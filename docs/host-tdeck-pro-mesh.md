# The T-Deck Pro on a LoRa mesh: MeshCore

*Begun 2026-10-13, branch `tdeck-meshcore`, at the owner's request: the
board's SX1262 LoRa radio as a [MeshCore](https://github.com/meshcore-dev/MeshCore)
chat node, with a Newton application that works as Messages does, and a
Host preferences setting to power the radio down as the 4G module can be.
The owner's earlier firmware for the same board, lilyphone1, was a MeshCore
node (`src/apps/mesh_net.cpp`, its companion protocol `mesh_companion.cpp`);
it is where the radio's set-up, the presets and the node's rules come
from.*

DEVIATION (host addition): the ROM has no mesh.

## The pieces

As the 4G module's (`docs/host-tdeck-pro-phone.md`), in five layers:

| Layer | File | What |
|---|---|---|
| The protocol | `src/thirdparty/meshcore/` | MeshCore 1.10.0, rweather's Crypto, orlp's ed25519, base64 and RadioLib's SX126x driver, vendored from lilyphone1 with their licences, trimmed (its `README.md` says what was left out and why); `compat/` stands in for the little of Arduino they include |
| The engine | `src/hal/host/HostMesh.h`, `HostMesh.cpp` (library `hal_host_mesh`) | a MeshCore `BaseChatMesh` node on its own thread, behind a plain interface: status, contacts, messages received, sends, adverts, the name, the radio presets, the power switch; no Newton headers |
| A desktop's radio | `src/hal/host/HostMeshAir.cpp`, `newton --mesh-air lan[:port]` | packets as UDP multicast datagrams (239.255.78.121, port 3685 by default): desktop newtons and `meshpeer` on one air mesh with each other |
| The natives | `src/host/HostMeshNatives.cpp` | `HostMesh*` (the list is `HostMesh.h`'s header) |
| The application | `src/comms/host/HostMesh.ns`, started by `comms/host/HostMeshApp.cpp` | Mesh, in the Extras drawer |
| The board | `src/host/esp32/main/tdeck_lora.cpp` | the SX1262 through RadioLib on a HAL of the board's own, the engine's task, NVS, the power switch |

`meshpeer` (`src/hal/host/MeshPeer.cpp`) is a node on the pretend air for
the application and the tests to talk to; `tools/mesh/meshrun.py` runs
nodes together on one air (`tools/mesh/README.md`).

## The node

Ported from lilyphone1's `mesh_net.cpp`, kept: the node does not forward
(a phone in a pocket is a poor repeater); MeshCore adds every node it hears
announce itself as a contact; a flood's acknowledgement is waited for
12 s + 12 airtimes, a direct one's 6 s + 2 airtimes a hop; the Public
channel (the key every MeshCore node has, `izOH6cXN6mrJ5e26oRXNcg==`); an
advert ten minutes apart, and one after starting, retuning or the radio
coming back on.

**The radio's settings are values** - frequency, bandwidth, spreading
factor, coding rate, power, and the mesh's path hash size (bytes of each
hop's hash in a flood's path, 1-3: MeshCore's network setting, used for
every flood this node sends) - kept by the engine (`KeptSettings` version
2) and changeable to anything the radio takes (`HostMeshSetRadio`:
150-960 MHz, a LoRa bandwidth, SF 5-12, CR 4/5-4/8, -9 to 22 dBm).  **The
presets only fill them in**: MeshCore's community-suggested settings, the
list its own apps offer, from https://api.meshcore.nz/api/v1/config
(`suggested_radio_settings`), kept in `tools/mesh/meshcore-presets.json`
and made into `src/hal/host/HostMeshPresets.inc` by
`tools/mesh/meshpresets.py` (`--fetch` to refresh; 26 presets on
2026-10-13).  The default is **Australia (Narrow)**: 916.575 MHz, 62.5
kHz, SF 7, CR 4/7.  The status names the preset the settings match, or
says "Custom".  Version 1 of the kept settings named one of lilyphone1's
four presets by index: its "Victoria AU" becomes the community's Australia
(Narrow) (CR 4/7 where lilyphone1 had 4/8 - the coding rate travels in
each packet's header, so either hears the other), the others keep their
values exactly.

The radio is set up as lilyphone1's build flags have it: the private sync
word (0x12), the TCXO on DIO3 at 1.8 V, a 140 mA current limit, the DC-DC
regulator, 22 dBm, a 32-symbol preamble at SF 7 (MeshCore's wrapper's
`setParams`).  MeshCore's own tuning is left at its defaults, which are
what lilyphone1 set (airtime budget 1.0, receive delay base 10, no extra
acknowledgements).  Checked against lilyphone1's source, 2026-10-13, at
the owner's asking.

Changed from lilyphone1 (each a thing its source shows):

- **The clock.** lilyphone1's `VolatileRTCClock` was never ticked, so the
  mesh's time stood still between its 30-second re-syncs; the engine's
  clock is the host's whenever the host knows the time (after 2023), and
  counts on from the last time it was told otherwise.
- **Several sends at once**, each with its own acknowledgement and
  timeout (lilyphone1 had one in flight), tried up to three times, the
  last by flood (the route may have gone).  `onSendTimeout`, which
  `BaseChatMesh` calls for the last message only, is not used.
- **Contacts kept** across a restart (lilyphone1 kept them in RAM): the
  newest 32, without their routes (learnt again: the first message
  floods), written only when the list changes - who is in it, by what
  name - not each time a node announces itself again.  A board's NVS
  partition is 24 KB.
- **The radio put to sleep** before its power is cut, its interrupt let go
  (lilyphone1 cut the power to a radio still listening).
- **Only the engine's thread touches MeshCore** (lilyphone1's UI task
  called `advert_send` and wrote SPIFFS itself).
