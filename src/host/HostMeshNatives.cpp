/*
	File:		host/HostMeshNatives.cpp

	Contains:	The NewtonScript natives over the LoRa mesh engine
				(HostMesh.h, which lists them).  The engine speaks UTF-8; a
				NewtonScript string is UTF-16, turned here (HostUTF8.h).  A
				desktop has a mesh node when newton is given an air with
				--mesh-air (tools/mesh's meshpeer, or other newtons, on the
				same one).
*/

#include "HostMesh.h"
#include "HostUTF8.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include <math.h>
#include <stdio.h>
#include <string.h>

const long	kSecondsFrom1904To1970 = 2082844800L;


static void
SetSlot(RefArg frame, const char* name, RefArg value)
{
	SetFrameSlot(frame, RefVar(Intern((char*) name)), value);
}


// Unix seconds as minutes since 1904, as Time() gives them (nil: none)
static Ref
MinutesOf(uint32_t seconds)
{
	return seconds != 0 ? MAKEINT((long) (((long long) seconds + kSecondsFrom1904To1970) / 60)) : NILREF;
}


static Ref
FHostMeshAvailable(RefArg /*rcvr*/)
{
	return HostMeshStarted() ? TRUEREF : NILREF;
}


static Ref
FHostMeshStatus(RefArg /*rcvr*/)
{
	if (!HostMeshStarted())
		return NILREF;
	HostMeshStatusInfo info;
	HostMeshGetStatus(&info);
	static const char* const kStates[] = { "starting", "starting", "on", "off" };
	RefVar status(AllocateFrame());
	SetSlot(status, "state", RefVar(Intern((char*) kStates[info.state])));
	SetSlot(status, "name", RefVar(HostStringOfUTF8(info.name)));
	char id[9];
	memcpy(id, info.key, 8);
	id[8] = 0;
	SetSlot(status, "id", RefVar(HostStringOfUTF8(id)));
	SetSlot(status, "region", RefVar(HostStringOfUTF8(info.region)));
	SetSlot(status, "contacts", RefVar(MAKEINT(info.contacts)));
	SetSlot(status, "received", RefVar(MAKEINT(info.received)));
	SetSlot(status, "sent", RefVar(MAKEINT(info.sent)));
	SetSlot(status, "packetsHeard", RefVar(MAKEINT(info.packetsHeard)));
	SetSlot(status, "packetsSent", RefVar(MAKEINT(info.packetsSent)));
	// what was heard, by MeshCore's payload type (only those heard)
	static const char* const kTypes[16] = { "req", "response", "text", "ack", "advert", "channelText", "channelData",
		"anonReq", "path", "trace", "multipart", "control", "type12", "type13", "type14", "raw" };
	RefVar heard(AllocateFrame());
	for (int k = 0; k < 16; k++)
		if (info.heardByType[k] != 0)
			SetSlot(heard, kTypes[k], RefVar(MAKEINT(info.heardByType[k])));
	SetSlot(status, "heard", heard);
	SetSlot(status, "channelKnown", RefVar(MAKEINT(info.channelKnown)));
	SetSlot(status, "channelUnknown", RefVar(MAKEINT(info.channelUnknown)));
	SetSlot(status, "lastUnknownHash", info.lastUnknownHash >= 0 ? RefVar(MAKEINT(info.lastUnknownHash)) : RefVar(NILREF));
	SetSlot(status, "radioErrors", info.radioErrors >= 0 ? RefVar(MAKEINT(info.radioErrors)) : RefVar(NILREF));
	SetSlot(status, "radioRecoveries", info.radioRecoveries >= 0 ? RefVar(MAKEINT(info.radioRecoveries)) : RefVar(NILREF));
	SetSlot(status, "radioIdleRestarts", info.radioIdleRestarts >= 0 ? RefVar(MAKEINT(info.radioIdleRestarts)) : RefVar(NILREF));
	SetSlot(status, "radioIdleMs", RefVar(MAKEINT(info.radioIdleMs)));
	SetSlot(status, "errFlags", RefVar(MAKEINT(info.errFlags)));
	SetSlot(status, "noiseFloor", RefVar(MAKEINT(info.noiseFloor)));
	SetSlot(status, "lastRssi", RefVar(MAKEINT((long) info.lastRssi)));
	SetSlot(status, "lastSnr", RefVar(MAKEINT((long) info.lastSnr)));
	return status;
}


