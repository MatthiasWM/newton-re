/*
	File:		host/HostGPSNatives.cpp

	Contains:	The NewtonScript natives over the GPS receiver
				(hal/host/HostGPS.h, which lists them).  A host has one
				when newton is given a source with --gps.
*/

#include "HostGPS.h"
#include "HostSerialChip.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include <string.h>

const long long	kSecondsFrom1904To1970 = 2082844800LL;


static void
SetSlot(RefArg frame, const char* name, RefArg value)
{
	SetFrameSlot(frame, RefVar(Intern((char*) name)), value);
}


static Ref
FHostGPSAvailable(RefArg /*rcvr*/)
{
	return HostGPSStarted() ? TRUEREF : NILREF;
}


static Ref
FHostGPSStatus(RefArg /*rcvr*/)
{
	if (!HostGPSStarted())
		return NILREF;
	HostGPSFix fix;
	HostGPSStatus(&fix);
	char source[kHostGPSSourceSize];
	HostGPSSource(source, sizeof(source));
	RefVar status(AllocateFrame());
	SetSlot(status, "source", RefVar(MakeString(source)));
	SetSlot(status, "kind", RefVar(Intern((char*) (HostGPSGetKind() == kHostGPSTripmate ? "tripmate" : "nmea"))));
	ULong port = HostSerialChipGPS();
	SetSlot(status, "plugged", RefVar(MAKEBOOLEAN(port != 0)));
	SetSlot(status, "port", port == 0 ? RefVar(NILREF) : RefVar(MakeString(port == 'mdem' ? "mdem" : "extr")));
	SetSlot(status, "fix", RefVar(MAKEBOOLEAN(fix.valid)));
	if (fix.valid)
	{
		SetSlot(status, "latitude", RefVar(MakeReal(fix.latitude)));
		SetSlot(status, "longitude", RefVar(MakeReal(fix.longitude)));
		SetSlot(status, "altitude", RefVar(MakeReal(fix.altitude)));
		SetSlot(status, "speed", RefVar(MakeReal(fix.knots)));
		SetSlot(status, "course", RefVar(MakeReal(fix.course)));
		SetSlot(status, "satellites", RefVar(MAKEINT(fix.satellites)));
	}
	if (fix.time != 0)
	{
		// (as the Newton keeps time: minutes since 1904, which Time() is
		// in the Newton's own zone - this is UTC - and the seconds into it)
		SetSlot(status, "time", RefVar(MAKEINT((long) ((fix.time + kSecondsFrom1904To1970) / 60))));
		SetSlot(status, "seconds", RefVar(MAKEINT((long) ((fix.time + kSecondsFrom1904To1970) % 60))));
	}
	return status;
}


static double
Number(RefArg value)
{
	return ISINT(value) ? (double) RINT(value) : IsReal(value) ? CoerceToDouble(value) : 0.0;
}

static Ref
FHostGPSSetPosition(RefArg /*rcvr*/, RefArg latitude, RefArg longitude, RefArg altitude, RefArg knots, RefArg course)
{
	return MAKEBOOLEAN(HostGPSSetPosition(Number(latitude), Number(longitude), Number(altitude), Number(knots), Number(course)));
}


void
HostRegisterGPSFunctions(void)
{
	RefVar functions(gFunctionFrame);
	SetSlot(functions, "HostGPSAvailable", RefVar(MakeCFunction((void*) FHostGPSAvailable, 0, nil)));
	SetSlot(functions, "HostGPSStatus", RefVar(MakeCFunction((void*) FHostGPSStatus, 0, nil)));
	SetSlot(functions, "HostGPSSetPosition", RefVar(MakeCFunction((void*) FHostGPSSetPosition, 5, nil)));
}
