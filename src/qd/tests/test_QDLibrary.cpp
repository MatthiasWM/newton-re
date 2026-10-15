// The QuickDraw library protocol (qd/QDLibrary.h): TQDLibraryDriver made
// from its class info and called through the TQDLibrary interface - the
// rectangles, regions, points, random numbers, colours, patterns, styles
// and drawing into a port - each answer checked against the QuickDraw
// function the method passes the call on to.  With the ROM's bug fixed
// only: the ROM's methods call themselves (NEWTON_ROM_BUGS=1 would never
// come back), so the test fixes it whatever the environment says.
#include "QDLibrary.h"
#include "Rects.h"
#include "Regions.h"
#include "Draw.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "ROMImport.h"
#include "NewtonExceptions.h"
#include "memory/host/KernelHeap.h"
#include "host/RomBugs.h"

#include <stdio.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)

const long kWidth = 64;
const long kHeight = 32;
static unsigned char gBits[kWidth * kHeight / 8];
static PixelMap gMap;
static GrafPort gPort;


static long
BitsSet(void)
{
	long n = 0;
	for (size_t i = 0; i < sizeof(gBits); i++)
		for (int b = 0; b < 8; b++)
			n += (gBits[i] >> b) & 1;
	return n;
}


static void
TestQDLibrary(void)
{
	SetRomBugFixed(true);
	const TClassInfo* info = TQDLibraryDriver::ClassInfo();
	EXPECT(strcmp(info->fName, "TQDLibraryDriver") == 0 && strcmp(info->fInterface, "TQDLibrary") == 0);
	alignas(TQDLibraryDriver) char memory[sizeof(TQDLibraryDriver)];
	TQDLibraryDriver* driver = (TQDLibraryDriver*) info->fMakeAt(memory);
	TQDLibrary* lib = driver->New();
	EXPECT(lib == driver);

	// rectangles and points
	Rect r;
	lib->SetRect(&r, 4, 2, 30, 20);
	EXPECT(r.left == 4 && r.top == 2 && r.right == 30 && r.bottom == 20);
	lib->InsetRect(&r, 1, 1);
	EXPECT(r.left == 5 && r.bottom == 19 && !lib->EmptyRect(&r));
	Point p;
	lib->SetPt(&p, 6, 7);
	EXPECT(p.h == 6 && p.v == 7 && lib->PtInRect(p, &r) && lib->EqualPt(p, p));
	Rect other, both;
	lib->SetRect(&other, 20, 10, 40, 30);
	EXPECT(lib->SectRect(&r, &other, &both) && both.left == 20 && both.bottom == 19);
	lib->UnionRect(&r, &other, &both);
	EXPECT(both.left == 5 && both.right == 40 && both.top == 3 && both.bottom == 30);
	lib->OffsetRect(&both, -5, -3);
	EXPECT(both.left == 0 && both.top == 0);

	// regions
	RgnHandle rgn = lib->NewRgn();
	lib->SetRectRgn(rgn, 0, 0, 10, 10);
	EXPECT(lib->PtInRgn(p, rgn) && !lib->EmptyRgn(rgn));
	lib->OffsetRgn(rgn, 20, 0);
	EXPECT(!lib->PtInRgn(p, rgn));
	RgnHandle copy = lib->NewRgn();
	lib->CopyRgn(rgn, copy);
	EXPECT(lib->EqualRgn(rgn, copy));
	lib->SetEmptyRgn(copy);
	EXPECT(lib->EmptyRgn(copy));
	lib->DisposeRgn(copy);
	lib->DisposeRgn(rgn);

	// random numbers, colours
	lib->SetRandSeed(1);
	long first = lib->Random();
	EXPECT(lib->GetRandSeed() != 1);
	lib->SetRandSeed(1);
	EXPECT(lib->Random() == first);
	ULong red, green, blue;
	lib->UnpackRGBvalues(lib->PackRGBvalues(0x1000, 0x2000, 0x3000), &red, &green, &blue);
	EXPECT(red == 0x1010 && green == 0x2020 && blue == 0x3030);
	EXPECT(lib->RGBtoGray(0, 0, 0, 8, 4) == RGBtoGray(0, 0, 0, 8, 4));

	// patterns and styles
	PatternHandle pattern = lib->MakeSimplePattern(1, 2, 3, 4, 5, 6, 7, 8);
	EXPECT(pattern != nil && lib->EqualPat(pattern, pattern) && ((unsigned char*) lib->GetPixelMapBits(*pattern))[7] == 8);
	lib->DisposePattern(pattern);
	EXPECT(lib->GetStdPattern(blackPat) == GetStdPattern(blackPat));
	StyleRecord style = lib->MakeSimpleStyle(RefVar(MAKEINT(3)), 12 << 16, 1);
	EXPECT((Ref) style.fFontFamily == MAKEINT(3) && style.fFontSize == (12 << 16) && style.fFontFace == 1 && style.fPattern == nil);
	style.fTransferMode = 5;
	style.fPattern = GetStdPattern(grayPat);
	StyleRecord copied = lib->CopyStyle(&style);
	EXPECT(lib->EqualStyle(&copied, &style) && copied.fPattern == nil);

	// drawing into the port
	memset(gBits, 0, sizeof(gBits));
	lib->SetRect(&r, 8, 8, 16, 16);
	lib->PaintRect(&r);
	EXPECT(BitsSet() == 64);
	lib->FillRoundRect(&r, 4, 4, GetStdPattern(whitePat));
	EXPECT(BitsSet() < 64 && BitsSet() > 0);
	lib->EraseRect(&gMap.bounds);
	EXPECT(BitsSet() == 0);
	lib->FillArc(&r, 0, 90, GetStdPattern(blackPat));
	EXPECT(BitsSet() > 0);
	lib->EraseRect(&gMap.bounds);
	lib->PaintRect(&r);
	Rect to;
	lib->SetRect(&to, 40, 8, 48, 16);
	lib->CopyBits(&gMap, &gMap, &r, &to, srcCopy, nil);
	EXPECT(BitsSet() == 128);
	RgnHandle update = lib->NewRgn();
	Rect all = gMap.bounds;
	lib->ScrollRect(&all, 0, 8, update);
	EXPECT(BitsSet() == 128 && !lib->EmptyRgn(update));
	lib->DisposeRgn(update);
	lib->EraseRect(&gMap.bounds);
	lib->MoveTo(0, 0);
	lib->LineTo(7, 0);
	EXPECT(BitsSet() == 8);
	Point pen;
	lib->GetPen(&pen);
	EXPECT(pen.h == 7 && pen.v == 0);

	// what the host cannot pass on: nothing to call, or the text walker
	lib->InitQD();
	lib->LCDEnterIdleMode();
	lib->LCDExitIdleMode();
	long count = -1;
	void* chars = &count;
	lib->ScanNextChunk(&count, &chars, nil, nil);
	EXPECT(count == 0 && chars == nil);
	driver->Delete();
}


