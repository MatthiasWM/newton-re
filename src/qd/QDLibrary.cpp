/*
	File:		qd/QDLibrary.cpp

	Contains:	TQDLibraryDriver, the ROM's implementation of the QuickDraw
				library protocol (QDLibrary.h): each method passes the
				call on to the QuickDraw function of the same name.

	ROM BUG (fixed): every method of the ROM's calls itself instead, and
	never returns (QDLibrary.h).  The fix passes the call on, as the
	method's name says it should; NEWTON_ROM_BUGS=1 brings the ROM's
	methods back - a call through the protocol then recurses until the
	host's stack runs out, as the ROM's spins or runs out of stack.

	Reconstructed from the MP2x00 US ROM (0x00195818-0x00196018); each
	method cites its origin.
*/

#include "QDLibrary.h"
#include "Rects.h"
#include "Draw.h"
#include "Shapes.h"
#include "Curves.h"
#include "Paths.h"
#include "PicPlay.h"
#include "LocalToGlobal.h"
#include "ScrollRect.h"
#include "Screen.h"
#include "host/RomBugs.h"

void	ZoomRect(Rect* from, Rect* to, long steps, Boolean zoomIn);	// (ZoomRect.cpp)

// The ROM's method is the same line without the `::`: the method itself.
#define QD_LIBRARY_CALL(call)	return RomBugFixed() ? ::call : call


/*------------------------------------------------------------------------------
	T Q D L i b r a r y
------------------------------------------------------------------------------*/

TQDLibrary*
TQDLibrary::New(char* implementation)
{
	TQDLibrary* p = (TQDLibrary*) AllocInstanceByName("TQDLibrary", implementation);
	return p != nil ? (TQDLibrary*) p->GlueNew() : nil;
}


void
TQDLibrary::Delete(void)
{
	GlueDelete();
}


/*------------------------------------------------------------------------------
	T Q D L i b r a r y D r i v e r
------------------------------------------------------------------------------*/

PROTOCOL_IMPL_SOURCE_MACRO(TQDLibraryDriver)	// ROM 0x00195810 Sizeof__16TQDLibraryDriverSFv
PROTOCOL_CLASSINFO(TQDLibraryDriver, "TQDLibrary", "", 0, 0, nil)	// ROM 0x003887c8 ClassInfo__16TQDLibraryDriverSFv


// ROM 0x00195818 New__16TQDLibraryDriverFv
TQDLibraryDriver*
TQDLibraryDriver::New(void)
{
	return this;
}


// ROM 0x00195de0 Delete__16TQDLibraryDriverFv
void
TQDLibraryDriver::Delete(void)
{ }


// ROM 0x00195e2c InitGraf__16TQDLibraryDriverFv
void
TQDLibraryDriver::InitGraf(void)
{
	QD_LIBRARY_CALL(InitGraf());
}


// ROM 0x00195e58 InitQD__16TQDLibraryDriverFv
// (There is no InitQD in the ROM: the method has nothing to pass on to.)
void
TQDLibraryDriver::InitQD(void)
{
	if (!RomBugFixed())
		InitQD();
}


// ROM 0x00195ed0 OpenPort__16TQDLibraryDriverFP8GrafPort
void
TQDLibraryDriver::OpenPort(GrafPort* port)
{
	QD_LIBRARY_CALL(OpenPort(port));
}


// ROM 0x00195f3c InitPort__16TQDLibraryDriverFP8GrafPort
void
TQDLibraryDriver::InitPort(GrafPort* port)
{
	QD_LIBRARY_CALL(InitPort(port));
}


// ROM 0x00195f68 ClosePort__16TQDLibraryDriverFP8GrafPort
void
TQDLibraryDriver::ClosePort(GrafPort* port)
{
	QD_LIBRARY_CALL(ClosePort(port));
}


// ROM 0x00195f94 SetPort__16TQDLibraryDriverFP8GrafPort
void
TQDLibraryDriver::SetPort(GrafPort* port)
{
	QD_LIBRARY_CALL(SetPort(port));
}


// ROM 0x00195fe8 GetPort__16TQDLibraryDriverFPP8GrafPort
void
TQDLibraryDriver::GetPort(GrafPort** port)
{
	QD_LIBRARY_CALL(GetPort(port));
}


// ROM 0x0019581c SetPortBits__16TQDLibraryDriverFP8PixelMap
void
TQDLibraryDriver::SetPortBits(const PixelMap* bits)
{
	QD_LIBRARY_CALL(SetPortBits(bits));
}


// ROM 0x0019585c SetOrigin__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::SetOrigin(long h, long v)
{
	QD_LIBRARY_CALL(SetOrigin(h, v));
}


// ROM 0x001958d8 SetClip__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::SetClip(RgnHandle rgn)
{
	QD_LIBRARY_CALL(SetClip(rgn));
}


// ROM 0x00195940 GetClip__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::GetClip(RgnHandle rgn)
{
	QD_LIBRARY_CALL(GetClip(rgn));
}


// ROM 0x0019596c ClipRect__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::ClipRect(const Rect* r)
{
	QD_LIBRARY_CALL(ClipRect(r));
}


// ROM 0x00195998 SetStdProcs__16TQDLibraryDriverFP7QDProcs
void
TQDLibraryDriver::SetStdProcs(QDProcs* procs)
{
	QD_LIBRARY_CALL(SetStdProcs(procs));
}


// ROM 0x00195b1c InitPortRgns__16TQDLibraryDriverFP8GrafPort
void
TQDLibraryDriver::InitPortRgns(GrafPort* port)
{
	QD_LIBRARY_CALL(InitPortRgns(port));
}


// ROM 0x00195cb8 HidePen__16TQDLibraryDriverFv
void
TQDLibraryDriver::HidePen(void)
{
	QD_LIBRARY_CALL(HidePen());
}


// ROM 0x00195d10 ShowPen__16TQDLibraryDriverFv
void
TQDLibraryDriver::ShowPen(void)
{
	QD_LIBRARY_CALL(ShowPen());
}


// ROM 0x00195d6c GetPen__16TQDLibraryDriverFP5Point
void
TQDLibraryDriver::GetPen(Point* pt)
{
	QD_LIBRARY_CALL(GetPen(pt));
}


// ROM 0x00195de4 GetPenState__16TQDLibraryDriverFP8PenState
void
TQDLibraryDriver::GetPenState(PenState* state)
{
	QD_LIBRARY_CALL(GetPenState(state));
}


// ROM 0x00195de8 SetPenState__16TQDLibraryDriverFP8PenState
void
TQDLibraryDriver::SetPenState(const PenState* state)
{
	QD_LIBRARY_CALL(SetPenState(state));
}


