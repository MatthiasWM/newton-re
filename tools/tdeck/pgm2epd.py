#!/usr/bin/env python3
"""A screenshot of the Newton (a PGM newton wrote) as a C array for the
T-Deck Pro's panel: 240x320, one bit a pixel, a set bit white, rows top to
bottom, each byte's top bit leftmost (tools/tdeck/spike/src/epd.h).

    python tools/tdeck/pgm2epd.py <screen.pgm> <out.c> [--name newton_screen]

The screenshot is newton's own at the panel's size, made on the desktop:

    SHOT=tmp/tdeck/screen.pgm build/host/host/newton --display 240x320x1 --erase \\
        --store tmp/tdeck/screen.store --headless 40 --script tools/tdeck/screenshot.ns

A pixel darker than half is black.  Standard library only.
"""

import argparse
import sys


def read_pgm(path):
    data = open(path, "rb").read()
    fields = []
    at = 0
    while len(fields) < 4:
        while data[at:at + 1].isspace():
            at += 1
        if data[at:at + 1] == b"#":
            at = data.index(b"\n", at)
            continue
        start = at
        while not data[at:at + 1].isspace():
            at += 1
        fields.append(data[start:at])
    if fields[0] != b"P5":
        raise ValueError("not a binary PGM")
    width, height, maxval = int(fields[1]), int(fields[2]), int(fields[3])
    pixels = data[at + 1:at + 1 + width * height]
    return width, height, maxval, pixels


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("pgm")
    parser.add_argument("out")
    parser.add_argument("--name", default="newton_screen")
    args = parser.parse_args(argv)
    width, height, maxval, pixels = read_pgm(args.pgm)
    if (width, height) != (240, 320):
        print(f"{args.pgm} is {width}x{height}, not the panel's 240x320", file=sys.stderr)
        return 1
    frame = bytearray(width // 8 * height)
    for y in range(height):
        for x in range(width):
            if pixels[y * width + x] * 2 >= maxval:
                frame[y * (width // 8) + x // 8] |= 0x80 >> (x & 7)
    with open(args.out, "w", newline="\n") as f:
        f.write(f"// Made by tools/tdeck/pgm2epd.py from {args.pgm.replace(chr(92), '/')} - regenerate, don't edit.\n")
        f.write("#include <stdint.h>\n\n")
        f.write(f"const uint8_t {args.name}[{len(frame)}] = {{\n")
        for i in range(0, len(frame), 16):
            f.write("\t" + ", ".join(f"0x{b:02x}" for b in frame[i:i + 16]) + ",\n")
        f.write("};\n")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
