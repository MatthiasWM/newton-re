#!/usr/bin/env python3
"""The ink codec's code books, the letter trigrams and the Letter Shapes
pictures of the ROM as text, and back.

Three kinds of the ROM's trained data, which romsrc/ kept as raw
binaries, each with a text form whose first line after any comments is
`format <kind>`; `#` starts a comment.  Packing makes the binary's bytes
out of it - the ROM's own bytes for every committed file:

  code-book       an ink code book ('Comp: Rparagraphcodebook1, the
                  writing book, and Rparagraphcodebook2 = @145, the ink
                  book; ink/CICCodec.h's _CODETABLE): eight tables, each
                  `table N`, its four header words (`base-down`,
                  `base-up`, `escape-up`, `escape-down`) and its code
                  words - a value and its code as the bits come out of
                  the stream, first bit first ("27 100011").  A table's
                  size and count are worked out, and its entries put in
                  order of code length (stably) as the decoder needs.
  trigrams        the 'Trigrams binary (Rtrig): a two-bit weight for
                  every three-symbol sequence over 32 symbols - a-z, '
                  (27) and _ (28, the edge of a word); a line a trigram
                  whose weight is not nought ("the 3").
  letter-images   the 'letterimages binary of charsetInfoResources
                  (recognition/LetterShapes.h): each `letter` (its Mac
                  Roman byte), each of its `variant`s with its group, and
                  each variant's strokes as x,y points in the 256-square
                  box.  Every offset and count is worked out.

Usage:
    inktables.py unpack FORMAT TABLE.bin OUT.txt
    inktables.py pack TABLE.txt OUT.bin
    inktables.py check FORMAT TABLE.bin...     (unpacked and packed back: the same?)

As a module: `unpack(data, format, path)`; `pack_lines(format, lines,
base)` -> bytes, `lines` the text split on "\\n" (the format line
included) and `base` its directory (no format here has companion files);
`pack(path)` reads the file and does the same.  `FORMATS` names them.
The formats are described in tools/tables/README.md.
"""

from __future__ import annotations

import os
import re
import struct
import sys

FORMATS = ("code-book", "trigrams", "letter-images")


def _rows(format, lines):
	"""The lines that are not comments, split, the format line checked and taken off."""
	out = []
	for line in lines:
		line = line.split("#", 1)[0].strip()
		if line:
			out.append(line.split())
	if not out or out[0][0] != "format" or len(out[0]) != 2:
		raise ValueError("no format line")
	if out[0][1] != format:
		raise ValueError("the file is format %s, not %s" % (out[0][1], format))
	return out[1:]


def _mac_comment(byte: int) -> str:
	if byte < 0x20 or byte == 0x7f:
		return ""
	return "\t# " + bytes([byte]).decode("mac_roman")


# --- code-book -----------------------------------------------------------------
#
# A book is tables laid end to end (DcdrSelectCodeBook walks eight of them
# by their sizes).  A table: halfwords size, count, base-down, base-up,
# escape-up, escape-down (CodeTableSize .. CodeTableEscapeDown), then
# `count` entries of value (signed), length in bits, and the code as a
# word whose bit 0 is the first bit read (DecodeWord_OLD: code |= bit << n).

_HEADER = ("base-down", "base-up", "escape-up", "escape-down")

# What each of the eight tables is read for (ink/CICDecoder.cpp,
# CICEncoder.cpp).
_TABLE_USE = (
	"x of the step to where a stroke starts (ReadNewStroke)",
	"y of that step",
	"x of a segment's end or a short stroke's step (ReadSegmentNear, ReadShortStroke)",
	"y of that step",
	"x of a segment's first bending number, in steps of the book's first length",
	"y of it",
	"x of the second bending number, in steps of its second length",
	"y of it",
)


def _bits(code: int, length: int) -> str:
	return "".join(str((code >> i) & 1) for i in range(length)) or "-"


