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
