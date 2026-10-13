# GPS: a receiver on a serial port

The MessagePad has no GPS and NewtonOS no location service.  Newton GPS
software talks to a receiver plugged into a serial port - the built-in
one, a PC card's, or the IR port - itself, reading NMEA 0183 sentences
off an asynchronous serial endpoint.  So the host gives the machine a
**receiver at the far end of a serial port** (`hal/host/HostGPS.h`,
`hal/host/HostSerialChip.h`'s `HostSerialChipSetGPS`) - serial port 2
by default, a port of its own, so the external one stays free for
docking - and the applications find it where they would have found a
Garmin on a cable.  The owner's decisions (2026-10-14): the serial
interface only - no PC card GPS, no location API for scripts - and a
second serial port for the receiver, the main one left available.

## What the applications do

The three fixtures (`fixtures/packages/apps/GPS*`), read with
`analysis/pkgns.py --functions/--disasm`:

| application | how it connects | what it reads |
|---|---|---|
| GPS Monitor 2.0b9 (Gerd Staudenmaier) | protoBasicEndpoint, `'aser'` with `'siop'` (the speed, bits, parity from its Prefs - 4800 8N1 by default), `'iflc'`/`'oflc'` flow control and `'schp'` the port its Prefs name (`GetCommPortInfo`, or `ModemLocations` and the cards: "Serial Port" is `'extr'`); connects as it opens, optionally sends an init string | `$GPGGA` with `$GPRMC`, `$GPVTG` or `$GPGLL` (its "Interface Options"), `InputScript`s ending at CR; a native function (NTK) splits the fields |
| GPS Map 2.1 (the same author) | the same endpoint, through its "NMEA 183" driver; other drivers are packages that register with it (`SATNAV.PKG`, the Centennial SatNav PC card's binary protocol; `GPS_SIM2.PKG`, a simulator needing no receiver) | the same sentences, decoded and the map drawn in 38 KB of NTK native code - which runs on `src/armcpu` |
| GPS View 3 (Harry Dodgson) | protoSerialProtocol (the DTS library compiled in, its `hack_*` and `runModemNavigator` BinCFunctions on armcpu) | a DeLorme Tripmate: waits for `ASTRAL`, answers `ASTRAL`, sends `$PRWIILOG` lines (GGA, GSA, GSV, ZCH off, RMC on), waits for a `$GPRMC`, sends `$PRWIINIT` with that RMC's place and the Newton's time, then reads `$GPRMC`s: the tenth field (the date) must be there |

GPS Monitor's track reads `--------` at any speed over 0.1 knot with its
default GGA+VTG sentences: after a VTG its `decode_NMEA` clears the track
when `Abs(Speed) > 0.1`, where after an RMC it does so when `< 0.1` - the
application's own bug, the same on a MessagePad.

## The receiver (`hal/host/HostGPS.h`)

A thread of its own (built as the cellular engine is, without the Newton
include paths), holding what it has said that the port has not yet read
(4 KB, the oldest dropped) and hearing what the Newton sends it a line at
a time.  Its source is `newton --gps SPEC`:

| spec | the receiver |
|---|---|
| `sim[:LAT,LON[,KNOTS]]` | pretend: round a circle of 500 m about the point (Melbourne, 10 knots unless given) |
| `fixed:LAT,LON[,ALT]` | pretend: standing still (moved, and set going, by `HostGPSSetPosition`) |
| `nmea:FILE` | a log replayed, a cycle a second - a cycle begins at the log's first kind of sentence - and round again |
| `tcp:HOST:PORT` | NMEA from a TCP server (a phone's "GPS over network" app; `gpspipe -r` behind `nc -l`) - reconnected every 5 s when it goes |
| `gpsd[:HOST[:PORT]]` | gpsd (127.0.0.1:2947), sent `?WATCH={"enable":true,"nmea":true}`; its JSON lines are left out |
| `serial:DEVICE[@BAUD]` | a receiver plugged into the host (`COM3`, `/dev/ttyUSB0`; 4800 unless given) |

A pretend receiver makes NMEA 0183 version 2.0's sentences, as the
receivers of the day did (a Garmin 12's: whole seconds, minutes of arc
to three places, no mode indicator): `$GPGGA`, `$GPGLL`, `$GPRMC`,
`$GPVTG` each second, `$GPGSA` and two `$GPGSV` (eight satellites) every
fifth - about 250 bytes a second, 600 with the satellites, inside 4800
baud's 480.  The time is the host's clock (UTC).  A real source's
sentences (lines beginning `$` or `!`) are passed on as they come, and
read (GGA, RMC, GLL) for the fix `HostGPSStatus` reports; what the Newton
sends is passed on to a `serial:` or `tcp:` receiver (a Garmin's
`$PGRMO` init string reaches it).

The receiver is an **NMEA** one - sentences all the time, anything sent
to it ignored - or a **DeLorme Tripmate**: `ASTRAL` each second until it
hears `ASTRAL`, then its sentences (GGA, GSA, GSV, RMC unless
`$PRWIILOG,<type>,A|V` says otherwise); `$PRWIIRST` starts it over.  A
real source behind a Tripmate is gated the same way.

## Which port

The ROM knows a second serial port at `'mdem'` (`kHWLocBuiltInModem`):
`ModemLocations` lists it as "Internal Modem", and the docking loader
(`comms/SCPLoader.cpp`) looks for a device there after the external
port.  The host registers a second `THostSerialChip` there for the
receiver, made when it is first plugged in, so it is a port of its own
and the external one (`'extr'`) keeps its TCP listener for docking.
Whether an application can use it depends on whether it asks which port:

| application | Serial Port 2 (`'mdem'`) | how |
|---|---|---|
| GPS Monitor | yes | its "i" > Prefs > Port: "Internal Modem" (ModemLocations' title for it) |
| GPS Map | yes | "i" > Prefs > Interface Settings > Port: "Serial Port 2" - which it adds, as `'mdem'`, on a machine whose root has `Buttons.soft` (the host's has); "Internal Modem" is the same port; its driver restarts when Preferences closes |
| SatNav driver (GPS Map) | offered ("Serial Port 2") | Rockwell binary only, which the receiver does not speak |
| GPS View | **no** | it sends no `'schp'` option, so the serial tool gives it the default chip, the external port; with the receiver on port 2 it waits ("waiting for response") without end |

So GPS View wants the receiver on the external port (the Host panel's
"GPS receiver on: Serial port", or `--gps-port 1`), as a Tripmate.

## On the port

`HostSerialChipSetGPS(location)` - `'mdem'`, `'extr'` or 0 for none -
makes the receiver that port's cable (making the chip if there was none:
port 2 always, the external one with `--serial-port none`): DCD, DSR and
CTS asserted, the receiver's bytes what the serial tool reads (still paced
at the line's speed), what the tool puts sent to the receiver.  On the
external port a desktop connected over TCP is cut off and none is taken
while it is in (HostSerialChipListening then says no).  What the receiver
said while no tool had the port is dropped when one takes it, as at a
UART nobody serviced.  Both chips are one host interrupt source, polled
in turn.  DEVIATION (hardware): the bytes arrive at whatever speed the
tool sets; a real receiver talks at its own and a tool set to another
reads noise.

newton plugs the receiver into serial port 2 when it makes the serial
port (`HostSettingsPlugGPS`; `--gps-port 1` the external port instead),
an NMEA one unless `--gps-kind tripmate`.  The Host preferences panel's
"GPS receiver on" (`gps`: Not plugged in, Serial port 2, Serial port)
and "GPS receiver" (`gpsKind`: NMEA, DeLorme Tripmate) change them while
the machine runs (`docs/host-settings.md`), and are kept: a choice made
there wins over newton's options at the next start.

## For scripts

`HostGPSAvailable()`, `HostGPSStatus()` - `{source, kind, plugged, port, fix,
latitude, longitude, altitude, speed, course, satellites, time,
seconds}`, port `"mdem"` or `"extr"`, time in minutes since 1904 (UTC) - and
`HostGPSSetPosition(lat, lon, alt, knots, course)` for a pretend source
(`host/HostGPSNatives.cpp`).

## Tests

- `hal.GPS` (`src/hal/tests/test_HostGPS.cpp`): the checksums against
  NMEA's own examples, the parsing, the sentences made and read back, the
  specs; a fixed receiver run (nothing heard while unplugged, moved), a
  Tripmate (ASTRAL until answered, `$PRWIILOG` obeyed, `$PRWIIRST`).
- `hal.GPSReplay`: a log replayed a cycle a second, noise left out.
- `host.NewtonAppGPSMonitor`, `host.NewtonAppGPSView`,
  `host.NewtonAppGPSMap` (`src/host/demo/apps-gps*.ns` over
  `gpshelpers.ns`): the receiver on serial port 2 with docking still on;
  GPS Monitor and GPS Map opened from the Extras drawer, waiting for data
  until their own Prefs are set to that port (the pen through the "i"
  button, the Port picker, the slips closed); then, the receiver standing
  in Melbourne, the display checked, the receiver moved to Greenwich and
  set going, the display checked again.  GPS View after the receiver is
  moved to the external port and made a Tripmate through the Host
  panel's settings, and its Connect button tapped.

## Not done

- A host's own location service as a source (Windows.Devices.Geolocation,
  CoreLocation, GeoClue) - `gpsd`, `tcp:` and `serial:` cover a desktop.
- The T-Deck Pro's own receiver (a u-blox MIA-M10Q on a UART): a source
  over the board's UART, as `tdeck_modem.cpp` gives the cellular engine
  its link.
- A GPS PC card (the Centennial SatNav: `SATNAV.PKG` drives one through
  its own card handler, binary protocol) - the owner chose the serial
  port only.
