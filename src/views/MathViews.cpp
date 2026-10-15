/*
	File:		views/MathViews.cpp

	Contains:	TMathExpView, TMathOpView and TMathLineView (MathViews.h).

	Reconstructed from the MP2x00 US ROM; each function cites its origin.
*/

#include "MathViews.h"
#include "ViewFlags.h"
#include "Commands.h"
#include "Application.h"
#include "Rects.h"
#include "Ports.h"
#include "Shapes.h"
#include "Frames.h"
#include "Interpreter.h"
#include "RSSymbols.h"


/*------------------------------------------------------------------------------
	T M a t h E x p V i e w
------------------------------------------------------------------------------*/

// ROM 0x0011bb38 ClassID__12TMathExpViewCFv
long
TMathExpView::ClassID(void) const
{
	return clMathExpView;
}


// ROM 0x0011bb40 DerivedFrom__12TMathExpViewCFl
Boolean
TMathExpView::DerivedFrom(long id) const
{
	return id == clMathExpView || TContainerView::DerivedFrom(id);
}


// ROM 0x0011beac Constructor__12TMathExpViewFRC6RefVarP5TView
// A container whose viewFont's family, face and size are kept, and whose
// children are kept 16 apart (the container's 5) - its +0x34 3 (2).
void
TMathExpView::Constructor(RefArg context, TView* parent)
{
	TContainerView::Constructor(context, parent);
	RefVar font(GetVariable(fContext, RSSYMviewfont, nil, 0));
	fFamily = GetFrameSlotRef(font, RSSYMfamily);
	fFace = RINT(GetFrameSlotRef(font, RSSYMface));
	fSize = RINT(GetFrameSlotRef(font, RSSYMsize));
	fGap = 16;
	fUnknown34 = 3;
}


// ROM 0x0011bf98 RealDoCommand__12TMathExpViewFRC6RefVar
// A key going up is taken, and nothing done, unless the view is read-only;
// everything else is the container's.
Boolean
TMathExpView::RealDoCommand(RefArg cmd)
{
	long id = CommandID(cmd);
	if (id == aeClick)							// (the ROM asks it first, to the same end)
		return TContainerView::RealDoCommand(cmd);
	if (id == aeKeyUp && (fFlags & vReadOnly) == 0)
		return true;
	return TContainerView::RealDoCommand(cmd);
}


// ROM 0x0011bf94 PreDraw__12TMathExpViewFR5TRect
void
TMathExpView::PreDraw(Rect& bounds)
{
	TView::PreDraw(bounds);
}


// ROM 0x0011bfe4 RealDraw__12TMathExpViewFR5TRect
// Nothing: the expression is its children.
void
TMathExpView::RealDraw(Rect& /*bounds*/)
{ }


// ROM 0x0011bfe8 HandleScrub__12TMathExpViewFRC5TRectlP11TUnitPublicUc
// The container's scrub; and when it was done and took something, every
// child whose data says it is the result (a non-nought isResult) is
// removed as well, each through the undoable aeRemoveData.
long
TMathExpView::HandleScrub(const Rect& bounds, long arg, TUnitPublic* unit, Boolean on)
{
	long result = TContainerView::HandleScrub(bounds, arg, unit, on);
	if (on && result != 0)
	{
		RefVar isResult;
		CList* children = fChildren;
		for (short i = 0; i < (long) children->GetArraySize(); i = (short) (i + 1))
		{
			TView* child = (TView*) children->At(i);
			isResult = GetFrameSlotRef(RefVar(child->DataFrame()), RSSYMisresult);
			if (ISNIL(isResult))
				continue;
			if (RINT(isResult) != 0)
			{
				gApplication->DispatchCommand(RefVar(MakeCommand(aeRemoveData, this, child->fId)));
				i = (short) (i - 1);
			}
		}
	}
	return result;
}


// ROM 0x0011c124 GetContext__12TMathExpViewFv
// What a copy of the expression starts from: a copy of its data.
Ref
TMathExpView::GetContext(void)
{
	return CopyForm();
}


/*------------------------------------------------------------------------------
	T M a t h O p V i e w
------------------------------------------------------------------------------*/

