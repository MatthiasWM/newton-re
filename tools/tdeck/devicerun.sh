#!/bin/sh
# devicerun.sh - the user walkthroughs on a device's budget (docs/host-tdeck-pro.md,
# "A device-sized run").
#
#   tools/tdeck/devicerun.sh <newton> [newton's options...]
#   e.g. (WSL 2, the 32-bit build of src/cmake/zig-x86-linux.cmake):
#   tools/tdeck/devicerun.sh tmp/build-x86/host/newton --objects build/host/romsrc-objects.bin \
#       --kernel-heap 3 --heap 1048576 --flash-size 4 --task-stack 32
#
# Runs src/host/demo/walkthrough.ns and walkthrough2.ns, each on a new store
# and then again on that store (the restart checks) - the ctests'
# host.NewtonWalkthrough[2][.restart] - with the options given and
# NEWTON_MEMORY_REPORT set, and prints for each its result line, the
# memory report (the kernel heap's peak, what the ROM's objects hold) and
# the process's peak resident memory (GNU time's "Maximum resident set
# size").  Each run's whole output: tmp/devicerun-<n>.log.  Linux only (GNU
# time); run from the repository's top directory.

newton=$1
shift
mkdir -p tmp
n=0
for script in walkthrough walkthrough2; do
	for pass in first restart; do
		n=$((n + 1))
		store=tmp/devicerun-$script.store
		erase=
		[ "$pass" = first ] && erase=--erase
		log=tmp/devicerun-$n.log
		NEWTON_MEMORY_REPORT=1 /usr/bin/time -v "$newton" "$@" --display 320x480 $erase --store "$store" \
			--headless 600 --script src/host/demo/$script.ns > "$log" 2>&1
		result=$(grep -E ": (restart )?done, [0-9]+ failed" "$log" | tail -1)
		[ -z "$result" ] && result="(no result: $(grep -E 'fell over|waited in vain|out of memory|No memory|exited' "$log" | head -1))"
		echo "$script $pass: $result"
		grep "\[host\] memory:" "$log" | sed 's/^/    /'
		grep "Maximum resident set size" "$log" | sed 's/^\s*/    /'
	done
done
