/*
	File:		recognition/WordReplay.h

	Contains:	The host's stand-in for what Apple's test tools put round
				the ROM's replay metrics (ReplayMetrics.h): the 'WRPL'
				domain that makes a replayed unit (TWordReplayUnit) over
				each written word's strokes, carrying what was written
				there, and the recogniser that puts the 'WRPL' type in an
				area while the readings are being measured - so that the
				arbiter waits for the replayed unit as for any other and
				hands it, with every reading over the same strokes, to
				HandleReplayUnit.

				The words come from the journal (testing/Journal.h,
				JournalReplayWords): a stroke file followed by a label for
				each word - how many strokes it is, what kind of thing it
				is ('WREC' a word, 'GSHP' a shape, as GatherExpectedMetrics
				reads them), and its text ("**..." a control string).
				`WordReplayStart` takes the labels and puts the arbiter in
				replay mode (TArbiter::fReplaying): the cached areas are let
				go, so that new ones are built with the 'WRPL' type and
				with HandleReplayUnit as their unit handler.  The replayed
				strokes are told apart by the controller's stroke numbers,
				counted from the one the next stroke will have when the
				replay starts.

	DEVIATION: all of it - the ROM has the measuring, not the replay;
	`TRecognitionManager::InitRecognizers` installs the recogniser beside
	the ROM's.
*/

#ifndef __WORDREPLAY_H
#define __WORDREPLAY_H

#include "Recognizer.h"
#include "ReplayMetrics.h"

class TRecognitionManager;

// one word of the journal: what was written over the next fStrokes strokes
struct ReplayLabel
{
	ULong		fType;			// 'WREC' / 'XRWR' / 'FRML' a word, 'GSHP' a shape
	long		fStrokes;
	UniChar		fText[kMetricsStringLength];
};


class TWordReplayDomain : public TDomain
{
public:
	static TWordReplayDomain*	Make(TController* controller);
	void				IWordReplayDomain(TController* controller);

	virtual long		Group(TUnit* unit, dInfoRec* info);		// a stroke put into its word's replayed unit
	virtual void		Classify(TUnit* unit);					// a finished replayed unit handed on to be arbitrated
};


class TWordReplayRecognizer : public TRecognizer
{
public:
	virtual long		EnableArea(TRecArea* area, RefArg config);	// the 'WRPL' type in an area that takes writing, while replaying
};

void		InstallWordReplayRecognizer(TRecognitionManager* manager);

NewtonErr	WordReplayStart(const ReplayLabel* labels, long count);	// ==> 0, or an error (no memory, no recogniser)
void		WordReplayStop(void);							// replay mode left (the arbiter's flag, the areas)
Boolean		WordReplayBusy(void);							// labels whose replayed units are still to be made or measured
long		WordReplayMade(void);							// replayed units made since the start

#endif	/* __WORDREPLAY_H */