// ROM 0x00195dec PenSize__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::PenSize(long width, long height)
{
	QD_LIBRARY_CALL(PenSize(width, height));
}


// ROM 0x00195df0 PenMode__16TQDLibraryDriverFl
void
TQDLibraryDriver::PenMode(long mode)
{
	QD_LIBRARY_CALL(PenMode(mode));
}


// ROM 0x00195df4 PenNormal__16TQDLibraryDriverFv
void
TQDLibraryDriver::PenNormal(void)
{
	QD_LIBRARY_CALL(PenNormal());
}


// ROM 0x00195df8 MoveTo__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::MoveTo(long h, long v)
{
	QD_LIBRARY_CALL(MoveTo(h, v));
}


// ROM 0x00195dfc Move__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::Move(long dh, long dv)
{
	QD_LIBRARY_CALL(Move(dh, dv));
}


// ROM 0x00195e00 LineTo__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::LineTo(long h, long v)
{
	QD_LIBRARY_CALL(LineTo(h, v));
}


// ROM 0x00195e04 Line__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::Line(long dh, long dv)
{
	QD_LIBRARY_CALL(Line(dh, dv));
}


// ROM 0x00195e08 InkerLine__16TQDLibraryDriverFC5PointT1P4RectT1
void
TQDLibraryDriver::InkerLine(const Point from, const Point to, Rect* damaged, const Point pen)
{
	QD_LIBRARY_CALL(InkerLine(from, to, damaged, pen));
}


// ROM 0x00195e30 EmptyRect__16TQDLibraryDriverFP4Rect
Boolean
TQDLibraryDriver::EmptyRect(const Rect* r)
{
	QD_LIBRARY_CALL(EmptyRect(r));
}


// ROM 0x00195e34 EqualRect__16TQDLibraryDriverFP4RectT1
Boolean
TQDLibraryDriver::EqualRect(const Rect* a, const Rect* b)
{
	QD_LIBRARY_CALL(EqualRect(a, b));
}


// ROM 0x00195e38 EraseRect__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::EraseRect(const Rect* r)
{
	QD_LIBRARY_CALL(EraseRect(r));
}


// ROM 0x00195e3c FillRect__16TQDLibraryDriverFP4RectPP8PixelMap
void
TQDLibraryDriver::FillRect(const Rect* r, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillRect(r, pattern));
}


// ROM 0x00195e40 FrameRect__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::FrameRect(const Rect* r)
{
	QD_LIBRARY_CALL(FrameRect(r));
}


// ROM 0x00195e44 InsetRect__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::InsetRect(Rect* r, long dh, long dv)
{
	QD_LIBRARY_CALL(InsetRect(r, dh, dv));
}


// ROM 0x00195e48 InvertRect__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::InvertRect(const Rect* r)
{
	QD_LIBRARY_CALL(InvertRect(r));
}


// ROM 0x00195e4c MapRect__16TQDLibraryDriverFP4RectN21
void
TQDLibraryDriver::MapRect(Rect* r, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapRect(r, src, dst));
}


// ROM 0x00195e50 OffsetRect__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::OffsetRect(Rect* r, long dh, long dv)
{
	QD_LIBRARY_CALL(OffsetRect(r, dh, dv));
}


// ROM 0x00195e54 PaintRect__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::PaintRect(const Rect* r)
{
	QD_LIBRARY_CALL(PaintRect(r));
}


// ROM 0x00195e5c Pt2Rect__16TQDLibraryDriverF5PointT1P4Rect
void
TQDLibraryDriver::Pt2Rect(Point a, Point b, Rect* r)
{
	QD_LIBRARY_CALL(Pt2Rect(a, b, r));
}


// ROM 0x00195e60 PtInRect__16TQDLibraryDriverF5PointP4Rect
Boolean
TQDLibraryDriver::PtInRect(Point pt, const Rect* r)
{
	QD_LIBRARY_CALL(PtInRect(pt, r));
}


// ROM 0x00195e64 SectRect__16TQDLibraryDriverFP4RectN21
Boolean
TQDLibraryDriver::SectRect(const Rect* a, const Rect* b, Rect* result)
{
	QD_LIBRARY_CALL(SectRect(a, b, result));
}


// ROM 0x00195e68 SetEmptyRect__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::SetEmptyRect(Rect* r)
{
	QD_LIBRARY_CALL(SetEmptyRect(r));
}


// ROM 0x00195e6c SetRect__16TQDLibraryDriverFP4RectlN32
void
TQDLibraryDriver::SetRect(Rect* r, long left, long top, long right, long bottom)
{
	QD_LIBRARY_CALL(SetRect(r, left, top, right, bottom));
}


// ROM 0x00195e98 UnionRect__16TQDLibraryDriverFP4RectN21
void
TQDLibraryDriver::UnionRect(const Rect* a, const Rect* b, Rect* result)
{
	QD_LIBRARY_CALL(UnionRect(a, b, result));
}


// ROM 0x00195e9c JoinRect__16TQDLibraryDriverFP4RectN21
void
TQDLibraryDriver::JoinRect(const Rect* a, const Rect* b, Rect* result)
{
	QD_LIBRARY_CALL(JoinRect(a, b, result));
}


// ROM 0x00195ea0 ZoomRect__16TQDLibraryDriverFP4RectT1lUc
void
TQDLibraryDriver::ZoomRect(Rect* from, Rect* to, long steps, Boolean zoomIn)
{
	QD_LIBRARY_CALL(ZoomRect(from, to, steps, zoomIn));
}


// ROM 0x00195ec8 EraseOval__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::EraseOval(const Rect* r)
{
	QD_LIBRARY_CALL(EraseOval(r));
}


// ROM 0x00195ecc FillOval__16TQDLibraryDriverFP4RectPP8PixelMap
void
TQDLibraryDriver::FillOval(const Rect* r, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillOval(r, pattern));
}


// ROM 0x00195ed4 FrameOval__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::FrameOval(const Rect* r)
{
	QD_LIBRARY_CALL(FrameOval(r));
}


// ROM 0x00195ed8 InvertOval__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::InvertOval(const Rect* r)
{
	QD_LIBRARY_CALL(InvertOval(r));
}


// ROM 0x00195edc PaintOval__16TQDLibraryDriverFP4Rect
void
TQDLibraryDriver::PaintOval(const Rect* r)
{
	QD_LIBRARY_CALL(PaintOval(r));
}


// ROM 0x00195ee0 EraseRoundRect__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::EraseRoundRect(const Rect* r, long ovalWidth, long ovalHeight)
{
	QD_LIBRARY_CALL(EraseRoundRect(r, ovalWidth, ovalHeight));
}


