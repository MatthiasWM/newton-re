/*
	File:		recognition/ReplayMetrics.h

	Contains:	The recogniser's replay metrics: Apple's recognition
				accuracy harness, which measured what the recognisers made
				of recorded writing against what the writer had written.

				Recorded writing ("TAP files": ink with the text each word
				was) was played back through the recognisers with the
				arbiter put in its replay mode (TArbiter::fReplaying).  A
				domain of Apple's test tools made a *replayed unit* - a
				TWordReplayUnit, 'WRPL' - over each word's strokes,
				carrying the text (or the shape) that was written there.
				In replay mode the arbiter lets the replayed units win
				beside everything else gathered over the same strokes
				(ArbitrateUnits), stamps them with the area's recognition
				case and the time (SetCaseAndTime), and hands the lot to
				the area's unit handler - which in replay mode is
				`HandleReplayUnit` (FindMatchingArea, MakeCharArea), not
				HandleUnit: nothing reaches the views.

				`WriteTapStats` then measures each replayed unit against
				the units of the word recogniser in use (gWordID) and of
				the shape recogniser ('GSHP') over the same strokes
				(`GetCorrespondingUnits`): whether they cover exactly
				those strokes, the readings and where the right one stood
				among them (exactly, with only the first letter's case
				wrong, ignoring case), the scores, the boxes, and - with
				learning on - teaches the cursive recogniser the word as a
				user correcting it would (`MaybeDoLearning`).
				`PrintMetrics` writes one tab-separated line per replayed
				unit to the stats channel, gReplayReporter, a test
				reporter (testing/TestAgent.h) that Apple's test exported
				(`ExportReporter`).

				A replayed unit whose text begins "**" is a control
				string, not a word (`IsControlUnit`,
				`HandleControlString`): it turns learning on or off and
				says how often the simulated writer corrects a misreading,
				resets the cursive recogniser's letter weights, turns
				deferred recognition or corrector recognition on, sets the
				field the writing is in (a recognition configuration from
				`testFields`, and the locale for the fields that read it),
				or scales the ink - each announced on the stats channel.

				The ROM has the measuring, but not what made the replayed
				units or set the replay mode: those were Apple's test
				tools, outside the ROM.  The host's stand-in is
				WordReplay.h (the 'WRPL' domain and recogniser, fed by the
				journal: testing/Journal.h, JournalReplayWords).

	DEVIATION: everything written to the stats channel also goes, a line at
	a time, to the file NEWTON_REPLAY_STATS names (the ROM's channel went
	to Apple's desktop test server, which the host has not got;
	PrintError's printf reaches the host's console as it is).  A unit
	type printed with %4.4s is printed as its four characters on every
	host.

	Reconstructed from the MP2x00 US ROM (0x00090284-0x000925c0, with
	AddTestConfig/RemoveTestConfig 0x00034a1c-0x00034b70 and
	ExportReporter 0x002527ac); each function cites its origin.
*/

#ifndef __REPLAYMETRICS_H
#define __REPLAYMETRICS_H

#include "Unit.h"

class TTestReporter;
class TStdWordUnit;


/*------------------------------------------------------------------------------
	T W o r d R e p l a y U n i t
	What was written over some strokes.  The ROM has no class of this name
	(Apple's test tools made them): its layout is what the ROM's metrics
	read of it - the offsets in the comments.
------------------------------------------------------------------------------*/

class TWordReplayUnit : public TSIUnit
{
public:
	long				IWordReplayUnit(TDomain* domain, ULong kind, TArray* areas, ULong expectedType, const UniChar* expected);	// host
	virtual void		IDispose(void);							// host: the text given back

