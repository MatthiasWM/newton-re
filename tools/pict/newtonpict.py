#!/usr/bin/env python3
"""The Newton's QuickDraw pictures as editable text and PNG and back, byte
for byte.  Pure Python (stdlib, plus tools/imaging/png.py).

The ROM keeps some of its pictures as QuickDraw PICTs (class 'picture);
the ROM source tree (romsrc/) writes them as `pict('picture, "X.pict")`,
512 bytes of nought then the picture.  This turns a picture - the data
after those 512 bytes - into a directory a person can edit with a text
editor and a paint program, and packs it back to the same bytes.  How the
Newton plays a picture is src/qd/PicPlay.cpp.

    python tools/pict/newtonpict.py unpack X.pict DIR
        writes DIR/: picture.txt (the opcodes, one to a line) and a PNG per
        bitmap opcode (bits1.png, ...); then packs DIR again and refuses
        (exit 1) unless that gives back X.pict's picture exactly.
    python tools/pict/newtonpict.py pack DIR X.pict
        builds the picture from DIR (with the 512-byte header).
    python tools/pict/newtonpict.py check X.pict...
        whether each picture round-trips through the text form, and what
        (if anything) had to be kept as raw bytes.

A .pict file given on the command line may have the 512-byte header or
not (a file whose first 512 bytes are all nought is taken to have it).

picture.txt (tools/pict/README.md has the details): `#` starts a comment;
rectangles are `top left bottom right`, points `v h`.  It starts with
`picSize` (`auto`: the low 16 bits of the picture's length) and `picFrame`,
then one line per opcode by Apple's name (`version 1` or `version 2`
first), e.g. `Clip 0 0 264 352`, `ShortComment 130`, `ShortLine 10 0 6 -3`.
A bitmap opcode (BitsRect, BitsRgn, PackBitsRect, PackBitsRgn) names its
PNG and is followed by its fields, indented: `rowBytes` (`auto`: the
bounds' width rounded up to an even number of bytes), `bounds`, `srcRect`,
`dstRect`, `mode`, `maskRgn` (the Rgn opcodes), and for PackBits the
`packing` - which packer made the rows: `classic` (Apple's PackBits:
runs of three bytes or more are repeated, and a row's last two bytes too
when they are equal), `runs3` (runs of three or more only) or `none`
(every row one literal run).  A row the packer does not reproduce is kept
as `packed ROW HEX`, a row's padding bits past the bounds' width as
`padding ROW HEX` (when not nought).  `pad 0xNN` is a version 2 picture's
alignment byte when it is not nought; `data HEX` is bytes copied as they
are (an opcode this does not decode, and all after it).

As a module: unpack(data, dir) -> None, pack(dir) -> bytes,
roundtrips(data) -> (bool, list of what was kept raw).
"""

from __future__ import annotations

import os
import shutil
import struct
import sys
import tempfile

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "imaging"))
import png							# noqa: E402

PICT_HEADER = 512					# a PICT file's header: nought, before the picture
TEXT = "picture.txt"


class PictError(Exception):
	pass


# ---------------------------------------------------------------------------
# names

MODES = ["srcCopy", "srcOr", "srcXor", "srcBic", "notSrcCopy", "notSrcOr", "notSrcXor", "notSrcBic",
		 "patCopy", "patOr", "patXor", "patBic", "notPatCopy", "notPatOr", "notPatXor", "notPatBic"]
MODE_EXTRA = {32: "blend", 33: "addPin", 34: "addOver", 35: "subPin", 36: "transparent",
			  37: "addMax", 38: "subOver", 39: "adMin", 49: "grayishTextOr", 50: "hilite", 64: "ditherCopy"}
MODE_NAMES = dict(enumerate(MODES))
MODE_NAMES.update(MODE_EXTRA)
MODE_VALUES = {v: k for k, v in MODE_NAMES.items()}

# picture comment kinds (Inside Macintosh: Imaging With QuickDraw, appendix B)
COMMENTS = {
	130: "picDwgBeg", 131: "picDwgEnd", 140: "picGrpBeg", 141: "picGrpEnd",
	142: "picBitBeg", 143: "picBitEnd", 150: "TextBegin", 151: "TextEnd",
	152: "StringBegin", 153: "StringEnd", 154: "TextCenter", 155: "LineLayoutOff",
	156: "LineLayoutOn", 157: "ClientLineLayout", 160: "PolyBegin", 161: "PolyEnd",
	163: "PolyIgnore", 164: "PolySmooth", 165: "PolyClose", 180: "DashedLine",
	181: "DashedStop", 182: "SetLineWidth", 190: "PostScriptBegin", 191: "PostScriptEnd",
	192: "PostScriptHandle", 193: "PostScriptFile", 194: "TextIsPostScript",
	195: "ResourcePS", 196: "PSBeginNoSave", 200: "RotateBegin", 201: "RotateEnd",
	202: "RotateCenter", 210: "FormsPrinting", 211: "EndFormsPrinting",
}
COMMENT_VALUES = {v: k for k, v in COMMENTS.items()}

