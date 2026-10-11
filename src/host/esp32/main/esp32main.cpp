/*
	File:		host/esp32/main/esp32main.cpp

	Contains:	The ESP32-S3 host's entry (src/host/esp32/README.md): the
				board's side of the start - the USB serial/JTAG console made
				a blocking stdio stream, the baked ROM objects' partition
				mapped (frames/ROMImport.h), a task with room to run
				NewtonScript in - before NewtonMainOnDevice (newtonmain.cpp)
				does the Newton's side.  ESP-IDF's headers only here, the
				Newton's only there: the two do not mix.
*/

#include <stdio.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_partition.h"
#include "esp_timer.h"
#include "esp_heap_caps.h"
#include "esp_psram.h"
#include "driver/usb_serial_jtag.h"
#include "esp_vfs_dev.h"

#include "esp32host.h"

static const void*	gImage = NULL;
static size_t		gImageSize = 0;


long long
HostDeviceMicroseconds(void)
{
	return (long long) esp_timer_get_time();
}


void
HostDeviceMemory(unsigned long* internalFree, unsigned long* psramFree)
{
	*internalFree = (unsigned long) heap_caps_get_free_size(MALLOC_CAP_INTERNAL);
	*psramFree = (unsigned long) heap_caps_get_free_size(MALLOC_CAP_SPIRAM);
}


extern "C" const void* gHostDeviceStackTop;		// (hal/host/System.cpp GetStackBounds)

static void
NewtonTask(void*)
{
	char top;
	gHostDeviceStackTop = &top + 64;				// (the task's frame and a little over)
	NewtonMainOnDevice(gImage, gImageSize);
	printf("newton: the REP has ended\n");
	for (;;)
		vTaskDelay(pdMS_TO_TICKS(1000));
}


extern "C" void
app_main(void)
{
	// the console: blocking reads on stdin, through the USB serial/JTAG driver
	usb_serial_jtag_driver_config_t usb = USB_SERIAL_JTAG_DRIVER_CONFIG_DEFAULT();
	usb_serial_jtag_driver_install(&usb);
	esp_vfs_usb_serial_jtag_use_driver();
	setvbuf(stdin, NULL, _IONBF, 0);
	setvbuf(stdout, NULL, _IONBF, 0);
	vTaskDelay(pdMS_TO_TICKS(1500));		// (time for a terminal to open the port)

	printf("newton: ESP32-S3, PSRAM %u KB\n", (unsigned) (esp_psram_get_size() >> 10));
	const esp_partition_t* part = esp_partition_find_first(ESP_PARTITION_TYPE_DATA, (esp_partition_subtype_t) 0x41, "objects");
	esp_partition_mmap_handle_t handle;
	if (part == NULL || esp_partition_mmap(part, 0, part->size, ESP_PARTITION_MMAP_DATA, &gImage, &handle) != ESP_OK)
		printf("newton: the objects partition could not be mapped\n");
	else
	{
		gImageSize = part->size;
		printf("newton: the objects partition mapped at %p (%u KB)\n", gImage, (unsigned) (gImageSize >> 10));
	}
	// NewtonScript recurses on the C stack: a task with room for it
	xTaskCreatePinnedToCore(NewtonTask, "newton", 96 * 1024, NULL, 5, NULL, 1);
}
