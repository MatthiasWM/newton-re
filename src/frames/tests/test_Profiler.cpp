// Profiler test: the ROM's frames function profiler hooks (Interpreter.h -
// EnableFramesFunctionProfiling, InstallFramesFunctionProfiler, and the
// calls TopLevelCall, Call, Send, CallPlainCFunction, Return,
// HandleException and GC make) heard by a profiler that records them: the
// kinds, the depths a call and its return share, the unwinding of a handled
// and of an unhandled exception (and the ROM's bug there, both ways), the
// collection; the fast loop off while profiling; and the host's profiler
// (FunctionProfiler.h) counting and reporting a recursive function.

#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "FunctionProfiler.h"
#include "Compiler.h"
#include "REPTranslators.h"
#include "ROMImport.h"
#include "NSErrors.h"
#include "host/RomBugs.h"
#include "memory/host/KernelHeap.h"

#include <stdio.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)

static Ref
Eval(const char* source)
{
	RefVar fn(ParseString(RefVar(MakeString(source))));
	if ((Ref) fn == NILREF)
		return NILREF;
	return InterpretBlock(fn, RefVar(gVarFrame));
}

static Ref
Global(const char* name)
{
	return GetFrameSlotRef(gVarFrame, Intern((char*) name));
}


// the events heard
struct Event
{
	FramesProfilingKind	fKind;
	long				fDepth;
	Ref					fFunction;
	Ref					fCaller;
	long				fGeneration;
};
static Event	gEvents[4096];
static long		gEventCount = 0;
static int		gData = 0;
static void*	gDataSeen = nil;

static void
Recorder(RefArg caller, RefArg fn, long depth, long generation, FramesProfilingKind kind, void* data)
{
	gDataSeen = data;
	if (gEventCount >= 4096)
		return;
	Event& e = gEvents[gEventCount++];
	e.fKind = kind;
	e.fDepth = depth;
	e.fFunction = fn;
	e.fCaller = caller;
	e.fGeneration = generation;
}

static long
CountOf(FramesProfilingKind kind, Ref fn)
{
	long n = 0;
	for (long i = 0; i < gEventCount; i++)
		if (gEvents[i].fKind == kind && (fn == NILREF || gEvents[i].fFunction == fn))
			n++;
	return n;
}

static long
FirstOf(FramesProfilingKind kind, Ref fn)
{
	for (long i = 0; i < gEventCount; i++)
		if (gEvents[i].fKind == kind && gEvents[i].fFunction == fn)
			return i;
	return -1;
}


static void
TestSwitches()
{
	EXPECT(gFramesFunctionProfilingEnabled == 0 && gFramesFunctionProfiler == nil);
	FramesFunctionProfilerInfo was = InstallFramesFunctionProfiler(Recorder, &gData);
	EXPECT(was.fProfiler == nil && was.fData == nil);
	EXPECT(gFramesFunctionProfiler == Recorder && gFramesFunctionProfilerData == &gData);
	EXPECT(!EnableFramesFunctionProfiling(true));
	EXPECT(gFramesFunctionProfilingEnabled == 0x66667065);		// 'ffpe'
	EXPECT(!gInterpreter->fFastLoop);							// the fast loop does not tell the profiler
	EXPECT(EnableFramesFunctionProfiling(false));
	EXPECT(gFramesFunctionProfilingEnabled == 0);
	was = InstallFramesFunctionProfiler(nil, nil);
	EXPECT(was.fProfiler == Recorder && was.fData == &gData);
	// on, but with no profiler: nothing is called and the fast loop may run
	EnableFramesFunctionProfiling(true);
	EXPECT(!FramesProfiling());
	EnableFramesFunctionProfiling(false);
}


