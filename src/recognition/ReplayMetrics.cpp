/*
	File:		recognition/ReplayMetrics.cpp

	Contains:	The recogniser's replay metrics (ReplayMetrics.h).

	Reconstructed from the MP2x00 US ROM; each function cites its origin.
*/

#include "ReplayMetrics.h"
#include "Arbiter.h"
#include "Controller.h"
#include "Recognizer.h"
#include "WordUnit.h"
#include "Words.h"				// gWordID
#include "UnitPublic.h"
#include "WordRecognizer.h"		// SetupXRD
#include "LetterShapes.h"		// LIBeginWeights, LIEndWeights
#include "TestAgent.h"			// TTestReporter, StdioOn/Off
#include "Unicode.h"
#include "SortTables.h"			// CompareStringNoCase
#include "REPTranslators.h"		// REPFormat (printf with %U), IntegerString
#include "Random.h"				// NewtonRand: the C library's rand
#include "Locale.h"				// SetCurrentLocale
#include "Frames.h"
#include "ObjectHeap.h"			// gVarFrame
#include "ROMConstants.h"		// Rtestfields
#include "RSSymbols.h"
#include "NewtonMemory.h"
#include "host/RomBugs.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


TTestReporter*	gReplayReporter = nil;				// ROM 0x0c104ecc gReplayReporter
char		gTestName[100];							// ROM 0x0c100bec gTestName
Boolean		TestConfigAdded = false;				// ROM 0x0c100bd4 TestConfigAdded
Boolean		gLearningOn = false;					// ROM 0x0c100be0 gLearningOn
ULong		gCorrectRate = 0;						// ROM 0x0c100be4 gCorrectRate
Boolean		gLearnCorrector = false;				// ROM 0x0c100be8 gLearnCorrector
Boolean		gTestDeferredRecognition = false;		// ROM 0x0c100c50 gTestDeferredRecognition
Boolean		gTestScaling = false;					// ROM 0x0c100c54 gTestScaling
Fixed		gScaleFactor = 0;						// ROM 0x0c100c58 gScaleFactor
Boolean		gTestCorrectorRecognition = false;		// ROM 0x0c100c5c gTestCorrectorRecognition
Boolean		CompleteTapFile = false;				// ROM 0x0c100c6c CompleteTapFile
long		gNumWordsInFile = 0;					// ROM 0x0c100c94 gNumWordsInFile
long		gNumWordsTallied = 0;					// ROM 0x0c100c98 gNumWordsTallied
long		gNumStrokesInFile = 0;					// ROM 0x0c100c9c gNumStrokesInFile
long		gNumStrokesTallied = 0;					// ROM 0x0c100ca0 gNumStrokesTallied

static const UniChar	unicodeAsterisk[] = { '*', 0 };	// ROM 0x0c100ca4 unicodeAsterisk
static const UniChar	unicodeSpace = ' ';				// ROM 0x0c100ca8 unicodeSpace


/*------------------------------------------------------------------------------
	The host's side of the output
------------------------------------------------------------------------------*/

// The ROM's sprintf, which has %U for a UniChar string: ==> the length
// written (the buffer's size bounds it on the host).
static long
Format(char* buffer, long size, const char* format, ...)
{
	va_list args;
	va_start(args, format);
	long length = REPFormat(buffer, size, format, args);
	va_end(args);
	return (length < size) ? length : size - 1;
}


// A unit type as %4.4s prints it on the big-endian Newton.
// DEVIATION: the ROM passes the word's address; on a little-endian host
// that would print it backwards.
struct TypeName
{
	char	fText[5];
	explicit TypeName(ULong type)
	{
		fText[0] = (char) (type >> 24);
		fText[1] = (char) (type >> 16);
		fText[2] = (char) (type >> 8);
		fText[3] = (char) type;
		fText[4] = 0;
	}
};


// DEVIATION: a line of the stats channel to the file NEWTON_REPLAY_STATS
// names, if any (opened the first time, appended to; the Newton's
// carriage returns written as newlines).
Boolean
ReplayStatsToFile(const char* line)
{
	static FILE* file = nil;
	static int state = -1;			// -1 not looked, 0 none, 1 open
	if (state < 0)
	{
		const char* name = getenv("NEWTON_REPLAY_STATS");
		file = (name != nil && *name != 0) ? fopen(name, "ab") : nil;
		state = (file != nil) ? 1 : 0;
	}
	if (state == 0)
		return false;
	for (const char* p = line; *p != 0; p++)
		fputc(*p == '\r' ? '\n' : *p, file);
	fflush(file);
	return true;
}


// What the ROM sends the stats channel itself (TTestReporter::TestFPrintf,
// kind 2: a message) with one string argument - and the host's file.
static void
ReporterPrintf(const char* format, const char* text)
{
	gReplayReporter->TestFPrintf(2, format, text);
	char line[512];
	snprintf(line, sizeof(line), format, text);
	ReplayStatsToFile(line);
}


/*------------------------------------------------------------------------------
	The measuring
------------------------------------------------------------------------------*/

// ROM 0x00090284 InitUnitTimingGlobals__Fv
// (The unit timing - the times PrintMetrics prints - is compiled out of
// this ROM: nothing to start.)
void
InitUnitTimingGlobals(void)
{ }


// ROM 0x00090288 HandleReplayUnit__FP6TArray
// The area's unit handler while the arbiter replays: anything but a single
// unit is measured (with stdio on, for PrintError's printf), and the
// arbiter told to arbitrate at once whatever is left.  ==> 1 (handled).
long
HandleReplayUnit(TArray* winners)
{
	if (winners->fCount == 1)
		return 1;
	StdioOn();
	WriteTapStats(winners);
	StdioOff();
	gArbiter->fArbitrateNow = true;
	return 1;
}


