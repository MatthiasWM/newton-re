/*
	File:		views/MathViews.h

	Contains:	The math views - TMathExpView (class 84), TMathOpView (85)
				and TMathLineView (86) - the pieces of a written expression
				laid out as views: an expression is a container of terms,
				each operator drawn as a few lines, a fraction's bar as one.

				They are what the math recogniser (not in this ROM) would
				have made of handwriting.  The U.S. ROM's BuildView makes
				them for a template of their classes, but nothing in the
				ROM, its extension or its stationery has one, so they are
				dead in it - a package or a script that opens a view of
				class 84, 85 or 86 gets them (ctest views.Views,
				TestMathViews).

				TMathExpView: a container (the children laid out with a gap
				of 16 rather than 5, fUnknown34 3 rather than 2) that keeps
				the family, face and size of its viewFont, draws nothing of
				its own, ignores a key going up unless it is read-only, and
				removes the children whose data says they are the result
				(isResult) when it is scrubbed out; its context for a copy
				is a copy of its data (CopyForm).

				TMathOpView: an operator (mathOperator: 0 plus, 1 minus, 2
				times, 3 a slash, 4 and anything else nothing) drawn in the
				view's bounds, a pixel in from the bottom and right.

				TMathLineView: a line the size of its mathLine rectangle,
				from the view's top left down to the right.

	Reconstructed from the MP2x00 US ROM (0x0011bb38-0x0011c168, the
	classes' cases in BuildView 0x0025edd0-0x0025ee88); each function cites
	its origin.
*/

#ifndef __MATHVIEWS_H
#define __MATHVIEWS_H

#ifndef __CONTAINERVIEW_H
#include "ContainerView.h"
#endif

// what a TMathOpView draws (its mathOperator)
enum
{
	kMathPlus = 0,
	kMathMinus,
	kMathTimes,
	kMathSlash,
	kMathNothing
};


// 0x44 bytes in the ROM
class TMathExpView : public TContainerView
{
public:
	virtual long	ClassID(void) const;							// ROM 0x0011bb38 ClassID__12TMathExpViewCFv
	virtual Boolean	DerivedFrom(long id) const;						// ROM 0x0011bb40 DerivedFrom__12TMathExpViewCFl
	virtual void	Constructor(RefArg context, TView* parent);		// ROM 0x0011beac Constructor__12TMathExpViewFRC6RefVarP5TView
	virtual Boolean	RealDoCommand(RefArg cmd);						// ROM 0x0011bf98 RealDoCommand__12TMathExpViewFRC6RefVar
	virtual void	PreDraw(Rect& bounds);							// ROM 0x0011bf94 PreDraw__12TMathExpViewFR5TRect - TView's
	virtual void	RealDraw(Rect& bounds);							// ROM 0x0011bfe4 RealDraw__12TMathExpViewFR5TRect - nothing
	virtual long	HandleScrub(const Rect& bounds, long arg, TUnitPublic* unit, Boolean on);	// ROM 0x0011bfe8 HandleScrub__12TMathExpViewFRC5TRectlP11TUnitPublicUc
	virtual Ref		GetContext(void);								// ROM 0x0011c124 GetContext__12TMathExpViewFv - CopyForm

	RefStruct		fFamily;			// +0x38  viewFont's family
	long			fFace;				// +0x3c  ... face
	long			fSize;				// +0x40  ... size
};


// 0x34 bytes in the ROM
class TMathOpView : public TDataView
{
public:
	virtual long	ClassID(void) const;							// ROM 0x0011c12c ClassID__11TMathOpViewCFv
	virtual Boolean	DerivedFrom(long id) const;						// ROM 0x0011c134 DerivedFrom__11TMathOpViewCFl
	virtual void	Constructor(RefArg context, TView* parent);		// ROM 0x0011bb74 Constructor__11TMathOpViewFRC6RefVarP5TView
	virtual void	PreDraw(Rect& bounds);							// ROM 0x0011bbd4 PreDraw__11TMathOpViewFR5TRect - TView's
	virtual Boolean	RealDoCommand(RefArg cmd);						// ROM 0x0011bbd8 RealDoCommand__11TMathOpViewFRC6RefVar - TView's
	virtual void	RealDraw(Rect& bounds);							// ROM 0x0011bbdc RealDraw__11TMathOpViewFR5TRect

	long			fOperator;			// +0x30  mathOperator
};


// 0x38 bytes in the ROM
class TMathLineView : public TDataView
{
public:
	virtual long	ClassID(void) const;							// ROM 0x0011bd00 ClassID__13TMathLineViewCFv
	virtual Boolean	DerivedFrom(long id) const;						// ROM 0x0011bd08 DerivedFrom__13TMathLineViewCFl
	virtual void	Constructor(RefArg context, TView* parent);		// ROM 0x0011bd3c Constructor__13TMathLineViewFRC6RefVarP5TView
	virtual void	PreDraw(Rect& bounds);							// ROM 0x0011bda4 PreDraw__13TMathLineViewFR5TRect - TView's
	virtual Boolean	RealDoCommand(RefArg cmd);						// ROM 0x0011bda8 RealDoCommand__13TMathLineViewFRC6RefVar - TView's
	virtual void	RealDraw(Rect& bounds);							// ROM 0x0011bdac RealDraw__13TMathLineViewFR5TRect

	Rect			fLine;				// +0x30  mathLine
};

#endif	/* __MATHVIEWS_H */
