# The testing system (`src/testing/`)

The Newton carried its own test tools in ROM: a **test agent**
(`TTestAgent`, an application world named `'tagt` that the loader starts
at boot) that a test server on a desktop drove over a connection,
reporters that sent it messages, test cases run as tasks, and the
**journal**, which records the pen's strokes and plays them back into the
tablet buffer so that a test can write on the machine as a person would.
38 NewtonScript natives reach it (`natives.py --unbound`, the `testing`
area).

Reconstructed so far: the journal, the tablet's bypass, the recogniser's replay metrics (below), the test agent
with its reporters, message queue and NewtonScript natives (a test
manager on the machine itself works end to end), and the debugging hooks
(`debug`, `DebugRunUntilIdle`, `DebugMemoryStats`, `StdioOn`/`StdioOff`,
`HobbleTablet`).  NOT YET: the test server's connection (`TCommServer`),
the C test cases (`TTestCaseTask`), the tests kept on a store, the serial
debugging (`InitSerialDebugging`), Uriah and the IR sniffing.

## The test agent (`testing/TestAgent.h`, ROM 0x00226a40-0x0022bbb8)

`TTestAgent` is an application world (`'tagt`, 0x178 bytes) started by
`InitTestAgent` (0x000ea470) - from `TLoader::TheMain` when
`gNewtTests & 0x800`, and from `ActivateTestAgent` - unless the name
server already has one.  Its `MainConstructor` makes a `'tstp` part
handler (a C test case's code), a `'newt/'tste` event handler idling
every three seconds, the newt world's reporter (`gTestReporterForNewt`,
a `TAgentReporter` numbered 9 that logs at most twenty errors) and the
message queue (`gTestAgentMessageQueue`).

