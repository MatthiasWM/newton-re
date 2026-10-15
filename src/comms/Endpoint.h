/*
	File:		comms/Endpoint.h

	Contains:	TEndpoint, the protocol a client talks to a communications
				service through (the DDK's CommAPI/Endpoint.h, whose
				interface this keeps), with what makes one work: the
				TEndpointEventHandler that carries its requests to the
				service's comm tool and brings the replies back, the endpoint
				events a client is told about asynchronous calls through, the
				TEndpointClient that receives them, and CMGetEndpoint.

				The DDK's Endpoint.h declares the protocol's methods plainly,
				as ProtocolGen took them; src/protocols/Protocols.h makes a
				protocol's methods virtual (VIRTUAL ... ENDVIRTUAL), so this
				header replaces it (sync_ddk_headers.py, REPLACED).

				An endpoint's calls are synchronous or asynchronous.  A
				synchronous one is an RPC to the tool made by
				TEndpointEventHandler::CallService with the world's mutex
				given up meanwhile (and the world forked first, so its event
				loop goes on, when forking is enabled); an asynchronous one
				is an async RPC whose reply comes to the world's port with
				the handler as its refCon, where the handler's
				AECompletionProc hands it to the endpoint's HandleComplete,
				which tells the client with an endpoint event (an event
				code: -1 a receive done, -2 a send, -7 a connect, ...).

	Reconstructed from the MP2x00 US ROM (0x000312b4, 0x0006b838,
	0x0006cb6c, 0x000ac2e0-0x000ad0f0, 0x000ad82c-0x000ada28,
	0x00382a0c-0x00382c4c); each function cites its origin.
	docs/comms/README.md.
*/

#ifndef __ENDPOINT_H
#define __ENDPOINT_H

#ifndef __PROTOCOLS_H
#include "Protocols.h"
#endif
#ifndef __AEVENTHANDLER_H
#include "AEventHandler.h"
#endif
#ifndef __COMMOPTIONS_H
#include "CommOptions.h"
#endif
#ifndef __PSEUDOSYNCSTATE_H
#include "PseudoSyncState.h"
#endif
#ifndef __TIMERQUEUE_H
#include "TimerQueue.h"
#endif
#ifndef __COMMS_OPTIONS_H
#include "Options.h"
#endif

class TEndpointEventHandler;
class TUAsyncMessage;
class CBufferSegment;


// "which" parm to IsPending()
#define	kSyncCall				(0x01)
#define	kAsyncCall				(0x02)
#define	kEitherCall				(0x03)

// the endpoint states (fState)
enum
{
	kUninit = 0,
	kUnbnd,				// opened
	kIdle,				// bound
	kOutCon,			// connecting
	kInCon,				// listened: a caller waiting to be accepted
	kDataXfer,			// connected
	kOutRel,			// releasing
	kInRel,				// the other end released
	kInFlux,			// a bind, unbind or disconnect in progress
	kInListen			// listening
};

// the endpoint's errors (-36000 on)
#define kEndpointErrBadState			(-36006)
#define kEndpointErrAborting			(-36003)
#define kEndpointErrPending				(-36030)
#define kEndpointErrNoPBs				(-36008)
#define kEndpointErrNotSupported		(-36018)
#define kEndpointErrBadEndpoint			(-36027)
#define kEndpointErrNoOptions			(-36002)
#define kEndpointErrAlreadyOpen			(-36006)
#define kError_Call_Aborted				(-10039)


//--------------------------------------------------------------------------------
//		TEndpoint
//--------------------------------------------------------------------------------

