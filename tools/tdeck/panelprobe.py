#!/usr/bin/env python3
"""Which way of driving the T-Deck Pro's panel works, found by looking: for
each combination of the panel's settings (src/host/esp32/main/tdeck_panel.cpp,
DevicePanelSet), the board's test pattern is run and photographed with a
webcam pointed at the panel (tools/tdeck/camshot.py), and each photograph is
read - the four quarters of the test's middle square, dark or light - to see
whether the panel went through the pattern's three pictures:

    A  (a full refresh)        the left half black, the right white
    B  (a partial refresh)     the square's top half flipped: its top-left
                               quarter white, its top-right black
    A  (a partial refresh)     back again

    build/tdeck-venv/Scripts/python tools/tdeck/panelprobe.py --send tmp/tdeck/send.txt --log tmp/tdeck/session.log
        [--camera 0] [--crop X,Y,W,H] [--screen X0,Y0,X1,Y1] [--set name=v,name=v]...
        [--keep tmp/tdeck/probe]

Needs a serialcapture.py running with --send-file and --out (the board's
console: DevicePanelSet lines are typed through it, and the board's lines
saying each of the test's refreshes is done - "trace" on - are read from
its log, so that each picture is photographed when it is there), a webcam on the panel, and
OpenCV (camshot.py says how).  --crop is the panel's rectangle in the
camera's frame (as camshot.py's), --screen the panel's 240 x 320 pixels'
corners within the crop (both found by looking at one camshot.py picture);
each --set is a combination to try (the settings it names, the rest as the
board has them).  For each, a line: the quarters' states in each
photograph (K dark, W light, - between) and PASS when A, B, A were all
seen in order.  --keep saves the photographs.
"""

import argparse
import os
import sys
import time

sys.path.insert(0, os.path.dirname(__file__))
import cv2  # noqa: E402
from camshot import open_camera, settle  # noqa: E402

# the quarters of the test square (160 x 160 at 40, 80): their centres in
# the panel's pixels, and what each picture has there
QUARTERS = {"TL": (80, 120), "TR": (160, 120), "BL": (80, 200), "BR": (160, 200)}
PICTURES = {"A": {"TL": "K", "TR": "W", "BL": "K", "BR": "W"},
            "B": {"TL": "W", "TR": "K", "BL": "K", "BR": "W"}}


def quarters(frame, crop, screen):
    x, y, w, h = crop
    frame = cv2.cvtColor(frame[y:y + h, x:x + w], cv2.COLOR_BGR2GRAY)
    x0, y0, x1, y1 = screen
    states = {}
    levels = {}
    for name, (px, py) in QUARTERS.items():
        cx = int(x0 + (x1 - x0) * px / 240.0)
        cy = int(y0 + (y1 - y0) * py / 320.0)
        r = max(2, int((x1 - x0) / 40))
        level = float(frame[cy - r:cy + r, cx - r:cx + r].mean())
        levels[name] = level
    # dark and light judged against the frame's own range (the lighting)
    lo, hi = min(levels.values()), max(levels.values())
    for name, level in levels.items():
        if hi - lo < 40:
            states[name] = "?"
        elif level < lo + (hi - lo) * 0.35:
            states[name] = "K"
        elif level > lo + (hi - lo) * 0.65:
            states[name] = "W"
        else:
            states[name] = "-"
    return states


def picture_of(states):
    for name, want in PICTURES.items():
        if all(states[q] == want[q] for q in QUARTERS):
            return name
    return "".join(states[q] for q in QUARTERS)


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--send", required=True)
    parser.add_argument("--log", required=True)
    parser.add_argument("--camera", type=int, default=0)
    parser.add_argument("--crop", default="1060,110,300,340")
    parser.add_argument("--screen", default="17,25,260,328")
    parser.add_argument("--set", action="append", default=[])
    parser.add_argument("--keep")
    args = parser.parse_args(argv)
    crop = [int(v) for v in args.crop.split(",")]
    screen = [int(v) for v in args.screen.split(",")]
    cam = open_camera(args.camera)
    if cam is None:
        print("no camera", file=sys.stderr)
        return 1
    settle(cam)
    if args.keep:
        os.makedirs(args.keep, exist_ok=True)
    for n, combination in enumerate(args.set or [""]):
        with open(args.send, "a") as f:
            for pair in filter(None, combination.split(",")):
                name, value = pair.split("=")
                f.write(f'DevicePanelSet("{name}", {value});\n')
            f.write('DevicePanelSet("test", 1);\n')
        seen = []
        # the board's lines: each step's announcement, then its refresh done
        steps = ["test (1)", "test (2)", "test (3)", "test done"]
        log = open(args.log, encoding="utf-8", errors="replace")
        log.seek(0, os.SEEK_END)
        text = ""
        start = time.time()
        step = 0
        while step < 3 and time.time() - start < 60:
            cam.read()					# (the camera's buffer kept fresh)
            text += log.read()
            at = text.find(steps[step])
            if at < 0:
                continue
            done = text.find("refresh", at + len(steps[step]))
            if done < 0 or "\n" not in text[done:]:
                continue
            for _ in range(8):			# (a few frames: the panel settled, the camera caught up)
                cam.read()
            ok, frame = cam.read()
            pic = picture_of(quarters(frame, crop, screen)) if ok else "none"
            seen.append((pic, round(time.time() - start, 1)))
            if args.keep:
                cv2.imwrite(os.path.join(args.keep, f"{n:02d}-{step + 1}-{pic}.png"),
                            frame[crop[1]:crop[1] + crop[3], crop[0]:crop[0] + crop[2]])
            text = text[done:]
            step += 1
        log.close()
        passed = [p for p, _ in seen] == ["A", "B", "A"]
        print(f"{combination or '(as it is)'}: {' '.join(f'{p}@{t}' for p, t in seen)}  {'PASS' if passed else 'fail'}", flush=True)
        # (the test ends with a full refresh back to the Newton's screen)
        end = time.time() + 6
        while time.time() < end:
            cam.read()
    cam.release()
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
