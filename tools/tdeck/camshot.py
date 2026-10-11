#!/usr/bin/env python3
"""A photograph of the board's e-paper panel from a webcam pointed at it -
how what the panel really shows (ghosts, inversions, refreshes that never
came) is looked at from the development machine, since the panel cannot be
read back (the board only writes to it).

    build/tdeck-venv/Scripts/python tools/tdeck/camshot.py [--camera N] [--out tmp/tdeck/cam.png]
        [--after SECONDS] [--every SECONDS --count N] [--crop X,Y,W,H] [--zoom N] [--sheet] [--list]

Needs OpenCV (once: `python -m venv build/tdeck-venv` and
`build/tdeck-venv/Scripts/python -m pip install opencv-python`).  --camera
picks the camera by its index (0 by default; --list tries the first few and
says which open and at what size; a virtual camera such as OBS's opens
too, and shows its own picture).  --crop keeps only that rectangle of the
frame (where the panel is) and --zoom scales it up so many times, so that
the panel's pixels can be looked at.  The camera is given a second to settle
its exposure and focus, then a frame is saved as a PNG; --after waits so
long first (to catch a refresh that is about to happen); --every with
--count saves a series, cam-000.png, cam-001.png ... beside --out (to catch
a refresh as it happens), and --sheet puts the series side by side, each
numbered, in <out>-sheet.png (one picture to look at).  Prints each file
it wrote.
"""

import argparse
import os
import sys
import time

import cv2


def open_camera(index):
    cam = cv2.VideoCapture(index, cv2.CAP_DSHOW) if sys.platform == "win32" else cv2.VideoCapture(index)
    if not cam.isOpened():
        return None
    # as large as the camera gives (the panel is small in the picture)
    cam.set(cv2.CAP_PROP_FRAME_WIDTH, 3840)
    cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 2160)
    return cam


def settle(cam, seconds=1.0):
    end = time.time() + seconds
    while time.time() < end:
        cam.read()


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--camera", type=int, default=0)
    parser.add_argument("--out", default="tmp/tdeck/cam.png")
    parser.add_argument("--after", type=float, default=0)
    parser.add_argument("--every", type=float)
    parser.add_argument("--count", type=int, default=1)
    parser.add_argument("--crop")
    parser.add_argument("--zoom", type=float, default=1)
    parser.add_argument("--sheet", action="store_true")
    parser.add_argument("--list", action="store_true")
    args = parser.parse_args(argv)

    if args.list:
        for i in range(5):
            cam = open_camera(i)
            if cam is None:
                continue
            ok, frame = cam.read()
            print(f"camera {i}: " + (f"{frame.shape[1]} x {frame.shape[0]}" if ok else "opens, gives no frame"))
            cam.release()
        return 0

    cam = open_camera(args.camera)
    if cam is None:
        print(f"camera {args.camera} does not open", file=sys.stderr)
        return 1
    settle(cam)
    if args.after:
        end = time.time() + args.after
        while time.time() < end:
            cam.read()					# (kept reading: the camera's buffer stays fresh)
    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    series = args.every is not None and args.count > 1
    shots = []
    base, ext = os.path.splitext(args.out)
    for n in range(args.count if series else 1):
        if n > 0:
            end = time.time() + args.every
            while time.time() < end:
                cam.read()
        ok, frame = cam.read()
        if not ok:
            print("no frame from the camera", file=sys.stderr)
            return 1
        if args.crop:
            x, y, w, h = (int(v) for v in args.crop.split(","))
            frame = frame[y:y + h, x:x + w]
        if args.zoom != 1:
            frame = cv2.resize(frame, None, fx=args.zoom, fy=args.zoom, interpolation=cv2.INTER_CUBIC)
        path = f"{base}-{n:03d}{ext}" if series else args.out
        cv2.imwrite(path, frame)
        print(path)
        shots.append(frame)
    cam.release()
    if args.sheet and shots:
        import numpy as np
        h, w = shots[0].shape[:2]
        scale = min(1.0, 240.0 / w)
        tiles = [cv2.resize(f, (int(w * scale), int(h * scale))) for f in shots]
        for i, t in enumerate(tiles):
            cv2.putText(t, str(i), (5, 22), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
        per_row = 7
        while len(tiles) % per_row and len(tiles) > per_row:
            tiles.append(np.zeros_like(tiles[0]))
        rows = [np.hstack(tiles[i:i + per_row]) for i in range(0, len(tiles), per_row)]
        sheet = f"{base}-sheet{ext}"
        cv2.imwrite(sheet, np.vstack(rows))
        print(sheet)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
