/*
	File:		frames/FunctionProfiler.cpp

	Contains:	The host's NewtonScript function profiler (FunctionProfiler.h):
				the profiler the ROM's hooks call, its table and shadow
				stacks, the report and the natives that drive it.

	Not a reconstruction - the ROM has no profiler, only the hooks it calls
	(Interpreter.cpp, GC.cpp).  Host code throughout.
*/

#include "FunctionProfiler.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "DebugAPI.h"
#include "REPTranslators.h"		// FindSlotName
#include "NativeFunctions.h"
#include "ROMConstants.h"
#include "ROMImport.h"
#include "NewtonExceptions.h"
#include "RSSymbols.h"
#include "hal/host/Host.h"		// HostMonotonicNanoseconds

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long	ProfileTime;	// nanoseconds


/* -------------------------------------------------------------------------------
	The table: a function's counts, found by its key through an open-
	addressed index.  Entry 0 is "(other functions)", where the calls of
	functions the full table has no room for go.
------------------------------------------------------------------------------- */

enum { kEntryOther = 0, kEntryScript, kEntryNative, kEntryUnknown };

struct ProfileEntry
{
	Ref				fKey;			// a NewtonScript function's instructions, else the function object
	Ref				fFunction;		// the function object it was first seen as
	Ref				fImplementor;	// an implementor it was seen running in (for its name)
	ULong			fCalls;
	ProfileTime		fExclusive;
	ProfileTime		fInclusive;
	long			fActive;		// calls in progress (a recursive function's inclusive time counted once)
	unsigned char	fKind;
};

struct ProfileFrame
{
	long			fEntry;
	long			fDepth;			// the control stack depth the call was made at
	ProfileTime		fStart;
	ProfileTime		fChildren;		// the time of the calls it made, and of the collections in it
};

struct ShadowStack
{
	void*			fOwner;			// the interpreter
	long			fCount;
	ProfileFrame*	fFrames;
	ProfileTime		fGCStart;
};

static ProfileEntry*	gEntries = nil;
static long				gCapacity = 0;
static long				gEntryCount = 0;
static long*			gIndex = nil;			// entry + 1, 0 empty
static long				gIndexSize = 0;			// a power of two, at least twice the capacity
static ShadowStack		gStacks[kNSProfilerStacks];
static ProfileFrame*	gFrameStore = nil;
static Boolean			gRegistered = false;	// with the collector (DIYGCRegister)
static Boolean			gRunning = false;
static ProfileTime		gStartedAt = 0;
static ProfileTime		gProfiled = 0;			// the time profiled before the last start
static ULong			gTotalCalls = 0;
static ULong			gTooDeep = 0;			// calls past a shadow stack's depth (counted, not timed)
static ULong			gCollections = 0;
static ProfileTime		gGCTime = 0;
static FramesFunctionProfilerInfo	gPrevious = { nil, nil };


static inline ULong
HashRef(Ref r)
{
	return (ULong) (((unsigned long long) (uintptr_t) r >> 2) * 2654435761u);
}


static void
RebuildIndex(void)
{
	memset(gIndex, 0, gIndexSize * sizeof(long));
	for (long i = 1; i < gEntryCount; i++)
	{
		ULong h = HashRef(gEntries[i].fKey) & (gIndexSize - 1);
		while (gIndex[h] != 0)
			h = (h + 1) & (gIndexSize - 1);
		gIndex[h] = i + 1;
	}
}


// The collector: the table's refs marked (the functions stay while they
// are counted) and moved with their objects - which changes the keys, so
// the index is made again.
static void
ProfilerMark(void* /*refCon*/)
{
	for (long i = 1; i < gEntryCount; i++)
	{
		DIYGCMark(gEntries[i].fKey);
		DIYGCMark(gEntries[i].fFunction);
		DIYGCMark(gEntries[i].fImplementor);
	}
}

static void
ProfilerUpdate(void* /*refCon*/)
{
	for (long i = 1; i < gEntryCount; i++)
	{
		gEntries[i].fKey = DIYGCUpdate(gEntries[i].fKey);
		gEntries[i].fFunction = DIYGCUpdate(gEntries[i].fFunction);
		gEntries[i].fImplementor = DIYGCUpdate(gEntries[i].fImplementor);
	}
	RebuildIndex();
}


