#!/usr/bin/env python3
"""How big a host build of the reconstruction is, as a device would carry it.

    python tools/host/codesize.py <build dir> [--program host/newton] [--top N]

Prints the program's loaded sections (code, read-only data, initialised and
zeroed data, exception tables), then the code and data each static library
of the build contributes before the linker drops what is unused - which is
what leaving a subsystem out would save.  Reads ELF (32- or 64-bit, either
byte order) and the build's .a archives of ELF objects; standard library
only.  Made for docs/host-tdeck-pro.md, over a build made with
src/cmake/zig-arm-linux.cmake.
"""

import argparse
import collections
import glob
import os
import struct
import sys


def elf_sections(data):
    """[(name, type, flags, size)] of an ELF image or object."""
    if data[:4] != b"\x7fELF":
        raise ValueError("not ELF")
    wide = data[4] == 2
    end = "<" if data[5] == 1 else ">"
    if wide:
        shoff, = struct.unpack_from(end + "Q", data, 0x28)
        shentsize, shnum, shstrndx = struct.unpack_from(end + "HHH", data, 0x3A)
        fmt = "IIQQQQIIQQ"
    else:
        shoff, = struct.unpack_from(end + "I", data, 0x20)
        shentsize, shnum, shstrndx = struct.unpack_from(end + "HHH", data, 0x2E)
        fmt = "IIIIIIIIII"
    raw = [struct.unpack_from(end + fmt, data, shoff + i * shentsize) for i in range(shnum)]
    strings = raw[shstrndx][4]
    out = []
    for name, kind, flags, addr, offset, size, link, info, align, entsize in raw:
        stop = data.index(b"\0", strings + name)
        out.append((data[strings + name:stop].decode("latin-1"), kind, flags, size))
    return out


def archive_members(data):
    """The members of a Unix ar archive."""
    if data[:8] != b"!<arch>\n":
        return
    at = 8
    while at + 60 <= len(data):
        size = int(data[at + 48:at + 58].strip() or 0)
        yield data[at + 60:at + 60 + size]
        at += 60 + size + (size & 1)


SHF_ALLOC = 2
SHT_NOBITS = 8


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("build")
    parser.add_argument("--program", default="host/newton")
    parser.add_argument("--top", type=int, default=25)
    args = parser.parse_args(argv)

    path = os.path.join(args.build, args.program)
    with open(path, "rb") as f:
        data = f.read()
    print(f"{path}: {len(data) / 1024 / 1024:.2f} MB on disk")
    for name, kind, flags, size in elf_sections(data):
        if flags & SHF_ALLOC and size >= 1024:
            what = "zeroed" if kind == SHT_NOBITS else ""
            print(f"  {name:22} {size / 1024:9.0f} KB {what}")

    per = collections.Counter()
    for lib in glob.glob(os.path.join(args.build, "**", "*.a"), recursive=True):
        with open(lib, "rb") as f:
            for member in archive_members(f.read()):
                if member[:4] != b"\x7fELF":
                    continue
                for name, kind, flags, size in elf_sections(member):
                    if flags & SHF_ALLOC and kind != SHT_NOBITS and name.startswith((".text", ".rodata", ".data")):
                        per[os.path.basename(lib)] += size
    if per:
        print(f"the libraries' code and data, before the linker drops what is unused "
              f"({sum(per.values()) / 1024 / 1024:.1f} MB in all):")
        for lib, size in per.most_common(args.top):
            print(f"  {lib:32} {size / 1024:8.0f} KB")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
