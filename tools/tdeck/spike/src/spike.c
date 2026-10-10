// The T-Deck Pro device spike (tools/tdeck/README.md; docs/host-tdeck-pro.md,
// "Order of work"): what the Newton port needs to know about the board,
// printed over the USB serial port as lines starting "spike:".
//
//   1. the chip, the flash and the PSRAM; an I2C scan, which says the board's
//      revision (V1.1 adds a DRV2605 at 0x5A, MAX an XL9555 at 0x20 too)
//   2. memory: dependent reads (each address made from the word read before,
//      the NewtonScript interpreter's pattern) and a sequential sum, over
//      internal SRAM, PSRAM and flash mapped through the cache, at sizes
//      inside and outside the cache
//   3. the panel: a Newton screen (newton_screen.c) drawn with the panel's
//      full waveform, with forced temperatures (shorter waveforms), and a
//      window refreshed on its own - each timed
//   4. input, for a minute: the touch panel's raw reports and the keyboard's
//      keys, as they come
//
// Pins and I2C addresses from LilyGO's schematic and utilities.h; the touch
// controller's report from LilyGO's hyn_cst3xx.c (register 0xD000, seven
// bytes, 0xAB at the end); the keyboard's layout from the owner's lilyphone1
// project (src/peripherals/peri_keypad.cpp).
#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_chip_info.h"
#include "esp_flash.h"
#include "esp_psram.h"
#include "esp_heap_caps.h"
#include "esp_partition.h"
#include "esp_timer.h"
#include "esp_system.h"
#include "driver/i2c.h"
#include "driver/gpio.h"
#include "epd.h"

extern const uint8_t newton_screen[EPD_BYTES];

#define I2C_PORT		I2C_NUM_0
#define PIN_SDA			13
#define PIN_SCL			14
#define PIN_TOUCH_INT	12
#define PIN_TOUCH_RST	45
#define PIN_KEY_INT		15
#define PIN_KEY_LED		42
#define ADDR_TOUCH		0x1A
#define ADDR_KEYBOARD	0x34

/*------------------------------------------------------------------------------
	1. The board
------------------------------------------------------------------------------*/

static void
board(void)
{
	esp_chip_info_t chip;
	esp_chip_info(&chip);
	uint32_t flash = 0;
	esp_flash_get_size(NULL, &flash);
	printf("spike: chip ESP32-S3 rev %d.%d, %d cores, flash %" PRIu32 " MB, PSRAM %u MB\n",
		   chip.revision / 100, chip.revision % 100, chip.cores, flash >> 20, (unsigned) (esp_psram_get_size() >> 20));
	printf("spike: free internal %u KB (largest %u KB), free PSRAM %u KB\n",
		   (unsigned) (heap_caps_get_free_size(MALLOC_CAP_INTERNAL) >> 10),
		   (unsigned) (heap_caps_get_largest_free_block(MALLOC_CAP_INTERNAL) >> 10),
		   (unsigned) (heap_caps_get_free_size(MALLOC_CAP_SPIRAM) >> 10));
}

static void
i2c_start(void)
{
	i2c_config_t c = {
		.mode = I2C_MODE_MASTER, .sda_io_num = PIN_SDA, .scl_io_num = PIN_SCL,
		.sda_pullup_en = GPIO_PULLUP_ENABLE, .scl_pullup_en = GPIO_PULLUP_ENABLE,
		.master.clk_speed = 400000,
	};
	i2c_param_config(I2C_PORT, &c);
	i2c_driver_install(I2C_PORT, I2C_MODE_MASTER, 0, 0, 0);
}

static bool
i2c_present(uint8_t address)
{
	i2c_cmd_handle_t cmd = i2c_cmd_link_create();
	i2c_master_start(cmd);
	i2c_master_write_byte(cmd, (uint8_t) (address << 1), true);
	i2c_master_stop(cmd);
	esp_err_t err = i2c_master_cmd_begin(I2C_PORT, cmd, pdMS_TO_TICKS(20));
	i2c_cmd_link_delete(cmd);
	return err == ESP_OK;
}

static void
scan(void)
{
	printf("spike: i2c:");
	bool drv2605 = false, xl9555 = false;
	for (int a = 0x08; a < 0x78; a++)
		if (i2c_present((uint8_t) a))
		{
			printf(" 0x%02x", a);
			if (a == 0x5A) drv2605 = true;
			if (a == 0x20) xl9555 = true;
		}
	printf("\n");
	printf("spike: board %s\n", xl9555 ? "MAX (XL9555 at 0x20)" : drv2605 ? "V1.1 (DRV2605 at 0x5A)" : "V1.0 (neither 0x5A nor 0x20)");
}

