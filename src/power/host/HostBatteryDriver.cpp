/*
	File:		power/host/HostBatteryDriver.cpp

	Contains:	The host's battery driver (power/host/HostBatteryDriver.h).
				Host only (not in the ROM).
*/

#include "power/host/HostBatteryDriver.h"
#include "power/host/HostBattery.h"
#include "power/BatteryDriver.h"
#include "OSErrors.h"

#include <string.h>

PROTOCOL PMainBatteryDriver : public PBatteryDriver
{
public:
	PROTOCOL_IMPL_HEADER_MACRO(PMainBatteryDriver);

	PMainBatteryDriver*	New();
	void			Delete();
	NewtonErr		Init(void);
	NewtonErr		WakeUp(void);
	NewtonErr		ShutDown(void);
	long			Count(void);
	NewtonErr		Status(ULong which, PowerPlantStatus* status);
	NewtonErr		RawStatus(ULong which, PowerPlantStatus* status);
	NewtonErr		StartSleepCharge(void);
	NewtonErr		SetType(ULong which, ULong type);
	long			ReadADCVoltage(ULong channel);
	Fixed			ConvertVoltage(ULong channel, ULong reading);

	long			fType;				// the kBattery... kind the machine was told
	PowerPlantStatus	fLast;			// the reading last taken
};

PROTOCOL_IMPL_SOURCE_MACRO(PMainBatteryDriver)
PROTOCOL_CLASSINFO(PMainBatteryDriver, "PBatteryDriver", "", 0, 0, nil)

static const Fixed kFixedOne = 0x00010000;
static const long kLowPercent = 10;			// the battery called low (MainBatteryCheck warns at it)


// A host's figure in thousandths (millivolts, milliamps) as a Fixed, or
// -1 (cannot say) where the host does not say.
static Fixed
FixedThousandths(long value)
{
	if (value == kHostBatteryUnknown)
		return -1;
	return (Fixed) ((long long) value * kFixedOne / 1000);
}


PMainBatteryDriver*
PMainBatteryDriver::New()
{
	fType = kBatteryAlkaline;
	memset(&fLast, 0, sizeof(fLast));
	return this;
}

void		PMainBatteryDriver::Delete()					{ }
NewtonErr	PMainBatteryDriver::Init(void)					{ PowerPlantStatus status; return RawStatus(0, &status); }
NewtonErr	PMainBatteryDriver::WakeUp(void)				{ return noErr; }
NewtonErr	PMainBatteryDriver::ShutDown(void)				{ return noErr; }
long		PMainBatteryDriver::Count(void)					{ return 1; }			// one set of cells, as a MessagePad has
NewtonErr	PMainBatteryDriver::StartSleepCharge(void)		{ return kError_Call_Not_Implemented; }
long		PMainBatteryDriver::ReadADCVoltage(ULong)		{ return 0; }
Fixed		PMainBatteryDriver::ConvertVoltage(ULong, ULong reading)	{ return (Fixed) reading; }


NewtonErr
PMainBatteryDriver::Status(ULong which, PowerPlantStatus* status)
{
	if (which != 0 || status == nil)
		return kError_Bad_Parameters;
	return RawStatus(which, status);
}


// A reading taken now (power/host/HostBattery.h).  A host with a battery
// of its own is reported as it says: its charge, its voltage, the current
// drawn from it or charging it, its temperature (-1, cannot say, where the
// host does not say), the mains, and low at 10% - the machine warns of it
// (MainBatteryCheck) as of a MessagePad's.  Dead is 0%: only then does the
// machine hold itself asleep (FMinimumBatteryCheck), the host's own
// shutdown coming first.  A host with none (a desktop computer) is a
// machine on fresh cells: full, nothing drawn, no mains, at room
// temperature.
NewtonErr
PMainBatteryDriver::RawStatus(ULong which, PowerPlantStatus* status)
{
	if (which != 0 || status == nil)
		return kError_Bad_Parameters;
	HostBatteryReading host;
	bool present = HostBatteryRead(&host);
	status->fBatteryType = fType;
	status->fBatteryCapacity = host.percent;
	status->fBatteryVoltage = (Fixed) (4 * kFixedOne + (2 * kFixedOne) * host.percent / 100);		// four cells, 1 to 1.5 V each
	status->fBatteryLow = 0;
	status->fBatteryDead = 0;
	status->fBatteryCurrent = 0;
	status->fACPower = 0;
	status->fChargeState = kChargeDischarging;
	status->fChargeRate = 0;
	status->fChargeCurrent = 0;
	status->fAmbientTemp = 20 * kFixedOne;
	status->fBatteryTemp = 20 * kFixedOne;
	if (present)
	{
		if (host.millivolts != kHostBatteryUnknown)
			status->fBatteryVoltage = FixedThousandths(host.millivolts);
		status->fBatteryLow = kLowPercent;
		status->fACPower = host.mains == 1;
		if (host.charge == kHostBatteryCharging)
			status->fChargeState = kChargeFast;
		else if (host.charge == kHostBatteryFull)
			status->fChargeState = kChargeFullyCharged;
		// (the current drawn from the battery, and the current charging it)
		status->fBatteryCurrent = host.milliamps == kHostBatteryUnknown ? -1 : host.milliamps < 0 ? FixedThousandths(-host.milliamps) : 0;
		status->fChargeCurrent = host.milliamps == kHostBatteryUnknown ? -1 : host.milliamps > 0 ? FixedThousandths(host.milliamps) : 0;
		status->fChargeRate = -1;
		status->fAmbientTemp = -1;
		status->fBatteryTemp = host.tenthsCelsius == kHostBatteryUnknown ? -1 : (Fixed) ((long long) host.tenthsCelsius * kFixedOne / 10);
	}
	status->fACVoltage = status->fACPower ? 7 * kFixedOne : 0;
	fLast = *status;
	return noErr;
}


NewtonErr
PMainBatteryDriver::SetType(ULong which, ULong type)
{
	if (which != 0)
		return kError_Bad_Parameters;
	fType = (long) type;
	return noErr;
}


void
HostRegisterBatteryDriver(void)
{
	PMainBatteryDriver::ClassInfo()->Register();
}