PROTOCOL TEndpoint : public TProtocol
{
public:
	static		TEndpoint*	New(char*);
				void		Delete(void);

	// delete the endpoint, but leave the tool running
	NONVIRTUAL	TObjectId	DeleteLeavingTool(void);

	// called as part of CMGetEndpoint
	NONVIRTUAL	NewtonErr	InitBaseEndpoint(TEndpointEventHandler* handler);
	NONVIRTUAL	void		SetClientHandler(ULong clientHandler);

	// EventHandler interface
	VIRTUAL		Boolean		HandleEvent(ULong msgType, TAEvent* event, ULong msgSize) ENDVIRTUAL;	// ROM 0x00382a54 HandleEvent__9TEndpointFUlP7TAEventT1
	VIRTUAL		Boolean		HandleComplete(TUMsgToken* msgToken, ULong* msgSize, TAEvent* event) ENDVIRTUAL;	// ROM 0x00382a60 HandleComplete__9TEndpointFP10TUMsgTokenPUlP7TAEvent

	// For handing endpoints around
	VIRTUAL		NewtonErr	AddToAppWorld(void) ENDVIRTUAL;	// ROM 0x00382a6c AddToAppWorld__9TEndpointFv
	VIRTUAL		NewtonErr	RemoveFromAppWorld(void) ENDVIRTUAL;	// ROM 0x00382a78 RemoveFromAppWorld__9TEndpointFv

	// Client interface
	VIRTUAL		NewtonErr	Open(ULong clientHandler = 0) ENDVIRTUAL;	// ROM 0x00382a84 Open__9TEndpointFUl
	VIRTUAL		NewtonErr	Close(void) ENDVIRTUAL;	// ROM 0x00382a90 Close__9TEndpointFv
	VIRTUAL		NewtonErr	Abort(void) ENDVIRTUAL;	// ROM 0x00382a9c Abort__9TEndpointFv

	NONVIRTUAL	NewtonErr	GetInfo(TCMOTransportInfo* info);
	NONVIRTUAL	Long		GetState(void)			{ return fState; }
	NONVIRTUAL	Boolean		IsSync(void)			{ return fSync; }

	VIRTUAL		Boolean		SetSync(Boolean sync) ENDVIRTUAL;	// ROM 0x00382aa8 SetSync__9TEndpointFUc

	VIRTUAL		NewtonErr	GetProtAddr(TOptionArray* bndAddr, TOptionArray* peerAddr, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382ab4 GetProtAddr__9TEndpointFP12TOptionArrayT1Ul
	VIRTUAL		NewtonErr	OptMgmt(ULong arrayOpCode, TOptionArray* options, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382ac0 OptMgmt__9TEndpointFUlP12TOptionArrayT1

	VIRTUAL		NewtonErr	Bind(TOptionArray* addr = nil, Long* qlen = nil, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382acc Bind__9TEndpointFP12TOptionArrayPlUl
	VIRTUAL		NewtonErr	UnBind(TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382ad8 UnBind__9TEndpointFUl

	VIRTUAL		NewtonErr	Listen(TOptionArray* addr = nil, TOptionArray* opt = nil, CBufferSegment* data = nil,
							Long* seq = nil, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382ae4 Listen__9TEndpointFP12TOptionArrayT1P14CBufferSegmentPlUl
	VIRTUAL		NewtonErr	Accept(TEndpoint* resfd, TOptionArray* addr = nil, TOptionArray* opt = nil,
							CBufferSegment* data = nil, Long seq = 0, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382af0 Accept__9TEndpointFP9TEndpointP12TOptionArrayT2P14CBufferSegmentlUl
	VIRTUAL		NewtonErr	Connect(TOptionArray* addr = nil, TOptionArray* opt = nil, CBufferSegment* data = nil,
							Long* seq = nil, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382afc Connect__9TEndpointFP12TOptionArrayT1P14CBufferSegmentPlUl
	VIRTUAL		NewtonErr	Disconnect(CBufferSegment* data = nil, Long reason = 0, Long seq = 0) ENDVIRTUAL;	// ROM 0x00382b08 Disconnect__9TEndpointFP14CBufferSegmentlT2
	VIRTUAL		NewtonErr	Release(TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382b14 Release__9TEndpointFUl

	VIRTUAL		NewtonErr	Snd(UByte* buf, Size& nBytes, ULong flags, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382b20 Snd__9TEndpointFPUcRlUlT3
	VIRTUAL		NewtonErr	Rcv(UByte* buf, Size& nBytes, Size thresh, ULong* flags, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382b2c Rcv__9TEndpointFPUcRllPUlUl
	VIRTUAL		NewtonErr	Snd(CBufferSegment* buf, ULong flags, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382b38 Snd__9TEndpointFP14CBufferSegmentUlT2
	VIRTUAL		NewtonErr	Rcv(CBufferSegment* buf, Size thresh, ULong* flags, TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382b44 Rcv__9TEndpointFP14CBufferSegmentlPUlUl

	VIRTUAL		NewtonErr	WaitForEvent(TTimeout timeOut = kNoTimeout) ENDVIRTUAL;	// ROM 0x00382b50 WaitForEvent__9TEndpointFUl

	// convenience functions
	NONVIRTUAL	NewtonErr	EasyOpen(ULong clientHandler = 0);
	NONVIRTUAL	NewtonErr	EasyConnect(ULong clientHandler = 0, TOptionArray* options = nil, TTimeout timeOut = kNoTimeout);
	NONVIRTUAL	NewtonErr	EasyClose(void);

	// 2.0
	VIRTUAL		NewtonErr	nBind(TOptionArray* opt = nil, TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382b5c nBind__9TEndpointFP12TOptionArrayUlUc
	VIRTUAL		NewtonErr	nListen(TOptionArray* opt = nil, CBufferSegment* data = nil, Long* seq = nil,
							TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382b68 nListen__9TEndpointFP12TOptionArrayP14CBufferSegmentPlUlUc
	VIRTUAL		NewtonErr	nAccept(TEndpoint* resfd, TOptionArray* opt = nil, CBufferSegment* data = nil,
							Long seq = 0, TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382b74 nAccept__9TEndpointFP9TEndpointP12TOptionArrayP14CBufferSegmentlUlUc
	VIRTUAL		NewtonErr	nConnect(TOptionArray* opt = nil, CBufferSegment* data = nil, Long* seq = nil,
							TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382b80 nConnect__9TEndpointFP12TOptionArrayP14CBufferSegmentPlUlUc
	VIRTUAL		NewtonErr	nRelease(TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382b8c nRelease__9TEndpointFUlUc
	VIRTUAL		NewtonErr	nDisconnect(CBufferSegment* data = nil, Long reason = 0, Long seq = 0,
							TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382b98 nDisconnect__9TEndpointFP14CBufferSegmentlT2UlUc
	VIRTUAL		NewtonErr	nUnBind(TTimeout timeOut = kNoTimeout, Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382ba4 nUnBind__9TEndpointFUlUc
	VIRTUAL		NewtonErr	nOptMgmt(ULong arrayOpCode, TOptionArray* options, TTimeout timeOut = kNoTimeout,
							Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382bb0 nOptMgmt__9TEndpointFUlP12TOptionArrayT1Uc
	VIRTUAL		NewtonErr	nSnd(UByte* buf, Size* count, ULong flags, TTimeout timeOut = kNoTimeout,
							Boolean sync = true, TOptionArray* opt = nil) ENDVIRTUAL;	// ROM 0x00382bbc nSnd__9TEndpointFPUcPlUlT3UcP12TOptionArray
	VIRTUAL		NewtonErr	nRcv(UByte* buf, Size* count, Size thresh, ULong* flags, TTimeout timeOut = kNoTimeout,
							Boolean sync = true, TOptionArray* opt = nil) ENDVIRTUAL;	// ROM 0x00382bc8 nRcv__9TEndpointFPUcPllPUlUlUcP12TOptionArray
	VIRTUAL		NewtonErr	nSnd(CBufferSegment* buf, ULong flags, TTimeout timeOut = kNoTimeout,
							Boolean sync = true, TOptionArray* opt = nil) ENDVIRTUAL;	// ROM 0x00382bd4 nSnd__9TEndpointFP14CBufferSegmentUlT2UcP12TOptionArray
	VIRTUAL		NewtonErr	nRcv(CBufferSegment* buf, Size thresh, ULong* flags, TTimeout timeOut = kNoTimeout,
							Boolean sync = true, TOptionArray* opt = nil) ENDVIRTUAL;	// ROM 0x00382be0 nRcv__9TEndpointFP14CBufferSegmentlPUlUlUcP12TOptionArray
	VIRTUAL		NewtonErr	nAbort(Boolean sync = true) ENDVIRTUAL;	// ROM 0x00382bec nAbort__9TEndpointFUc
	VIRTUAL		NewtonErr	Timeout(ULong refCon) ENDVIRTUAL;	// ROM 0x00382bf8 Timeout__9TEndpointFUl
	VIRTUAL		Boolean		IsPending(ULong which) ENDVIRTUAL;	// ROM 0x00382c04 IsPending__9TEndpointFUl

	NONVIRTUAL	Boolean		UseForks(Boolean justDoIt);

protected:
	NONVIRTUAL	void		DestroyBaseEndpoint(void);

public:
	Long					fState;				// +0x10
	TEndpointEventHandler*	fEventHandler;		// +0x14
	ULong					fClientRefCon;		// +0x18  the client (a TEndpointClient*)
	TCMOTransportInfo*		fInfo;				// +0x1c
	Boolean					fSync;				// +0x20
	Boolean					fToolIsRunning;		// +0x21
};


//--------------------------------------------------------------------------------
//		The endpoint events: what a client is told about an asynchronous call
//--------------------------------------------------------------------------------

// the event codes (fEventCode)
enum
{
	kEndpointEventRcvComplete		= -1,
	kEndpointEventSndComplete		= -2,
	kEndpointEventGetProtAddr		= -3,
	kEndpointEventOptMgmtComplete	= -4,
	kEndpointEventListenComplete	= -5,
	kEndpointEventAcceptComplete	= -6,
	kEndpointEventConnectComplete	= -7,
	kEndpointEventReleaseComplete	= -8,
	kEndpointEventDisconnectComplete= -9,
	kEndpointEventBindComplete		= -10,
	kEndpointEventUnBindComplete	= -11,
	kEndpointEventAbortComplete		= -12,
	kEndpointEventDisconnect		= 2,
	kEndpointEventRelease			= 3
};

class TEndpointEvent : public TAEvent		// 0x20 bytes
{
public:
						TEndpointEvent();
						TEndpointEvent(NewtonErr error, ULong client, Long eventCode);

	NewtonErr			fError;				// +0x08
	ULong				fClient;			// +0x0c  the TEndpointClient it is for
	Long				fEventCode;			// +0x10
	ULong				fReserved;			// +0x14
	TTime				fTime;				// +0x18
};

class TSndCompleteEvent : public TEndpointEvent		// 0x30
{
public:
						TSndCompleteEvent();
	UByte*				fBuffer;			// +0x20
	CBufferSegment*		fData;				// +0x24
	Size				fCount;				// +0x28
	TOptionArray*		fOptions;			// +0x2c
};

class TRcvCompleteEvent : public TEndpointEvent		// 0x34
{
public:
						TRcvCompleteEvent();
	UByte*				fBuffer;			// +0x20
	CBufferSegment*		fData;				// +0x24
	Size				fCount;				// +0x28
	ULong				fFlags;				// +0x2c
	TOptionArray*		fOptions;			// +0x30
};

class TBindCompleteEvent : public TEndpointEvent	// 0x24
{
public:
						TBindCompleteEvent();
						TBindCompleteEvent(NewtonErr error, ULong client, Long eventCode);
	ULong				fQueueLength;		// +0x20
};

class TDefaultEvent : public TEndpointEvent			// 0x24
{
public:
						TDefaultEvent();
	ULong				fData;				// +0x20
};

class TDisconnectEvent : public TEndpointEvent		// 0x2c
{
public:
						TDisconnectEvent();
						TDisconnectEvent(NewtonErr error, ULong client);
	CBufferSegment*		fDisconnectData;	// +0x20
	Long				fReason;			// +0x24
	Long				fSequence;			// +0x28
};

class TGetProtAddrCompleteEvent : public TEndpointEvent	// 0x28
{
public:
						TGetProtAddrCompleteEvent(NewtonErr error, ULong client);
	TOptionArray*		fBoundAddr;			// +0x20
	TOptionArray*		fPeerAddr;			// +0x24
};

class TOptMgmtCompleteEvent : public TEndpointEvent	// 0x24
{
public:
						TOptMgmtCompleteEvent();
						TOptMgmtCompleteEvent(NewtonErr error, ULong client);
	TOptionArray*		fOptions;			// +0x20
};

class TConnectCompleteEvent : public TEndpointEvent	// 0x30
{
public:
						TConnectCompleteEvent();
						TConnectCompleteEvent(NewtonErr error, ULong client, Long eventCode);
	TOptionArray*		fAddr;				// +0x20
	TOptionArray*		fOptions;			// +0x24
	CBufferSegment*		fData;				// +0x28
	Long				fSequence;			// +0x2c
};


//--------------------------------------------------------------------------------
//		TEndpointClient: what an endpoint's asynchronous calls tell
//--------------------------------------------------------------------------------

class TEndpointClient : public TAEventHandler		// 0x18 bytes
{
public:
						TEndpointClient();
	virtual				~TEndpointClient();

	NewtonErr			Init(TEndpoint* endpoint, ULong eventId, ULong eventClass);

	virtual Boolean		AETestEvent(TAEvent* event);
	virtual void		AEHandlerProc(TUMsgToken* token, ULong* size, TAEvent* event);
	virtual void		AECompletionProc(TUMsgToken* token, ULong* size, TAEvent* event);

	// the events (each the Default of its kind of event unless overridden)
	virtual void		Default(TEndpointEvent* event);
	virtual void		Disconnect(TEndpointEvent* event);
	virtual void		Release(TEndpointEvent* event);
	virtual void		DefaultComplete(TEndpointEvent* event);
	virtual void		SndComplete(TEndpointEvent* event);
	virtual void		RcvComplete(TEndpointEvent* event);
	virtual void		GetProtAddr(TEndpointEvent* event);
	virtual void		OptMgmtComplete(TEndpointEvent* event);
	virtual void		ListenComplete(TEndpointEvent* event);
	virtual void		ConnectComplete(TEndpointEvent* event);
	virtual void		AcceptComplete(TEndpointEvent* event);
	virtual void		ReleaseComplete(TEndpointEvent* event);
	virtual void		DisconnectComplete(TEndpointEvent* event);
	virtual void		BindComplete(TEndpointEvent* event);
	virtual void		UnBindComplete(TEndpointEvent* event);
	virtual void		AbortComplete(TEndpointEvent* event);

	TEndpoint*			fEndpoint;			// +0x14
};


//--------------------------------------------------------------------------------
//		TEndpointEventHandler: the endpoint's side of its service
//--------------------------------------------------------------------------------

class TEndpointTimer;

class TEndpointEventHandler : public TAEventHandler	// 0x2c bytes
{
public:
						TEndpointEventHandler(TEndpoint* endpoint, Boolean handleAborts);
	virtual				~TEndpointEventHandler();

	NewtonErr			Init(TObjectId servicePortId, ULong eventId, ULong eventClass);

	virtual Boolean		AETestEvent(TAEvent* event);
	virtual void		AEHandlerProc(TUMsgToken* token, ULong* size, TAEvent* event);
	virtual void		AECompletionProc(TUMsgToken* token, ULong* size, TAEvent* event);
	virtual void		IdleProc(TUMsgToken* token, ULong* size, TAEvent* event);

	NewtonErr			CallService(ULong msgType, TUAsyncMessage* asyncMsg, TAEvent* request, ULong requestSize,
									TAEvent* reply, ULong replySize, TTimeout timeout, ULong refCon, Boolean sync);
	NewtonErr			CallServiceNoForks(ULong msgType, TUAsyncMessage* asyncMsg, TAEvent* request, ULong requestSize,
									TAEvent* reply, ULong replySize, TTimeout timeout, ULong refCon, Boolean sync);
	Boolean				UseForks(Boolean useForks);
	NewtonErr			Block(ULong timeout);
	void				Unblock(void);
	void				DoEventLoop(TTimeout timeout);
	TObjectId			GetServicePortId(void);
	NewtonErr			AddToAppWorld(void);
	NewtonErr			RemoveFromAppWorld(void);
	void				HandleAborts(Boolean handleAborts);
	void				Abort(void);
	void				Timeout(TEndpointTimer* timer);
	NewtonErr			AddTimer(TTimeout timeout, ULong refCon);
	NewtonErr			KillTimer(ULong refCon);
	void				TerminateEventLoop(void);

	// the public jump table's of an older interface, each a bare return in
	// the ROM and called by nothing (the reconstruction's answer nothing;
	// the ROM's caller found its handler in r0)
	void				CallService(ULong msgType, TUAsyncMessage* asyncMsg, TAEvent* request, long requestSize,
									TAEvent* reply, long replySize, ULong timeout, Boolean sync);	// ROM 0x000ac670 CallService__21TEndpointEventHandlerFUlP14TUAsyncMessageP7TAEventlT3T4T1Uc
	void				CallServiceBlocking(ULong msgType, TAEvent* request, long requestSize,
									TAEvent* reply, long replySize, ULong timeout);					// ROM 0x000ac674 CallServiceBlocking__21TEndpointEventHandlerFUlP7TAEventlT2T3T1
	void				GetPrivatePortId(void);												// ROM 0x000acc28 GetPrivatePortId__21TEndpointEventHandlerFv
	void				GetSyncPortId(void);												// ROM 0x000acc2c GetSyncPortId__21TEndpointEventHandlerFv

	TEndpoint*			fEndpoint;			// +0x14
	TUPort				fServicePort;		// +0x18  the comm tool's port
	TPseudoSyncState	fSyncState;			// +0x20  what Block waits on
	Boolean				fBlocked;			// +0x28
	Boolean				fAborted;			// +0x29
	Boolean				fHandleAborts;		// +0x2a
};

// A timer on a call: when it goes off the endpoint's Timeout kills the call.
class TEndpointTimer : public TTimerElement	// 0x1c bytes
{
public:
						TEndpointTimer(TEndpointEventHandler* handler, TTimerQueue* queue, ULong refCon);
	virtual void		Timeout(void);

	TEndpointEventHandler*	fHandler;		// +0x18
};

// An async RPC whose reply comes to the handler (its refCon).
NewtonErr	SendRPC(TAEventHandler* handler, TUPort* port, TUAsyncMessage* asyncMsg, void* request, ULong requestSize,
					void* reply, ULong replySize, TTimeout timeout, TTime* when, ULong msgType, Boolean urgent);

// An endpoint for the options' service: the endpoint class an 'endp option
// names (TSerialEndpoint by default), the service started, and the
// endpoint bound to it.
NewtonErr	CMGetEndpoint(TOptionArray* options, TEndpoint** endPoint, Boolean handleAborts);

#endif	/* __ENDPOINT_H */
