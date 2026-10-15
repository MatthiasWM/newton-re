// TPinPad (alert/PinPad.h), the ROM's TDrawInterface, made from its class
// info over a host display: the box put the right way round and cut to the
// screen, the tablet polled while it is up, text measured in the alert
// font's strikes and drawn and shown, the pen's point read off a polled
// sample, and everything put back by Delete.
#include "PinPad.h"
#include "Rects.h"
#include "Draw.h"
#include "Screen.h"
#include "Fonts.h"
#include "TabletBuffer.h"
#include "HostScreen.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "ROMImport.h"
#include "ROMConstants.h"
#include "RSSymbols.h"
#include "NewtonExceptions.h"
#include "memory/host/KernelHeap.h"
#include "host/RomBugs.h"

#include <stdio.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)


static long
InkIn(THostScreenDriver* display, const Rect& r)
{
	long n = 0;
	for (long y = r.top; y < r.bottom; y++)
		for (long x = r.left; x < r.right; x++)
			n += display->Gray(x, y) != 0;
	return n;
}


static void
TestPinPad(THostScreenDriver* display)
{
	GrafPort* before = GetCurrentPort();
	const TClassInfo* info = TPinPad::ClassInfo();
	EXPECT(strcmp(info->fName, "TPinPad") == 0 && strcmp(info->fInterface, "TDrawInterface") == 0);
	alignas(TPinPad) char memory[sizeof(TPinPad)];
	TPinPad* pad = (TPinPad*) info->fMakeAt(memory);
	TDrawInterface* draw = pad->New();

	// the box the wrong way round, and off the screen's right edge
	Rect box;
	box.left = 90;  box.right = 4;
	box.top = 40;   box.bottom = 10;
	SetTabletPolling(false);
	EXPECT(draw->Init(&box) == noErr);
	EXPECT(pad->fBounds.left == 4 && pad->fBounds.right == 64 && pad->fBounds.top == 10 && pad->fBounds.bottom == 40);
	EXPECT(box.left == 4 && box.right == 64);
	EXPECT(TBCGetTabletPolling() && !pad->fWasPolling);
	EXPECT(GetCurrentPort() == &pad->fPort && pad->fSavedPort == before);

	// text: measured in the strikes, drawn into the box and shown
	UniChar text[] = { '1', '2', '3', 0 };
	long width = draw->GetTextWidth(text);
	UniChar one[] = { '1', 0 };
	EXPECT(draw->GetTextWidth(one) > 0 && width > draw->GetTextWidth(one));
	EXPECT(InkIn(display, pad->fBounds) == 0);
	Point at;
	at.h = 8;
	at.v = 30;
	ULong blits = display->fBlits;
	draw->DrawText(text, at);
	EXPECT(display->fBlits > blits && InkIn(display, pad->fBounds) > 0);
	draw->DefineStyle(RefVar(MAKEINT(PackFont(0, 9, 0))), 0);		// plain
	EXPECT(draw->GetTextWidth(text) > 0);

	// the pen's point, off a sample taken while polling (x and y the
	// sample's top 11 and next 11 bits, the pressure its bottom 4)
	TBCInsertTabletSample((20UL << 21) | (25UL << 7), 0);
	Point pt;
	EXPECT(!draw->GetPoint(&pt));
	EXPECT(pt.h == 20 && pt.v == 25);
	TBCInsertTabletSample(kTabletPenUp, 0);
	EXPECT(draw->GetPoint(&pt));

	// put away: the box erased and shown, the port and the polling put back
	pad->Delete();			// (the implementation's: the interface's would free the instance too)
	EXPECT(InkIn(display, pad->fBounds) == 0);
	EXPECT(GetCurrentPort() == before && !TBCGetTabletPolling());
}


int
main()
{
	InitHostStandaloneHeap();
	if (ImportROMObjectsFromFile(NEWTON_OBJECTS) != noErr)
	{
		printf("test_PinPad: cannot import %s\n", NEWTON_OBJECTS);
		return 1;
	}
	gObjectHeapSize = 0x100000;
	InitObjects();
	InitGraf();
	InitFonts();
	// vars.fonts: the ROM's font families by their symbols (what a font
	// spec's family is looked up in)
	SetFrameSlot(RefVar(gVarFrame), RSSYMvars, RefVar(gVarFrame));
	RefVar fonts(AllocateFrame());
	RefVar list(Rromfontlist);
	for (long i = 0; i < Length(list); i++)
		SetFrameSlot(fonts, RefVar(FamilyNumToSym(i)), RefVar(GetArraySlotRef(list, i)));
	SetFrameSlot(RefVar(gVarFrame), RSSYMfonts, fonts);
	SetFrameSlot(RefVar(gVarFrame), RSSYMuserconfiguration, RefVar(AllocateFrame()));
	THostScreenDriver* display = new THostScreenDriver;
	display->New();
	display->Configure(64, 48, 1, 100);
	InitScreen(display);
	newton_try
	{
		TestPinPad(display);
	}
	newton_catch_all
	{
		failures++;
		fprintf(stderr, "FAIL: unhandled exception %s\n", _info.exception.name);
	}
	end_try;
	if (failures == 0)
		printf("test_PinPad: all passed\n");
	else
		printf("test_PinPad: %d failures\n", failures);
	return failures == 0 ? 0 : 1;
}
