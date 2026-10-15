/*
	File:		alert/PinPad.cpp

	Contains:	TPinPad, the ROM's TDrawInterface (PinPad.h): a box drawn
				straight onto the screen, text in the alert font's
				strikes, the pen polled.

	Reconstructed from the MP2x00 US ROM (0x00189f78-0x0018a424); each
	method cites its origin.
*/

#include "PinPad.h"
#include "AlertManager.h"		// TAlertGlyph
#include "Rects.h"
#include "Draw.h"
#include "PicPlay.h"
#include "Screen.h"
#include "TabletBuffer.h"
#include "Unicode.h"
#include "ROMConstants.h"
#include "RSSymbols.h"
#include "host/RomBugs.h"


/*------------------------------------------------------------------------------
	T D r a w I n t e r f a c e
------------------------------------------------------------------------------*/

TDrawInterface*
TDrawInterface::New(char* implementation)
{
	TDrawInterface* p = (TDrawInterface*) AllocInstanceByName("TDrawInterface", implementation);
	return p != nil ? (TDrawInterface*) p->GlueNew() : nil;
}


void
TDrawInterface::Delete(void)
{
	GlueDelete();
}


/*------------------------------------------------------------------------------
	T P i n P a d
------------------------------------------------------------------------------*/

PROTOCOL_IMPL_SOURCE_MACRO(TPinPad)
PROTOCOL_CLASSINFO(TPinPad, "TDrawInterface", "", 0, 0, nil)	// ROM 0x00388740 ClassInfo__7TPinPadSFv


// ROM 0x00189f78 Init__7TPinPadFP4Rect
// The box put the right way round and cut to the screen; the tablet
// polled, the LCD's activity blocked and the screen's drawing held over
// it; the text style the system font, 9 point, bold (and the bold strikes
// of its family); a port of the pad's own, clipped to the box.  ==> what
// BeginPolling answers: 0.
NewtonErr
TPinPad::Init(Rect* bounds)
{
	if (bounds->left > bounds->right)
	{
		short left = bounds->left;
		bounds->left = bounds->right;
		bounds->right = left;
	}
	if (bounds->bottom < bounds->top)
	{
		short top = bounds->top;
		bounds->top = bounds->bottom;
		bounds->bottom = top;
	}
	RSect(bounds, 2, bounds, &qdGlobals.fScreenBits.bounds);
	SetRect(&fBounds, bounds->left, bounds->top, bounds->right, bounds->bottom);
	NewtonErr result = BeginPolling();
	BlockLCDActivity(true);
	StartDrawing(nil, &fBounds);
	fSavedPort = GetCurrentPort();
	fScreenPort = fSavedPort;
	CreateTextStyleRecord(RefVar(Rfontsystem9bold), &fStyle);
	fGlyphFont = GetFrameSlotRef(fStyle.fFontFamily, RSSYMbolddata);
	fOptions.fTransferMode = 0;
	fOptions.fAlignment = 0;
	fOptions.fJustification = 0;
	fOptions.fWidth = 0;
	fOptions.fReserved = 0;
	fOptions.fFittedWidth = 0;
	fOptions.fScanner = nil;
	OpenPort(&fPort);
	ClipRect(&fBounds);
	return result;
}


// ROM 0x0018a0e8 Delete__7TPinPadFv
// The box erased (and shown erased), the port before put back, the LCD
// and the screen's drawing let go.
// ROM BUG (fixed): the style's ref handle (and a pattern its font spec
// made) is never let go - the instance's memory is freed with them still
// in it.  The fix disposes of them.
void
TPinPad::Delete(void)
{
	EndPolling();
	EraseRect(&fBounds);
	BlitToScreens(&fScreenPort->portBits, &fBounds, &fBounds, 0);
	SetPort(fSavedPort);
	ClosePort(&fPort);
	BlockLCDActivity(false);
	StopDrawing(nil, &fBounds);
	if (RomBugFixed())
	{
		DisposeStyleRecord(&fStyle);
		fStyle.~StyleRecord();
	}
	fGlyphFont.~RefStruct();		// (host: the RefStruct the ROM's Ref is here)
}