static void
TestCalls()
{
	// (+ and - are done in the loop; * would be a call of its own)
	Eval("tpInc := func(x) x + 1; tpTwice := func(x) call tpInc with (x) + x + 1; tpObj := {M: func(y) y - 1}; nil");
	RefVar inc(Global("tpInc")), twice(Global("tpTwice")), method(GetFrameSlotRef(Global("tpObj"), Intern((char*) "M")));
	InstallFramesFunctionProfiler(Recorder, &gData);
	EnableFramesFunctionProfiling(true);
	gEventCount = 0;
	long depth = gInterpreter->ControlPosition();
	EXPECT(RINT(Eval("call tpTwice with (3)")) == 8);
	// the top-level block called, then tpTwice, tpInc; returned in turn
	EXPECT(gEventCount == 6);
	EXPECT(gEvents[0].fKind == kProfileCall && gEvents[0].fDepth == depth);
	EXPECT(gEvents[1].fKind == kProfileCall && gEvents[1].fFunction == (Ref) twice);
	EXPECT(gEvents[2].fKind == kProfileCall && gEvents[2].fFunction == (Ref) inc && gEvents[2].fCaller == (Ref) twice);
	EXPECT(gEvents[3].fKind == kProfileReturn && gEvents[3].fFunction == (Ref) inc && gEvents[3].fCaller == (Ref) twice);
	EXPECT(gEvents[4].fKind == kProfileReturn && gEvents[4].fFunction == (Ref) twice);
	EXPECT(gEvents[5].fKind == kProfileReturn && gEvents[5].fDepth == depth);
	// a call and its return share the depth, each call one state deeper
	EXPECT(gEvents[1].fDepth == gEvents[4].fDepth && gEvents[2].fDepth == gEvents[3].fDepth);
	EXPECT(gEvents[2].fDepth == gEvents[1].fDepth + kVMStateSize && gEvents[1].fDepth == depth + kVMStateSize);
	EXPECT(gEvents[0].fGeneration == (long) (gCurrentStackPos >> 16));
	EXPECT(gDataSeen == &gData);

	// a send, and a native's call and return
	gEventCount = 0;
	EXPECT(RINT(Eval("tpObj:M(5)")) == 4);
	EXPECT(CountOf(kProfileSend, method) == 1 && CountOf(kProfileReturn, method) == 1);
	gEventCount = 0;
	EXPECT(RINT(Eval("Max(2, 7)")) == 7);
	EXPECT(gEventCount == 4);
	EXPECT(gEvents[1].fKind == kProfileCall && IsNativeFunction(RefVar(gEvents[1].fFunction)));
	EXPECT(gEvents[2].fKind == kProfileReturn && gEvents[2].fFunction == gEvents[1].fFunction && gEvents[2].fDepth == gEvents[1].fDepth);
	EnableFramesFunctionProfiling(false);
	InstallFramesFunctionProfiler(nil, nil);
}


static void
TestExceptions()
{
	Eval("tpThrow := func() Throw('|evt.ex.msg|, \"no\"); tpOuter := func() call tpThrow with (); nil");
	RefVar thrower(Global("tpThrow")), outer(Global("tpOuter"));
	InstallFramesFunctionProfiler(Recorder, &gData);
	EnableFramesFunctionProfiling(true);

	// handled: Throw (a native that never returns), tpThrow and tpOuter unwound to the try
	gEventCount = 0;
	EXPECT(RINT(Eval("try call tpOuter with () onexception |evt.ex| do 1")) == 1);
	EXPECT(CountOf(kProfileUnwind, NILREF) == 3);
	long call = FirstOf(kProfileCall, thrower), unwind = FirstOf(kProfileUnwind, thrower);
	EXPECT(call >= 0 && unwind > call && gEvents[unwind].fDepth == gEvents[call].fDepth);
	EXPECT(CountOf(kProfileReturn, thrower) == 0);

	// unhandled: unwound back to the caller of the Run, the control stack
	// back where it was - the ROM pops one state too many (ROM BUG, fixed).
	// (A caller's state is pushed under the call: at the bottom of the
	// stack the ROM's extra pop would read below it.)
	for (int faithful = 0; faithful < 2; faithful++)
	{
		SetRomBugFixed(faithful == 0);
		long below = gInterpreter->ControlPosition();
		VMState* bottom = gInterpreter->fVMState;
		gInterpreter->fVMState = gInterpreter->fCtrlStack.NewState();
		StateRef(gInterpreter->fVMState->fPC) = MAKEINT(-1);
		long depth = gInterpreter->ControlPosition();
		VMState* state = gInterpreter->fVMState;
		gEventCount = 0;
		Boolean thrown = false;
		newton_try
		{
			Eval("call tpOuter with ()");
		}
		newton_catch_all
		{
			thrown = true;
		}
		end_try;
		EXPECT(thrown);
		EXPECT(CountOf(kProfileUnwind, outer) == 1 && CountOf(kProfileUnwind, thrower) == 1);
		if (faithful == 0)
			EXPECT(gInterpreter->ControlPosition() == depth && gInterpreter->fVMState == state);
		else
			EXPECT(gInterpreter->ControlPosition() == below && gInterpreter->fVMState == bottom);	// the caller's state lost
		gInterpreter->fCtrlStack.fTop = gInterpreter->fCtrlStack.fBase + below + 1;
		gInterpreter->fVMState = bottom;
		gInterpreter->fPC = RINT(StateRef(bottom->fPC));
	}
	SetRomBugFixed(true);
	EnableFramesFunctionProfiling(false);
	InstallFramesFunctionProfiler(nil, nil);
}