/*------------------------------------------------------------------------------
	2. Memory
------------------------------------------------------------------------------*/

// dependent reads: each index made from the word just read, so that no two
// can overlap - the latency of a load that misses (or hits) the cache
static uint32_t gSink;

static void
bench(const char* what, const volatile uint32_t* mem, size_t bytes)
{
	size_t words = bytes / 4;
	size_t mask = words - 1;					// (bytes a power of two)
	const int kReads = 200000;
	uint32_t i = 12345, acc = 0;
	int64_t t0 = esp_timer_get_time();
	for (int n = 0; n < kReads; n++)
	{
		uint32_t v = mem[i & mask];
		acc += v;
		// the next address depends on the word: xorshift, whose low bits are
		// as random as its high ones (a linear congruential step's low bits
		// repeat every few steps, and the reads stayed in a handful of words)
		i ^= v | 1;
		i ^= i << 13;
		i ^= i >> 17;
		i ^= i << 5;
	}
	int64_t t1 = esp_timer_get_time();
	uint32_t sum = 0;
	for (size_t k = 0; k < words; k++)
		sum += mem[k];
	int64_t t2 = esp_timer_get_time();
	gSink += acc + sum;
	printf("spike: mem %-9s %5u KB: dependent read %4u ns; sequential %5.1f MB/s\n", what, (unsigned) (bytes >> 10),
		   (unsigned) ((t1 - t0) * 1000 / kReads), (double) bytes / (double) (t2 - t1));
	vTaskDelay(1);
}

static void
memory(void)
{
	static const size_t kSizes[] = { 16 << 10, 256 << 10, 4 << 20 };
	// internal SRAM (the largest block there is, a power of two)
	size_t internal = 128 << 10;
	uint32_t* sram = heap_caps_malloc(internal, MALLOC_CAP_INTERNAL | MALLOC_CAP_8BIT);
	if (sram != NULL)
	{
		for (size_t k = 0; k < internal / 4; k++)
			sram[k] = (uint32_t) (k * 2654435761u);
		bench("sram", sram, 16 << 10);
		bench("sram", sram, internal);
		heap_caps_free(sram);
	}
	// PSRAM
	uint32_t* psram = heap_caps_malloc(4 << 20, MALLOC_CAP_SPIRAM);
	if (psram != NULL)
	{
		for (size_t k = 0; k < (4 << 20) / 4; k++)
			psram[k] = (uint32_t) (k * 2654435761u);
		for (int s = 0; s < 3; s++)
			bench("psram", psram, kSizes[s]);
		heap_caps_free(psram);
	}
	else
		printf("spike: mem psram: no 4 MB block\n");
	// flash, mapped through the cache (the 'bench' partition, whatever it
	// holds: the reads depend on it, the timing does not)
	const esp_partition_t* part = esp_partition_find_first(ESP_PARTITION_TYPE_DATA, 0x40, "bench");
	const void* mapped = NULL;
	esp_partition_mmap_handle_t handle;
	if (part != NULL && esp_partition_mmap(part, 0, 4 << 20, ESP_PARTITION_MMAP_DATA, &mapped, &handle) == ESP_OK)
	{
		for (int s = 0; s < 3; s++)
			bench("flash", (const volatile uint32_t*) mapped, kSizes[s]);
		esp_partition_munmap(handle);
	}
	else
		printf("spike: mem flash: the bench partition could not be mapped\n");
}

/*------------------------------------------------------------------------------
	3. The panel
------------------------------------------------------------------------------*/

// The panel's refresh times (measured on the owner's V1.0, 2026-10-10:
// docs/host-tdeck-pro.md) - set to run them again
static const bool kPanelTimings = false;

// Five black squares, 16 x 16, to be tapped in turn: the four corners
// clockwise from the top left, then the centre
static void
targets(void)
{
	static uint8_t frame[EPD_BYTES], white[EPD_BYTES];
	memset(frame, 0xFF, sizeof(frame));
	memset(white, 0xFF, sizeof(white));
	static const int kAt[5][2] = { { 8, 8 }, { 216, 8 }, { 216, 296 }, { 8, 296 }, { 112, 152 } };
	for (int t = 0; t < 5; t++)
		for (int y = kAt[t][1]; y < kAt[t][1] + 16; y++)
			for (int x = kAt[t][0] / 8; x < (kAt[t][0] + 16) / 8; x++)
				frame[y * EPD_ROW_BYTES + x] = 0x00;
	if (!epd_init())
		return;
	printf("spike: targets at (8,8) (216,8) (216,296) (8,296) (112,152), 16 x 16: %lld us\n",
		   (long long) epd_fast(white, frame, 0x7F));
	epd_sleep();
}

