/*
	File:		qd/QDLibrary.h

	Contains:	TQDLibrary, the QuickDraw library offered as a protocol to
				code outside the ROM (a driver in a package) - every
				QuickDraw call such code might want, from InitGraf to
				PutGrayTable, in the order of the ROM's dispatch table -
				and TQDLibraryDriver, the ROM's implementation, whose
				methods pass each call on to the QuickDraw function of the
				same name.

	ROM BUG (fixed in QDLibrary.cpp): the ROM's TQDLibraryDriver never
	passes anything on.  Each method calls the function by its plain name,
	and inside the class that name is the method itself, so every one of
	them calls itself: a `b` to its own address where the call was the
	last thing it did (most of them - the ARM spins there), a `bl` with
	the stack growing where it was not (CopyBits, SetRect, the text calls,
	MakeSimpleStyle and CopyStyle) until the stack runs out.  Nothing in
	the ROM registers it (ClassInfo__16TQDLibraryDriverSFv has no caller:
	InitGraf registers TPinPad and TGrayShrink only), so the ROM itself
	never meets it.

	Not in the DDK.  The interface follows the ROM's dispatch table
	(tools/newton-rom/analysis/classinfo.py --name TQDLibraryDriver: 196
	methods after New and Delete) with the parameter types of the QuickDraw
	functions the methods were meant to call, as this reconstruction
	declares them.  The ROM has no glue for the interface's methods.

	Reconstructed from the MP2x00 US ROM (0x00195818-0x00196018, class
	info 0x0038878c); each method cites its origin.
*/

#ifndef __QDLIBRARY_H
#define __QDLIBRARY_H

#include "Protocols.h"
#include "Ports.h"
#include "Regions.h"
#include "Fonts.h"
#include "Text.h"
#include "TextObject.h"
#include "PicRecord.h"
#include "Polygons.h"

struct TextWalker;		// (the ROM's; NOT YET reconstructed - the host walks a text object's characters with TTextObjectChars)


/*------------------------------------------------------------------------------
	T Q D L i b r a r y
------------------------------------------------------------------------------*/

