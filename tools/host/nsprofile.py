#!/usr/bin/env python3
"""nsprofile.py - read a report of the host's NewtonScript profiler.

The profiler (src/frames/FunctionProfiler.h, behind the ROM's frames function
profiler hooks) writes a report - to the file NEWTON_NS_PROFILE names when the
program ends, or to stdout from HostNSProfileReport(nil), which on the T-Deck
is its console.  This reads one (the last report in the file, so a captured
console log will do), names the ROM's functions the host could not name by
their paths in the ROM source tree, and prints the top of it.

Usage:
    python tools/host/nsprofile.py REPORT [--romsrc romsrc] [--top N]
                                   [--sort excl|incl|calls] [--expect NAME[=CALLS]]...

  REPORT      the report, or a log holding one (between "### NewtonScript
              profile" and "### end")
  --romsrc    the ROM source tree: an entry with no name but a ROM address
              (the "rom" column: the function object; "code": its
              instructions, for a closure of a ROM function) is named by
              romsrc/layout.tsv's path for it ("Rbuiltinfunctions.AddAlarm")
  --top N     the first N lines (default 40; 0: all)
  --sort      exclusive time (the default), inclusive time or calls
  --expect    a check (for ctests): a function of that name is in the report
              - with exactly CALLS calls when given; the exit status is 1 if
              any fails

Output: a table on stdout - exclusive and inclusive milliseconds, calls,
the exclusive time's share, the kind (ns, native, gc) and the name.
Standard library only.
"""

import argparse
import os
import sys


def read_report(path):
    lines = open(path, encoding='utf-8', errors='replace').read().splitlines()
    start = None
    for i, line in enumerate(lines):
        if line.startswith('### NewtonScript profile'):
            start = i
    if start is None:
        sys.exit('%s: no NewtonScript profile in it' % path)
    header = lines[start]
    rows = []
    for line in lines[start + 1:]:
        if line.startswith('### end'):
            break
        if line.startswith('#') or not line.strip():
            continue
        parts = line.split(None, 7)
        if len(parts) < 8:
            continue
        rows.append({'excl': float(parts[0]), 'incl': float(parts[1]), 'calls': int(parts[2]),
                     'pct': float(parts[3]), 'kind': parts[4], 'rom': parts[5], 'code': parts[6],
                     'name': parts[7]})
    return header, rows


def read_layout(romsrc):
    names = {}
    with open(os.path.join(romsrc, 'layout.tsv'), encoding='utf-8', errors='replace') as f:
        for line in f:
            parts = line.rstrip('\n').split('\t')
            if len(parts) < 2 or line.startswith('#'):
                continue
            try:
                names[int(parts[0], 16)] = parts[1]
            except ValueError:
                pass
    return names


def name_from_layout(row, layout):
    for column, suffix in (('rom', ''), ('code', '.instructions')):
        if row[column] == '-':
            continue
        path = layout.get(int(row[column], 16) - 1)		# (a pointer ref is its address + 1)
        if path is None:
            continue
        if suffix and path.endswith(suffix):
            path = path[:-len(suffix)]
        return path
    return None


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('report')
    ap.add_argument('--romsrc')
    ap.add_argument('--top', type=int, default=40)
    ap.add_argument('--sort', choices=('excl', 'incl', 'calls'), default='excl')
    ap.add_argument('--expect', action='append', default=[])
    a = ap.parse_args()

    header, rows = read_report(a.report)
    named = 0
    if a.romsrc:
        layout = read_layout(a.romsrc)
        for row in rows:
            if row['name'].startswith('#'):
                path = name_from_layout(row, layout)
                if path:
                    row['name'] = path + ' (romsrc)'
                    named += 1
    rows.sort(key=lambda r: r[a.sort], reverse=True)

    print(header.lstrip('# '))
    if a.romsrc:
        print('(%d named from %s)' % (named, os.path.join(a.romsrc, 'layout.tsv')))
    print('%11s %11s %9s %6s  %-6s  %s' % ('excl.ms', 'incl.ms', 'calls', 'excl%', 'kind', 'function'))
    for row in rows[:a.top] if a.top > 0 else rows:
        print('%11.3f %11.3f %9d %6.2f  %-6s  %s' % (row['excl'], row['incl'], row['calls'], row['pct'],
                                                  row['kind'], row['name']))

    failed = 0
    for expect in a.expect:
        name, _, calls = expect.partition('=')
        found = [r for r in rows if r['name'] == name]
        if not found:
            print('nsprofile: FAILED - %s is not in the report' % name)
            failed += 1
        elif calls and found[0]['calls'] != int(calls):
            print('nsprofile: FAILED - %s has %d calls, not %s' % (name, found[0]['calls'], calls))
            failed += 1
        else:
            print('nsprofile: %s is there (%d calls)' % (name, found[0]['calls']))
    if a.expect:
        print('nsprofile: %s' % ('checks failed' if failed else 'checks passed'))
    return 1 if failed else 0


if __name__ == '__main__':
    sys.exit(main())
