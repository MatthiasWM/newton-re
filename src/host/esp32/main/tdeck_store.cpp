/*
	File:		host/esp32/main/tdeck_store.cpp

	Contains:	The Newton's internal flash on the board's own (src/host/esp32/
				README.md): the `store` partition (4 MB, partitions.csv) is
				the flash's image, which hal/host/HostFlash.h reads in place
				through a read-only memory mapping (no copy in RAM: there is
				no room for one) and whose writes and erases come here
				(newtonmain.cpp gives them to HostFlashSetBacking).  So the
				internal store - the ROM's TFlashStore on the flash, as on the
				desktop - is kept from one start to the next.

				The flash is written by a task of the board's own whose stack
				is in internal RAM: a task whose stack is in PSRAM, as the
				Newton's are, must not write the flash (the cache, PSRAM's
				way in, is off while it does).  The Newton's task hands each
				write or erase over and waits for it, and the mapping's cache
				lines over what it changed are forgotten.  A write is a whole
				run of words (hal/host/HostFlash.h HostFlashBeginRun: what the
				store's driver writes between its BeginWrite and its
				ReportWriteResult), copied into internal RAM a sector at a
				time and programmed in one go - one hand-over a run, not one
				a word.  A word is written as
				the chips' rules have already made it (only bits cleared:
				the SPI flash programs the same way); an erase of whole 4 KB
				sectors and all lanes is an erase, and one of some of the
				lanes (the Newton's flash is two 16-bit chips side by side)
				reads the sectors, sets those bytes, erases and writes them
				back.  DEVIATION: power lost during that rewrite loses the
				sector's other lanes, where the MessagePad's chips would have
				kept them.

				The first time (NVS's storeVersion says when that has been)
				the partition is erased whole: it may hold whatever the
				board was used for before.
				ESP-IDF's headers only (esp32host.h says why).
*/

#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "esp_partition.h"
#include "esp_heap_caps.h"
#include "esp_timer.h"
#include "nvs_flash.h"
#include "nvs.h"
#include "hal/cache_hal.h"

#include "esp32host.h"

const size_t	kSectorSize = 4096;

static const esp_partition_t*	gPart = NULL;
static const unsigned char*		gMapped = NULL;

// one request at a time, from the Newton's task to the writer
struct StoreRequest
{
	bool			erase;
	unsigned long	offset;
	unsigned long	size;
	unsigned long	lanes;
	const unsigned char* bytes;			// (anywhere: copied to gSector)
};
static StoreRequest			gRequest;
static SemaphoreHandle_t	gGo = NULL;			// a request is there
static SemaphoreHandle_t	gDone = NULL;		// it has been done
static SemaphoreHandle_t	gOne = NULL;		// one caller at a time
static uint8_t*				gSector = NULL;		// (internal RAM: written to the flash)
static unsigned long		gWrites = 0, gErases = 0;
static int					gFailures = 0;			// (the first few told)


// The mapping's cache lines over what was just written forgotten, so that
// reading through it sees the flash: ESP-IDF's own refresh after a write
// did not reach this mapping (a word written read back as erased until the
// next start - the self-test below, 2026-10-11)
static void
Refresh(unsigned long offset, unsigned long size)
{
	const uint32_t kLine = 64;
	uint32_t from = (uint32_t) (uintptr_t) (gMapped + offset) & ~(kLine - 1);
	uint32_t to = ((uint32_t) (uintptr_t) (gMapped + offset + size) + kLine - 1) & ~(kLine - 1);
	cache_hal_invalidate_addr(from, to - from);
}


static void
DoErase(unsigned long offset, unsigned long size, unsigned long lanes)
{
	unsigned long end = offset + size;
	for (unsigned long sector = offset - offset % kSectorSize; sector < end; sector += kSectorSize)
	{
		unsigned long from = offset > sector ? offset : sector;
		unsigned long to = end < sector + kSectorSize ? end : sector + kSectorSize;
		bool whole = from == sector && to == sector + kSectorSize && lanes == 0xFFFFFFFFUL;
		if (whole)
		{
			esp_partition_erase_range(gPart, sector, kSectorSize);
			continue;
		}
		// some of the sector's bytes, or some lanes: its bytes read, those
		// set, the sector erased and written back
		memcpy(gSector, gMapped + sector, kSectorSize);
		bool changes = false;
		for (unsigned long i = from; i < to; i++)
			if (((lanes >> (8 * (3 - i % 4))) & 0xFF) != 0 && gSector[i - sector] != 0xFF)
			{
				gSector[i - sector] = 0xFF;
				changes = true;
			}
		if (!changes)
			continue;
		esp_partition_erase_range(gPart, sector, kSectorSize);
		esp_partition_write(gPart, sector, gSector, kSectorSize);
	}
}


