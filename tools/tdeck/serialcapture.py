#!/usr/bin/env python3
"""What a board prints on its serial port for a while, to the console and a
file - the non-interactive counterpart of `pio device monitor`.

    <PlatformIO's python> tools/tdeck/serialcapture.py <port> <seconds> [--out tmp/tdeck/serial.log]
        [--until TEXT] [--reset]

Needs pyserial, which PlatformIO's own Python has
(~/.platformio/penv/Scripts/python.exe).  --until stops at the first line
holding TEXT (e.g. "spike: done"); --reset pulses the ESP32-S3's reset
through the USB serial/JTAG port's RTS/DTR first, so the capture starts at
boot.  A port that goes away (the board resetting) is opened again.
"""

import argparse
import sys
import time

import serial


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("port")
    parser.add_argument("seconds", type=float)
    parser.add_argument("--out", default="tmp/tdeck/serial.log")
    parser.add_argument("--until")
    parser.add_argument("--reset", action="store_true")
    args = parser.parse_args(argv)

    end = time.time() + args.seconds
    out = open(args.out, "w", encoding="utf-8", newline="\n")
    port = None
    pending = b""
    reset_done = not args.reset
    while time.time() < end:
        if port is None:
            try:
                port = serial.Serial(args.port, 115200, timeout=0.2)
            except serial.SerialException:
                time.sleep(0.3)
                continue
            if not reset_done:
                port.dtr = False
                port.rts = True
                time.sleep(0.1)
                port.rts = False
                reset_done = True
        try:
            chunk = port.read(4096)
        except serial.SerialException:
            port = None
            continue
        if not chunk:
            continue
        pending += chunk
        while b"\n" in pending:
            line, pending = pending.split(b"\n", 1)
            text = line.decode("utf-8", "replace").rstrip("\r")
            print(text, flush=True)
            out.write(text + "\n")
            out.flush()
            if args.until and args.until in text:
                return 0
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
