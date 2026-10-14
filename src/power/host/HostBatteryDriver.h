/*
	File:		power/host/HostBatteryDriver.h

	Contains:	The host's battery driver: a PBatteryDriver
				(power/BatteryDriver.h) registered as "PMainBatteryDriver",
				the name the power manager looks for before it makes the
				MP2x00's own Cirrus driver - so it stands where a machine's
				own driver would.  Host only (not in the ROM).

				It reports the host's own battery (power/host/HostBattery.h:
				a board's fuel gauge, or what the operating system says -
				Windows, macOS, Linux's /sys/class/power_supply), its low
				mark at 10%; and on a host with none a machine on fresh
				cells: full, nothing drawn, no mains, at room temperature.
				The kind of cells is what the machine is told (the Prefs'
				battery picker, SetBatteryType).
*/

#ifndef __HOSTBATTERYDRIVER_H
#define __HOSTBATTERYDRIVER_H

void	HostRegisterBatteryDriver(void);			// before the power manager starts

#endif	/* __HOSTBATTERYDRIVER_H */