static Ref
FHostMeshContacts(RefArg /*rcvr*/)
{
	if (!HostMeshStarted())
		return NILREF;
	static HostMeshContact contacts[kHostMeshContactsMax];
	long count = HostMeshGetContacts(contacts, kHostMeshContactsMax);
	if (count > kHostMeshContactsMax)
		count = kHostMeshContactsMax;
	static const char* const kKinds[] = { "none", "chat", "repeater", "room", "sensor" };
	RefVar list(MakeArray(0));
	for (long k = 0; k < count; k++)
	{
		const HostMeshContact& c = contacts[k];
		RefVar contact(AllocateFrame());
		SetSlot(contact, "key", RefVar(HostStringOfUTF8(c.key)));
		SetSlot(contact, "name", RefVar(HostStringOfUTF8(c.name)));
		SetSlot(contact, "kind", RefVar(Intern((char*) kKinds[c.kind >= 0 && c.kind <= 4 ? c.kind : 0])));
		SetSlot(contact, "hops", c.hops >= 0 ? RefVar(MAKEINT(c.hops)) : RefVar(NILREF));
		SetSlot(contact, "heard", RefVar(MinutesOf(c.heard)));
		SetSlot(contact, "saved", c.saved ? RefVar(TRUEREF) : RefVar(NILREF));
		AddArraySlot(list, contact);
	}
	return list;
}


static Ref
FHostMeshSendText(RefArg /*rcvr*/, RefArg key, RefArg text)
{
	char hex[kHostMeshKeyHexSize];
	static char body[kHostMeshTextSize];
	HostUTF8Of(key, hex, sizeof(hex));
	HostUTF8Of(text, body, sizeof(body));
	long id = HostMeshSendText(hex, body);
	return id != 0 ? MAKEINT(id) : NILREF;
}


static Ref
FHostMeshSendState(RefArg /*rcvr*/, RefArg id)
{
	if (!ISINT(id))
		return NILREF;
	static const char* const kStates[] = { NULL, "busy", "sent", "delivered", "failed" };
	int state = HostMeshGetSendState(RINT(id));
	return state == kHostMeshSendNone ? NILREF : Intern((char*) kStates[state]);
}


static Ref
FHostMeshNextMessage(RefArg /*rcvr*/)
{
	static HostMeshMessage m;
	if (!HostMeshNextMessage(&m))
		return NILREF;
	RefVar message(AllocateFrame());
	SetSlot(message, "key", m.key[0] != 0 ? RefVar(HostStringOfUTF8(m.key)) : RefVar(NILREF));
	SetSlot(message, "name", RefVar(HostStringOfUTF8(m.name)));
	SetSlot(message, "channel", m.channel[0] != 0 ? RefVar(HostStringOfUTF8(m.channel)) : RefVar(NILREF));
	SetSlot(message, "text", RefVar(HostStringOfUTF8(m.text)));
	SetSlot(message, "time", RefVar(MinutesOf(m.sent)));
	// (how long ago it was sent by the sender's clock, in minutes, by ours:
	// a clock that is out shows here; nil when theirs is ahead)
	SetSlot(message, "age", m.sent != 0 && m.now >= m.sent ? RefVar(MAKEINT((long) ((m.now - m.sent) / 60))) : RefVar(NILREF));
	return message;
}


static Ref
FHostMeshAdvertise(RefArg /*rcvr*/)
{
	return HostMeshAdvertise() ? TRUEREF : NILREF;
}


static Ref
FHostMeshSetName(RefArg /*rcvr*/, RefArg name)
{
	char utf8[kHostMeshNameSize];
	HostUTF8Of(name, utf8, sizeof(utf8));
	return HostMeshSetName(utf8) ? TRUEREF : NILREF;
}


