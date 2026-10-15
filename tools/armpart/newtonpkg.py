#!/usr/bin/env python3
"""A Newton package split into its parts - the directory as text, each
protocol part as ARM assembly source (newtonarm.py), every other part as
its bytes - and put back together, byte for byte.  Pure Python (stdlib
only; reads tools/newton-rom/analysis/packages.py for moving a frames
part).

    python tools/armpart/newtonpkg.py unpack FILE.pkg DIR [--rom BUILD]
        writes DIR/package.txt, DIR/partN.s for each protocol part and
        DIR/partN.bin for the rest; then packs DIR again and refuses
        (exit 1) unless that gives back FILE.pkg's bytes exactly.  --rom
        names the ROM functions the protocol parts' glue reaches.
    python tools/armpart/newtonpkg.py pack DIR FILE.pkg
        builds the package from DIR, edited or not.
    python tools/armpart/newtonpkg.py check FILE.pkg...
        whether each package round-trips.

package.txt (tools/armpart/README.md has the details) holds the
directory's fields - signature, type, flags, version, copyright, name, the
date and reserved words, the bytes NTK leaves after the strings - and per
part its file, type, flags, info and compressor strings; for a part kept as
bytes, the offsets of its words the relocation chunk names and where it was
linked.  What follows from the parts is worked out when packing: the
directory's size, each part's offset and size, the relocation chunk, the
package's size, and each protocol part's origin (so its relocated words
follow it: a part's source has no .origin line, which would go stale).  A frames part that moves is rebased (its pointer refs are
offsets in the package: packages.py's rebase_frames_part); what a frames
part holds is not yet source (it stays bytes).

The directory layout this writes, and so reads back, is the one NTK and
the other package builders use: the InfoRefs' strings one after another in
the directory data (a zero-length one as offset 0) - by default copyright,
name, then each part's info and compressor, else in the order a `layout`
line gives - with the runs of bytes no InfoRef points at (`trailer`,
`trailer2`, ...: NTK's own name, a tool's padding) where they lay, then
padding to four; the parts one after another from the end of the
directory (and of the relocation chunk), each but the last padded to four
with nought.  unpack refuses a package laid out otherwise (with
overlapping strings, say, or bytes between its parts).

A package that lies at an address of its own - one of the ROM
extension's, in the form the ROM keeps them in (no relocation chunk, its
refs and branches the addresses they reach) - is unpacked with that
address as its `base` (a `base` line in package.txt): each part's origin
is then its address, so a protocol part's branches out of it are written
as the addresses they reach (the ROM's patch table at 0x01e00000, say),
and pack(dir, base) puts the parts at another address keeping them so.

A frames part may be kept as a NewtonScript source tree instead of its
bytes (`file partN/`, a directory): romsrc.py writes and builds those
(`romsrc.py package unpack|pack`, which hand unpack and pack their
`trees`), as it does the ROM's own packages' parts.  pack() without
`trees` refuses a package that has one.

As a module: unpack(data, dir, rom=None, base=0, trees=None),
pack(dir, base=None, trees=None) -> bytes, roundtrips(data) -> bool.
trees is an object with extract(part, offset, relocations, path) -> bool
(the part, at that offset in the package with those relocated words in
it, written as a tree at path when it builds back the same) and
build(path, offset) -> (bytes, relocations) (the tree built at that
offset; its relocated words' offsets in the part).
"""

from __future__ import annotations

import os
import re
import shutil
import struct
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "newton-rom", "analysis"))

import newtonarm		# noqa: E402

RELOCATION_FLAG = newtonarm.RELOCATION_FLAG
KIND_PROTOCOL, KIND_FRAMES = 0, 1
COMPRESSED_FLAG = 0x40


class PackageError(Exception):
	pass


# ---------------------------------------------------------------------------
# strings