// ROM 0x000902d0 PrintMetrics__FP13ReplayMetrics
// One tab-separated line to the stats channel: the case, whether the
// strokes were covered, the kinds written and found, whether they agree,
// the time; for a case with words the word metrics (the count, the
// length written - or -1 for anything but a word covered exactly - what
// was written, the readings, strokes, box, first reading and score, and
// eight 0/1 columns: the right reading first, first counting a wrong
// first-letter case, in the first three, five, at all, likewise; -1 when
// not a word covered exactly), the two times and their sum, the flags;
// for a case with shapes the shape metrics likewise.
void
PrintMetrics(ReplayMetrics* m)
{
	char line[500];
	long at = Format(line, sizeof(line), "%d\t%d\t%c\t%c\t%d\t%d\t",
					 (int) m->fRecCase, (int) m->fCorrect, m->fExpectedKind, m->fFoundKind,
					 (int) m->fKindRight, (int) m->fTime);
	if (m->fRecCase & 4)
	{
		WordMetrics* w = &m->fWords;
		long length;
		int exact0, case0, exact3, case3, exact5, case5, exactAny, caseAny;
		if (m->fExpectedKind == 'W' && m->fCorrect != 0)
		{
			exact0 = w->fExactRank == 0;
			case0 = w->fCaseRank == 0;
			exact3 = w->fExactRank < 3;
			case3 = w->fCaseRank < 3;
			exact5 = w->fExactRank < 5;
			case5 = w->fCaseRank < 5;
			exactAny = w->fExactRank < 999;
			caseAny = w->fCaseRank < 999;
			length = w->fExpectedLength;
		}
		else
		{
			exact0 = case0 = exact3 = case3 = exact5 = case5 = exactAny = caseAny = -1;
			length = -1;
		}
		at += Format(line + at, sizeof(line) - at, "%ld\t%ld\t%U\t%ld\t%ld\t%ld\t%ld\t%U\t%ld\t",
					 w->fCount, length, w->fExpected, w->fInterpretations, w->fSubRange,
					 w->fWidth, w->fHeight, w->fFound, w->fScore);
		at += Format(line + at, sizeof(line) - at, "%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t",
					 exact0, case0, exact3, case3, exact5, case5, exactAny, caseAny);
		at += Format(line + at, sizeof(line) - at, "%ld\t%ld\t%ld\t", w->fTime, w->fTime2, w->fTime + w->fTime2);
		at += Format(line + at, sizeof(line) - at, "%ld\t", (long) w->fFlags);
	}
	if (m->fRecCase & 2)
	{
		ShapeMetrics* s = &m->fShapes;
		at += Format(line + at, sizeof(line) - at, "%ld\t%U\t%ld\t%ld\t%ld\t%ld\t%U\t%ld\t%ld\t",
					 s->fCount, s->fExpected, s->fInterpretations, s->fSubRange,
					 s->fWidth, s->fHeight, s->fFound, s->fMatch, s->fScore);
		at += Format(line + at, sizeof(line) - at, "%ld\t%ld\t%ld\t", s->fTime, s->fTime2, s->fTime + s->fTime2);
	}
	Format(line + at, sizeof(line) - at, "\r");
	PrintToStats(line);
}


// A UniChar string appended to a line, a space between when the line has
// something already.
// DEVIATION: cut at the field's length; the ROM runs on into the fields
// after it (it never has a line that long).
static void
AppendToLine(UniChar* line, const UniChar* word)
{
	long length = Ustrlen(line);
	if (length > 0 && length < kMetricsStringLength - 1)
		line[length++] = unicodeSpace;
	for ( ; length < kMetricsStringLength - 1 && *word != 0; length++, word++)
		line[length] = *word;
	line[length] = 0;
}


