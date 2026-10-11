#!/usr/bin/env python3
"""A picture of what the T-Deck Pro's panel shows, from the board's own
account of it: typing `!shot` at its console (src/host/esp32/main/
esp32main.cpp - answered by the board whatever the Newton is doing) prints
the frame the panel driver last sent (tdeck_panel.cpp's HostDevicePanelDump:
"shot-begin W H", a "shot <hex>" line a row, a set bit white, "shot-end"),
which this reads out of a console log and writes as a PNG.

    python tools/tdeck/panelshot.py tmp/tdeck/session.log [-o tmp/tdeck/panel.png] [--scale 2]

The last picture in the log is taken.  It is what was sent, not what the
glass shows (a refresh's ghosts are the camera's - tools/tdeck/camshot.py).
Standard library only.
"""

import argparse
import struct
import sys
import zlib


def is_hex(text):
    try:
        bytes.fromhex(text)
        return len(text) > 0
    except ValueError:
        return False


def read_shot(path):
    rows, size, current = None, None, None
    broken = False			# a row's "shot " with a log line of ESP-IDF's (WiFi's) spliced in after it: its hex on the next line
    with open(path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = line.strip()
            if "shot-begin" in line:				# (a log line of the board's own may come before it)
                _, w, h = line[line.index("shot-begin"):].split()[:3]
                current, size = [], (int(w), int(h))
            elif line.startswith("shot-end") and current is not None:
                rows, current = current, None
            elif line.startswith("shot ") and current is not None:
                broken = not is_hex(line[5:])
                if not broken:
                    current.append(bytes.fromhex(line[5:]))
            elif broken and current is not None and is_hex(line):
                current.append(bytes.fromhex(line))
                broken = False
    return size, rows


def write_png(path, width, height, gray_rows):
    raw = b"".join(b"\x00" + bytes(r) for r in gray_rows)
    def chunk(kind, data):
        return struct.pack(">I", len(data)) + kind + data + struct.pack(">I", zlib.crc32(kind + data) & 0xffffffff)
    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 0, 0, 0, 0))
    png += chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b"")
    open(path, "wb").write(png)


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("log")
    parser.add_argument("-o", "--out", default="tmp/tdeck/panel.png")
    parser.add_argument("--scale", type=int, default=2)
    args = parser.parse_args(argv)
    size, rows = read_shot(args.log)
    if rows is None:
        print("no picture in the log (type !shot at the board's console)", file=sys.stderr)
        return 1
    width, height = size
    gray = []
    for r in rows:
        line = []
        for x in range(width):
            white = (r[x >> 3] >> (7 - (x & 7))) & 1
            line += [255 if white else 0] * args.scale
        for _ in range(args.scale):
            gray.append(line)
    write_png(args.out, width * args.scale, len(rows) * args.scale, gray)
    print(args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