	ULong				fExpectedType;	// +0x64  what was written: 'WREC', 'XRWR' or 'FRML' a word, 'GSHP' a shape (its type number as text)
	Handle				fExpected;		// +0x6c  the text, a UniChar string
	ULong				fRecCase;		// +0x70  the area's recognition case (SetCaseAndTime)
	ULong				fTime;			// +0x74  (SetCaseAndTime)
	long				fLabel;			// host: which of the journal's words this is
	long				fStrokesWanted;	// host: how many strokes it is written in
};


/*------------------------------------------------------------------------------
	R e p l a y M e t r i c s
	One replayed unit measured (0x3cc bytes in the ROM; the host's longs
	may be wider, so the offsets are the ROM's).
------------------------------------------------------------------------------*/

#define kMetricsStringLength	64		// UniChars: 0x80 bytes

struct WordMetrics							// +0x1c of ReplayMetrics
{
	long		fCount;				// +0x000 (0x01c)  word units found over the strokes (-1 none looked for)
	long		fExpectedLength;	// +0x004 (0x020)
	UniChar		fExpected[kMetricsStringLength];		// +0x008 (0x024)  what was written ("*" for none)
	UniChar		fExpectedLine[kMetricsStringLength];	// +0x088 (0x0a4)  ... and the words before it, while the readings ran on past them
	long		fInterpretations;	// +0x108 (0x124)  the first unit's readings
	long		fSubRange;			// +0x10c (0x128)  its strokes
	long		fWidth;				// +0x110 (0x12c)  its box, in pixels
	long		fHeight;			// +0x114 (0x130)
	UniChar		fFound[kMetricsStringLength];			// +0x118 (0x134)  its first reading
	UniChar		fFoundLine[kMetricsStringLength];		// +0x198 (0x1b4)  every unit's first reading, spaced
	long		fScore;				// +0x218 (0x234)  the mean of the units' first scores, then the first unit's
	long		fExactRank;			// +0x21c (0x238)  where the right reading stood (999 nowhere)
	long		fCaseRank;			// +0x220 (0x23c)  ... counting the first reading with its first letter's case changed
	long		fNoCaseRank;		// +0x224 (0x240)  ... ignoring case
	long		f244;				// +0x228 (0x244)
	long		fScoreCount;		// +0x22c (0x248)  scores kept (at most five)
	long		fScores[5];			// +0x230 (0x24c)  the first readings' scores
	long		fFirstTwo;			// +0x244 (0x260)  the mean of the first two scores (the second 100 when there is one only)
	long		fHasFirstTwo;		// +0x248 (0x264)
	long		fLate;				// +0x24c (0x268)  units starting after the first stroke
	long		fMissed;			// +0x250 (0x26c)  1: the first stroke is not covered, 2: the units run on past the last
	long		fCovered;			// +0x254 (0x270)  the units cover the strokes, first to last
	long		fFirstStroke;		// +0x258 (0x274)  the lowest stroke they start at (it starts at 0: always 0)
	long		fLastStroke;		// +0x25c (0x278)  the highest stroke they end at
	long		fTime;				// +0x260 (0x27c)  (the unit timing, compiled out of this ROM: 0)
	long		fTime2;				// +0x264 (0x280)
	long		f284;				// +0x268 (0x284)
	long		f288;				// +0x26c (0x288)
	ULong		fFlags;				// +0x270 (0x28c)  0x100000: the units cover the strokes exactly
	long		f290;				// +0x274 (0x290)  (-1)
};

struct ShapeMetrics							// +0x294 of ReplayMetrics
{
	long		fCount;				// +0x000 (0x294)  shape units found over the strokes (-1 none looked for)
	UniChar		fExpected[kMetricsStringLength];		// +0x004 (0x298)  the shape written, its type as a number
	long		fInterpretations;	// +0x084 (0x318)
	long		fSubRange;			// +0x088 (0x31c)
	long		fWidth;				// +0x08c (0x320)
	long		fHeight;			// +0x090 (0x324)
	UniChar		fFound[kMetricsStringLength];			// +0x094 (0x328)  the first unit's type, as a number
	long		fMatch;				// +0x114 (0x3a8)  it is the one written
	long		fScore;				// +0x118 (0x3ac)
	long		fLate;				// +0x11c (0x3b0)
	long		fMissed;			// +0x120 (0x3b4)
	long		fCovered;			// +0x124 (0x3b8)
	long		fFirstStroke;		// +0x128 (0x3bc)
	long		fLastStroke;		// +0x12c (0x3c0)
	long		fTime;				// +0x130 (0x3c4)  (0)
	long		fTime2;				// +0x134 (0x3c8)  (0)
};