// ROM 0x000905d0 GatherExpectedMetrics__FP15TWordReplayUnitP13ReplayMetrics
// The metrics cleared and what was written put in.  The lines of words
// written and read are kept while the readings ran on past the last unit
// (the highest stroke they reached is not where it ended), so that a
// reading spanning two written words is seen against both; otherwise they
// start again.  Everything not yet known is -1 (or "*", or 999 for the
// ranks); the kinds start as '?' and '$'.
void
GatherExpectedMetrics(TWordReplayUnit* expected, ReplayMetrics* m)
{
	long highest = m->fWords.fLastStroke;
	if (highest == m->fLastStroke)
		memset(m, 0, sizeof(ReplayMetrics));
	else
	{
		UniChar expectedLine[kMetricsStringLength];
		UniChar foundLine[kMetricsStringLength];
		Ustrcpy(expectedLine, m->fWords.fExpectedLine);
		Ustrcpy(foundLine, m->fWords.fFoundLine);
		memset(m, 0, sizeof(ReplayMetrics));
		Ustrcpy(m->fWords.fExpectedLine, expectedLine);
		Ustrcpy(m->fWords.fFoundLine, foundLine);
		m->fWords.fLastStroke = highest;
	}
	m->fExpectedKind = '?';
	m->fFoundKind = '$';
	m->fTime = -1;
	m->fWords.fCount = -1;
	m->fWords.fExpectedLength = -1;
	Ustrcpy(m->fWords.fExpected, unicodeAsterisk);
	m->fWords.fInterpretations = -1;
	m->fWords.fSubRange = -1;
	m->fWords.fWidth = -1;
	m->fWords.fHeight = -1;
	Ustrcpy(m->fWords.fFound, unicodeAsterisk);
	m->fWords.fExactRank = 999;
	m->fWords.fScore = -1;
	m->fWords.fCaseRank = 999;
	m->fWords.fNoCaseRank = 999;
	m->fWords.f290 = -1;
	m->fShapes.fCount = -1;
	Ustrcpy(m->fShapes.fExpected, unicodeAsterisk);
	m->fShapes.fInterpretations = -1;
	m->fShapes.fSubRange = -1;
	m->fShapes.fWidth = -1;
	m->fShapes.fHeight = -1;
	Ustrcpy(m->fShapes.fFound, unicodeAsterisk);
	m->fShapes.fMatch = -1;
	m->fShapes.fScore = -1;

	m->fRecCase = expected->fRecCase;
	m->fTime = (long) expected->fTime;
	m->fSubCount = expected->SubCount();
	m->fLastStroke = expected->fMaxStroke;

	ULong type = expected->fExpectedType;
	const UniChar* text = *(UniChar**) expected->fExpected;
	if (type == 'GSHP')
	{
		m->fExpectedKind = 'G';
		Ustrcpy(m->fShapes.fExpected, text);
		return;
	}
	if (type != 'FRML' && type != 'WREC' && type != 'XRWR')
	{
		printf("GatherExpectedMetrics: unsupported expected->fType 0x%08X (%4.4s)\n",
			   (unsigned) type, TypeName(type).fText);		// (the ROM's \r a newline on the host's console)
		return;
	}
	m->fExpectedKind = 'W';
	Ustrcpy(m->fWords.fExpected, text);
	m->fWords.fExpectedLength = Ustrlen(m->fWords.fExpected);
	AppendToLine(m->fWords.fExpectedLine, m->fWords.fExpected);
}


// ROM 0x00090848 WriteTapStats__FP6TArray
// The winners measured.  The first may be a control string, which is
// obeyed and is all there is.  Otherwise each replayed unit - they must
// come first - is measured against the units over its strokes, as the
// area's recognition case says (shapes, words, or both), and the metrics
// printed; anything else among them is only an error while no replayed
// unit has been seen.
void
WriteTapStats(TArray* winners)
{
	if (gReplayReporter == nil)
	{
		PrintError("WriteTapStats:  NULL stats channel (gSFPtr or gReplayReporter).");
		return;
	}
	TArrayIterator iter;
	BestMatch* entry = (BestMatch*) winners->GetIterator(&iter);
	if (IsControlUnit((TWordReplayUnit*) entry->fUnit) != 0)
		return;

	Boolean sawOther = false;
	Boolean sawReplay = false;
	ReplayMetrics metrics;
	memset(&metrics, 0, sizeof(metrics));
	for (ULong i = 0; i < (ULong) iter.fCount && entry != nil; i++, entry = (BestMatch*) iter.GetNext())
	{
		TUnit* unit = entry->fUnit;
		if (unit->fType != kReplayUnit)
		{
			sawOther = true;
			if (!sawReplay)
			{
				char text[100];
				Format(text, sizeof(text), "INVALID UNIT in bestList in WriteTapStats(): type = %4.4s.  Expected WRPL.\r",
					   TypeName(unit->fType).fText);
				PrintError(text);
			}
			continue;
		}
		sawReplay = true;
		if (sawOther)
			PrintError("Found out-of-order WordReplayUnit in bestList in WriteTapStats()");
		TWordReplayUnit* expected = (TWordReplayUnit*) unit;
		GatherExpectedMetrics(expected, &metrics);
		gNumStrokesTallied += metrics.fSubCount;
		switch (expected->fRecCase)
		{
		case 2: case 3:
			GatherGraphicsMetrics(expected, winners, &metrics);
			break;
		case 4: case 5:
			GatherWordsMetrics(expected, winners, &metrics);
			break;
		case 6: case 7:
			GatherWordsGraphicsMetrics(expected, winners, &metrics);
			break;
		default:
			unit->DumpObject((char*) " fRecCase not recognized.  No metrics gathered:\r");
			break;
		}
		PrintMetrics(&metrics);
	}
	if (!sawReplay)
		PrintError("No WordReplayUnit(s) found in bestList in WriteTapStats()");
}


// ROM 0x00090b34 GetCorrespondingUnits__FUlN21P6TArrayT4PUcPlN47
// The winners of a type that start within the strokes first..last, copied
// to found.  chosen: one of them is the arbitration's own choice
// (kGatheredUnit); late: how many start after the first stroke; covered:
// they reach from the first stroke to the last; missed: 1 the first is
// not covered, 2 they run on past the last; lowest and highest follow
// the range they cover (lowest is only ever lowered: from the cleared
// metrics, never).  Units of the type that stop short of the last stroke
// are an error.
void
GetCorrespondingUnits(ULong first, ULong last, ULong type, TArray* winners, TArray* found, UChar* chosen,
					  long* missed, long* late, long* covered, long* lowest, long* highest)
{
	*chosen = 0;
	ULong low = 0xffffffff;
	ULong high = 0;
	long count = 0;
	*late = 0;
	*missed = 0;
	TArrayIterator iter;
	BestMatch* entry = (BestMatch*) winners->GetIterator(&iter);
	for (ULong i = 0; i < (ULong) iter.fCount; i++, entry = (BestMatch*) iter.GetNext())
	{
		TUnit* unit = entry->fUnit;
		if (unit->fType != type)
			continue;
		ULong start = unit->fMinStroke;
		if (start < first || start > last)
			continue;
		// (the ROM copies the ROM's 0x28 bytes of the entry)
		memcpy(found->AddEntry(), entry, sizeof(BestMatch));
		count++;
		if (first < (ULong) unit->fMinStroke)
			(*late)++;
		if (unit->TestFlags(kGatheredUnit))
			*chosen = 1;
		if ((ULong) unit->fMinStroke < low)
			low = unit->fMinStroke;
		if ((ULong) unit->fMaxStroke > high)
			high = unit->fMaxStroke;
	}
	*covered = (low <= first && high >= last) ? 1 : 0;
	if ((ULong) *highest < high)
		*highest = (long) high;
	if (low < (ULong) *lowest)
		*lowest = (long) low;
	if (first < low)
		*missed |= 1;
	if (last < high)
		*missed |= 2;
	if (count > 0 && high < last)
	{
		char text[100];
		Format(text, sizeof(text), "INSUFFICIENT UNITS FOUND OF TYPE %4.4s to cover strokes %d to %d\r",
			   TypeName(type).fText, (int) first, (int) last);
		PrintError(text);
	}
}