def utf16_text(raw: bytes) -> str:
	"""A UTF-16 (big-endian) string as a quoted literal: \\0 for the nul,
	\\uXXXX for what is not printable."""
	if len(raw) & 1:
		raise PackageError("an odd-length UTF-16 string")
	out = []
	for i in range(0, len(raw), 2):
		c = struct.unpack_from(">H", raw, i)[0]
		if c == 0:
			out.append("\\0")
		elif c == 0x22:
			out.append('\\"')
		elif c == 0x5C:
			out.append("\\\\")
		elif 0x20 <= c < 0x7F or 0xA0 <= c < 0xD800 or 0xE000 <= c < 0xFFFE:
			out.append(chr(c))
		else:
			out.append("\\u%04x" % c)
	return '"' + "".join(out) + '"'


def bytes_text(raw: bytes) -> str:
	"""A byte string as a quoted literal: \\0, \\xHH for what is not printable."""
	out = []
	for c in raw:
		if c == 0:
			out.append("\\0")
		elif c == 0x22:
			out.append('\\"')
		elif c == 0x5C:
			out.append("\\\\")
		elif 0x20 <= c < 0x7F:
			out.append(chr(c))
		else:
			out.append("\\x%02x" % c)
	return '"' + "".join(out) + '"'


def parse_literal(t: str):
	"""A quoted literal -> list of code points."""
	t = t.strip()
	if len(t) < 2 or t[0] != '"' or t[-1] != '"':
		raise PackageError("not a quoted string: %s" % t)
	body, out, i = t[1:-1], [], 0
	while i < len(body):
		ch = body[i]
		if ch == "\\":
			e = body[i + 1]
			if e == "0":
				out.append(0)
				i += 2
			elif e == "x":
				out.append(int(body[i + 2:i + 4], 16))
				i += 4
			elif e == "u":
				out.append(int(body[i + 2:i + 6], 16))
				i += 6
			elif e in '"\\':
				out.append(ord(e))
				i += 2
			else:
				raise PackageError("bad escape \\%s" % e)
		else:
			out.append(ord(ch))
			i += 1
	return out


def utf16_bytes(t: str) -> bytes:
	return b"".join(struct.pack(">H", c) for c in parse_literal(t))


def literal_bytes(t: str) -> bytes:
	cps = parse_literal(t)
	if any(c > 255 for c in cps):
		raise PackageError("a byte string holds a character past 0xff: %s" % t)
	return bytes(cps)


def fourcc_text(w: int) -> str:
	b = struct.pack(">I", w)
	if all(0x20 <= c < 0x7F and c != 0x27 for c in b):
		return "'%s'" % b.decode("ascii")
	return "0x%08x" % w


def fourcc_value(t: str) -> int:
	t = t.strip()
	if t.startswith("'") and t.endswith("'") and len(t) == 6:
		return struct.unpack(">I", t[1:5].encode("ascii"))[0]
	return int(t, 0)


# ---------------------------------------------------------------------------
# reading a package

