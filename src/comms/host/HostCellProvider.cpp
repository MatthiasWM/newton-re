/*
	File:		comms/host/HostCellProvider.cpp

	Contains:	HostCellProviderStart (HostCellProvider.h).

	Host code (no ROM counterpart).
*/

#include "HostCellProvider.h"
#include "HostCellular.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "ObjectHeap.h"
#include "Frames.h"
#include "NewtonExceptions.h"

#include <stdio.h>

extern const char gHostCellSource[];		// HostCell.ns (HostCellSource.cpp, generated)


void
HostCellProviderStart(void)
{
	if (!HostCellularStarted())
		return;
	newton_try
	{
		RefVar fn(ParseString(RefVar(MakeString(gHostCellSource))));
		RefVar provider(InterpretBlock(fn, RefVar()));
		SetFrameSlot(RefVar(gVarFrame), RefVar(Intern((char*) "HostCell:host")), provider);
		NSSend(provider, RefVar(Intern((char*) "Start")));
	}
	newton_catch_all
	{
		fprintf(stderr, "[host] the cellular provider did not start: %s\n", CurrentException()->name);
	}
	end_try;
}