// ROM 0x0011c12c ClassID__11TMathOpViewCFv
long
TMathOpView::ClassID(void) const
{
	return clMathOpView;
}


// ROM 0x0011c134 DerivedFrom__11TMathOpViewCFl
Boolean
TMathOpView::DerivedFrom(long id) const
{
	return id == clMathOpView || TDataView::DerivedFrom(id);
}


// ROM 0x0011bb74 Constructor__11TMathOpViewFRC6RefVarP5TView
// The operator it draws, its mathOperator.
void
TMathOpView::Constructor(RefArg context, TView* parent)
{
	TView::Constructor(context, parent);
	fOperator = RINT(GetVariable(fContext, RSSYMmathoperator, nil, 0));
}


// ROM 0x0011bbd4 PreDraw__11TMathOpViewFR5TRect
void
TMathOpView::PreDraw(Rect& bounds)
{
	TView::PreDraw(bounds);
}


// ROM 0x0011bbd8 RealDoCommand__11TMathOpViewFRC6RefVar
Boolean
TMathOpView::RealDoCommand(RefArg cmd)
{
	return TView::RealDoCommand(cmd);
}


// ROM 0x0011bbdc RealDraw__11TMathOpViewFR5TRect
// The operator drawn in the view's bounds (the rectangle given is not
// looked at), a pixel in from the bottom and the right: a plus is a line
// down the middle and one across it, a minus the one across, a times the
// two diagonals, a slash the one up to the right.
void
TMathOpView::RealDraw(Rect& /*bounds*/)
{
	Rect r = viewBounds;
	PenNormal();
	r.bottom = (short) (r.bottom - 1);
	r.right = (short) (r.right - 1);
	Point mid = MidPoint(r);
	switch (fOperator)
	{
	case kMathPlus:
		MoveTo(mid.h, r.top);
		LineTo(mid.h, r.bottom);
		// and on into the minus
	case kMathMinus:
		MoveTo(r.left, mid.v);
		LineTo(r.right, mid.v);
		break;
	case kMathTimes:
		MoveTo(r.left, r.top);
		LineTo(r.right, r.bottom);
		// and on into the slash
	case kMathSlash:
		MoveTo(r.right, r.top);
		LineTo(r.left, r.bottom);
		break;
	default:
		break;
	}
}


/*------------------------------------------------------------------------------
	T M a t h L i n e V i e w
------------------------------------------------------------------------------*/

// ROM 0x0011bd00 ClassID__13TMathLineViewCFv
long
TMathLineView::ClassID(void) const
{
	return clMathLineView;
}


// ROM 0x0011bd08 DerivedFrom__13TMathLineViewCFl
Boolean
TMathLineView::DerivedFrom(long id) const
{
	return id == clMathLineView || TDataView::DerivedFrom(id);
}


// ROM 0x0011bd3c Constructor__13TMathLineViewFRC6RefVarP5TView
// The line's rectangle, its mathLine.
void
TMathLineView::Constructor(RefArg context, TView* parent)
{
	TView::Constructor(context, parent);
	RefVar line(GetVariable(fContext, RSSYMmathline, nil, 0));
	FromObject(line, fLine);
}


// ROM 0x0011bda4 PreDraw__13TMathLineViewFR5TRect
void
TMathLineView::PreDraw(Rect& bounds)
{
	TView::PreDraw(bounds);
}


// ROM 0x0011bda8 RealDoCommand__13TMathLineViewFRC6RefVar
Boolean
TMathLineView::RealDoCommand(RefArg cmd)
{
	return TView::RealDoCommand(cmd);
}


// ROM 0x0011bdac RealDraw__13TMathLineViewFR5TRect
// A line from the view's top left down to the right, as wide and as deep
// as the mathLine rectangle (where that lies is not looked at).
void
TMathLineView::RealDraw(Rect& /*bounds*/)
{
	Rect r;
	r.top = viewBounds.top;
	r.left = viewBounds.left;
	r.bottom = (short) (viewBounds.top + (short) (fLine.bottom - fLine.top));
	r.right = (short) (viewBounds.left + (short) (fLine.right - fLine.left));
	PenNormal();
	MoveTo(r.left, r.top);
	LineTo(r.right, r.bottom);
}
