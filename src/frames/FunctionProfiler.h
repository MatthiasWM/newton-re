/*
	File:		frames/FunctionProfiler.h

	Contains:	The host's NewtonScript function profiler: what it installs in
				the ROM's frames function profiler hooks (Interpreter.h,
				InstallFramesFunctionProfiler), counting each function's
				calls and timing it - inclusive (with what it calls) and
				exclusive (its own) - on the host's monotonic clock, with
				the collector's time apart; and a report of it, sorted by
				exclusive time.

	Not a reconstruction: the ROM has the hooks but no profiler (a
	developer's tool installed one through the jump table).  A host
	re-expression of such a tool (docs/frames/README.md, "Profiling
	NewtonScript"):

	- A NewtonScript function is counted by its instructions, so that every
	  closure made of one function (each evaluation of a func expression
	  clones it) is the one entry; a native by its function object.
	- Each interpreter (one per task that runs NewtonScript) has a shadow
	  stack of the calls in progress, matched to the returns by the control
	  stack depth the hooks pass; a call left unreturned (the fast loop
	  returns without telling; an exception's unwinding is told) is closed
	  when a shallower return comes.  A recursive function's inclusive time
	  is counted once, at its outermost return.
	- The time is wall-clock time on the host's monotonic clock: a task
	  waiting while another runs is charged with the wait.  The profiler's
	  own few hundred nanoseconds a call are in what it measures.
	- Memory is bounded and allocated once, when profiling starts: a table
	  of kDefault... functions (further ones counted together as "(other
	  functions)") and shadow stacks of a fixed depth (deeper calls are
	  counted but not timed).  The table's refs are kept up to date - and
	  their objects alive - through the collector's DIY hooks.
	- Names are found when the report is written (the heap is not touched
	  while profiling): a global function's or global variable's
	  ("functions.Foo", "vars.foo"), else the slot of the implementor it
	  was seen sent to ("vars.myApp.ViewSetupFormScript", or the implementor
	  by its ROM constant name), else the slot of a ROM constant frame
	  holding it, else none - and a ROM object's address in the ROM's own
	  layout (romsrc/layout.tsv) is printed for tools/host/nsprofile.py to
	  name it by its romsrc path.

	Switched on by NEWTON_NS_PROFILE=<file> in the environment (profiling
	from InitObjects, the report written to the file when the program
	ends: NSProfilerFinish), or from NewtonScript - the Host panel, a
	script or the T-Deck's console:
		HostNSProfileStart()		start (or go on); ==> true
		HostNSProfileStop()			stop, keeping the counts
		HostNSProfileReset()		the counts thrown away
		HostNSProfileReport(path)	the report written to the file (nil:
									stdout - the T-Deck's console);
									==> true when written
*/

#ifndef __FUNCTIONPROFILER_H
#define __FUNCTIONPROFILER_H

#ifndef __OBJECTS_H
#include "objects.h"
#endif
#include <stdio.h>

// the table's size and the shadow stacks' depth unless asked otherwise:
// small on a microcontroller
#if defined(ESP_PLATFORM)
const long	kNSProfilerDefaultFunctions = 1024;
const long	kNSProfilerStackDepth = 256;
#else
const long	kNSProfilerDefaultFunctions = 8192;
const long	kNSProfilerStackDepth = 1024;
#endif
const long	kNSProfilerStacks = 4;		// interpreters told apart (more share the last)

Boolean		NSProfilerStart(long functions);		// 0: the default; false: no memory
void		NSProfilerStop(void);
void		NSProfilerReset(void);
Boolean		NSProfilerRunning(void);
// the report: to the file, or (nil) to stdout; false when it cannot be
// opened or nothing has been profiled
Boolean		NSProfilerReport(const char* path);
void		NSProfilerWriteReport(FILE* out);

// Host: the natives above put in the global function frame and
// NEWTON_NS_PROFILE read (InitInterpreter calls it); NSProfilerFinish
// writes NEWTON_NS_PROFILE's report (the host programs call it as they end)
void		NSProfilerInit(void);
void		NSProfilerFinish(void);

// for tests: the counts of the function (a NewtonScript function or a
// native's object) - false when the profiler has not seen it
Boolean		NSProfilerCounts(RefArg fn, ULong* calls, unsigned long long* inclusiveNs, unsigned long long* exclusiveNs);
void		NSProfilerGCTotals(ULong* collections, unsigned long long* ns);

#endif	/* __FUNCTIONPROFILER_H */
