#!/usr/bin/env python3
"""The recognisers measured on the same writing, with the ROM's replay metrics.

The Newton ROM carries Apple's recognition accuracy harness
(src/recognition/ReplayMetrics.h): recorded writing is played back with the
arbiter in replay mode, a replayed unit over each word says what was written,
and WriteTapStats/PrintMetrics write a line of metrics per word - whether the
recogniser's units cover the word's strokes, its readings, where the right
one stood among them, the scores.  On the host the writing comes from a
*word journal* (src/testing/Journal.cpp: the journal's stroke file followed
by a label per word) played by JournalReplayWords, and the lines go to the
file NEWTON_REPLAY_STATS names.  This tool makes word journals, runs
`newton` headless over one with a given recogniser, and compares them.

Usage:
    replaymetrics.py build WORD... -o FILE [--style printed|joined] [--control "**0"]...
    replaymetrics.py run --newton EXE --journal FILE --recognizer NAME [--stats OUT] [--rom IMAGE]
    replaymetrics.py compare --newton EXE WORD... [--recognizers printing,cursive,UNIS]
                     [--style printed|joined] [--control ...] [--rom IMAGE] [--keep DIR]
                     [--expect-lines N]
    replaymetrics.py summary STATS...

WORD is a word of lower-case letters (a..z); `build` writes each with the
synthetic letters below - `printed`, a letter at a time in the shapes the host
demos' penhelpers.ns writes t, o and n in (Rosetta's kind of writing), or
`joined`, each word's letters run into one stroke (ParaGraph's kind), the
dots and bars after.  --control adds a control string ("**0" learning off,
"**10" learning on with the writer always correcting, ... - see
HandleControlString) before the words, written as a short dash on a line
of its own above them.

A recogniser NAME is `printing` (Rosetta: the letter set 2), `cursive`
(ParaGraph: the letter set 0) or the type of one of the host's own engines
(`UNIS`, the unistroke engine: HostWordEngines()), chosen the way the
Handwriting Recognition slip chooses them (userConfiguration's
letterSetSelection and hostWordEngine, then ReadCursiveOptions).

`run` starts `newton --display 320x480 --headless 300 --script
src/host/demo/replaymetrics.ns` with NEWTON_REPLAY_JOURNAL,
NEWTON_REPLAY_RECOGNIZER and NEWTON_REPLAY_STATS set, and prints the stats
lines and a summary.  `compare` builds the journal, runs every recogniser over
it and prints a table: per recogniser the words measured, read right first
time, right among the first five (the ROM's columns), covered exactly, and the
mean first score.  It exits 1 when a run fails or measures fewer lines than
--expect-lines.

The stats line (PrintMetrics, tab-separated): recCase, correct, expected
kind, found kind, kind right, time; for a case with words: units found,
length written (-1 unless a word covered exactly), word written, readings,
strokes, width, height, first reading, score, then eight 0/1 columns - right
first, right first counting a wrong first-letter case, in the first three
(both ways), five, at all - the two times and their sum, the flags; for a case
with shapes the same for shapes.  Lines starting "**" are control strings
announced.

Reproducible from a clean checkout: needs only Python 3 and a built
`newton` (with the ROM image extracted, or booting from romsrc/).
"""

import argparse
import os
import struct
import subprocess
import sys
import tempfile

REPO = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..'))
DEMO = os.path.join(REPO, 'src', 'host', 'demo', 'replaymetrics.ns')


# --------------------------------------------------------------------------
# synthetic letters: strokes of (x, y) points, y up negative from the
# baseline, the x-height 14 pixels, ascenders 24, descenders 8

def oval(cx, cy, rx, ry, start=0, steps=12):
    """An oval from the top going anticlockwise, as an o is written (the
    twelfths of a turn penhelpers.ns uses)."""
    c = [0, -50, -87, -100, -87, -50, 0, 50, 87, 100, 87, 50, 0]
    s = [100, 87, 50, 0, -50, -87, -100, -87, -50, 0, 50, 87, 100]
    pts = []
    for k in range(start, start + steps + 1):
        k %= 12
        pts.append((cx + rx * c[k] / 100.0, cy - ry * s[k] / 100.0))
    return pts


O = oval(6, -7, 6, 7)
ARCH = [(0, -14), (0, -7), (0, 0), (0, -7), (1, -11), (3, -13), (6, -14), (9, -13),
        (10, -10), (10, -5), (10, 0)]

