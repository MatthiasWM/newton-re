#!/usr/bin/env python3
"""The ROM extension's non-object pieces and the ROM's parameter block as text.

romsrc/ (romsrc/README.md) keeps the ROM extension cut into pieces in
address order (rex.tsv) and the ROM's other data by name (romdata.tsv).
The objects are source of their own; this module is the text form of the
rest - what the extension's header, its config entries and its package
directories are - and makes their bytes back, exactly the ROM's for every
committed file.  Each file says what it is on its first line that is not
a comment, `format <kind>`; `#` starts a comment (outside quotes):

  rex-header         the extension's header (RExHeader,
                     headers/OS600/ROMExtension.h): its signatures,
                     checksum, version words and id, then one `entry`
                     line per config entry - its tag and the rex.tsv
                     piece it starts at, and the piece it runs up to
                     when it covers more than one (`end`: to the end of
                     the extension).  Worked out on build: the length,
                     the start (rex.tsv's `rex` line), the count, each
                     entry's offset and length.
  config-table       a config entry that is a version word, a count and
                     that many rows of words ('dio ', 'gpio', 'ralc'):
                     `version`, `columns` (the names of a row's words -
                     documentation: the row's width is their number),
                     then a `row` line each.  The count is worked out.
  page-table         an MMU coarse page table ('ptpt', 'glpt'): runs of
                     entries, `first-last address flags` - a small-page
                     descriptor is the page's address and 12 bits of
                     flags.
  refs               a list of words, one to a line (the frame export
                     table 'fexp: the refs of the objects the packages
                     export, which magic-pointer table 2 indexes).
  patch-table        the C patch table ('jump'): `at` (the virtual
                     address it is mapped at), then each entry's target;
                     each entry is an ARM `B` encoded relative to its own
                     virtual address.
  pad                padding: `fill` (the byte) and `align`: as long as
                     it must be for the piece after it to start on that
                     alignment.
  package-directory  a package's directory (PackageDirectory,
                     tools/newton-rom/analysis/packages.py): its
                     signature, type, flags, version, copyright and name,
                     creation date and the two reserved words, one `part`
                     line per part (its type, reserved word, flags, info
                     and compressor name), the `trailer` (bytes in the
                     directory data that nothing points at: NTK's
                     signature) and the `fill` byte the directory is
                     padded to a word with.  Worked out on build: the
                     package's size, the directory's size, the InfoRefs
                     and every part's offset and size - the parts are the
                     rex.tsv pieces that follow the directory.
  words              a block of words, one to a line: its address, a name
                     (the ROM's symbol for it, or `word`) and the value;
                     `zeros N` for a run of N bytes of nought (the ROM's
                     parameter block, romdata/gParamBlock.txt).

Strings are "quoted", UTF-8, with \\uXXXX for a character that is not
printable and \\" and \\\\ escaped; a package's copyright and name are
UTF-16 (the terminator added on build), its part infos and trailer Mac
Roman bytes.  A four-character tag is 'quoted' ('dio ').

Usage:
    rextext.py pack FILE.txt OUT.bin [--tree romsrc]    (the rex-header,
                     package-directory and pad formats need the tree's
                     rex.tsv for the pieces around them)
    rextext.py check romsrc        (every text piece of rex.tsv and
                     romdata.tsv built and printed with its size)

As a module: `load(path)` -> a Piece (`size(address)`, `render(layout,
rel)` -> bytes), `pack(path)` for the formats that need no layout, and
the writers `*_text(...)` that the extractor (romsrc.py) uses, each
giving None when its text would not give the bytes back.
"""

from __future__ import annotations

import argparse
import os
import struct
import sys


# ---- lexical

def quote(text: str) -> str:
	out = []
	for c in text:
		o = ord(c)
		if c in "\\\"":
			out.append("\\" + c)
		elif o < 0x20 or 0x7f <= o < 0xa0 or 0xd800 <= o <= 0xdfff or o in (0x2028, 0x2029, 0xfeff) or o >= 0xfff0:
			out.append("\\u%04x" % o)
		else:
			out.append(c)
	return '"' + "".join(out) + '"'


def tag_text(tag: bytes) -> str:
	text = tag.decode("latin-1")
	if len(tag) == 4 and all(32 <= b < 127 and b != 39 for b in tag):
		return "'" + text + "'"
	return "0x%08x" % struct.unpack(">I", tag)[0]