static void
WriterTask(void*)
{
	for (;;)
	{
		xSemaphoreTake(gGo, portMAX_DELAY);
		if (gRequest.erase)
		{
			DoErase(gRequest.offset, gRequest.size, gRequest.lanes);
			Refresh(gRequest.offset - gRequest.offset % kSectorSize,
					(gRequest.offset % kSectorSize + gRequest.size + kSectorSize - 1) / kSectorSize * kSectorSize);
			gErases++;
		}
		else
		{
			// (a sector's worth at a time, through internal RAM: the bytes
			//  may be in PSRAM, which is out of reach while the flash is
			//  written)
			for (unsigned long done = 0; done < gRequest.size; )
			{
				unsigned long n = gRequest.size - done > kSectorSize ? kSectorSize : gRequest.size - done;
				memcpy(gSector, gRequest.bytes + done, n);
				esp_err_t err = esp_partition_write(gPart, gRequest.offset + done, gSector, n);
				if (err != ESP_OK && gFailures++ < 8)
					printf("newton: the store partition would not be written at 0x%lx: %s\n", gRequest.offset + done, esp_err_to_name(err));
				done += n;
			}
			Refresh(gRequest.offset, gRequest.size);
			gWrites++;
		}
		xSemaphoreGive(gDone);
	}
}


static void
Hand(const StoreRequest& request)
{
	xSemaphoreTake(gOne, portMAX_DELAY);
	gRequest = request;
	xSemaphoreGive(gGo);
	xSemaphoreTake(gDone, portMAX_DELAY);
	xSemaphoreGive(gOne);
}


// What the Newton's flash relies on, tried on the partition's last sector
// through the mapping, at each start when that sector is erased (and left
// erased): a word written read back, a second write only clearing bits, an
// erase of some lanes, an erase of the sector.  Prints what failed.
static void
SelfTest(void)
{
	const unsigned long sector = gPart->size - kSectorSize;
	const volatile uint8_t* m = gMapped + sector;
	for (size_t i = 0; i < kSectorSize; i++)
		if (m[i] != 0xFF)
		{
			printf("newton: store self-test skipped (its sector is in use)\n");
			return;
		}
	int failed = 0;
	StoreRequest r;
	r.erase = false;
	r.offset = sector + 8;
	r.size = 4;
	const unsigned char w[4] = { 0x12, 0x34, 0x56, 0x78 };
	r.bytes = w;
	Hand(r);
	if (m[8] != 0x12 || m[9] != 0x34 || m[10] != 0x56 || m[11] != 0x78)
	{
		unsigned char direct[4] = { 0, 0, 0, 0 };
		esp_partition_read(gPart, sector + 8, direct, 4);
		printf("newton: store self-test: read from the flash itself: %02x %02x %02x %02x\n", direct[0], direct[1], direct[2], direct[3]);
		printf("newton: store self-test: a word written read back as %02x %02x %02x %02x\n", m[8], m[9], m[10], m[11]);
		failed++;
	}
	const unsigned char v[4] = { 0x10, 0x30, 0x50, 0x70 };	// (fewer bits: only clearing)
	r.bytes = v;
	Hand(r);
	if (m[8] != 0x10 || m[11] != 0x70)
	{
		printf("newton: store self-test: a second write read back as %02x .. %02x\n", m[8], m[11]);
		failed++;
	}
	StoreRequest e;
	e.erase = true;
	e.offset = sector;
	e.size = kSectorSize;
	e.lanes = 0xFFFF0000UL;			// the first chip's lanes
	Hand(e);
	if (m[8] != 0xFF || m[9] != 0xFF || m[10] != 0x50 || m[11] != 0x70)
	{
		printf("newton: store self-test: a lanes erase left %02x %02x %02x %02x\n", m[8], m[9], m[10], m[11]);
		failed++;
	}
	e.lanes = 0xFFFFFFFFUL;
	Hand(e);
	if (m[10] != 0xFF || m[11] != 0xFF)
	{
		printf("newton: store self-test: a sector erase left %02x %02x\n", m[10], m[11]);
		failed++;
	}
	printf("newton: store self-test %s\n", failed ? "FAILED" : "passed");
}


