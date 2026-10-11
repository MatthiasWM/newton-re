/*
	File:		host/esp32/main/tdeck_profile.cpp

	Contains:	A sampling profiler of the Newton's core (src/host/esp32/
				README.md): every Newton task runs on core 1, and the
				ESP32-S3's assist-debug block records a core's program
				counter as it runs (ASSIST_DEBUG_CORE_1_RCD_PDEBUGPC), which
				the other core can read.  So a task on core 0 reads it each
				millisecond (the FreeRTOS tick) into a buffer in PSRAM, from
				the start of the boot; HostDeviceProfileMark notes where each
				phase began; HostDeviceProfileDump prints the lot on the
				console as lines "prof-mark <sample> <label>" and "prof
				<pc> <pc> ...", which tools/tdeck/profile.py turns into the
				functions the time went to (addr2line on the firmware's ELF).
				A sample in FreeRTOS's idle task is core 1 waiting.
				ESP-IDF's headers only (esp32host.h says why).
*/

#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_heap_caps.h"
#include "soc/soc.h"
#include "soc/system_reg.h"
#include "soc/assist_debug_reg.h"

#include "esp32host.h"

const size_t	kMaxSamples = 150000;			// (150 s at a sample a millisecond: 600 KB of PSRAM)
const int		kMaxMarks = 48;

static uint32_t*		gSamples = NULL;
static volatile size_t	gCount = 0;
static volatile bool	gRunning = false;
struct ProfileMark { size_t at; char label[48]; };
static ProfileMark*		gMarks = NULL;			// (in PSRAM: the internal RAM's static data is full)
static int				gMarkCount = 0;


static void
SamplerTask(void*)
{
	while (gRunning && gCount < kMaxSamples)
	{
		gSamples[gCount++] = REG_READ(ASSIST_DEBUG_CORE_1_RCD_PDEBUGPC_REG);
		vTaskDelay(1);
	}
	gRunning = false;
	vTaskSuspend(NULL);
}


void
HostDeviceProfileStart(void)
{
	gSamples = (uint32_t*) heap_caps_malloc(kMaxSamples * sizeof(uint32_t), MALLOC_CAP_SPIRAM);
	gMarks = (ProfileMark*) heap_caps_malloc(kMaxMarks * sizeof(ProfileMark), MALLOC_CAP_SPIRAM);
	if (gSamples == NULL || gMarks == NULL)
	{
		heap_caps_free(gSamples);
		gSamples = NULL;
		return;
	}
	// the assist-debug block clocked and out of reset, core 1's pc recorded
	REG_SET_BIT(SYSTEM_CPU_PERI_CLK_EN_REG, SYSTEM_CLK_EN_ASSIST_DEBUG);
	REG_CLR_BIT(SYSTEM_CPU_PERI_RST_EN_REG, SYSTEM_RST_EN_ASSIST_DEBUG);
	REG_WRITE(ASSIST_DEBUG_CORE_1_RCD_PDEBUGENABLE_REG, 1);
	REG_WRITE(ASSIST_DEBUG_CORE_1_RCD_RECORDING_REG, 1);
	gRunning = true;
	if (xTaskCreatePinnedToCore(SamplerTask, "profile", 2048, NULL, configMAX_PRIORITIES - 2, NULL, 0) != pdPASS)
		gRunning = false;
}


void
HostDeviceProfileMark(const char* label)
{
	if (gSamples == NULL || gMarkCount >= kMaxMarks)
		return;
	gMarks[gMarkCount].at = gCount;
	strncpy(gMarks[gMarkCount].label, label, sizeof(gMarks[0].label) - 1);
	gMarks[gMarkCount].label[sizeof(gMarks[0].label) - 1] = 0;
	gMarkCount++;
}


void
HostDeviceProfileDump(void)
{
	if (gSamples == NULL)
	{
		printf("prof-none\n");
		return;
	}
	gRunning = false;
	vTaskDelay(pdMS_TO_TICKS(5));
	size_t count = gCount;
	printf("prof-begin %u\n", (unsigned) count);
	for (int m = 0; m < gMarkCount; m++)
		printf("prof-mark %u %s\n", (unsigned) gMarks[m].at, gMarks[m].label);
	for (size_t i = 0; i < count; i += 16)
	{
		printf("prof");
		for (size_t j = i; j < i + 16 && j < count; j++)
			printf(" %08lx", (unsigned long) gSamples[j]);
		printf("\n");
		if ((i / 16) % 32 == 31)
			vTaskDelay(1);					// (the console's buffer given time to drain)
	}
	printf("prof-end\n");
	heap_caps_free(gSamples);
	gSamples = NULL;
}
