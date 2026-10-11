// The T-Deck Pro's panel: a Good Display GDEQ031T10, 240x320 one bit,
// driven by an UltraChip UC8253 over SPI.  Written from the UC8253 datasheet
// (LilyGO's T-Deck-Pro repository, hardware/UC8253.pdf): the waveforms are
// the panel's own (OTP); "fast" forces the temperature the OTP waveform is
// chosen by (CCSET TSFIX, TSSET); "partial" refreshes a window only.
#pragma once
#include <stdint.h>
#include <stdbool.h>

#define EPD_WIDTH	240
#define EPD_HEIGHT	320
#define EPD_ROW_BYTES	(EPD_WIDTH / 8)
#define EPD_BYTES	(EPD_ROW_BYTES * EPD_HEIGHT)

// what epd_init found: false when the controller never came out of busy
bool	epd_init(void);
// the frame (EPD_BYTES, a set bit white, rows top to bottom, the byte's top
// bit leftmost) shown with the whole-screen waveform; ==> microseconds busy
int64_t	epd_full(const uint8_t* old_frame, const uint8_t* new_frame);
// the same with the temperature forced (TS_SET), which picks a shorter
// waveform from the OTP; ==> microseconds busy
int64_t	epd_fast(const uint8_t* old_frame, const uint8_t* new_frame, uint8_t ts_set);
// a window (x and width multiples of 8) refreshed alone; ==> microseconds busy
int64_t	epd_partial(int x, int y, int w, int h, const uint8_t* old_frame, const uint8_t* new_frame, uint8_t ts_set);
void	epd_sleep(void);				// power off (not deep sleep: there is no reset line to wake it)