# opcode -> (name, operand kinds, comment).  Kinds: rect (top left bottom
# right), pt (v h), i8/u8/i16/u16/i32 numbers, fixed (16.16), mode (a
# transfer mode by name), pat (8 bytes in hex), rgb (three words), pstr (a
# quoted string), rgn (size + rect + more, the size worked out), poly
# (size + bounding rect + points), kind (a comment kind), cdata (a long
# comment's size and data, as hex).
OPS = {
	0x00: ("NOP", [], ""),
	0x01: ("Clip", ["rgn"], "the clip region: its rect, then any more of it in hex"),
	0x02: ("BkPat", ["pat"], ""),
	0x03: ("TxFont", ["i16"], ""),
	0x04: ("TxFace", ["u8"], ""),
	0x05: ("TxMode", ["mode"], ""),
	0x06: ("SpExtra", ["fixed"], ""),
	0x07: ("PnSize", ["pt"], "v h"),
	0x08: ("PnMode", ["mode"], ""),
	0x09: ("PnPat", ["pat"], ""),
	0x0a: ("FillPat", ["pat"], ""),
	0x0b: ("OvSize", ["pt"], "v h"),
	0x0c: ("Origin", ["i16", "i16"], "dh dv"),
	0x0d: ("TxSize", ["i16"], ""),
	0x0e: ("FgColor", ["i32"], ""),
	0x0f: ("BkColor", ["i32"], ""),
	0x10: ("TxRatio", ["pt", "pt"], "numerator v h, denominator v h"),
	0x15: ("PnLocHFrac", ["u16"], ""),
	0x16: ("ChExtra", ["i16"], ""),
	0x1a: ("RGBFgCol", ["rgb"], ""),
	0x1b: ("RGBBkCol", ["rgb"], ""),
	0x1c: ("HiliteMode", [], ""),
	0x1d: ("HiliteColor", ["rgb"], ""),
	0x1e: ("DefHilite", [], ""),
	0x1f: ("OpColor", ["rgb"], ""),
	0x20: ("Line", ["pt", "pt"], "from v h to v h"),
	0x21: ("LineFrom", ["pt"], "to v h"),
	0x22: ("ShortLine", ["pt", "i8", "i8"], "from v h, by dh dv"),
	0x23: ("ShortLineFrom", ["i8", "i8"], "by dh dv"),
	0x28: ("LongText", ["pt", "pstr"], "at v h"),
	0x29: ("DHText", ["u8", "pstr"], "dh"),
	0x2a: ("DVText", ["u8", "pstr"], "dv"),
	0x2b: ("DHDVText", ["u8", "u8", "pstr"], "dh dv"),
	0xa0: ("ShortComment", ["kind"], ""),
	0xa1: ("LongComment", ["kind", "cdata"], "kind, data in hex (- for none)"),
	0xff: ("OpEndPic", [], ""),
	0x0c00: ("HeaderOp", ["i32", "fixed", "fixed", "fixed", "fixed", "i32"],
			 "version (-1), the frame at 72 dpi as 16.16 left top right bottom, reserved"),
}
_VERBS = ["frame", "paint", "erase", "invert", "fill"]
for _i, _v in enumerate(_VERBS):
	OPS[0x30 + _i] = (_v + "Rect", ["rect"], "")
	OPS[0x38 + _i] = (_v + "SameRect", [], "")
	OPS[0x40 + _i] = (_v + "RRect", ["rect"], "")
	OPS[0x48 + _i] = (_v + "SameRRect", [], "")
	OPS[0x50 + _i] = (_v + "Oval", ["rect"], "")
	OPS[0x58 + _i] = (_v + "SameOval", [], "")
	OPS[0x60 + _i] = (_v + "Arc", ["rect", "i16", "i16"], "rect, start angle, arc angle")
	OPS[0x68 + _i] = (_v + "SameArc", ["i16", "i16"], "start angle, arc angle")
	OPS[0x70 + _i] = (_v + "Poly", ["poly"], "bounding rect, then the points v h")
	OPS[0x78 + _i] = (_v + "SamePoly", [], "")
	OPS[0x80 + _i] = (_v + "Rgn", ["rgn"], "the region's rect, then any more of it in hex")
	OPS[0x88 + _i] = (_v + "SameRgn", [], "")

