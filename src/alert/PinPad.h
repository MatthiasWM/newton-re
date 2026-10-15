/*
	File:		alert/PinPad.h

	Contains:	TDrawInterface, a protocol for drawing straight onto the
				screen and reading the pen with nothing else running - a
				box (Init) that pictures and text are drawn into and the
				pen is polled in, put away again by Delete - and TPinPad,
				the ROM's implementation: the screen's drawing held
				(StartDrawing, the LCD's activity blocked), a port of its
				own clipped to the box, text in the alert font's strikes
				(the style's font family's plainData, boldData, ...: what
				TAlertGlyph reads) and the tablet polled directly
				(SetTabletPolling) rather than through the tablet task.
				A PIN pad, by its name: what asks for a PIN before the
				system is up.  Nothing in the ROM makes one; InitGraf
				registers it, for code outside the ROM to make by name.

	Not in the DDK; the interface follows the ROM's dispatch table
	(tools/newton-rom/analysis/classinfo.py --name TPinPad).  Layout
	(0xb8 bytes): the TProtocol, fBounds +0x10, fPort +0x18 (a GrafPort,
	0x54), fSavedPort +0x6c, fScreenPort +0x70, fWasPolling +0x74,
	fGlyphFont +0x78, fStyle +0x7c (a StyleRecord, 0x20), fOptions +0x9c
	(TextOptions, 0x1c).

	Reconstructed from the MP2x00 US ROM (0x00189f78-0x0018a424, class
	info 0x00388704); each method cites its origin.
*/

#ifndef __PINPAD_H
#define __PINPAD_H

#include "Protocols.h"
#include "Ports.h"
#include "Fonts.h"
#include "Text.h"
#include "PicRecord.h"


/*------------------------------------------------------------------------------
	T D r a w I n t e r f a c e
------------------------------------------------------------------------------*/

PROTOCOL TDrawInterface : public TProtocol
{
public:
	static TDrawInterface*	New(char* implementation);		// (host glue: the ROM has none)
	void				Delete(void);

	VIRTUAL NewtonErr	Init(Rect* bounds) ENDVIRTUAL;
	VIRTUAL void		DrawPict(PicHandle picture, Rect* bounds) ENDVIRTUAL;
	VIRTUAL void		DefineStyle(RefArg fontSpec, long transferMode) ENDVIRTUAL;
	VIRTUAL long		GetTextWidth(UniChar* text) ENDVIRTUAL;
	VIRTUAL void		DrawText(UniChar* text, Point where) ENDVIRTUAL;
	VIRTUAL Boolean		GetPoint(Point* where) ENDVIRTUAL;
};


/*------------------------------------------------------------------------------
	T P i n P a d
------------------------------------------------------------------------------*/

PROTOCOL TPinPad : public TDrawInterface
{
public:
	PROTOCOL_IMPL_HEADER_MACRO(TPinPad);

	TPinPad*		New(void) { return this; }			// (the ROM's class info has no New: the default)
	void			Delete(void);
	NewtonErr		Init(Rect* bounds);
	void			DrawPict(PicHandle picture, Rect* bounds);
	void			DefineStyle(RefArg fontSpec, long transferMode);
	long			GetTextWidth(UniChar* text);
	void			DrawText(UniChar* text, Point where);
	Boolean			GetPoint(Point* where);

	NewtonErr		BeginPolling(void);
	void			EndPolling(void);

	Rect			fBounds;		// +0x10  the box, on the screen
	GrafPort		fPort;			// +0x18  the pad's port, clipped to the box
	GrafPort*		fSavedPort;		// +0x6c  the port current before, put back by Delete
	GrafPort*		fScreenPort;	// +0x70  the same: whose pixel map is blitted to the screen
	Boolean			fWasPolling;	// +0x74  whether the tablet was being polled before
	RefStruct		fGlyphFont;		// +0x78  the strikes the text is in (the ROM: a Ref; host: kept from the collector)
	StyleRecord		fStyle;			// +0x7c
	TextOptions		fOptions;		// +0x9c  (its transfer mode DefineStyle's)
};

void	RegisterPinPad(void);		// host: InitGraf's registration of TPinPad (the alert library is above QuickDraw's)

#endif	/* __PINPAD_H */