// a function's key and kind, read without a fault or a throw (the hook is
// called before the interpreter has checked that fn is a function at all)
static Ref
KeyOf(Ref fn, unsigned char* kind)
{
	*kind = kEntryUnknown;
	if (!ISPTR(fn))
		return fn;
	// (a function is a slotted object - a frame of class, instructions, ...
	// or an array - whose first slot is its class)
	ObjHeader* o = NoFaultObjectPtr(fn);
	if (o == nil || (ObjFlags(o) & kObjSlotted) == 0 || ObjArrayLength(o) < 2)
		return fn;
	Ref cls = ObjArraySlots(o)[kFunctionClassSlot];
	if (cls == kFuncClass)
	{
		*kind = kEntryScript;
		return ObjArraySlots(o)[kFunctionInstructionsSlot];
	}
	if (cls == kNativeFuncClass || cls == kBinaryNativeFuncClass)
		*kind = kEntryNative;
	return fn;
}


static long
EntryFor(Ref fn)
{
	unsigned char kind;
	Ref key = KeyOf(fn, &kind);
	ULong h = HashRef(key) & (gIndexSize - 1);
	for (;;)
	{
		long i = gIndex[h];
		if (i == 0)
			break;
		if (gEntries[i - 1].fKey == key)
			return i - 1;
		h = (h + 1) & (gIndexSize - 1);
	}
	if (gEntryCount >= gCapacity)
		return kEntryOther;
	long e = gEntryCount++;
	ProfileEntry& entry = gEntries[e];
	memset(&entry, 0, sizeof(entry));
	entry.fKey = key;
	entry.fFunction = fn;
	entry.fImplementor = NILREF;
	entry.fKind = kind;
	gIndex[h] = e + 1;
	return e;
}


/* -------------------------------------------------------------------------------
	The shadow stacks
------------------------------------------------------------------------------- */

static ShadowStack*
StackFor(void* owner)
{
	for (long i = 0; i < kNSProfilerStacks; i++)
		if (gStacks[i].fOwner == owner)
			return &gStacks[i];
	for (long i = 0; i < kNSProfilerStacks; i++)
		if (gStacks[i].fOwner == nil)
		{
			gStacks[i].fOwner = owner;
			gStacks[i].fCount = 0;
			return &gStacks[i];
		}
	return &gStacks[kNSProfilerStacks - 1];		// (more interpreters than stacks: they share the last)
}


// a call ended at now: its time to its function, and to its caller's children
static void
PopFrame(ShadowStack* stack, ProfileTime now)
{
	ProfileFrame& f = stack->fFrames[--stack->fCount];
	ProfileTime elapsed = now > f.fStart ? now - f.fStart : 0;
	ProfileEntry& e = gEntries[f.fEntry];
	e.fExclusive += elapsed > f.fChildren ? elapsed - f.fChildren : 0;
	if (--e.fActive <= 0)
	{
		e.fActive = 0;
		e.fInclusive += elapsed;
	}
	if (stack->fCount > 0)
		stack->fFrames[stack->fCount - 1].fChildren += elapsed;
}


static void
CloseStacks(ProfileTime now)
{
	for (long i = 0; i < kNSProfilerStacks; i++)
	{
		while (gStacks[i].fCount > 0)
			PopFrame(&gStacks[i], now);
		gStacks[i].fOwner = nil;
	}
}


/* -------------------------------------------------------------------------------
	The profiler the hooks call
------------------------------------------------------------------------------- */

static void
Profiler(RefArg /*caller*/, RefArg fn, long depth, long /*generation*/, FramesProfilingKind kind, void* /*data*/)
{
	ProfileTime now = HostMonotonicNanoseconds();
	ShadowStack* stack = StackFor(gInterpreter);
	switch (kind)
	{
	case kProfileCall:
	case kProfileSend:
	{
		long e = EntryFor((Ref) fn);
		gEntries[e].fCalls++;
		gTotalCalls++;
		if (stack->fCount >= kNSProfilerStackDepth)
		{
			gTooDeep++;
			break;
		}
		ProfileFrame& f = stack->fFrames[stack->fCount++];
		f.fEntry = e;
		f.fDepth = depth;
		f.fStart = now;
		f.fChildren = 0;
		gEntries[e].fActive++;
		break;
	}
	case kProfileReturn:
	case kProfileUnwind:
		// calls deeper than this one that were never seen to return (the
		// fast loop's) end now; one at this depth is this return's - a
		// return deeper than the top is a call past the stack's depth
		while (stack->fCount > 0 && stack->fFrames[stack->fCount - 1].fDepth > depth)
			PopFrame(stack, now);
		if (stack->fCount > 0 && stack->fFrames[stack->fCount - 1].fDepth == depth)
		{
			// the state just left is still above the top of the control
			// stack: its implementor names a method (fPC, fFunction,
			// fLocals, fImplementor)
			ProfileEntry& e = gEntries[stack->fFrames[stack->fCount - 1].fEntry];
			if (e.fImplementor == NILREF && gInterpreter != nil)
			{
				Ref* left = gInterpreter->fCtrlStack.fTop;
				if (left[1] == (Ref) fn)
					e.fImplementor = left[3];
			}
			PopFrame(stack, now);
		}
		break;
	case kProfileGC:
		if (depth == 0)
			stack->fGCStart = now;
		else
		{
			ProfileTime elapsed = now > stack->fGCStart ? now - stack->fGCStart : 0;
			gGCTime += elapsed;
			gCollections++;
			if (stack->fCount > 0)
				stack->fFrames[stack->fCount - 1].fChildren += elapsed;
		}
		break;
	}
}


