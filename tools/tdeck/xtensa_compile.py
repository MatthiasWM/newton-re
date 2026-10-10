#!/usr/bin/env python3
"""The reconstruction compiled with the ESP32-S3's compiler: how much of the
tree builds as it is, why the rest does not, and how big the code comes to.

    python tools/tdeck/xtensa_compile.py <a build's compile_commands.json>
        [--gcc <xtensa-esp32s3-elf-g++>] [--out tmp/tdeck/xtensa]
        [--only DIR,...] [--jobs N] [--opt -Os]

It takes every file of a CMake build (configure it with
-DCMAKE_EXPORT_COMPILE_COMMANDS=ON; a 32-bit one - src/cmake/zig-arm-linux.cmake
- so that the defines and include paths are a 32-bit host's), keeps its -I,
-D and -include, and compiles it again with ESP-IDF's GCC for the ESP32-S3
(the one PlatformIO installs: ~/.platformio/packages/toolchain-xtensa-esp32s3)
and the flags the tree needs - C++17 with exceptions, -fwrapv, -fsigned-char,
-falign-functions=4 - plus the Xtensa ones ESP-IDF uses (-mlongcalls,
function and data sections).  Nothing is linked: this says what compiles,
not what runs.

Output: tmp/tdeck/xtensa/report.txt - per directory how many files compiled;
the failures grouped by their first error (a missing header named by
itself, so that what a port must supply is listed once); the compiled
objects' code and data by directory.  The objects and each failure's full
messages are kept beside it.  Standard library only (and the compiler).
"""

import argparse
import collections
import concurrent.futures
import json
import os
import re
import shlex
import subprocess
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "host"))
from codesize import elf_sections, SHF_ALLOC, SHT_NOBITS  # noqa: E402

DEFAULT_GCC = os.path.expanduser("~/.platformio/packages/toolchain-xtensa-esp32s3/bin/xtensa-esp32s3-elf-g++")
FLAGS = ["-std=gnu++17", "-fexceptions", "-fwrapv", "-fsigned-char", "-falign-functions=4",
         "-mlongcalls", "-ffunction-sections", "-fdata-sections", "-w"]


def kept_arguments(command):
    """The -I, -D and -include of a compile command."""
    words = shlex.split(command, posix=False)
    kept = []
    i = 0
    while i < len(words):
        w = words[i]
        if w in ("-include", "-isystem", "-I", "-D") and i + 1 < len(words):
            kept += [w, words[i + 1].strip('"')]
            i += 2
            continue
        if w.startswith("-I"):
            kept.append(w.strip('"'))
        elif w.startswith("-D"):
            kept.append(w.replace('\\"', '"'))		# (a quoted value: -DNAME=\"...\")
        i += 1
    return kept


def area(path, src):
    rel = os.path.relpath(path, src).replace("\\", "/")
    parts = rel.split("/")
    return "/".join(parts[:2]) if len(parts) > 2 and parts[0] in ("host", "hal", "os600", "comms", "print") else parts[0]


def compile_one(entry, gcc, out, opt, index):
    path = entry["file"]
    is_c = path.endswith(".c")
    compiler = gcc.replace("g++", "gcc") if is_c else gcc
    flags = [f for f in FLAGS if not (is_c and f in ("-std=gnu++17", "-fexceptions"))]
    if is_c:
        flags = ["-std=gnu11"] + flags
    obj = os.path.join(out, "obj", f"{index:04d}_{os.path.basename(path)}.o")
    args = [compiler, opt] + flags + kept_arguments(entry["command"]) + ["-c", path, "-o", obj]
    r = subprocess.run(args, capture_output=True, text=True, cwd=entry.get("directory"))
    return path, r.returncode == 0, obj, r.stderr


def first_error(stderr):
    for line in stderr.splitlines():
        m = re.search(r"fatal error: ([^:]+): No such file", line)
        if m:
            return f"missing header <{m.group(1)}>"
        m = re.search(r"error: (.*)", line)
        if m:
            text = m.group(1)
            text = re.sub(r"'[^']*'", "'...'", text)	# (names out, so like errors group)
            return text[:120]
    return "(no error line)"


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("database")
    parser.add_argument("--gcc", default=DEFAULT_GCC)
    parser.add_argument("--out", default="tmp/tdeck/xtensa")
    parser.add_argument("--only", help="comma-separated src/ directories")
    parser.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    parser.add_argument("--opt", default="-Os")
    args = parser.parse_args(argv)
    args.out = os.path.abspath(args.out)			# (each compile runs in its build directory)

    entries = json.load(open(args.database))
    src = os.path.commonpath([e["file"] for e in entries if "/src/" in e["file"].replace("\\", "/")])
    src = src[:src.replace("\\", "/").index("/src") + 4] if "/src" in src.replace("\\", "/") else src
    if args.only:
        wanted = args.only.split(",")
        entries = [e for e in entries if area(e["file"], src).split("/")[0] in wanted]
    # tests and tools are not what a device carries
    entries = [e for e in entries if "/tests/" not in e["file"].replace("\\", "/")]
    os.makedirs(os.path.join(args.out, "obj"), exist_ok=True)
    os.makedirs(os.path.join(args.out, "errors"), exist_ok=True)

    per_area = collections.defaultdict(lambda: [0, 0])
    failures = collections.defaultdict(list)
    sizes = collections.Counter()
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        jobs = [pool.submit(compile_one, e, args.gcc, args.out, args.opt, i) for i, e in enumerate(entries)]
        for n, job in enumerate(concurrent.futures.as_completed(jobs)):
            path, ok, obj, stderr = job.result()
            a = area(path, src)
            per_area[a][0 if ok else 1] += 1
            if ok:
                data = open(obj, "rb").read()
                for name, kind, flags, size in elf_sections(data):
                    if flags & SHF_ALLOC and kind != SHT_NOBITS and name.startswith((".text", ".rodata", ".data", ".literal")):
                        sizes[a] += size
            else:
                failures[first_error(stderr)].append(os.path.relpath(path, src).replace("\\", "/"))
                with open(os.path.join(args.out, "errors", os.path.basename(path) + ".txt"), "w") as f:
                    f.write(stderr)
            if (n + 1) % 100 == 0:
                print(f"  {n + 1}/{len(jobs)}", file=sys.stderr)

    lines = []
    total_ok = sum(v[0] for v in per_area.values())
    total = sum(v[0] + v[1] for v in per_area.values())
    lines.append(f"{args.gcc} {args.opt}: {total_ok} of {total} files compiled")
    lines.append(f"code and data of what compiled: {sum(sizes.values()) / 1024 / 1024:.2f} MB (before linking drops what is unused)")
    lines.append("")
    lines.append("by area (compiled / failed, code and data):")
    for a in sorted(per_area, key=lambda a: -sizes[a]):
        ok, bad = per_area[a]
        lines.append(f"  {a:28} {ok:4} / {bad:3}   {sizes[a] / 1024:7.0f} KB")
    lines.append("")
    lines.append("failures by first error:")
    for err, files in sorted(failures.items(), key=lambda kv: -len(kv[1])):
        lines.append(f"  {len(files):3}  {err}")
        for f in sorted(files)[:6]:
            lines.append(f"         {f}")
        if len(files) > 6:
            lines.append(f"         ... and {len(files) - 6} more")
    report = "\n".join(lines) + "\n"
    open(os.path.join(args.out, "report.txt"), "w").write(report)
    print(report)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
