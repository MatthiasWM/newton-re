#!/usr/bin/env python3
"""A MeshCore packet taken apart, and a channel message decrypted - to see why
a node could not read one (docs/host-tdeck-pro-mesh.md).

    python tools/mesh/meshdecode.py HEX [--channel NAME | --secret KEY]...

HEX is the packet as the radio gave it (HostMeshLastUnreadable() on a newton
with a mesh node).  Each --channel "#name" (a hashtag channel: the first 16
bytes of SHA-256 of its name) or --secret (32 or 64 hex digits, or base64)
is tried on a channel message; the Public channel is always tried.  Prints
the header (version, route, type), the transport codes, the path (each
repeater's hash), and for a channel message (GRP_TXT/GRP_DATA) its channel
hash, the MAC as sent and as each secret makes it, and - when one matches -
the text with its timestamp.  When none matches, it also tries the
ciphertext cut short or with a byte left out at each place, to tell a packet
truncated or corrupted on its way from the radio from one on a channel this
node is not in.

The layout and the cryptography are MeshCore 1.10's (Packet.h,
Dispatcher::tryParsePacket, Utils::MACThenDecrypt: HMAC-SHA256 keyed with
the 32-byte secret, its first 2 bytes the MAC, over the ciphertext; then
AES-128-ECB with the secret's first 16 bytes).  AES is written out here so
that the tool needs nothing beyond Python 3.9.
"""

import argparse
import base64
import hashlib
import hmac
import struct
import sys
import time

PUBLIC = base64.b64decode("izOH6cXN6mrJ5e26oRXNcg==")
TYPES = ["REQ", "RESPONSE", "TXT_MSG", "ACK", "ADVERT", "GRP_TXT", "GRP_DATA", "ANON_REQ",
         "PATH", "TRACE", "MULTIPART", "CONTROL", "type12", "type13", "type14", "RAW_CUSTOM"]
ROUTES = ["TRANSPORT_FLOOD", "FLOOD", "DIRECT", "TRANSPORT_DIRECT"]

# ---------------------------------------------------------------- AES-128

SBOX = [0] * 256
INV = [0] * 256


def _sbox():
    p = q = 1
    while True:
        p = p ^ ((p << 1) & 0xFF) ^ (0x1B if p & 0x80 else 0)
        q ^= q << 1
        q ^= q << 2
        q ^= q << 4
        q &= 0xFF
        if q & 0x80:
            q ^= 0x09
        x = q ^ ((q << 1 | q >> 7) & 0xFF) ^ ((q << 2 | q >> 6) & 0xFF) ^ ((q << 3 | q >> 5) & 0xFF) ^ ((q << 4 | q >> 4) & 0xFF)
        SBOX[p] = x ^ 0x63
        if p == 1:
            break
    SBOX[0] = 0x63
    for i, v in enumerate(SBOX):
        INV[v] = i


_sbox()


def _mul(a, b):
    r = 0
    while b:
        if b & 1:
            r ^= a
        a = ((a << 1) ^ 0x1B) & 0xFF if a & 0x80 else a << 1
        b >>= 1
    return r


def _expand(key):
    w = list(key)
    rcon = 1
    for i in range(16, 176, 4):
        t = w[i - 4:i]
        if i % 16 == 0:
            t = [SBOX[t[1]] ^ rcon, SBOX[t[2]], SBOX[t[3]], SBOX[t[0]]]
            rcon = _mul(rcon, 2)
        w += [w[i - 16 + j] ^ t[j] for j in range(4)]
    return [w[r * 16:(r + 1) * 16] for r in range(11)]


def aes_decrypt_block(keys, block):
    s = [b ^ k for b, k in zip(block, keys[10])]
    for r in range(9, -1, -1):
        s = [s[(i - 4 * (i % 4)) % 16] for i in range(16)]      # inverse ShiftRows
        s = [INV[b] for b in s]
        s = [b ^ k for b, k in zip(s, keys[r])]
        if r:
            n = []
            for c in range(4):
                a = s[4 * c:4 * c + 4]
                n += [_mul(a[0], 14) ^ _mul(a[1], 11) ^ _mul(a[2], 13) ^ _mul(a[3], 9),
                      _mul(a[0], 9) ^ _mul(a[1], 14) ^ _mul(a[2], 11) ^ _mul(a[3], 13),
                      _mul(a[0], 13) ^ _mul(a[1], 9) ^ _mul(a[2], 14) ^ _mul(a[3], 11),
                      _mul(a[0], 11) ^ _mul(a[1], 13) ^ _mul(a[2], 9) ^ _mul(a[3], 14)]
            s = n
    return bytes(s)