# letter: (advance, [strokes])
LETTERS = {
    'a': (16, [O, [(12, -14), (12, 0)]]),
    'b': (16, [[(0, -24), (0, 0)], O]),
    'c': (14, [oval(6, -7, 6, 7, 11, 8)]),
    'd': (16, [O, [(12, -24), (12, 0)]]),
    'e': (16, [[(0, -7), (12, -7)] + oval(6, -7, 6, 7, 9, 10)[1:]]),
    'f': (12, [[(10, -24), (6, -24), (4, -21), (4, 0)], [(0, -14), (9, -14)]]),
    'g': (16, [O, [(12, -14), (12, 5), (9, 8), (3, 8), (0, 5)]]),
    'h': (14, [[(0, -24), (0, 0)], [(0, -7), (1, -11), (3, -13), (6, -14), (9, -13), (10, -10), (10, 0)]]),
    'i': (8, [[(2, -14), (2, 0)], [(2, -20), (2, -19)]]),
    'j': (10, [[(6, -14), (6, 5), (3, 8), (0, 6)], [(6, -20), (6, -19)]]),
    'k': (14, [[(0, -24), (0, 0)], [(10, -14), (0, -6), (10, 0)]]),
    'l': (8, [[(2, -24), (2, 0)]]),
    'm': (22, [[(0, -14), (0, 0), (0, -7), (1, -11), (3, -13), (5, -14), (7, -13), (8, -10), (8, 0),
                (8, -10), (9, -13), (11, -14), (13, -13), (15, -10), (16, -5), (16, 0)]]),
    'n': (16, [ARCH]),
    'o': (16, [O]),
    'p': (16, [[(0, -14), (0, 8)], O]),
    'q': (16, [O, [(12, -14), (12, 8)]]),
    'r': (12, [[(0, -14), (0, 0)], [(0, -9), (3, -13), (6, -14), (10, -13)]]),
    's': (14, [[(11, -12), (8, -14), (3, -14), (0, -11), (2, -8), (10, -6), (12, -3), (9, 0), (3, 0), (0, -2)]]),
    't': (16, [[(6, -24), (6, 0)], [(0, -14), (12, -14)]]),
    'u': (16, [[(0, -14), (0, -4), (2, -1), (6, 0), (10, -2), (12, -6)], [(12, -14), (12, 0)]]),
    'v': (14, [[(0, -14), (6, 0), (12, -14)]]),
    'w': (20, [[(0, -14), (4, 0), (8, -10), (12, 0), (16, -14)]]),
    'x': (14, [[(0, -14), (12, 0)], [(12, -14), (0, 0)]]),
    'y': (14, [[(0, -14), (6, 0)], [(12, -14), (3, 8)]]),
    'z': (14, [[(0, -14), (12, -14), (0, 0), (12, 0)]]),
}

SPACE = 14          # between words
LEFT, RIGHT = 20, 300
FIRST_BASE, LINE = 150, 50


def densify(points, step=2.0):
    """A sample every `step` pixels along the polyline, as a pen gives them."""
    out = [points[0]]
    for (x0, y0), (x1, y1) in zip(points, points[1:]):
        n = max(1, int(max(abs(x1 - x0), abs(y1 - y0)) / step))
        for k in range(1, n + 1):
            out.append((x0 + (x1 - x0) * k / n, y0 + (y1 - y0) * k / n))
    return out


def word_strokes(word, x, base, style):
    """The strokes of a word written from x on the baseline: ==> (strokes,
    the x after it)."""
    letters = []
    for ch in word:
        if ch not in LETTERS:
            raise SystemExit("replaymetrics: no synthetic letter for %r" % ch)
        adv, strokes = LETTERS[ch]
        letters.append([[(x + px, base + py) for px, py in s] for s in strokes])
        x += adv
    if style == 'printed':
        return [s for l in letters for s in l], x
    # joined: each letter's first stroke run into the next, the rest after
    main = []
    rest = []
    for l in letters:
        main.extend(l[0])
        rest.extend(l[1:])
    return [main] + rest, x


def control_stroke(x, base):
    """What a control string is written as: a short dash."""
    return [[(x, base - 7), (x + 6, base - 7)]], x + 6


def layout(words, controls, style):
    """Every label's strokes on the page: ==> [(type, text, strokes)]."""
    out = []
    # the control strings on a line of their own, well apart, so that no
    # recogniser groups their dashes with each other or with a word (a
    # control string that shares its units' winners with a word is all
    # WriteTapStats looks at)
    x, base = LEFT, FIRST_BASE - LINE
    for c in controls:
        strokes, x = control_stroke(x, base)
        out.append(('WREC', c, strokes))
        x += 4 * SPACE
    x, base = LEFT, FIRST_BASE
    for w in words:
        width = sum(LETTERS[ch][0] for ch in w if ch in LETTERS)
        if x + width > RIGHT and x > LEFT:
            x, base = LEFT, base + LINE
        strokes, x = word_strokes(w, x, base, style)
        out.append(('WREC', w, strokes))
        x += SPACE
    return out