// (before the OS boots, while the internal RAM has room: the writer's stack,
//  its sector buffer)
bool
HostDeviceStoreStart(void)
{
	gPart = esp_partition_find_first(ESP_PARTITION_TYPE_DATA, (esp_partition_subtype_t) 0x42, "store");
	if (gPart == NULL || gPart->size < 4 * 1024 * 1024)
	{
		printf("newton: no 4 MB store partition - the store is kept in memory\n");
		return false;
	}
	// the first time: the partition erased whole
	nvs_handle_t nvs;
	// (kStoreVersion: what the partition was last made for - a newer one
	//  erases it once; 2: the first one whose writes the mapping saw)
	const uint8_t kStoreVersion = 2;
	uint8_t erased = 0;
	if (nvs_flash_init() != ESP_OK)
	{
		nvs_flash_erase();
		nvs_flash_init();
	}
	if (nvs_open("newton", NVS_READWRITE, &nvs) == ESP_OK)
	{
		nvs_get_u8(nvs, "storeVersion", &erased);
		if (erased < kStoreVersion)
		{
			printf("newton: the store partition erased (the first time: it may hold what the board was used for before)\n");
			int64_t t = esp_timer_get_time();
			esp_partition_erase_range(gPart, 0, gPart->size);
			printf("newton: erased in %lld ms\n", (long long) ((esp_timer_get_time() - t) / 1000));
			nvs_set_u8(nvs, "storeVersion", kStoreVersion);
			nvs_commit(nvs);
		}
		nvs_close(nvs);
	}
	const void* mapped;
	esp_partition_mmap_handle_t handle;
	if (esp_partition_mmap(gPart, 0, 4 * 1024 * 1024, ESP_PARTITION_MMAP_DATA, &mapped, &handle) != ESP_OK)
	{
		printf("newton: the store partition could not be mapped - the store is kept in memory\n");
		return false;
	}
	gMapped = (const unsigned char*) mapped;
	gGo = xSemaphoreCreateBinary();
	gDone = xSemaphoreCreateBinary();
	gOne = xSemaphoreCreateMutex();
	gSector = (uint8_t*) heap_caps_malloc(kSectorSize, MALLOC_CAP_INTERNAL | MALLOC_CAP_8BIT);
	static StaticTask_t control;
	static StackType_t stack[3 * 1024];
	if (gSector == NULL || gGo == NULL || gDone == NULL || gOne == NULL
	|| xTaskCreateStaticPinnedToCore(WriterTask, "store", sizeof(stack), NULL, 6, stack, &control, 0) == NULL)
	{
		printf("newton: no room for the store's writer - the store is kept in memory\n");
		gMapped = NULL;
		return false;
	}
	SelfTest();
	return true;
}


bool
HostDeviceStoreOpen(unsigned char** bytes, unsigned long* size, bool* existed)
{
	if (gMapped == NULL)
		return false;
	*bytes = (unsigned char*) gMapped;
	*size = 4 * 1024 * 1024;
	// used before when anything in it is not erased
	const uint32_t* words = (const uint32_t*) gMapped;
	*existed = false;
	for (unsigned long i = 0; i < *size / 4; i++)
		if (words[i] != 0xFFFFFFFFUL)
		{
			*existed = true;
			break;
		}
	return true;
}


void
HostDeviceStoreWrite(unsigned long offset, const unsigned char* bytes, unsigned long size)
{
	if (size == 0)
		return;
	StoreRequest request;
	request.erase = false;
	request.offset = offset;
	request.size = size;
	request.bytes = bytes;
	Hand(request);
}


void
HostDeviceStoreErase(unsigned long offset, unsigned long size, unsigned long lanes)
{
	StoreRequest request;
	request.erase = true;
	request.offset = offset;
	request.size = size;
	request.lanes = lanes;
	Hand(request);
}


void
HostDeviceStoreCounts(unsigned long* writes, unsigned long* erases)
{
	*writes = gWrites;
	*erases = gErases;
}
