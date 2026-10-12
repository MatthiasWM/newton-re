/*
	File:		host/HostCellularNatives.cpp

	Contains:	The NewtonScript natives over the cellular modem engine
				(HostCellular.h, which lists them).  The engine speaks
				UTF-8; a NewtonScript string is UTF-16, turned here.
				A desktop has a module when newton is given one with
				--cell-port (tools/modem/fakecell.py at the other end).
*/

#include "HostCellular.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Unicode.h"
#include <string.h>
#include <time.h>

const long	kSecondsFrom1904To1970 = 2082844800L;


// A NewtonScript string as UTF-8 (nil, or not a string: "")
static void
UTF8Of(RefArg text, char* out, long size)
{
	out[0] = 0;
	if (ISNIL(text) || !IsString(text))
		return;
	const UniChar* s = GetCString(text);
	long o = 0;
	for (; *s != 0; s++)
	{
		unsigned long cp = *s;
		if (cp >= 0xD800 && cp <= 0xDBFF && s[1] >= 0xDC00 && s[1] <= 0xDFFF)
		{
			cp = 0x10000 + ((cp - 0xD800) << 10) + (s[1] - 0xDC00);
			s++;
		}
		long n = cp < 0x80 ? 1 : cp < 0x800 ? 2 : cp < 0x10000 ? 3 : 4;
		if (o + n >= size)
			break;
		if (n == 1)
			out[o++] = (char) cp;
		else if (n == 2)
		{
			out[o++] = (char) (0xC0 | (cp >> 6));
			out[o++] = (char) (0x80 | (cp & 0x3F));
		}
		else if (n == 3)
		{
			out[o++] = (char) (0xE0 | (cp >> 12));
			out[o++] = (char) (0x80 | ((cp >> 6) & 0x3F));
			out[o++] = (char) (0x80 | (cp & 0x3F));
		}
		else
		{
			out[o++] = (char) (0xF0 | (cp >> 18));
			out[o++] = (char) (0x80 | ((cp >> 12) & 0x3F));
			out[o++] = (char) (0x80 | ((cp >> 6) & 0x3F));
			out[o++] = (char) (0x80 | (cp & 0x3F));
		}
	}
	out[o] = 0;
}


// UTF-8 as a NewtonScript string (a malformed byte taken as itself)
static Ref
StringOfUTF8(const char* utf8)
{
	long size = (long) strlen(utf8) + 1;
	UniChar* units = new UniChar[size * 2];
	const unsigned char* p = (const unsigned char*) utf8;
	long o = 0;
	while (*p)
	{
		unsigned long cp = *p;
		int n = 1;
		if ((*p & 0xE0) == 0xC0)
			cp = *p & 0x1F, n = 2;
		else if ((*p & 0xF0) == 0xE0)
			cp = *p & 0x0F, n = 3;
		else if ((*p & 0xF8) == 0xF0)
			cp = *p & 0x07, n = 4;
		bool good = true;
		for (int k = 1; k < n; k++)
			if ((p[k] & 0xC0) != 0x80)
				good = false;
			else
				cp = (cp << 6) | (p[k] & 0x3F);
		if (!good)
			cp = *p, n = 1;
		p += n;
		if (cp >= 0x10000)
		{
			cp -= 0x10000;
			units[o++] = (UniChar) (0xD800 + (cp >> 10));
			units[o++] = (UniChar) (0xDC00 + (cp & 0x3FF));
		}
		else
			units[o++] = (UniChar) cp;
	}
	RefVar string(MakeString(units, o));
	delete[] units;
	return string;
}


static void
SetSlot(RefArg frame, const char* name, RefArg value)
{
	SetFrameSlot(frame, RefVar(Intern((char*) name)), value);
}


static Ref
FHostCellAvailable(RefArg /*rcvr*/)
{
	return HostCellularStarted() ? TRUEREF : NILREF;
}


static Ref
FHostCellStatus(RefArg /*rcvr*/)
{
	if (!HostCellularStarted())
		return NILREF;
	HostCellStatusInfo info;
	HostCellularStatus(&info);
	static const char* const kStates[] = { "none", "starting", "noSIM", "locked", "searching", "home", "roaming" };
	static const char* const kCalls[] = { "idle", "incoming", "dialing", "active" };
	RefVar status(AllocateFrame());
	SetSlot(status, "state", RefVar(Intern((char*) kStates[info.state])));
	SetSlot(status, "operator", info.operatorName[0] != 0 ? RefVar(StringOfUTF8(info.operatorName)) : RefVar(NILREF));
	SetSlot(status, "rssi", info.rssi != 0 ? RefVar(MAKEINT(info.rssi)) : RefVar(NILREF));
	SetSlot(status, "callState", RefVar(Intern((char*) kCalls[info.call])));
	SetSlot(status, "number", info.number[0] != 0 ? RefVar(StringOfUTF8(info.number)) : RefVar(NILREF));
	SetSlot(status, "seconds", RefVar(MAKEINT(info.callSeconds)));
	return status;
}


static Ref
FHostCellDial(RefArg /*rcvr*/, RefArg number)
{
	char digits[kHostCellNumberSize];
	UTF8Of(number, digits, sizeof(digits));
	return HostCellularDial(digits) ? TRUEREF : NILREF;
}