def sample_word(x, y, z=4):
    """The tablet's sample word (testing/Journal.h): x and y in eighths of
    a pixel in bits 18-31 and 4-17, the pressure in the low nibble."""
    xi = int(round(x * 8)) & 0x3fff
    yi = int(round(y * 8)) & 0x3fff
    return (xi << 18) | (yi << 4) | (z & 0xf)


def journal_bytes(labels, rate=100):
    """A word journal: the stroke file (a 0x18-byte header - format 1, the
    count, the sample rate - and each JournalStroke) and the labels."""
    strokes = []
    t = 0
    for _, text, ss in labels:
        for s in ss:
            pts = densify(s)
            down = t
            up = t + max(1, len(pts) * 60 // rate)
            body = b''.join(struct.pack('>I', sample_word(px, py)) for px, py in pts)
            # (sized as recording sizes it: as though the last sample were twelve bytes)
            size = 0x10 + 4 * len(pts) + 8
            strokes.append(struct.pack('>IIII', size, len(pts), down, up) + body + b'\0' * 8)
            t = up + 8
        # a pause between words; three seconds after a control string, so
        # that its dash is read on its own before the words begin
        t += 180 if text.startswith('**') else 30
    out = bytearray(struct.pack('>HHHH', 0, 1, len(strokes), rate) + b'\0' * 0x10)
    for s in strokes:
        out += s
    out += b'WRPL' + struct.pack('>I', len(labels))
    for typ, text, ss in labels:
        u = text.encode('utf-16-be')
        rec = struct.pack('>H4sH', len(ss), typ.encode('ascii'), len(u) // 2) + u
        rec += b'\0' * (-len(u) % 4)
        out += rec
    return bytes(out)


# --------------------------------------------------------------------------
# running and reading

def parse_stats(text):
    """The metrics lines (tab-separated, starting with a recognition case)."""
    lines = []
    for line in text.splitlines():
        if not line or line.startswith('**') or line.startswith('\xb4') or line.startswith('ERROR'):
            continue
        fields = line.rstrip('\t').split('\t')
        if len(fields) < 6 or not fields[0].lstrip('-').isdigit():
            continue
        lines.append(fields)
    return lines


def word_rows(lines):
    """Each line of a case with words as a dict of the word columns."""
    rows = []
    for f in lines:
        case = int(f[0])
        if not case & 4 or len(f) < 6 + 9 + 8:
            continue
        w = f[6:]
        rows.append({
            'case': case, 'correct': int(f[1]), 'expectedKind': f[2], 'foundKind': f[3],
            'units': int(w[0]), 'written': w[2], 'readings': int(w[3]), 'read': w[7],
            'score': int(w[8]), 'first': int(w[9]), 'firstCase': int(w[10]),
            'top3': int(w[11]), 'top5': int(w[13]), 'any': int(w[15]),
        })
    return rows


def summarise(rows):
    n = len(rows)
    first = sum(1 for r in rows if r['first'] == 1)
    top5 = sum(1 for r in rows if r['top5'] == 1)
    covered = sum(1 for r in rows if r['correct'] == 1)
    scores = [r['score'] for r in rows if r['score'] >= 0]
    mean = (sum(scores) / len(scores)) if scores else -1
    return {'words': n, 'first': first, 'top5': top5, 'covered': covered, 'meanScore': mean}


def run_one(newton, journal, recognizer, stats, rom=None, seconds=300, display='320x480'):
    """newton headless over the journal: ==> (exit code, the output)."""
    if os.path.exists(stats):
        os.remove(stats)
    env = dict(os.environ)
    env['NEWTON_REPLAY_JOURNAL'] = os.path.abspath(journal)
    env['NEWTON_REPLAY_RECOGNIZER'] = recognizer
    env['NEWTON_REPLAY_STATS'] = os.path.abspath(stats)
    newton = os.path.abspath(newton)
    cmd = [newton, '--display', display, '--headless', str(seconds), '--script', DEMO]
    if rom:
        cmd[1:1] = ['--rom', rom]
    p = subprocess.run(cmd, cwd=REPO, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                       timeout=seconds + 120)
    return p.returncode, p.stdout.decode('latin-1')


def read_text(path):
    if not os.path.exists(path):
        return ''
    with open(path, 'rb') as f:
        return f.read().decode('latin-1')


def cmd_build(args):
    labels = layout(args.words, args.control or [], args.style)
    with open(args.output, 'wb') as f:
        f.write(journal_bytes(labels))
    print("replaymetrics: %d labels, %d strokes -> %s" % (len(labels), sum(len(l[2]) for l in labels), args.output))


def cmd_run(args):
    stats = args.stats or os.path.splitext(args.journal)[0] + '-' + args.recognizer + '.tsv'
    code, out = run_one(args.newton, args.journal, args.recognizer, stats, args.rom)
    sys.stdout.write(out)
    text = read_text(stats)
    print("replaymetrics: stats (%s):" % stats)
    sys.stdout.write(text)
    s = summarise(word_rows(parse_stats(text)))
    print("replaymetrics: %s: %d words, %d right first, %d in the first five, %d covered, mean score %.0f"
          % (args.recognizer, s['words'], s['first'], s['top5'], s['covered'], s['meanScore']))
    return 0 if code == 0 and 'replaymetrics: done' in out else 1


def cmd_compare(args):
    keep = args.keep or tempfile.mkdtemp(prefix='replaymetrics-')
    os.makedirs(keep, exist_ok=True)
    journal = os.path.join(keep, 'words.jnl')
    labels = layout(args.words, args.control or [], args.style)
    with open(journal, 'wb') as f:
        f.write(journal_bytes(labels))
    failed = 0
    results = []
    for rec in args.recognizers.split(','):
        stats = os.path.join(keep, 'stats-%s.tsv' % rec)
        code, out = run_one(args.newton, journal, rec, stats, args.rom)
        with open(os.path.join(keep, 'log-%s.txt' % rec), 'w', encoding='latin-1') as f:
            f.write(out)
        text = read_text(stats)
        rows = word_rows(parse_stats(text))
        ok = code == 0 and 'replaymetrics: done' in out and len(rows) >= args.expect_lines
        if not ok:
            failed += 1
        results.append((rec, summarise(rows), rows, ok))
        for line in text.splitlines():
            print("replaymetrics: %s: %s" % (rec, line.replace('\t', ' | ')))
    print("replaymetrics: %-10s %6s %6s %6s %8s %10s" % ('recogniser', 'words', 'first', 'top5', 'covered', 'mean score'))
    for rec, s, rows, ok in results:
        print("replaymetrics: %-10s %6d %6d %6d %8d %10.0f%s" % (rec, s['words'], s['first'], s['top5'],
              s['covered'], s['meanScore'], '' if ok else '  FAILED'))
        for r in rows:
            print("replaymetrics: %-10s   %-12s read %-14s rank %s" % (rec, r['written'], r['read'],
                  'first' if r['first'] == 1 else ('top5' if r['top5'] == 1 else
                                                   ('-' if r['first'] < 0 else 'no'))))
    print("replaymetrics: files in %s" % keep)
    print("replaymetrics: compare %s" % ('done' if failed == 0 else 'FAILED (%d)' % failed))
    return 1 if failed else 0


def cmd_summary(args):
    for path in args.stats:
        s = summarise(word_rows(parse_stats(read_text(path))))
        print("%s: %d words, %d right first, %d in the first five, %d covered, mean score %.0f"
              % (path, s['words'], s['first'], s['top5'], s['covered'], s['meanScore']))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    sub = ap.add_subparsers(dest='cmd', required=True)
    b = sub.add_parser('build')
    b.add_argument('words', nargs='+')
    b.add_argument('-o', '--output', required=True)
    b.add_argument('--style', choices=['printed', 'joined'], default='printed')
    b.add_argument('--control', action='append')
    r = sub.add_parser('run')
    r.add_argument('--newton', required=True)
    r.add_argument('--journal', required=True)
    r.add_argument('--recognizer', default='printing')
    r.add_argument('--stats')
    r.add_argument('--rom')
    c = sub.add_parser('compare')
    c.add_argument('words', nargs='+')
    c.add_argument('--newton', required=True)
    c.add_argument('--recognizers', default='printing,cursive')
    c.add_argument('--style', choices=['printed', 'joined'], default='printed')
    c.add_argument('--control', action='append')
    c.add_argument('--rom')
    c.add_argument('--keep')
    c.add_argument('--expect-lines', type=int, default=1)
    s = sub.add_parser('summary')
    s.add_argument('stats', nargs='+')
    args = ap.parse_args()
    return {'build': cmd_build, 'run': cmd_run, 'compare': cmd_compare, 'summary': cmd_summary}[args.cmd](args) or 0


if __name__ == '__main__':
    sys.exit(main())
