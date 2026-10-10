#!/bin/sh
# stackdepth.sh - how deep a Linux newton's task stacks really go.
#
# Each Newton task runs on a host thread whose stack is a mapping of its own
# (os600/kernel/host/TaskRuntime.cpp: kTaskStackSize, 8 MB, less the guard
# page), so the pages of it a run has touched - the mapping's Rss in
# /proc/<pid>/smaps - are the deepest the task went.  This runs newton with
# the arguments given, samples every task stack's Rss once a second until
# newton exits, and prints the deepest few, the median and the total, with
# the most threads seen.  docs/host-tdeck-pro.md ("Task stacks") is what it
# was made for.
#
#   tools/host/stackdepth.sh <newton> [newton's arguments...]
#   e.g. (WSL, a 32-bit build):
#   tools/host/stackdepth.sh tmp/build-x86/host/newton --objects build/host/romsrc-objects.bin \
#       --display 320x480 --erase --store tmp/depth.store --headless 400 \
#       --script src/host/demo/walkthrough.ns
#
# newton's own output goes to tmp/stackdepth.out (its last "done"/FAILED
# lines are repeated at the end); STACK_KB names another stack size in KB
# (the mapping's size less the 4 KB guard: 8188 for the 8 MB stacks).
# Linux only (it reads /proc); run from the repository's top directory.

mkdir -p tmp
size=${STACK_KB:-8188}
samples=tmp/stackdepth.samples
"$@" > tmp/stackdepth.out 2>&1 &
pid=$!
: > "$samples"
while kill -0 "$pid" 2>/dev/null; do
	awk -v size="$size" '/^[0-9a-f]+-[0-9a-f]+ /{r=$1} /^Size:/{s=$2} /^Rss:/{ if (s==size) print r, $2 }' \
		/proc/$pid/smaps 2>/dev/null >> "$samples"
	awk '/^Threads:/{print "threads", $2}' /proc/$pid/status 2>/dev/null >> "$samples"
	sleep 1
done
awk '$1=="threads" { if ($2 > mt) mt = $2; next }
     { if ($2 > m[$1]) m[$1] = $2 }
     END { for (k in m) print m[k]; print "threads " mt > "/dev/stderr" }' "$samples" 2> tmp/stackdepth.threads \
	| sort -n | awk '{ a[NR] = $1; s += $1 }
	END { printf "task stacks %d, the deepest (KB):", NR
	      for (i = NR; i > NR - 8 && i > 0; i--) printf " %d", a[i]
	      printf "; median %d KB; all %d KB\n", a[int((NR + 1) / 2)], s }'
cat tmp/stackdepth.threads
grep -E "FAILED|: done|fell over" tmp/stackdepth.out | tail -3