static void
panel(void)
{
	static uint8_t white[EPD_BYTES], inverse[EPD_BYTES], boxed[EPD_BYTES];
	memset(white, 0xFF, sizeof(white));
	for (int k = 0; k < EPD_BYTES; k++)
		inverse[k] = (uint8_t) ~newton_screen[k];
	memcpy(boxed, newton_screen, EPD_BYTES);
	// a black box over the middle, 64 x 64 at (88, 128), for the partial test
	for (int y = 128; y < 192; y++)
		for (int x = 88 / 8; x < (88 + 64) / 8; x++)
			boxed[y * EPD_ROW_BYTES + x] = 0x00;

	if (!epd_init())
	{
		printf("spike: panel: the controller stayed busy - nothing drawn\n");
		return;
	}
	printf("spike: panel full white:    %lld us\n", (long long) epd_full(white, white));
	printf("spike: panel full newton:   %lld us\n", (long long) epd_full(white, newton_screen));
	vTaskDelay(pdMS_TO_TICKS(1500));
	static const uint8_t kTemps[] = { 0x5A, 0x6E, 0x7F };
	for (int t = 0; t < 3; t++)
	{
		printf("spike: panel fast ts 0x%02x inverse: %lld us\n", kTemps[t], (long long) epd_fast(newton_screen, inverse, kTemps[t]));
		vTaskDelay(pdMS_TO_TICKS(800));
		printf("spike: panel fast ts 0x%02x newton:  %lld us\n", kTemps[t], (long long) epd_fast(inverse, newton_screen, kTemps[t]));
		vTaskDelay(pdMS_TO_TICKS(800));
	}
	printf("spike: panel partial box:        %lld us\n", (long long) epd_partial(88, 128, 64, 64, newton_screen, boxed, 0));
	vTaskDelay(pdMS_TO_TICKS(800));
	printf("spike: panel partial box fast:   %lld us\n", (long long) epd_partial(88, 128, 64, 64, boxed, newton_screen, 0x5A));
	vTaskDelay(pdMS_TO_TICKS(800));
	printf("spike: panel partial box again:  %lld us\n", (long long) epd_partial(88, 128, 64, 64, newton_screen, boxed, 0x5A));
	vTaskDelay(pdMS_TO_TICKS(800));
	printf("spike: panel full newton again: %lld us\n", (long long) epd_full(boxed, newton_screen));
	epd_sleep();
}

/*------------------------------------------------------------------------------
	4. Input
------------------------------------------------------------------------------*/

static esp_err_t
i2c_write(uint8_t address, const uint8_t* data, size_t length)
{
	return i2c_master_write_to_device(I2C_PORT, address, data, length, pdMS_TO_TICKS(20));
}

static esp_err_t
i2c_read_reg(uint8_t address, const uint8_t* reg, size_t regLength, uint8_t* data, size_t length)
{
	return i2c_master_write_read_device(I2C_PORT, address, reg, regLength, data, length, pdMS_TO_TICKS(20));
}

// the CST328: reset, normal mode (0xD109)
static void
touch_start(void)
{
	gpio_set_direction(PIN_TOUCH_RST, GPIO_MODE_OUTPUT);
	gpio_set_level(PIN_TOUCH_RST, 0);
	vTaskDelay(pdMS_TO_TICKS(10));
	gpio_set_level(PIN_TOUCH_RST, 1);
	vTaskDelay(pdMS_TO_TICKS(100));
	gpio_set_direction(PIN_TOUCH_INT, GPIO_MODE_INPUT);
	gpio_set_pull_mode(PIN_TOUCH_INT, GPIO_PULLUP_ONLY);
	static const uint8_t normal[2] = { 0xD1, 0x09 };
	i2c_write(ADDR_TOUCH, normal, 2);
}

// a report: valid when byte 6 is 0xAB; fingers in byte 5's low bits; the
// first at bytes 0-4 (id and state, x and y's high bits, their low nibbles)
static void
touch_poll(int64_t start)
{
	static int lastX = -1, lastY = -1, lastDown = 0;
	static const uint8_t reg[2] = { 0xD0, 0x00 };
	uint8_t b[7];
	if (i2c_read_reg(ADDR_TOUCH, reg, 2, b, 7) != ESP_OK)
		return;
	static const uint8_t sync[3] = { 0xD0, 0x00, 0xAB };
	i2c_write(ADDR_TOUCH, sync, 3);
	if (b[6] != 0xAB || b[0] == 0xAB)
		return;
	int fingers = b[5] & 0x7F;
	int down = fingers > 0 && (b[0] & 0x0F) == 0x06;
	int x = (b[1] << 4) | (b[3] >> 4);
	int y = (b[2] << 4) | (b[3] & 0x0F);
	if (down != lastDown || (down && (x != lastX || y != lastY)))
		printf("spike: touch %6lld ms %s x %d y %d (fingers %d; raw %02x %02x %02x %02x %02x %02x %02x)\n",
			   (long long) ((esp_timer_get_time() - start) / 1000), down ? "down" : "up  ", x, y, fingers,
			   b[0], b[1], b[2], b[3], b[4], b[5], b[6]);
	lastX = x; lastY = y; lastDown = down;
}