// ROM 0x00090d68 GatherWordsGraphicsMetrics__FP15TWordReplayUnitP6TArrayP13ReplayMetrics
// Words and shapes both looked for.  Correct: the kind written covers its
// strokes exactly; the kind found is the one the arbitration chose, when
// it chose one kind only (and that kind covers the strokes).
void
GatherWordsGraphicsMetrics(TWordReplayUnit* expected, TArray* winners, ReplayMetrics* m)
{
	TArray* words = TArray::Make(sizeof(BestMatch), 0);		// (the ROM's 0x28)
	TArray* shapes = TArray::Make(sizeof(BestMatch), 0);
	UChar wordChosen, shapeChosen;
	WordMetrics* w = &m->fWords;
	ShapeMetrics* s = &m->fShapes;
	GetCorrespondingUnits(expected->fMinStroke, expected->fMaxStroke, gWordID, winners, words, &wordChosen,
						  &w->fMissed, &w->fLate, &w->fCovered, &w->fFirstStroke, &w->fLastStroke);
	GetCorrespondingUnits(expected->fMinStroke, expected->fMaxStroke, kShapeUnit, winners, shapes, &shapeChosen,
						  &s->fMissed, &s->fLate, &s->fCovered, &s->fFirstStroke, &s->fLastStroke);
	char kind = m->fExpectedKind;
	if (kind == 'G')
		m->fCorrect = (s->fMissed == 0 && s->fLate == 0 && s->fCovered != 0) ? 1 : 0;
	else
		m->fCorrect = (kind == 'W' && w->fMissed == 0 && w->fLate == 0 && w->fCovered != 0) ? 1 : 0;
	if (wordChosen != 0)
	{
		if (shapeChosen == 0 && w->fCovered != 0)
			m->fFoundKind = 'W';
	}
	else if (shapeChosen != 0 && s->fCovered != 0)
		m->fFoundKind = 'G';
	m->fKindRight = (m->fFoundKind == kind) ? 1 : 0;
	GatherWordMetrics(words, m);
	GatherShapeMetrics(shapes, m);
	words->Dispose();
	shapes->Dispose();
}


// ROM 0x00090f30 GatherWordsMetrics__FP15TWordReplayUnitP6TArrayP13ReplayMetrics
void
GatherWordsMetrics(TWordReplayUnit* expected, TArray* winners, ReplayMetrics* m)
{
	TArray* words = TArray::Make(sizeof(BestMatch), 0);		// (the ROM's 0x28)
	UChar chosen;
	WordMetrics* w = &m->fWords;
	GetCorrespondingUnits(expected->fMinStroke, expected->fMaxStroke, gWordID, winners, words, &chosen,
						  &w->fMissed, &w->fLate, &w->fCovered, &w->fFirstStroke, &w->fLastStroke);
	m->fCorrect = (w->fMissed == 0 && w->fLate == 0 && w->fCovered != 0) ? 1 : 0;
	if (chosen != 0 && w->fCovered != 0)
		m->fFoundKind = 'W';
	m->fKindRight = (m->fFoundKind == m->fExpectedKind) ? 1 : 0;
	GatherWordMetrics(words, m);
	words->Dispose();
}


// ROM 0x00091024 GatherGraphicsMetrics__FP15TWordReplayUnitP6TArrayP13ReplayMetrics
// (A shape chosen is 'G' whether or not the shapes cover the strokes.)
void
GatherGraphicsMetrics(TWordReplayUnit* expected, TArray* winners, ReplayMetrics* m)
{
	TArray* shapes = TArray::Make(sizeof(BestMatch), 0);		// (the ROM's 0x28)
	UChar chosen;
	ShapeMetrics* s = &m->fShapes;
	GetCorrespondingUnits(expected->fMinStroke, expected->fMaxStroke, kShapeUnit, winners, shapes, &chosen,
						  &s->fMissed, &s->fLate, &s->fCovered, &s->fFirstStroke, &s->fLastStroke);
	m->fCorrect = (s->fMissed == 0 && s->fLate == 0 && s->fCovered != 0) ? 1 : 0;
	if (chosen != 0)
		m->fFoundKind = 'G';
	m->fKindRight = (m->fFoundKind == m->fExpectedKind) ? 1 : 0;
	GatherShapeMetrics(shapes, m);
	shapes->Dispose();
}