// ROM 0x00195ee4 FillRoundRect__16TQDLibraryDriverFP4RectlT2PP8PixelMap
void
TQDLibraryDriver::FillRoundRect(const Rect* r, long ovalWidth, long ovalHeight, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillRoundRect(r, ovalWidth, ovalHeight, pattern));
}


// ROM 0x00195f08 FrameRoundRect__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::FrameRoundRect(const Rect* r, long ovalWidth, long ovalHeight)
{
	QD_LIBRARY_CALL(FrameRoundRect(r, ovalWidth, ovalHeight));
}


// ROM 0x00195f0c InvertRoundRect__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::InvertRoundRect(const Rect* r, long ovalWidth, long ovalHeight)
{
	QD_LIBRARY_CALL(InvertRoundRect(r, ovalWidth, ovalHeight));
}


// ROM 0x00195f10 PaintRoundRect__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::PaintRoundRect(const Rect* r, long ovalWidth, long ovalHeight)
{
	QD_LIBRARY_CALL(PaintRoundRect(r, ovalWidth, ovalHeight));
}


// ROM 0x00195f14 EraseArc__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::EraseArc(const Rect* r, long startAngle, long arcAngle)
{
	QD_LIBRARY_CALL(EraseArc(r, startAngle, arcAngle));
}


// ROM 0x00195f18 FillArc__16TQDLibraryDriverFP4RectlT2PP8PixelMap
void
TQDLibraryDriver::FillArc(const Rect* r, long startAngle, long arcAngle, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillArc(r, startAngle, arcAngle, pattern));
}


// ROM 0x00195f40 FrameArc__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::FrameArc(const Rect* r, long startAngle, long arcAngle)
{
	QD_LIBRARY_CALL(FrameArc(r, startAngle, arcAngle));
}


// ROM 0x00195f44 InvertArc__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::InvertArc(const Rect* r, long startAngle, long arcAngle)
{
	QD_LIBRARY_CALL(InvertArc(r, startAngle, arcAngle));
}


// ROM 0x00195f48 PaintArc__16TQDLibraryDriverFP4RectlT2
void
TQDLibraryDriver::PaintArc(const Rect* r, long startAngle, long arcAngle)
{
	QD_LIBRARY_CALL(PaintArc(r, startAngle, arcAngle));
}


// ROM 0x00195f4c CloseRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::CloseRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(CloseRgn(rgn));
}


// ROM 0x00195f50 CopyRgn__16TQDLibraryDriverFPP6RegionT1
Boolean
TQDLibraryDriver::CopyRgn(RgnHandle src, RgnHandle dst)
{
	QD_LIBRARY_CALL(CopyRgn(src, dst));
}


// ROM 0x00195f54 DiffRgn__16TQDLibraryDriverFPP6RegionN21
void
TQDLibraryDriver::DiffRgn(RgnHandle a, RgnHandle b, RgnHandle dst)
{
	QD_LIBRARY_CALL(DiffRgn(a, b, dst));
}


// ROM 0x00195f58 DisposeRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::DisposeRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(DisposeRgn(rgn));
}


// ROM 0x00195f5c EmptyRgn__16TQDLibraryDriverFPP6Region
Boolean
TQDLibraryDriver::EmptyRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(EmptyRgn(rgn));
}


// ROM 0x00195f60 EqualRgn__16TQDLibraryDriverFPP6RegionT1
Boolean
TQDLibraryDriver::EqualRgn(RgnHandle a, RgnHandle b)
{
	QD_LIBRARY_CALL(EqualRgn(a, b));
}


// ROM 0x00195f64 EraseRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::EraseRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(EraseRgn(rgn));
}


// ROM 0x00195f6c FillRgn__16TQDLibraryDriverFPP6RegionPP8PixelMap
void
TQDLibraryDriver::FillRgn(RgnHandle rgn, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillRgn(rgn, pattern));
}


// ROM 0x00195f70 FrameRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::FrameRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(FrameRgn(rgn));
}


// ROM 0x00195f74 InsetRgn__16TQDLibraryDriverFPP6RegionlT2
void
TQDLibraryDriver::InsetRgn(RgnHandle rgn, long dh, long dv)
{
	QD_LIBRARY_CALL(InsetRgn(rgn, dh, dv));
}


// ROM 0x00195f78 InvertRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::InvertRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(InvertRgn(rgn));
}


// ROM 0x00195f7c MapRgn__16TQDLibraryDriverFPP6RegionP4RectT2
void
TQDLibraryDriver::MapRgn(RgnHandle rgn, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapRgn(rgn, src, dst));
}


// ROM 0x00195f80 NewRgn__16TQDLibraryDriverFv
RgnHandle
TQDLibraryDriver::NewRgn(void)
{
	QD_LIBRARY_CALL(NewRgn());
}


// ROM 0x00195f84 OffsetRgn__16TQDLibraryDriverFPP6RegionlT2
void
TQDLibraryDriver::OffsetRgn(RgnHandle rgn, long dh, long dv)
{
	QD_LIBRARY_CALL(OffsetRgn(rgn, dh, dv));
}


// ROM 0x00195f88 OpenRgn__16TQDLibraryDriverFv
void
TQDLibraryDriver::OpenRgn(void)
{
	QD_LIBRARY_CALL(OpenRgn());
}


// ROM 0x00195f8c PaintRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::PaintRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(PaintRgn(rgn));
}


// ROM 0x00195f90 PtInRgn__16TQDLibraryDriverF5PointPP6Region
Boolean
TQDLibraryDriver::PtInRgn(Point pt, RgnHandle rgn)
{
	QD_LIBRARY_CALL(PtInRgn(pt, rgn));
}


// ROM 0x00195f98 RectInRgn__16TQDLibraryDriverFP4RectPP6Region
Boolean
TQDLibraryDriver::RectInRgn(const Rect* r, RgnHandle rgn)
{
	QD_LIBRARY_CALL(RectInRgn(r, rgn));
}


// ROM 0x00195f9c RectRgn__16TQDLibraryDriverFPP6RegionP4Rect
void
TQDLibraryDriver::RectRgn(RgnHandle rgn, const Rect* r)
{
	QD_LIBRARY_CALL(RectRgn(rgn, r));
}


// ROM 0x00195fa0 SectRgn__16TQDLibraryDriverFPP6RegionN21
void
TQDLibraryDriver::SectRgn(RgnHandle a, RgnHandle b, RgnHandle dst)
{
	QD_LIBRARY_CALL(SectRgn(a, b, dst));
}