def tokens(line: str, where: str):
	"""A line's tokens: bare words, "strings" (unquoted, as ('str', text))
	and 'tags' (as ('tag', text)); `#` outside quotes ends the line."""
	out = []
	i, n = 0, len(line)
	while i < n:
		c = line[i]
		if c in " \t\r\n":
			i += 1
		elif c == "#":
			break
		elif c == '"':
			i += 1
			text = []
			while True:
				if i >= n:
					raise ValueError("%s: a string with no end" % where)
				c = line[i]
				if c == '"':
					i += 1
					break
				if c == "\\":
					e = line[i + 1:i + 2]
					if e == "u":
						text.append(chr(int(line[i + 2:i + 6], 16)))
						i += 6
						continue
					if e in ("\\", '"'):
						text.append(e)
						i += 2
						continue
					raise ValueError("%s: unknown escape \\%s" % (where, e))
				text.append(c)
				i += 1
			out.append(("str", "".join(text)))
		elif c == "'":
			end = line.find("'", i + 1)
			if end < 0:
				raise ValueError("%s: a tag with no end" % where)
			out.append(("tag", line[i + 1:end]))
			i = end + 1
		else:
			j = i
			while j < n and line[j] not in " \t\r\n#":
				j += 1
			out.append(line[i:j])
			i = j
	return out


def lines(path: str):
	"""The file's lines as token lists (with where each is), its format first."""
	with open(path, encoding="utf-8") as f:
		text = f.read()
	out = []
	for number, line in enumerate(text.split("\n"), 1):
		where = "%s:%d" % (path, number)
		t = tokens(line, where)
		if t:
			out.append((where, t))
	if not out or out[0][1][0] != "format" or len(out[0][1]) != 2:
		raise ValueError("%s: the first line must be `format <kind>`" % path)
	return out[0][1][1], out[1:]


def number(tok, where: str) -> int:
	if not isinstance(tok, str):
		raise ValueError("%s: %r is not a number" % (where, tok))
	try:
		return int(tok, 0)
	except ValueError:
		raise ValueError("%s: %r is not a number" % (where, tok)) from None


def tag(tok, where: str) -> bytes:
	if isinstance(tok, tuple) and tok[0] == "tag":
		data = tok[1].encode("latin-1")
		if len(data) != 4:
			raise ValueError("%s: a tag is four characters" % where)
		return data
	return struct.pack(">I", number(tok, where) & 0xffffffff)


def string(tok, where: str) -> str:
	if not (isinstance(tok, tuple) and tok[0] == "str"):
		raise ValueError("%s: %r is not a \"string\"" % (where, tok))
	return tok[1]


def expect(t, count, where):
	if len(t) != count:
		raise ValueError("%s: `%s` takes %d values" % (where, t[0], count - 1))


def num_text(v: int, how: str = None) -> str:
	if how == "d":
		return "%d" % v
	if how == "x":
		return "0x%x" % v
	return "%d" % v if v < 10 else "0x%x" % v


# ---- the layout pieces are placed in

class Layout:
	"""Where the pieces of the extension lie: its address and length, and
	each piece's rex.tsv path, offset from the extension's start and size,
	in address order."""

	def __init__(self, base: int, length: int, pieces):
		self.base = base
		self.length = length
		self.pieces = list(pieces)					# (rel, offset, size)
		self.index = {rel: i for i, (rel, _, _) in enumerate(self.pieces)}

	def at(self, rel: str, where: str):
		if rel == "end":
			return self.length, 0
		if rel not in self.index:
			raise ValueError("%s: %s is no piece of rex.tsv" % (where, rel))
		_, offset, size = self.pieces[self.index[rel]]
		return offset, size

	def after(self, rel: str, count: int, where: str):
		i = self.index[rel]
		found = self.pieces[i + 1:i + 1 + count]
		if len(found) != count:
			raise ValueError("%s: %d parts, but only %d pieces follow" % (where, count, len(found)))
		return found


class Piece:
	format = None
	needs_layout = False

	def size(self, address: int) -> int:
		return len(self.data())

	def data(self) -> bytes:
		raise ValueError("a %s piece needs the pieces around it" % self.format)

	def render(self, layout: Layout, rel: str) -> bytes:
		return self.data()


# ---- rex-header

HEADER_FIELDS = ("checksum", "headerVersion", "manufacturer", "version", "id")