int
main()
{
	InitHostStandaloneHeap();
	if (ImportROMObjectsFromFile(NEWTON_OBJECTS) != noErr)
	{
		printf("test_QDLibrary: cannot import %s\n", NEWTON_OBJECTS);
		return 1;
	}
	gObjectHeapSize = 0x100000;
	InitObjects();
	InitGraf();
	gMap.baseAddr = (Ptr) gBits;
	gMap.rowBytes = kWidth / 8;
	SetRect(&gMap.bounds, 0, 0, kWidth, kHeight);
	gMap.pixMapFlags = kPixMapPtr | 1;
	gMap.deviceRes.v = kDefaultDPI;
	gMap.deviceRes.h = kDefaultDPI;
	gMap.grayTable = nil;
	OpenPort(&gPort);
	SetPortBits(&gMap);
	gPort.portRect = gMap.bounds;
	RectRgn(gPort.visRgn, &gMap.bounds);
	RectRgn(gPort.clipRgn, &gMap.bounds);
	newton_try
	{
		TestQDLibrary();
	}
	newton_catch_all
	{
		failures++;
		printf("test_QDLibrary: an exception\n");
	}
	end_try;
	if (failures == 0)
		printf("test_QDLibrary: all passed\n");
	else
		printf("test_QDLibrary: %d failures\n", failures);
	return failures == 0 ? 0 : 1;
}
