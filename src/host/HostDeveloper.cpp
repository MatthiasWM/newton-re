/*
	File:		host/HostDeveloper.cpp

	Contains:	The Developer preferences panel's host side (HostDeveloper.h).
*/

#include <stdio.h>
#include <string.h>
#include "HostDeveloper.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "NativeFunctions.h"
#include "NewtonExceptions.h"

extern const char gHostDeveloperSource[];		// HostDeveloper.ns (HostDeveloperSource.cpp, generated)

// where the panel writes the profile ("" : the console)
static char	gReportPath[512] = "";


void
HostDeveloperSetReportFile(const char* storePath)
{
	if (storePath != nil && storePath[0] != 0)
		snprintf(gReportPath, sizeof(gReportPath), "%s.nsprofile.txt", storePath);
	else
		snprintf(gReportPath, sizeof(gReportPath), "newton-nsprofile.txt");
}


// HostDeveloperReportPath() ==> the profile's file, or nil for the console
static Ref
FHostDeveloperReportPath(RefArg /*rcvr*/)
{
	if (gReportPath[0] == 0)
		return NILREF;
	return MakeString(gReportPath);
}


void
HostInstallDeveloper(void)
{
	RefVar functions(gFunctionFrame);
	SetFrameSlot(functions, RefVar(Intern((char*) "HostDeveloperReportPath")),
				 RefVar(MakeCFunction((void*) FHostDeveloperReportPath, 0, nil)));
	newton_try
	{
		RefVar fn(ParseString(RefVar(MakeString(gHostDeveloperSource))));
		RefVar developer(InterpretBlock(fn, RefVar()));
		SetFrameSlot(RefVar(gVarFrame), RefVar(Intern((char*) "HostDeveloper:host")), developer);
		NSSend(developer, RefVar(Intern((char*) "Start")));
	}
	newton_catch_all
	{
		fprintf(stderr, "[host] the Developer preferences panel did not start: %s\n", CurrentException()->name);
	}
	end_try;
}