def aes_ecb_decrypt(key, data):
    keys = _expand(key[:16])
    return b"".join(aes_decrypt_block(keys, data[i:i + 16]) for i in range(0, len(data) - len(data) % 16, 16))


# ---------------------------------------------------------------- MeshCore


def secret_of(text):
    if text.startswith("#"):
        return hashlib.sha256(text.encode("utf-8")).digest()[:16]
    t = text.strip()
    if len(t) in (32, 64) and all(c in "0123456789abcdefABCDEF" for c in t):
        return bytes.fromhex(t)
    return base64.b64decode(t)


def mac_of(secret, ciphertext):
    return hmac.new(secret.ljust(32, b"\0"), ciphertext, hashlib.sha256).digest()[:2]


def show_plain(plain):
    stamp = struct.unpack("<I", plain[:4])[0]
    flags = plain[4]
    text = plain[5:].split(b"\0", 1)[0].decode("utf-8", "replace")
    when = time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(stamp))
    return f"sent {when} GMT, flags {flags:#04x}: {text!r}"


def main(argv):
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("hex")
    parser.add_argument("--channel", action="append", default=[])
    parser.add_argument("--secret", action="append", default=[])
    args = parser.parse_args(argv)

    raw = bytes.fromhex(args.hex)
    print(f"{len(raw)} bytes")
    if not raw:
        return 1
    header = raw[0]
    version, ptype, route = header >> 6, (header >> 2) & 15, header & 3
    print(f"header {header:#04x}: version {version + 1}, {TYPES[ptype]}, {ROUTES[route]}")
    i = 1
    if route in (0, 3):
        codes = struct.unpack("<HH", raw[i:i + 4])
        print(f"transport codes {codes[0]:#06x} {codes[1]:#06x}")
        i += 4
    path_len = raw[i]
    i += 1
    size, count = (path_len >> 6) + 1, path_len & 63
    path = raw[i:i + size * count]
    i += size * count
    hops = [path[k * size:(k + 1) * size].hex().upper() for k in range(count)]
    print(f"path: {count} hop(s) of {size} byte(s): {' '.join(hops) or '(none)'}")
    payload = raw[i:]
    print(f"payload {len(payload)} bytes")
    if ptype not in (5, 6):
        return 0

    channel_hash, mac, ciphertext = payload[0], payload[1:3], payload[3:]
    print(f"channel hash {channel_hash} ({channel_hash:#04x}), MAC as sent {mac.hex()}, "
          f"ciphertext {len(ciphertext)} bytes{'' if len(ciphertext) % 16 == 0 else ' - NOT a whole number of AES blocks'}")
    secrets = [("Public", PUBLIC)] + [(c, secret_of(c)) for c in args.channel] + [(s[:8] + "...", secret_of(s)) for s in args.secret]
    found = False
    for name, secret in secrets:
        h = hashlib.sha256(secret).digest()[0]
        made = mac_of(secret, ciphertext)
        ok = made == mac
        print(f"  {name}: hash {h}{' (matches)' if h == channel_hash else ''}, MAC {made.hex()}{' - MATCHES' if ok else ''}")
        if ok:
            print("    " + show_plain(aes_ecb_decrypt(secret, ciphertext)))
            found = True
    if found:
        return 0

    # not read: cut short, or a byte lost or gained at some place?
    for name, secret in secrets:
        if hashlib.sha256(secret).digest()[0] != channel_hash:
            continue
        for cut in range(1, 33):
            if mac_of(secret, ciphertext[:-cut]) == mac:
                print(f"  {name}: the MAC matches with the last {cut} byte(s) left off - extra bytes at the end")
                return 0
        for k in range(len(ciphertext)):
            if mac_of(secret, ciphertext[:k] + ciphertext[k + 1:]) == mac:
                print(f"  {name}: the MAC matches with byte {k} left out - a byte gained there")
                return 0
        plain = aes_ecb_decrypt(secret, ciphertext)
        print(f"  {name}: no MAC match; decrypted anyway - {plain[:64]!r}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