**Reporting.**  A `TTestReporter` (0x1a0 bytes: the test's name, its
parameters, the agent's port, its number, an error count) turns every
report into a `'newt/'tste` event to the agent (`SendToTestAgent`): kind
1-4 a line of text (`"Test Case MSG: ..."`, `"Test Case ERR: ..."`,
`"TestAgent ERR ..."`), 5 a status whose sub-kind says what happened
(`AgentReportStatus`: 1 the agent activated, 2 a test started - with the
date and time and the free memory - 4 finished, with the errors reported
and logged, 7 a C test case wanted, 10 the name and parameters, 11 quit,
12 the server dropped), 9 a data file wanted (an RPC), 10 flush.  The
agent's `AEHandlerProc` queues the text ones as `'amsg`, `'aerr`, `'tmsg`
and `'terr`, times a test from its start to its end, and keeps the state.

**Who listens.**  `ActivateTestAgent(name, server)` with a name of `"*"`
makes the frame it is sent to the **test manager** (`gTestMgrAppContext`)
on the machine itself: it reads the queue with `TestMGetReportMsg` (the
oldest message first), is sent `testMgrFrameDoneScript` and
`testMgrCaseDoneScript` as tests finish (the agent sends the newt world a
`'newt/'tsse` event, which `TNewtTestScriptEventHandler` turns into the
message), and answers `testMgrReadDataFile(name, offset, size)` for a
test's data files.  Any other name is a test server on a desktop, reached
over AppleTalk (`TCommServer`, `Setup`, `ProcessTestServerCommand`): NOT
YET, so the queue simply fills.  With a manager the agent idles every 50
milliseconds, without one every three seconds (and three seconds after a
journal replay ends, whatever).

**A NewtonScript test** is a `'tsps` package part whose frame has a
`testScript` method (`TtspsPart`): `TestMStartTestFrame(name, nil)`
reports it started and sends it `testScript`; a NewtonScript error is
reported as `"Test script failed!!"` with the error code and symbol, and
the test reported finished unless the script said it would do that
itself (`TestWillCallExit`, then `TestExit`).  `TestMSetParameterString`
and `TestGetParameterString`/`TestGetParameterArray` carry the test's
name and parameters through the agent (spaces become `\x01` on the way;
the array splits them at spaces, a quoted one kept whole, ten at most).
`TestReadTextFile`/`TestReadDataFile` read a data file - from the host's
own file system with an offset of -1 (stdio switched on for it), from the
test manager, or from the server.

**The journal** is played by the agent's idle proc - nothing else calls
`JournalInsertTabletSamople` - so on the machine, and now on the host, a
replay plays only while the agent runs.

ROM bugs kept: `TestReportErrorValues` and `AgentReportDirect` pass their
formats too few arguments; the agent frees its message queue without
clearing `gTestAgentMessageQueue` (the host clears it: DEVIATION); a data
file asked of the test manager is also queued with a kind nothing set.
All are fixed by default (`NEWTON_ROM_BUGS=1` for the ROM's behaviour):
the formats are given their text and values, and the answered request is
not queued; the cleared pointer is the fix in either mode.
DEVIATION: the natives that report through `gTestReporterForNewt` or look
in `gtspsPartHandler` without asking whether the agent runs answer nil on
the host rather than read low memory; a `TTestAgentEvent`'s text block is
sixteen bytes longer, to hold the activation block's host-sized id and
pointer.

## The debugging hooks

`debug(form)` (0x001ea0a8) finds a view from the root through
`FindForm`: an integer is that child of the `viewChildren` (the open view
if there is one), a string is a view whose `debug` slot is that string or
its `DebugHashValue` (each character lower-cased and XORed into the hash
shifted left), or whose text is (a text starting with 0xfc01 compared from
its second character), an array is a path; failing that every child is
searched.  `DebugRunUntilIdle` updates the screen, runs the application
and every due delayed action; `DebugMemoryStats` does nothing in this
ROM.  `StdioOn`/`StdioOff` count down and up the gate the C library's
i/o passes to the serial debugger through (DEVIATION: the host's stdio
is its console regardless).  `HobbleTablet` sends the inker its command
0x1d (NOT YET: the host has no inker port).

The frames function profiler is done: the ROM's hooks
(`EnableFramesFunctionProfiling` 0x002d41f4, `InstallFramesFunctionProfiler`
0x002d424c, the calls in the interpreter and around the collector) are
reconstructed, and the host installs a profiler of its own behind them -
`NEWTON_NS_PROFILE=<file>` or `HostNSProfileStart`/`Stop`/`Report` from a
script, a report of calls and inclusive and exclusive time per
NewtonScript function, read with `tools/host/nsprofile.py`
(`docs/frames/README.md`, "Profiling NewtonScript").

### Tests

ctest `host.NewtonTestAgent` (`src/host/demo/testagent.ns`) activates
the agent with the script as its test manager, reports a message, an
error and a test frame's start, reads them back from the queue, sets and
splits the parameters and finds views with `debug`.


## What is left of the debugging and test tools (2026-10-15)

The uncited ROM's "debugger, test harness, diagnostics" category
(`coverage.py --categories`, 239 functions, 31 KB) and the testing
system's NOT YETs, gone through one by one - who reaches each
(`analysis/callgraph.py --callers`) and what it would give the host.  The
NTK Inspector, the one debugger a Newton developer used, is already done
(`comms/NTK.h`, ctest `host.NewtonNTK`).

**Done:** the recogniser's replay metrics - below, "The replay metrics" - and
the NewtonScript function profiler's hooks, with a host profiler behind
them (`docs/frames/README.md`, "Profiling NewtonScript").

**Not worth doing on the host** (each kept in the uncited categories with
this reason):

- **The serial and GeoPort debug links** (`TAsyncDebugLink`,
  `TGeoPortDebugLink`, the Hammer translators `PHammerIn/OutTranslator`,
  `InformHammer`) and **ARM's remote debug protocol** (`DoRDP`, `rdpInfo`,
  `rdpStop`, `StopWithStatus`, `ImageCommand`, reached from
  `ReportException` with a debug card fitted): the link to Apple's Hammer
  and ARM's armsd, neither of which exists outside Apple, over a debug
  card the host has not got (`testing/SerialDebugger.cpp` answers
  `kError_Call_Not_Implemented`, DEVIATION).  The host's own debuggers
  see everything; packages' native code, if it ever needs stepping, would
  want a GDB stub on `armcpu`, not RDP.  The task stack limits
  (`GetTaskStackInfo` into `gNewtGlobals`, `InitInterpreter`'s NOT YET)
  are only for these debuggers.
- **The test server** (`TCommServer`, `ProcessTestServerCommand`,
  `ConnectToTestServer`: Apple's desktop test server over AppleTalk ADSP)
  and **the C test cases** (`TTestCaseTask`, a `'tstp` part's code,
  `StartCTestCase`, `DoNewtCTestCase`) and **the tests kept on a store**
  (`MakeTestStore`, `TTestStoreFileList`): Apple's test suites and server
  are not to be had and no package carries a `'tstp` part; the test
  manager on the machine itself already works, and the host's own tests
  drive the OS through scripts.  A test server could be spoken over TCP,
  as the dock is, if a use for one appears.
- `TMsg` (printing to the debug link), the abort and unhandled-exception
  handlers (`InstallAbortHandler`, `UnhandledException` - the host catches
  and reports a fault itself), `StrHexDump`'s helper (the native,
  `FStrHexDump`, is done), `dbprint`, `BlinkRect`.

## The journal (`testing/Journal.h`, ROM 0x000f8e08-0x000f9fd4)

`gJournallingState` says what it is doing: 0 idle, 1 recording, 2 playing
back.

### Recording

`receiver:JournalStartRecord(message, format)` - the receiver is the
function's `self` - keeps the receiver and message (the ROM's
`gJournalRecordStuff`, 0x14 bytes).  From then on
`StrokeCentral::IdleStrokes`, as each stroke is finished, calls
`JournalRecordAStroke`, which sends `receiver:message(binary, size)`:
`binary` a `'foo` binary holding a **JournalStroke** -

| offset | |
|---|---|
| +0x00 | the size in bytes |
| +0x04 | the sample count |
| +0x08 | the down time, in ticks from the first stroke recorded |
| +0x0c | the up time, likewise |
| +0x10 | a sample per point: format 1 the tablet's own sample word (x in eighths of a pixel in bits 18-31, y in bits 4-17, the pressure in the low nibble); format 2 the whole `TabPt` (x and y 16.16, the pressure and flag halfwords) |

The block is sized as though the last sample were twelve bytes, so a
format 1 stroke ends in eight bytes of whatever the block held (kept).
`JournalStopRecord()` ends it.

### Playing back

A `JournalReplayHandler` (0x48 bytes) plays strokes:

- `JournalReplayAStroke(stroke, dx, dy, format, sampleRate, other)` - one
  recorded stroke, moved by (dx, dy) pixels;
- `JournalReplayALine(x1, y1, x2, y2, hold, sampleRate)` - a straight line
  made up on the spot, a sample every two pixels of its longer side (ten
  for a dot).  With `hold` not nil, a line of more than three pixels is
  held still at its start for 60 samples and drawn a sample every eight
  pixels (a press and drag, as a selection is made), and a shorter one is
  drawn twice with a pen-up and a pause of `rate * 9 / 60` empty samples
  between (a double tap);
- `JournalReplayStrokes(strokes, dx, dy, count)` - a file of strokes: a
  0x18-byte header (the format at +2, the stroke count at +4, the sample
  rate at +6, a word at +8 nothing reads) and the strokes end to end,
  each found by the one before's size; `count` plays only the first so
  many.

`JournalReplayBusy()` says whether a replay is still going.

**Timing.**  A replay starts when it is asked for - five seconds later for
a file of several strokes - and each stroke at its down time after that.
A stroke's samples fall due in proportion to the time since it started
(`count * elapsed / duration`), except that a stroke written slower than
the tablet samples (more than 60 samples, fewer a second than eight short
of the sample rate) plays its first 60 at its own pace and the rest at 20
a second.

**Into the tablet buffer.**  `JournalInsertTabletSamople` (the ROM's
spelling) takes every sample that is due and inserts it with
`InsertTabletSample`, a pen-down (0xd) before a stroke's first.  Before
the first stroke of a replay it **bypasses the tablet** -
`StartBypassTablet`, the tablet driver's state 8, in which the real pen's
samples are ignored; refused while the pen is down, and then that first
sample and its pen-down are dropped.  After a stroke's last sample comes
a pen-up (0xe) - *in place of* that last sample, so a replayed stroke
never plays its final point (kept: the `n` of a replayed "ton" loses the
end of its last leg and reads as "tor").  An empty sample (the pause in a
double tap) is skipped.

Nothing ends the bypass when a replay runs out: only `JournalStopReplay`
does, which the test agent calls when it is deactivated or a test exits
(kept - after a replay, the real pen stays out of it).

The test agent's idle proc (`TTestAgent::IdleProc` 0x00228374) runs
`JournalInsertTabletSamople` and puts the journal back to idle when the
replay is no longer busy - every 50 milliseconds under a test manager,
every three seconds otherwise - so a replay needs the agent running
(`ActivateTestAgent`).  The unit tests, which run the view system without
the OS, call that half of the idle proc, `JournalAgentIdle`, from their
wait hook instead.

DEVIATION: the words of a JournalStroke in a binary (what recording makes
and a file holds) are kept big-endian, as the ROM wrote them, so a
journal is the same on every host; the handler turns a stroke into host
order as it copies it in.  A line JournalReplayALine makes is in host
order already, and the handler borrows it rather than copying it (as
the ROM does).

ROM bug kept: `PlayAStroke` moves a stroke by adding the offset to its
first `count` words - its samples in format 1, but in format 2 the wrong
places in the TabPts. Fixed by default (`NEWTON_ROM_BUGS=1` for the ROM's
behaviour): a format 2 stroke's TabPts are moved.

### The tablet's natives

`StartBypassTablet()`/`StopBypassTablet()` (0 or -1), and
`InsertTabletSample(x, y, z, time)`, which puts one sample of the pen at
(x, y) pixels into the buffer (x is not masked to its fourteen bits, so a
negative one fills the word's top - kept).  The tablet driver itself
(`TResistiveTablet`) is NOT YET: the host's tablet (`hal/host/
HostTablet.h`) keeps the driver's state - idle, pen down, bypassed - and
answers the bypass through `gTabletDriverBypass`; while it is bypassed
the window's pen is ignored.  `HobbleTablet` (a message to the inker) is
NOT YET.

### Tests

`test_Views`'s `TestJournal` records a stroke, checks the JournalStroke
it comes as, plays it back moved and checks it reaches a view as a click
there with the tablet bypassed meanwhile, and does the same with a line
from `JournalReplayALine`.  `src/host/demo/journal.ns` (ctest
`host.NewtonJournal`) writes "ton" on the Notepad while recording,
starts the agent as its test manager and plays the four strokes back as
one stroke file (`JournalReplayStrokes`; played one at a time they come
three seconds apart, the agent's idle after each replay, and are read as
four words): the page reads "ton tor" afterwards, and
nothing else.  (It once also left an ink word behind: the replayed word,
written below any text, goes in at the caret without a child of the page
choosing it, and the host's `TEditView::HandleWord` answered nil there,
so the command's result was 0, the handler did not claim the word unit,
the arbiter marked it claimed *and invalid* as an at-once winner, and
the clean-up expired its strokes as ink.  The ROM answers a register it
never set - in `HandleWordUnit`'s case the word's text pointer - which
is not nil; the host now does the same.  Nothing to do with the
journal: a word written well away from the text with remote writing on
did the same.)


## The replay metrics (`recognition/ReplayMetrics.h`, ROM 0x00090284-0x000925c0)

Apple's recognition accuracy harness.  Recorded writing with the text of
each word ("TAP files": `TapFileWordNumber`, `CompleteTapFile` and the
debugger's file channel `TapFileCntl` are what is left of them) was played
back with the arbiter in replay mode; a *replayed unit* ('WRPL', a
`TWordReplayUnit`) over each word's strokes said what had been written
there, and the ROM measured the recognisers against it.  How each fact was
established: the disassembly and Ghidra's decompile of every function
(`analysis/decompile.py --range 0x00090284 0x000925c0 --asm`), the ROM's
strings (the formats are verbatim), and `xrefs.py`/`callgraph.py
--callers` for who reaches what.

**What the ROM has and has not.**  It has the measuring and the arbiter's
side; it has *nothing* that makes a replayed unit or sets the replay mode:
no code writes the arbiter's +0x21 but `IArbiter` (0), no code refers to
'WRPL' but the metrics and the arbiter, nothing calls `ExportReporter`, and
`useWordReplayDomain` is only a slot in the preferences' defaults.  Those
were Apple's test tools (a 'WRPL' domain reading the TAP file), outside the
ROM.  The journal itself records and replays strokes only
(`JournalRecordAStroke` is its one recorder); there is no unit recording.

**The path, as the ROM has it.**

- Replay mode is `TArbiter::fReplaying` (+0x21; misnamed `fWaiting` until
  now).  `FindMatchingArea` and `MakeCharArea` then give a new area
  `HandleReplayUnit` as its unit handler instead of `HandleUnit`;
  `ArbitrateUnits` puts the replayed units first among the winners and,
  after its usual choice (whose winners it marks `kGatheredUnit`), adds
  everything else gathered over the same strokes; `ArbitrateWithScrubs`
  never lets a replayed unit win; `HandleExpiredStroke` and `ExpireGroup`
  leave no ink; `TUnitPublic::FindView` takes the view in the middle of the
  screen.
- `SetCaseAndTime` (0x0020830c) stamps the replayed units at the front of
  the winners with the area's recognition case (`GetRecognitionCase`: the
  scrub types, +2 shapes, +4 words - read once and kept in the arbiter's
  `fCase`) and the time (0 from `DoArbitration`).
- `HandleReplayUnit` (0x00090288): a single winner is left alone;
  otherwise, with stdio on, `WriteTapStats`, and the arbiter told to
  arbitrate at once.  ==> 1.
- `WriteTapStats` (0x00090848): the stats channel must be there
  (`gReplayReporter`, a `TTestReporter` set by `ExportReporter`
  0x002527ac); the first winner may be a control string (`IsControlUnit`);
  otherwise each replayed unit (they must come first) is measured -
  `GatherExpectedMetrics`, then by its case `GatherGraphicsMetrics` (2,
  3), `GatherWordsMetrics` (4, 5) or `GatherWordsGraphicsMetrics` (6, 7) -
  and `PrintMetrics` writes its line.
- `GetCorrespondingUnits` (0x00090b34) finds the winners of the word
  recogniser in use (`gWordID`) or 'GSHP' that start within the replayed
  unit's strokes, and says whether they cover them exactly, start late, run
  on, and whether one of them was the arbitration's own choice.
  `GatherWordMetrics`/`GatherWordScoreTime` count and score them (10000 a
  unit with no reading), and one unit alone covering the strokes is
  measured by `GatherRealWordMetrics`: its readings, strokes, box, first
  reading and score, where the written word stood among the readings -
  exactly, counting the first reading with its first letter's case
  changed, ignoring case - the first five scores, and the learning
  (`MaybeDoLearning`: with learning on, ParaGraph taught the word as a
  writer correcting it `gCorrectRate` times in a hundred would,
  `DoIndexedLearning('XRWR', ...)`).  Shapes likewise
  (`GatherRealShapeMetrics`: the type number as text against the written
  one).
- `PrintMetrics` (0x000902d0), one line, tab-separated: recCase, correct
  (the written kind's units cover exactly its strokes), expected kind (W,
  G, ?), found kind (W, G, $), kind right, time; for words: units found,
  the written word's length (-1 unless a word covered exactly), the word,
  readings, strokes, width, height, first reading, score, eight 0/1
  columns (right first; right first counting a wrong first-letter case; in
  the first three, both ways; five; at all - all -1 unless a word covered
  exactly), the two unit times and their sum (always 0: the unit timing,
  `InitUnitTimingGlobals`, is compiled out of this ROM), the flags
  (0x100000 covered exactly); for shapes the same columns for shapes.
- Control strings (`IsControlUnit` 0x00092410, `HandleControlString`
  0x00091a34): a replayed unit whose text starts "**".  "**0" learning off;
  "**1d" learning on, d how often the writer corrects (0 always, 1 never,
  2 half, 3 a quarter, 4 three quarters); "**2" ParaGraph's letter weights
  reset; "**3d" as 1, learning from the corrector too; "**41"/"**40"
  deferred recognition on/off; "**5..." recognition in a field (0 off,
  "1d" nine fields, "2d" five more, a locale digit after City, State,
  Company, Phone, Date and Time - `SetLocale5`/`SetLocale4` - and
  `AddTestConfig` puts `testFields[n]` into
  `userConfiguration.testConfig`); "**6..." the ink scaled
  (`gScaleFactor`, read by nothing else in the ROM); "**71"/"**70"
  recognition in the corrector.  Each is announced on the stats channel
  (four 0xB4 bytes and "***Replay encountered control string: ...", "**Turn
  Learning On", ..., and then "Beginning test: <name> Field").

**Output.**  `PrintToStats` is `gReplayReporter->TestFPrintf(2, "%s",
...)`: a test reporter's message, which the test agent queues (a test
manager on the machine reads it with `TestMGetReportMsg`, cut at 0xe0
bytes) or would send to the desktop test server.  `PrintError` adds a
printf to stdio.  DEVIATION: every line for the stats channel is also
written to the file `NEWTON_REPLAY_STATS` names; a 4-character type printed
with `%4.4s` is printed as its characters on every host;
`TTestReporter::TestFPrintf` cuts its line at 255 characters (the ROM's
vsprintf overruns the stack for a longer one, which a words-and-shapes
metrics line can be).

**The host's stand-in for the test tools** (DEVIATION,
`recognition/WordReplay.h`): the 'WRPL' recogniser, installed beside the
ROM's in `InitRecognizers`, puts its type in every area that takes words
or shapes while replaying (arbitrated at once, as words and shapes are, so
the arbitration waits for it), and its domain groups the replayed strokes
- told apart by the controller's stroke numbers, counted from the one the
replay started at - into one `TWordReplayUnit` per labelled word, carrying
the label's text and type (one reading, scored 9999, so that it never wins
by score).  The words come from a **word journal** (`testing/Journal.cpp`):
the journal's stroke file as `JournalReplayStrokes` plays it, followed by
'WRPL', a label count, and per label its stroke count (a half word), its
type ('WREC' a word, 'GSHP' a shape), its length and UTF-16 text, padded
to four bytes - big-endian throughout.  Host natives:
`JournalReplayWords(file, dx, dy)` (a binary or a host file's name; the
test agent must be running: the newt world's reporter becomes the stats
channel, the arbiter goes into replay mode, and the area cache is purged so
that areas are built again with the handler and the type),
`JournalReplayWordsBusy()`, `JournalStopReplayWords()`.
`NEWTON_TRACE_REPLAY=1` traces the replayed units.

**Comparing recognisers.**  `tools/recognition/replaymetrics.py`
(`tools/recognition/README.md`) builds word journals from synthetic letters
(printed, or joined into one stroke a word) with control strings, runs
`newton` headless over one through `src/host/demo/replaymetrics.ns` with
`printing` (Rosetta), `cursive` (ParaGraph) or a host engine ('UNIS'),
chosen as the Handwriting Recognition slip chooses them, and tabulates the
ROM's lines.  For "ton to on no it" printed: Rosetta 3 right first and 5 in
its first five ("on" read "0M", "no" "MO"), ParaGraph 5 right first, the
unistroke engine none (it makes a unit of each stroke, so no unit covers a
word).

ROM bug: `HandleControlString`'s smaller scales ("**62d") shift the factor
left by a negative count, which the ARM takes as 255, so every smaller
scale comes out 0 (fixed: shifted right; `NEWTON_ROM_BUGS=1` the ROM's 0).
ROM quirk: `GetCorrespondingUnits` lowers the lowest stroke from the
cleared metrics' 0, so it is always 0.  A curiosity: the space
`GatherExpectedMetrics` puts between words is loaded with an unaligned
`ldr` from `unicodeSpace + 2`, which the ARM rotates into the halfword it
wants.

Found on the way: the host's `TDomain::VUnitInClass` had ParaGraph's type
as 'WRXR' (and 'KANJ' as 'JANK'), so a cursive area's recognition case
counted no words and the scrub gesture won its arbitrations; with the
ROM's literals ParaGraph's synthetic "mum" and "nun" are read
(`host.NewtonCursiveJoined`).

### Tests

ctest `host.NewtonReplayMetrics` (the tool's `compare` on "ton to on no"
printed, Rosetta, with "**0" and "**624": the control strings announced,
the scale 0.5, the line for "ton", 2 right first and 4 in the first five),
`host.NewtonReplayMetrics.romBugs` (the scale 0 with `NEWTON_ROM_BUGS=1`),
`tools.ReplayMetrics` (Rosetta, ParaGraph and the unistroke engine on "ton
to on no it").