static Ref
FHostCellAnswer(RefArg /*rcvr*/)
{
	return HostCellularAnswer() ? TRUEREF : NILREF;
}


static Ref
FHostCellHangUp(RefArg /*rcvr*/)
{
	return HostCellularHangUp() ? TRUEREF : NILREF;
}


static Ref
FHostCellSendText(RefArg /*rcvr*/, RefArg number, RefArg text)
{
	char digits[kHostCellNumberSize];
	static char body[kHostCellTextSize];
	UTF8Of(number, digits, sizeof(digits));
	UTF8Of(text, body, sizeof(body));
	long id = HostCellularSendText(digits, body);
	return id != 0 ? MAKEINT(id) : NILREF;
}


static Ref
FHostCellSendState(RefArg /*rcvr*/, RefArg id)
{
	if (!ISINT(id))
		return NILREF;
	static const char* const kStates[] = { nil, "busy", "sent", "failed" };
	HostCellSendState state = HostCellularSendState(RINT(id));
	return state == kHostCellSendNone ? NILREF : Intern((char*) kStates[state]);
}


static Ref
NextText(HostCellReader reader)
{
	static HostCellText text;
	if (!HostCellularNextText(&text, reader))
		return NILREF;
	RefVar message(AllocateFrame());
	SetSlot(message, "number", RefVar(StringOfUTF8(text.number)));
	SetSlot(message, "text", RefVar(StringOfUTF8(text.text)));
	// (minutes since 1904, as Time() gives them)
	SetSlot(message, "time", text.time != 0 ? RefVar(MAKEINT((long) ((text.time + kSecondsFrom1904To1970) / 60))) : RefVar(NILREF));
	// (how long ago it was sent, in minutes, by the host's clock - which is
	// GMT: Time() less this is when, in the Newton's own zone; time is GMT)
	long long now = (long long) ::time(nil);
	SetSlot(message, "age", text.time != 0 && now >= text.time ? RefVar(MAKEINT((long) ((now - text.time) / 60))) : RefVar(NILREF));
	return message;
}


static Ref
FHostCellNextText(RefArg /*rcvr*/)
{
	return NextText(kHostCellReaderScript);
}


// the text transport's own (comms/host/HostText.ns): every message, as the
// script's natives get every one too
static Ref
FHostCellTransportText(RefArg /*rcvr*/)
{
	return NextText(kHostCellReaderTool);
}


static Ref
FHostCellNextEvent(RefArg /*rcvr*/)
{
	HostCellEvent event;
	if (!HostCellularNextEvent(&event, kHostCellReaderScript))
		return NILREF;
	static const char* const kEvents[] = { "ring", "connected", "ended", "busy", "noAnswer" };
	RefVar frame(AllocateFrame());
	SetSlot(frame, "event", RefVar(Intern((char*) kEvents[event.kind])));
	SetSlot(frame, "number", event.number[0] != 0 ? RefVar(StringOfUTF8(event.number)) : RefVar(NILREF));
	return frame;
}


static Ref
FHostCellCommand(RefArg /*rcvr*/, RefArg command)
{
	char line[256];
	static char reply[kHostCellReplySize];
	UTF8Of(command, line, sizeof(line));
	if (line[0] == 0 || !HostCellularStarted())
		return NILREF;
	bool ok = HostCellularCommand(line, reply, sizeof(reply), 10000);
	RefVar answer(AllocateFrame());
	SetSlot(answer, "ok", ok ? RefVar(TRUEREF) : RefVar(NILREF));
	SetSlot(answer, "reply", RefVar(StringOfUTF8(reply)));
	return answer;
}


void
HostRegisterCellularFunctions(void)
{
	RefVar functions(gFunctionFrame);
	SetSlot(functions, "HostCellAvailable", RefVar(MakeCFunction((void*) FHostCellAvailable, 0, nil)));
	SetSlot(functions, "HostCellStatus", RefVar(MakeCFunction((void*) FHostCellStatus, 0, nil)));
	SetSlot(functions, "HostCellDial", RefVar(MakeCFunction((void*) FHostCellDial, 1, nil)));
	SetSlot(functions, "HostCellAnswer", RefVar(MakeCFunction((void*) FHostCellAnswer, 0, nil)));
	SetSlot(functions, "HostCellHangUp", RefVar(MakeCFunction((void*) FHostCellHangUp, 0, nil)));
	SetSlot(functions, "HostCellSendText", RefVar(MakeCFunction((void*) FHostCellSendText, 2, nil)));
	SetSlot(functions, "HostCellSendState", RefVar(MakeCFunction((void*) FHostCellSendState, 1, nil)));
	SetSlot(functions, "HostCellNextText", RefVar(MakeCFunction((void*) FHostCellNextText, 0, nil)));
	SetSlot(functions, "HostCellTransportText", RefVar(MakeCFunction((void*) FHostCellTransportText, 0, nil)));
	SetSlot(functions, "HostCellNextEvent", RefVar(MakeCFunction((void*) FHostCellNextEvent, 0, nil)));
	SetSlot(functions, "HostCellCommand", RefVar(MakeCFunction((void*) FHostCellCommand, 1, nil)));
}
