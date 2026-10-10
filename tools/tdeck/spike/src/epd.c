// The T-Deck Pro's panel (epd.h).  Pins from LilyGO's schematic: SPI SCK 36,
// MOSI 33 (shared with the LoRa radio, CS 3, and the SD card, CS 48), the
// panel's CS 34, D/C 35, BUSY 37 (low while busy); its reset line is not
// connected, so the controller is reset by PSR's RST_N bit.
#include "epd.h"
#include <string.h>
#include "driver/spi_master.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define PIN_SCK		36
#define PIN_MOSI	33
#define PIN_CS		34
#define PIN_DC		35
#define PIN_BUSY	37
#define PIN_LORA_CS	3
#define PIN_SD_CS	48

// UC8253 commands (its datasheet's command table)
#define PSR		0x00	// panel setting: RES[1:0] REG KW/R UD SHL SHD_N RST_N, then VCMZ TS_AUTO TIEG NORG VCM_LUTZ
#define POF		0x02	// power off
#define PON		0x04	// power on
#define DTM1	0x10	// the old frame (KW mode)
#define DRF		0x12	// display refresh
#define DTM2	0x13	// the new frame
#define TRES	0x61	// resolution: HRES[7:3], VRES[8], VRES[7:0]
#define PTL		0x90	// partial window: HRST, HRED, VRST (2), VRED (2), PT_SCAN
#define PTIN	0x91
#define PTOUT	0x92
#define CCSET	0xE0	// cascade setting: TSFIX (bit 1), CCEN (bit 0)
#define TSSET	0xE5	// the temperature forced when TSFIX is set
#define DSLP	0x07	// deep sleep (check code 0xA5) - never sent: see epd_sleep

static const char* TAG = "epd";
static spi_device_handle_t gSpi;

static void
send(uint8_t command, const uint8_t* data, size_t length)
{
	spi_transaction_t t;
	memset(&t, 0, sizeof(t));
	gpio_set_level(PIN_DC, 0);
	t.length = 8;
	t.tx_buffer = &command;
	spi_device_polling_transmit(gSpi, &t);
	gpio_set_level(PIN_DC, 1);
	while (length > 0)
	{
		size_t n = length > 4000 ? 4000 : length;
		memset(&t, 0, sizeof(t));
		t.length = n * 8;
		t.tx_buffer = data;
		spi_device_polling_transmit(gSpi, &t);
		data += n;
		length -= n;
	}
}

static void
send1(uint8_t command, uint8_t value)
{
	send(command, &value, 1);
}

// until BUSY goes high; ==> microseconds waited (-1: it never did)
static int64_t
wait_busy(int timeout_ms)
{
	int64_t start = esp_timer_get_time();
	while (gpio_get_level(PIN_BUSY) == 0)
	{
		if (esp_timer_get_time() - start > (int64_t) timeout_ms * 1000)
			return -1;
		vTaskDelay(1);
	}
	return esp_timer_get_time() - start;
}