// ROM 0x0018a144 DrawPict__7TPinPadFPP7PictureP4Rect
// A picture drawn into the box and, what of it is on the screen, shown.
void
TPinPad::DrawPict(PicHandle picture, Rect* bounds)
{
	DrawPicture(picture, bounds, false);
	if (RSect(bounds, 2, bounds, &fScreenPort->portBits.bounds))
		BlitToScreens(&fScreenPort->portBits, bounds, bounds, 0);
}


// ROM 0x0018a1a0 DefineStyle__7TPinPadFRC6RefVarl
// The text's style from a font spec (a packed integer or a font frame),
// the transfer mode it is drawn in, and the strikes of its family for its
// face: plain, bold, italic or both.
void
TPinPad::DefineStyle(RefArg fontSpec, long transferMode)
{
	CreateTextStyleRecord(fontSpec, &fStyle);
	fOptions.fTransferMode = transferMode;
	long face;
	Ref spec = fontSpec;
	if (ISINT(spec))
		face = PackedFontFace(RVALUE(spec));
	else
		face = RINT(GetFrameSlotRef(fontSpec, RSSYMface));
	Ref strikes;
	switch (face & 3)
	{
	case 1:		strikes = RSSYMbolddata;		break;
	case 2:		strikes = RSSYMitalicdata;		break;
	case 3:		strikes = RSSYMbolditalicdata;	break;
	default:	strikes = RSSYMplaindata;		break;
	}
	fGlyphFont = GetFrameSlotRef(fStyle.fFontFamily, strikes);
}


// ROM 0x0018a27c GetTextWidth__7TPinPadFPUs
// The advances of the string's characters, from the strike of the
// style's size.
long
TPinPad::GetTextWidth(UniChar* text)
{
	TAlertGlyph glyph(RefVar(fGlyphFont), fStyle.fFontSize);
	long width = 0;
	for ( ; *text != 0; text++)
		width += glyph.GetAlertGlyphWidth(*text);
	return width;
}


// ROM 0x0018a2f0 DrawText__7TPinPadFPUs5Point
// A string drawn in the style with its baseline at the point, and the box
// shown.
void
TPinPad::DrawText(UniChar* text, Point where)
{
	StyleRecord* style = &fStyle;
	FPoint at;
	at.x = ToFixed(where.h);
	at.y = ToFixed(where.v);
	DrawTextOnce(text, Ustrlen(text), &style, nil, at, &fOptions, nil);
	BlitToScreens(&fScreenPort->portBits, &fBounds, &fBounds, 0);
}


// ROM 0x0018a36c BeginPolling__7TPinPadFv
// The tablet polled (directly, not through the tablet task), whether it
// was before kept.  ==> what SetTabletPolling leaves: 0.
NewtonErr
TPinPad::BeginPolling(void)
{
	fWasPolling = GetTabletPolling();
	SetTabletPolling(true);
	return noErr;
}


// ROM 0x0018a390 GetPoint__7TPinPadFP5Point
// The pen polled until a sample comes with it down (the pressure 7 or
// less), its point rounded to the pixel - or the pen comes up.  ==>
// whether it came up.  (AlertGetPoint is the same.)
Boolean
TPinPad::GetPoint(Point* where)
{
	long x, y;
	ULong pressure;
	Boolean penUp = false;
	while (PollTablet(&x, &y, &pressure, &penUp) != 0 || pressure > 7)
	{
		if (penUp)
			return penUp;
	}
	where->v = (short) ((ULong) (y + 0x8000) >> 16);
	where->h = (short) ((ULong) (x + 0x8000) >> 16);
	return penUp;
}


// ROM 0x0018a41c EndPolling__7TPinPadFv
void
TPinPad::EndPolling(void)
{
	SetTabletPolling(fWasPolling);
}


// What InitGraf does at 0x002e446c.  DEVIATION: called by the boot after
// InitAlertManager - QuickDraw's library is below the alert library here,
// which TPinPad's text needs.
void
RegisterPinPad(void)
{
	TPinPad::ClassInfo()->Register();
}