def build_relocation_chunk(offsets, page_size: int, base: int, reserved: int, slack: int = 0) -> bytes:
	"""The relocation chunk naming the words at the offsets (in the
	package): its header, then per page (ascending) its number, a count
	and the words' indices in the page, padded to four with nought; then
	slack bytes of nought (NTK leaves room it does not use, its size
	counted in the chunk's)."""
	pages = {}
	for off in sorted(offsets):
		if off & 3:
			raise PackageError("a relocated word at %#x is not word-aligned" % off)
		pages.setdefault(off // page_size, []).append((off % page_size) // 4)
	body = b""
	for page in sorted(pages):
		idx = pages[page]
		if any(i > 255 for i in idx):
			raise PackageError("page size %d is too large for a relocation chunk" % page_size)
		body += struct.pack(">HH", page, len(idx)) + bytes(idx) + b"\0" * ((-len(idx)) % 4)
	return struct.pack(">5I", reserved, 20 + len(body) + slack, page_size, len(pages), base) + body + bytes(slack)


def read(data: bytes, base: int = 0):
	"""The package's directory as a dict and its parts' bytes (each part's
	origin its offset in the package plus base); raises
	PackageError when the layout is not NTK's (which pack would not give
	back)."""
	sig = data[:8]
	if sig not in (b"package0", b"package1"):
		raise PackageError("not a package")
	(ptype, flags, version, copy_off, copy_len, name_off, name_len, size, date, reserved2, reserved3,
		dir_size, num_parts) = struct.unpack_from(">IIIHHHHIIIIII", data, 8)
	if size != len(data):
		raise PackageError("the package's size field (%d) is not its length (%d)" % (size, len(data)))
	data_start = 52 + 32 * num_parts
	pkg = {"signature": sig.decode("ascii"), "type": ptype, "flags": flags, "version": version,
		"date": date, "reserved2": reserved2, "reserved3": reserved3, "parts": []}
	refs = [(copy_off, copy_len)]
	refs.append((name_off, name_len))
	pkg["copyright"] = data[data_start + copy_off:data_start + copy_off + copy_len]
	pkg["name"] = data[data_start + name_off:data_start + name_off + name_len]
	entries = []
	for i in range(num_parts):
		e = 52 + 32 * i
		(offset, psize, size2, part_type, reserved, pflags, info_off, info_len,
			comp_off, comp_len) = struct.unpack_from(">IIIIIIHHHH", data, e)
		entries.append((offset, psize))
		refs += [(info_off, info_len), (comp_off, comp_len)]
		pkg["parts"].append({"type": part_type, "flags": pflags, "reserved": reserved, "size2": size2,
			"size": psize, "info": data[data_start + info_off:data_start + info_off + info_len],
			"compressor": data[data_start + comp_off:data_start + comp_off + comp_len]})
	# the strings one after another (a zero-length one at 0), with runs of
	# other bytes - NTK's own name, a tool's padding - among or after them
	keys = ["copyright", "name"] + [k % i for i in range(num_parts) for k in ("info%d", "compressor%d")]
	placed = []
	for key, (off, length) in zip(keys, refs):
		if length == 0:
			if off != 0:
				raise PackageError("an empty InfoRef not at offset 0")
		else:
			placed.append((off, length, key))
	at, layout, fillers = 0, [], []
	for off, length, key in sorted(placed):
		if off < at:
			raise PackageError("the directory's strings overlap")
		if off > at:
			fillers.append(data[data_start + at:data_start + off])
			layout.append(filler_name(len(fillers) - 1))
		layout.append(key)
		at = off + length
	rest = data[data_start + at:dir_size]
	pad = 0
	for k in (3, 2, 1):
		if k <= len(rest) and len(set(rest[-k:])) == 1 and k == (-(dir_size - k)) % 4:
			pad = k
			break
	if not fillers or len(rest) > pad:
		fillers.append(rest[:len(rest) - pad])
		layout.append(filler_name(len(fillers) - 1))
	pkg["layout"] = layout
	pkg["fillers"] = fillers
	pkg["pad"] = rest[-1] if pad else 0
	if dir_size % 4:
		raise PackageError("the directory's size is not a multiple of four")
	parts_base = dir_size
	relocs = []
	if flags & RELOCATION_FLAG:
		reserved, chunk_size, page_size, count, base = struct.unpack_from(">5I", data, dir_size)
		_, relocs = newtonarm.read_relocations(data, dir_size)
		chunk = data[dir_size:dir_size + chunk_size]
		built = build_relocation_chunk(relocs, page_size, base, reserved)
		slack = chunk_size - len(built)
		if slack < 0 or chunk[20:len(built)] != built[20:] or any(chunk[len(built):]):
			raise PackageError("the relocation chunk is not laid out as this writes one")
		pkg["relocation"] = {"page_size": page_size, "base": base, "reserved": reserved, "slack": slack}
		parts_base += chunk_size
	at = 0
	blobs = []
	for i, (offset, psize) in enumerate(entries):
		if offset != at:
			raise PackageError("part %d is not where the previous one ends (padded to four)" % i)
		start = parts_base + offset
		blobs.append(data[start:start + psize])
		part = pkg["parts"][i]
		part["origin"] = base + start
		part["relocations"] = sorted(r - start for r in relocs if start <= r < start + psize)
		if any(data[start + psize:start + psize + (-psize % 4)]):
			raise PackageError("part %d is padded with something other than nought" % i)
		at = offset + psize + (-psize % 4)
	if entries and parts_base + entries[-1][0] + entries[-1][1] != len(data):
		raise PackageError("bytes follow the last part")
	if relocs and sum(len(p["relocations"]) for p in pkg["parts"]) != len(relocs):
		raise PackageError("the relocation chunk names words outside the parts")
	return pkg, blobs


# ---------------------------------------------------------------------------
# unpack

def filler_name(i):
	"""The name of the directory data's i-th run of bytes that no InfoRef
	points at."""
	return "trailer" if i == 0 else "trailer%d" % (i + 1)


def default_layout(pkg):
	"""NTK 1.6.4b2's: the strings in order, then its own name (`trailer`)."""
	keys = []
	for key in ("copyright", "name"):
		if pkg[key]:
			keys.append(key)
	for i, p in enumerate(pkg["parts"]):
		for field in ("info", "compressor"):
			if p[field]:
				keys.append("%s%d" % (field, i))
	return keys + ["trailer"]


def unpack(data: bytes, directory: str, rom=None, base: int = 0, trees=None) -> None:
	"""Writes the package's text form to directory (made afresh); raises
	PackageError unless packing it gives the package back exactly.  base:
	the package's address, when it lies at one (the ROM extension's)."""
	pkg, blobs = read(data, base)
	if base and pkg["flags"] & RELOCATION_FLAG:
		raise PackageError("a package with a relocation chunk is linked at 0, not at a base")
	if os.path.isdir(directory):
		shutil.rmtree(directory)
	os.makedirs(directory)
	lines = [
		"# A Newton package's directory: python tools/armpart/newtonpkg.py pack DIR OUT.pkg",
		"# (sizes, offsets, the relocation chunk and the parts' origins are worked out)",
		"signature %s" % pkg["signature"],
		"type %s" % fourcc_text(pkg["type"]),
		"flags 0x%08x" % pkg["flags"],
		"version %d" % pkg["version"],
		"copyright %s" % utf16_text(pkg["copyright"]),
		"name %s" % utf16_text(pkg["name"]),
		"date 0x%08x" % pkg["date"],
		"reserved2 0x%08x" % pkg["reserved2"],
		"reserved3 0x%08x" % pkg["reserved3"],
	]
	lines += ["%s %s" % (filler_name(i), bytes_text(f)) for i, f in enumerate(pkg["fillers"])]
	if pkg["layout"] != default_layout(pkg):
		lines.append("layout " + " ".join(pkg["layout"]))
	lines += [
		"pad 0x%02x" % pkg["pad"],
	]
	if base:
		lines.append("base 0x%x\t# the package's address: each part's origin is its address" % base)
	if "relocation" in pkg:
		r = pkg["relocation"]
		lines += ["relocation-page-size %d" % r["page_size"], "relocation-base 0x%x" % r["base"],
			"relocation-reserved 0x%x" % r["reserved"], "relocation-slack %d" % r["slack"]]
	name = pkg["name"].decode("utf-16-be", "replace").rstrip("\0")
	for i, (part, blob) in enumerate(zip(pkg["parts"], blobs)):
		protocol = part["flags"] & 3 == KIND_PROTOCOL
		file = "part%d.%s" % (i, "s" if protocol else "bin")
		lines += ["", "part %d" % i, "\tfile %s" % file, "\ttype %s" % fourcc_text(part["type"]),
			"\tflags 0x%x" % part["flags"]]
		if part["reserved"]:
			lines.append("\treserved 0x%x" % part["reserved"])
		if part["size2"] != part["size"]:
			lines.append("\tsize2 %d" % part["size2"])
		lines += ["\tinfo %s" % bytes_text(part["info"]), "\tcompressor %s" % bytes_text(part["compressor"])]
		path = os.path.join(directory, file)
		tree = part["flags"] & 3 == KIND_FRAMES and not part["flags"] & COMPRESSED_FLAG and trees is not None \
			and trees.extract(blob, part["origin"], part["relocations"], os.path.join(directory, "part%d" % i))
		if tree:
			lines[lines.index("\tfile %s" % file)] = "\tfile part%d/\t# a frames part as a source tree (romsrc.py)" % i
		elif protocol:
			title = '"%s" part %d: protocol (%d bytes)' % (name, i, len(blob))
			newtonarm.unpack(blob, path, part["relocations"], part["origin"], rom, title, origin_line=False)
		else:
			with open(path, "wb") as f:
				f.write(blob)
			lines.append("\tlinked-at 0x%x" % part["origin"])
			if part["relocations"]:
				lines.append("\trelocations " + " ".join("0x%x" % r for r in part["relocations"]))
	with open(os.path.join(directory, "package.txt"), "w", encoding="utf-8", newline="\n") as f:
		f.write("\n".join(lines) + "\n")
	if pack(directory, trees=trees) != data:
		raise PackageError("%s: the text form does not give the package back byte for byte" % directory)


# ---------------------------------------------------------------------------
# pack

def read_text(directory: str):
	pkg = {"parts": [], "pad": 0, "reserved2": 0, "reserved3": 0, "date": 0, "fillers": {}}
	part = None
	with open(os.path.join(directory, "package.txt"), encoding="utf-8") as f:
		for number, raw in enumerate(f, 1):
			s = raw.split("#", 1)[0].strip() if raw.lstrip().startswith("base ") else raw.strip()
			if not s or s.startswith("#"):
				continue
			key, _, value = s.partition(" ")
			value = value.strip()
			try:
				if key == "part":
					part = {"index": int(value), "type": 0, "flags": 0, "reserved": 0, "info": b"",
						"compressor": b"", "relocations": [], "linked_at": None, "size2": None}
					pkg["parts"].append(part)
				elif part is not None:
					if key == "file":
						part["file"] = value.split("#", 1)[0].strip()
					elif key in ("type",):
						part["type"] = fourcc_value(value)
					elif key in ("flags", "reserved", "size2"):
						part[key] = int(value, 0)
					elif key in ("info", "compressor"):
						part[key] = literal_bytes(value)
					elif key == "linked-at":
						part["linked_at"] = int(value, 0)
					elif key == "relocations":
						part["relocations"] = [int(x, 0) for x in value.split()]
					else:
						raise PackageError("unknown part field %r" % key)
				elif key == "signature":
					pkg["signature"] = value
				elif key == "type":
					pkg["type"] = fourcc_value(value)
				elif key in ("flags", "version", "date", "reserved2", "reserved3", "pad", "base"):
					pkg[key] = int(value, 0)
				elif key in ("copyright", "name"):
					pkg[key] = utf16_bytes(value)
				elif re.match(r"^trailer\d*$", key):
					pkg["fillers"][key] = literal_bytes(value)
				elif key == "layout":
					pkg["layout"] = value.split()
				elif key.startswith("relocation-"):
					pkg.setdefault("relocation", {"page_size": 1024, "base": 0, "reserved": 0, "slack": 0})
					pkg["relocation"][key[len("relocation-"):].replace("-", "_")] = int(value, 0)
				else:
					raise PackageError("unknown field %r" % key)
			except (ValueError, PackageError) as e:
				raise PackageError("%s/package.txt:%d: %s" % (directory, number, e))
	return pkg


def pack(directory: str, base: int = None, trees=None) -> bytes:
	"""The package built from its text form, at base (the package's address:
	package.txt's `base`, 0 if it has none, unless given); trees builds the
	frames parts kept as source trees (the module's docstring)."""
	import packages			# tools/newton-rom/analysis: rebase_frames_part
	pkg = read_text(directory)
	if base is None:
		base = pkg.get("base", 0)
	parts = pkg["parts"]
	align = 8 if pkg["signature"] == "package0" else 4
	# the directory: header, entries, strings (offsets worked out)
	strings = {"copyright": pkg["copyright"], "name": pkg["name"]}
	for i, p in enumerate(parts):
		strings["info%d" % i], strings["compressor%d" % i] = p["info"], p["compressor"]
	layout = pkg.get("layout") or default_layout(pkg)
	layout = layout + [k for k in default_layout(pkg) if k not in layout and k in strings]
	tail, refs = bytearray(), {}
	for key in layout:
		if re.match(r"^trailer\d*$", key):
			tail += pkg["fillers"].get(key, b"")
		elif key not in strings:
			raise PackageError("layout names %r, which is no string of the directory" % key)
		elif strings[key]:
			refs[key] = (len(tail), len(strings[key]))
			tail += strings[key]
	copy_ref, name_ref = refs.get("copyright", (0, 0)), refs.get("name", (0, 0))
	part_refs = [(refs.get("info%d" % i, (0, 0)), refs.get("compressor%d" % i, (0, 0))) for i in range(len(parts))]
	data_start = 52 + 32 * len(parts)
	tail += bytes([pkg["pad"]]) * ((-(data_start + len(tail))) % 4)
	tail = bytes(tail)
	dir_size = data_start + len(tail)
	# the parts' bytes: a source assembled once for its size (which no origin changes)
	sources = {}
	sizes = []
	for p in parts:
		path = os.path.join(directory, p["file"])
		if p["file"].endswith("/"):
			if trees is None:
				raise PackageError("%s: part %d is a source tree, which only romsrc.py builds "
					"(romsrc.py package pack)" % (directory, p["index"]))
			if base:
				raise PackageError("a package at a base cannot have a part kept as a tree")
			p["tree"] = path
			p["trees"] = trees
			p["built"] = {}
			sizes.append(len(build_tree(p, trees, 0)[0]))
		elif p["file"].endswith(".s"):
			with open(path, encoding="utf-8") as f:
				sources[id(p)] = f.read()
			sizes.append(len(newtonarm.assemble(sources[id(p)], 0, path).data))
		else:
			with open(path, "rb") as f:
				p["bytes"] = f.read()
			sizes.append(len(p["bytes"]))
	offsets, at = [], 0
	for size in sizes:
		offsets.append(at)
		at += size + (-size % 4)
	# the relocation chunk: its size moves the parts, which moves what it names
	chunk = b""
	reloc = pkg.get("relocation")
	if pkg["flags"] & RELOCATION_FLAG:
		if base:
			raise PackageError("a package with a relocation chunk is linked at 0, not at a base")
		reloc = reloc or {"page_size": 1024, "base": 0, "reserved": 0, "slack": 0}
		chunk_size = 20
		for _ in range(16):
			built = {}
			allrelocs = []
			for p, off in zip(parts, offsets):
				origin = dir_size + chunk_size + off
				built[id(p)] = place(p, sources, origin, directory, packages, align)
				allrelocs += [origin + r for r in built[id(p)][1]]
			chunk = build_relocation_chunk(allrelocs, reloc["page_size"], reloc["base"], reloc["reserved"],
				reloc["slack"])
			if len(chunk) == chunk_size:
				break
			chunk_size = len(chunk)
		else:
			raise PackageError("the relocation chunk's size does not settle")
	else:
		built = {}
		for p, off in zip(parts, offsets):
			built[id(p)] = place(p, sources, base + dir_size + off, directory, packages, align)
			if built[id(p)][1]:
				raise PackageError("part %d has relocations but the package has no kRelocationFlag" % p["index"])
	body = bytearray()
	for i, p in enumerate(parts):
		blob = built[id(p)][0]
		body += blob
		if i + 1 < len(parts):		# (no padding after the last part)
			body += b"\0" * (-len(blob) % 4)
	total = dir_size + len(chunk) + len(body)
	head = bytearray(pkg["signature"].encode("ascii"))
	head += struct.pack(">IIIHHHHIIIIII", pkg["type"], pkg["flags"], pkg["version"], copy_ref[0], copy_ref[1],
		name_ref[0], name_ref[1], total, pkg["date"], pkg["reserved2"], pkg["reserved3"], dir_size, len(parts))
	for p, off, size, (info, comp) in zip(parts, offsets, sizes, part_refs):
		head += struct.pack(">IIIIIIHHHH", off, size, p["size2"] if p["size2"] is not None else size, p["type"],
			p["reserved"], p["flags"], info[0], info[1], comp[0], comp[1])
	return bytes(head + tail + chunk + body)


def build_tree(p, trees, origin):
	"""A tree part built at origin (once for each origin asked for)."""
	if origin not in p["built"]:
		p["built"][origin] = (trees or p["trees"]).build(p["tree"], origin)
	return p["built"][origin]


def place(p, sources, origin, directory, packages, align):
	"""(the part's bytes at origin in the package, its relocated words'
	offsets in it)."""
	if "tree" in p:
		return build_tree(p, None, origin)
	if id(p) in sources:
		a = newtonarm.assemble(sources[id(p)], origin, os.path.join(directory, p["file"]))
		return a.data, a.relocations
	data = bytearray(p["bytes"])
	old = p["linked_at"]
	if old is not None and old != origin:
		delta = origin - old
		before = bytes(data)
		if p["flags"] & 3 == KIND_FRAMES and not p["flags"] & COMPRESSED_FLAG:
			packages.rebase_frames_part(data, old, old + len(data), delta, align)
		for r in p["relocations"]:
			v = struct.unpack_from(">I", before, r)[0]
			if struct.unpack_from(">I", data, r)[0] == v and old <= v < old + len(data):
				struct.pack_into(">I", data, r, v + delta)
	return bytes(data), p["relocations"]


def roundtrips(data: bytes) -> bool:
	tmp = tempfile.mkdtemp(prefix="newtonpkg-")
	try:
		unpack(data, os.path.join(tmp, "pkg"))
		return True
	except PackageError:
		return False
	finally:
		shutil.rmtree(tmp)


# ---------------------------------------------------------------------------
# the command line

def main(argv=None):
	argv = sys.argv[1:] if argv is None else argv
	rom = None
	if "--rom" in argv:
		i = argv.index("--rom")
		rom = newtonarm.RomNames(argv[i + 1])
		argv = argv[:i] + argv[i + 2:]
	if len(argv) == 3 and argv[0] == "unpack":
		with open(argv[1], "rb") as f:
			data = f.read()
		try:
			unpack(data, argv[2], rom)
		except (PackageError, ValueError, newtonarm.AsmError) as e:
			print("%s: %s" % (argv[1], e), file=sys.stderr)
			return 1
		print("%s -> %s" % (argv[1], argv[2]))
		return 0
	if len(argv) == 3 and argv[0] == "pack":
		try:
			data = pack(argv[1])
		except (PackageError, newtonarm.AsmError) as e:
			print(e, file=sys.stderr)
			return 1
		with open(argv[2], "wb") as f:
			f.write(data)
		print("%s -> %s, %d bytes" % (argv[1], argv[2], len(data)))
		return 0
	if len(argv) >= 2 and argv[0] == "check":
		bad = 0
		for path in argv[1:]:
			with open(path, "rb") as f:
				ok = roundtrips(f.read())
			bad += not ok
			print("%s: %s" % (path, "identical" if ok else "DIFFERS"))
		return 1 if bad else 0
	print(__doc__, file=sys.stderr)
	return 2


if __name__ == "__main__":
	sys.exit(main())
