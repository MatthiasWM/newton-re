/*
	File:		comms/host/HostMeshApp.cpp

	Contains:	HostMeshAppStart (HostMeshApp.h).

	Host code (no ROM counterpart).
*/

#include "HostMeshApp.h"
#include "HostMesh.h"
#include "HostAppIcon.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "ObjectHeap.h"
#include "Frames.h"
#include "NewtonExceptions.h"

#include <stdio.h>

extern const char gHostMeshSource[];		// HostMesh.ns (HostMeshSource.cpp, generated)


void
HostMeshAppStart(void)
{
	if (!HostMeshStarted())
	{
		// (no radio: Mesh nowhere to be seen, though the store had it)
		HostRemoveAppIcon("Mesh:host");
		return;
	}
	newton_try
	{
		RefVar fn(ParseString(RefVar(MakeString(gHostMeshSource))));
		RefVar frame(InterpretBlock(fn, RefVar()));
		SetFrameSlot(RefVar(gVarFrame), RefVar(Intern((char*) "HostMesh:host")), frame);
		NSSend(frame, RefVar(Intern((char*) "Start")));
	}
	newton_catch_all
	{
		fprintf(stderr, "[host] the Mesh application did not start: %s\n", CurrentException()->name);
	}
	end_try;
}
