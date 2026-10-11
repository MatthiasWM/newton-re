#!/usr/bin/env python3
"""The reconstruction's sources and include directories for the ESP32-S3
build (src/host/esp32, docs/host-tdeck-pro.md), as a CMake file the
ESP-IDF component includes.

    python tools/tdeck/idf_sources.py <a 32-bit build's compile_commands.json>
        [-o src/host/esp32/main/newton_sources.cmake]

Every library source of the build (configure a 32-bit one -
src/cmake/zig-arm-linux.cmake - with -DCMAKE_EXPORT_COMPILE_COMMANDS=ON),
less what a device does not build:

  - tests, and the sources a build generates (the host's NewtonScript
    panels: HostSettingsSource.cpp and its kind);
  - src/host/ - the desktop's programs, windows and services - but for its
    portable parts: HostNatives.cpp (every area's natives registered),
    HostViews.cpp (the newt world's host boot, the display, the toolbox,
    with HostCards.cpp and HostInterconnect.cpp, whose natives it
    registers) and HostStores.cpp with FactorySoups.cpp (the stores).
  (The host's task runtime and hal/host/System.cpp have ESP-IDF branches
  of their own; the sockets build on ESP-IDF's lwIP.)

Each source keeps the include directories the build gives it, in their
order (the sources grouped by them): headers of one name live in more than
one directory.  The output is generated: regenerate it, don't edit it.
Standard library only.
"""

import argparse
import json
import os
import shlex
import sys

LEFT_OUT = set()
# the portable parts of src/host/: every area's natives, the newt world's
# host boot and display (HostViews.cpp, with the card and interconnect
# natives it registers), the stores (HostStores.cpp, FactorySoups.cpp)
KEPT_IN_HOST = {"host/HostNatives.cpp", "host/HostViews.cpp", "host/HostStores.cpp",
                "host/FactorySoups.cpp", "host/HostCards.cpp", "host/HostInterconnect.cpp"}


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("database")
    parser.add_argument("-o", "--out", default="src/host/esp32/main/newton_sources.cmake")
    args = parser.parse_args(argv)

    entries = json.load(open(args.database))
    norm = lambda p: os.path.normpath(p).replace(os.sep, "/")
    src = None
    for e in entries:
        f = norm(e["file"])
        if "/src/" in f:
            src = f[:f.index("/src/") + 4]
            break
    sources = set()
    includes = {}						# a source: its include directories, in the build's order
    for e in entries:
        f = norm(e["file"])
        if not f.startswith(src + "/"):
            continue					# (a generated source, in the build directory)
        rel = f[len(src) + 1:]
        if "/tests/" in rel or rel.startswith("tests/"):
            continue
        if rel.startswith("host/") and rel not in KEPT_IN_HOST:
            continue
        if rel in LEFT_OUT:
            continue
        sources.add(rel)
        ordered = []
        words = shlex.split(e["command"], posix=False)
        for i, w in enumerate(words):
            d = None
            if w == "-I" and i + 1 < len(words):
                d = words[i + 1]
            elif w.startswith("-I"):
                d = w[2:]
            if d is not None:
                d = norm(d.strip('"'))
                if d.startswith(src):
                    d = d[len(src) + 1:] if d != src else "."
                    if d not in ordered:
                        ordered.append(d)
        includes[rel] = tuple(ordered)

    # PlatformIO's ESP-IDF builder names a source outside the component by
    # its file name alone, so two files of one name (books/Search.cpp,
    # recognition/Search.cpp) would be one object: each such source is
    # compiled through a file of its own name in the component,
    # forwarded/<directory>_<name>, that includes it
    component = os.path.dirname(os.path.abspath(args.out))
    forwarded_dir = os.path.join(component, "forwarded")
    by_name = {}
    for rel in sources:
        by_name.setdefault(os.path.basename(rel).lower(), []).append(rel)
    forwarded = {}
    for name, rels in by_name.items():
        if len(rels) > 1:
            for rel in rels:
                forwarded[rel] = rel.replace("/", "_")
    if os.path.isdir(forwarded_dir):
        for f in os.listdir(forwarded_dir):
            os.remove(os.path.join(forwarded_dir, f))
    if forwarded:
        os.makedirs(forwarded_dir, exist_ok=True)
    for rel, name in forwarded.items():
        target = os.path.relpath(os.path.join(src, rel), forwarded_dir).replace(os.sep, "/")
        with open(os.path.join(forwarded_dir, name), "w", newline="\n") as f:
            f.write(f"// Made by tools/tdeck/idf_sources.py: src/{rel} under a name of its own\n"
                    f"// (another source has its file name) - regenerate, don't edit.\n"
                    f'#include "{target}"\n')

    lines = ["# Made by tools/tdeck/idf_sources.py from a 32-bit build's compile commands -",
             "# regenerate it, don't edit it.  NEWTON_SOURCES are relative to src/;",
             "# NEWTON_FORWARDED, to this directory (sources of a name another has).", ""]
    lines.append("set(NEWTON_SOURCES")
    lines += [f"    {s}" for s in sorted(sources) if s not in forwarded]
    lines.append(")")
    lines.append("set(NEWTON_FORWARDED")
    lines += [f"    forwarded/{forwarded[s]}" for s in sorted(forwarded)]
    lines.append(")")
    # each source's include directories, in the order the build gives them
    # (headers of one name live in more than one directory - hal/Flash.h,
    # stores/flash/Flash.h - so one list for all would find the wrong one):
    # the sources grouped by their list
    groups = {}
    for rel in sorted(sources):
        groups.setdefault(includes[rel], []).append(f"forwarded/{forwarded[rel]}" if rel in forwarded else rel)
    lines.append(f"set(NEWTON_GROUP_COUNT {len(groups)})")
    for n, (dirs, members) in enumerate(sorted(groups.items(), key=lambda kv: kv[1][0])):
        lines.append(f"set(NEWTON_GROUP_{n}_SOURCES")
        lines += [f"    {m}" for m in members]
        lines.append(")")
        lines.append(f"set(NEWTON_GROUP_{n}_INCLUDES")
        lines += [f"    {d}" for d in dirs]
        lines.append(")")
    os.makedirs(os.path.dirname(args.out), exist_ok=True)
    open(args.out, "w", newline="\n").write("\n".join(lines) + "\n")
    print(f"{args.out}: {len(sources)} sources ({len(forwarded)} forwarded) in {len(groups)} groups by include directories")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
