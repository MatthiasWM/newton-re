/*
	File:		recognition/WordReplay.cpp

	Contains:	The host's 'WRPL' domain and recogniser (WordReplay.h).

	DEVIATION: host code throughout; nothing here is in the ROM.
*/

#include "WordReplay.h"
#include "Arbiter.h"
#include "Controller.h"
#include "Areas.h"
#include "RSSymbols.h"
#include "Frames.h"
#include "Unicode.h"
#include "NewtonMemory.h"
#include "OSErrors.h"
#include "Interpreter.h"		// GetVariable

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// the words being replayed
static ReplayLabel*	sLabels = nil;
static long			sLabelCount = 0;
static UShort		sBaseStroke = 0;		// the controller's number for the replay's first stroke
static long			sMade = 0;				// replayed units made
static long			sLive = 0;				// ... and not yet let go
static TWordReplayDomain*	sDomain = nil;

static Boolean
Tracing(void)
{
	static int tracing = -1;
	if (tracing < 0)
		tracing = getenv("NEWTON_TRACE_REPLAY") != nil ? 1 : 0;
	return tracing != 0;
}


/*------------------------------------------------------------------------------
	T W o r d R e p l a y U n i t
------------------------------------------------------------------------------*/

// A replayed unit over strokes yet to be added: what was written (a copy
// of the text in a handle of its own) and one reading, labelled 0 and
// scored 9999.  (A unit with no reading scores 0 to GetBestInterpretation
// and would beat every real reading in an arbitration by score; at 9999
// it beats none.)  ==> 0, or 1 for no memory.
long
TWordReplayUnit::IWordReplayUnit(TDomain* domain, ULong kind, TArray* areas, ULong expectedType, const UniChar* expected)
{
	ISIUnit(domain, kReplayUnit, kind, areas, sizeof(UnitInterpretation));
	fExpectedType = expectedType;
	fRecCase = 0;
	fTime = 0;
	fLabel = -1;
	fStrokesWanted = 0;
	long length = Ustrlen(expected);
	fExpected = NewHandle((length + 1) * sizeof(UniChar));
	if (fExpected == nil)
		return 1;
	Ustrcpy(*(UniChar**) fExpected, expected);
	UnitInterpretation interp;
	interp.label = 0;
	interp.score = 9999;
	interp.angle = 0;
	interp.param = nil;
	if (AddInterpretation((char*) &interp) == -1)
		return 1;
	sMade++;
	sLive++;
	return 0;
}


void
TWordReplayUnit::IDispose(void)
{
	if (fExpected != nil)
	{
		DisposeHandle(fExpected);
		fExpected = nil;
		sLive--;
	}
	TSIUnit::IDispose();
}


/*------------------------------------------------------------------------------
	T W o r d R e p l a y D o m a i n
------------------------------------------------------------------------------*/

TWordReplayDomain*
TWordReplayDomain::Make(TController* controller)
{
	TWordReplayDomain* domain = new TWordReplayDomain;
	if (domain != nil)
		domain->IWordReplayDomain(controller);
	return domain;
}


// 'WRPL' out of 'STRK' pieces, held back (as long as a unit can be) until
// its last stroke comes - then ended at once.
void
TWordReplayDomain::IWordReplayDomain(TController* controller)
{
	IDomain(controller, kReplayUnit, (char*) "WordReplay Domain");
	AddPieceType(kStrokeUnit);
	fDelay = 0xff;
	fController = controller;
	*(TDomain**) controller->fDomains->AddEntry() = this;
	controller->fDomains->Compact();
}


// Which of the journal's words a stroke is in, from the controller's
// number for it: ==> its index, -1 for none (and the word's first stroke).
static long
LabelOfStroke(ULong strokeNumber, long* firstStroke)
{
	long index = (UShort) (strokeNumber - sBaseStroke);
	long start = 0;
	for (long i = 0; i < sLabelCount; i++)
	{
		if (index < start + sLabels[i].fStrokes)
		{
			*firstStroke = start;
			return i;
		}
		start += sLabels[i].fStrokes;
	}
	return -1;
}


