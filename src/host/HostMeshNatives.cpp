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
	return HostMeshStarted() ? MAKEINT(HostMeshRegion()) : NILREF;
}


static Ref
FHostMeshSetRegion(RefArg /*rcvr*/, RefArg index)
{
	return ISINT(index) && HostMeshSetRegion(RINT(index)) ? TRUEREF : NILREF;
}


void
HostRegisterMeshFunctions(void)
{
	RefVar functions(gFunctionFrame);
	SetSlot(functions, "HostMeshAvailable", RefVar(MakeCFunction((void*) FHostMeshAvailable, 0, nil)));
	SetSlot(functions, "HostMeshStatus", RefVar(MakeCFunction((void*) FHostMeshStatus, 0, nil)));
	SetSlot(functions, "HostMeshContacts", RefVar(MakeCFunction((void*) FHostMeshContacts, 0, nil)));
	SetSlot(functions, "HostMeshSendText", RefVar(MakeCFunction((void*) FHostMeshSendText, 2, nil)));
	SetSlot(functions, "HostMeshSendState", RefVar(MakeCFunction((void*) FHostMeshSendState, 1, nil)));
	SetSlot(functions, "HostMeshNextMessage", RefVar(MakeCFunction((void*) FHostMeshNextMessage, 0, nil)));
	SetSlot(functions, "HostMeshAdvertise", RefVar(MakeCFunction((void*) FHostMeshAdvertise, 0, nil)));
	SetSlot(functions, "HostMeshSetName", RefVar(MakeCFunction((void*) FHostMeshSetName, 1, nil)));
	SetSlot(functions, "HostMeshRegions", RefVar(MakeCFunction((void*) FHostMeshRegions, 0, nil)));
	SetSlot(functions, "HostMeshRegion", RefVar(MakeCFunction((void*) FHostMeshRegion, 0, nil)));
	SetSlot(functions, "HostMeshSetRegion", RefVar(MakeCFunction((void*) FHostMeshSetRegion, 1, nil)));
}
