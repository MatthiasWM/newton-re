/*
	File:		utility/IdleTimer.h

	Contains:	TIdleTimer, an idle timer of an older interface than the
				handlers' own (TAEIdleTimer, AEventHandler.h), and nothing
				more: in the MessagePad 2x00's ROM each of its functions -
				the constructor, Init, Start, Stop and the Resets, two of
				them with a port to send to - is a bare return (mov pc, lr),
				as is TAEventHandler's ResetIdle with a port (declared in the
				DDK's class by sync_ddk_headers.py).  They are in the public
				jump table, for packages built against the older interface;
				nothing in the ROM calls them.

				The class has no fields: the constructor does not even
				allocate (a self-allocating constructor called with nil
				gives nil back), so its size is not known.  The ROM's
				functions answer nothing - whatever their caller finds in
				r0 afterwards is the object it passed - and the
				reconstruction's return nothing (armcpu's glue leaves r0 as
				the ARM code passed it).  The DDK does not declare the
				class; the argument names are the reconstruction's.

	Reconstructed from the MP2x00 US ROM (0x00025460-0x00025cd8, among
	TAEventHandler's functions); each function cites its origin.
*/

#ifndef __IDLETIMER_H
#define __IDLETIMER_H

#ifndef __NEWTON_H
#include "Newton.h"
#endif
#ifndef __NEWTONTIME_H
#include "NewtonTime.h"
#endif

class TUPort;


class TIdleTimer
{
public:
				TIdleTimer();													// ROM 0x00025460 __ct__10TIdleTimerFv

	void		Init(ULong amount, TimeUnits units, ULong refCon, ULong start);	// ROM 0x00025464 Init__10TIdleTimerFUl9TimeUnitsN21
	void		Start(void);													// ROM 0x00025aec Start__10TIdleTimerFv
	void		Start(TUPort* port);											// ROM 0x00025cd8 Start__10TIdleTimerFP6TUPort
	void		Stop(void);														// ROM 0x00025ccc Stop__10TIdleTimerFv
	void		Reset(void);													// ROM 0x00025888 Reset__10TIdleTimerFv
	void		Reset(ULong amount, TimeUnits units);							// ROM 0x000256b4 Reset__10TIdleTimerFUl9TimeUnits
	void		Reset(ULong amount, TimeUnits units, TUPort* port);				// ROM 0x00025cd4 Reset__10TIdleTimerFUl9TimeUnitsP6TUPort
};

#endif	/* __IDLETIMER_H */