bool
epd_init(void)
{
	// the other devices on the bus deselected
	gpio_set_direction(PIN_LORA_CS, GPIO_MODE_OUTPUT);
	gpio_set_level(PIN_LORA_CS, 1);
	gpio_set_direction(PIN_SD_CS, GPIO_MODE_OUTPUT);
	gpio_set_level(PIN_SD_CS, 1);
	gpio_set_direction(PIN_DC, GPIO_MODE_OUTPUT);
	gpio_set_direction(PIN_BUSY, GPIO_MODE_INPUT);
	gpio_set_pull_mode(PIN_BUSY, GPIO_PULLUP_ONLY);

	spi_bus_config_t bus = {
		.mosi_io_num = PIN_MOSI, .miso_io_num = -1, .sclk_io_num = PIN_SCK,
		.quadwp_io_num = -1, .quadhd_io_num = -1, .max_transfer_sz = 4096,
	};
	ESP_ERROR_CHECK(spi_bus_initialize(SPI2_HOST, &bus, SPI_DMA_CH_AUTO));
	spi_device_interface_config_t dev = {
		.clock_speed_hz = 10 * 1000 * 1000, .mode = 0, .spics_io_num = PIN_CS, .queue_size = 1,
	};
	ESP_ERROR_CHECK(spi_bus_add_device(SPI2_HOST, &dev, &gSpi));

	// soft reset (RST_N clear), then the panel: KW mode (black and white),
	// LUTs from OTP, scan up, shift right, booster on; 240 x 320
	uint8_t reset[2] = { 0x1E, 0x8D };
	send(PSR, reset, 2);
	vTaskDelay(pdMS_TO_TICKS(10));
	if (wait_busy(2000) < 0)
	{
		ESP_LOGE(TAG, "busy after the soft reset");
		return false;
	}
	uint8_t psr[2] = { 0x1F, 0x8D };
	send(PSR, psr, 2);
	uint8_t tres[3] = { EPD_WIDTH & 0xF8, EPD_HEIGHT >> 8, EPD_HEIGHT & 0xFF };
	send(TRES, tres, 3);
	send(PON, NULL, 0);
	int64_t on = wait_busy(2000);
	ESP_LOGI(TAG, "power on: %lld us", (long long) on);
	return on >= 0;
}

static int64_t
refresh(void)
{
	send(DRF, NULL, 0);
	vTaskDelay(1);
	return wait_busy(15000);
}

int64_t
epd_full(const uint8_t* old_frame, const uint8_t* new_frame)
{
	send1(CCSET, 0x00);
	send(DTM1, old_frame, EPD_BYTES);
	send(DTM2, new_frame, EPD_BYTES);
	return refresh();
}

int64_t
epd_fast(const uint8_t* old_frame, const uint8_t* new_frame, uint8_t ts_set)
{
	send1(CCSET, 0x02);
	send1(TSSET, ts_set);
	send(DTM1, old_frame, EPD_BYTES);
	send(DTM2, new_frame, EPD_BYTES);
	int64_t t = refresh();
	send1(CCSET, 0x00);
	return t;
}

int64_t
epd_partial(int x, int y, int w, int h, const uint8_t* old_frame, const uint8_t* new_frame, uint8_t ts_set)
{
	static uint8_t window[EPD_BYTES];
	if (ts_set != 0)
	{
		send1(CCSET, 0x02);
		send1(TSSET, ts_set);
	}
	send(PTIN, NULL, 0);
	int x2 = x + w - 1, y2 = y + h - 1;
	uint8_t ptl[7] = { (uint8_t) (x & 0xF8), (uint8_t) ((x2 & 0xF8) | 0x07),
					   (uint8_t) (y >> 8), (uint8_t) y, (uint8_t) (y2 >> 8), (uint8_t) y2, 0x01 };
	send(PTL, ptl, 7);
	int rowBytes = w / 8;
	for (int pass = 0; pass < 2; pass++)
	{
		const uint8_t* frame = pass == 0 ? old_frame : new_frame;
		for (int r = 0; r < h; r++)
			memcpy(window + r * rowBytes, frame + (y + r) * EPD_ROW_BYTES + x / 8, rowBytes);
		send(pass == 0 ? DTM1 : DTM2, window, (size_t) (rowBytes * h));
	}
	int64_t t = refresh();
	send(PTOUT, NULL, 0);
	if (ts_set != 0)
		send1(CCSET, 0x00);
	return t;
}

// Power off only, never deep sleep (DSLP): the controller leaves deep sleep
// only by a hardware reset, and the T-Deck Pro does not wire up the panel's
// RES# - after DSLP it stayed busy until the board lost power (found on the
// owner's V1.0, 2026-10-10)
void
epd_sleep(void)
{
	send(POF, NULL, 0);
	wait_busy(2000);
}