/* -------------------------------------------------------------------------------
	Starting and stopping
------------------------------------------------------------------------------- */

static void
ClearCounts(void)
{
	gEntryCount = 1;
	memset(&gEntries[kEntryOther], 0, sizeof(ProfileEntry));
	gEntries[kEntryOther].fKey = NILREF;
	gEntries[kEntryOther].fFunction = NILREF;
	gEntries[kEntryOther].fImplementor = NILREF;
	gEntries[kEntryOther].fKind = kEntryOther;
	RebuildIndex();
	for (long i = 0; i < kNSProfilerStacks; i++)
	{
		gStacks[i].fOwner = nil;
		gStacks[i].fCount = 0;
	}
	gProfiled = 0;
	gStartedAt = HostMonotonicNanoseconds();
	gTotalCalls = 0;
	gTooDeep = 0;
	gCollections = 0;
	gGCTime = 0;
}


Boolean
NSProfilerStart(long functions)
{
	if (gRunning)
		return true;
	if (gEntries == nil)
	{
		gCapacity = functions > 1 ? functions : kNSProfilerDefaultFunctions;
		gIndexSize = 1;
		while (gIndexSize < gCapacity * 2)
			gIndexSize <<= 1;
		gEntries = (ProfileEntry*) malloc(gCapacity * sizeof(ProfileEntry));
		gIndex = (long*) malloc(gIndexSize * sizeof(long));
		gFrameStore = (ProfileFrame*) malloc(kNSProfilerStacks * kNSProfilerStackDepth * sizeof(ProfileFrame));
		if (gEntries == nil || gIndex == nil || gFrameStore == nil)
		{
			free(gEntries);
			free(gIndex);
			free(gFrameStore);
			gEntries = nil;
			gIndex = nil;
			gFrameStore = nil;
			return false;
		}
		for (long i = 0; i < kNSProfilerStacks; i++)
			gStacks[i].fFrames = gFrameStore + i * kNSProfilerStackDepth;
		ClearCounts();
	}
	if (!gRegistered)
	{
		DIYGCRegister(&gEntries, ProfilerMark, ProfilerUpdate);
		gRegistered = true;
	}
	for (long i = 0; i < kNSProfilerStacks; i++)
	{
		gStacks[i].fOwner = nil;
		gStacks[i].fCount = 0;
	}
	gStartedAt = HostMonotonicNanoseconds();
	gPrevious = InstallFramesFunctionProfiler(Profiler, nil);
	gRunning = true;
	EnableFramesFunctionProfiling(true);
	return true;
}


void
NSProfilerStop(void)
{
	if (!gRunning)
		return;
	EnableFramesFunctionProfiling(false);
	InstallFramesFunctionProfiler(gPrevious.fProfiler, gPrevious.fData);
	ProfileTime now = HostMonotonicNanoseconds();
	CloseStacks(now);
	gProfiled += now - gStartedAt;
	gRunning = false;
}


void
NSProfilerReset(void)
{
	if (gEntries == nil)
		return;
	ClearCounts();
}


Boolean
NSProfilerRunning(void)
{
	return gRunning;
}


/* -------------------------------------------------------------------------------
	Names
------------------------------------------------------------------------------- */

// a NewtonScript string or symbol into buf (ASCII; others as '?')
static void
NameText(RefArg name, char* buf, size_t size)
{
	buf[0] = 0;
	if (IsSymbol(name))
	{
		snprintf(buf, size, "%s", SymbolName(name));
		return;
	}
	if (!IsString(name))
		return;
	long n = Length(name) / (long) sizeof(UniChar) - 1;
	const UniChar* text = (const UniChar*) BinaryData(name);
	size_t i = 0;
	for (long j = 0; j < n && i + 1 < size; j++)
		buf[i++] = (text[j] >= 32 && text[j] < 127) ? (char) text[j] : '?';
	buf[i] = 0;
}


