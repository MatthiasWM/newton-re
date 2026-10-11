#!/usr/bin/env python3
"""Where the ESP32-S3 host's time goes: the samples of core 1's program
counter that the board's profiler (src/host/esp32/main/tdeck_profile.cpp)
printed - `DeviceProfileDump()` at the NewtonScript prompt - read out of a
console log and named with the firmware's symbols.

    python tools/tdeck/profile.py tmp/tdeck/session.log
        [--elf src/host/esp32/.pio/build/tdeck-pro/firmware.elf] [--top 30]
        [--by function|file|area] [--phases]

A sample is a millisecond of core 1 (the Newton's tasks; FreeRTOS's idle
task is core 1 with nothing to do).  The table: each function's (or source
file's, or src/ area's) samples, share and running share, largest first;
--phases makes one table for each stretch between the boot's marks (the
"newton: ... at N ms" steps).  Standard library and PlatformIO's
xtensa-esp32s3-elf-addr2line (the toolchain's, found under ~/.platformio).
"""

import argparse
import collections
import os
import subprocess
import sys

DEFAULT_ELF = "src/host/esp32/.pio/build/tdeck-pro/firmware.elf"
ADDR2LINE = os.path.expanduser("~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-addr2line")


def read_log(path):
    marks, samples = [], []
    with open(path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = line.strip()
            if line.startswith("prof-mark "):
                _, at, label = line.split(" ", 2)
                marks.append((int(at), label))
            elif line.startswith("prof-begin"):
                marks, samples = [], []			# (the last dump in the log)
            elif line.startswith("prof "):
                samples += [int(w, 16) for w in line.split()[1:]]
    return marks, samples


def names_for(pcs, elf):
    """pc -> (function, file:line)"""
    pcs = sorted(set(pcs))
    out = {}
    for i in range(0, len(pcs), 2000):
        chunk = pcs[i:i + 2000]
        r = subprocess.run([ADDR2LINE, "-f", "-C", "-e", elf] + [hex(p) for p in chunk],
                           capture_output=True, text=True)
        lines = r.stdout.splitlines()
        for j, pc in enumerate(chunk):
            fn = lines[2 * j] if 2 * j < len(lines) else "??"
            loc = lines[2 * j + 1] if 2 * j + 1 < len(lines) else "??"
            out[pc] = (fn, loc.split(" (")[0])
    return out


def key_for(pc, names, by):
    fn, loc = names.get(pc, ("??", "??"))
    if fn == "??":
        return f"?? {pc:08x}" if by == "function" else "??"
    if by == "function":
        return fn
    path = loc.rsplit(":", 1)[0].replace("\\", "/")
    if "/src/" in path:
        path = path[path.index("/src/") + 5:]
    elif "framework-espidf" in path:
        path = "ESP-IDF: " + path.split("components/")[-1].split("/")[0]
    if by == "file":
        return path
    parts = path.split("/")
    return "/".join(parts[:2]) if parts[0] in ("os600", "hal", "host", "comms") and len(parts) > 2 else parts[0]


def table(samples, names, by, top, title):
    counts = collections.Counter(key_for(pc, names, by) for pc in samples)
    total = len(samples)
    print(f"\n{title}: {total} samples ({total / 1000:.1f} s)")
    running = 0
    for key, n in counts.most_common(top):
        running += n
        print(f"  {n:7d}  {100.0 * n / total:5.1f}%  {100.0 * running / total:5.1f}%  {key}")


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("log")
    parser.add_argument("--elf", default=DEFAULT_ELF)
    parser.add_argument("--top", type=int, default=30)
    parser.add_argument("--by", choices=["function", "file", "area"], default="function")
    parser.add_argument("--phases", action="store_true")
    args = parser.parse_args(argv)
    marks, samples = read_log(args.log)
    if not samples:
        print("no profile in the log (DeviceProfileDump() prints one)", file=sys.stderr)
        return 1
    names = names_for(samples, args.elf)
    print("marks: " + "; ".join(f"{label} @ {at / 1000:.1f} s" for at, label in marks))
    table(samples, names, args.by, args.top, "the whole profile")
    if args.phases:
        bounds = [(0, "the start")] + marks + [(len(samples), "the end")]
        for (a, la), (b, _) in zip(bounds, bounds[1:]):
            if b > a:
                table(samples[a:b], names, args.by, args.top, f"from {la}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