// ROM 0x00195fa4 SetEmptyRgn__16TQDLibraryDriverFPP6Region
void
TQDLibraryDriver::SetEmptyRgn(RgnHandle rgn)
{
	QD_LIBRARY_CALL(SetEmptyRgn(rgn));
}


// ROM 0x00195fa8 SetRectRgn__16TQDLibraryDriverFPP6RegionlN32
void
TQDLibraryDriver::SetRectRgn(RgnHandle rgn, long left, long top, long right, long bottom)
{
	QD_LIBRARY_CALL(SetRectRgn(rgn, left, top, right, bottom));
}


// ROM 0x00195fd4 UnionRgn__16TQDLibraryDriverFPP6RegionN21
void
TQDLibraryDriver::UnionRgn(RgnHandle a, RgnHandle b, RgnHandle dst)
{
	QD_LIBRARY_CALL(UnionRgn(a, b, dst));
}


// ROM 0x00195fd8 XorRgn__16TQDLibraryDriverFPP6RegionN21
void
TQDLibraryDriver::XorRgn(RgnHandle a, RgnHandle b, RgnHandle dst)
{
	QD_LIBRARY_CALL(XorRgn(a, b, dst));
}


// ROM 0x00195fdc ClosePoly__16TQDLibraryDriverFv
void
TQDLibraryDriver::ClosePoly(void)
{
	QD_LIBRARY_CALL(ClosePoly());
}


// ROM 0x00195fe0 ErasePoly__16TQDLibraryDriverFPP7Polygon
void
TQDLibraryDriver::ErasePoly(PolyHandle poly)
{
	QD_LIBRARY_CALL(ErasePoly(poly));
}


// ROM 0x00195fe4 FillPoly__16TQDLibraryDriverFPP7PolygonPP8PixelMap
void
TQDLibraryDriver::FillPoly(PolyHandle poly, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillPoly(poly, pattern));
}


// ROM 0x00195fec FramePoly__16TQDLibraryDriverFPP7Polygon
void
TQDLibraryDriver::FramePoly(PolyHandle poly)
{
	QD_LIBRARY_CALL(FramePoly(poly));
}


// ROM 0x00195ff0 KillPoly__16TQDLibraryDriverFPP7Polygon
void
TQDLibraryDriver::KillPoly(PolyHandle poly)
{
	QD_LIBRARY_CALL(KillPoly(poly));
}


// ROM 0x00195ff4 InvertPoly__16TQDLibraryDriverFPP7Polygon
void
TQDLibraryDriver::InvertPoly(PolyHandle poly)
{
	QD_LIBRARY_CALL(InvertPoly(poly));
}


// ROM 0x00195ff8 MapPoly__16TQDLibraryDriverFPP7PolygonP4RectT2
void
TQDLibraryDriver::MapPoly(PolyHandle poly, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapPoly(poly, src, dst));
}


// ROM 0x00195ffc OffsetPoly__16TQDLibraryDriverFPP7PolygonlT2
void
TQDLibraryDriver::OffsetPoly(PolyHandle poly, long dh, long dv)
{
	QD_LIBRARY_CALL(OffsetPoly(poly, dh, dv));
}


// ROM 0x00196000 OpenPoly__16TQDLibraryDriverFv
PolyHandle
TQDLibraryDriver::OpenPoly(void)
{
	QD_LIBRARY_CALL(OpenPoly());
}


// ROM 0x00196004 PaintPoly__16TQDLibraryDriverFPP7Polygon
void
TQDLibraryDriver::PaintPoly(PolyHandle poly)
{
	QD_LIBRARY_CALL(PaintPoly(poly));
}


// ROM 0x00196008 CheckPic__16TQDLibraryDriverFv
Boolean
TQDLibraryDriver::CheckPic(void)
{
	QD_LIBRARY_CALL(CheckPic());
}


// ROM 0x0019600c ClosePicture__16TQDLibraryDriverFv
void
TQDLibraryDriver::ClosePicture(void)
{
	QD_LIBRARY_CALL(ClosePicture());
}


// ROM 0x00196010 DrawPicture__16TQDLibraryDriverFPP7PictureP4RectUc
Ref
TQDLibraryDriver::DrawPicture(PicHandle picture, Rect* dstRect, Boolean toShapes)
{
	QD_LIBRARY_CALL(DrawPicture(picture, dstRect, toShapes));
}


// ROM 0x00195820 KillPicture__16TQDLibraryDriverFPP7Picture
void
TQDLibraryDriver::KillPicture(PicHandle picture)
{
	QD_LIBRARY_CALL(KillPicture(picture));
}


// ROM 0x00195824 OpenPicture__16TQDLibraryDriverFP4RectUc
PicHandle
TQDLibraryDriver::OpenPicture(Rect* frame, Boolean macPicture)
{
	QD_LIBRARY_CALL(OpenPicture(frame, macPicture));
}


// ROM 0x0019582c PicComment__16TQDLibraryDriverFsT1PPc
void
TQDLibraryDriver::PicComment(short kind, short size, Handle data)
{
	QD_LIBRARY_CALL(PicComment(kind, size, data));
}


// ROM 0x00195840 EqualPt__16TQDLibraryDriverF5PointT1
Boolean
TQDLibraryDriver::EqualPt(Point a, Point b)
{
	QD_LIBRARY_CALL(EqualPt(a, b));
}


// ROM 0x00195844 LocalToGlobal__16TQDLibraryDriverFP5Point
void
TQDLibraryDriver::LocalToGlobal(Point* pt)
{
	QD_LIBRARY_CALL(LocalToGlobal(pt));
}


// ROM 0x00195848 MapPt__16TQDLibraryDriverFP5PointP4RectT2
void
TQDLibraryDriver::MapPt(Point* pt, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapPt(pt, src, dst));
}


// ROM 0x0019584c ScalePt__16TQDLibraryDriverFP5PointP4RectT2
void
TQDLibraryDriver::ScalePt(Point* pt, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(ScalePt(pt, src, dst));
}


// ROM 0x00195850 SetPt__16TQDLibraryDriverFP5PointlT2
void
TQDLibraryDriver::SetPt(Point* pt, long h, long v)
{
	QD_LIBRARY_CALL(SetPt(pt, h, v));
}


// ROM 0x00195854 MapFPoint__16TQDLibraryDriverFP6FPointP4RectT2
void
TQDLibraryDriver::MapFPoint(FPoint* pt, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapFPoint(pt, src, dst));
}


// ROM 0x00195858 GetPixelMapBits__16TQDLibraryDriverFP8PixelMap
Ptr
TQDLibraryDriver::GetPixelMapBits(const PixelMap* pm)
{
	QD_LIBRARY_CALL(GetPixelMapBits(pm));
}