// whether value is the entry's function: the object itself, or a
// NewtonScript function with its instructions (a closure of it)
static Boolean
IsEntryFunction(Ref value, const ProfileEntry& e)
{
	if (value == e.fFunction)
		return true;
	if (e.fKind != kEntryScript)
		return false;
	unsigned char kind;
	Ref key = KeyOf(value, &kind);
	return kind == kEntryScript && key == e.fKey;
}


// the slot of frame holding the entry's function, nil for none
static Ref
SlotHolding(RefArg frame, const ProfileEntry& e)
{
	if (!IsFrame(frame))
		return NILREF;
	TObjectIterator iter(frame, true);
	for (; !iter.Done(); iter.Next())
		if (IsEntryFunction((Ref) iter.fValue, e))
			return iter.fTag;
	return NILREF;
}


// a ROM constant's name for obj ("protoFoo"), nil for none
static const char*
ROMConstantName(Ref obj)
{
	if (!ISPTR(obj))
		return nil;
	for (long i = 0; i < gROMConstantCount; i++)
		if (gROMConstantEntries[i].fRef != nil && *gROMConstantEntries[i].fRef == obj)
			return gROMConstantEntries[i].fName;
	return nil;
}


// a frame's name: a ROM constant's, a well-known object's ("vars.foo"),
// its 'debug slot (a string or symbol), else its address
static void
FrameName(RefArg frame, char* buf, size_t size)
{
	const char* constant = ROMConstantName(frame);
	if (constant != nil)
	{
		snprintf(buf, size, "%s", constant);
		return;
	}
	RefVar name(SearchForObjectName(frame));
	if (NOTNIL(name))
	{
		NameText(name, buf, size);
		return;
	}
	if (FrameHasSlotRef(frame, RSSYMdebug))
	{
		name = GetFrameSlotRef(frame, RSSYMdebug);
		NameText(name, buf, size);
		if (buf[0] != 0)
			return;
	}
	snprintf(buf, size, "#%llX", (unsigned long long) (uintptr_t) (Ref) frame);
}


static void
EntryName(const ProfileEntry& e, char* buf, size_t size)
{
	buf[0] = 0;
	if (e.fKind == kEntryOther)
	{
		snprintf(buf, size, "(other functions: the table was full)");
		return;
	}
	newton_try
	{
		RefVar fn(e.fFunction);
		RefVar name(SearchForObjectName(fn));
		if (NOTNIL(name))
			NameText(name, buf, size);
		if (buf[0] == 0 && IsFrame(fn))
		{
			name = FunctionDebugName(fn);
			if (NOTNIL(name))
				NameText(name, buf, size);
		}
		if (buf[0] == 0 && e.fImplementor != NILREF)
		{
			RefVar implementor(e.fImplementor);
			RefVar slot(SlotHolding(implementor, e));
			if (NOTNIL(slot))
			{
				char frameName[96];
				FrameName(implementor, frameName, sizeof(frameName));
				snprintf(buf, size, "%s.%s", frameName, SymbolName(slot));
			}
		}
		if (buf[0] == 0)
		{
			const char* constant = ROMConstantName(e.fFunction);
			if (constant != nil)
				snprintf(buf, size, "%s", constant);
		}
		if (buf[0] == 0)
		{
			// a slot of a ROM constant frame (a proto's method)
			RefVar frame, slot;
			for (long i = 0; i < gROMConstantCount && buf[0] == 0; i++)
			{
				if (gROMConstantEntries[i].fRef == nil || !ISPTR(*gROMConstantEntries[i].fRef))
					continue;
				frame = *gROMConstantEntries[i].fRef;
				slot = SlotHolding(frame, e);
				if (NOTNIL(slot))
					snprintf(buf, size, "%s.%s", gROMConstantEntries[i].fName, SymbolName(slot));
			}
		}
		if (buf[0] == 0 && e.fKind == kEntryNative)
		{
			// a ROM native by the ROM's name for it
			Ref funcPtr = GetArraySlotRef(fn, kNativeFuncPtrSlot);
			const ROMNativeEntry* entry = ((ULong) funcPtr < kROMCodeLimit) ? ROMNativeAt((unsigned int) funcPtr) : nil;
			if (entry != nil)
				snprintf(buf, size, "%s", entry->fName);
		}
	}
	newton_catch_all
	{
	}
	end_try;
}


