// Host unit test for the power manager (power/PowerManager.h): the 'pg&e
// world started over the host's battery driver (power/host/
// HostBatteryDriver.h, registered as the machine's own
// "PMainBatteryDriver"), and the batteries asked for by RPC as the
// scripts' natives ask - how many, a battery's status, what cells it
// holds; the host's own battery (power/host/HostBattery.h) as the driver
// reports it - pinned readings, a board's gauge, no battery, and Linux's
// /sys/class/power_supply read from a tree the test makes; and the
// platform's sleep (hal/host/HostPower.h): a test's wake
// ends it with the power switch's bit, which the platform puts down to
// nothing in particular, and an alarm's bit to the alarm.
//
// The power manager is a world with a task of its own, so the test runs as
// the kernel services task of a booted OS.

#include "power/PowerManager.h"
#include "power/BatteryDriver.h"
#include "power/host/HostBatteryDriver.h"
#include "power/host/HostBattery.h"
#include "hal/Power.h"
#include "hal/host/HostPower.h"
#include "Boot.h"
#include "UserBoot.h"
#include "UserPorts.h"
#include "OSErrors.h"
#include "host/TaskRuntime.h"

#include <stdio.h>
#include <string.h>
#if defined(_WIN32)
#include <direct.h>
#define MakeDirectory(path) _mkdir(path)
#else
#include <sys/stat.h>
#define MakeDirectory(path) mkdir(path, 0755)
#endif

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; printf("FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)


static NewtonErr
Ask(ULong command, ULong which, ULong type, TPowerManagerEvent* reply, ULong size)
{
	TPowerManagerEvent request;
	request.fAEventClass = kNewtEventClass;
	request.fAEventID = kPowerManagerID;
	request.fCommand = command;
	request.fWhich = which;
	request.fType = type;
	ULong replySize = 0;
	return GetPowerPort()->SendRPC(&replySize, &request, size, reply, size);
}


static void
TestBatteries(void)
{
	TPowerManagerEvent reply;
	EXPECT(Ask(kPowerCmdCount, 0, 0, &reply, kPowerEventSize) == noErr);
	EXPECT(reply.fWhich == 1);

	EXPECT(Ask(kPowerCmdStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fCommand == noErr);
	EXPECT(reply.fStatus.fBatteryType == kBatteryAlkaline);
	EXPECT(reply.fStatus.fBatteryCapacity >= 0 && reply.fStatus.fBatteryCapacity <= 100);
	printf("test_PowerManager: battery at %ld%%, mains %ld\n", (long) reply.fStatus.fBatteryCapacity, (long) reply.fStatus.fACPower);

	// the cells told, and the next reading says so
	EXPECT(Ask(kPowerCmdSetType, 0, kBatteryNiMH, &reply, kPowerEventTypeSize) == noErr);
	EXPECT(reply.fWhich == noErr);
	EXPECT(Ask(kPowerCmdRawStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fStatus.fBatteryType == kBatteryNiMH);

	// there is no second battery
	EXPECT(Ask(kPowerCmdStatus, 1, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fCommand == (ULong) kError_Bad_Parameters);

	// commands 1 to 3 answer 100
	EXPECT(Ask(2, 0, 0, &reply, kPowerEventSize) == noErr);
	EXPECT(reply.fCommand == 100);
}


static const Fixed kOne = 0x00010000;

static bool
GaugeSource(HostBatteryReading* reading)
{
	reading->percent = 64;
	reading->charge = kHostBatteryCharging;			// (the mains not said)
	return true;
}


static void
TestHostBattery(void)
{
	TPowerManagerEvent reply;

	// a battery charging on the mains, as a host says it
	HostBatteryReading reading = { 55, 3900, 1500, 315, 1, kHostBatteryCharging };
	HostBatteryPin(&reading);
	EXPECT(Ask(kPowerCmdRawStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fStatus.fBatteryCapacity == 55);
	EXPECT(reply.fStatus.fBatteryVoltage == (Fixed) (3900LL * kOne / 1000));
	EXPECT(reply.fStatus.fBatteryLow == 10);
	EXPECT(reply.fStatus.fBatteryDead == 0);
	EXPECT(reply.fStatus.fACPower == 1);
	EXPECT(reply.fStatus.fChargeState == kChargeFast);
	EXPECT(reply.fStatus.fChargeCurrent == (Fixed) (1500LL * kOne / 1000));
	EXPECT(reply.fStatus.fBatteryCurrent == 0);
	EXPECT(reply.fStatus.fBatteryTemp == (Fixed) (315LL * kOne / 10));

	// running down on the battery, nothing said but its charge
	HostBatteryReading low = { 7, kHostBatteryUnknown, kHostBatteryUnknown, kHostBatteryUnknown, 0, kHostBatteryDischarging };
	HostBatteryPin(&low);
	EXPECT(Ask(kPowerCmdRawStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fStatus.fBatteryCapacity == 7);
	EXPECT(reply.fStatus.fBatteryCapacity <= reply.fStatus.fBatteryLow);		// MainBatteryCheck warns
	EXPECT(reply.fStatus.fACPower == 0);
	EXPECT(reply.fStatus.fChargeState == kChargeDischarging);
	EXPECT(reply.fStatus.fBatteryCurrent == -1 && reply.fStatus.fBatteryTemp == -1);
	EXPECT(reply.fStatus.fBatteryVoltage == (Fixed) (4 * kOne + 2 * kOne * 7 / 100));

	// on the mains, held full
	HostBatteryReading full = { 100, kHostBatteryUnknown, kHostBatteryUnknown, kHostBatteryUnknown, 1, kHostBatteryFull };
	HostBatteryPin(&full);
	EXPECT(Ask(kPowerCmdRawStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fStatus.fChargeState == kChargeFullyCharged && reply.fStatus.fACPower == 1);

	// a host with no battery: fresh cells, no mains, never low
	HostBatteryPin(&full, false);
	EXPECT(Ask(kPowerCmdRawStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fStatus.fBatteryCapacity == 100);
	EXPECT(reply.fStatus.fBatteryLow == 0 && reply.fStatus.fACPower == 0);
	EXPECT(reply.fStatus.fChargeState == kChargeDischarging);
	EXPECT(reply.fStatus.fBatteryTemp == 20 * kOne);

	// a board's gauge: charging, so on the mains though it did not say
	HostBatteryPin(nullptr);
	HostBatterySetSource(GaugeSource);
	EXPECT(HostBatteryRead(&reading));
	EXPECT(reading.percent == 64 && reading.mains == 1);
	EXPECT(Ask(kPowerCmdRawStatus, 0, 0, &reply, kPowerEventStatusSize) == noErr);
	EXPECT(reply.fStatus.fBatteryCapacity == 64 && reply.fStatus.fACPower == 1);
	HostBatterySetSource(nullptr);
}


static void
WriteAttribute(const char* root, const char* supply, const char* attribute, const char* value)
{
	char path[256];
	snprintf(path, sizeof(path), "%s/%s", root, supply);
	MakeDirectory(path);
	snprintf(path, sizeof(path), "%s/%s/%s", root, supply, attribute);
	FILE* f = fopen(path, "w");
	EXPECT(f != nil);
	if (f != nil)
	{
		fprintf(f, "%s\n", value);
		fclose(f);
	}
}


// Linux's power supply class, as a tree of files: a mouse's battery (scope
// Device) and an absent one passed over, the system's battery found
// whatever its name, its current's sign taken from its status, the mains
// from a supply online
static void
TestSysfs(void)
{
	const char* root = "test_PowerManager.sysfs";
	MakeDirectory(root);
	WriteAttribute(root, "AC", "type", "Mains");
	WriteAttribute(root, "AC", "online", "1");
	WriteAttribute(root, "BAT0", "type", "Battery");
	WriteAttribute(root, "BAT0", "present", "0");
	WriteAttribute(root, "BAT0", "capacity", "99");
	WriteAttribute(root, "a-hid-mouse", "type", "Battery");
	WriteAttribute(root, "a-hid-mouse", "scope", "Device");
	WriteAttribute(root, "a-hid-mouse", "capacity", "5");
	WriteAttribute(root, "max1726x_battery", "type", "Battery");
	WriteAttribute(root, "max1726x_battery", "present", "1");
	WriteAttribute(root, "max1726x_battery", "capacity", "42");
	WriteAttribute(root, "max1726x_battery", "status", "Charging");
	WriteAttribute(root, "max1726x_battery", "voltage_now", "4012000");
	WriteAttribute(root, "max1726x_battery", "current_now", "-750000");
	WriteAttribute(root, "max1726x_battery", "temp", "287");
	HostBatteryReading reading;
	EXPECT(HostBatteryReadSysfs(root, &reading));
	EXPECT(reading.percent == 42);
	EXPECT(reading.charge == kHostBatteryCharging);
	EXPECT(reading.millivolts == 4012);
	EXPECT(reading.milliamps == 750);
	EXPECT(reading.tenthsCelsius == 287);
	EXPECT(reading.mains == 1);

	// unplugged: the charge from energy, the mains off
	WriteAttribute(root, "AC", "online", "0");
	WriteAttribute(root, "max1726x_battery", "capacity", "");
	WriteAttribute(root, "max1726x_battery", "energy_now", "30000000");
	WriteAttribute(root, "max1726x_battery", "energy_full", "40000000");
	WriteAttribute(root, "max1726x_battery", "status", "Discharging");
	WriteAttribute(root, "max1726x_battery", "current_now", "750000");
	EXPECT(HostBatteryReadSysfs(root, &reading));
	EXPECT(reading.percent == 75);
	EXPECT(reading.charge == kHostBatteryDischarging);
	EXPECT(reading.milliamps == -750);
	EXPECT(reading.mains == 0);

	// the reMarkable Paper Pro's tree (as read on the owner's, 2026-10-14):
	// the gauge's battery and the charger's, the charger on USB, and the
	// Marker's battery a Wireless supply online when it is docked - which
	// is not the mains
	const char* tablet = "test_PowerManager.rmpp";
	MakeDirectory(tablet);
	WriteAttribute(tablet, "elants-marker-battery", "type", "Wireless");
	WriteAttribute(tablet, "elants-marker-battery", "present", "0");
	WriteAttribute(tablet, "elants-marker-battery", "capacity", "90");
	WriteAttribute(tablet, "max1726x_battery", "type", "Battery");
	WriteAttribute(tablet, "max1726x_battery", "present", "1");
	WriteAttribute(tablet, "max1726x_battery", "status", "Charging");
	WriteAttribute(tablet, "max1726x_battery", "capacity", "97");
	WriteAttribute(tablet, "max1726x_battery", "voltage_now", "8752500");
	WriteAttribute(tablet, "max1726x_battery", "current_now", "257730");
	WriteAttribute(tablet, "max1726x_battery", "temp", "260");
	WriteAttribute(tablet, "max77963-bat", "type", "Battery");
	WriteAttribute(tablet, "max77963-bat", "voltage_now", "8761896");
	WriteAttribute(tablet, "max77963-charger", "type", "USB");
	WriteAttribute(tablet, "max77963-charger", "online", "1");
	WriteAttribute(tablet, "nfc-marker-battery", "type", "Wireless");
	WriteAttribute(tablet, "nfc-marker-battery", "online", "1");
	WriteAttribute(tablet, "nfc-marker-battery", "capacity", "90");
	EXPECT(HostBatteryReadSysfs(tablet, &reading));
	EXPECT(reading.percent == 97 && reading.charge == kHostBatteryCharging);
	EXPECT(reading.millivolts == 8752 && reading.milliamps == 257 && reading.tenthsCelsius == 260);
	EXPECT(reading.mains == 1);
	WriteAttribute(tablet, "max77963-charger", "online", "0");
	WriteAttribute(tablet, "max1726x_battery", "status", "Discharging");
	EXPECT(HostBatteryReadSysfs(tablet, &reading));
	EXPECT(reading.mains == 0);								// (the Marker still docked)
	EXPECT(reading.charge == kHostBatteryDischarging);

	// no tree at all: no battery
	EXPECT(!HostBatteryReadSysfs("test_PowerManager.nothing", &reading));
}


static void
TestSleep(void)
{
	ULong before = HostPowerSleeps();
	HostPowerWakeAfter(50);
	PlatformPowerOffSystem();
	EXPECT(HostPowerSleeps() == before + 1);
	EXPECT(PlatformPowerOnSystem() == 0);
	ULong event = PlatformPowerEvent();
	EXPECT(event == kHostPowerEventSwitch);
	EXPECT(TranslatePowerEvent(event) == kWokeBecause);
	EXPECT(PlatformPowerEvent() == 0);				// taken
	EXPECT(TranslatePowerEvent(kPowerEventAlarm) == kWokeAlarm);
	EXPECT(TranslatePowerEvent(kPowerEventSerialGPI) == kWokeSerialGPI);

	// with no window and no wake armed nothing could wake it: it does not
	// sleep, and says the switch was pressed
	PlatformPowerOffSystem();
	EXPECT(HostPowerSleeps() == before + 1);
	EXPECT(PlatformPowerEvent() == kHostPowerEventSwitch);
}


static void
PowerScenario(void)
{
	HostRegisterBatteryDriver();
	EXPECT(InitPowerManager() == noErr);
	EXPECT(GetPowerPort() != nil);
	EXPECT(GetBatteryDriver() != nil);
	if (GetPowerPort() != nil)
	{
		TestBatteries();
		TestHostBattery();
	}
	TestSysfs();
	TestSleep();
	HostStopTasks();
}


int
main()
{
	gHostKernelServicesTask = PowerScenario;
	OsBoot();
	if (failures == 0)
		printf("test_PowerManager: all passed\n");
	else
		printf("test_PowerManager: %d failures\n", failures);
	return failures != 0;
}
