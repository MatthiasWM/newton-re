# MeshCore and the libraries it needs (vendored)

The hosts' LoRa mesh node (`src/hal/host/HostMesh.h`) is
[MeshCore](https://github.com/meshcore-dev/MeshCore)'s chat node. These
are third-party libraries, each under its own licence (the file beside it),
copied on 2026-10-13 from the owner's earlier firmware for the T-Deck Pro,
lilyphone1 (`lib/`), which had already trimmed them to what MeshCore uses:

| Directory | What | Version | Licence |
|---|---|---|---|
| `MeshCore/` | the mesh protocol: dispatcher, packets, identities, the chat node (`helpers/BaseChatMesh`), the SX1262 wrapper (`helpers/radiolib/`) | 1.10.0 | MIT (`LICENSE.txt`, from upstream) |
| `Crypto/` | rweather's arduinolibs Crypto: AES, SHA-256/512, Ed25519 verification, Curve25519 | 0.4.0 | MIT (`LICENSE.txt`) |
| `ed25519/` | orlp's Ed25519: keys, signing, key exchange | 1.0.0 | Zlib (`LICENSE.txt`, from upstream) |
| `base64/` | Densaugeo's base64 (a channel's key) | 1.3.0 | MIT (`LICENSE.txt`, from upstream) |
| `RadioLib/` | Jan Gromeš's RadioLib: the SX126x driver, the T-Deck Pro's only | 7.6.0 | MIT (`license.txt`) |

## What was changed

Left out (not used, or Arduino-only):

- MeshCore: the BLE serial interface (`helpers/esp32/SerialBLEInterface.*`),
  `AbstractBridge.h`, the other radios' wrappers (`helpers/radiolib/Custom*`
  but `CustomSX1262*`) and `LR11x0Reset.h`.
- Crypto: `RNG.cpp` (Arduino's EEPROM and noise sources), `NoiseSource`,
  `ChaCha`, `Cipher`.  `RNG.h` stays: `Ed25519.cpp` and `Curve25519.cpp`
  name the `RNG` object in key-generation functions MeshCore does not call,
  so `compat/CryptoRNG.cpp` defines it over the host's random bytes.
- ed25519: `seed.c` (`ED25519_NO_SEED`: the node's RNG makes the seed).
- RadioLib: everything but its core (`Module`, `Hal`, `TypeDef`,
  `BuildOpt*`), `utils/`, `protocols/PhysicalLayer/` and
  `modules/SX126x/` (less `STM32WLx*`); its examples, docs and the
  Arduino/RPi HALs (the board's HAL is `src/host/esp32/main`'s).
  `RadioLib.h` includes only those modules.

Added: `compat/` - a minimal `Arduino.h` (the C library's headers) and
`Stream.h` (the interface `Identity` and `Utils` name), so the sources build
without Arduino on a desktop and under plain ESP-IDF on the board, and
`CryptoRNG.cpp` (above).

## Building

`CMakeLists.txt` here makes the `meshcore` library for the desktops (the
radio-independent part: no RadioLib); the T-Deck Pro's build lists the same
sources and RadioLib's (`src/host/esp32/main/CMakeLists.txt`).
`MAX_CONTACTS=64` and `MAX_GROUP_CHANNELS=4` change `BaseChatMesh`'s layout,
so everything that includes MeshCore's headers is built with them.