class Header(Piece):
	format = "rex-header"
	needs_layout = True

	def __init__(self, body):
		self.signature = None
		self.fields = {}
		self.entries = []					# (tag, first piece, piece it runs up to or None, where)
		for where, t in body:
			if t[0] == "signature":
				expect(t, 3, where)
				self.signature = tag(t[1], where) + tag(t[2], where)
			elif t[0] in HEADER_FIELDS:
				expect(t, 2, where)
				self.fields[t[0]] = number(t[1], where)
			elif t[0] == "entry":
				if len(t) not in (3, 4):
					raise ValueError("%s: `entry tag piece [piece it runs up to]`" % where)
				self.entries.append((tag(t[1], where), t[2], t[3] if len(t) > 3 else None, where))
			else:
				raise ValueError("%s: unknown line %r" % (where, t[0]))
		missing = [f for f in HEADER_FIELDS if f not in self.fields] + (["signature"] if self.signature is None else [])
		if missing:
			raise ValueError("rex-header: no %s" % ", ".join(missing))

	def size(self, address):
		return 0x28 + 12 * len(self.entries)

	def render(self, layout, rel):
		f = self.fields
		out = bytearray(self.signature)
		out += struct.pack(">8I", f["checksum"], f["headerVersion"], f["manufacturer"], f["version"],
						   layout.length, f["id"], layout.base, len(self.entries))
		for t, first, last, where in self.entries:
			offset, size = layout.at(first, where)
			end = offset + size if last is None else layout.at(last, where)[0]
			if end < offset:
				raise ValueError("%s: %s comes before %s" % (where, last, first))
			out += t + struct.pack(">II", offset, end - offset)
		return bytes(out)


def header_text(data: bytes, layout: Layout, rel: str = "rex/header.txt"):
	"""The extension's header as text: layout says where its pieces are
	(the rex.tsv paths the entries name)."""
	if data[:8] != b"RExBlock" or len(data) < 0x28:
		return None
	checksum, hver, manuf, ver, length, rex_id, start, count = struct.unpack(">8I", data[8:0x28])
	if len(data) != 0x28 + 12 * count:
		return None
	starts = {offset: r for r, offset, size in layout.pieces}
	text = ["# the ROM extension's header (RExHeader, headers/OS600/ROMExtension.h; written by",
			"# romsrc.py extract, built by tools/rex/rextext.py): its length, its start (rex.tsv's",
			"# `rex` line), the number of entries and each one's offset and length are worked out",
			"format rex-header",
			"signature\t%s\t%s" % (tag_text(data[0:4]), tag_text(data[4:8])),
			"checksum\t0x%08x\t# nothing in the ROM reads it (docs/rom-free/README.md)" % checksum,
			"headerVersion\t%d" % hver,
			"manufacturer\t0x%08x" % manuf,
			"version\t0x%08x" % ver,
			"id\t%d\t# the patch table 'jump is mapped at 0x01e00000 + id MB (BuildPatchTablePageTable)" % rex_id,
			"# the config entries: the tag, the piece it starts at, and the piece it runs up to",
			"# when it covers more than one (`end`: the end of the extension)"]
	for i in range(count):
		t, offset, size = struct.unpack(">4sII", data[0x28 + 12 * i:0x34 + 12 * i])
		if offset not in starts:
			return None
		first = starts[offset]
		_, first_size = layout.at(first, "header")
		if size == first_size:
			text.append("entry\t%s\t%s" % (tag_text(t), first))
		elif offset + size == layout.length:
			text.append("entry\t%s\t%s\tend" % (tag_text(t), first))
		elif offset + size in starts:
			text.append("entry\t%s\t%s\t%s" % (tag_text(t), first, starts[offset + size]))
		else:
			return None
	text = "\n".join(text) + "\n"
	return text if _rendered(text, layout, rel) == data else None


# ---- config-table