static Ref
FHostMeshSaveContact(RefArg /*rcvr*/, RefArg key, RefArg name, RefArg saved)
{
	if (!IsString(key))
		return NILREF;
	char hex[kHostMeshKeyHexSize + 1];
	HostUTF8Of(key, hex, sizeof(hex));
	char utf8[kHostMeshNameSize];
	utf8[0] = 0;
	if (IsString(name))
		HostUTF8Of(name, utf8, sizeof(utf8));
	return HostMeshSetSaved(hex, utf8, NOTNIL(saved)) ? TRUEREF : NILREF;
}


static Ref
FHostMeshRegions(RefArg /*rcvr*/)
{
	RefVar list(MakeArray(0));
	for (long k = 0; k < HostMeshRegionCount(); k++)
		AddArraySlot(list, RefVar(HostStringOfUTF8(HostMeshRegionName(k))));
	return list;
}


static Ref
FHostMeshRegion(RefArg /*rcvr*/)
{
	long index = HostMeshStarted() ? HostMeshRegion() : -1;
	return index >= 0 ? MAKEINT(index) : NILREF;
}


static Ref
FHostMeshSetRegion(RefArg /*rcvr*/, RefArg index)
{
	return ISINT(index) && HostMeshSetRegion(RINT(index)) ? TRUEREF : NILREF;
}


// a radio's settings as a frame: {frequency (MHz, a real), bandwidth (kHz,
// a real), spreadingFactor, codingRate, txPower} (a preset's have no
// txPower)
static Ref
RadioFrame(const HostMeshRadioSettings& r, bool power)
{
	RefVar frame(AllocateFrame());
	// (to the kHz, so that 916.575 reads back as itself, not 916.57501...)
	SetSlot(frame, "frequency", RefVar(MakeReal(floor(r.frequency * 1000.0 + 0.5) / 1000.0)));
	SetSlot(frame, "bandwidth", RefVar(MakeReal(floor(r.bandwidth * 100.0 + 0.5) / 100.0)));
	SetSlot(frame, "spreadingFactor", RefVar(MAKEINT(r.spreadingFactor)));
	SetSlot(frame, "codingRate", RefVar(MAKEINT(r.codingRate)));
	SetSlot(frame, "pathHashSize", RefVar(MAKEINT(r.pathHashSize)));
	if (power)
		SetSlot(frame, "txPower", RefVar(MAKEINT(r.txPower)));
	return frame;
}


// a number slot of a frame (an integer or a real), or nil
static bool
NumberSlot(RefArg frame, const char* name, double* value)
{
	RefVar v(GetFrameSlot(frame, RefVar(Intern((char*) name))));
	if (ISINT(v))
		*value = (double) RINT(v);
	else if (NOTNIL(v) && IsReal(v))
		*value = CoerceToDouble(v);
	else
		return false;
	return true;
}


static Ref
FHostMeshRegionSettings(RefArg /*rcvr*/, RefArg index)
{
	HostMeshRadioSettings r;
	if (!ISINT(index) || !HostMeshRegionSettings(RINT(index), &r))
		return NILREF;
	return RadioFrame(r, false);
}


static Ref
FHostMeshRadio(RefArg /*rcvr*/)
{
	if (!HostMeshStarted())
		return NILREF;
	HostMeshRadioSettings r;
	HostMeshGetRadio(&r);
	return RadioFrame(r, true);
}


// HostMeshSetRadio({frequency, bandwidth, spreadingFactor, codingRate,
// txPower, pathHashSize}): any left out as they are now
static Ref
FHostMeshSetRadio(RefArg /*rcvr*/, RefArg settings)
{
	if (!HostMeshStarted() || !IsFrame(settings))
		return NILREF;
	HostMeshRadioSettings r;
	HostMeshGetRadio(&r);
	double v;
	if (NumberSlot(settings, "frequency", &v))
		r.frequency = (float) v;
	if (NumberSlot(settings, "bandwidth", &v))
		r.bandwidth = (float) v;
	if (NumberSlot(settings, "spreadingFactor", &v))
		r.spreadingFactor = (int) v;
	if (NumberSlot(settings, "codingRate", &v))
		r.codingRate = (int) v;
	if (NumberSlot(settings, "txPower", &v))
		r.txPower = (int) v;
	if (NumberSlot(settings, "pathHashSize", &v))
		r.pathHashSize = (int) v;
	return HostMeshSetRadio(&r) ? TRUEREF : NILREF;
}


