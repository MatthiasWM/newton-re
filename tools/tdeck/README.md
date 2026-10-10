# tools/tdeck - the LilyGO T-Deck Pro

Tools for the small-device investigation (`docs/host-tdeck-pro.md`): the
reconstruction on an ESP32-S3 with 8 MB of PSRAM, a 240x320 e-paper, a
touch panel and a keyboard.  Nothing here is the OS; these measure what a
port of it needs to know.

Everything builds with PlatformIO (its own Python, ESP-IDF and toolchains -
`~/.platformio`), so a checkout and PlatformIO are all that is needed:

    ~/.platformio/penv/Scripts/pio run -d tools/tdeck/spike                         # build
    ~/.platformio/penv/Scripts/pio run -d tools/tdeck/spike -t upload --upload-port COM4
    ~/.platformio/penv/Scripts/python tools/tdeck/serialcapture.py COM4 120 --until "spike: done" --reset

(On Linux and macOS `penv/bin/` for `penv/Scripts/`, and the port's own
name.)  The first build installs ESP-IDF and its toolchains, about 1.5 GB:
install them on their own first, with no time limit, so that a long
download never cuts a build short - an Xtensa toolchain cut off part way
leaves the linker unable to find `-lc`; delete that package and install
again:

    ~/.platformio/penv/Scripts/pio pkg install -d tools/tdeck/spike

After that a rebuild takes about 20 s.  The board shows up as the ESP32-S3's own USB serial/JTAG port
(USB 303A:1001); flashing it replaces what was there.

## spike/ - what the board is like

A PlatformIO project, framework ESP-IDF (`platform = espressif32@6.5.0`,
ESP-IDF 5.1; the board's PSRAM is quad, not the octal LilyGO's README
says), that prints lines beginning `spike:` over the USB serial port:

1. **The board**: the chip's revision, the flash and PSRAM sizes, the free
   heaps, and an I2C scan - which also says the board revision (LilyGO's
   own firmware tells them apart the same way: V1.1 adds a DRV2605 haptic
   driver at 0x5A, MAX an XL9555 expander at 0x20 as well).
2. **Memory**: for internal SRAM, PSRAM and flash mapped through the cache
   (the `bench` partition), at sizes inside and outside the cache - the
   time a *dependent* read takes (each address made from the word read
   before it, which is how the NewtonScript interpreter walks objects) and
   a sequential sum's bandwidth.
3. **The panel**: a Newton screen (`src/newton_screen.c`, below) drawn with
   the panel's own full waveform; with the temperature forced to three
   values (`CCSET`/`TSSET`: a forced temperature picks a shorter waveform
   from the panel's OTP); and a 64x64 window refreshed on its own
   (`PTIN`/`PTL`) - each refresh timed from `DRF` to the end of BUSY.
   Measured once (docs/host-tdeck-pro.md, "What the device spike
   showed"), so off by default now: `kPanelTimings` in `spike.c` runs them
   again.  The panel is powered off at the end, never put into deep sleep:
   without its reset line, deep sleep lasts until the board loses power.
4. **Input**, for a minute and a half, over five black targets drawn on
   the panel (the four corners clockwise from the top left, then the
   centre, 16 x 16 pixels): the touch panel's reports as they change
   (position, finger count, the raw bytes) and the keyboard's keys (down
   and up, row and column, the character).

Sources of the facts it relies on:

- pins and I2C addresses: LilyGO's [T-Deck-Pro](https://github.com/Xinyuan-LilyGO/T-Deck-Pro)
  schematic (`hardware/T-Deckpro v1.0 24-05-16/`) and `examples/factory/utilities.h`;
- the panel driver (`src/epd.c`): the UltraChip UC8253 datasheet
  (`hardware/UC8253.pdf`) - its command table; written from it, not from
  any library (LilyGO's code is GPL-3.0, so none of it is copied here);
  one thing the datasheet does not say plainly, found on the board: in
  this black-and-white mode the image shown is the one sent with DTM1
  (0x10), the frame before it goes to DTM2 (0x13);
- the touch report (register 0xD000, seven bytes ending 0xAB, 0xD109 for
  normal mode): read off LilyGO's `examples/touch_hyn_core/arduino/hyn_cst3xx.c`;
- the keyboard (a 4x10 matrix on a TCA8418, an event `0x80 | row * 10 +
  column + 1` with the columns counted from the right, the layout): the
  owner's own lilyphone1 project (`src/peripherals/peri_keypad.cpp`).

## pgm2epd.py, screenshot.ns - a Newton screen for the panel

    SHOT=tmp/tdeck/screen.pgm build/host/host/newton --display 240x320x1 --erase \
        --store tmp/tdeck/screen.store --headless 40 --script tools/tdeck/screenshot.ns
    python tools/tdeck/pgm2epd.py tmp/tdeck/screen.pgm tools/tdeck/spike/src/newton_screen.c

`screenshot.ns` photographs the desktop newton six seconds after boot into
the file `SHOT` names; `pgm2epd.py` packs a 240x320 PGM into the panel's
format (one bit a pixel, a set bit white, rows top to bottom, each byte's
top bit leftmost) as a C array.  `newton_screen.c` is generated - remake
it, don't edit it.

## serialcapture.py - what the board prints

    ~/.platformio/penv/Scripts/python tools/tdeck/serialcapture.py <port> <seconds> \
        [--out tmp/tdeck/serial.log] [--until TEXT] [--reset]

`pio device monitor` is interactive; this captures for a while (until a
line holding TEXT), echoing and writing to a file, reopening the port when
the board resets; `--reset` resets the board first through the USB
serial/JTAG port's RTS line, so the capture starts at boot.

## xtensa_compile.py - the tree with the ESP32-S3's compiler

    cmake -S src -B tmp/build-arm -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...   # (src/cmake/zig-arm-linux.cmake)
    python tools/tdeck/xtensa_compile.py tmp/build-arm/compile_commands.json [--only DIR,...] [--jobs N] [--opt -Os]

Every file of a 32-bit CMake build (tests left out) compiled again with
ESP-IDF's GCC for the ESP32-S3 (PlatformIO's `toolchain-xtensa-esp32s3`),
keeping the build's `-I`, `-D` and `-include` and adding the flags the tree
needs (C++17 with exceptions, `-fwrapv`, `-fsigned-char`,
`-falign-functions=4`) and ESP-IDF's (`-mlongcalls`, function and data
sections).  Nothing is linked.  **Output**: `tmp/tdeck/xtensa/report.txt`
- how many files compiled, by area; the failures grouped by their first
error (a missing header by its name); the compiled code and data by area -
with the objects and each failure's full messages beside it.  About 30 s
for the whole tree.

## devicerun.sh - the walkthroughs on a device's budget

    tools/tdeck/devicerun.sh <newton> [newton's options...]
    # e.g. under WSL 2, the 32-bit build:
    tools/tdeck/devicerun.sh tmp/build-x86/host/newton --objects build/host/romsrc-objects.bin         --kernel-heap 2 --heap 524288 --flash-size 4 --task-stack 32

Runs both user walkthroughs (`src/host/demo/walkthrough.ns`,
`walkthrough2.ns`), each on a new store and then on that store again (the
restart checks), with the options given and `NEWTON_MEMORY_REPORT` set;
prints for each its result, the memory report (the kernel heap's peak and
what the ROM's objects hold) and the peak resident set (GNU time).  Each
run's whole output is `tmp/devicerun-<n>.log`.  Linux only.
`--kernel-heap` and `--task-stack` are newton's (src/host/newton.cpp).