/* -------------------------------------------------------------------------------
	The report
------------------------------------------------------------------------------- */

static const ProfileTime*	gSortBy = nil;

static int
ByExclusive(const void* a, const void* b)
{
	ProfileTime x = gSortBy[*(const long*) a];
	ProfileTime y = gSortBy[*(const long*) b];
	return x < y ? 1 : x > y ? -1 : 0;
}


static void
ROMRefText(Ref r, char* buf, size_t size)
{
	ULong32 rom = ROMSourceRef(r);
	if (rom != 0)
		snprintf(buf, size, "0x%08lX", (unsigned long) rom);
	else
		snprintf(buf, size, "-");
}


void
NSProfilerWriteReport(FILE* out)
{
	if (gEntries == nil)
		return;
	ProfileTime now = HostMonotonicNanoseconds();
	ProfileTime total = gProfiled + (gRunning ? now - gStartedAt : 0);
	// the calls still in progress counted to now, without ending them
	ProfileTime* exclusive = (ProfileTime*) malloc(gEntryCount * sizeof(ProfileTime));
	ProfileTime* inclusive = (ProfileTime*) malloc(gEntryCount * sizeof(ProfileTime));
	long* active = (long*) malloc(gEntryCount * sizeof(long));
	long* order = (long*) malloc(gEntryCount * sizeof(long));
	if (exclusive == nil || inclusive == nil || active == nil || order == nil)
	{
		free(exclusive); free(inclusive); free(active); free(order);
		fprintf(out, "### NewtonScript profile: no memory for the report\n");
		return;
	}
	for (long i = 0; i < gEntryCount; i++)
	{
		exclusive[i] = gEntries[i].fExclusive;
		inclusive[i] = gEntries[i].fInclusive;
		active[i] = gEntries[i].fActive;
		order[i] = i;
	}
	for (long s = 0; s < kNSProfilerStacks; s++)
	{
		ProfileTime children = 0;
		for (long k = gStacks[s].fCount - 1; k >= 0; k--)
		{
			const ProfileFrame& f = gStacks[s].fFrames[k];
			ProfileTime elapsed = now > f.fStart ? now - f.fStart : 0;
			ProfileTime own = f.fChildren + children;
			exclusive[f.fEntry] += elapsed > own ? elapsed - own : 0;
			if (--active[f.fEntry] <= 0)
				inclusive[f.fEntry] += elapsed;
			children = elapsed;
		}
	}
	gSortBy = exclusive;
	qsort(order, gEntryCount, sizeof(long), ByExclusive);

	long functions = 0;
	for (long i = 0; i < gEntryCount; i++)
		if (gEntries[i].fCalls > 0)
			functions++;
	fprintf(out, "### NewtonScript profile: %.3f s profiled, %lu calls of %ld functions, %lu collections taking %.3f s%s\n",
			total / 1e9, (unsigned long) gTotalCalls, functions, (unsigned long) gCollections, gGCTime / 1e9,
			gRunning ? " (still running)" : "");
	if (gTooDeep > 0)
		fprintf(out, "# %lu calls deeper than the profiler's %ld were counted but not timed\n", (unsigned long) gTooDeep, kNSProfilerStackDepth);
	fprintf(out, "# (tools/host/nsprofile.py reads this; --romsrc names the ROM's functions by their romsrc paths)\n");
	fprintf(out, "#%11s %12s %10s %6s  %-6s %-10s %-10s  %s\n", "excl.ms", "incl.ms", "calls", "excl%", "kind", "rom", "code", "function");
	fprintf(out, "%12.3f %12.3f %10lu %6.2f  %-6s %-10s %-10s  %s\n", gGCTime / 1e6, gGCTime / 1e6, (unsigned long) gCollections,
			total > 0 ? 100.0 * gGCTime / total : 0.0, "gc", "-", "-", "(garbage collection)");
	char name[192], rom[16], code[16];
	for (long k = 0; k < gEntryCount; k++)
	{
		long i = order[k];
		const ProfileEntry& e = gEntries[i];
		if (e.fCalls == 0)
			continue;
		EntryName(e, name, sizeof(name));
		if (name[0] == 0)
			snprintf(name, sizeof(name), "#%llX", (unsigned long long) (uintptr_t) e.fFunction);
		if (e.fKind == kEntryOther)
		{
			snprintf(rom, sizeof(rom), "-");
			snprintf(code, sizeof(code), "-");
		}
		else
		{
			ROMRefText(e.fFunction, rom, sizeof(rom));
			if (e.fKind == kEntryScript)
				ROMRefText(e.fKey, code, sizeof(code));
			else
				snprintf(code, sizeof(code), "-");
		}
		const char* kind = e.fKind == kEntryScript ? "ns" : e.fKind == kEntryNative ? "native" : "other";
		fprintf(out, "%12.3f %12.3f %10lu %6.2f  %-6s %-10s %-10s  %s\n", exclusive[i] / 1e6, inclusive[i] / 1e6,
				(unsigned long) e.fCalls, total > 0 ? 100.0 * exclusive[i] / total : 0.0, kind, rom, code, name);
	}
	fprintf(out, "### end\n");
	fflush(out);
	free(exclusive); free(inclusive); free(active); free(order);
}