- Not kept: the UI's tables, GPS position in adverts, the BLE companion
  (no internal RAM to spare: ~31 KB free with the OS up).

A desktop's node keeps its identity, settings and contacts beside the
store (`<store>.mesh-identity`, `-settings`, `-contacts`; `--erase`
forgets them); the board's in NVS, namespace `mesh`.

## The application

`comms/host/HostMesh.ns`: Messages' design (`docs/host-tdeck-pro-phone.md`,
"Messages") over the mesh's natives rather than a transport -

- conversations: one per node, and the **Public channel**, always first;
  the folder tab's picker lists them; the list's foot says who this node
  is (name, id, preset) or that the radio is off;
- **New** picks from the nodes heard (`HostMeshContacts`), not the Names
  file - a mesh node has a key, not a number; **Announce** sends this
  node's advert; **Say** and **Send** below a conversation: the Say line
  wraps and grows with what is written (up to half the conversation's
  height; the ROM's `protoLabelInputLine` is one line only, so its entry
  loses `vjOneLineOnly`, and its `textChanged` lays the application out
  again when the line count changes), Send empties it and does nothing
  when it holds nothing but spaces (`StrFilled` is only "not empty", as
  the ROM's is);
- **an entry line is emptied with `Clone("")`, never a literal `""`**:
  typing changes the line's string in place, so a literal set once
  becomes the next message typed, and the next `SetValue` with it changes
  nothing (the first send emptied the line, the later ones did not;
  Messages and the Wi-Fi password line had the same);
- a message sent is *Sending*, then *Sent* (a channel's: on the air),
  *Delivered* (acknowledged) or *Not sent*; on a channel each bubble says
  who said it;
- the frame `HostMesh:host` polls `HostMeshNextMessage` every 2 s whether
  the application is open or not, and keeps the messages in the soup
  `Mesh:host` (`{class: '|meshMessage:host|, thread, name, sender, text,
  time, dir, state, sendId}`; a thread is a node's key or `"public"`);
  closed, a message is told with an alert; open, with a beep;
- the node is named after the owner (Setup's name) the first time.
- **deleting**: a message tapped in the conversation is selected (drawn
  inverted); the status bar's **Delete** removes it, or - nothing selected
  - asks (`AsyncConfirm`) and removes the whole conversation (the Public
  channel stays listed, empty);
- a message that cannot be filed is told on the console and the poll goes
  on (a throw out of `Poll` used to end the polling until a restart).

**A message heard by another node but not by this one** is most likely a
collision: the radio is half-duplex, and a channel message is neither
acknowledged nor sent again.  A long one is on the air for most of a
second at SF7/62.5 kHz/CR 4/8, so a message sent at the same moment can
deafen this node to it (MeshCore listens before it talks, which helps
only when the other's preamble has already begun).  Found 2026-10-13:
the board's counters (`HostMeshStatus()`'s `received`, `sent`) matched
the soup exactly - the message never reached the engine.

Laid out for any screen as Messages is (ctests at 240x320, 320x480,
480x320, 810x1080).

**Only where there is a radio** (the owner's ask, 2026-10-13): the
application is built only when the host has a mesh node - the T-Deck Pro,
or a desktop started with `--mesh-air` - and a newton started without one
on a store that had it takes its Extras icon out again
(`comms/host/HostAppIcon.h`); Messages does the same without a cellular
module (`--cell-port`).  A reMarkable has neither.  ctests
`host.NewtonMesh.unplugged`, `host.NewtonMessages.unplugged`.

## Settings

In the Mesh application, as other Newton applications have them: the
**i** button in its status bar (`protoInfoButton`, @478), whose only item
is **Prefs** (the application's `DoInfoPrefs`), opens the Mesh
Preferences slip:

- **Keep** - how long messages are kept: a day, a week (the default), a
  month, a year, or always; never more than 1000 in all, the oldest going
  first, and never one still sending.  Pruned at the start, at most hourly
  after, and at once when Keep is changed (the owner's ask, 2026-10-14: a
  busy mesh says a lot);
- **Name** - this node's name on the mesh (taken, and announced, when the
  slip closes);
- **Preset** - fills in the settings below it; shows which preset they
  are, or "Custom";
- **Frequency** (MHz, typed), **Bandwidth**, **Spreading**, **Coding**,
  **Power** (dBm, typed), **Path hash** - the settings themselves, taken
  when the slip closes (settings the radio cannot take are told, and left
  as they were);
- **The radio on** - where the board can switch it (GPIO 46, kept in NVS
  as `loraOff`), at once.

They were Host preferences (`loraPower`, `meshRegion`) until 2026-10-13;
the owner wanted them in the application.

## The board

`tdeck_lora.cpp`.  The pins are lilyphone1's: chip select GPIO 3, reset 4,
DIO1 5, BUSY 6, power 46; the bus the panel shares (SCK 36, MOSI 33, MISO
47), now started once in `app_main` (`HostDeviceSpiBusStart`,
`tdeck_panel.cpp`) with every chip select parked high before either adds
its device.

- **RadioLib's HAL** is the board's own (RadioLib has none for the S3; its
  ESP-IDF example drives the original ESP32's registers): GPIO, the GPIO
  interrupt service, `esp_timer`, and the SPI master - the chip select a
  GPIO RadioLib drives, each exchange taking the bus
  (`spi_device_acquire_bus`) so the panel's transfers wait, the bytes
  through 256-byte buffers in internal RAM.  `Module::init` calls the
  HAL's `init`, not `spiBegin`: the device is added there.
- **Tasks**: the engine's on core 0 with a 12 KB PSRAM stack; a "keeper"
  with an internal stack does its NVS reads and writes and the power
  switch (a task with a PSRAM stack must not touch the flash).
- **The build**: MeshCore, RadioLib and the engine are left out of
  `newton_sources.cmake` (`tools/tdeck/idf_sources.py`) and listed in
  `main/CMakeLists.txt` with their `-I` paths and definitions (MeshCore's
  contact and channel counts and RadioLib's `GODMODE`/`STATIC_ONLY` change
  class layouts, so every file of them has the same), each compiled
  through a forwarding file of its own name - PlatformIO names an object
  by its file name, and ed25519's `sha512.c` met Crypto's `SHA512.cpp`.
  The firmware grew by ~180 KB (4.85 of 6 MB).

On the owner's board, 2026-10-13: the node starts with the OS ("[mesh] up
as ..."), is named after the owner, its first advert goes out
(`packetsSent`), the radio switches off and on again from the setting, and
after the advert that follows a first packet was heard.

## Tests

- `hal.MeshPeers`: two `meshpeer`s on one air - one hears the other,
  sends, is acknowledged and gets the echo back (the first copy can come
  before the other has heard this one's advert, and is then answered on
  the retry: ~17 s).
- `host.NewtonMesh.<size>`: `src/host/demo/mesh.ns` against a `meshpeer`
  "Ada" - her channel hello filed under Public, a conversation begun from
  New, delivered and echoed; on Public, Send with only spaces doing
  nothing, the Say line growing and emptied by Send (typed text too); a
  message to the Public channel, the Host
  setting's presets; snapshots `mesh-<w>x<h>-<n>.pgm`.

## Not yet

- `host.NewtonMesh.810x1080` failed once in a full `ctest -j 8` run (the
  peer received the message and both retries, but neither its
  acknowledgements nor its echoes reached newton; the channel message
  after did); it passes alone and four at a time.  Not yet understood.

- A message exchanged with another real node on the board.
- The WiFi companion (MeshCore's companion protocol on TCP port 5000, the
  frames lilyphone1's `mesh_companion.cpp` speaks), so the MeshCore phone
  apps can drive the node.
- Channels other than Public; renaming the node from the application;
  removing a contact; scroll arrows (as Messages).