struct ReplayMetrics
{
	ULong		fRecCase;			// +0x000  the area's recognition case: +4 words, +2 shapes, the scrubs
	long		fCorrect;			// +0x004  the units of the kind written cover exactly its strokes
	long		fKindRight;			// +0x008  the kind found is the kind written
	char		fExpectedKind;		// +0x00c  'W' a word, 'G' a shape, '?'
	char		fFoundKind;			// +0x00d  what the arbitration chose: 'W', 'G', or '$' neither
	long		fTime;				// +0x010
	long		fSubCount;			// +0x014  strokes written
	long		fLastStroke;		// +0x018  the last of them
	WordMetrics	fWords;				// +0x01c
	ShapeMetrics fShapes;			// +0x294
};


/*------------------------------------------------------------------------------
	T h e   m e a s u r i n g
------------------------------------------------------------------------------*/

void	InitUnitTimingGlobals(void);				// ROM 0x00090284 InitUnitTimingGlobals__Fv (nothing: the unit timing is compiled out)
long	HandleReplayUnit(TArray* winners);			// ROM 0x00090288 HandleReplayUnit__FP6TArray - the area's unit handler while replaying: ==> 1
void	PrintMetrics(ReplayMetrics* metrics);		// ROM 0x000902d0 PrintMetrics__FP13ReplayMetrics
void	GatherExpectedMetrics(TWordReplayUnit* expected, ReplayMetrics* metrics);	// ROM 0x000905d0 GatherExpectedMetrics__FP15TWordReplayUnitP13ReplayMetrics
void	WriteTapStats(TArray* winners);				// ROM 0x00090848 WriteTapStats__FP6TArray
void	GetCorrespondingUnits(ULong first, ULong last, ULong type, TArray* winners, TArray* found, UChar* chosen,
							  long* missed, long* late, long* covered, long* lowest, long* highest);	// ROM 0x00090b34 GetCorrespondingUnits__FUlN21P6TArrayT4PUcPlN47
void	GatherWordsGraphicsMetrics(TWordReplayUnit* expected, TArray* winners, ReplayMetrics* metrics);	// ROM 0x00090d68 GatherWordsGraphicsMetrics__FP15TWordReplayUnitP6TArrayP13ReplayMetrics
void	GatherWordsMetrics(TWordReplayUnit* expected, TArray* winners, ReplayMetrics* metrics);	// ROM 0x00090f30 GatherWordsMetrics__FP15TWordReplayUnitP6TArrayP13ReplayMetrics
void	GatherGraphicsMetrics(TWordReplayUnit* expected, TArray* winners, ReplayMetrics* metrics);	// ROM 0x00091024 GatherGraphicsMetrics__FP15TWordReplayUnitP6TArrayP13ReplayMetrics
void	GatherWordScoreTime(TArray* found, WordMetrics* metrics);	// ROM 0x0009110c GatherWordScoreTime__FP6TArrayP11WordMetrics
void	MaybeDoLearning(TStdWordUnit* unit, ULong rank);	// ROM 0x00091228 MaybeDoLearning__FP12TStdWordUnitUl
void	GatherRealWordMetrics(TArray* found, ReplayMetrics* metrics);	// ROM 0x000912f0 GatherRealWordMetrics__FP6TArrayP13ReplayMetrics
void	GatherWordMetrics(TArray* found, ReplayMetrics* metrics);	// ROM 0x0009159c GatherWordMetrics__FP6TArrayP13ReplayMetrics
void	GatherShapeScoreTime(TArray* found, ShapeMetrics* metrics);	// ROM 0x0009160c GatherShapeScoreTime__FP6TArrayP12ShapeMetrics
void	GatherRealShapeMetrics(TArray* found, ReplayMetrics* metrics);	// ROM 0x000916d0 GatherRealShapeMetrics__FP6TArrayP13ReplayMetrics
void	GatherShapeMetrics(TArray* found, ReplayMetrics* metrics);	// ROM 0x000917e0 GatherShapeMetrics__FP6TArrayP13ReplayMetrics