// ROM 0x0009110c GatherWordScoreTime__FP6TArrayP11WordMetrics
// How many word units, their first readings put on the line read, and
// the mean of their first scores (10000 for a unit with no reading).
void
GatherWordScoreTime(TArray* found, WordMetrics* w)
{
	long sum = 0;
	TArrayIterator iter;
	BestMatch* entry = (BestMatch*) found->GetIterator(&iter);
	w->fCount = iter.fCount;
	ULong count = (ULong) iter.fCount;
	for (ULong i = 0; i < count; i++, entry = (BestMatch*) iter.GetNext())
	{
		TStdWordUnit* unit = (TStdWordUnit*) entry->fUnit;
		if (unit->InterpretationCount() == 0)
			sum += 10000;
		else
		{
			AppendToLine(w->fFoundLine, *(UniChar**) unit->GetString(0));
			sum += unit->GetScore(0);
		}
	}
	if (count == 0)
		count = 1;
	w->fScore = (long) ((ULong) sum / count);
}


// ROM 0x00091228 MaybeDoLearning__FP12TStdWordUnitUl
// With learning on, the cursive recogniser taught the word as the writer
// would teach it.  A word read right first time is learnt as it was
// read.  A misreading is corrected gCorrectRate times in a hundred: the
// writer chooses the right reading - learnt, with its rank, when learning
// from the corrector is on and it was among the first five - or else
// leaves the misreading, which is learnt as it was read.
void
MaybeDoLearning(TStdWordUnit* unit, ULong rank)
{
	Boolean learn = false;
	ULong which = 0;
	if (!gLearningOn)
		return;
	if (rank != 0)
	{
		ULong chance = (ULong) (NewtonRand() % 100);
		if (chance >= gCorrectRate)
			learn = true;
		else if (gLearnCorrector && rank < 5)
		{
			which = rank;
			learn = true;
		}
		if (!learn)
			return;
	}
	TUnitPublic pub(unit, 0);
	RefVar info(pub.WordInfo());
	DoIndexedLearning('XRWR', info, which);
}


// ROM 0x000912f0 GatherRealWordMetrics__FP6TArrayP13ReplayMetrics
// The first word unit measured: its readings (none for an invalid unit),
// strokes and box; its first reading and score.  For a word written,
// where the right reading stood - exactly, counting the first reading
// with its first letter's case changed as right, and ignoring case - and
// the first five scores.  When the first reading's case-changed twin is
// not among the first five, the mean of the first two scores is kept (the
// second taken as 100 when there is only one).  Then the learning.
void
GatherRealWordMetrics(TArray* found, ReplayMetrics* m)
{
	WordMetrics* w = &m->fWords;
	Boolean caseTwin = false;
	TStdWordUnit* unit = (TStdWordUnit*) ((BestMatch*) found->GetEntry(0))->fUnit;
	ULong readings = 0;
	if (!unit->TestFlags(kInvalidUnit))
	{
		readings = unit->InterpretationCount();
		if (readings > 0)
		{
			Ustrcpy(w->fFound, *(UniChar**) unit->GetString(0));
			w->fScore = unit->GetScore(0);
		}
	}
	w->fInterpretations = readings;
	w->fSubRange = unit->fSubRange;
	FRect box;
	unit->GetBBox(&box);
	w->fWidth = (short) ((ULong) (box.right - box.left + 0x8000) >> 16);
	w->fHeight = (short) ((ULong) (box.bottom - box.top + 0x8000) >> 16);
	if (m->fExpectedKind != 'W')
		return;

	ULong exact = 999;
	ULong caseRank = 999;
	ULong noCase = 999;
	UniChar twin[kMetricsStringLength * 2];
	for (ULong i = 0; i < readings; i++)
	{
		const UniChar* reading = *(UniChar**) unit->GetString(i);
		if (i < exact && Ustrcmp(w->fExpected, reading) == 0)
		{
			exact = i;
			if (caseRank > i)
				caseRank = i;
			if (noCase > i)
				noCase = i;
		}
		else if (noCase > i && CompareStringNoCase(w->fExpected, reading) == 0)
			noCase = i;
		if (i == 0)
		{
			// the first reading with its first letter's case changed
			Ustrcpy(twin, reading);
			twin[0] = ToggleCase(reading[0]);
			if (twin[0] == reading[0])
				caseTwin = true;
			else if (Ustrcmp(w->fExpected, twin) == 0)
				caseRank = 0;
		}
		else
		{
			if (Ustrcmp(twin, reading) == 0 && i < 5)
				caseTwin = true;
			if (i >= 5)
				continue;
		}
		w->fScores[i] = unit->GetScore(i);
		w->fScoreCount++;
	}
	w->fExactRank = (long) exact;
	w->fCaseRank = (long) caseRank;
	w->fNoCaseRank = (long) noCase;
	if (w->fScoreCount >= 1 && !caseTwin)
	{
		long second = (w->fScoreCount < 2) ? 100 : w->fScores[1];
		w->fFirstTwo = (long) ((ULong) (w->fScores[0] + second) >> 1);
		w->fHasFirstTwo = 1;
	}
	if (readings > 0)
		MaybeDoLearning(unit, exact);
}


// ROM 0x0009159c GatherWordMetrics__FP6TArrayP13ReplayMetrics
// The word units counted and scored; one alone that covers the strokes is
// measured, and flagged when it covers them exactly.
void
GatherWordMetrics(TArray* found, ReplayMetrics* m)
{
	gNumWordsTallied++;
	GatherWordScoreTime(found, &m->fWords);
	if (m->fWords.fCount != 1)
		return;
	if (m->fWords.fCovered == 0)
		return;
	GatherRealWordMetrics(found, m);
	if (m->fWords.fMissed == 0)
		m->fWords.fFlags |= 0x100000;
}