// ROM 0x00195860 PtInPixelMap__16TQDLibraryDriverFP8PixelMaplT2
Boolean
TQDLibraryDriver::PtInPixelMap(const PixelMap* pm, long x, long y)
{
	QD_LIBRARY_CALL(PtInPixelMap(pm, x, y));
}


// ROM 0x00195864 CopyBits__16TQDLibraryDriverFP8PixelMapT1P4RectT3lPP6Region
void
TQDLibraryDriver::CopyBits(PixelMap* src, PixelMap* dst, const Rect* srcRect, const Rect* dstRect, long mode, RgnHandle mask)
{
	QD_LIBRARY_CALL(CopyBits(src, dst, srcRect, dstRect, mode, mask));
}


// ROM 0x00195898 PackBits__16TQDLibraryDriverFPPcT1l
void
TQDLibraryDriver::PackBits(char** srcPtr, char** dstPtr, long count)
{
	QD_LIBRARY_CALL(PackBits(srcPtr, dstPtr, count));
}


// ROM 0x0019589c ScrollRect__16TQDLibraryDriverFP4RectlT2PP6Region
void
TQDLibraryDriver::ScrollRect(Rect* r, long dh, long dv, RgnHandle updateRgn)
{
	QD_LIBRARY_CALL(ScrollRect(r, dh, dv, updateRgn));
}


// ROM 0x001958c0 UnpackBits__16TQDLibraryDriverFPPcT1l
void
TQDLibraryDriver::UnpackBits(char** src, char** dst, long count)
{
	QD_LIBRARY_CALL(UnpackBits(src, dst, count));
}


// ROM 0x001958c4 UnpackWords__16TQDLibraryDriverFPPcT1l
void
TQDLibraryDriver::UnpackWords(char** src, char** dst, long count)
{
	QD_LIBRARY_CALL(UnpackWords(src, dst, count));
}


// ROM 0x001958c8 GetRandSeed__16TQDLibraryDriverFv
long
TQDLibraryDriver::GetRandSeed(void)
{
	QD_LIBRARY_CALL(GetRandSeed());
}


// ROM 0x001958cc Random__16TQDLibraryDriverFv
long
TQDLibraryDriver::Random(void)
{
	QD_LIBRARY_CALL(Random());
}


// ROM 0x001958d0 SetRandSeed__16TQDLibraryDriverFl
void
TQDLibraryDriver::SetRandSeed(long seed)
{
	QD_LIBRARY_CALL(SetRandSeed(seed));
}


// ROM 0x001958d4 FrameCurve__16TQDLibraryDriverFP5curve
void
TQDLibraryDriver::FrameCurve(curve* c)
{
	QD_LIBRARY_CALL(FrameCurve(c));
}


// ROM 0x001958dc PaintCurve__16TQDLibraryDriverFP5curve
void
TQDLibraryDriver::PaintCurve(curve* c)
{
	QD_LIBRARY_CALL(PaintCurve(c));
}


// ROM 0x001958e0 EraseCurve__16TQDLibraryDriverFP5curve
void
TQDLibraryDriver::EraseCurve(curve* c)
{
	QD_LIBRARY_CALL(EraseCurve(c));
}


// ROM 0x001958e4 InvertCurve__16TQDLibraryDriverFP5curve
void
TQDLibraryDriver::InvertCurve(curve* c)
{
	QD_LIBRARY_CALL(InvertCurve(c));
}


// ROM 0x001958e8 FillCurve__16TQDLibraryDriverFP5curvePP8PixelMap
void
TQDLibraryDriver::FillCurve(curve* c, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillCurve(c, pattern));
}


// ROM 0x001958ec SetCurve__16TQDLibraryDriverFP5curve6FPointN22
void
TQDLibraryDriver::SetCurve(curve* c, FPoint first, FPoint control, FPoint last)
{
	QD_LIBRARY_CALL(SetCurve(c, first, control, last));
}


// ROM 0x0019592c OffsetCurve__16TQDLibraryDriverFP5curvelT2
void
TQDLibraryDriver::OffsetCurve(curve* c, Fixed dh, Fixed dv)
{
	QD_LIBRARY_CALL(OffsetCurve(c, dh, dv));
}


// ROM 0x00195930 EqualCurve__16TQDLibraryDriverFP5curveT1
Boolean
TQDLibraryDriver::EqualCurve(const curve* a, const curve* b)
{
	QD_LIBRARY_CALL(EqualCurve(a, b));
}


// ROM 0x00195934 GetCurveBounds__16TQDLibraryDriverFP5curveP4Rect
void
TQDLibraryDriver::GetCurveBounds(const curve* c, Rect* bounds)
{
	QD_LIBRARY_CALL(GetCurveBounds(c, bounds));
}


// ROM 0x00195938 ScaleCurve__16TQDLibraryDriverFP5curvelT2
void
TQDLibraryDriver::ScaleCurve(curve* c, Fixed hScale, Fixed vScale)
{
	QD_LIBRARY_CALL(ScaleCurve(c, hScale, vScale));
}


// ROM 0x0019593c MapCurve__16TQDLibraryDriverFP5curveP4RectT2
void
TQDLibraryDriver::MapCurve(curve* c, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapCurve(c, src, dst));
}


// ROM 0x00195944 FramePaths__16TQDLibraryDriverFPP5paths
void
TQDLibraryDriver::FramePaths(pathsHandle p)
{
	QD_LIBRARY_CALL(FramePaths(p));
}


// ROM 0x00195948 PaintPaths__16TQDLibraryDriverFPP5paths
void
TQDLibraryDriver::PaintPaths(pathsHandle p)
{
	QD_LIBRARY_CALL(PaintPaths(p));
}


// ROM 0x0019594c ErasePaths__16TQDLibraryDriverFPP5paths
void
TQDLibraryDriver::ErasePaths(pathsHandle p)
{
	QD_LIBRARY_CALL(ErasePaths(p));
}


// ROM 0x00195950 InvertPaths__16TQDLibraryDriverFPP5paths
void
TQDLibraryDriver::InvertPaths(pathsHandle p)
{
	QD_LIBRARY_CALL(InvertPaths(p));
}


// ROM 0x00195954 FillPaths__16TQDLibraryDriverFPP5pathsPP8PixelMap
void
TQDLibraryDriver::FillPaths(pathsHandle p, PatternHandle pattern)
{
	QD_LIBRARY_CALL(FillPaths(p, pattern));
}


// ROM 0x00195958 OffsetPaths__16TQDLibraryDriverFPP5pathslT2
void
TQDLibraryDriver::OffsetPaths(pathsHandle p, Fixed dh, Fixed dv)
{
	QD_LIBRARY_CALL(OffsetPaths(p, dh, dv));
}