// the control strings
void	SetTestName(const char* name);				// ROM 0x00091824 SetTestName__FPc
void	SetLocale5(const char* name, UShort digit);	// ROM 0x0009187c SetLocale5__FPcUs
void	SetLocale4(const char* name, UShort digit);	// ROM 0x000919f4 SetLocale4__FPcUs - the digits past '2' one up (no French Canada)
long	HandleControlString(UniChar* str);			// ROM 0x00091a34 HandleControlString__FPUs - ==> 1 when it was one
long	IsControlUnit(TWordReplayUnit* unit);		// ROM 0x00092410 IsControlUnit__FP15TWordReplayUnit - ==> 1 when it was a control string (and was obeyed)
void	InitReplayStats(void);						// ROM 0x00092544 InitReplayStats__Fv
void	PrintToStats(const char* text);				// ROM 0x00092548 PrintToStats__FPc
void	PrintError(const char* text);				// ROM 0x00092568 PrintError__FPc

void	AddTestConfig(ULong field);					// ROM 0x00034a1c AddTestConfig__FUl - userConfiguration.testConfig set to testFields[field]
void	RemoveTestConfig(void);						// ROM 0x00034ad0 RemoveTestConfig__Fv
void	ExportReporter(TTestReporter* reporter);	// ROM 0x002527ac ExportReporter__FP13TTestReporter - the stats channel

extern TTestReporter*	gReplayReporter;			// ROM 0x0c104ecc gReplayReporter - the stats channel
extern char		gTestName[];						// ROM 0x0c100bec gTestName - "<field> Field"
extern Boolean	TestConfigAdded;					// ROM 0x0c100bd4 TestConfigAdded
extern Boolean	gLearningOn;						// ROM 0x0c100be0 gLearningOn
extern ULong	gCorrectRate;						// ROM 0x0c100be4 gCorrectRate - how often (%) the writer corrects a misreading
extern Boolean	gLearnCorrector;					// ROM 0x0c100be8 gLearnCorrector - learn the corrected word
extern Boolean	gTestDeferredRecognition;			// ROM 0x0c100c50 gTestDeferredRecognition
extern Boolean	gTestScaling;						// ROM 0x0c100c54 gTestScaling
extern Fixed	gScaleFactor;						// ROM 0x0c100c58 gScaleFactor
extern Boolean	gTestCorrectorRecognition;			// ROM 0x0c100c5c gTestCorrectorRecognition
extern Boolean	CompleteTapFile;					// ROM 0x0c100c6c CompleteTapFile
extern long		gNumWordsInFile;					// ROM 0x0c100c94 gNumWordsInFile
extern long		gNumWordsTallied;					// ROM 0x0c100c98 gNumWordsTallied
extern long		gNumStrokesInFile;					// ROM 0x0c100c9c gNumStrokesInFile
extern long		gNumStrokesTallied;					// ROM 0x0c100ca0 gNumStrokesTallied

// host: the stats channel's lines written to the file NEWTON_REPLAY_STATS
// names (DEVIATION, above); ==> whether there is one
Boolean	ReplayStatsToFile(const char* line);

#endif	/* __REPLAYMETRICS_H */