# the names of a config table's words, by its tag: what reads them
# (TGPIOInterface::Init 0x0026c0d0, TBIOInterface::Init 0x0026b620 - an
# entry's word written to a register or a BIO command when it is not
# nought; RAMAllocEntry in ROMExtension.h)
CONFIG_COLUMNS = {
	b"dio ": ("bit", "mask", "dir", "pins", "cmd14", "cmd11", "cmd12", "pullup", "unread"),
	b"gpio": ("bit", "mask", "dir", "polarity", "pullup", "unread1c", "reg18cc00", "reg18d000", "data", "unread2c"),
	b"ralc": ("min", "max", "pct"),
}
# how a column is written: "d" in decimal, "x" in hex (else a small number
# in decimal, a larger one in hex)
COLUMN_FORMS = {"bit": "d", "mask": "x", "min": "x", "max": "x", "pct": "d"}
CONFIG_NOTES = {
	b"dio ": ["# 'dio ': the BIO chip's pins (TBIOInterface::Init 0x0026b620 reads it): a row per",
			  "# function, its bit and mask; each other word not nought puts the bit into what",
			  "# Init writes - dir to BIO command 0xc (WriteDIODir), pins to 0xe (WriteDIOPins),",
			  "# pullup to 0xd (WriteDIOPullup), cmd14/cmd11/cmd12 to commands 0x14/0x11/0x12;",
			  "# `unread` is not read there"],
	b"gpio": ["# 'gpio': the Voyager's general-purpose pins (TGPIOInterface::Init 0x0026c0d0): a row",
			  "# per function (MapFunctionToBit), its bit and mask; each other word not nought puts",
			  "# the bit into the register Init writes - dir 0x0f18e800 (WriteGPIODir), polarity",
			  "# 0x0f18e000, pullup 0x0f18dc00 (inverted), data 0x0f18ec00, reg18cc00 0x0f18cc00,",
			  "# reg18d000 0x0f18d000; the `unread` words are not read there"],
	b"ralc": ["# 'ralc': how RAM is shared out (RAMAllocTable, ROMExtension.h): rows kRAMStoreAlloc,",
			  "# kFramesHeapAlloc, kRDMCacheAlloc - min and max in bytes (0: no limit), pct in 1024ths"],
}


class ConfigTable(Piece):
	format = "config-table"

	def __init__(self, body):
		self.version = None
		self.columns = None
		self.rows = []
		for where, t in body:
			if t[0] == "version":
				expect(t, 2, where)
				self.version = number(t[1], where)
			elif t[0] == "columns":
				self.columns = t[1:]
			elif t[0] == "row":
				if self.columns is None:
					raise ValueError("%s: a row before `columns`" % where)
				if len(t) - 1 != len(self.columns):
					raise ValueError("%s: %d words, not %d" % (where, len(t) - 1, len(self.columns)))
				self.rows.append([number(v, where) & 0xffffffff for v in t[1:]])
			else:
				raise ValueError("%s: unknown line %r" % (where, t[0]))
		if self.version is None or self.columns is None:
			raise ValueError("config-table: no version or columns")

	def data(self):
		return struct.pack(">II", self.version, len(self.rows)) + b"".join(struct.pack(">%dI" % len(r), *r) for r in self.rows)