PROTOCOL TQDLibrary : public TProtocol
{
public:
	static TQDLibrary*	New(char* implementation);		// (host glue: the ROM has none)
	void			Delete(void);

	VIRTUAL void			InitGraf(void) ENDVIRTUAL;
	VIRTUAL void			InitQD(void) ENDVIRTUAL;
	VIRTUAL void			OpenPort(GrafPort* port) ENDVIRTUAL;
	VIRTUAL void			InitPort(GrafPort* port) ENDVIRTUAL;
	VIRTUAL void			ClosePort(GrafPort* port) ENDVIRTUAL;
	VIRTUAL void			SetPort(GrafPort* port) ENDVIRTUAL;
	VIRTUAL void			GetPort(GrafPort** port) ENDVIRTUAL;
	VIRTUAL void			SetPortBits(const PixelMap* bits) ENDVIRTUAL;
	VIRTUAL void			SetOrigin(long h, long v) ENDVIRTUAL;
	VIRTUAL void			SetClip(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			GetClip(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			ClipRect(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			SetStdProcs(QDProcs* procs) ENDVIRTUAL;
	VIRTUAL void			InitPortRgns(GrafPort* port) ENDVIRTUAL;
	VIRTUAL void			HidePen(void) ENDVIRTUAL;
	VIRTUAL void			ShowPen(void) ENDVIRTUAL;
	VIRTUAL void			GetPen(Point* pt) ENDVIRTUAL;
	VIRTUAL void			GetPenState(PenState* state) ENDVIRTUAL;
	VIRTUAL void			SetPenState(const PenState* state) ENDVIRTUAL;
	VIRTUAL void			PenSize(long width, long height) ENDVIRTUAL;
	VIRTUAL void			PenMode(long mode) ENDVIRTUAL;
	VIRTUAL void			PenNormal(void) ENDVIRTUAL;
	VIRTUAL void			MoveTo(long h, long v) ENDVIRTUAL;
	VIRTUAL void			Move(long dh, long dv) ENDVIRTUAL;
	VIRTUAL void			LineTo(long h, long v) ENDVIRTUAL;
	VIRTUAL void			Line(long dh, long dv) ENDVIRTUAL;
	VIRTUAL void			InkerLine(const Point from, const Point to, Rect* damaged, const Point pen) ENDVIRTUAL;
	VIRTUAL Boolean			EmptyRect(const Rect* r) ENDVIRTUAL;
	VIRTUAL Boolean			EqualRect(const Rect* a, const Rect* b) ENDVIRTUAL;
	VIRTUAL void			EraseRect(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			FillRect(const Rect* r, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			FrameRect(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			InsetRect(Rect* r, long dh, long dv) ENDVIRTUAL;
	VIRTUAL void			InvertRect(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			MapRect(Rect* r, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL void			OffsetRect(Rect* r, long dh, long dv) ENDVIRTUAL;
	VIRTUAL void			PaintRect(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			Pt2Rect(Point a, Point b, Rect* r) ENDVIRTUAL;
	VIRTUAL Boolean			PtInRect(Point pt, const Rect* r) ENDVIRTUAL;
	VIRTUAL Boolean			SectRect(const Rect* a, const Rect* b, Rect* result) ENDVIRTUAL;
	VIRTUAL void			SetEmptyRect(Rect* r) ENDVIRTUAL;
	VIRTUAL void			SetRect(Rect* r, long left, long top, long right, long bottom) ENDVIRTUAL;
	VIRTUAL void			UnionRect(const Rect* a, const Rect* b, Rect* result) ENDVIRTUAL;
	VIRTUAL void			JoinRect(const Rect* a, const Rect* b, Rect* result) ENDVIRTUAL;
	VIRTUAL void			ZoomRect(Rect* from, Rect* to, long steps, Boolean zoomIn) ENDVIRTUAL;
	VIRTUAL void			EraseOval(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			FillOval(const Rect* r, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			FrameOval(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			InvertOval(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			PaintOval(const Rect* r) ENDVIRTUAL;
	VIRTUAL void			EraseRoundRect(const Rect* r, long ovalWidth, long ovalHeight) ENDVIRTUAL;
	VIRTUAL void			FillRoundRect(const Rect* r, long ovalWidth, long ovalHeight, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			FrameRoundRect(const Rect* r, long ovalWidth, long ovalHeight) ENDVIRTUAL;
	VIRTUAL void			InvertRoundRect(const Rect* r, long ovalWidth, long ovalHeight) ENDVIRTUAL;
	VIRTUAL void			PaintRoundRect(const Rect* r, long ovalWidth, long ovalHeight) ENDVIRTUAL;
	VIRTUAL void			EraseArc(const Rect* r, long startAngle, long arcAngle) ENDVIRTUAL;
	VIRTUAL void			FillArc(const Rect* r, long startAngle, long arcAngle, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			FrameArc(const Rect* r, long startAngle, long arcAngle) ENDVIRTUAL;
	VIRTUAL void			InvertArc(const Rect* r, long startAngle, long arcAngle) ENDVIRTUAL;
	VIRTUAL void			PaintArc(const Rect* r, long startAngle, long arcAngle) ENDVIRTUAL;
	VIRTUAL void			CloseRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL Boolean			CopyRgn(RgnHandle src, RgnHandle dst) ENDVIRTUAL;
	VIRTUAL void			DiffRgn(RgnHandle a, RgnHandle b, RgnHandle dst) ENDVIRTUAL;
	VIRTUAL void			DisposeRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL Boolean			EmptyRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL Boolean			EqualRgn(RgnHandle a, RgnHandle b) ENDVIRTUAL;
	VIRTUAL void			EraseRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			FillRgn(RgnHandle rgn, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			FrameRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			InsetRgn(RgnHandle rgn, long dh, long dv) ENDVIRTUAL;
	VIRTUAL void			InvertRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			MapRgn(RgnHandle rgn, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL RgnHandle		NewRgn(void) ENDVIRTUAL;
	VIRTUAL void			OffsetRgn(RgnHandle rgn, long dh, long dv) ENDVIRTUAL;
	VIRTUAL void			OpenRgn(void) ENDVIRTUAL;
	VIRTUAL void			PaintRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL Boolean			PtInRgn(Point pt, RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL Boolean			RectInRgn(const Rect* r, RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			RectRgn(RgnHandle rgn, const Rect* r) ENDVIRTUAL;
	VIRTUAL void			SectRgn(RgnHandle a, RgnHandle b, RgnHandle dst) ENDVIRTUAL;
	VIRTUAL void			SetEmptyRgn(RgnHandle rgn) ENDVIRTUAL;
	VIRTUAL void			SetRectRgn(RgnHandle rgn, long left, long top, long right, long bottom) ENDVIRTUAL;
	VIRTUAL void			UnionRgn(RgnHandle a, RgnHandle b, RgnHandle dst) ENDVIRTUAL;
	VIRTUAL void			XorRgn(RgnHandle a, RgnHandle b, RgnHandle dst) ENDVIRTUAL;
	VIRTUAL void			ClosePoly(void) ENDVIRTUAL;
	VIRTUAL void			ErasePoly(PolyHandle poly) ENDVIRTUAL;
	VIRTUAL void			FillPoly(PolyHandle poly, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			FramePoly(PolyHandle poly) ENDVIRTUAL;
	VIRTUAL void			KillPoly(PolyHandle poly) ENDVIRTUAL;
	VIRTUAL void			InvertPoly(PolyHandle poly) ENDVIRTUAL;
	VIRTUAL void			MapPoly(PolyHandle poly, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL void			OffsetPoly(PolyHandle poly, long dh, long dv) ENDVIRTUAL;
	VIRTUAL PolyHandle		OpenPoly(void) ENDVIRTUAL;
	VIRTUAL void			PaintPoly(PolyHandle poly) ENDVIRTUAL;
	VIRTUAL Boolean			CheckPic(void) ENDVIRTUAL;
	VIRTUAL void			ClosePicture(void) ENDVIRTUAL;
	VIRTUAL Ref				DrawPicture(PicHandle picture, Rect* dstRect, Boolean toShapes) ENDVIRTUAL;
	VIRTUAL void			KillPicture(PicHandle picture) ENDVIRTUAL;
	VIRTUAL PicHandle		OpenPicture(Rect* frame, Boolean macPicture) ENDVIRTUAL;
	VIRTUAL void			PicComment(short kind, short size, Handle data) ENDVIRTUAL;
	VIRTUAL Boolean			EqualPt(Point a, Point b) ENDVIRTUAL;
	VIRTUAL void			LocalToGlobal(Point* pt) ENDVIRTUAL;
	VIRTUAL void			MapPt(Point* pt, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL void			ScalePt(Point* pt, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL void			SetPt(Point* pt, long h, long v) ENDVIRTUAL;
	VIRTUAL void			MapFPoint(FPoint* pt, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL Ptr				GetPixelMapBits(const PixelMap* pm) ENDVIRTUAL;
	VIRTUAL Boolean			PtInPixelMap(const PixelMap* pm, long x, long y) ENDVIRTUAL;
	VIRTUAL void			CopyBits(PixelMap* src, PixelMap* dst, const Rect* srcRect, const Rect* dstRect, long mode, RgnHandle mask) ENDVIRTUAL;
	VIRTUAL void			PackBits(char** srcPtr, char** dstPtr, long count) ENDVIRTUAL;
	VIRTUAL void			ScrollRect(Rect* r, long dh, long dv, RgnHandle updateRgn) ENDVIRTUAL;
	VIRTUAL void			UnpackBits(char** src, char** dst, long count) ENDVIRTUAL;
	VIRTUAL void			UnpackWords(char** src, char** dst, long count) ENDVIRTUAL;
	VIRTUAL long			GetRandSeed(void) ENDVIRTUAL;
	VIRTUAL long			Random(void) ENDVIRTUAL;
	VIRTUAL void			SetRandSeed(long seed) ENDVIRTUAL;
	VIRTUAL void			FrameCurve(curve* c) ENDVIRTUAL;
	VIRTUAL void			PaintCurve(curve* c) ENDVIRTUAL;
	VIRTUAL void			EraseCurve(curve* c) ENDVIRTUAL;
	VIRTUAL void			InvertCurve(curve* c) ENDVIRTUAL;
	VIRTUAL void			FillCurve(curve* c, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			SetCurve(curve* c, FPoint first, FPoint control, FPoint last) ENDVIRTUAL;
	VIRTUAL void			OffsetCurve(curve* c, Fixed dh, Fixed dv) ENDVIRTUAL;
	VIRTUAL Boolean			EqualCurve(const curve* a, const curve* b) ENDVIRTUAL;
	VIRTUAL void			GetCurveBounds(const curve* c, Rect* bounds) ENDVIRTUAL;
	VIRTUAL void			ScaleCurve(curve* c, Fixed hScale, Fixed vScale) ENDVIRTUAL;
	VIRTUAL void			MapCurve(curve* c, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL void			FramePaths(pathsHandle p) ENDVIRTUAL;
	VIRTUAL void			PaintPaths(pathsHandle p) ENDVIRTUAL;
	VIRTUAL void			ErasePaths(pathsHandle p) ENDVIRTUAL;
	VIRTUAL void			InvertPaths(pathsHandle p) ENDVIRTUAL;
	VIRTUAL void			FillPaths(pathsHandle p, PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			OffsetPaths(pathsHandle p, Fixed dh, Fixed dv) ENDVIRTUAL;
	VIRTUAL void			DisposePaths(pathsHandle p) ENDVIRTUAL;
	VIRTUAL void			MapPaths(pathsHandle p, const Rect* src, const Rect* dst) ENDVIRTUAL;
	VIRTUAL void			ScalePaths(pathsHandle p, Fixed hScale, Fixed vScale) ENDVIRTUAL;
	VIRTUAL void			CopyPaths(pathsHandle src, pathsHandle dst) ENDVIRTUAL;
	VIRTUAL long			SizeOfPaths(pathsHandle p) ENDVIRTUAL;
	VIRTUAL void			GetPathsBounds(pathsHandle p, Rect* bounds) ENDVIRTUAL;
	VIRTUAL void			InitPathWalker(pathWalker* walker, path* contour) ENDVIRTUAL;
	VIRTUAL path*			NextPath(path* contour) ENDVIRTUAL;
	VIRTUAL Boolean			NextPathSegment(pathWalker* walker) ENDVIRTUAL;
	VIRTUAL void			DisposePattern(PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			DisposeFgPattern(void) ENDVIRTUAL;
	VIRTUAL void			SetFgPattern(PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL void			SetBgPattern(PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL PatternHandle	GetFgPattern(void) ENDVIRTUAL;
	VIRTUAL PatternHandle	GetBgPattern(void) ENDVIRTUAL;
	VIRTUAL PatternHandle	MakeSimplePattern(long row0, long row1, long row2, long row3, long row4, long row5, long row6, long row7) ENDVIRTUAL;
	VIRTUAL PatternHandle	MakeSimplePattern(const char* rows) ENDVIRTUAL;
	VIRTUAL PatternHandle	GetStdPattern(UChar which) ENDVIRTUAL;
	VIRTUAL PatternHandle	CopyPattern(PatternHandle pattern) ENDVIRTUAL;
	VIRTUAL Boolean			EqualPat(PatternHandle a, PatternHandle b) ENDVIRTUAL;
	VIRTUAL Boolean			MonochromePat(PatternHandle pattern, ULong* gray) ENDVIRTUAL;
	VIRTUAL StyleRecord		MakeSimpleStyle(RefArg fontFamily, long size, long face) ENDVIRTUAL;
	VIRTUAL Boolean			EqualStyle(const StyleRecord* a, const StyleRecord* b) ENDVIRTUAL;
	VIRTUAL StyleRecord		CopyStyle(StyleRecord* style) ENDVIRTUAL;
	VIRTUAL void			FlushFontCache(void) ENDVIRTUAL;
	VIRTUAL TextObjectRef	NewText(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint location, TextOptions* options) ENDVIRTUAL;
	VIRTUAL void			DrawTextObj(TextObjectRef text) ENDVIRTUAL;
	VIRTUAL void			DisposeText(TextObjectRef text) ENDVIRTUAL;
	VIRTUAL void			DrawTextOnce(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint where, TextOptions* options, TextBoundsInfo* bounds) ENDVIRTUAL;
	VIRTUAL void			MeasureTextOnce(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint where, TextOptions* options, TextBoundsInfo* bounds) ENDVIRTUAL;
	VIRTUAL void			DrawRichString(TRichString& rich, ULong start, long length, StyleRecord* style, FPoint where, TextOptions* options, TextBoundsInfo* bounds) ENDVIRTUAL;
	VIRTUAL long			MeasureRichString(TRichString& rich, ULong start, long length, StyleRecord* style, FPoint where, TextOptions* options, TextBoundsInfo* bounds) ENDVIRTUAL;
	VIRTUAL void			GetTextObjField(TextObjectRef text, int field, void* result) ENDVIRTUAL;
	VIRTUAL Boolean			SetTextObjField(TextObjectRef text, int field, void* value) ENDVIRTUAL;
	VIRTUAL void			CharToPoint(TextObjectRef text, long offset, FPoint* point) ENDVIRTUAL;
	VIRTUAL long			PointToChar(TextObjectRef text, FPoint point) ENDVIRTUAL;
	VIRTUAL long			TextArrowOffset(TextObjectRef text, long offset, Boolean forward) ENDVIRTUAL;
	VIRTUAL void			InitTextWalker(TextObjectRef text, TextWalker* walker, Boolean forDrawing) ENDVIRTUAL;
	VIRTUAL void			ReleaseTextWalker(TextWalker* walker) ENDVIRTUAL;
	VIRTUAL void			ScanNextChunk(long* count, void** chars, TextWalker* walker, long** widths) ENDVIRTUAL;
	VIRTUAL long			GetGrafInfo(long selector, void* info) ENDVIRTUAL;
	VIRTUAL void			SetGrafInfo(long selector, long value) ENDVIRTUAL;
	VIRTUAL void			InitScreen(void) ENDVIRTUAL;
	VIRTUAL void			LCDPowerInit(UChar wasAsleep) ENDVIRTUAL;
	VIRTUAL void			LCDPowerOn(UChar wasAsleep) ENDVIRTUAL;
	VIRTUAL void			LCDPowerOff(UChar toSleep) ENDVIRTUAL;
	VIRTUAL void			LCDEnterIdleMode(void) ENDVIRTUAL;
	VIRTUAL void			LCDExitIdleMode(void) ENDVIRTUAL;
	VIRTUAL void			StartDrawing(PixelMap* map, Rect* r) ENDVIRTUAL;
	VIRTUAL void			StopDrawing(PixelMap* map, Rect* r) ENDVIRTUAL;
	VIRTUAL void			ReleaseScreenLock(void) ENDVIRTUAL;
	VIRTUAL long			PtInCPixelMap(const PixelMap* pm, long x, long y) ENDVIRTUAL;
	VIRTUAL long			PtInMask(const PixelMap* pm, long x, long y) ENDVIRTUAL;
	VIRTUAL ULong			RGBtoGray(ULong red, ULong green, ULong blue, long depthIn, long depthOut) ENDVIRTUAL;
	VIRTUAL void			GrayToRGB(UChar gray, ULong* red, ULong* green, ULong* blue, long depth) ENDVIRTUAL;
	VIRTUAL ULong			PackRGBvalues(ULong red, ULong green, ULong blue) ENDVIRTUAL;
	VIRTUAL void			UnpackRGBvalues(ULong colour, ULong* red, ULong* green, ULong* blue) ENDVIRTUAL;
	VIRTUAL PatternHandle	GetStdGrayPattern(ULong red, ULong green, ULong blue) ENDVIRTUAL;
	VIRTUAL PatternHandle	MakeGrayPattern(RefArg spec) ENDVIRTUAL;
	VIRTUAL PatternHandle	MakeSimpleGrayPattern(long* rows, ULong fg, ULong bg) ENDVIRTUAL;
	VIRTUAL void			PutPixMap(PixelMap* pm) ENDVIRTUAL;
	VIRTUAL void			PutColorTable(long depth) ENDVIRTUAL;
	VIRTUAL void			PutGrayTable(PixelMap* pm) ENDVIRTUAL;
};


/*------------------------------------------------------------------------------
	T Q D L i b r a r y D r i v e r
	Nothing of its own: 0x10 bytes, the TProtocol.
------------------------------------------------------------------------------*/

PROTOCOL TQDLibraryDriver : public TQDLibrary
{
public:
	PROTOCOL_IMPL_HEADER_MACRO(TQDLibraryDriver);

	TQDLibraryDriver*	New(void);
	void			Delete(void);

	void					InitGraf(void);
	void					InitQD(void);
	void					OpenPort(GrafPort* port);
	void					InitPort(GrafPort* port);
	void					ClosePort(GrafPort* port);
	void					SetPort(GrafPort* port);
	void					GetPort(GrafPort** port);
	void					SetPortBits(const PixelMap* bits);
	void					SetOrigin(long h, long v);
	void					SetClip(RgnHandle rgn);
	void					GetClip(RgnHandle rgn);
	void					ClipRect(const Rect* r);
	void					SetStdProcs(QDProcs* procs);
	void					InitPortRgns(GrafPort* port);
	void					HidePen(void);
	void					ShowPen(void);
	void					GetPen(Point* pt);
	void					GetPenState(PenState* state);
	void					SetPenState(const PenState* state);
	void					PenSize(long width, long height);
	void					PenMode(long mode);
	void					PenNormal(void);
	void					MoveTo(long h, long v);
	void					Move(long dh, long dv);
	void					LineTo(long h, long v);
	void					Line(long dh, long dv);
	void					InkerLine(const Point from, const Point to, Rect* damaged, const Point pen);
	Boolean					EmptyRect(const Rect* r);
	Boolean					EqualRect(const Rect* a, const Rect* b);
	void					EraseRect(const Rect* r);
	void					FillRect(const Rect* r, PatternHandle pattern);
	void					FrameRect(const Rect* r);
	void					InsetRect(Rect* r, long dh, long dv);
	void					InvertRect(const Rect* r);
	void					MapRect(Rect* r, const Rect* src, const Rect* dst);
	void					OffsetRect(Rect* r, long dh, long dv);
	void					PaintRect(const Rect* r);
	void					Pt2Rect(Point a, Point b, Rect* r);
	Boolean					PtInRect(Point pt, const Rect* r);
	Boolean					SectRect(const Rect* a, const Rect* b, Rect* result);
	void					SetEmptyRect(Rect* r);
	void					SetRect(Rect* r, long left, long top, long right, long bottom);
	void					UnionRect(const Rect* a, const Rect* b, Rect* result);
	void					JoinRect(const Rect* a, const Rect* b, Rect* result);
	void					ZoomRect(Rect* from, Rect* to, long steps, Boolean zoomIn);
	void					EraseOval(const Rect* r);
	void					FillOval(const Rect* r, PatternHandle pattern);
	void					FrameOval(const Rect* r);
	void					InvertOval(const Rect* r);
	void					PaintOval(const Rect* r);
	void					EraseRoundRect(const Rect* r, long ovalWidth, long ovalHeight);
	void					FillRoundRect(const Rect* r, long ovalWidth, long ovalHeight, PatternHandle pattern);
	void					FrameRoundRect(const Rect* r, long ovalWidth, long ovalHeight);
	void					InvertRoundRect(const Rect* r, long ovalWidth, long ovalHeight);
	void					PaintRoundRect(const Rect* r, long ovalWidth, long ovalHeight);
	void					EraseArc(const Rect* r, long startAngle, long arcAngle);
	void					FillArc(const Rect* r, long startAngle, long arcAngle, PatternHandle pattern);
	void					FrameArc(const Rect* r, long startAngle, long arcAngle);
	void					InvertArc(const Rect* r, long startAngle, long arcAngle);
	void					PaintArc(const Rect* r, long startAngle, long arcAngle);
	void					CloseRgn(RgnHandle rgn);
	Boolean					CopyRgn(RgnHandle src, RgnHandle dst);
	void					DiffRgn(RgnHandle a, RgnHandle b, RgnHandle dst);
	void					DisposeRgn(RgnHandle rgn);
	Boolean					EmptyRgn(RgnHandle rgn);
	Boolean					EqualRgn(RgnHandle a, RgnHandle b);
	void					EraseRgn(RgnHandle rgn);
	void					FillRgn(RgnHandle rgn, PatternHandle pattern);
	void					FrameRgn(RgnHandle rgn);
	void					InsetRgn(RgnHandle rgn, long dh, long dv);
	void					InvertRgn(RgnHandle rgn);
	void					MapRgn(RgnHandle rgn, const Rect* src, const Rect* dst);
	RgnHandle				NewRgn(void);
	void					OffsetRgn(RgnHandle rgn, long dh, long dv);
	void					OpenRgn(void);
	void					PaintRgn(RgnHandle rgn);
	Boolean					PtInRgn(Point pt, RgnHandle rgn);
	Boolean					RectInRgn(const Rect* r, RgnHandle rgn);
	void					RectRgn(RgnHandle rgn, const Rect* r);
	void					SectRgn(RgnHandle a, RgnHandle b, RgnHandle dst);
	void					SetEmptyRgn(RgnHandle rgn);
	void					SetRectRgn(RgnHandle rgn, long left, long top, long right, long bottom);
	void					UnionRgn(RgnHandle a, RgnHandle b, RgnHandle dst);
	void					XorRgn(RgnHandle a, RgnHandle b, RgnHandle dst);
	void					ClosePoly(void);
	void					ErasePoly(PolyHandle poly);
	void					FillPoly(PolyHandle poly, PatternHandle pattern);
	void					FramePoly(PolyHandle poly);
	void					KillPoly(PolyHandle poly);
	void					InvertPoly(PolyHandle poly);
	void					MapPoly(PolyHandle poly, const Rect* src, const Rect* dst);
	void					OffsetPoly(PolyHandle poly, long dh, long dv);
	PolyHandle				OpenPoly(void);
	void					PaintPoly(PolyHandle poly);
	Boolean					CheckPic(void);
	void					ClosePicture(void);
	Ref						DrawPicture(PicHandle picture, Rect* dstRect, Boolean toShapes);
	void					KillPicture(PicHandle picture);
	PicHandle				OpenPicture(Rect* frame, Boolean macPicture);
	void					PicComment(short kind, short size, Handle data);
	Boolean					EqualPt(Point a, Point b);
	void					LocalToGlobal(Point* pt);
	void					MapPt(Point* pt, const Rect* src, const Rect* dst);
	void					ScalePt(Point* pt, const Rect* src, const Rect* dst);
	void					SetPt(Point* pt, long h, long v);
	void					MapFPoint(FPoint* pt, const Rect* src, const Rect* dst);
	Ptr						GetPixelMapBits(const PixelMap* pm);
	Boolean					PtInPixelMap(const PixelMap* pm, long x, long y);
	void					CopyBits(PixelMap* src, PixelMap* dst, const Rect* srcRect, const Rect* dstRect, long mode, RgnHandle mask);
	void					PackBits(char** srcPtr, char** dstPtr, long count);
	void					ScrollRect(Rect* r, long dh, long dv, RgnHandle updateRgn);
	void					UnpackBits(char** src, char** dst, long count);
	void					UnpackWords(char** src, char** dst, long count);
	long					GetRandSeed(void);
	long					Random(void);
	void					SetRandSeed(long seed);
	void					FrameCurve(curve* c);
	void					PaintCurve(curve* c);
	void					EraseCurve(curve* c);
	void					InvertCurve(curve* c);
	void					FillCurve(curve* c, PatternHandle pattern);
	void					SetCurve(curve* c, FPoint first, FPoint control, FPoint last);
	void					OffsetCurve(curve* c, Fixed dh, Fixed dv);
	Boolean					EqualCurve(const curve* a, const curve* b);
	void					GetCurveBounds(const curve* c, Rect* bounds);
	void					ScaleCurve(curve* c, Fixed hScale, Fixed vScale);
	void					MapCurve(curve* c, const Rect* src, const Rect* dst);
	void					FramePaths(pathsHandle p);
	void					PaintPaths(pathsHandle p);
	void					ErasePaths(pathsHandle p);
	void					InvertPaths(pathsHandle p);
	void					FillPaths(pathsHandle p, PatternHandle pattern);
	void					OffsetPaths(pathsHandle p, Fixed dh, Fixed dv);
	void					DisposePaths(pathsHandle p);
	void					MapPaths(pathsHandle p, const Rect* src, const Rect* dst);
	void					ScalePaths(pathsHandle p, Fixed hScale, Fixed vScale);
	void					CopyPaths(pathsHandle src, pathsHandle dst);
	long					SizeOfPaths(pathsHandle p);
	void					GetPathsBounds(pathsHandle p, Rect* bounds);
	void					InitPathWalker(pathWalker* walker, path* contour);
	path*					NextPath(path* contour);
	Boolean					NextPathSegment(pathWalker* walker);
	void					DisposePattern(PatternHandle pattern);
	void					DisposeFgPattern(void);
	void					SetFgPattern(PatternHandle pattern);
	void					SetBgPattern(PatternHandle pattern);
	PatternHandle			GetFgPattern(void);
	PatternHandle			GetBgPattern(void);
	PatternHandle			MakeSimplePattern(long row0, long row1, long row2, long row3, long row4, long row5, long row6, long row7);
	PatternHandle			MakeSimplePattern(const char* rows);
	PatternHandle			GetStdPattern(UChar which);
	PatternHandle			CopyPattern(PatternHandle pattern);
	Boolean					EqualPat(PatternHandle a, PatternHandle b);
	Boolean					MonochromePat(PatternHandle pattern, ULong* gray);
	StyleRecord				MakeSimpleStyle(RefArg fontFamily, long size, long face);
	Boolean					EqualStyle(const StyleRecord* a, const StyleRecord* b);
	StyleRecord				CopyStyle(StyleRecord* style);
	void					FlushFontCache(void);
	TextObjectRef			NewText(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint location, TextOptions* options);
	void					DrawTextObj(TextObjectRef text);
	void					DisposeText(TextObjectRef text);
	void					DrawTextOnce(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint where, TextOptions* options, TextBoundsInfo* bounds);
	void					MeasureTextOnce(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint where, TextOptions* options, TextBoundsInfo* bounds);
	void					DrawRichString(TRichString& rich, ULong start, long length, StyleRecord* style, FPoint where, TextOptions* options, TextBoundsInfo* bounds);
	long					MeasureRichString(TRichString& rich, ULong start, long length, StyleRecord* style, FPoint where, TextOptions* options, TextBoundsInfo* bounds);
	void					GetTextObjField(TextObjectRef text, int field, void* result);
	Boolean					SetTextObjField(TextObjectRef text, int field, void* value);
	void					CharToPoint(TextObjectRef text, long offset, FPoint* point);
	long					PointToChar(TextObjectRef text, FPoint point);
	long					TextArrowOffset(TextObjectRef text, long offset, Boolean forward);
	void					InitTextWalker(TextObjectRef text, TextWalker* walker, Boolean forDrawing);
	void					ReleaseTextWalker(TextWalker* walker);
	void					ScanNextChunk(long* count, void** chars, TextWalker* walker, long** widths);
	long					GetGrafInfo(long selector, void* info);
	void					SetGrafInfo(long selector, long value);
	void					InitScreen(void);
	void					LCDPowerInit(UChar wasAsleep);
	void					LCDPowerOn(UChar wasAsleep);
	void					LCDPowerOff(UChar toSleep);
	void					LCDEnterIdleMode(void);
	void					LCDExitIdleMode(void);
	void					StartDrawing(PixelMap* map, Rect* r);
	void					StopDrawing(PixelMap* map, Rect* r);
	void					ReleaseScreenLock(void);
	long					PtInCPixelMap(const PixelMap* pm, long x, long y);
	long					PtInMask(const PixelMap* pm, long x, long y);
	ULong					RGBtoGray(ULong red, ULong green, ULong blue, long depthIn, long depthOut);
	void					GrayToRGB(UChar gray, ULong* red, ULong* green, ULong* blue, long depth);
	ULong					PackRGBvalues(ULong red, ULong green, ULong blue);
	void					UnpackRGBvalues(ULong colour, ULong* red, ULong* green, ULong* blue);
	PatternHandle			GetStdGrayPattern(ULong red, ULong green, ULong blue);
	PatternHandle			MakeGrayPattern(RefArg spec);
	PatternHandle			MakeSimpleGrayPattern(long* rows, ULong fg, ULong bg);
	void					PutPixMap(PixelMap* pm);
	void					PutColorTable(long depth);
	void					PutGrayTable(PixelMap* pm);
};

#endif	/* __QDLIBRARY_H */
