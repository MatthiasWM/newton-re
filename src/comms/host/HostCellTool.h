/*
	File:		comms/host/HostCellTool.h

	Contains:	THostCellTool, the comm tool behind the host's 'cell
				service: a telephone API (TAPI) provider over the host's
				cellular module (hal/host/HostCellular.h), so that the
				ROM's own Phone transport (|PhoneHome:Newton|) and Calls
				log make, take and log calls through it.

				The ROM has the whole framework and no provider for it
				(docs/host-tdeck-pro-phone.md): the Phone transport opens a
				'tapiEndpoint (@662, a protoBasicEndpoint) on whatever
				service the provider names - registered with RegCommConfig,
				which comms/host/HostCell.ns does for this one - and speaks
				to it in options, as the ROM's modem tool (comms/ModemTool.h,
				whose 'taps handling this follows) understands them:

				Instantiate  the service ('cell), 'ctso (the service's id,
				             4 characters), 'cpcm (the passive claim:
				             TCommTool's)
				Connect      'taps (the telephone API's service, four
				             booleans): taken, and connected at once - the
				             module is always there
				'cpst        the passive state (TCommTool's)
				'outg        a call made: the number in the 'rout address
				             (TCMAPhoneNumber, kPhoneNumber) beside it
				'answ        the ringing call answered
				'disc        hung up
				'sdgt        keypad tones in a call: the digits in a 'rout
				'tasp        the speaker on (the loudspeaker) or off (the
				             handset)
				'rout, read  (opGetCurrent) the caller's number, as
				             GetCallerId asks for it
				'hold 'unho 'forw 'focr 'tran
				             not supported (the Phone transport does not
				             use them)

				Each completes at once: the module's answer comes back as
				an event.  The events (T_TAPIEVT, its data the
				'tapiEndpoint's eventHandler's) are the engine's, taken
				every kHostCellPollInterval and posted as the endpoint asks
				for them:

				a ring           1  (EventIncoming: "Call from ^0…",
				                    Take Call)
				connected        8  (conversation)
				ended, no answer 6  (on hook: EventOnHook, the call
				                    logged and closed)
				busy             11 (busy tone), then 6

	Host code for a telephone provider (no ROM counterpart: the ROM
	registers none).
*/

#ifndef __COMMS_HOSTCELLTOOL_H
#define __COMMS_HOSTCELLTOOL_H

#ifndef __COMMS_COMMTOOLS_H
#include "CommTools.h"
#endif

#define kCellServiceId				'cell'
#define kHostCellPollInterval		(100 * kMilliseconds)

// the telephone API's events (the 'tapiEndpoint's eventHandler, @662)
enum
{
	kTAPIEventIncoming = 1,
	kTAPIEventRinger = 2,
	kTAPIEventOffHook = 5,
	kTAPIEventOnHook = 6,
	kTAPIEventConversation = 8,
	kTAPIEventBusyTone = 11
};

class THostCellTool : public TCommTool
{
public:
						THostCellTool(ULong serviceId);
	virtual				~THostCellTool();

	virtual ULong		GetSizeOf();
	virtual UChar*		GetToolName();
	virtual NewtonErr	OpenStart(TOptionArray* options);
	virtual ULong		ProcessOptionStart(TOption* theOption, ULong label, ULong opcode);
	virtual void		HandleTimerTick();
	virtual void		HandleInternalEvent();
	virtual void		GetCommEvent();

	// (no data flows: the call's audio is the module's own)
	virtual void		PutBytes(CBufferList* clientBuffer);
	virtual void		PutFramedBytes(CBufferList* clientBuffer, Boolean endOfFrame);
	virtual void		KillPut();
	virtual void		GetBytes(CBufferList* clientBuffer);
	virtual void		GetFramedBytes(CBufferList* clientBuffer);
	virtual void		KillGet();

private:
	Boolean				PhoneNumberOption(char* number, long size);
	void				Queue(ULong event);
	void				PostQueued();

	ULong				fEvents[8];				// the events not yet taken by the endpoint
	long				fEventCount;
};

#endif	/* __COMMS_HOSTCELLTOOL_H */