// ROM 0x0009160c GatherShapeScoreTime__FP6TArrayP12ShapeMetrics
// How many shape units, and the mean of their first scores (10000 for a
// unit with no reading); the times nought.
void
GatherShapeScoreTime(TArray* found, ShapeMetrics* s)
{
	long sum = 0;
	TArrayIterator iter;
	BestMatch* entry = (BestMatch*) found->GetIterator(&iter);
	s->fCount = iter.fCount;
	ULong count = (ULong) iter.fCount;
	for (ULong i = 0; i < count; i++, entry = (BestMatch*) iter.GetNext())
	{
		TSIUnit* unit = (TSIUnit*) entry->fUnit;
		if (unit->InterpretationCount() == 0)
			sum += 10000;
		else
			sum += unit->GetScore(0);
	}
	if (count == 0)
		count = 1;
	s->fScore = (long) ((ULong) sum / count);
	s->fTime = 0;
	s->fTime2 = 0;
}


// ROM 0x000916d0 GatherRealShapeMetrics__FP6TArrayP13ReplayMetrics
// The first shape unit measured: its readings, strokes and box, and its
// first reading's type (as a number) against the one written, and score.
void
GatherRealShapeMetrics(TArray* found, ReplayMetrics* m)
{
	ShapeMetrics* s = &m->fShapes;
	TSIUnit* unit = (TSIUnit*) ((BestMatch*) found->GetEntry(0))->fUnit;
	long readings = unit->TestFlags(kInvalidUnit) ? 0 : unit->InterpretationCount();
	s->fInterpretations = readings;
	s->fSubRange = unit->fSubRange;
	FRect box;
	unit->GetBBox(&box);
	s->fWidth = (short) ((ULong) (box.right - box.left + 0x8000) >> 16);
	s->fHeight = (short) ((ULong) (box.bottom - box.top + 0x8000) >> 16);
	if (readings > 0)
	{
		IntegerString(unit->GetLabel(0), s->fFound);
		s->fMatch = (Ustrcmp(s->fExpected, s->fFound) == 0) ? 1 : 0;
		s->fScore = unit->GetScore(0);
	}
}


// ROM 0x000917e0 GatherShapeMetrics__FP6TArrayP13ReplayMetrics
// The shape units counted and scored; one alone that covers the strokes
// is measured.
void
GatherShapeMetrics(TArray* found, ReplayMetrics* m)
{
	GatherShapeScoreTime(found, &m->fShapes);
	if (m->fShapes.fCount != 1)
		return;
	if (m->fShapes.fCovered != 0)
		GatherRealShapeMetrics(found, m);
}


/*------------------------------------------------------------------------------
	The control strings
------------------------------------------------------------------------------*/

// ROM 0x00091824 SetTestName__FPc
// "**name" to the stats channel, and the test is "name Field".
void
SetTestName(const char* name)
{
	char line[100];
	snprintf(line, sizeof(line), "**%s\r", name);
	PrintToStats(line);
	snprintf(gTestName, sizeof(gTestName), "%s Field", name);
}


// ROM 0x0009187c SetLocale5__FPcUs
// A field read in a locale: the digit says which ('1' the U.S., '2'
// Canada, '3' French Canada, '4' the United Kingdom, '5' Australia; any
// other the U.S., and an error); the test is named for the locale and the
// field, and the locale put in force.
void
SetLocale5(const char* name, UShort digit)
{
	const char* locale;
	const char* prefix;
	switch (digit)
	{
	case '2':	locale = "Canada";					prefix = "CAN";		break;
	case '3':	locale = "Canada (French locale)";	prefix = "CANFr";	break;
	case '4':	locale = "United Kingdom";			prefix = "UK";		break;
	case '5':	locale = "Australia";				prefix = "AUS";		break;
	default:
		{
			char text[100];
			snprintf(text, sizeof(text), "INVALID LOCALE CODE DIGIT IN CONTROL FILE: 0x%04X.  Defaulting to U.S.", (unsigned) digit);
			PrintError(text);
		}
		// and on
	case '1':	locale = "U.S.";					prefix = "US";		break;
	}
	char test[32];
	snprintf(test, sizeof(test), "%s%s", prefix, name);
	SetTestName(test);
	SetCurrentLocale(RefVar(MakeString(locale)));
}


// ROM 0x000919f4 SetLocale4__FPcUs
// The same for a field with no French Canadian form: the digits past '2'
// mean the locale one further on.
void
SetLocale4(const char* name, UShort digit)
{
	if ((long) U_CONST_CHAR('2') < (long) digit)
		digit = (UShort) (digit + 1);
	SetLocale5(name, digit);
}


