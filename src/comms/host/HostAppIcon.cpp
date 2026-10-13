/*
	File:		comms/host/HostAppIcon.cpp

	Contains:	HostRemoveAppIcon (HostAppIcon.h).

	Host code (no ROM counterpart).
*/

#include "HostAppIcon.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "ObjectHeap.h"
#include "Frames.h"
#include "NewtonExceptions.h"

#include <stdio.h>

// (the entries gathered first, then removed: a cursor moves on when its
// entry goes)
static const char kRemoveSource[] =
	"func(app) begin\n"
	"	local extras := GetUnionSoup(@307.name);\n"
	"	if not extras then return 0;\n"
	"	local found := [];\n"
	"	local cursor := Query(extras, {type: 'index});\n"
	"	local e;\n"
	"	while e := cursor:Entry() do begin\n"
	"		if e.app = app then AddArraySlot(found, e);\n"
	"		cursor:Next();\n"
	"	end;\n"
	"	foreach e in found do EntryRemoveFromSoupXmit(e, nil);\n"
	"	Length(found);\n"
	"end";


void
HostRemoveAppIcon(const char* appSymbol)
{
	newton_try
	{
		RefVar fn(InterpretBlock(RefVar(ParseString(RefVar(MakeString(kRemoveSource)))), RefVar()));
		RefVar args(MakeArray(1));
		SetArraySlot(args, 0, RefVar(Intern((char*) appSymbol)));
		RefVar removed(DoBlock(fn, args));
		if (ISINT(removed) && RINT(removed) > 0)
			fprintf(stderr, "[host] %s's icon taken out of Extras: its hardware is not here\n", appSymbol);
	}
	newton_catch_all
	{
		fprintf(stderr, "[host] %s's icon could not be looked for: %s\n", appSymbol, CurrentException()->name);
	}
	end_try;
}