// ROM 0x0019595c DisposePaths__16TQDLibraryDriverFPP5paths
void
TQDLibraryDriver::DisposePaths(pathsHandle p)
{
	QD_LIBRARY_CALL(DisposePaths(p));
}


// ROM 0x00195960 MapPaths__16TQDLibraryDriverFPP5pathsP4RectT2
void
TQDLibraryDriver::MapPaths(pathsHandle p, const Rect* src, const Rect* dst)
{
	QD_LIBRARY_CALL(MapPaths(p, src, dst));
}


// ROM 0x00195964 ScalePaths__16TQDLibraryDriverFPP5pathslT2
void
TQDLibraryDriver::ScalePaths(pathsHandle p, Fixed hScale, Fixed vScale)
{
	QD_LIBRARY_CALL(ScalePaths(p, hScale, vScale));
}


// ROM 0x00195968 CopyPaths__16TQDLibraryDriverFPP5pathsT1
void
TQDLibraryDriver::CopyPaths(pathsHandle src, pathsHandle dst)
{
	QD_LIBRARY_CALL(CopyPaths(src, dst));
}


// ROM 0x00195970 SizeOfPaths__16TQDLibraryDriverFPP5paths
long
TQDLibraryDriver::SizeOfPaths(pathsHandle p)
{
	QD_LIBRARY_CALL(SizeOfPaths(p));
}


// ROM 0x00195974 GetPathsBounds__16TQDLibraryDriverFPP5pathsP4Rect
void
TQDLibraryDriver::GetPathsBounds(pathsHandle p, Rect* bounds)
{
	QD_LIBRARY_CALL(GetPathsBounds(p, bounds));
}


// ROM 0x00195978 InitPathWalker__16TQDLibraryDriverFP10pathWalkerP4path
void
TQDLibraryDriver::InitPathWalker(pathWalker* walker, path* contour)
{
	QD_LIBRARY_CALL(InitPathWalker(walker, contour));
}


// ROM 0x0019597c NextPath__16TQDLibraryDriverFP4path
path*
TQDLibraryDriver::NextPath(path* contour)
{
	QD_LIBRARY_CALL(NextPath(contour));
}


// ROM 0x00195980 NextPathSegment__16TQDLibraryDriverFP10pathWalker
Boolean
TQDLibraryDriver::NextPathSegment(pathWalker* walker)
{
	QD_LIBRARY_CALL(NextPathSegment(walker));
}


// ROM 0x00195984 DisposePattern__16TQDLibraryDriverFPP8PixelMap
void
TQDLibraryDriver::DisposePattern(PatternHandle pattern)
{
	QD_LIBRARY_CALL(DisposePattern(pattern));
}


// ROM 0x00195988 DisposeFgPattern__16TQDLibraryDriverFv
void
TQDLibraryDriver::DisposeFgPattern(void)
{
	QD_LIBRARY_CALL(DisposeFgPattern());
}


// ROM 0x0019598c SetFgPattern__16TQDLibraryDriverFPP8PixelMap
void
TQDLibraryDriver::SetFgPattern(PatternHandle pattern)
{
	QD_LIBRARY_CALL(SetFgPattern(pattern));
}


// ROM 0x00195990 SetBgPattern__16TQDLibraryDriverFPP8PixelMap
void
TQDLibraryDriver::SetBgPattern(PatternHandle pattern)
{
	QD_LIBRARY_CALL(SetBgPattern(pattern));
}


// ROM 0x00195994 GetFgPattern__16TQDLibraryDriverFv
PatternHandle
TQDLibraryDriver::GetFgPattern(void)
{
	QD_LIBRARY_CALL(GetFgPattern());
}


// ROM 0x0019599c GetBgPattern__16TQDLibraryDriverFv
PatternHandle
TQDLibraryDriver::GetBgPattern(void)
{
	QD_LIBRARY_CALL(GetBgPattern());
}


// ROM 0x001959a0 MakeSimplePattern__16TQDLibraryDriverFlN71
PatternHandle
TQDLibraryDriver::MakeSimplePattern(long row0, long row1, long row2, long row3, long row4, long row5, long row6, long row7)
{
	QD_LIBRARY_CALL(MakeSimplePattern(row0, row1, row2, row3, row4, row5, row6, row7));
}


// ROM 0x001959ec MakeSimplePattern__16TQDLibraryDriverFPc
PatternHandle
TQDLibraryDriver::MakeSimplePattern(const char* rows)
{
	QD_LIBRARY_CALL(MakeSimplePattern(rows));
}


// ROM 0x001959f0 GetStdPattern__16TQDLibraryDriverFUc
PatternHandle
TQDLibraryDriver::GetStdPattern(UChar which)
{
	if (RomBugFixed())
		return ::GetStdPattern((GetPatSelector) which);
	return GetStdPattern(which);
}


// ROM 0x001959f8 CopyPattern__16TQDLibraryDriverFPP8PixelMap
PatternHandle
TQDLibraryDriver::CopyPattern(PatternHandle pattern)
{
	QD_LIBRARY_CALL(CopyPattern(pattern));
}


// ROM 0x001959fc EqualPat__16TQDLibraryDriverFPP8PixelMapT1
Boolean
TQDLibraryDriver::EqualPat(PatternHandle a, PatternHandle b)
{
	QD_LIBRARY_CALL(EqualPat(a, b));
}


// ROM 0x00195a00 MonochromePat__16TQDLibraryDriverFPP8PixelMapPUl
Boolean
TQDLibraryDriver::MonochromePat(PatternHandle pattern, ULong* gray)
{
	QD_LIBRARY_CALL(MonochromePat(pattern, gray));
}


// ROM 0x00195a04 MakeSimpleStyle__16TQDLibraryDriverFRC6RefVarlT2
// A style record answered by value (the ROM: copied out of a temporary
// into the caller's record, or a new one when given none).
StyleRecord
TQDLibraryDriver::MakeSimpleStyle(RefArg fontFamily, long size, long face)
{
	if (!RomBugFixed())
		return MakeSimpleStyle(fontFamily, size, face);
	StyleRecord style;
	::MakeSimpleStyle(&style, fontFamily, size, face);
	return style;
}


// ROM 0x00195a98 EqualStyle__16TQDLibraryDriverFP11StyleRecordT1
Boolean
TQDLibraryDriver::EqualStyle(const StyleRecord* a, const StyleRecord* b)
{
	QD_LIBRARY_CALL(EqualStyle(a, b));
}