BITS = {0x90: "BitsRect", 0x91: "BitsRgn", 0x98: "PackBitsRect", 0x99: "PackBitsRgn"}
OP_BY_NAME = {v[0]: k for k, v in OPS.items()}
BITS_BY_NAME = {v: k for k, v in BITS.items()}


# ---------------------------------------------------------------------------
# PackBits

def unpack_bits(data: bytes, pos: int, size: int):
	"""Unpack `size` bytes from data[pos:] -> (bytes, position after)."""
	out = bytearray()
	while len(out) < size:
		if pos >= len(data):
			raise PictError("PackBits data runs past the end")
		n = data[pos]
		pos += 1
		if n < 128:
			out += data[pos:pos + n + 1]
			pos += n + 1
		elif n > 128:
			out += bytes([data[pos]]) * (257 - n)
			pos += 1
	if len(out) != size:
		raise PictError("a PackBits run crosses the end of a row")
	return bytes(out), pos


def pack_bits(row: bytes, packing: str) -> bytes:
	"""PackBits as the packer `packing` does it (module docstring)."""
	out = bytearray()
	if packing == "none":
		for i in range(0, len(row), 128):
			chunk = row[i:i + 128]
			out.append(len(chunk) - 1)
			out += chunk
		return bytes(out)
	if packing not in ("classic", "runs3"):
		raise PictError("unknown packing %r (classic, runs3 or none)" % packing)
	lit = bytearray()
	n = len(row)
	i = 0
	while i < n:
		r = 1
		while i + r < n and row[i + r] == row[i] and r < 128:
			r += 1
		if r >= 3 or (packing == "classic" and r == 2 and i + 2 == n):
			if lit:
				out.append(len(lit) - 1)
				out += lit
				lit.clear()
			out.append(257 - r)
			out.append(row[i])
			i += r
		else:
			lit.append(row[i])
			i += 1
			if len(lit) == 128:
				out.append(127)
				out += lit
				lit.clear()
	if lit:
		out.append(len(lit) - 1)
		out += lit
	return bytes(out)


PACKINGS = ["classic", "runs3", "none"]


# ---------------------------------------------------------------------------
# reading a picture

class Reader:
	def __init__(self, data: bytes, pos: int):
		self.data = data
		self.pos = pos

	def take(self, n: int) -> bytes:
		if self.pos + n > len(self.data):
			raise PictError("the picture ends inside an opcode")
		b = self.data[self.pos:self.pos + n]
		self.pos += n
		return b

	def u8(self):
		return self.take(1)[0]

	def i8(self):
		return struct.unpack(">b", self.take(1))[0]

	def u16(self):
		return struct.unpack(">H", self.take(2))[0]

	def i16(self):
		return struct.unpack(">h", self.take(2))[0]

	def i32(self):
		return struct.unpack(">i", self.take(4))[0]

	def rect(self):
		return list(struct.unpack(">4h", self.take(8)))


