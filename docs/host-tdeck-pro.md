# A LilyGO T-Deck Pro host: what it would take

*An investigation (2026-10-10, branch `tdeck-pro-investigation`). Nothing
here runs on the device yet; what is measured was measured on the
development machine, and says so.*

The question: the MessagePad 2x00 ran this OS in a few megabytes, so could
the reconstruction run on a small device like the
[LilyGO T-Deck Pro](https://lilygo.cc/products/t-deck-pro) - an ESP32-S3
with an e-paper screen, a keyboard and a touch panel?

**The short answer: the memory fits, the code fits, and the code is
correct at 32 bits** - both user walkthroughs pass on a 32-bit `-Os` build,
with a 1 MB NewtonScript heap and task stacks no deeper than 24 KB, once
one alignment assumption was made explicit (below).
What stands in the way is not size but three pieces of work and one
question of fit:

1. **The ROM's objects must run from flash.** Today the 5 MB object file
   is read into RAM and a second, converted copy is made of it; on the
   device that alone would use the PSRAM. It needs to be baked on the
   development machine into the device's own layout and mapped from flash
   read-only.
2. **The stores must be flash partitions**, not a whole flash image held
   in RAM.
3. **A FreeRTOS task runtime** in place of one host thread per Newton
   task, plus drivers for the panel, the touch screen and the keyboard.
4. **The screen is smaller than any the OS 2.x applications were laid out
   for** (240x320 against 320x480), one bit deep, and touched with a
   finger. The OS boots and draws at that size; its applications are a
   different matter.

## The machines

| | MessagePad 2100 | T-Deck Pro |
|---|---|---|
| Processor | StrongARM SA-110, 162 MHz, 16 KB I + 16 KB D cache | ESP32-S3: two Xtensa LX7 cores, 240 MHz |
| Working memory | 4 MB DRAM (`hal/host/System.cpp` `GetRamSize`) | ~512 KB internal SRAM + 8 MB octal PSRAM |
| ROM | 8 MB mask ROM | - |
| Flash | 4 MB (the internal store, `hal/host/HostFlash.h`) | 16 MB, code and data both mapped through the cache |
| Card | PC Card slots | microSD |
| Screen | 320x480, 16 grays, backlit LCD | 240x320 e-paper (Good Display GDEQ031T10, UC8253 over SPI), 1 bit |
| Input | resistive pen; optional keyboard | capacitive touch (CST328, finger); keyboard (TCA8418) |
| Sound | speaker, microphone | variant: I2S DAC, mic, speaker (the other variant has a 4G modem instead) |
| Radios | IrDA | Wi-Fi, BLE, LoRa (SX1262), GPS; 4G on one variant |

The device facts are from LilyGO's product page and its
[T-Deck-Pro repository](https://github.com/Xinyuan-LilyGO/T-Deck-Pro)
(pins, ICs, board revisions V1.0/V1.1/MAX, which need different
firmware). Not confirmed there: the panel's refresh times (a reseller
gives about 3 s full, 0.5 s partial) and whether it can show grays; the
ESP32-S3 maps flash and PSRAM through one 32 MB window, which the 8 MB
PSRAM and a mapped part of flash share (ESP-IDF's external-RAM guide).

The MessagePad's "8 MB of RAM" is really 4 MB of DRAM and a 4 MB flash
store; the T-Deck Pro's 8 MB PSRAM is the DRAM's counterpart, with the
store going into its own 16 MB flash (or the microSD card).

## What the reconstruction needs (measured on the development machine)

### Code: 4 to 5 MB - fits

`newton` built for 32-bit ARM Linux at `-Os` (`src/cmake/zig-arm-linux.cmake`,
`-DCMAKE_BUILD_TYPE=MinSizeRel`, stripped; `tools/host/codesize.py <build>`
reads it): **4.7 MB** (4,956,276 bytes), of which 3.6 MB code, 0.66 MB
read-only data, 0.5 MB exception tables, 13 KB initialised data and 280 KB
zeroed data.
Xtensa code is usually denser than ARM's 32-bit instructions, so the
device's should be no bigger. Before the linker drops what is unused, the
libraries come to 4.0 MB, the largest being handwriting recognition
(1.0 MB, mostly the recogniser's network weights), the views (0.55 MB),
NewtonScript (0.43 MB), the stores (0.22 MB) and the ARM interpreter for
packages' native code (0.18 MB).

(The 27 MB `newton.exe` of the usual Windows build is unoptimised and
carries debug information; it says nothing about a device build.)

### Working memory: about 1.5 MB at rest, plus the ROM data

A headless boot on Windows has a working set of about 100 MB, but almost
none of that is the Newton's:

- **The kernel heap** is a 32 MB allocation (`memory/host/KernelHeap.cpp`
  `kHostKernelHeapSize`). A heap walk after a boot (NEWTON_HEAPCHECK with
  NEWTON_HEAPDUMP, totalled) finds **5.24 MB** reached, **4 MB of it the
  NewtonScript object heap** (`--heap`, default 4 MB), and that object heap
  has **4,073,144 bytes free** after the boot (`Stats()`) - about 120 KB
  used. Everything else the kernel and the services allocate comes to
  about 1.2 MB.
- **The flash store** is held whole in RAM (`hal/host/HostFlash.cpp`, a
  `std::vector` the size of the flash - 64 MB by default). On the device
  it would be a flash partition read through the cache and written with
  the flash driver.
- **The ROM's objects**: `romsrc-objects.bin` (5.1 MB) is read whole into
  RAM and kept (`frames/ROMImport.cpp`), and a converted copy - host byte
  order, every reference turned into a host address, an index of the
  46,538 objects - is made beside it (`frames/ObjectAreaImport.cpp`). The
  objects are never written once imported (`kObjReadOnly`; `LockRef` and
  `DirtyObject` pass them by), so a copy baked on the development machine
  in the device's layout could be mapped from flash and used in place.
  The file itself is the same on every host (`docs/host-remarkable.md`).
- **Task stacks**: one host thread per Newton task, 8 MB reserved each on
  Linux; the walkthroughs peak at 21 threads, and at `-Os` none goes
  deeper than 24 KB (below).

So a device budget of roughly: 1-2 MB object heap, 1.5-2 MB for the rest
of the kernel heap, under 1 MB of task stacks, the screen (240x320 at one bit is
9.6 KB; the driver's own copy and QuickDraw's map a few tens of KB), all
in PSRAM, with the ROM objects (about 3 MB baked) and the code in flash -
leaves most of the 8 MB PSRAM spare.

### Correct at 32 bits: yes, with one fix

Nothing in the tree had been built for a 32-bit target before. Built for
32-bit ARM and for 32-bit x86 (`src/cmake/zig-x86-linux.cmake`, which WSL 2
runs - `--objects build/host/romsrc-objects.bin`, the object file being
the same on every host), the whole tree
compiles but for one call (`recognition/Areas.cpp`: `nil` passed for an
integer, an error where `nil` is `nullptr` - fixed). Then:

- **zig places a 32-bit program at 0x10000**, so every host function falls
  below `kROMCodeLimit` (0x02000000, `frames/NativeFunctions.h`) and is
  taken for a ROM address - the reMarkable's trap (`docs/host-remarkable.md`,
  PIE). Linked at 0x08000000 the 32-bit debug build boots, and **the first
  user walkthrough (`src/host/demo/walkthrough.ns`) passes, 0 failed**.
  On the ESP32-S3 code lives at 0x42000000 and up, so the device is not
  affected.
- **A 32-bit `-Os` build crashed at once**, jumping into its own heap from
  `ObjectDestroy` → `TObjectTable::Remove` → `CallDestructor`. The ROM
  clears the low two bits of a destructor's address before calling it
  (`bic #3`; `os600/kernel/ObjectTable.cpp`, `DoubleQ.cpp`), and a
  native's function pointer sits in a NewtonScript array slot as a raw Ref
  whose low bits are its tag (`frames/Interpreter.cpp` `MakeCFunction`):
  both assume code addresses are multiples of four, as the ARM's are. x86
  at `-O0`, `-O2` and `-O3` aligns functions to 16; at `-Os` it does not
  align them at all. **Every build now asks for four-byte alignment**
  (`-falign-functions=4`, `src/CMakeLists.txt`); Xtensa aligns function
  entries to four anyway. A Thumb build could never keep this (bit 0 of a
  Thumb function pointer is set): build ARM code.

What the crash took to find is now in the tools: the crash handler names
the faulting instruction on 32-bit x86 and ARM Linux as well as 64-bit,
and when a fault is a jump to somewhere outside the program - where the
unwinder stops - it prints the words on the stack that point into the
program, the return addresses (`host/newton.cpp`); `tools/host/whichfunction.py`
reads 32-bit ELF images and programs that are not position-independent.

With four-byte alignment the 32-bit `-Os` build (`i386-linux-gnu`, zig,
run under WSL 2) passes **both user walkthroughs and their restarts, 0
failed**, and the first again with the NewtonScript heap cut to 1 MB
(`--heap 1048576`).

### Task stacks: tens of kilobytes

Each task's stack on Linux is its own mapping, so the pages a run touches
show how deep it went (`tools/host/stackdepth.sh <newton> <arguments>`
samples `/proc/<pid>/smaps` each second through a run). Built at `-Os`, 32-bit: **the deepest of the 16-17 task
stacks reached 24 KB, most 8 KB, 156-180 KB in all**, with at most 21
threads. (Unoptimised, every stack reached 260-300 KB: an `-O0` build's
frames are no guide.) So 32 KB stacks with a guard, measured again on the
device, rather than the 8 MB a Linux thread reserves.

### The screen: the OS fits, its applications may not

Booted at 240x320 (`--display 240x320x4`, and `x1`), the OS comes up and
draws: the button bar, the alerts, Setup's Welcome page. But the first
thing it shows is Setup refusing the portrait screen ("This cannot operate
in this orientation. Should the screen be rotated before opening?"), and
rotated it refuses again ("The backdrop icon, Setup, cannot operate while
rotated"). The OS 2.x applications were made for 320x480 and the eMate's
480x320; 240x320 is smaller than both in both directions, and each
application decides for itself what it will open at (`GetAppParams` here:
240 wide, 274 high above the button bar). At one bit, the button bar's
gray turns to a black dither and its labels are lost.

Three ways on, not exclusive:

- **Run the applications at the size they ask for and fix what does not
  fit**, one by one, as host-side layout (each a DEVIATION). The most work,
  and the best result on the panel.
- **Draw a 320x480 Newton and scale it to 240x320** (three quarters) for
  the panel. Everything fits at once, but espy 9 becomes about 7 pixels
  high, which one bit does not render legibly.
- **A larger e-paper device** for the same work (the reMarkable host shows
  the e-ink side is solved).

Whichever is chosen, the e-paper lessons of the reMarkable host carry
over: redraw only what changed, a fast waveform for ink and typing and a
clean full refresh now and then (`docs/host-remarkable.md`, "Lag and
full-screen redraws", "Only what changed"). And grays become a dither (or
the panel's gray modes, if it has them).

### Input

- **Touch is a finger, not a pen.** Taps and drags work as a pen's do, but
  a finger cannot write: the handwriting recogniser (a quarter of the code)
  is of little use, and ink notes are coarse. With the keyboard it makes
  sense to leave recognition out of a device build, or keep it for drawn
  shapes only.
- **The keyboard** is a TCA8418 matrix: its key events map to the Newton's
  keyboard codes as the host's keyboard does (`host/HostKeyboard.cpp`).

## What a port would be made of

An ESP-IDF application (not Arduino: the tree's CMake builds as
components), C++17 with exceptions (`TTaskRedirect` and a few re-expressions
use real ones; `hasCppExceptions`), `-fwrapv`, `-fsigned-char`,
`-falign-functions=4`.

| Seam | Today | On the device |
|---|---|---|
| Task runtime (`os600/kernel/host/TaskRuntime.cpp`) | a host thread per task, a baton on `std::mutex`/`condition_variable` | a FreeRTOS task per Newton task, all on one core, the baton a semaphore; stacks in PSRAM |
| Timers (`hal/host/Timer.cpp`, `HostFIQTimer.cpp`) | `std::chrono`, waitable timers | `esp_timer` |
| ROM objects (`frames/ROMImport.cpp`, `ObjectAreaImport.cpp`) | read and converted into RAM | a baked image in a flash partition, mapped read-only |
| Flash store (`hal/host/HostFlash.cpp`) | the whole flash in RAM | a 4 MB flash partition, mapped for reading, written and erased through `esp_partition` |
| Cards (`hal/host/HostCard.cpp`) | image files | files on the microSD card |
| Screen (`hal/host/HostScreen.h`, a `host/HostWindow.h`) | a window, or the reMarkable's panel | the UC8253 over SPI, partial refresh of what changed |
| Pen (`hal/host/HostTablet.h`) | mouse, the reMarkable's Marker | the CST328 |
| Keyboard (`host/HostKeyboard.cpp`) | the window's keys | the TCA8418 |
| Network (`hal/host/HostSockets.cpp`) | BSD sockets | lwIP's BSD sockets over Wi-Fi - most of it as it is |
| Sound (`hal/host/HostSoundDriver.h`) | waveOut, ALSA | none, or I2S on the audio variant |
| Files, `getenv`, restart | 25 files open files, 54 read the environment | the SD card or nothing; options compiled in |

Left out of a first device build: printing, fax and the modem, the NIE,
the ARM interpreter for packages' native code, the host's own fonts - none
can be left out by a CMake option today (the libraries reach each other by
design); each needs a stub.

## Order of work

The owner already has a T-Deck Pro (bought for another project), so the
device's unknowns can be measured on it early rather than argued about:
a **device spike** - a small ESP-IDF program, not the OS - comes first,
as the reMarkable work began with one (`docs/host-remarkable.md`, "What
the spike showed"). It should answer:

- **the board revision** (V1.0, V1.1 or MAX: the I2C scan LilyGO's own
  firmware does - DRV2605 at 0x5A, XL9555 at 0x20), which decides the pins;
- **the panel**: full and partial refresh times over SPI as actually
  driven, whether the UC8253 can show any grays, and how a 240x320 one-bit
  frame looks;
- **the touch panel**: how fine and how steady a finger's position is at
  the CST328's report rate - whether taps on the Newton's small targets
  (a checkbox, a scroll arrow) are possible;
- **the memory**: PSRAM and flash-mapped read speed through the cache
  for a pointer-chasing walk over a few megabytes (the interpreter's
  pattern), against internal SRAM;
- **the toolchain**: ESP-IDF's Xtensa compiler on a sample of the tree
  (C++17, exceptions, `-fwrapv`, `-falign-functions=4`) and the code size
  it gives.

Then:

1. **32 bits as a supported host** (done here, enough to boot and walk
   through): keep a 32-bit build in the tests so it stays correct (a
   `ZIG_TARGET=x86-linux-gnu` build run under WSL or a Linux CI runner).
2. **A device-sized desktop run**: heap sizes as the device's (a 1 MB
   object heap already works), a 4 MB store, 32 KB task stacks, the ROM
   objects mapped read-only from a baked file - all on the desktop, where
   the tools are, measured.
3. **The baked object image**: `romsrc` → the device's layout (little-
   endian, 32-bit, references resolved to the address it will be mapped
   at), with a tool and a test, as every generated thing here has.
4. **An ESP-IDF skeleton**: the task runtime, timers and the store on
   FreeRTOS; boot to the NewtonScript prompt over the USB serial port, no
   screen.
5. **The panel, the touch screen, the keyboard.**
6. **The applications at 240x320** (or the scaled screen) - the part
   whose size is least known.

## Risks

- **The screen** (above): the largest unknown is how many of the built-in
  applications can be made to fit.
- **E-paper speed**: half a second a partial refresh suits reading and
  typing, not scrolling or ink.
- **Caches**: the ROM's objects and the code both reach the processor
  through the ESP32-S3's cache (32 or 64 KB), shared with the PSRAM; the
  interpreter walks objects all over 3 MB of them. The StrongARM had a
  16 KB data cache too; how the two compare only a measurement on the
  device will say.
- **Board revisions**: LilyGO's V1.0, V1.1 and MAX need different firmware.