// A stroke put into the replayed unit of the word it belongs to: the
// unit being built, if it is that word's, or a new one (and any other
// still open ended).  The unit is ended when it has all its strokes.
// ==> 1: the stroke is dealt with (a stroke of no word is ignored).
long
TWordReplayDomain::Group(TUnit* unit, dInfoRec* /*info*/)
{
	if (gArbiter == nil || !gArbiter->fReplaying || sLabels == nil)
		return 1;
	long first;
	long label = LabelOfStroke(unit->fMinStroke, &first);
	if (label < 0)
		return 1;
	TUnitList* delayed = fController->GetDelayList(this, kReplayUnit);
	if (delayed == nil)
		return 0;
	TWordReplayUnit* replay = nil;
	for (ULong i = 0; i < (ULong) delayed->Count(); i++)
	{
		TWordReplayUnit* open = (TWordReplayUnit*) delayed->GetUnit(i);
		if (open->fLabel == label)
			replay = open;
		else
			open->EndSubs();
	}
	delayed->Dispose();

	if (replay == nil)
	{
		TAreaList* areas = unit->GetAreas();
		replay = new TWordReplayUnit;
		if (replay != nil && replay->IWordReplayUnit(this, unit->fKind + 1, (TArray*) areas,
													 sLabels[label].fType, sLabels[label].fText) != 0)
		{
			replay->Dispose();
			replay = nil;
		}
		if (areas != nil)
			areas->Dispose();
		if (replay == nil)
			return 0;
		replay->fLabel = label;
		replay->fStrokesWanted = sLabels[label].fStrokes;
		if (replay->AddSub(unit) == -1)
			return 0;
		fController->NewGroup(replay);
	}
	else if (replay->AddSub(unit) == -1)
		return 0;
	if (Tracing())
		fprintf(stderr, "[replay] stroke %u is word %ld's %ld of %ld\n", (unsigned) unit->fMinStroke,
				label, replay->SubCount(), replay->fStrokesWanted);
	if (replay->SubCount() >= replay->fStrokesWanted)
		replay->EndSubs();
	return 1;
}


// A replayed unit finished: handed on, to be arbitrated with the rest.
void
TWordReplayDomain::Classify(TUnit* unit)
{
	((TSIUnit*) unit)->EndUnit();
	if (Tracing())
		fprintf(stderr, "[replay] word %ld (strokes %u..%u) ready\n", ((TWordReplayUnit*) unit)->fLabel,
				(unsigned) unit->fMinStroke, (unsigned) unit->fMaxStroke);
	fController->NewClassification(unit);
}


/*------------------------------------------------------------------------------
	T W o r d R e p l a y R e c o g n i z e r
------------------------------------------------------------------------------*/

// While replaying, an area that takes words or shapes takes replayed units
// too, arbitrated at once (as the words and shapes are) and handed to the
// unit handler - which in replay mode is HandleReplayUnit.
long
TWordReplayRecognizer::EnableArea(TRecArea* area, RefArg config)
{
	if (gArbiter == nil || !gArbiter->fReplaying)
		return 0;
	ULong mask = RINT(RefVar(GetVariable(config, RSSYMinputmask, nil, 0)));
	if ((mask & (kWRecServices | 0x10000)) != 0)
		area->AddAType(ID(), gRecognition.fUnitHandler, ArbitrateTime(), nil);
	return 0;
}


void
InstallWordReplayRecognizer(TRecognitionManager* manager)
{
	sDomain = TWordReplayDomain::Make(manager->fController);
	if (sDomain == nil)
		return;
	TRecognizer* recognizer = new TWordReplayRecognizer;
	recognizer->Init(sDomain, kReplayUnit, 0, kRecognizerArbitrated, kArbitrateAtOnce);
	recognizer->InitServices(0, 0);
	manager->fRecognizers->AddRecognizer(recognizer);
}


/*------------------------------------------------------------------------------
	T h e   r e p l a y
------------------------------------------------------------------------------*/

NewtonErr
WordReplayStart(const ReplayLabel* labels, long count)
{
	if (sDomain == nil || gArbiter == nil || gController == nil)
		return -10007;			// (kOSErrNoMemory)
	if (sLabels != nil)
		DisposePtr((Ptr) sLabels);
	sLabels = (ReplayLabel*) NewPtr(count * sizeof(ReplayLabel) + 1);
	if (sLabels == nil)
	{
		sLabelCount = 0;
		return -10007;			// (kOSErrNoMemory)
	}
	memcpy(sLabels, labels, count * sizeof(ReplayLabel));
	sLabelCount = count;
	sBaseStroke = gController->fNextStroke;
	sMade = 0;
	gArbiter->fReplaying = true;
	gArbiter->fCase = 0;
	PurgeAreaCache();
	if (Tracing())
		fprintf(stderr, "[replay] %ld words from stroke %u\n", count, (unsigned) sBaseStroke);
	return noErr;
}


void
WordReplayStop(void)
{
	if (gArbiter != nil)
		gArbiter->fReplaying = false;
	PurgeAreaCache();
	if (sLabels != nil)
		DisposePtr((Ptr) sLabels);
	sLabels = nil;
	sLabelCount = 0;
}


Boolean
WordReplayBusy(void)
{
	return sLabels != nil && (sMade < sLabelCount || sLive > 0);
}


long
WordReplayMade(void)
{
	return sMade;
}
