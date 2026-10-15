/*
	File:		host/HostQuickSheet.cpp

	Contains:	The quick sheet and the lock screen (HostQuickSheet.h).
*/

#include <stdio.h>
#include "HostQuickSheet.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "NativeFunctions.h"
#include "NewtonExceptions.h"

extern const char gHostQuickSheetSource[];		// HostQuickSheet.ns (HostQuickSheetSource.cpp, generated)

static void	(*gLockHook)(bool on) = nil;
static bool	gInstalled = false;


void
HostQuickSheetSetLockHook(void (*locked)(bool on))
{
	gLockHook = locked;
}


// HostScreenLocked(on): the lock screen opened (on true) or closed - the host told
static Ref
FHostScreenLocked(RefArg /*rcvr*/, RefArg on)
{
	fprintf(stderr, "[host] the screen %s\n", NOTNIL(on) ? "locked" : "unlocked");
	if (gLockHook != nil)
		gLockHook(NOTNIL(on));
	return TRUEREF;
}


void
HostInstallQuickSheet(void)
{
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "HostScreenLocked")), RefVar(MakeCFunction((void*) FHostScreenLocked, 1, nil)));
	newton_try
	{
		RefVar fn(ParseString(RefVar(MakeString(gHostQuickSheetSource))));
		RefVar sheet(InterpretBlock(fn, RefVar()));
		SetFrameSlot(RefVar(gVarFrame), RefVar(Intern((char*) "QuickSheet:host")), sheet);
		gInstalled = true;
	}
	newton_catch_all
	{
		fprintf(stderr, "[host] the quick sheet was not installed: %s\n", CurrentException()->name);
	}
	end_try;
}


void
HostQuickSheetPulled(void)
{
	if (!gInstalled)
		return;
	newton_try
	{
		RefVar sheet(GetFrameSlot(RefVar(gVarFrame), RefVar(Intern((char*) "QuickSheet:host"))));
		if (NOTNIL(sheet))
			NSSend(sheet, RefVar(Intern((char*) "Pulled")));
	}
	newton_catch_all
	{
		fprintf(stderr, "[host] the quick sheet did not open: %s\n", CurrentException()->name);
	}
	end_try;
}
