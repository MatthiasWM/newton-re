#!/usr/bin/env python3
"""What a board prints on its serial port for a while, to the console and a
file - the non-interactive counterpart of `pio device monitor`.

    <PlatformIO's python> tools/tdeck/serialcapture.py <port> <seconds> [--out tmp/tdeck/serial.log]
        [--until TEXT] [--reset] [--send LINE]... [--after TEXT] [--quiet-ms N]

Needs pyserial, which PlatformIO's own Python has
(~/.platformio/penv/Scripts/python.exe).  --until stops at the first line
holding TEXT (e.g. "spike: done"); --reset pulses the ESP32-S3's reset
through the USB serial/JTAG port's RTS/DTR first, so the capture starts at
boot.  A port that goes away (the board resetting) is opened again.

--send LINE (repeatable) types the lines to the board, one at a time, once
a line holding --after TEXT has been seen ("Welcome to NewtonScript" by
default): each is sent when the board has printed nothing for --quiet-ms
(600 by default), so that a long answer is not interrupted - how the
NewtonScript prompt on the ESP32-S3 host (src/host/esp32) is driven from a
script.  A board ending its lines with CR alone (the NewtonScript REP does)
is read as if it ended them with newlines.
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
    parser.add_argument("--send", action="append", default=[])
    parser.add_argument("--after", default="Welcome to NewtonScript")
    parser.add_argument("--quiet-ms", type=int, default=600)
    args = parser.parse_args(argv)

    end = time.time() + args.seconds
    out = open(args.out, "w", encoding="utf-8", newline="\n")
    port = None
    pending = b""
    reset_done = not args.reset
    to_send = list(args.send)
    sending = False
    last_output = time.time()
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
            if sending and to_send and time.time() - last_output > args.quiet_ms / 1000.0:
                line = to_send.pop(0)
                print(">>> " + line, flush=True)
                out.write(">>> " + line + "\n")
                port.write((line + "\n").encode("utf-8"))
                last_output = time.time()
            continue
        last_output = time.time()
        pending += chunk.replace(b"\r\n", b"\n").replace(b"\r", b"\n")
        while b"\n" in pending:
            line, pending = pending.split(b"\n", 1)
            text = line.decode("utf-8", "replace")
            print(text, flush=True)
            out.write(text + "\n")
            out.flush()
            if to_send and args.after in text:
                sending = True
            if args.until and args.until in text:
                return 0
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
