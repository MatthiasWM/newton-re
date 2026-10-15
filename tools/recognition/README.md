# Recognition tools

## `replaymetrics.py` - the recognisers compared with the ROM's replay metrics

**Purpose.**  Measures how well each recogniser reads the same writing,
using Apple's own accuracy harness in the ROM (`src/recognition/ReplayMetrics.h`,
`docs/testing/README.md` "The replay metrics"): a *word journal* - strokes
and what each word was - is played back with the arbiter in replay mode,
and the ROM writes one line of metrics per word (whether the recogniser's
units cover the word's strokes, its readings, where the right reading
stood, the scores).

**Inputs.**  Words (lower-case a..z) and optional control strings; or a
word journal file; a built `newton` (`build/host/host/newton`, or a
worktree's build).  No ROM image is needed (the OS boots from `romsrc/`);
`--rom build/MP2x00US/rom.bin` boots the original for cross-checking.

**Outputs.**  A word journal (`build`); the stats lines and a summary
(`run`); a table per recogniser - words measured, right first time, right
among the first five, covered exactly, mean first score - and every
word's first reading (`compare`), with the journal, each run's log and
stats file kept in `--keep DIR` (a temporary directory otherwise).

**Invocation.**

```sh
# a journal of four printed words with learning turned off first
python tools/recognition/replaymetrics.py build ton to on no --control "**0" -o build/words.jnl
# one recogniser over it: printing (Rosetta), cursive (ParaGraph), or a host engine's type (UNIS)
python tools/recognition/replaymetrics.py run --newton build/host/host/newton --journal build/words.jnl --recognizer cursive
# build and compare in one go
python tools/recognition/replaymetrics.py compare --newton build/host/host/newton ton to on no it \
    --recognizers printing,cursive,UNIS [--style joined] [--keep build/replaymetrics]
# the summary of stats files already made
python tools/recognition/replaymetrics.py summary build/replaymetrics/stats-*.tsv
```

`run` starts `newton --display 320x480 --headless 300 --script
src/host/demo/replaymetrics.ns` with `NEWTON_REPLAY_JOURNAL` (the journal),
`NEWTON_REPLAY_RECOGNIZER` (the recogniser, chosen the way the Handwriting
Recognition slip chooses it: `letterSetSelection`, `hostWordEngine`,
`ReadCursiveOptions`) and `NEWTON_REPLAY_STATS` (where the ROM's stats
channel is copied).  The demo walks Setup, starts the test agent as its
test manager, calls `JournalReplayWords`, waits for `JournalReplayWordsBusy()`
to go nil, prints the queued reports and ends.

**The synthetic writing.**  `printed` writes each letter in separate
strokes, x-height 14 pixels (t, o and n as `src/host/demo/penhelpers.ns`
writes them, the other letters in the same style); `joined` runs each
word's letters into one stroke and adds the dots and bars after it.  Words
go left to right on the Notepad from y = 150, 50 pixels a line; samples
every two pixels at 100 a second, 30 ticks between words.  Control strings
(HandleControlString: "**0" learning off, "**1d" on with the writer
correcting 0 always .. 4 three quarters of the time, "**624" the ink half
the size, ...) are a short dash each on a line of their own above, three
seconds apart from what follows, so that no recogniser groups a dash with a
word.  Recorded ink can be put in a word journal the same way: the stroke
file `JournalStartRecord` makes (see `src/host/demo/journal.ns`) followed by
the labels (`src/testing/Journal.cpp` describes the format;
`journal_bytes` writes it).

**The stats line** is PrintMetrics' (tab-separated): recCase, correct,
expected kind, found kind, kind right, time; for words: units found,
length (-1 unless covered exactly), word written, readings, strokes,
width, height, first reading, score, eight 0/1 columns (right first;
counting a wrong first-letter case; first three both ways; five; at all),
two times and their sum (0), flags; then shapes likewise.

**Tests.**  ctests `host.NewtonReplayMetrics`, `host.NewtonReplayMetrics.romBugs`
and `tools.ReplayMetrics` (`src/host/CMakeLists.txt`).

Python 3 only, no packages.