def read_operand(r: Reader, kind: str):
	if kind in ("u8", "i8", "u16", "i16", "i32"):
		return [getattr(r, kind)()]
	if kind == "fixed":
		return [r.i32()]
	if kind in ("mode", "kind"):
		return [r.u16()]
	if kind == "rect":
		return r.rect()
	if kind == "pt":
		return [r.i16(), r.i16()]
	if kind == "pat":
		return [r.take(8)]
	if kind == "rgb":
		return [r.u16(), r.u16(), r.u16()]
	if kind == "pstr":
		return [r.take(r.u8())]
	if kind in ("rgn", "poly"):
		size = r.u16()
		if size < 10:
			raise PictError("a region or polygon of %d bytes" % size)
		box = r.rect()
		rest = r.take(size - 10)
		if kind == "poly":
			if len(rest) % 4:
				raise PictError("a polygon with half a point")
			return [box, list(struct.unpack(">%dh" % (len(rest) // 2), rest))]
		return [box, rest]
	if kind == "cdata":
		return [r.take(r.u16())]
	raise AssertionError(kind)


def read_bits(r: Reader, opcode: int, v2: bool):
	"""A bitmap opcode's fields and rows (as unpacked rows and how each was
	stored).  Raises PictError for what this does not decode (pixel maps)."""
	word = r.u16()
	if word & 0x8000:
		raise PictError("a pixel map (not decoded)")
	rb = word
	bounds = r.rect()
	src = r.rect()
	dst = r.rect()
	mode = r.u16()
	mask = None
	if opcode in (0x91, 0x99):
		mask = read_operand(r, "rgn")
	height = bounds[2] - bounds[0]
	width = bounds[3] - bounds[1]
	if height < 0 or width < 0 or width > rb * 8:
		raise PictError("bounds %r do not fit rowBytes %d" % (bounds, rb))
	packed = opcode in (0x98, 0x99) and rb >= 8
	rows = []
	stored = []
	for _ in range(height):
		if packed:
			n = r.u16() if rb > 250 else r.u8()
			pk = r.take(n)
			row, end = unpack_bits(pk, 0, rb)
			if end != n:
				raise PictError("a packed row's count is not its runs'")
			stored.append(pk)
		else:
			row = r.take(rb)
		rows.append(row)
	return dict(opcode=opcode, rowBytes=rb, bounds=bounds, srcRect=src, dstRect=dst,
				mode=mode, mask=mask, rows=rows, stored=stored if packed else None)


def parse(data: bytes):
	"""-> (picSize, picFrame, version, items).  Items: ('op', opcode,
	values, pad), ('bits', fields, pad), ('data', bytes)."""
	if len(data) < 12:
		raise PictError("too short for a picture")
	size, = struct.unpack(">H", data[:2])
	frame = list(struct.unpack(">4h", data[2:10]))
	if data[10:12] == b"\x11\x01":
		v2 = False
		version = 1
		pos = 12
	elif data[10:14] == b"\x00\x11\x02\xff":
		v2 = True
		version = 2
		pos = 14
	else:
		raise PictError("neither a version 1 (0x1101) nor a version 2 (0x001102ff) picture")
	items = []
	r = Reader(data, pos)
	while r.pos < len(data):
		start = r.pos
		try:
			if v2:
				opcode = r.u16()
			else:
				opcode = r.u8()
			if opcode in BITS:
				item = ["bits", read_bits(r, opcode, v2), None]
			elif opcode in OPS and (v2 or opcode < 0x100):
				values = []
				for kind in OPS[opcode][1]:
					values += read_operand(r, kind)
				item = ["op", opcode, values, None]
			else:
				raise PictError("opcode 0x%x not decoded" % opcode)
			if v2 and (r.pos & 1):
				item[-1] = r.u8()
		except PictError as e:
			items.append(("data", data[start:], str(e)))
			r.pos = len(data)
			break
		items.append(tuple(item))
		if item[0] == "op" and item[1] == 0xff:
			break
	if r.pos < len(data):
		items.append(("data", data[r.pos:], "after OpEndPic"))
	return size, frame, version, items


# ---------------------------------------------------------------------------
# text

def fixed_text(v: int) -> str:
	if v % 65536 == 0:
		return str(v >> 16)
	return repr(v / 65536.0)


def fixed_value(t: str) -> int:
	if t.lower().startswith(("0x", "-0x")):
		return int(t, 16)
	return int(round(float(t) * 65536))


def quote(b: bytes) -> str:
	out = ['"']
	for c in b:
		if c in (0x22, 0x5c):
			out.append("\\" + chr(c))
		elif 0x20 <= c < 0x7f:
			out.append(chr(c))
		else:
			out.append("\\x%02x" % c)
	out.append('"')
	return "".join(out)


def unquote(t: str) -> bytes:
	if len(t) < 2 or t[0] != '"' or t[-1] != '"':
		raise PictError("expected a quoted string, not %s" % t)
	out = bytearray()
	s = t[1:-1]
	i = 0
	while i < len(s):
		c = s[i]
		if c == "\\":
			if s[i + 1] == "x":
				out.append(int(s[i + 2:i + 4], 16))
				i += 4
				continue
			out.append(ord(s[i + 1]))
			i += 2
			continue
		out += c.encode("latin-1")
		i += 1
	return bytes(out)


def tokens(line: str):
	"""A line's tokens, `#` to the end of the line a comment (not inside a
	quoted string)."""
	out = []
	i = 0
	n = len(line)
	while i < n:
		c = line[i]
		if c.isspace():
			i += 1
		elif c == "#":
			break
		elif c == '"':
			j = i + 1
			while j < n and line[j] != '"':
				j += 2 if line[j] == "\\" else 1
			out.append(line[i:j + 1])
			i = j + 1
		else:
			j = i
			while j < n and not line[j].isspace() and line[j] != "#":
				j += 1
			out.append(line[i:j])
			i = j
	return out


def operand_text(kind: str, values: list):
	"""-> (tokens, values used)."""
	v = values[0]
	if kind in ("u8", "i8", "u16", "i16", "i32"):
		return [str(v)], 1
	if kind == "fixed":
		return [fixed_text(v)], 1
	if kind == "mode":
		return [MODE_NAMES.get(v, str(v))], 1
	if kind == "kind":
		return [str(v)], 1
	if kind == "rect":
		return [str(x) for x in values[:4]], 4
	if kind == "pt":
		return [str(x) for x in values[:2]], 2
	if kind == "pat":
		return [v.hex()], 1
	if kind == "rgb":
		return ["0x%04x" % x for x in values[:3]], 3
	if kind == "pstr":
		return [quote(v)], 1
	if kind == "rgn":
		return [str(x) for x in v] + ([values[1].hex()] if values[1] else []), 2
	if kind == "poly":
		return [str(x) for x in v] + [str(x) for x in values[1]], 2
	if kind == "cdata":
		return [v.hex() if v else "-"], 1
	raise AssertionError(kind)


def number(t: str) -> int:
	return int(t, 0)


def operand_values(kind: str, toks: list, last: bool):
	"""-> (values, tokens used)."""
	def need(k):
		if len(toks) < k:
			raise PictError("too few operands")
	if kind in ("u8", "i8", "u16", "i16", "i32"):
		need(1)
		return [number(toks[0])], 1
	if kind == "fixed":
		need(1)
		return [fixed_value(toks[0])], 1
	if kind == "mode":
		need(1)
		return [MODE_VALUES[toks[0]] if toks[0] in MODE_VALUES else number(toks[0])], 1
	if kind == "kind":
		need(1)
		return [COMMENT_VALUES[toks[0]] if toks[0] in COMMENT_VALUES else number(toks[0])], 1
	if kind == "rect":
		need(4)
		return [number(t) for t in toks[:4]], 4
	if kind == "pt":
		need(2)
		return [number(t) for t in toks[:2]], 2
	if kind == "pat":
		need(1)
		b = bytes.fromhex(toks[0])
		if len(b) != 8:
			raise PictError("a pattern is 8 bytes (16 hex digits)")
		return [b], 1
	if kind == "rgb":
		need(3)
		return [number(t) for t in toks[:3]], 3
	if kind == "pstr":
		need(1)
		return [unquote(toks[0])], 1
	if kind in ("rgn", "poly", "cdata"):
		if not last:
			raise AssertionError(kind)
		if kind == "cdata":
			need(1)
			return [b"" if toks[0] == "-" else bytes.fromhex("".join(toks))], len(toks)
		need(4)
		box = [number(t) for t in toks[:4]]
		if kind == "rgn":
			return [box, bytes.fromhex("".join(toks[4:]))], len(toks)
		pts = [number(t) for t in toks[4:]]
		if len(pts) % 2:
			raise PictError("a polygon's points come in pairs (v h)")
		return [box, pts], len(toks)
	raise AssertionError(kind)


def rect_text(r):
	return " ".join(str(x) for x in r)


def standard_rowbytes(width: int) -> int:
	return (width + 15) // 16 * 2


def bits_lines(f: dict, png_name: str, raw_notes: list):
	"""A bitmap opcode's lines, and its PNG's levels; notes what was kept
	raw."""
	b = f["bounds"]
	width = b[3] - b[1]
	height = b[2] - b[0]
	rb = f["rowBytes"]
	lines = ["%s %s\t\t# %d x %d pixels, black a set bit" % (BITS[f["opcode"]], png_name, width, height)]
	if rb == standard_rowbytes(width):
		lines.append("\trowBytes auto\t\t# %d: the width in bytes, rounded up to even" % rb)
	else:
		lines.append("\trowBytes %d\t\t# (auto would be %d)" % (rb, standard_rowbytes(width)))
	lines.append("\tbounds %s\t# top left bottom right: the PNG's size" % rect_text(b))
	lines.append("\tsrcRect %s" % rect_text(f["srcRect"]))
	lines.append("\tdstRect %s" % rect_text(f["dstRect"]))
	lines.append("\tmode %s" % MODE_NAMES.get(f["mode"], str(f["mode"])))
	if f["mask"] is not None:
		lines.append("\tmaskRgn %s" % " ".join(operand_text("rgn", f["mask"])[0]))
	if f["stored"] is not None:
		best = None
		for packing in PACKINGS:
			misses = [y for y, row in enumerate(f["rows"]) if pack_bits(row, packing) != f["stored"][y]]
			if best is None or len(misses) < len(best[1]):
				best = (packing, misses)
		packing, misses = best
		lines.append("\tpacking %s\t\t# %s" % (packing, {
			"classic": "Apple's PackBits: runs of 3+ bytes, and a row's last two if equal",
			"runs3": "runs of 3+ bytes only",
			"none": "each row one literal run"}[packing]))
		for y in misses:
			lines.append("\tpacked %d %s\t# not the packer's" % (y, f["stored"][y].hex()))
			raw_notes.append("%s row %d packed" % (png_name, y))
	levels = []
	for y, row in enumerate(f["rows"]):
		bits = [(row[x >> 3] >> (7 - (x & 7))) & 1 for x in range(width)]
		levels.append([1 - bit for bit in bits])
		pad = bytearray(row)
		for x in range(width):
			pad[x >> 3] &= ~(0x80 >> (x & 7)) & 0xff
		if any(pad):
			lines.append("\tpadding %d %s\t# the bits past the bounds' width" % (y, bytes(pad).hex()))
			raw_notes.append("%s row %d padding" % (png_name, y))
	return lines, width, height, levels


def unpack(data: bytes, path: str) -> None:
	"""Write the picture `data` (without the 512-byte PICT header) as the
	directory `path` (made afresh)."""
	unpack_notes(data, path)


def unpack_notes(data: bytes, path: str) -> list:
	size, frame, version, items = parse(data)
	if os.path.isdir(path):
		shutil.rmtree(path)
	os.makedirs(path)
	notes = []
	lines = [
		"# A QuickDraw picture as text: tools/pict/newtonpict.py (tools/pict/README.md).",
		"# Rects are top left bottom right, points v h; `#` starts a comment.",
	]
	if size == len(data) & 0xffff:
		lines.append("picSize auto\t\t# 0x%04x: the picture's length, low 16 bits" % size)
	else:
		lines.append("picSize %d\t\t# (auto would be %d)" % (size, len(data) & 0xffff))
		notes.append("picSize")
	lines.append("picFrame %s" % rect_text(frame))
	lines.append("version %d" % version)
	nbits = 0
	for item in items:
		if item[0] == "data":
			lines.append("data %s\t# %s" % (item[1].hex(), item[2]))
			notes.append("data: " + item[2])
			continue
		if item[0] == "bits":
			nbits += 1
			name = "bits%d.png" % nbits
			blines, width, height, levels = bits_lines(item[1], name, notes)
			lines += blines
			png.write_gray(os.path.join(path, name), width, height, levels, 1)
		else:
			_, opcode, values, _ = item
			name, kinds, comment = OPS[opcode]
			toks = []
			rest = values
			for kind in kinds:
				t, used = operand_text(kind, rest)
				toks += t
				rest = rest[used:]
			line = " ".join([name] + toks)
			if opcode in (0xa0, 0xa1) and values[0] in COMMENTS:
				comment = COMMENTS[values[0]] + (": " + comment if comment else "")
			if comment:
				line += "\t\t# " + comment
			lines.append(line)
		if item[-1]:
			lines.append("pad 0x%02x\t\t# the alignment byte" % item[-1])
			notes.append("pad")
	with open(os.path.join(path, TEXT), "w", encoding="utf-8", newline="\n") as f:
		f.write("\n".join(lines) + "\n")
	return notes


# ---------------------------------------------------------------------------
# packing

def bits_bytes(f: dict, path: str, v2: bool) -> bytes:
	name = f["png"]
	for key in ("bounds", "srcRect", "dstRect", "mode"):
		if key not in f:
			raise PictError("%s: no %s" % (name, key))
	b = f["bounds"]
	width = b[3] - b[1]
	height = b[2] - b[0]
	pw, ph, levels = png.read_gray(os.path.join(path, name), 1)
	if (pw, ph) != (width, height):
		raise PictError("%s is %d x %d pixels but its bounds %s make %d x %d: set bounds to "
						"%d %d %d %d (and srcRect, dstRect, Clip, picFrame and HeaderOp to suit)"
						% (name, pw, ph, rect_text(b), width, height,
						   b[0], b[1], b[0] + ph, b[1] + pw))
	rb = f.get("rowBytes", "auto")
	rb = standard_rowbytes(width) if rb == "auto" else number(rb)
	if rb * 8 < width:
		raise PictError("%s: rowBytes %d is too few for %d pixels (auto gives %d)" % (name, rb, width, standard_rowbytes(width)))
	opcode = f["opcode"]
	out = bytearray()
	out += struct.pack(">H4h4h4hH", rb, *b, *f["srcRect"], *f["dstRect"], f["mode"])
	if opcode in (0x91, 0x99):
		if "maskRgn" not in f:
			raise PictError("%s: a Rgn opcode needs a maskRgn" % name)
		box, rest = f["maskRgn"]
		out += struct.pack(">H4h", 10 + len(rest), *box) + rest
	elif "maskRgn" in f:
		raise PictError("%s: only BitsRgn and PackBitsRgn have a maskRgn" % name)
	packed = opcode in (0x98, 0x99) and rb >= 8
	for y in range(height):
		row = bytearray(rb)
		for x, level in enumerate(levels[y]):
			if level == 0:
				row[x >> 3] |= 0x80 >> (x & 7)
		pad = f["padding"].get(y)
		if pad is not None:
			if len(pad) != rb:
				raise PictError("%s: padding %d is not %d bytes" % (name, y, rb))
			for i in range(rb):
				row[i] |= pad[i]
		row = bytes(row)
		if not packed:
			out += row
			continue
		pk = f["packed"].get(y)
		if pk is not None:
			try:
				back, end = unpack_bits(pk, 0, rb)
			except PictError:
				back, end = None, 0
			if back != row or end != len(pk):
				pk = None				# the row was edited: pack it afresh
		if pk is None:
			pk = pack_bits(row, f.get("packing", "classic"))
		out += struct.pack(">H", len(pk)) if rb > 250 else bytes([len(pk)])
		out += pk
	return bytes(out)


def pack(path: str) -> bytes:
	"""The picture (without the 512-byte PICT header) from the directory
	`path`."""
	with open(os.path.join(path, TEXT), encoding="utf-8") as fh:
		text = fh.read()
	size = "auto"
	frame = None
	v2 = None
	body = bytearray()
	bits = None
	padded = [None]						# where the last alignment byte went

	def flush_bits():
		nonlocal bits
		if bits is not None:
			op = bits["opcode"]
			body.extend(struct.pack(">H", op) if v2 else bytes([op]))
			try:
				body.extend(bits_bytes(bits, path, v2))
			except (PictError, ValueError, OSError) as e:
				raise PictError("%s line %d: %s" % (os.path.join(path, TEXT), bits["line"], e)) from None
			align()
			bits = None

	def align():
		padded[0] = None
		if v2 and (len(body) & 1):
			padded[0] = len(body)
			body.append(0)

	for lineno, line in enumerate(text.splitlines(), 1):
		toks = tokens(line)
		if not toks:
			continue
		word, args = toks[0], toks[1:]
		try:
			if bits is not None and word in ("rowBytes", "bounds", "srcRect", "dstRect", "mode",
											 "maskRgn", "packing", "packed", "padding"):
				if word == "rowBytes" or word == "packing":
					bits[word] = args[0]
				elif word == "mode":
					bits[word] = operand_values("mode", args, True)[0][0]
				elif word == "maskRgn":
					bits[word] = operand_values("rgn", args, True)[0]
				elif word in ("packed", "padding"):
					bits[word][number(args[0])] = bytes.fromhex("".join(args[1:]))
				else:
					bits[word] = operand_values("rect", args, True)[0]
				continue
			flush_bits()
			if word == "picSize":
				size = args[0]
			elif word == "picFrame":
				frame = operand_values("rect", args, True)[0]
			elif word == "version":
				if v2 is not None:
					raise PictError("a second version line")
				v2 = number(args[0]) == 2
				body.extend(b"\x00\x11\x02\xff" if v2 else b"\x11\x01")
			elif v2 is None:
				raise PictError("%s before the version line" % word)
			elif word == "pad":
				if padded[0] != len(body) - 1:
					raise PictError("a pad byte where the opcode before ends aligned")
				body[-1] = number(args[0])
				padded[0] = None
			elif word == "data":
				body.extend(bytes.fromhex("".join(args)))
			elif word in BITS_BY_NAME:
				bits = dict(opcode=BITS_BY_NAME[word], png=args[0], packed={}, padding={}, line=lineno)
			elif word in OP_BY_NAME:
				opcode = OP_BY_NAME[word]
				if not v2 and opcode > 0xff:
					raise PictError("%s is a version 2 opcode" % word)
				kinds = OPS[opcode][1]
				out = bytearray(struct.pack(">H", opcode) if v2 else bytes([opcode]))
				rest = args
				for i, kind in enumerate(kinds):
					values, used = operand_values(kind, rest, i == len(kinds) - 1)
					rest = rest[used:]
					out += operand_bytes(kind, values)
				if rest:
					raise PictError("too many operands")
				body.extend(out)
				align()
			else:
				raise PictError("unknown opcode or field %r" % word)
		except PictError as e:
			if str(e).startswith(os.path.join(path, TEXT)):
				raise
			raise PictError("%s line %d: %s" % (os.path.join(path, TEXT), lineno, e)) from None
		except (ValueError, IndexError, KeyError, struct.error) as e:
			raise PictError("%s line %d: %s" % (os.path.join(path, TEXT), lineno, e)) from None
	flush_bits()
	if frame is None or v2 is None:
		raise PictError("%s: no picFrame or no version" % os.path.join(path, TEXT))
	total = 10 + len(body)
	head = struct.pack(">H4h", (total & 0xffff) if size == "auto" else number(size), *frame)
	return head + bytes(body)


def operand_bytes(kind: str, values: list) -> bytes:
	v = values[0]
	if kind == "u8":
		return struct.pack(">B", v)
	if kind == "i8":
		return struct.pack(">b", v)
	if kind in ("u16", "mode", "kind"):
		return struct.pack(">H", v)
	if kind == "i16":
		return struct.pack(">h", v)
	if kind in ("i32", "fixed"):
		return struct.pack(">i", v)
	if kind == "rect":
		return struct.pack(">4h", *values)
	if kind == "pt":
		return struct.pack(">2h", *values)
	if kind == "pat":
		return v
	if kind == "rgb":
		return struct.pack(">3H", *values)
	if kind == "pstr":
		if len(v) > 255:
			raise PictError("a string of more than 255 bytes")
		return bytes([len(v)]) + v
	if kind == "rgn":
		return struct.pack(">H4h", 10 + len(values[1]), *v) + values[1]
	if kind == "poly":
		pts = values[1]
		return struct.pack(">H4h%dh" % len(pts), 10 + 2 * len(pts), *v, *pts)
	if kind == "cdata":
		return struct.pack(">H", len(v)) + v
	raise AssertionError(kind)


# ---------------------------------------------------------------------------

def roundtrips(data: bytes, work: str = None):
	"""Whether the picture comes back byte for byte through the text form,
	and what was kept raw (rows' packed bytes, padding, data)."""
	tmp = tempfile.mkdtemp(dir=work)
	try:
		d = os.path.join(tmp, "pict")
		notes = unpack_notes(data, d)
		return pack(d) == data, notes
	finally:
		shutil.rmtree(tmp, ignore_errors=True)


def read_pict(path: str) -> bytes:
	"""A .pict file's picture: without its 512-byte header if it has one."""
	with open(path, "rb") as f:
		data = f.read()
	if len(data) > PICT_HEADER and not any(data[:PICT_HEADER]):
		return data[PICT_HEADER:]
	return data


def main(argv=None):
	argv = sys.argv[1:] if argv is None else argv
	try:
		if len(argv) == 3 and argv[0] == "unpack":
			data = read_pict(argv[1])
			notes = unpack_notes(data, argv[2])
			if pack(argv[2]) != data:
				print("%s: the text form does not give the picture back byte for byte" % argv[1], file=sys.stderr)
				return 1
			print("%s -> %s%s" % (argv[1], argv[2], (" (raw: %s)" % ", ".join(notes)) if notes else ""))
			return 0
		if len(argv) == 3 and argv[0] == "pack":
			data = pack(argv[1])
			with open(argv[2], "wb") as f:
				f.write(bytes(PICT_HEADER) + data)
			print("%s -> %s, %d bytes" % (argv[1], argv[2], PICT_HEADER + len(data)))
			return 0
		if len(argv) >= 2 and argv[0] == "check":
			bad = 0
			for path in argv[1:]:
				ok, notes = roundtrips(read_pict(path))
				bad += not ok
				print("%s: %s%s" % (path, "identical" if ok else "DIFFERS",
									(" (raw: %s)" % ", ".join(notes)) if notes else ""))
			return 1 if bad else 0
	except PictError as e:
		print("error: %s" % e, file=sys.stderr)
		return 1
	print(__doc__, file=sys.stderr)
	return 2


if __name__ == "__main__":
	sys.exit(main())