def config_table_text(t: bytes, data: bytes):
	columns = CONFIG_COLUMNS.get(t)
	if columns is None or len(data) < 8 or len(data) % 4:
		return None
	version, count = struct.unpack(">II", data[:8])
	if len(data) != 8 + 4 * len(columns) * count:
		return None
	words = struct.unpack(">%dI" % ((len(data) - 8) // 4), data[8:])
	text = ["# a config entry of the ROM extension (written by romsrc.py extract, built by",
			"# tools/rex/rextext.py): its version, then its rows; the count is worked out"]
	text += CONFIG_NOTES.get(t, [])
	text += ["format config-table", "version\t%d" % version, "columns\t" + "\t".join(columns)]
	for i in range(count):
		row = words[i * len(columns):(i + 1) * len(columns)]
		text.append("row\t" + "\t".join(num_text(v, COLUMN_FORMS.get(c)) for v, c in zip(row, columns)))
	text = "\n".join(text) + "\n"
	return text if _packed(text) == data else None


# ---- page-table

class PageTable(Piece):
	format = "page-table"

	def __init__(self, body):
		self.entries = []
		for where, t in body:
			expect(t, 3, where)
			first, _, last = t[0].partition("-")
			first = number(first, where)
			last = number(last, where) if last else first
			if first != len(self.entries) or last < first:
				raise ValueError("%s: entries %s, but the next is %d" % (where, t[0], len(self.entries)))
			address, flags = number(t[1], where), number(t[2], where)
			if address & 0xfff or flags & ~0xfff:
				raise ValueError("%s: the address is a page's, the flags 12 bits" % where)
			self.entries += [address | flags] * (last - first + 1)

	def data(self):
		return struct.pack(">%dI" % len(self.entries), *self.entries)


def small_page(flags: int) -> str:
	if flags & 3 != 2:
		return "descriptor type %d" % (flags & 3)
	cache = "cached and buffered" if (flags & 0xc) == 0xc else "cached" if flags & 8 else \
		"buffered" if flags & 4 else "uncached"
	return "small page, %s, AP %s" % (cache, " ".join(str((flags >> s) & 3) for s in (4, 6, 8, 10)))


PAGE_TABLE_NOTES = {
	b"ptpt": "'ptpt, the patch table's page table: the coarse page table that maps the\n"
			 "# 1 MB at 0x01e00000 + id MB, where the extension's C patch table 'jump is seen\n"
			 "# (UseROMJumpTables 0x001832e8, BuildPatchTablePageTable 0x00183230)",
	b"glpt": "'glpt, the patch table's page table for a machine whose ROM lies 4 MB further on:\n"
			 "# 'ptpt's pages 4 MB on - UseROMJumpTables 0x001832e8 takes it instead of 'ptpt\n"
			 "# when gGlobalsThatLiveAcrossReboot's word +0x20 says so, at its address + 4 MB",
}


def page_table_text(t: bytes, data: bytes):
	if len(data) % 4 or not data:
		return None
	words = struct.unpack(">%dI" % (len(data) // 4), data)
	text = ["# %s" % PAGE_TABLE_NOTES.get(t, "a page table"),
			"# (written by romsrc.py extract, built by tools/rex/rextext.py): runs of entries,",
			"# each the page's physical address and the descriptor's flags.  Carried as they are:",
			"# they name pages of the extension in the ROM, which nothing on the host reads",
			"format page-table"]
	i = 0
	while i < len(words):
		j = i
		while j + 1 < len(words) and words[j + 1] == words[i]:
			j += 1
		run = "%d" % i if i == j else "%d-%d" % (i, j)
		text.append("%s\t0x%08x\t0x%03x\t# %s" % (run, words[i] & ~0xfff, words[i] & 0xfff, small_page(words[i] & 0xfff)))
		i = j + 1
	text = "\n".join(text) + "\n"
	return text if _packed(text) == data else None


# ---- refs

class Refs(Piece):
	format = "refs"

	def __init__(self, body):
		self.words = []
		for where, t in body:
			expect(t, 1, where)
			self.words.append(number(t[0], where) & 0xffffffff)

	def data(self):
		return struct.pack(">%dI" % len(self.words), *self.words)


def refs_text(data: bytes, comment=lambda ref: None, notes=()):
	if len(data) % 4:
		return None
	text = list(notes) + ["format refs"]
	for i, w in enumerate(struct.unpack(">%dI" % (len(data) // 4), data)):
		c = comment(w)
		text.append("0x%08x\t# %d%s" % (w, i, ": " + c if c else ""))
	text = "\n".join(text) + "\n"
	return text if _packed(text) == data else None


# ---- patch-table

def branch(at: int, target: int, where: str) -> int:
	offset = target - (at + 8)
	if offset & 3 or not -(1 << 25) <= offset < (1 << 25):
		raise ValueError("%s: no B at %#x reaches %#x" % (where, at, target))
	return 0xea000000 | ((offset >> 2) & 0xffffff)


class PatchTable(Piece):
	format = "patch-table"

	def __init__(self, body):
		self.at = None
		self.targets = []
		for where, t in body:
			if t[0] == "at":
				expect(t, 2, where)
				self.at = number(t[1], where)
			else:
				expect(t, 1, where)
				if self.at is None:
					raise ValueError("%s: an entry before `at`" % where)
				self.targets.append((number(t[0], where), where))

	def data(self):
		return b"".join(struct.pack(">I", branch(self.at + 4 * i, target, where))
						for i, (target, where) in enumerate(self.targets))


def patch_table_text(data: bytes, at: int, comment=lambda address: None):
	if len(data) % 4:
		return None
	text = ["# the ROM extension's C patch table 'jump (written by romsrc.py extract, built by",
			"# tools/rex/rextext.py): ARM branches, each encoded relative to its own virtual address",
			"# - `at` the table's (0x01e00000 + the extension's id MB: BuildPatchTablePageTable",
			"# 0x00183230, the page tables 'ptpt and 'glpt) - each line the address it branches to",
			"format patch-table",
			"at\t0x%08x" % at]
	for i, w in enumerate(struct.unpack(">%dI" % (len(data) // 4), data)):
		if w >> 24 != 0xea:
			return None
		offset = w & 0xffffff
		if offset & 0x800000:
			offset -= 0x1000000
		target = (at + 4 * i + 8 + 4 * offset) & 0xffffffff
		c = comment(target)
		text.append("0x%08x\t# %d%s" % (target, i, ": " + c if c else ""))
	text = "\n".join(text) + "\n"
	return text if _packed(text) == data else None


# ---- pad

class Pad(Piece):
	format = "pad"

	def __init__(self, body):
		self.fill = 0
		self.align = None
		for where, t in body:
			expect(t, 2, where)
			if t[0] == "fill":
				self.fill = number(t[1], where)
			elif t[0] == "align":
				self.align = number(t[1], where)
			else:
				raise ValueError("%s: unknown line %r" % (where, t[0]))
		if not self.align or self.align & (self.align - 1):
			raise ValueError("pad: `align` must be a power of two")

	def size(self, address):
		return -address % self.align

	def render(self, layout, rel):
		offset, size = layout.at(rel, "pad")
		return bytes([self.fill]) * size


def pad_text(data: bytes, address: int, align: int):
	if not data or data != bytes([data[0]]) * len(data) or (address + len(data)) % align or len(data) >= align:
		return None
	return ("# padding (written by romsrc.py extract, built by tools/rex/rextext.py): as long as\n"
			"# it must be for the piece after it to start on the alignment\n"
			"format pad\nfill\t0x%02x\nalign\t0x%x\n" % (data[0], align))


# ---- package-directory

def _utf16(text: str) -> bytes:
	return text.encode("utf-16-be") + b"\0\0"


class PackageDirectory(Piece):
	format = "package-directory"
	needs_layout = True

	def __init__(self, body):
		self.fields = {}
		self.parts = []
		self.trailer = b""
		self.fill = 0xff
		for where, t in body:
			k = t[0]
			if k == "signature":
				expect(t, 2, where)
				self.fields[k] = t[1].encode("latin-1")
				if len(self.fields[k]) != 8:
					raise ValueError("%s: a signature is eight characters" % where)
			elif k == "type":
				expect(t, 2, where)
				self.fields[k] = tag(t[1], where)
			elif k in ("flags", "version", "creation"):
				expect(t, 2, where)
				self.fields[k] = number(t[1], where)
			elif k == "reserved":
				expect(t, 3, where)
				self.fields[k] = (number(t[1], where), number(t[2], where))
			elif k in ("copyright", "name"):
				expect(t, 2, where)
				self.fields[k] = string(t[1], where)
			elif k == "part":
				# part TYPE RESERVED FLAGS "info" "compressor"
				expect(t, 6, where)
				self.parts.append((tag(t[1], where), number(t[2], where), number(t[3], where),
								   string(t[4], where).encode("mac_roman"), string(t[5], where).encode("mac_roman")))
			elif k == "trailer":
				expect(t, 2, where)
				self.trailer = string(t[1], where).encode("mac_roman")
			elif k == "fill":
				expect(t, 2, where)
				self.fill = number(t[1], where)
			else:
				raise ValueError("%s: unknown line %r" % (where, k))
		missing = [k for k in ("signature", "type", "flags", "version", "copyright", "name", "creation", "reserved")
				   if k not in self.fields]
		if missing:
			raise ValueError("package-directory: no %s" % ", ".join(missing))

	def _data_area(self):
		"""The directory data, and each InfoRef in it: copyright, name, then
		each part's info and compressor name, then the trailer."""
		data = bytearray()

		def put(raw):
			if not raw:
				return 0, 0
			data.extend(raw)
			return len(data) - len(raw), len(raw)
		copyright = put(_utf16(self.fields["copyright"]))
		name = put(_utf16(self.fields["name"]))
		refs = [(put(info), put(comp)) for _, _, _, info, comp in self.parts]
		data += self.trailer
		data += bytes([self.fill]) * (-(52 + 32 * len(self.parts) + len(data)) % 4)
		return bytes(data), copyright, name, refs

	def size(self, address):
		return 52 + 32 * len(self.parts) + len(self._data_area()[0])

	def render(self, layout, rel):
		f = self.fields
		data, copyright, name, refs = self._data_area()
		dir_size = 52 + 32 * len(self.parts) + len(data)
		sizes = [size for _, _, size in layout.after(rel, len(self.parts), rel)]
		out = bytearray(f["signature"] + f["type"])
		out += struct.pack(">II", f["flags"], f["version"])
		out += struct.pack(">HHHH", copyright[0], copyright[1], name[0], name[1])
		out += struct.pack(">IIIIII", dir_size + sum(sizes), f["creation"], f["reserved"][0], f["reserved"][1],
						   dir_size, len(self.parts))
		offset = 0
		for (ptype, reserved, flags, _, _), size, (info, comp) in zip(self.parts, sizes, refs):
			out += struct.pack(">III4sII", offset, size, size, ptype, reserved, flags)
			out += struct.pack(">HHHH", info[0], info[1], comp[0], comp[1])
			offset += size
		return bytes(out + data)


def package_directory_text(data: bytes, layout: Layout, rel: str, name_of="the package"):
	"""A package's directory (data: its bytes, up to its first part) as
	text: layout has the pieces after it, its parts."""
	if data[:7] != b"package" or data[7:8] not in b"01" or len(data) < 52:
		return None
	(ptype, flags, version, co_off, co_len, nm_off, nm_len, size, creation, r2, r3, dir_size,
	 count) = struct.unpack(">4sIIHHHHIIIIII", data[8:52])
	if dir_size != len(data) or 52 + 32 * count > len(data):
		return None
	base = 52 + 32 * count

	def utf16(off, length):
		raw = data[base + off:base + off + length]
		if len(raw) != length or length < 2 or length % 2 or raw[-2:] != b"\0\0":
			return None
		text = raw[:-2].decode("utf-16-be", "replace")
		return text if "\0" not in text else None
	copyright, name = utf16(co_off, co_len), utf16(nm_off, nm_len)
	if copyright is None or name is None:
		return None
	used = max(co_off + co_len, nm_off + nm_len)
	parts = []
	for i in range(count):
		(offset, psize, size2, part_type, reserved, pflags, info_off, info_len, comp_off,
		 comp_len) = struct.unpack(">III4sIIHHHH", data[52 + 32 * i:84 + 32 * i])
		info = data[base + info_off:base + info_off + info_len]
		comp = data[base + comp_off:base + comp_off + comp_len]
		used = max(used, info_off + info_len, comp_off + comp_len)
		parts.append("part\t%s\t%d\t0x%x\t%s\t%s" % (tag_text(part_type), reserved, pflags,
													 quote(info.decode("mac_roman")), quote(comp.decode("mac_roman"))))
	# what follows the strings: the trailer, then up to three bytes of 0xff
	# padding the directory to a word
	rest = data[base + used:]
	k = len(rest)
	while k > 0 and len(rest) - k < 3 and rest[k - 1] == 0xff:
		k -= 1
	trailer, fill = rest[:k], 0xff
	text = ["# the directory of %s (PackageDirectory: tools/newton-rom/analysis/packages.py;" % name_of,
			"# written by romsrc.py extract, built by tools/rex/rextext.py): the package's and",
			"# the directory's sizes, the strings' InfoRefs and each part's offset and size are",
			"# worked out - the parts are the pieces after this one in rex.tsv",
			"format package-directory",
			"signature\t%s" % data[:8].decode("latin-1"),
			"type\t%s" % tag_text(ptype),
			"flags\t0x%08x" % flags,
			"version\t%d" % version,
			"copyright\t%s" % quote(copyright),
			"name\t%s" % quote(name),
			"creation\t0x%08x\t# seconds since 1904" % creation,
			"reserved\t0x%08x\t0x%08x\t# the modify date and the directory's checksum in newer packages" % (r2, r3),
			"# each part: type, reserved word, flags, \"info\", \"compressor\""] + parts
	if trailer:
		text.append("trailer\t%s\t# Mac Roman bytes nothing points at" % quote(trailer.decode("mac_roman")))
	text.append("fill\t0x%02x\t# what the directory is padded to a word with" % fill)
	text = "\n".join(text) + "\n"
	return text if _rendered(text, layout, rel) == data else None


# ---- words

class Words(Piece):
	format = "words"

	def __init__(self, body):
		self.at = None
		self.items = []						# (address, words or zero bytes, where)
		position = None
		for where, t in body:
			if t[0] == "at":
				expect(t, 2, where)
				self.at = position = number(t[1], where)
				continue
			if position is None:
				raise ValueError("%s: a word before `at`" % where)
			expect(t, 3, where)
			address = number(t[0], where)
			if address != position:
				raise ValueError("%s: at %#x, but the line before ends at %#x" % (where, address, position))
			if t[1] == "zeros":
				count = number(t[2], where)
				self.items.append(bytes(count))
				position += count
			else:
				self.items.append(struct.pack(">I", number(t[2], where) & 0xffffffff))
				position += 4

	def data(self):
		return b"".join(self.items)


def words_text(data: bytes, address: int, names=None, notes=None, title=None):
	"""A block of words as text: names (address -> its symbol) names the
	words, notes (address -> comment lines) say what a stretch is; a run of
	unnamed words of nought is one `zeros` line."""
	names = names or {}
	notes = notes or {}
	if len(data) % 4:
		return None
	text = list(title or []) + ["format words", "at\t0x%x" % address]
	i = 0
	while i < len(data):
		a = address + i
		for line in notes.get(a, []):
			text.append("# " + line)
		w = struct.unpack_from(">I", data, i)[0]
		if w == 0 and a not in names:
			j = i + 4
			while j < len(data) and struct.unpack_from(">I", data, j)[0] == 0 and address + j not in names \
					and address + j not in notes:
				j += 4
			text.append("0x%x\tzeros\t0x%x" % (a, j - i))
			i = j
			continue
		text.append("0x%x\t%s\t0x%08x" % (a, names.get(a, "word"), w))
		i += 4
	text = "\n".join(text) + "\n"
	return text if _packed(text) == data else None


# ---- reading

FORMATS = {c.format: c for c in (Header, ConfigTable, PageTable, Refs, PatchTable, Pad, PackageDirectory, Words)}


def parse(path: str) -> Piece:
	kind, body = lines(path)
	if kind not in FORMATS:
		raise ValueError("%s: unknown format %r" % (path, kind))
	return FORMATS[kind](body)


load = parse


def pack(path: str) -> bytes:
	"""The bytes of a piece that needs no layout (all but rex-header,
	package-directory and pad)."""
	return parse(path).data()


def _from_text(text: str) -> Piece:
	import tempfile
	fd, path = tempfile.mkstemp(suffix=".txt")
	try:
		with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as f:
			f.write(text)
		return parse(path)
	finally:
		os.remove(path)


def _packed(text: str):
	try:
		return _from_text(text).data()
	except ValueError:
		return None


def _rendered(text: str, layout: Layout, rel: str):
	try:
		return _from_text(text).render(layout, rel)
	except ValueError:
		return None


# ---- the tree's pieces

def tree_layout(tree: str, sizes=None):
	"""The layout of tree's rex.tsv pieces as the ROM has them (the addresses
	in rex.tsv; the pieces at `-` left out), with each piece's size from the
	address of the next.  ==> Layout."""
	pieces = []
	with open(os.path.join(tree, "rex.tsv"), encoding="utf-8") as f:
		for line in f:
			if line.startswith("#"):
				continue
			fields = line.rstrip("\n").split("\t")
			if fields[0] == "rex":
				base, length = int(fields[1], 16), int(fields[2], 16)
			elif fields[0] != "-":
				pieces.append((fields[1], int(fields[0], 16) - base))
	ends = [offset for _, offset in pieces[1:]] + [length]
	return Layout(base, length, [(rel, offset, end - offset) for (rel, offset), end in zip(pieces, ends)])


def main(argv=None) -> int:
	ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
	sub = ap.add_subparsers(dest="command", required=True)
	p = sub.add_parser("pack", help="make a text piece's bytes")
	p.add_argument("text")
	p.add_argument("output")
	p.add_argument("--tree", help="the tree whose rex.tsv says where the pieces are (for rex-header, "
								  "package-directory and pad: the text must be one of its pieces)")
	c = sub.add_parser("check", help="build every text piece of a tree's rex.tsv and romdata.tsv")
	c.add_argument("tree")
	a = ap.parse_args(argv)
	if a.command == "pack":
		piece = parse(a.text)
		if piece.needs_layout or isinstance(piece, Pad):
			if not a.tree:
				print("a %s piece needs --tree" % piece.format, file=sys.stderr)
				return 1
			layout = tree_layout(a.tree)
			rel = os.path.relpath(os.path.abspath(a.text), os.path.abspath(a.tree)).replace(os.sep, "/")
			data = piece.render(layout, rel)
		else:
			data = piece.data()
		with open(a.output, "wb") as f:
			f.write(data)
		print("%s: %d bytes" % (a.output, len(data)))
		return 0
	layout = tree_layout(a.tree)
	for rel, offset, size in layout.pieces:
		if rel.endswith(".txt"):
			data = parse(os.path.join(a.tree, rel)).render(layout, rel)
			print("%x\t%s\t%d bytes%s" % (layout.base + offset, rel, len(data),
										   "" if len(data) == size else " (rex.tsv has room for %d)" % size))
	path = os.path.join(a.tree, "romdata.tsv")
	if os.path.exists(path):
		with open(path, encoding="utf-8") as f:
			for line in f:
				if line.startswith("#"):
					continue
				address, name, rel = line.rstrip("\n").split("\t")
				if rel.endswith(".txt"):
					print("%s\t%s\t%d bytes" % (address, rel, len(pack(os.path.join(a.tree, rel)))))
	return 0


if __name__ == "__main__":
	sys.exit(main())
