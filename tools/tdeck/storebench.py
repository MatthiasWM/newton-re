#!/usr/bin/env python3
"""How long the T-Deck Pro's store takes to write: soup entries added and
removed at the board's NewtonScript prompt, timed by the Newton's own Ticks.

    ~/.platformio/penv/Scripts/python tools/tdeck/storebench.py COM4 [--count 10]

Each statement is typed by tools/tdeck/serialcapture.py, one capture each,
waiting for the REP's "(N ms)" that ends its answer (a long one says
nothing for many seconds).  The Newton's sleep (SleepTime) is turned off
for the run and put back after: asleep, it would finish nothing.  Ten cards
named "Bench <n>" are added to the Names soup and removed again.  Prints
"add N: T ms" and "remove N: T ms" (docs/host-tdeck-pro.md, "Batched
store writes").
"""

import argparse
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))


STEP = [0]


def run(port, line, seconds=600):
    # (each step's capture kept: tmp/tdeck/storebench-<n>.log)
    STEP[0] += 1
    log = os.path.join("tmp", "tdeck", "storebench-%d.log" % STEP[0])
    out = subprocess.run([sys.executable, os.path.join(HERE, "serialcapture.py"), port, str(seconds),
                          "--after", "", "--until", " ms)", "--send", line, "--out", log],
                         capture_output=True, text=True, errors="replace").stdout
    return out


def number_after(text, label):
    m = re.search(re.escape(label) + r'"?,\s*(\d+)', text)
    return int(m.group(1)) if m else None


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("port")
    ap.add_argument("--count", type=int, default=10)
    args = ap.parse_args()
    n = args.count
    run(args.port, "benchSleep := GetUserConfig('SleepTime); SetUserConfig('SleepTime, nil);")
    # (each statement short: the board's console reads a long line in pieces)
    run(args.port, "bA:=func(n)begin local s:=GetUnionSoup(\"Names\");local t:=Ticks();for i:=1 to n do "
                   "s:AddToDefaultStoreXmit({class:'person,name:{first:\"Bench\",last:NumberStr(i)},cardType:0,"
                   "sorton:\"Bench\"},nil);(Ticks()-t)*1000 div 60 end;")
    # (the loop's body in begin..end: without, c:Next() is after the loop and
    #  the cursor stays on the first card that is not a bench one, for ever)
    run(args.port, "bX:=func(e)if StrEqual(e.sorton,\"Bench\") then begin EntryRemoveFromSoupXmit(e,nil);1 end else 0;")
    run(args.port, "bR:=func()begin local c:=Query(GetUnionSoup(\"Names\"),{type:'index});local t:=Ticks();"
                   "local e;local n:=0;while e:=c:Entry() do begin n:=n+call bX with (e);c:Next() end;"
                   "[n,(Ticks()-t)*1000 div 60] end;")
    out = run(args.port, "Print([\"benchadd\", call bA with (%d)]);" % n)
    print("add %d: %s ms" % (n, number_after(out, "benchadd")))
    out = run(args.port, "Print([\"benchremove\", call bR with ()]);")
    m = re.search(r'"benchremove",\s*\[\s*(\d+),\s*(\d+)', out.replace("\n", " "))
    print("remove %s: %s ms" % ((m.group(1), m.group(2)) if m else ("?", "?")))
    run(args.port, "SetUserConfig('SleepTime, benchSleep);")


if __name__ == "__main__":
    main()