// ROM 0x00195a9c CopyStyle__16TQDLibraryDriverFP11StyleRecord
// The style without its pattern, answered by value.  (DEVIATION: the
// host's CopyStyle answers nothing - its callers take the fields
// straight from the style - so the copy the ROM's makes is made here.)
StyleRecord
TQDLibraryDriver::CopyStyle(StyleRecord* style)
{
	if (!RomBugFixed())
		return CopyStyle(style);
	StyleRecord copy;
	copy.fFontFamily = (Ref) style->fFontFamily;
	copy.fFontSize = style->fFontSize;
	copy.fFontFace = style->fFontFace;
	copy.fFontPattern = style->fFontPattern;
	copy.fTransferMode = style->fTransferMode;
	copy.fReserved14 = style->fReserved14;
	copy.fReserved18 = style->fReserved18;
	return copy;
}


// ROM 0x00195b20 FlushFontCache__16TQDLibraryDriverFv
void
TQDLibraryDriver::FlushFontCache(void)
{
	QD_LIBRARY_CALL(FlushFontCache());
}


// ROM 0x00195b24 NewText__16TQDLibraryDriverFPvlPP11StyleRecordPs6FPointP11TextOptions
TextObjectRef
TQDLibraryDriver::NewText(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint location, TextOptions* options)
{
	QD_LIBRARY_CALL(NewText(text, length, styles, runLengths, location, options));
}


// ROM 0x00195b68 DrawTextObj__16TQDLibraryDriverFl
void
TQDLibraryDriver::DrawTextObj(TextObjectRef text)
{
	QD_LIBRARY_CALL(DrawTextObj(text));
}


// ROM 0x00195b6c DisposeText__16TQDLibraryDriverFl
void
TQDLibraryDriver::DisposeText(TextObjectRef text)
{
	QD_LIBRARY_CALL(DisposeText(text));
}


// ROM 0x00195b70 DrawTextOnce__16TQDLibraryDriverFPvlPP11StyleRecordPs6FPointP11TextOptionsP14TextBoundsInfo
void
TQDLibraryDriver::DrawTextOnce(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint where, TextOptions* options, TextBoundsInfo* bounds)
{
	QD_LIBRARY_CALL(DrawTextOnce(text, length, styles, runLengths, where, options, bounds));
}


// ROM 0x00195bc0 MeasureTextOnce__16TQDLibraryDriverFPvlPP11StyleRecordPs6FPointP11TextOptionsP14TextBoundsInfo
void
TQDLibraryDriver::MeasureTextOnce(const void* text, long length, StyleRecord** styles, const short* runLengths, FPoint where, TextOptions* options, TextBoundsInfo* bounds)
{
	QD_LIBRARY_CALL(MeasureTextOnce(text, length, styles, runLengths, where, options, bounds));
}


// ROM 0x00195c10 DrawRichString__16TQDLibraryDriverFR11TRichStringUllP11StyleRecord6FPointP11TextOptionsP14TextBoundsInfo
void
TQDLibraryDriver::DrawRichString(TRichString& rich, ULong start, long length, StyleRecord* style, FPoint where, TextOptions* options, TextBoundsInfo* bounds)
{
	QD_LIBRARY_CALL(DrawRichString(rich, start, length, style, where, options, bounds));
}


// ROM 0x00195c60 MeasureRichString__16TQDLibraryDriverFR11TRichStringUllP11StyleRecord6FPointP11TextOptionsP14TextBoundsInfo
long
TQDLibraryDriver::MeasureRichString(TRichString& rich, ULong start, long length, StyleRecord* style, FPoint where, TextOptions* options, TextBoundsInfo* bounds)
{
	QD_LIBRARY_CALL(MeasureRichString(rich, start, length, style, where, options, bounds));
}


// ROM 0x00195cb0 GetTextObjField__16TQDLibraryDriverFliPv
void
TQDLibraryDriver::GetTextObjField(TextObjectRef text, int field, void* result)
{
	if (RomBugFixed())
		::GetTextObjField(text, (TextObjectField) field, result);
	else
		GetTextObjField(text, field, result);
}


// ROM 0x00195cb4 SetTextObjField__16TQDLibraryDriverFliPv
Boolean
TQDLibraryDriver::SetTextObjField(TextObjectRef text, int field, void* value)
{
	if (RomBugFixed())
		return ::SetTextObjField(text, (TextObjectField) field, value);
	return SetTextObjField(text, field, value);
}


// ROM 0x00195cbc CharToPoint__16TQDLibraryDriverFlT1P6FPoint
void
TQDLibraryDriver::CharToPoint(TextObjectRef text, long offset, FPoint* point)
{
	QD_LIBRARY_CALL(CharToPoint(text, offset, point));
}


// ROM 0x00195cc0 PointToChar__16TQDLibraryDriverFl6FPoint
long
TQDLibraryDriver::PointToChar(TextObjectRef text, FPoint point)
{
	QD_LIBRARY_CALL(PointToChar(text, point));
}


// ROM 0x00195cc4 TextArrowOffset__16TQDLibraryDriverFlT1Uc
long
TQDLibraryDriver::TextArrowOffset(TextObjectRef text, long offset, Boolean forward)
{
	QD_LIBRARY_CALL(TextArrowOffset(text, offset, forward));
}


// ROM 0x00195ccc InitTextWalker__16TQDLibraryDriverFlP10TextWalkerUc
// NOT YET: the text walker (InitTextWalker 0x0035c41c) - the host walks a
// text object's characters with TTextObjectChars (TextObject.h).
void
TQDLibraryDriver::InitTextWalker(TextObjectRef text, TextWalker* walker, Boolean forDrawing)
{
	if (!RomBugFixed())
		InitTextWalker(text, walker, forDrawing);
}


// ROM 0x00195cd4 ReleaseTextWalker__16TQDLibraryDriverFP10TextWalker
// NOT YET: the text walker (ReleaseTextWalker 0x0035c4a0).
void
TQDLibraryDriver::ReleaseTextWalker(TextWalker* walker)
{
	if (!RomBugFixed())
		ReleaseTextWalker(walker);
}


// ROM 0x00195cd8 ScanNextChunk__16TQDLibraryDriverFPlPPvP10TextWalkerPPl
// NOT YET: the text walker (ScanNextChunk 0x0035c2b4); answered as the
// ROM's answers a walker with nothing left in it.
void
TQDLibraryDriver::ScanNextChunk(long* count, void** chars, TextWalker* walker, long** widths)
{
	if (!RomBugFixed())
	{
		ScanNextChunk(count, chars, walker, widths);
		return;
	}
	*count = 0;
	*chars = nil;
}


