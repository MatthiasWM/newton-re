# tools/mesh - the LoRa mesh's desktop tools

The hosts' mesh node is `src/hal/host/HostMesh.h` (MeshCore;
`docs/host-tdeck-pro-mesh.md`).  On a desktop its radio is a pretend one
whose air is a UDP multicast group (`newton --mesh-air lan[:port]`).

## meshpeer - a node to talk to

Built with the tree (`build/host/hal/meshpeer`, from
`src/hal/host/MeshPeer.cpp`):

    meshpeer [--air lan[:port]] [--name NAME] [--state PREFIX] [--echo]
             [--channel TEXT] [--send-to NAME --text TEXT] [--until TEXT] [--seconds N]

It announces itself, prints a line for each thing that happens
(`meshpeer: up <id> as <name>`, `heard <name>`, `from <name>: <text>`,
`channel <channel> <name>: <text>`, `sent <state>`), and answers as it is
told: `--echo` answers each message to it with "echo: <text>",
`--channel` says TEXT on the Public channel once it has heard a node,
`--send-to` sends TEXT to the node of that name once heard.  `--until`
stops it (exit 0) once a message holding TEXT comes and its own send is
settled; `--seconds` (60; 0 never) stops it with exit 1.  `--state` keeps
its identity and contacts in files beside PREFIX (none: a new node each
run).

By hand, a newton and a peer to talk to:

    build/host/hal/meshpeer --air lan --name Ada --echo --seconds 0
    build/host/host/newton --mesh-air lan --store my.store

## meshpresets.py - the radio's presets

    python tools/mesh/meshpresets.py [--fetch] [--json FILE] [-o FILE]

Makes `src/hal/host/HostMeshPresets.inc`, the engine's table of radio
presets, from `tools/mesh/meshcore-presets.json`: MeshCore's
community-suggested radio settings, the list its own apps offer, published
at https://api.meshcore.nz/api/v1/config (`suggested_radio_settings`).
`--fetch` refreshes the kept copy from that URL first (and records when).
One `{name, MHz, kHz, SF, CR, path hash size}` per preset, in the list's
order; a preset without `network_settings` gets a path hash size of 1,
MeshCore's default.  Regenerate after a fetch; never edit the `.inc`.
Standard library only.

## meshrun.py - nodes run together

    python tools/mesh/meshrun.py [--seconds N] [--port P]
        [--peer "<command and arguments>"]... -- <main command and arguments>

Starts the peers, then the main command, every `{port}` in their arguments
the same UDP port, chosen afresh each run (so runs side by side do not
hear each other); prints every line they print, prefixed with which
printed it; stops the peers when the main command ends and exits with its
status (1 past `--seconds`, 300).  The ctests `hal.MeshPeers` and
`host.NewtonMesh.<size>` are run with it (`src/hal/tests/CMakeLists.txt`,
`src/host/CMakeLists.txt`).  Standard library only.

## meshdecode.py - a packet taken apart

    python tools/mesh/meshdecode.py HEX [--channel "#name" | --secret KEY]...

Takes a MeshCore packet as the radio gave it - `HostMeshLastUnreadable()` on
a newton with a mesh node keeps the last channel packet no channel of its
could decrypt - and prints its header (version, route, type), transport
codes, path (each repeater's hash) and payload.  For a channel message it
shows the channel hash and, for the Public channel and each `--channel`
(a hashtag channel: SHA-256 of its name) or `--secret` (hex or base64),
the hash and MAC each makes; the one that matches is decrypted (timestamp,
flags, text).  When none matches it tries the ciphertext cut short and with
a byte left out at each place, to tell a packet damaged on its way from the
radio from one on a channel this node is not in.  MeshCore 1.10's layout
and cryptography (HMAC-SHA256, AES-128-ECB written out here); standard
library only.  Checked against FIPS-197's AES vector and against a
desktop newton's capture of a meshpeer's `#newton-test` message.