/* -------------------------------------------------------------------------------
	The environment and the natives
------------------------------------------------------------------------------- */

// NEWTON_NS_PROFILE, read once
static const char*
ProfileFile(void)
{
	static Boolean read = false;
	static const char* file = nil;
	if (!read)
	{
		read = true;
		file = getenv("NEWTON_NS_PROFILE");
		if (file != nil && file[0] == 0)
			file = nil;
	}
	return file;
}


Boolean
NSProfilerReport(const char* path)
{
	if (gEntries == nil)
		return false;
	if (path == nil)
	{
		NSProfilerWriteReport(stdout);
		return true;
	}
	FILE* out = fopen(path, "w");
	if (out == nil)
	{
		fprintf(stderr, "[frames] the NewtonScript profile cannot be written to %s\n", path);
		return false;
	}
	NSProfilerWriteReport(out);
	fclose(out);
	return true;
}


static Ref
FHostNSProfileStart(RefArg /*rcvr*/)
{
	return NSProfilerStart(0) ? TRUEREF : NILREF;
}

static Ref
FHostNSProfileStop(RefArg /*rcvr*/)
{
	NSProfilerStop();
	return NILREF;
}

static Ref
FHostNSProfileReset(RefArg /*rcvr*/)
{
	NSProfilerReset();
	return NILREF;
}

static Ref
FHostNSProfileRunning(RefArg /*rcvr*/)
{
	return NSProfilerRunning() ? TRUEREF : NILREF;
}

static Ref
FHostNSProfileReport(RefArg /*rcvr*/, RefArg path)
{
	char file[512];
	if (NOTNIL(path))
	{
		NameText(path, file, sizeof(file));
		return NSProfilerReport(file) ? TRUEREF : NILREF;
	}
	return NSProfilerReport(nil) ? TRUEREF : NILREF;
}


void
NSProfilerInit(void)
{
	RefVar functions(gFunctionFrame);
	SetFrameSlot(functions, RefVar(Intern((char*) "HostNSProfileStart")), RefVar(MakeCFunction((void*) FHostNSProfileStart, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostNSProfileStop")), RefVar(MakeCFunction((void*) FHostNSProfileStop, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostNSProfileReset")), RefVar(MakeCFunction((void*) FHostNSProfileReset, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostNSProfileRunning")), RefVar(MakeCFunction((void*) FHostNSProfileRunning, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostNSProfileReport")), RefVar(MakeCFunction((void*) FHostNSProfileReport, 1, nil)));
	if (ProfileFile() != nil && !gRunning)
		NSProfilerStart(0);
}


void
NSProfilerFinish(void)
{
	const char* file = ProfileFile();
	if (file == nil || gEntries == nil)
		return;
	NSProfilerStop();
	NSProfilerReport(file);
}


/* -------------------------------------------------------------------------------
	For tests
------------------------------------------------------------------------------- */

Boolean
NSProfilerCounts(RefArg fn, ULong* calls, unsigned long long* inclusiveNs, unsigned long long* exclusiveNs)
{
	if (gEntries == nil)
		return false;
	unsigned char kind;
	Ref key = KeyOf((Ref) fn, &kind);
	for (long i = 1; i < gEntryCount; i++)
		if (gEntries[i].fKey == key)
		{
			*calls = gEntries[i].fCalls;
			*inclusiveNs = gEntries[i].fInclusive;
			*exclusiveNs = gEntries[i].fExclusive;
			return true;
		}
	return false;
}


void
NSProfilerGCTotals(ULong* collections, unsigned long long* ns)
{
	*collections = gCollections;
	*ns = gGCTime;
}