static void
TestGC()
{
	InstallFramesFunctionProfiler(Recorder, &gData);
	EnableFramesFunctionProfiling(true);
	gEventCount = 0;
	GC();
	EXPECT(gEventCount == 2);
	EXPECT(gEvents[0].fKind == kProfileGC && gEvents[0].fDepth == 0 && gEvents[0].fFunction == NILREF && gEvents[0].fCaller == NILREF);
	EXPECT(gEvents[1].fKind == kProfileGC && gEvents[1].fDepth == 1);
	EnableFramesFunctionProfiling(false);
	gEventCount = 0;
	GC();
	EXPECT(gEventCount == 0);				// off: not called
	InstallFramesFunctionProfiler(nil, nil);
}


static void
TestHostProfiler(FILE* report)
{
	Eval("tpFib := func(n) if n < 2 then n else call tpFib with (n - 1) + call tpFib with (n - 2); nil");
	RefVar fib(Global("tpFib"));
	EXPECT(NSProfilerStart(0));
	EXPECT(NSProfilerRunning());
	EXPECT(RINT(Eval("call tpFib with (10)")) == 55);
	GC();
	NSProfilerStop();
	EXPECT(!NSProfilerRunning() && !FramesProfiling());
	ULong calls = 0;
	unsigned long long incl = 0, excl = 0;
	EXPECT(NSProfilerCounts(fib, &calls, &incl, &excl));
	EXPECT(calls == 177);
	EXPECT(incl >= excl && incl > 0);
	ULong collections = 0;
	unsigned long long gcTime = 0;
	NSProfilerGCTotals(&collections, &gcTime);
	EXPECT(collections >= 1);
	NSProfilerWriteReport(report);
	fflush(report);
	rewind(report);
	char line[512];
	Boolean header = false, fibLine = false, end = false;
	while (fgets(line, sizeof(line), report) != nil)
	{
		if (strncmp(line, "### NewtonScript profile:", 25) == 0)
			header = true;
		if (strstr(line, "vars.tpFib") != nil && strstr(line, " 177 ") != nil && strstr(line, " ns ") != nil)
			fibLine = true;
		if (strncmp(line, "### end", 7) == 0)
			end = true;
	}
	EXPECT(header && fibLine && end);
	// counts thrown away; a closure of a function counts as the function
	NSProfilerReset();
	EXPECT(!NSProfilerCounts(fib, &calls, &incl, &excl));
	Eval("tpMake := func() func(x) x * 3; nil");
	NSProfilerStart(0);
	Eval("for i := 1 to 5 do call (call tpMake with ()) with (i)");
	NSProfilerStop();
	RefVar closure(Eval("call tpMake with ()"));
	EXPECT(NSProfilerCounts(closure, &calls, &incl, &excl) && calls == 5);
}


int
main()
{
	InitHostStandaloneHeap();
	if (ImportROMObjectsFromFile(NEWTON_OBJECTS) != noErr)
	{
		printf("test_Profiler: cannot import %s\n", NEWTON_OBJECTS);
		return 1;
	}
	gObjectHeapSize = 0x100000;
	InitObjects();
	FILE* output = tmpfile();
	FILE* report = tmpfile();
	if (output == nil || report == nil)
	{
		printf("test_Profiler: no temporary file\n");
		return 1;
	}
	HostInitREP(output);
	newton_try
	{
		TestSwitches();
		TestCalls();
		TestExceptions();
		TestGC();
		TestHostProfiler(report);
	}
	newton_catch_all
	{
		failures++;
		fprintf(stderr, "FAIL: unhandled exception %s\n", _info.exception.name);
	}
	end_try;
	if (failures == 0)
		printf("test_Profiler: all passed\n");
	return failures == 0 ? 0 : 1;
}