// ROM 0x00195cfc GetGrafInfo__16TQDLibraryDriverFlPv
long
TQDLibraryDriver::GetGrafInfo(long selector, void* info)
{
	QD_LIBRARY_CALL(GetGrafInfo(selector, info));
}


// ROM 0x00195d00 SetGrafInfo__16TQDLibraryDriverFlT1
void
TQDLibraryDriver::SetGrafInfo(long selector, long value)
{
	QD_LIBRARY_CALL(SetGrafInfo(selector, value));
}


// ROM 0x00195d04 InitScreen__16TQDLibraryDriverFv
// (Host: InitScreen is given the screen driver the ROM's makes by name -
// the one the screen has, when it has one.)
void
TQDLibraryDriver::InitScreen(void)
{
	if (!RomBugFixed())
		InitScreen();
	else if (gTheScreen != nil)
		::InitScreen(gTheScreen);
}


// ROM 0x00195d08 LCDPowerInit__16TQDLibraryDriverFUc
void
TQDLibraryDriver::LCDPowerInit(UChar wasAsleep)
{
	QD_LIBRARY_CALL(LCDPowerInit(wasAsleep));
}


// ROM 0x00195d14 LCDPowerOn__16TQDLibraryDriverFUc
void
TQDLibraryDriver::LCDPowerOn(UChar wasAsleep)
{
	QD_LIBRARY_CALL(LCDPowerOn(wasAsleep));
}


// ROM 0x00195d1c LCDPowerOff__16TQDLibraryDriverFUc
void
TQDLibraryDriver::LCDPowerOff(UChar toSleep)
{
	QD_LIBRARY_CALL(LCDPowerOff(toSleep));
}


// ROM 0x00195d24 LCDEnterIdleMode__16TQDLibraryDriverFv
// (There is no LCDEnterIdleMode in the ROM: nothing to pass on to.)
void
TQDLibraryDriver::LCDEnterIdleMode(void)
{
	if (!RomBugFixed())
		LCDEnterIdleMode();
}


// ROM 0x00195d28 LCDExitIdleMode__16TQDLibraryDriverFv
// (There is no LCDExitIdleMode in the ROM: nothing to pass on to.)
void
TQDLibraryDriver::LCDExitIdleMode(void)
{
	if (!RomBugFixed())
		LCDExitIdleMode();
}


// ROM 0x00195d2c StartDrawing__16TQDLibraryDriverFP8PixelMapP4Rect
void
TQDLibraryDriver::StartDrawing(PixelMap* map, Rect* r)
{
	QD_LIBRARY_CALL(StartDrawing(map, r));
}


// ROM 0x00195d30 StopDrawing__16TQDLibraryDriverFP8PixelMapP4Rect
void
TQDLibraryDriver::StopDrawing(PixelMap* map, Rect* r)
{
	QD_LIBRARY_CALL(StopDrawing(map, r));
}


// ROM 0x00195d34 ReleaseScreenLock__16TQDLibraryDriverFv
void
TQDLibraryDriver::ReleaseScreenLock(void)
{
	QD_LIBRARY_CALL(ReleaseScreenLock());
}


// ROM 0x00195d38 PtInCPixelMap__16TQDLibraryDriverFP8PixelMaplT2
long
TQDLibraryDriver::PtInCPixelMap(const PixelMap* pm, long x, long y)
{
	QD_LIBRARY_CALL(PtInCPixelMap(pm, x, y));
}


// ROM 0x00195d3c PtInMask__16TQDLibraryDriverFP8PixelMaplT2
long
TQDLibraryDriver::PtInMask(const PixelMap* pm, long x, long y)
{
	QD_LIBRARY_CALL(PtInMask(pm, x, y));
}


// ROM 0x00195d40 RGBtoGray__16TQDLibraryDriverFUlN21lT4
ULong
TQDLibraryDriver::RGBtoGray(ULong red, ULong green, ULong blue, long depthIn, long depthOut)
{
	QD_LIBRARY_CALL(RGBtoGray(red, green, blue, depthIn, depthOut));
}


// ROM 0x00195d70 GrayToRGB__16TQDLibraryDriverFUcPUlN22l
void
TQDLibraryDriver::GrayToRGB(UChar gray, ULong* red, ULong* green, ULong* blue, long depth)
{
	QD_LIBRARY_CALL(GrayToRGB(gray, red, green, blue, depth));
}


// ROM 0x00195da0 PackRGBvalues__16TQDLibraryDriverFUlN21
ULong
TQDLibraryDriver::PackRGBvalues(ULong red, ULong green, ULong blue)
{
	QD_LIBRARY_CALL(PackRGBvalues(red, green, blue));
}


// ROM 0x00195da4 UnpackRGBvalues__16TQDLibraryDriverFUlPUlN22
void
TQDLibraryDriver::UnpackRGBvalues(ULong colour, ULong* red, ULong* green, ULong* blue)
{
	QD_LIBRARY_CALL(UnpackRGBvalues(colour, red, green, blue));
}


// ROM 0x00195dc8 GetStdGrayPattern__16TQDLibraryDriverFUlN21
PatternHandle
TQDLibraryDriver::GetStdGrayPattern(ULong red, ULong green, ULong blue)
{
	QD_LIBRARY_CALL(GetStdGrayPattern(red, green, blue));
}


// ROM 0x00195dcc MakeGrayPattern__16TQDLibraryDriverFRC6RefVar
PatternHandle
TQDLibraryDriver::MakeGrayPattern(RefArg spec)
{
	QD_LIBRARY_CALL(MakeGrayPattern(spec));
}


// ROM 0x00195dd0 MakeSimpleGrayPattern__16TQDLibraryDriverFPlUlT2
PatternHandle
TQDLibraryDriver::MakeSimpleGrayPattern(long* rows, ULong fg, ULong bg)
{
	if (RomBugFixed())
		return ::MakeSimpleGrayPattern((const char*) rows, fg, bg);
	return MakeSimpleGrayPattern(rows, fg, bg);
}


// ROM 0x00195dd4 PutPixMap__16TQDLibraryDriverFP8PixelMap
void
TQDLibraryDriver::PutPixMap(PixelMap* pm)
{
	QD_LIBRARY_CALL(PutPixMap(pm));
}


// ROM 0x00195dd8 PutColorTable__16TQDLibraryDriverFl
void
TQDLibraryDriver::PutColorTable(long depth)
{
	QD_LIBRARY_CALL(PutColorTable(depth));
}


// ROM 0x00195ddc PutGrayTable__16TQDLibraryDriverFP8PixelMap
void
TQDLibraryDriver::PutGrayTable(PixelMap* pm)
{
	QD_LIBRARY_CALL(PutGrayTable(pm));
}
