/*
	File:		comms/host/HostCellTool.cpp

	Contains:	THostCellTool (HostCellTool.h).

	Host code for a telephone provider (no ROM counterpart).
*/

#include "HostCellTool.h"
#include "HostCellular.h"
#include "ModemOptions.h"
#include "Options.h"
#include "CommAddresses.h"
#include "CommErrors.h"
#include "Transport.h"

#include <string.h>


THostCellTool::THostCellTool(ULong serviceId)
	: TCommTool(serviceId), fEventCount(0)
{ }


THostCellTool::~THostCellTool()
{ }


ULong
THostCellTool::GetSizeOf()
{
	return sizeof(THostCellTool);
}


UChar*
THostCellTool::GetToolName()
{
	return (UChar*) "Host cellular";
}


// Opened: the engine's events looked at every kHostCellPollInterval from
// now on - those from before forgotten (they were nobody's)
NewtonErr
THostCellTool::OpenStart(TOptionArray* options)
{
	if (!HostCellularStarted())
		return kCommErrResourceNotAvailable;
	HostCellEvent stale;
	while (HostCellularNextEvent(&stale, kHostCellReaderTool))
		;
	fTimerInterval = kHostCellPollInterval;
	return noErr;
}


// The number in the phone number address among the options (marked done)
// ==> whether there was one
Boolean
THostCellTool::PhoneNumberOption(char* number, long size)
{
	number[0] = 0;
	if (fOptionsInfo.fOptions == nil)
		return false;
	TOptionIterator iter(fOptionsInfo.fOptions);
	for (TOption* option = iter.FirstOption(); iter.More(); option = iter.NextOption())
		if (option->Label() == kCMARouteLabel)
		{
			TCMAPhoneNumber* address = (TCMAPhoneNumber*) option;
			if (address->fType == kPhoneNumber)
			{
				// (only what a GSM dial string holds: the transport's number
				// carries the dialling prefix's spacing, " 5551234", and its
				// punctuation)
				const char* chars = (const char*) (address + 1);
				long n = 0;
				for (ULong i = 0; i < address->fPhoneLen && n < size - 1; i++)
					if ((chars[i] >= '0' && chars[i] <= '9') || chars[i] == '+' || chars[i] == '*' || chars[i] == '#')
						number[n++] = chars[i];
				number[n] = 0;
			}
			option->SetOpCodeResult(opSuccess);
			option->SetProcessed();
			return number[0] != 0;
		}
	return false;
}


ULong
THostCellTool::ProcessOptionStart(TOption* theOption, ULong label, ULong opcode)
{
	Boolean set = (opcode == opSetNegotiate || opcode == opSetRequired);
	char number[kHostCellNumberSize];
	switch (label)
	{
	case kCellServiceId:
	case 'ctso':
	case kCMOTAPIService:
		return opSuccess;

	case 'outg':
		if (!set || !PhoneNumberOption(number, sizeof(number)))
			return opFailure;
		return HostCellularDial(number) ? opSuccess : opFailure;

	case 'answ':
		if (!set)
			return opFailure;
		return HostCellularAnswer() ? opSuccess : opFailure;

	case 'disc':
		if (!set)
			return opFailure;
		return HostCellularHangUp() ? opSuccess : opFailure;

	case 'sdgt':
		if (!set || !PhoneNumberOption(number, sizeof(number)))
			return opFailure;
		return HostCellularSendDigits(number) ? opSuccess : opFailure;

	case kCMOTAPISpeaker:
		if (!set)
			return opFailure;
		return HostCellularSetSpeaker(((TCMOTAPISpeaker*) theOption)->fSpeakerOn) ? opSuccess : opFailure;

	case kCMARouteLabel:
		// read: the caller's number (GetCallerId), in as much room as the
		// option has; set: a number taken by the option beside it
		if (opcode == opGetCurrent || opcode == opGetDefault)
		{
			TCMAPhoneNumber* address = (TCMAPhoneNumber*) theOption;
			long room = (long) theOption->Length() - (long) (sizeof(TCMAPhoneNumber) - sizeof(TOption));
			if (room <= 0)
				return opFailure;
			HostCellStatusInfo status;
			HostCellularStatus(&status);
			long length = (long) strlen(status.number);
			if (length == 0)
				return opFailure;
			if (length > room)
				length = room;
			char* chars = (char*) (address + 1);
			memset(chars, 0, room);
			memcpy(chars, status.number, length);
			address->fType = kPhoneNumber;
			address->fPhoneLen = length;
			return opSuccess;
		}
		return opSuccess;

	case 'hold':
	case 'unho':
	case 'forw':
	case 'focr':
	case 'tran':
		return opNotSupported;
	}
	return TCommTool::ProcessOptionStart(theOption, label, opcode);
}


// ---------------------------------------------------------------------------
//	Events
// ---------------------------------------------------------------------------

void
THostCellTool::Queue(ULong event)
{
	if (fEventCount == (long) (sizeof(fEvents) / sizeof(fEvents[0])))
	{
		memmove(fEvents, fEvents + 1, (fEventCount - 1) * sizeof(fEvents[0]));		// (the oldest forgotten)
		fEventCount--;
	}
	fEvents[fEventCount++] = event;
}


// The oldest event, if the endpoint is asking for one
void
THostCellTool::PostQueued()
{
	if (fEventCount == 0)
		return;
	TCommToolGetEventReply event;
	event.fEventCode = T_TAPIEVT;
	event.fEventTime.Set(0, 0);
	event.fEventData = fEvents[0];
	event.fServiceId = fServiceId;
	if (TCommTool::PostCommEvent(event, noErr) == noErr)
	{
		memmove(fEvents, fEvents + 1, (fEventCount - 1) * sizeof(fEvents[0]));
		fEventCount--;
	}
}


void
THostCellTool::GetCommEvent()
{
	if (fEventCount > 0)
		PostQueued();
	else
		TCommTool::GetCommEvent();
}


void
THostCellTool::HandleTimerTick()
{
	HostCellEvent event;
	while (HostCellularNextEvent(&event, kHostCellReaderTool))
		switch (event.kind)
		{
		case kHostCellEventRing:
			Queue(kTAPIEventIncoming);
			break;
		case kHostCellEventConnected:
			Queue(kTAPIEventConversation);
			break;
		case kHostCellEventBusy:
			Queue(kTAPIEventBusyTone);
			Queue(kTAPIEventOnHook);
			break;
		case kHostCellEventEnded:
		case kHostCellEventNoAnswer:
			Queue(kTAPIEventOnHook);
			break;
		}
	PostQueued();
}


// After every message: the poll kept going (as THostTCPTool's: the
// countdown of TaskMain's timeout can come to nought while the host's
// clock stands still, and nought is no timeout at all)
void
THostCellTool::HandleInternalEvent()
{
	if (fTimerInterval != 0 && fTimeout == 0)
		fTimeout = fTimerInterval;
}


void THostCellTool::PutBytes(CBufferList*)						{ PutComplete(kCommErrNotSupported, 0); }
void THostCellTool::PutFramedBytes(CBufferList*, Boolean)		{ PutComplete(kCommErrNotSupported, 0); }
void THostCellTool::KillPut()									{ KillPutComplete(noErr); }
void THostCellTool::GetBytes(CBufferList*)						{ GetComplete(kCommErrNotSupported); }
void THostCellTool::GetFramedBytes(CBufferList*)				{ GetComplete(kCommErrNotSupported); }
void THostCellTool::KillGet()									{ KillGetComplete(noErr); }