def _code_book_text(d):
	out = ["format code-book",
		   "# an ink code book (ink/CICCodec.h): eight tables, each its four header",
		   "# words and its code words - a value and its code, the bits in the order",
		   "# the stream gives them (first bit first; DecodeWord_OLD); a value equal",
		   "# to escape-up/escape-down means another word follows, added to",
		   "# base-up/base-down.  Sizes and counts are worked out on packing, and",
		   "# the entries sorted (stably) by code length, as the decoder needs."]
	at, n = 0, 0
	while at < len(d):
		if len(d) - at < 12:
			raise ValueError("a table header cut short")
		size, count = struct.unpack(">HH", d[at:at + 4])
		head = struct.unpack(">4h", d[at + 4:at + 12])
		if size != 12 + 8 * count or at + size > len(d):
			raise ValueError("table %d: size %d for %d entries" % (n, size, count))
		use = "\t# fTables[%d]: %s" % (n, _TABLE_USE[n]) if n < len(_TABLE_USE) else ""
		out.append("")
		out.append("table %d%s" % (n, use))
		for name, v in zip(_HEADER, head):
			out.append("%s %d" % (name, v))
		lengths = []
		for i in range(count):
			value, length, code = struct.unpack(">hHI", d[at + 12 + 8 * i:at + 20 + 8 * i])
			if code >> length:
				raise ValueError("table %d entry %d: a code longer than its length" % (n, i))
			out.append("%d %s" % (value, _bits(code, length)))
			lengths.append(length)
		if lengths != sorted(lengths):
			raise ValueError("table %d is not in order of code length" % n)
		at += size
		n += 1
	return out


def _code_book_bytes(rows):
	tables = []
	for r in rows:
		if r[0] == "table":
			if int(r[1]) != len(tables):
				raise ValueError("table %s out of order" % r[1])
			tables.append([dict(), []])
		elif not tables:
			raise ValueError("%s before the first table" % " ".join(r))
		elif r[0] in _HEADER:
			tables[-1][0][r[0]] = int(r[1], 0)
		else:
			if len(r) != 2 or not re.fullmatch(r"[01]+|-", r[1]):
				raise ValueError("table %d: what is %s?" % (len(tables) - 1, " ".join(r)))
			bits = "" if r[1] == "-" else r[1]
			tables[-1][1].append((int(r[0], 0), bits))
	out = b""
	for n, (head, entries) in enumerate(tables):
		missing = [h for h in _HEADER if h not in head]
		if missing:
			raise ValueError("table %d has no %s" % (n, ", ".join(missing)))
		entries = sorted(entries, key=lambda e: len(e[1]))
		codes = {}
		for value, bits in entries:
			for k in range(1, len(bits) + 1):
				if bits[:k] in codes:
					raise ValueError("table %d: code %s (%d) begins with %s (%d), which the decoder takes first"
									 % (n, bits, value, bits[:k], codes[bits[:k]]))
			codes[bits] = value
		out += struct.pack(">HH4h", 12 + 8 * len(entries), len(entries), *(head[h] for h in _HEADER))
		for value, bits in entries:
			code = sum(1 << i for i, b in enumerate(bits) if b == "1")
			out += struct.pack(">hHI", value, len(bits), code)
	return out


# --- trigrams --------------------------------------------------------------------
#
# 32 x 32 x 32 two-bit entries: entry (a*32 + b)*32 + c is in byte i>>2,
# bits 2*(i&3) and up (the first entry in a byte's lowest bits).  Symbols
# 1-26 are a-z, 27 an apostrophe and 28 the edge of a word, which is
# what the trigrams that are set show (n't, 'll, 're, 've, 's, 'd, 'm;
# 28 before a word's first letters and after its last).  0 and 29-31
# are used by none and written <n> if one ever is.

_SYMBOLS = {i + 1: chr(ord("a") + i) for i in range(26)}
_SYMBOLS[27] = "'"
_SYMBOLS[28] = "_"
_SYMBOL_OF = {v: k for k, v in _SYMBOLS.items()}


def _sym(n: int) -> str:
	return _SYMBOLS.get(n, "<%d>" % n)


