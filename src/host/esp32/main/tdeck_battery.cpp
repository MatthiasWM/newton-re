/*
	File:		host/esp32/main/tdeck_battery.cpp

	Contains:	The T-Deck Pro's battery as the Newton's
				(power/host/HostBattery.h): the board's fuel gauge and
				charger, on the I2C bus the touch panel and keyboard use
				(tdeck_input.cpp installs its driver; ESP-IDF's I2C driver
				takes one transaction at a time, so a Newton task may read
				here while the input task polls).

				The gauge is TI's BQ27220 at 0x55 (docs/host-tdeck-pro.md:
				the device spike found it): its standard commands are
				little-endian words - StateOfCharge (0x2C, per cent),
				Voltage (0x08, mV), Current (0x0C, mA, + charging),
				Temperature (0x06, 0.1 K) and BatteryStatus (0x0A: BATTPRES
				bit 3, there is a battery; FC bit 9, it is fully charged;
				DSG bit 0, it is discharging).  The charger is TI's BQ25896
				at 0x6B: its status register REG0B says whether the input
				is good (PG_STAT, bit 2: the USB is the mains) and what it
				is doing (CHRG_STAT, bits 4-3: 0 not charging, 1 pre-
				charge, 2 fast charging, 3 done).  Both are only read.

				With no battery fitted (the board on USB alone) the gauge
				says so and the Newton is told the host has none.
				ESP-IDF's headers only, and HostBattery.h (plain C++).
*/

#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "driver/i2c.h"

#include "esp32host.h"
#include "HostBattery.h"

#define I2C_PORT		I2C_NUM_0
#define ADDR_GAUGE		0x55
#define ADDR_CHARGER	0x6B

enum
{
	kGaugeTemperature = 0x06,
	kGaugeVoltage = 0x08,
	kGaugeStatus = 0x0A,
	kGaugeCurrent = 0x0C,
	kGaugeStateOfCharge = 0x2C
};

enum
{
	kStatusDischarging = 0x0001,		// DSG
	kStatusPresent = 0x0008,			// BATTPRES
	kStatusFull = 0x0200				// FC
};

const uint8_t	kChargerStatus = 0x0B;	// REG0B


// (asleep, the gauge stretches the clock while it wakes - longer than the
// bus's own timeout once allowed for, tdeck_input.cpp: so a word is asked
// for again)
static bool
ReadWord(uint8_t command, uint16_t* value)
{
	uint8_t b[2];
	if (i2c_master_write_read_device(I2C_PORT, ADDR_GAUGE, &command, 1, b, 2, pdMS_TO_TICKS(20)) != ESP_OK
	&& i2c_master_write_read_device(I2C_PORT, ADDR_GAUGE, &command, 1, b, 2, pdMS_TO_TICKS(20)) != ESP_OK)
		return false;
	*value = (uint16_t) (b[0] | (b[1] << 8));
	return true;
}


static bool
ReadCharger(uint8_t* status)
{
	return i2c_master_write_read_device(I2C_PORT, ADDR_CHARGER, &kChargerStatus, 1, status, 1, pdMS_TO_TICKS(20)) == ESP_OK;
}


// The battery now (HostBatterySource): none when the gauge does not
// answer or says none is fitted.
static bool
ReadBattery(HostBatteryReading* reading)
{
	uint16_t status, soc, value;
	if (!ReadWord(kGaugeStatus, &status) || (status & kStatusPresent) == 0 || !ReadWord(kGaugeStateOfCharge, &soc))
		return false;
	reading->percent = soc > 100 ? 100 : soc;
	if (ReadWord(kGaugeVoltage, &value))
		reading->millivolts = value;
	if (ReadWord(kGaugeCurrent, &value))
		reading->milliamps = (int16_t) value;
	if (ReadWord(kGaugeTemperature, &value))
		reading->tenthsCelsius = (long) value - 2731;
	uint8_t charger;
	if (ReadCharger(&charger))
	{
		reading->mains = (charger & 0x04) != 0;
		switch ((charger >> 3) & 3)
		{
		case 1:
		case 2:	reading->charge = kHostBatteryCharging;	break;
		case 3:	reading->charge = kHostBatteryFull;		break;
		default:
			reading->charge = reading->mains == 1 && (status & kStatusFull) != 0 ? kHostBatteryFull : kHostBatteryDischarging;
			break;
		}
	}
	else
		reading->charge = (status & kStatusDischarging) != 0 ? kHostBatteryDischarging
						: (status & kStatusFull) != 0 ? kHostBatteryFull : kHostBatteryCharging;
	return true;
}


bool
HostDeviceBatteryStart(void)
{
	HostBatteryReading reading = { 100, kHostBatteryUnknown, kHostBatteryUnknown, kHostBatteryUnknown, -1, kHostBatteryDischarging };
	uint16_t status;
	if (!ReadWord(kGaugeStatus, &status))
	{
		printf("newton: no fuel gauge - no battery reading\n");
		return false;
	}
	HostBatterySetSource(ReadBattery);
	if (ReadBattery(&reading))
		printf("newton: the battery at %ld%%, %ld mV, %ld mA, %s%s\n", reading.percent, reading.millivolts, reading.milliamps,
			   reading.charge == kHostBatteryCharging ? "charging" : reading.charge == kHostBatteryFull ? "full" : "discharging",
			   reading.mains == 1 ? ", on USB" : "");
	else
		printf("newton: no battery fitted\n");
	return true;
}
