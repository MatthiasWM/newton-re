#!/usr/bin/env python3
"""What a board prints on its serial port for a while, to the console and a
file - the non-interactive counterpart of `pio device monitor`.

    <PlatformIO's python> tools/tdeck/serialcapture.py <port> <seconds> [--out tmp/tdeck/serial.log]
        [--until TEXT] [--reset] [--send LINE]... [--after TEXT] [--quiet-ms N]
        [--send-file FILE]

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
is read as if it ended them with newlines.  --after "" sends at once (a
board already running).

--send-file FILE: every line added to FILE while the capture runs is sent
too, as --send's are - so that one long capture (in the background) can
be typed into from outside without opening the port again; opening it
anew can reset the board.  The file is emptied at the start.
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
    parser.add_argument("--send-file")
    args = parser.parse_args(argv)

    end = time.time() + args.seconds
    out = open(args.out, "w", encoding="utf-8", newline="\n")
    port = None
    pending = b""
    reset_done = not args.reset
    to_send = list(args.send)
    sending = args.after == ""			# (--after "": a board already running, sent to at once)
    last_output = time.time()
    if args.send_file:
        open(args.send_file, "w").close()
    send_file_at = 0
    while time.time() < end:
        if args.send_file:
            with open(args.send_file, "rb") as f:
                f.seek(send_file_at)
                added = f.read()
            if b"\n" in added:
                complete = added[:added.rindex(b"\n") + 1]
                send_file_at += len(complete)
                to_send += [l for l in complete.decode("utf-8", "replace").splitlines() if l.strip()]
                sending = True
        if port is None:
            try:
                # opened with DTR and RTS low: the ESP32-S3's USB serial/JTAG
                # takes their changing as a reset, and a board looked at
                # (no --reset) is to keep running
                port = serial.Serial()
                port.port = args.port
                port.baudrate = 115200
                port.timeout = 0.2
                port.write_timeout = 2		# (a board that stops reading must not stop the capture too)
                port.dtr = False
                port.rts = False
                port.open()
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
                try:
                    port.write((line + "\n").encode("utf-8"))
                except serial.SerialTimeoutException:
                    print("(the board is not reading: line dropped)", flush=True)
                    out.write("(the board is not reading: line dropped)\n")
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