def _trigrams_text(d):
	if len(d) != 8192:
		raise ValueError("a trigram table is 8192 bytes, not %d" % len(d))
	out = ["format trigrams",
		   "# the 'Trigrams binary (Rtrig): a weight 1-3 for each sequence of three",
		   "# symbols - a-z, ' and _ (the edge of a word) - that has one; any not",
		   "# listed is nought.  Nothing in the ROM's code reads it (see",
		   "# tools/tables/README.md); what the weights mean is not known."]
	for i in range(32 * 32 * 32):
		w = (d[i >> 2] >> (2 * (i & 3))) & 3
		if w:
			out.append("%s%s%s %d" % (_sym(i >> 10), _sym((i >> 5) & 31), _sym(i & 31), w))
	return out


def _trigrams_bytes(rows):
	table = bytearray(8192)
	seen = set()
	for r in rows:
		syms = re.findall(r"<\d+>|.", r[0])
		if len(syms) != 3 or len(r) != 2:
			raise ValueError("what is %s?" % " ".join(r))
		idx = 0
		for s in syms:
			v = int(s[1:-1]) if s.startswith("<") else _SYMBOL_OF.get(s)
			if v is None or not 0 <= v < 32:
				raise ValueError("%s: %s is no symbol" % (r[0], s))
			idx = idx * 32 + v
		w = int(r[1], 0)
		if not 0 <= w <= 3:
			raise ValueError("%s: a weight is 0-3" % r[0])
		if idx in seen:
			raise ValueError("%s given twice" % r[0])
		seen.add(idx)
		table[idx >> 2] |= w << (2 * (idx & 3))
	return bytes(table)


# --- letter-images ---------------------------------------------------------------
#
# A word, the number of letters; each letter a byte (its character), a
# byte (its variant count) and a halfword per variant, the variant's
# offset in the binary; a variant a byte (its group), a byte (its stroke
# count) and a halfword per stroke, its offset; a stroke a byte (its
# point count) and an x byte and a y byte per point.  The ROM lays out
# the letters, then every variant, then every stroke, each in order -
# which is what packing does, so no offset need be written.

def _letter_images_text(d):
	n = struct.unpack(">I", d[:4])[0]
	out = ["format letter-images",
		   "# the Letter Shapes pictures (recognition/LetterShapes.h): each letter",
		   "# (its Mac Roman byte), its variants in order with their group (the",
		   "# variants the recogniser weighs together), and each variant's strokes",
		   "# as x,y points in a box 0-255 high, the letter's body between y 0x55",
		   "# and 0xaa.  Offsets and counts are worked out."]
	p = 4
	expect = None			# the layout packing makes, checked as we go
	items = []
	for _ in range(n):
		c, nv = d[p], d[p + 1]
		offs = struct.unpack(">%dH" % nv, d[p + 2:p + 2 + 2 * nv])
		items.append((c, offs))
		p += 2 + 2 * nv
	expect = p
	strokes = []
	for c, offs in items:
		out.append("")
		out.append("letter 0x%02x%s" % (c, _mac_comment(c)))
		for o in offs:
			if o != expect:
				raise ValueError("letter 0x%02x: a variant not where packing puts it" % c)
			g, ns = d[o], d[o + 1]
			expect += 2 + 2 * ns
			out.append("variant group %d" % g)
			for s in struct.unpack(">%dH" % ns, d[o + 2:o + 2 + 2 * ns]):
				strokes.append(s)
				np = d[s]
				pts = d[s + 1:s + 1 + 2 * np]
				if len(pts) != 2 * np:
					raise ValueError("a stroke runs off the end")
				out.append("stroke " + " ".join("%d,%d" % (pts[2 * k], pts[2 * k + 1]) for k in range(np)))
	for s in strokes:
		if s != expect:
			raise ValueError("a stroke not where packing puts it")
		expect += 1 + 2 * d[s]
	if expect != len(d):
		raise ValueError("%d bytes after the last stroke" % (len(d) - expect))
	return out