// ROM 0x00091a34 HandleControlString__FPUs
// A control string: "**" and then a digit -
//   0  learning off ("Turn Learning Off")
//   1  learning on ("Turn Learning On"), and the next digit how often the
//      writer corrects a misreading: 0 always, 1 never, 2 half the time,
//      3 a quarter, 4 three quarters
//   2  the cursive recogniser's letter weights reset
//   3  learning from the corrector on, and the learning as for 1
//   4  deferred recognition on (next digit 1) or off
//   5  recognition in a field: next digit 0 turns it off, 1 and then a
//      digit one of nine fields (honorific, first name, last name, title,
//      company, address, city, state, zip code), 2 and a digit one of five
//      (country, e-mail, phone, date, time) - with a locale digit after
//      it for those that read one - its recognition configuration put in
//      (AddTestConfig)
//   6  the ink scaled: next digit 0 off, 1 bigger or 2 smaller by the
//      digit after that in quarter powers of two (9 bigger: a hundredfold)
//   7  recognition in the corrector on (next digit 1) or off
// Each is announced on the stats channel, the counts of the file's words
// and strokes cleared, and the test begun.  ==> 1, 0 when it was no
// control string.
long
HandleControlString(UniChar* str)
{
	if (str[0] != U_CONST_CHAR('*') || str[1] != U_CONST_CHAR('*'))
		return 0;
	char text[200];
	Format(text, sizeof(text), "***Replay encountered control string: %U", str);
	ReporterPrintf("\xB4\xB4\xB4\xB4%s\r", text);
	gNumStrokesInFile = 0;
	gNumWordsInFile = 0;
	InitReplayStats();

	if (str[2] == U_CONST_CHAR('0'))
	{
		SetTestName("Turn Learning Off");
		gLearningOn = false;
		gLearnCorrector = false;
	}
	else if (str[2] == U_CONST_CHAR('1') || str[2] == U_CONST_CHAR('3'))
	{
		if (str[2] == U_CONST_CHAR('1'))
		{
			SetTestName("Turn Learning On");
			gLearnCorrector = false;
		}
		else
		{
			PrintToStats("**Turn Learning from corrector on\r ");
			gLearnCorrector = true;
		}
		gLearningOn = true;
		const char* said = nil;
		if (str[3] == U_CONST_CHAR('0'))
		{
			gCorrectRate = 100;
			said = "** learn correct (user always corrects)\r";
		}
		else if (str[3] == U_CONST_CHAR('1'))
		{
			gCorrectRate = 0;
			said = "** learn always (user never corrects)\r";
		}
		else if (str[3] == U_CONST_CHAR('2'))
		{
			gCorrectRate = 50;
			said = "** learn sometimes (user corrects 50%)\r";
		}
		else if (str[3] == U_CONST_CHAR('3'))
		{
			gCorrectRate = 25;
			said = "** learn sometimes (user corrects 25%)\r";
		}
		else if (str[3] == U_CONST_CHAR('4'))
		{
			gCorrectRate = 75;
			said = "** learn sometimes (user corrects 75%)\r";
		}
		if (said != nil)
			PrintToStats(said);
	}
	else if (str[2] == U_CONST_CHAR('2'))
	{
		PrintToStats("**Reset weights\r");
		Handle weights = LIBeginWeights();
		TDomain* domain = gController->GetTypedDomain('XRWR');
		SetupXRD(domain, weights, 0, 0);
		domain->DomainParameter(0x20015, 0, (ULong) (uintptr_t) weights);
		LIEndWeights(weights);
	}
	else if (str[2] == U_CONST_CHAR('4'))
	{
		if (str[3] == U_CONST_CHAR('1'))
		{
			PrintToStats("**Turn on deferred recognition\r ");
			gTestDeferredRecognition = true;
		}
		else
		{
			PrintToStats("**Turn off deferred recognition\r ");
			gTestDeferredRecognition = false;
		}
	}

	if (str[2] == U_CONST_CHAR('5'))
	{
		PrintToStats("**Recognition in fields\r");
		if (TestConfigAdded)
		{
			RemoveTestConfig();
			TestConfigAdded = false;
		}
		if (str[3] == U_CONST_CHAR('0'))
			PrintToStats("**Turn off\r");
		else
		{
			long field = -1;
			if (str[3] == U_CONST_CHAR('1'))
			{
				if (str[4] == U_CONST_CHAR('1'))		{ SetTestName("Honorific");		field = 0; }
				else if (str[4] == U_CONST_CHAR('2'))	{ SetTestName("FirstName");		field = 1; }
				else if (str[4] == U_CONST_CHAR('3'))	{ SetTestName("LastName");		field = 2; }
				else if (str[4] == U_CONST_CHAR('4'))	{ SetTestName("Title");			field = 3; }
				else if (str[4] == U_CONST_CHAR('5'))	{ SetLocale4("Company", str[5]);	field = 4; }
				else if (str[4] == U_CONST_CHAR('6'))	{ SetTestName("Address");		field = 5; }
				else if (str[4] == U_CONST_CHAR('7'))	{ SetLocale5("City", str[5]);	field = 6; }
				else if (str[4] == U_CONST_CHAR('8'))	{ SetLocale4("State", str[5]);	field = 7; }
				else if (str[4] == U_CONST_CHAR('9'))	{ SetTestName("ZipCode");		field = 8; }
			}
			else if (str[3] == U_CONST_CHAR('2'))
			{
				if (str[4] == U_CONST_CHAR('0'))		{ SetTestName("Country");		field = 9; }
				else if (str[4] == U_CONST_CHAR('1'))	{ SetTestName("E-Mail");		field = 10; }
				else if (str[4] == U_CONST_CHAR('2'))	{ SetLocale5("Phone", str[5]);	field = 11; }
				else if (str[4] == U_CONST_CHAR('3'))	{ SetLocale5("Date", str[5]);	field = 12; }
				else if (str[4] == U_CONST_CHAR('4'))	{ SetLocale5("Time", str[5]);	field = 13; }
			}
			if (field >= 0)
			{
				AddTestConfig((ULong) field);
				TestConfigAdded = true;
			}
		}
	}
	else if (str[2] == U_CONST_CHAR('6'))
	{
		PrintToStats("**Scaling (resizing) ink\r");
		if (str[3] == U_CONST_CHAR('0'))
		{
			PrintToStats("**Turning scaling off\r");
			gTestScaling = false;
			gScaleFactor = 0x10000;
		}
		else if (str[3] == U_CONST_CHAR('1') || str[3] == U_CONST_CHAR('2'))
		{
			long n = (long) str[4] - (long) U_CONST_CHAR('0');
			if (n >= 1 && n <= 9)
			{
				gTestScaling = true;
				if (str[3] == U_CONST_CHAR('2'))
					n = -n;
				if (n == 9)
					gScaleFactor = 0x640000;		// a hundredfold
				else
				{
					// 2 to the power n/4: the fraction's quarter power from
					// a table, shifted by the whole part
					switch (n & 3)
					{
					case 0: gScaleFactor = 0x10000;				break;
					case 1: gScaleFactor = 0x1306f;	n -= 1;		break;		// 2^0.25
					case 2: gScaleFactor = 0x16a09;	n -= 2;		break;		// 2^0.5
					case 3: gScaleFactor = 0x1ae89;	n -= 3;		break;		// 2^0.75
					}
					long shift = n / 4;
					// ROM BUG (fixed): the whole part is shifted left by
					// whatever it is - for the smaller sizes a negative
					// number, which as a register shift is 255 and leaves
					// nought, so every smaller scale comes out as 0.  The
					// fix shifts right by as much.
					if (shift >= 0)
						gScaleFactor = (Fixed) ((ULong) gScaleFactor << shift);
					else if (RomBugFixed())
						gScaleFactor = gScaleFactor >> -shift;
					else
						gScaleFactor = 0;
				}
				char line[200];
				snprintf(line, sizeof(line), "**Turning scaling on: scale factor %9.4f\r", (double) gScaleFactor / 65536.0);
				PrintToStats(line);
			}
		}
	}
	else if (str[2] == U_CONST_CHAR('7'))
	{
		if (str[3] == U_CONST_CHAR('1'))
		{
			PrintToStats("**Recognition in corrector\r ");
			gTestCorrectorRecognition = true;
			CompleteTapFile = true;
		}
		else
		{
			PrintToStats("**Turn off corrector recognition\r ");
			gTestCorrectorRecognition = false;
			RemoveTestConfig();
		}
	}

	snprintf(text, sizeof(text), "Beginning test: %s", gTestName);
	ReporterPrintf("\xB4\xB4\xB4\xB4%s\r", text);
	return 1;
}


