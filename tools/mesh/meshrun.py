#!/usr/bin/env python3
"""Runs mesh nodes together on one pretend air: some peers in the background
and a main command, every "{port}" in their arguments replaced by the same
UDP port, chosen afresh for each run so that runs side by side (ctest -j)
do not hear each other.

    python tools/mesh/meshrun.py [--seconds N] [--port P]
        [--peer "<command and arguments>"]... -- <main command and arguments>

Each --peer is one command line (split as a shell would, POSIX rules); the
main command is everything after "--".  The peers start first, then the
main command; the run ends when the main command does, the peers are
stopped, and meshrun exits with the main command's status (1 if it ran
past --seconds, 300 by default).  Every line any of them prints is printed
here, prefixed with the command's name and its number - which is what a
ctest's PASS_REGULAR_EXPRESSION looks at.

The nodes are src/hal/host/MeshPeer.cpp's meshpeer and newton --mesh-air
lan:{port} (hal/host/HostMesh.h, HostMeshAir.cpp): the air is the UDP
multicast group 239.255.78.121 on that port.  ctests hal.MeshPeers and
host.NewtonMesh.<size> (src/hal/tests/CMakeLists.txt,
src/host/CMakeLists.txt).
"""

import argparse
import os
import random
import shlex
import subprocess
import sys
import threading
import time


def relay(process, label, lock):
    for raw in iter(process.stdout.readline, b""):
        line = raw.decode("utf-8", "replace").rstrip("\r\n")
        with lock:
            print(f"[{label}] {line}", flush=True)


def start(argv, label, lock):
    process = subprocess.Popen(argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, stdin=subprocess.DEVNULL)
    thread = threading.Thread(target=relay, args=(process, label, lock), daemon=True)
    thread.start()
    return process, thread


def main():
    argv = sys.argv[1:]
    if "--" not in argv:
        print("meshrun: the main command goes after --", file=sys.stderr)
        return 2
    split = argv.index("--")
    parser = argparse.ArgumentParser()
    parser.add_argument("--seconds", type=float, default=300)
    parser.add_argument("--port", type=int, default=0)
    parser.add_argument("--peer", action="append", default=[])
    options = parser.parse_args(argv[:split])
    command = argv[split + 1:]
    port = options.port or random.randint(20000, 40000)
    substitute = lambda args: [a.replace("{port}", str(port)) for a in args]
    print(f"meshrun: the air on port {port}", flush=True)

    lock = threading.Lock()
    peers = []
    for n, line in enumerate(options.peer):
        args = substitute(shlex.split(line))
        peers.append(start(args, f"{os.path.basename(args[0])}{n + 1}", lock))
    time.sleep(0.5)                                  # (the peers' air open first)
    main_args = substitute(command)
    process, thread = start(main_args, os.path.basename(main_args[0]), lock)
    try:
        status = process.wait(timeout=options.seconds)
    except subprocess.TimeoutExpired:
        process.kill()
        print("meshrun: the main command ran out of time", flush=True)
        status = 1
    thread.join(timeout=5)
    for peer, peer_thread in peers:
        if peer.poll() is None:
            peer.kill()
        peer.wait()
        peer_thread.join(timeout=5)
    print(f"meshrun: done, status {status}", flush=True)
    return status


if __name__ == "__main__":
    sys.exit(main())