// the TCA8418: a 4-row, 10-column matrix (KP_GPIO1 rows, KP_GPIO2/3 columns),
// key events on (CFG KE_IEN); events from the FIFO (KEY_EVENT_A), their
// count in KEY_LCK_EC's low nibble.  An event is 0x80 for a press, then
// row * 10 + column + 1, the columns counted from the right.
static const char kKeymap[4][10] = {
	{'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'},
	{'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', '\b'},
	{ 0,  'z', 'x', 'c', 'v', 'b', 'n', 'm', '$', '\r'},
	{ 0,   0,   0,   0,   0,   0,   0,  ' ',  0,   0 },
};

static void
keyboard_start(void)
{
	static const uint8_t setup[][2] = {
		{ 0x1D, 0x0F },		// KP_GPIO1: rows 0-3
		{ 0x1E, 0xFF },		// KP_GPIO2: columns 0-7
		{ 0x1F, 0x03 },		// KP_GPIO3: columns 8-9
		{ 0x01, 0x01 },		// CFG: key events interrupt
	};
	for (int k = 0; k < 4; k++)
		i2c_write(ADDR_KEYBOARD, setup[k], 2);
	// whatever is in the FIFO, thrown away
	uint8_t reg = 0x03, count = 0, event;
	for (int k = 0; k < 16 && i2c_read_reg(ADDR_KEYBOARD, &reg, 1, &count, 1) == ESP_OK && (count & 0x0F) != 0; k++)
	{
		uint8_t fifo = 0x04;
		i2c_read_reg(ADDR_KEYBOARD, &fifo, 1, &event, 1);
	}
	gpio_set_direction(PIN_KEY_LED, GPIO_MODE_OUTPUT);
	gpio_set_level(PIN_KEY_LED, 1);
}

static void
keyboard_poll(int64_t start)
{
	uint8_t reg = 0x03, count = 0;
	if (i2c_read_reg(ADDR_KEYBOARD, &reg, 1, &count, 1) != ESP_OK)
		return;
	for (int n = count & 0x0F; n > 0; n--)
	{
		uint8_t fifo = 0x04, event = 0;
		if (i2c_read_reg(ADDR_KEYBOARD, &fifo, 1, &event, 1) != ESP_OK || event == 0)
			break;
		int key = (event & 0x7F) - 1;
		int row = key / 10, col = 9 - key % 10;
		char c = (row >= 0 && row < 4) ? kKeymap[row][col] : 0;
		printf("spike: key %6lld ms %s key %2d (row %d col %d) %s%c%s\n",
			   (long long) ((esp_timer_get_time() - start) / 1000), (event & 0x80) ? "down" : "up  ", key, row, col,
			   c > ' ' ? "'" : "", c > ' ' ? c : ' ', c > ' ' ? "'" : (c == ' ' ? "space" : c == '\b' ? "backspace" : c == '\r' ? "enter" : "(modifier)"));
	}
	static const uint8_t clear[2] = { 0x02, 0x01 };	// INT_STAT: key events seen
	i2c_write(ADDR_KEYBOARD, clear, 2);
}

static void
input(int seconds)
{
	touch_start();
	keyboard_start();
	printf("spike: input for %d s - tap and drag on the screen, type on the keyboard\n", seconds);
	int64_t start = esp_timer_get_time();
	while (esp_timer_get_time() - start < (int64_t) seconds * 1000000)
	{
		touch_poll(start);
		keyboard_poll(start);
		vTaskDelay(pdMS_TO_TICKS(10));
	}
	gpio_set_level(PIN_KEY_LED, 0);
	printf("spike: input done\n");
}

void
app_main(void)
{
	vTaskDelay(pdMS_TO_TICKS(2000));		// (time for the serial port to be opened)
	printf("spike: start\n");
	board();
	i2c_start();
	scan();
	memory();
	if (kPanelTimings)
		panel();
	targets();
	input(90);
	printf("spike: done\n");
	for (;;)
		vTaskDelay(pdMS_TO_TICKS(1000));
}