def _letter_images_bytes(rows):
	letters = []
	for r in rows:
		if r[0] == "letter":
			letters.append((int(r[1], 0), []))
		elif r[0] == "variant":
			if not letters or len(r) != 3 or r[1] != "group":
				raise ValueError("what is %s?" % " ".join(r))
			letters[-1][1].append((int(r[2], 0), []))
		elif r[0] == "stroke":
			if not letters or not letters[-1][1]:
				raise ValueError("a stroke outside a variant")
			pts = []
			for xy in r[1:]:
				x, y = (int(v, 0) for v in xy.split(","))
				if not (0 <= x <= 255 and 0 <= y <= 255):
					raise ValueError("a point %s outside 0-255" % xy)
				pts.append((x, y))
			letters[-1][1][-1][1].append(pts)
		else:
			raise ValueError("what is %s?" % " ".join(r))

	def byte(v, what):
		if not 0 <= v <= 255:
			raise ValueError("%s: %d does not fit a byte" % (what, v))
		return v

	head = 4 + sum(2 + 2 * len(vs) for _, vs in letters)
	at_v = head
	at_s = head + sum(2 + 2 * len(ss) for _, vs in letters for _, ss in vs)
	head_b, var_b, str_b = struct.pack(">I", len(letters)), b"", b""
	for c, vs in letters:
		head_b += bytes([byte(c, "a letter"), byte(len(vs), "letter 0x%02x's variants" % c)])
		for g, ss in vs:
			head_b += struct.pack(">H", at_v)
			var_b += bytes([byte(g, "a group"), byte(len(ss), "letter 0x%02x's strokes" % c)])
			at_v += 2 + 2 * len(ss)
			for pts in ss:
				if at_s > 0xffff:
					raise ValueError("the pictures have grown past 64KB, which a halfword offset cannot reach")
				var_b += struct.pack(">H", at_s)
				str_b += bytes([byte(len(pts), "a stroke's points")]) + b"".join(bytes(p) for p in pts)
				at_s += 1 + 2 * len(pts)
	return head_b + var_b + str_b


# --- the files ---------------------------------------------------------------------

_TEXT = {"code-book": _code_book_text, "trigrams": _trigrams_text, "letter-images": _letter_images_text}
_BYTES = {"code-book": _code_book_bytes, "trigrams": _trigrams_bytes, "letter-images": _letter_images_bytes}


def unpack(data: bytes, format: str, path: str) -> None:
	lines = _TEXT[format](data)
	with open(path, "w", encoding="utf-8", newline="\n") as f:
		f.write("\n".join(lines) + "\n")


def pack_lines(format: str, lines: list, base: str) -> bytes:
	return _BYTES[format](_rows(format, lines))


def file_format(lines: list) -> str:
	for line in lines:
		line = line.split("#", 1)[0].split()
		if line:
			if line[0] == "format" and len(line) == 2:
				return line[1]
			break
	raise ValueError("no format line")


def pack(path: str) -> bytes:
	with open(path, encoding="utf-8") as f:
		lines = f.read().split("\n")
	return pack_lines(file_format(lines), lines, os.path.dirname(os.path.abspath(path)))


def main(argv=None) -> int:
	argv = sys.argv[1:] if argv is None else argv
	if len(argv) == 4 and argv[0] == "unpack" and argv[1] in FORMATS:
		with open(argv[2], "rb") as f:
			unpack(f.read(), argv[1], argv[3])
		return 0
	if len(argv) == 3 and argv[0] == "pack":
		with open(argv[2], "wb") as f:
			f.write(pack(argv[1]))
		return 0
	if len(argv) >= 3 and argv[0] == "check" and argv[1] in FORMATS:
		import tempfile
		bad = 0
		with tempfile.TemporaryDirectory() as tmp:
			for p in argv[2:]:
				with open(p, "rb") as f:
					data = f.read()
				out = os.path.join(tmp, "t.txt")
				try:
					unpack(data, argv[1], out)
					same = pack(out) == data
				except ValueError as e:
					print("%s: %s" % (p, e))
					same = False
				print("%s: %s" % (os.path.basename(p), "the same" if same else "DIFFERS"))
				bad += not same
		return 1 if bad else 0
	print(__doc__)
	return 2


if __name__ == "__main__":
	sys.exit(main())