// ROM 0x00092410 IsControlUnit__FP15TWordReplayUnit
// A replayed unit whose text starts "**" is a control string and is
// obeyed - unless it is 100 characters or more, which is an error.
// ==> whether it was one.
long
IsControlUnit(TWordReplayUnit* unit)
{
	if (unit->fType != kReplayUnit)
		return 0;
	const UniChar* text = *(UniChar**) unit->fExpected;
	if (text[0] != U_CONST_CHAR('*') || text[1] != U_CONST_CHAR('*'))
		return 0;
	if ((ULong) Ustrlen(text) < 100)
	{
		UniChar str[100];
		Ustrcpy(str, text);
		return HandleControlString(str);
	}
	char line[100];
	snprintf(line, sizeof(line), "CONTROL STRING EXCEEDS BUFFER SIZE (%d).  Must ignore control string.", 100);
	PrintError(line);
	Format(line, sizeof(line), "STRING: \"%.60U...\"", text);
	PrintError(line);
	return 1;
}


// ROM 0x00092544 InitReplayStats__Fv
// (The unit timing's start - nothing in this ROM.)
void
InitReplayStats(void)
{
	InitUnitTimingGlobals();
}


// ROM 0x00092548 PrintToStats__FPc
// A line to the stats channel.
void
PrintToStats(const char* text)
{
	ReporterPrintf("%s", text);
}


// ROM 0x00092568 PrintError__FPc
// An error to the stats channel, if there is one, and to stdio.
// (DEVIATION: the ROM's carriage return is a newline on the host's
// console.)
void
PrintError(const char* text)
{
	StdioOn();
	if (gReplayReporter != nil)
		ReporterPrintf("ERROR: %s\r", text);
	printf("ERROR: %s\n", text);
	StdioOff();
}


// ROM 0x00034a1c AddTestConfig__FUl
// The user configuration's testConfig - which every recognition
// configuration is read against (RecConfig.cpp) - set to the field's
// entry of testFields, and the recognition options read again.
void
AddTestConfig(ULong field)
{
	RefVar userConfig(GetFrameSlot(RefVar(gVarFrame), RefVar(RSSYMuserconfiguration)));
	RefVar config(GetArraySlot(RefVar(Rtestfields), (long) field));
	SetFrameSlot(userConfig, RefVar(RSSYMtestconfig), config);
	FReadCursiveOptions(RefVar(NILREF));
}


// ROM 0x00034ad0 RemoveTestConfig__Fv
void
RemoveTestConfig(void)
{
	RefVar userConfig(GetFrameSlot(RefVar(gVarFrame), RefVar(RSSYMuserconfiguration)));
	SetFrameSlot(userConfig, RefVar(RSSYMtestconfig), RefVar(NILREF));
	FReadCursiveOptions(RefVar(NILREF));
}


// ROM 0x002527ac ExportReporter__FP13TTestReporter
// (Nothing in the ROM calls it: Apple's test did.)
void
ExportReporter(TTestReporter* reporter)
{
	gReplayReporter = reporter;
}