static Ref
FHostMeshBandwidths(RefArg /*rcvr*/)
{
	RefVar list(MakeArray(0));
	for (long k = 0; k < HostMeshBandwidthCount(); k++)
		AddArraySlot(list, RefVar(MakeReal(floor(HostMeshBandwidth(k) * 100.0 + 0.5) / 100.0)));
	return list;
}


// the radio's power (the Mesh application's Prefs): whether the board can
// switch it, whether it is on, and switched (==> whether it was taken)
static Ref
FHostMeshPowerSwitchable(RefArg /*rcvr*/)
{
	return HostMeshPowerSwitchable() ? TRUEREF : NILREF;
}


static Ref
FHostMeshPowered(RefArg /*rcvr*/)
{
	return HostMeshPowered() ? TRUEREF : NILREF;
}


static Ref
FHostMeshSetPower(RefArg /*rcvr*/, RefArg on)
{
	if (!HostMeshPowerSwitchable())
		return NILREF;
	bool taken = HostMeshSetPower(NOTNIL(on));
	fprintf(stderr, "[host] the LoRa radio %s%s\n", NOTNIL(on) ? "on" : "off", taken ? "" : " - it could not be switched");
	return taken ? TRUEREF : NILREF;
}


void
HostRegisterMeshFunctions(void)
{
	RefVar functions(gFunctionFrame);
	SetSlot(functions, "HostMeshAvailable", RefVar(MakeCFunction((void*) FHostMeshAvailable, 0, nil)));
	SetSlot(functions, "HostMeshStatus", RefVar(MakeCFunction((void*) FHostMeshStatus, 0, nil)));
	SetSlot(functions, "HostMeshContacts", RefVar(MakeCFunction((void*) FHostMeshContacts, 0, nil)));
	SetSlot(functions, "HostMeshSaveContact", RefVar(MakeCFunction((void*) FHostMeshSaveContact, 3, nil)));
	SetSlot(functions, "HostMeshSendText", RefVar(MakeCFunction((void*) FHostMeshSendText, 2, nil)));
	SetSlot(functions, "HostMeshSendState", RefVar(MakeCFunction((void*) FHostMeshSendState, 1, nil)));
	SetSlot(functions, "HostMeshNextMessage", RefVar(MakeCFunction((void*) FHostMeshNextMessage, 0, nil)));
	SetSlot(functions, "HostMeshAdvertise", RefVar(MakeCFunction((void*) FHostMeshAdvertise, 0, nil)));
	SetSlot(functions, "HostMeshSetName", RefVar(MakeCFunction((void*) FHostMeshSetName, 1, nil)));
	SetSlot(functions, "HostMeshRegions", RefVar(MakeCFunction((void*) FHostMeshRegions, 0, nil)));
	SetSlot(functions, "HostMeshRegion", RefVar(MakeCFunction((void*) FHostMeshRegion, 0, nil)));
	SetSlot(functions, "HostMeshSetRegion", RefVar(MakeCFunction((void*) FHostMeshSetRegion, 1, nil)));
	SetSlot(functions, "HostMeshRegionSettings", RefVar(MakeCFunction((void*) FHostMeshRegionSettings, 1, nil)));
	SetSlot(functions, "HostMeshRadio", RefVar(MakeCFunction((void*) FHostMeshRadio, 0, nil)));
	SetSlot(functions, "HostMeshSetRadio", RefVar(MakeCFunction((void*) FHostMeshSetRadio, 1, nil)));
	SetSlot(functions, "HostMeshBandwidths", RefVar(MakeCFunction((void*) FHostMeshBandwidths, 0, nil)));
	SetSlot(functions, "HostMeshPowerSwitchable", RefVar(MakeCFunction((void*) FHostMeshPowerSwitchable, 0, nil)));
	SetSlot(functions, "HostMeshPowered", RefVar(MakeCFunction((void*) FHostMeshPowered, 0, nil)));
	SetSlot(functions, "HostMeshSetPower", RefVar(MakeCFunction((void*) FHostMeshSetPower, 1, nil)));
}
