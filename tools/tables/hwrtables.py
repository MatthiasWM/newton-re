#!/usr/bin/env python3
"""The cursive recogniser's letter table, rules and trigrams as text, and back.

ParaGraph's cursive ("xr") recogniser keeps its trained data in four
binaries of the `charsetInfoResources` frame (recognition/ParaGraph.h),
which romsrc/ kept as raw binaries.  Each has a text form whose first line
after any comments is `format <kind>`; `#` starts a comment.  Packing makes
the binary's bytes out of it - the ROM's own bytes for every committed
file:

  dte-header    DTEHeader ('DTEH, 216 bytes): the letter table's header,
                which ReadDteResource copies into the engine's DTIHeader -
                the names in its first 0x8c bytes (`text`) and the
                pointer words after them, which the resource ships holding
                the build machine's stale addresses (`word fName`).
  dte-main      DTEMain ('DTEM): the symbol descriptors - for each of the
                engine's character codes (`symbol`) its variants (`variant
                a.0`: default vex, group, letter-set styles, may it be a
                capital, position and size nibbles) and each variant's
                prototype xrs (`xrp a.0.3`: the xr it stands for, its flags
                and skip penalty, and its nibble tables for the xr types,
                heights, shifts, links and directions).  The offset table,
                variant counts and prototype counts are worked out.
  ppd-main      PPDMain ('PPDB): the prototype data ("PDF") - the
                post-processing rules (recognition/XrRules.cpp): for each
                letter, variant and neighbouring letter's variant, a rule
                of up to five queues of stack-machine code, each with its
                weight (`queue a.0 b.2 -3 : xr 1 top ; xr 2 top ; sub`); the
                constants they push.  Every header, bit set, offset, size,
                count and weight index is worked out.
  dte-trigrams  DTETrigrams ('Trigram): a two-bit weight for every sequence
                of three of the cursive reader's 40 letter classes (read by
                Xrlv.cpp; the reader's penalty is 5 less the weight); a
                line a trigram whose weight is not nought ("the 3").

Usage:
    hwrtables.py unpack FORMAT TABLE.bin OUT.txt
    hwrtables.py pack TABLE.txt OUT.bin
    hwrtables.py check FORMAT TABLE.bin...     (unpacked and packed back: the same?)

As a module: `unpack(data, format, path)`; `pack_lines(format, lines,
base=None)` -> bytes, `lines` the text split on "\\n" (the format line
included; `base`, the text's directory, is not needed by these formats);
`pack(path)` reads the file and does the same.  `FORMATS` names them.  The
formats, and how each fact about them was established, are described in
tools/tables/README.md.
"""

from __future__ import annotations

import os
import re
import struct
import sys

FORMATS = ("dte-header", "dte-main", "ppd-main", "dte-trigrams")

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(HERE, "..", "..", "src", "recognition")


def _w(d, o):
	return struct.unpack(">I", d[o:o + 4])[0]


def _h(d, o):
	return struct.unpack(">H", d[o:o + 2])[0]


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


def _int(s: str) -> int:
	return int(s, 0)


# --- the engine's character codes ---------------------------------------------
#
# The letter table and the rules are indexed by the engine's own code
# (OSToRec): the same as Mac Roman below 0x7f; above, the codes the pairs
# of os_rec_ctbl_intl (src/recognition/ParaGraphTables.cpp, from the ROM)
# give the Swedish letters - the only ones the tables have.  Only comments
# use these; test_hwrtables.py checks them against that table.

REC_CHARS = {0x7f: "£", 0x80: "Ä", 0x81: "ä", 0x82: "Ö", 0x83: "ö",
			 0xa0: "Å", 0xa1: "å"}


def _sym(c: int) -> str:
	"""A character code as a token: the character itself when it is printable
	ASCII (and not #), else 0xNN."""
	if 0x21 <= c <= 0x7e and c != 0x23:
		return chr(c)
	return "0x%02x" % c


def _sym_value(tok: str) -> int:
	if len(tok) == 1:
		return ord(tok)
	v = int(tok, 0)
	if not 0 <= v <= 0xff:
		raise ValueError("%s is no character code" % tok)
	return v


def _sym_comment(c: int) -> str:
	if c == 0x20:
		return "space"
	if c == 0x23:
		return "#"
	if c in REC_CHARS:
		return REC_CHARS[c] + " (the engine's code)"
	return ""


def _label(tok: str, parts: int):
	"""'a.0' (parts 2) or 'a.0.3' (parts 3) split: the character may itself be '.'."""
	bits = tok.rsplit(".", parts - 1)
	if len(bits) != parts:
		raise ValueError("%s is not a %s label" % (tok, "c.v" if parts == 2 else "c.v.p"))
	return (_sym_value(bits[0]),) + tuple(int(b) for b in bits[1:])


# --- dte-header ------------------------------------------------------------------
#
# 216 bytes.  ReadDteResource (ParaGraph.cpp) copies bytes 4-0x8f into
# DTIHeader.fHeader (the first word is where the ROM's handle word goes)
# and treats the words from 0x90 as DTIHeader's pointer fields (+0x8c on,
# counting from the byte after the handle word), which it sets itself.

_DTI_WORDS = ("fRAMDTE", "fDTEMain", "fRAMDTEMain", "fRAMDTEMainPtr", "f9C", "fLearnInfo",
			  "fLearnInfoPtr", "fA8", "fAC", "fB0", "fPDF", "fPDFPtr", "fRAMPDF", "fC0", "fC4",
			  "fC8", "fCC", "fD0")
_DTEH_SIZE = 0x90 + 4 * len(_DTI_WORDS)


def _printable(run: bytes) -> bool:
	return all(0x21 <= b <= 0x7e and b != 0x23 for b in run)


def _dte_header_text(d):
	if len(d) != _DTEH_SIZE:
		raise ValueError("a DTE header is %d bytes, not %d" % (_DTEH_SIZE, len(d)))
	out = ["format dte-header",
		   "# DTEHeader: the cursive recogniser's letter-table header (ParaGraph.h's",
		   "# DTIHeader; ReadDteResource copies bytes 4-0x8f and sets the pointer",
		   "# words itself).",
		   "# `handle`: the first word, where the engine's handle word goes - the",
		   "# build machine's stale handle address.",
		   "handle 0x%08x" % _w(d, 0),
		   "# fHeader (bytes 4-0x8f): what is not nought, as `text OFFSET string` (no",
		   "# terminator: the rest is nought) or `bytes OFFSET hex`.  By their",
		   "# contents a file name, its date, the DTE's name and its version; nothing",
		   "# in the reconstructed engine reads them."]
	at = 4
	while at < 0x90:
		if d[at] == 0:
			at += 1
			continue
		end = at
		while end < 0x90 and d[end] != 0:
			end += 1
		run = d[at:end]
		if _printable(run):
			out.append("text 0x%02x %s" % (at, run.decode("ascii")))
		else:
			out.append("bytes 0x%02x %s" % (at, run.hex()))
		at = end
	out.append("# the pointer words (byte offset; DTIHeader's field): the engine sets them")
	out.append("# when it loads the table, so these are stale build-machine values")
	for i, name in enumerate(_DTI_WORDS):
		out.append("word %s 0x%08x\t# +0x%02x" % (name, _w(d, 0x90 + 4 * i), 0x90 + 4 * i))
	return out


def _dte_header_bytes(rows):
	d = bytearray(_DTEH_SIZE)
	for r in rows:
		if r[0] == "handle":
			struct.pack_into(">I", d, 0, _int(r[1]))
		elif r[0] in ("text", "bytes"):
			at = _int(r[1])
			run = r[2].encode("ascii") if r[0] == "text" else bytes.fromhex(r[2])
			if at < 4 or at + len(run) > 0x90:
				raise ValueError("%s at 0x%x is not within bytes 4-0x8f" % (r[0], at))
			d[at:at + len(run)] = run
		elif r[0] == "word":
			if r[1] not in _DTI_WORDS:
				raise ValueError("%s is no DTIHeader word" % r[1])
			struct.pack_into(">I", d, 0x90 + 4 * _DTI_WORDS.index(r[1]), _int(r[2]))
		else:
			raise ValueError("what is %s?" % " ".join(r))
	return bytes(d)


# --- dte-main ---------------------------------------------------------------------
#
# A handle word; then (the engine's `fDTEMain`) 256 big-endian words, each
# character code's descriptor's offset from the table (0: none); then the
# descriptors, in order of code, one after another.  A descriptor: byte 0
# its variant count, bytes 1-3, then sixteen bytes each of the variants'
# prototype counts (+4), vexes (+0x14), groups (+0x24), positions (+0x34)
# and sizes (+0x44), then each variant's prototypes, 0x4c bytes each, one
# variant after another (XrMatrix.cpp's CountSym, XrPostCalc.cpp's
# GetXrCorr, XrPostEval.cpp's GetVarOfChar).  A prototype: its xr byte,
# a byte, flags, its skip penalty, then nibble tables (high nibble first)
# for the 64 xr types (+4), 16 heights (+0x24), 16 shifts (+0x2c), 16
# links (+0x34) and 32 directions (+0x3c) (XrMatrix.cpp's XrMatch).

_XRP = 0x4c
_NIBBLES = (("types", 4, 32), ("heights", 0x24, 8), ("shifts", 0x2c, 8), ("links", 0x34, 8),
			("dirs", 0x3c, 16))


def _dte_main_text(d):
	t = d[4:]
	out = ["format dte-main",
		   "# DTEMain: the cursive recogniser's symbol descriptors (ParaGraph.h;",
		   "# GetSymDescriptor, CountSym, GetXrCorr).  Each `symbol` is an engine",
		   "# character code (OSToRec: Mac Roman below 0x7f) and its descriptor's",
		   "# bytes 1-3 (b1: the top byte of GetVarPosSize's answer, which no reader",
		   "# uses; b2: the code itself for most, its use unknown; b3: unknown).",
		   "# Each `variant c.v`, in order:",
		   "#   vex     its default weight (0 best .. 7 never; the low three bits are",
		   "#           what the engine reads, the byte is kept whole)",
		   "#   group   the Letter Shapes group it belongs to (group byte bits 1-3)",
		   "#   styles  the letter sets that use it (bits 4-7: CheckVarActive)",
		   "#   rewcap  1 when it may stand for a capital (bit 0 clear: GetVarRewcapAllow)",
		   "#   pos     where its body lies in its box, in sixteenths: high nibble the",
		   "#           top, low nibble the bottom less one (Xrlv.cpp, against the line)",
		   "#   size    the smallest (high nibble) and tallest (low) it may be (SizePenalty)",
		   "# Each `xrp c.v.p`, a prototype xr of the variant, in order:",
		   "#   xr      byte 0: the xr it stands for (written into the trace; mostly the",
		   "#           type its own table rates highest, but values above 63 occur)",
		   "#   b1      byte 1: unknown (nothing in the reconstructed engine reads it)",
		   "#   flags   byte 2: bit 7 - it only reads an xr next to a break",
		   "#   skip    byte 3: what skipping the prototype costs",
		   "#   types heights shifts links dirs: what an xr of each type (0-63),",
		   "#           height (0-15), shift (0-15), link (0-15) and direction (0-31)",
		   "#           is worth here, a hex digit each; a type worth 0 is not read",
		   "# The offset table, the counts and the prototype counts are worked out.",
		   "handle 0x%08x\t# the first word: the build machine's stale handle" % _w(d, 0)]
	if len(t) < 0x400:
		raise ValueError("no offset table")
	offsets = [_w(t, 4 * c) for c in range(256)]
	at = 0x400
	for c in range(256):
		o = offsets[c]
		if o == 0:
			continue
		if o != at:
			raise ValueError("descriptor 0x%02x is not after the one before" % c)
		n = t[o]
		if not 1 <= n <= 16:
			raise ValueError("descriptor 0x%02x has %d variants" % (c, n))
		lens = t[o + 4:o + 0x14]
		for base in (4, 0x14, 0x24, 0x34, 0x44):
			if any(t[o + base + n:o + base + 16]):
				raise ValueError("descriptor 0x%02x: bytes for variants it does not have" % c)
		s = _sym(c)
		note = _sym_comment(c)
		out.append("")
		out.append("symbol %s b1 0x%02x b2 0x%02x b3 0x%02x\t# %s%d variant%s"
				   % (s, t[o + 1], t[o + 2], t[o + 3], note + ": " if note else "", n, "" if n == 1 else "s"))
		for v in range(n):
			g = t[o + 0x24 + v]
			out.append("variant %s.%d vex %d group %d styles 0x%x rewcap %d pos 0x%02x size 0x%02x"
					   % (s, v, t[o + 0x14 + v], (g >> 1) & 7, g >> 4, 0 if g & 1 else 1,
						  t[o + 0x34 + v], t[o + 0x44 + v]))
		p = o + 0x54
		for v in range(n):
			for k in range(lens[v]):
				x = t[p:p + _XRP]
				if len(x) != _XRP:
					raise ValueError("descriptor 0x%02x cut short" % c)
				out.append("xrp %s.%d.%d xr 0x%02x b1 %d flags 0x%02x skip %d %s"
						   % (s, v, k, x[0], x[1], x[2], x[3],
							  " ".join("%s %s" % (name, x[b:b + w].hex()) for name, b, w in _NIBBLES)))
				p += _XRP
		at = p
	if at != len(t):
		raise ValueError("bytes after the last descriptor")
	return out


def _dte_main_bytes(rows):
	handle = 0
	symbols = {}
	for r in rows:
		if r[0] == "handle":
			handle = _int(r[1])
		elif r[0] == "symbol":
			c = _sym_value(r[1])
			f = dict(zip(r[2::2], r[3::2]))
			if c in symbols:
				raise ValueError("symbol %s given twice" % r[1])
			symbols[c] = {"head": (_int(f.get("b1", "0")), _int(f.get("b2", "0")), _int(f.get("b3", "0"))),
						  "variants": []}
		elif r[0] == "variant":
			c, v = _label(r[1], 2)
			if c not in symbols:
				raise ValueError("variant %s before its symbol" % r[1])
			vs = symbols[c]["variants"]
			if v != len(vs):
				raise ValueError("variant %s is not the next variant" % r[1])
			f = dict(zip(r[2::2], r[3::2]))
			group = _int(f["group"])
			styles = _int(f["styles"])
			rewcap = _int(f["rewcap"])
			if not (0 <= group <= 7 and 0 <= styles <= 15 and rewcap in (0, 1)):
				raise ValueError("variant %s: group 0-7, styles 0-15, rewcap 0 or 1" % r[1])
			vs.append({"vex": _int(f["vex"]), "group": (styles << 4) | (group << 1) | (rewcap ^ 1),
					   "pos": _int(f["pos"]), "size": _int(f["size"]), "xrps": []})
		elif r[0] == "xrp":
			c, v, k = _label(r[1], 3)
			try:
				var = symbols[c]["variants"][v]
			except (KeyError, IndexError):
				raise ValueError("prototype %s before its variant" % r[1]) from None
			if k != len(var["xrps"]):
				raise ValueError("prototype %s is not the next prototype" % r[1])
			f = dict(zip(r[2::2], r[3::2]))
			x = bytearray(_XRP)
			x[0:4] = bytes((_int(f["xr"]), _int(f["b1"]), _int(f["flags"]), _int(f["skip"])))
			for name, b, w in _NIBBLES:
				table = bytes.fromhex(f[name])
				if len(table) != w:
					raise ValueError("prototype %s: %s is %d hex digits" % (r[1], name, 2 * w))
				x[b:b + w] = table
			var["xrps"].append(bytes(x))
		else:
			raise ValueError("what is %s?" % " ".join(r))
	table = bytearray(0x400)
	body = b""
	for c in sorted(symbols):
		s = symbols[c]
		vs = s["variants"]
		if not 1 <= len(vs) <= 16:
			raise ValueError("symbol %s has %d variants (1-16)" % (_sym(c), len(vs)))
		head = bytearray(0x54)
		head[0] = len(vs)
		head[1:4] = bytes(s["head"])
		for v, var in enumerate(vs):
			if not 1 <= len(var["xrps"]) <= 255:
				raise ValueError("variant %s.%d has no prototypes" % (_sym(c), v))
			head[4 + v] = len(var["xrps"])
			head[0x14 + v] = var["vex"]
			head[0x24 + v] = var["group"]
			head[0x34 + v] = var["pos"]
			head[0x44 + v] = var["size"]
		struct.pack_into(">I", table, 4 * c, 0x400 + len(body))
		body += bytes(head) + b"".join(x for var in vs for x in var["xrps"])
	return struct.pack(">I", handle) + bytes(table) + body


# --- ppd-main --------------------------------------------------------------------
#
# A handle word ("HMEM"), then the table (the engine's `ppd`): three words
# CreatePDFHeader writes the sections' addresses over (stale here), a
# word - the halfword counts of section 1 (the constants) and section 2
# (the queues' weights) - and section 0 from +0x10, the rules' tree
# (XrRules.cpp).  Section 0's main header: "PDF\0", two words, section 1's
# offset from it, a bit per character code (+0x10) and the characters'
# offsets (+0x30).  A character: its size, a bit per variant (+4), the
# variants' offsets (+8).  A variant: its size, a bit per character next
# to it (+4), its own rule's size (+0x24; nought for none), the
# connections' offsets (+0x28), then its own rule.  A connection: its size,
# a bit per variant of the character next to it (+4), the rules' offsets
# (+8).  A rule: its queue count (+0), each queue's length (+2), each
# queue's weight's index in section 2 (+0x16), the queues from +0x20.
# Every offset is from the header it is in; the bits are numbered from the
# top bit of the first byte.  Laid out depth first in order with no gaps
# (checked), which is what packing does.

_OPS = ("add", "sub", "mul", "div", "pow", "neg", "less", "greater", "equal")
_FIELDS = ("el", "left", "bottom", "right", "top")
_GLOBAL_SIZE = (2, 6, 2, 6, 3, 4, 2, 4, 1, 5, 3, 2, 2, 3, 2, 3)		# globalSizeArray (XrPostTables.cpp)


def _bits(d, o, nbytes):
	return [i for i in range(nbytes * 8) if d[o + (i >> 3)] & (0x80 >> (i & 7))]


def _bitset(nums, nbytes):
	b = bytearray(nbytes)
	for i in nums:
		if not 0 <= i < nbytes * 8:
			raise ValueError("%d is out of a %d-bit set" % (i, nbytes * 8))
		b[i >> 3] |= 0x80 >> (i & 7)
	return bytes(b)


def _function_names():
	"""The post-processing functions' names by number: kPPFunctions in
	XrPostCalc.cpp, which is in the order of the ROM's Functions table.
	Only for the text (it names them in `function` lines); {} without it."""
	try:
		with open(os.path.join(SRC, "XrPostCalc.cpp"), encoding="utf-8") as f:
			src = f.read()
	except OSError:
		return {}
	m = re.search(r"kPPFunctions\[\d+\]\s*=\s*\{(.*?)\n\};", src, re.S)
	if not m:
		return {}
	names = re.findall(r"\{\s*0x[0-9a-fA-F]+,\s*(\w+)\s*\}", m.group(1))
	return dict(enumerate(names))


def _field_name(f: int) -> str:
	if f < 15:
		return ("", "prev.", "next.")[f // 5] + _FIELDS[f % 5]
	return str(f)


def _field_value(s: str) -> int:
	if s[0].isdigit():
		return int(s, 0)
	where, _, name = s.rpartition(".")
	return ("", "prev", "next").index(where) * 5 + _FIELDS.index(name)


def _encode_insn(words, functions):
	"""One instruction's text as its bytes."""
	w = words[0]
	if re.fullmatch(r"-?(0x[0-9a-fA-F]+|\d+)", w):
		v = int(w, 0)
		if len(words) != 1:
			raise ValueError("a number is an instruction of its own: %s" % " ".join(words))
		if 0 <= v <= 0xff:
			return bytes((0x0b, v))
		if 0 <= v <= 0xffff:
			return bytes((0x0a, v >> 8, v & 0xff))
		return bytes((0x09,)) + struct.pack(">i", v)
	if w in _OPS and len(words) == 1:
		return bytes((0x0c, _OPS.index(w)))
	if w == "op" and len(words) == 2:
		return bytes((0x0c, _int(words[1])))
	if w == "xr" and len(words) == 3:
		return bytes((0x0f, _int(words[1]), _field_value(words[2])))
	if w == "const" and len(words) == 2:
		return bytes((0x10, 6)) + struct.pack(">H", _int(words[1])) + b"\0\0"
	if w == "call" and len(words) == 2:
		f = words[1]
		v = int(f, 0) if f[0].isdigit() else functions.get(f)
		if v is None:
			raise ValueError("no function %s (a `function` line names it)" % f)
		return bytes((0x0e, v))
	if w == "raw" and len(words) == 2:
		return bytes.fromhex(words[1])
	raise ValueError("what instruction is %s?" % " ".join(words))


def _decode_queue(q, names):
	"""A queue's bytes as its instructions' text, the bytes after its
	terminating nought as a `pad` when there are any."""
	insns = []
	at = 0
	while True:
		if at >= len(q):
			raise ValueError("a queue with no terminating nought")
		op = q[at]
		if op == 0:
			break
		size = q[at + 1] if op == 0x10 else (_GLOBAL_SIZE[op] if op < 16 else 0)
		if size == 0 or at + size > len(q):
			raise ValueError("a queue's bytecode 0x%02x is cut short or unknown" % op)
		b = q[at:at + size]
		text = None
		if op == 0x0b:
			text = str(b[1])
		elif op == 0x0a:
			text = str((b[1] << 8) | b[2])
		elif op == 0x09:
			text = str(struct.unpack(">i", b[1:5])[0])
		elif op == 0x0c:
			text = _OPS[b[1]] if b[1] < len(_OPS) else "op %d" % b[1]
		elif op == 0x0f:
			text = "xr %d %s" % (b[1], _field_name(b[2]))
		elif op == 0x10 and size == 6:
			text = "const %d" % _h(b, 2)
		elif op == 0x0e:
			text = "call %s" % names.get(b[1], str(b[1]))
		if text is None or _encode_insn(text.split(), {v: k for k, v in names.items()}) != b:
			text = "raw %s" % b.hex()
		insns.append(text)
		at += size
	tail = q[at + 1:]
	if tail:
		insns.append("pad %s" % tail.hex())
	return " ; ".join(insns)


def _ppd_main_text(d):
	p = d[4:]
	n1, n2 = _h(p, 0x0c), _h(p, 0x0e)
	m = 0x10
	sec1 = m + _w(p, m + 0x0c)
	if sec1 + 2 * n1 + 2 * n2 != len(p):
		raise ValueError("the sections do not end the table")
	names = _function_names()
	out = ["format ppd-main",
		   "# PPDMain: the cursive recogniser's prototype data (\"PDF\"): the",
		   "# post-processing rules (recognition/XrRules.cpp, XrPostEval.cpp,",
		   "# XrPostCalc.cpp).  A letter's variant, in a word, is scored by its own",
		   "# rule and by the rules for it next to the letter before and after it -",
		   "# `rule c.v own`, `rule c.v n.w` (c.v next to n's variant w) - each rule",
		   "# a list of queues, each queue's answer times its weight (at least",
		   "# -16 x the queues counted) added up.  A `queue` line: its rule, its weight,",
		   "# then ':' and its code, separated by ';', run as a stack machine:",
		   "#   N              push the number",
		   "#   const I        push constant I (the `constant` lines)",
		   "#   xr E F         push field F of the xr the letter's prototype element E",
		   "#                  was read from: el (its address), left, bottom, right, top;",
		   "#                  prev.F / next.F the letter before's or after's",
		   "#   add sub mul div pow neg less greater equal   the top two (neg: one)",
		   "#   call NAME      a function of the table (`function` lines) on the top",
		   "#   raw HEX        bytecode as it is",
		   "#   pad HEX        bytes after the queue's terminating nought (kept)",
		   "# Every header, bit set, offset, size, count and weight index is worked out",
		   "# on packing; `letter`, `variant` and `next` lines only matter for one",
		   "# with nothing under it.",
		   "handle 0x%08x\t# the first word (\"HMEM\")" % _w(d, 0),
		   "stale 0x%08x 0x%08x 0x%08x\t# the words CreatePDFHeader writes the sections' addresses over"
		   % (_w(p, 0), _w(p, 4), _w(p, 8)),
		   "main 0x%08x 0x%08x 0x%08x\t# the main header's first three words: \"PDF\\0\", then two unknown"
		   % (_w(p, m), _w(p, m + 4), _w(p, m + 8))]
	for i in range(n1):
		out.append("constant %d %d" % (i, struct.unpack(">h", p[sec1 + 2 * i:sec1 + 2 * i + 2])[0]))
	weights = [struct.unpack(">h", p[sec1 + 2 * n1 + 2 * i:sec1 + 2 * n1 + 2 * i + 2])[0] for i in range(n2)]
	if names:
		out.append("# the functions `call` names (kPPFunctions, XrPostCalc.cpp; only these lines")
		out.append("# give the names their numbers)")
		for i in sorted(names):
			out.append("function %d %s" % (i, names[i]))
	widx = 0
	at = m + 0x30

	def expect(o, what):
		nonlocal at
		if o != at:
			raise ValueError("%s is not where the one before ended" % what)

	def rule_text(r, key):
		nonlocal at, widx
		expect(r, "rule " + key)
		n = _h(p, r)
		if n > 5:
			raise ValueError("rule %s has %d queues (at most 5)" % (key, n))
		lens = [_h(p, r + 2 + 2 * i) for i in range(n)]
		idx = [_h(p, r + 0x16 + 2 * i) for i in range(n)]
		if any(p[r + 2 + 2 * n:r + 0x16]) or any(p[r + 0x16 + 2 * n:r + 0x20]):
			raise ValueError("rule %s: header bytes past its queues are not nought" % key)
		lines = ["rule " + key]
		q = r + 0x20
		for L, i in zip(lens, idx):
			if i != widx:
				raise ValueError("rule %s: weights are not in order of the queues" % key)
			lines.append("queue %s %d : %s" % (key, weights[i], _decode_queue(p[q:q + L], names)))
			widx += 1
			q += L
		at = q
		return lines

	chars = _bits(p, m + 0x10, 32)
	at = m + 0x30 + 4 * len(chars)
	for k, c in enumerate(chars):
		ch = m + _w(p, m + 0x30 + 4 * k)
		s = _sym(c)
		expect(ch, "letter " + s)
		note = _sym_comment(c)
		out.append("")
		out.append("letter %s%s" % (s, "\t# " + note if note else ""))
		vs = _bits(p, ch + 4, 4)
		at = ch + 8 + 4 * len(vs)
		for j, v in enumerate(vs):
			va = ch + _w(p, ch + 8 + 4 * j)
			key = "%s.%d" % (s, v)
			expect(va, "variant " + key)
			out.append("variant " + key)
			conns = _bits(p, va + 4, 32)
			at = va + 0x28 + 4 * len(conns)
			own = _w(p, va + 0x24)
			if own:
				start = at
				out += rule_text(at, key + " own")
				if at - start != own:
					raise ValueError("variant %s: its own rule's size is not its word" % key)
			for i, nc in enumerate(conns):
				co = va + _w(p, va + 0x28 + 4 * i)
				expect(co, "the rules of %s next to %s" % (key, _sym(nc)))
				out.append("next %s %s" % (key, _sym(nc)))
				rs = _bits(p, co + 4, 4)
				at = co + 8 + 4 * len(rs)
				for q, rv in enumerate(rs):
					out += rule_text(co + _w(p, co + 8 + 4 * q), "%s %s.%d" % (key, _sym(nc), rv))
				if _w(p, co) != at - co:
					raise ValueError("the rules of %s next to %s: a wrong size" % (key, _sym(nc)))
			if _w(p, va) != at - va:
				raise ValueError("variant %s: a wrong size" % key)
		if _w(p, ch) != at - ch:
			raise ValueError("letter %s: a wrong size" % s)
	if at != sec1:
		raise ValueError("section 1 is not after the rules")
	if widx != n2:
		raise ValueError("weights no queue uses")
	return out


def _ppd_main_bytes(rows):
	handle, stale, main = 0, (0, 0, 0), (0, 0, 0)
	constants = {}
	functions = {}
	tree = {}				# c -> v -> {"own": rule or None, "next": {nc -> {w -> rule}}}

	def var_of(c, v):
		return tree.setdefault(c, {}).setdefault(v, {"own": None, "next": {}})

	def rule_of(key, other):
		c, v = _label(key, 2)
		var = var_of(c, v)
		if other == "own":
			if var["own"] is None:
				var["own"] = []
			return var["own"]
		nc, nv = _label(other, 2)
		return var["next"].setdefault(nc, {}).setdefault(nv, [])

	for r in rows:
		if r[0] == "handle":
			handle = _int(r[1])
		elif r[0] == "stale":
			stale = tuple(_int(x) for x in r[1:4])
		elif r[0] == "main":
			main = tuple(_int(x) for x in r[1:4])
		elif r[0] == "constant":
			constants[_int(r[1])] = _int(r[2])
		elif r[0] == "function":
			functions[r[2]] = _int(r[1])
		elif r[0] == "letter":
			tree.setdefault(_sym_value(r[1]), {})
		elif r[0] == "variant":
			var_of(*_label(r[1], 2))
		elif r[0] == "next":
			c, v = _label(r[1], 2)
			var_of(c, v)["next"].setdefault(_sym_value(r[2]), {})
		elif r[0] == "rule":
			rule_of(r[1], r[2])
		elif r[0] == "queue":
			if len(r) < 5 or r[4] != ":":
				raise ValueError("a queue is `queue c.v own|n.w WEIGHT : code`: %s" % " ".join(r))
			code = b""
			insns = " ".join(r[5:]).split(";")
			for i, insn in enumerate(insns):
				words = insn.split()
				if not words:
					if len(insns) == 1:
						continue
					raise ValueError("an empty instruction in %s" % " ".join(r))
				if words[0] == "pad":
					if i != len(insns) - 1:
						raise ValueError("pad is the last of a queue")
					continue
				code += _encode_insn(words, functions)
			last = insns[-1].split()
			code += b"\0" + (bytes.fromhex(last[1]) if last and last[0] == "pad" else b"")
			rule_of(r[1], r[2]).append((_int(r[3]), code))
		else:
			raise ValueError("what is %s?" % " ".join(r))
	if sorted(constants) != list(range(len(constants))):
		raise ValueError("the constants are not numbered 0 on")
	weights = []

	def rule_bytes(queues):
		if len(queues) > 5:
			raise ValueError("a rule has at most five queues")
		head = bytearray(0x20)
		struct.pack_into(">H", head, 0, len(queues))
		for i, (w, code) in enumerate(queues):
			struct.pack_into(">H", head, 2 + 2 * i, len(code))
			struct.pack_into(">H", head, 0x16 + 2 * i, len(weights))
			weights.append(w)
		return bytes(head) + b"".join(code for w, code in queues)

	chars = []
	for c in sorted(tree):
		var_blobs = []
		for v in sorted(tree[c]):
			var = tree[c][v]
			own = rule_bytes(var["own"]) if var["own"] is not None else b""
			conn_blobs = []
			for nc in sorted(var["next"]):
				rules = [rule_bytes(var["next"][nc][w]) for w in sorted(var["next"][nc])]
				hsize = 8 + 4 * len(rules)
				body, offs = b"", []
				for blob in rules:
					offs.append(hsize + len(body))
					body += blob
				conn_blobs.append(struct.pack(">I", hsize + len(body)) + _bitset(sorted(var["next"][nc]), 4)
								  + b"".join(struct.pack(">I", o) for o in offs) + body)
			hsize = 0x28 + 4 * len(conn_blobs)
			body, offs = own, []
			for blob in conn_blobs:
				offs.append(hsize + len(body))
				body += blob
			var_blobs.append(struct.pack(">I", hsize + len(body)) + _bitset(sorted(var["next"]), 32)
							 + struct.pack(">I", len(own)) + b"".join(struct.pack(">I", o) for o in offs) + body)
		hsize = 8 + 4 * len(var_blobs)
		body, offs = b"", []
		for blob in var_blobs:
			offs.append(hsize + len(body))
			body += blob
		chars.append(struct.pack(">I", hsize + len(body)) + _bitset(sorted(tree[c]), 4)
					 + b"".join(struct.pack(">I", o) for o in offs) + body)
	hsize = 0x30 + 4 * len(chars)
	body, offs = b"", []
	for blob in chars:
		offs.append(hsize + len(body))
		body += blob
	section0 = (struct.pack(">III", *main) + struct.pack(">I", hsize + len(body)) + _bitset(sorted(tree), 32)
				+ b"".join(struct.pack(">I", o) for o in offs) + body)
	section1 = b"".join(struct.pack(">h", constants[i]) for i in range(len(constants)))
	section2 = b"".join(struct.pack(">h", w) for w in weights)
	if len(constants) > 0xffff or len(weights) > 0xffff:
		raise ValueError("too many constants or queues")
	return (struct.pack(">I", handle) + struct.pack(">III", *stale)
			+ struct.pack(">HH", len(constants), len(weights)) + section0 + section1 + section2)


# --- dte-trigrams ------------------------------------------------------------------
#
# A handle word, then 40 x 40 x 40 two-bit weights: the weight of the
# class c after b after a in byte a x 400 + b x 10 + (c >> 2), at bits
# 2 x (c & 3) (Xrlv.cpp's XrlvGetNextSymbols: the reading's state holds
# the classes of its last two letters, the older in its second byte).  A
# character's class is triads_mapping[c] - 1 (XrReaderTables.cpp); one
# above 39 counts as 0.  Classes 1-26 are a-z with their capitals, 0 is
# the space (a reading starts in state 0: the edge of a word), 39 the
# apostrophe, 27-38 accented letters - named here by one of each class's
# characters (test_hwrtables.py checks these against triads_mapping).

_TRI_N = 40
_TRI_SYMBOLS = ("_",) + tuple("abcdefghijklmnopqrstuvwxyz") + tuple(
	"åäçéïöüâèêîû") + ("'",)
_TRI_OF = {s: i for i, s in enumerate(_TRI_SYMBOLS)}


def _dte_trigrams_text(d):
	t = d[4:]
	if len(t) != _TRI_N * _TRI_N * 10:
		raise ValueError("a DTE trigram table is %d bytes after its handle word, not %d"
						 % (_TRI_N * _TRI_N * 10, len(t)))
	out = ["format dte-trigrams",
		   "# DTETrigrams: the cursive reader's letter trigrams (Xrlv.cpp's",
		   "# XrlvGetNextSymbols): a weight 1-3 for each sequence of three letter",
		   "# classes that has one - the third letter after the first two - the",
		   "# reader charging a letter 5 less the weight when it reads without a",
		   "# dictionary; any not listed is 0 (a charge of 5).  The classes:",
		   "#   _      the space, the edge of a word (and any letter of a class above 39)",
		   "#   a-z    the letters, with their capitals and some accented forms",
		   "#   å ä ç é ï ö ü â è ê î û  classes 27-38: accented letters (each with its capital;",
		   "#          ä also à, ö also ô, ü also ù: triads_mapping)",
		   "#   '      the apostrophe",
		   "handle 0x%08x\t# the first word: the build machine's stale handle" % _w(d, 0)]
	for a in range(_TRI_N):
		for b in range(_TRI_N):
			for c in range(_TRI_N):
				v = (t[a * 400 + b * 10 + (c >> 2)] >> ((c & 3) * 2)) & 3
				if v:
					out.append("%s%s%s %d" % (_TRI_SYMBOLS[a], _TRI_SYMBOLS[b], _TRI_SYMBOLS[c], v))
	return out


def _dte_trigrams_bytes(rows):
	handle = 0
	t = bytearray(_TRI_N * _TRI_N * 10)
	seen = set()
	for r in rows:
		if r[0] == "handle":
			handle = _int(r[1])
			continue
		if len(r) != 2 or len(r[0]) != 3 or any(s not in _TRI_OF for s in r[0]):
			raise ValueError("what is %s?" % " ".join(r))
		a, b, c = (_TRI_OF[s] for s in r[0])
		v = _int(r[1])
		if not 0 <= v <= 3:
			raise ValueError("%s: a weight is 0-3" % r[0])
		if r[0] in seen:
			raise ValueError("%s given twice" % r[0])
		seen.add(r[0])
		t[a * 400 + b * 10 + (c >> 2)] |= v << ((c & 3) * 2)
	return struct.pack(">I", handle) + bytes(t)


# --- the files ---------------------------------------------------------------------

_TEXT = {"dte-header": _dte_header_text, "dte-main": _dte_main_text, "ppd-main": _ppd_main_text,
		 "dte-trigrams": _dte_trigrams_text}
_BYTES = {"dte-header": _dte_header_bytes, "dte-main": _dte_main_bytes, "ppd-main": _ppd_main_bytes,
		  "dte-trigrams": _dte_trigrams_bytes}


def unpack(data: bytes, format: str, path: str) -> None:
	lines = _TEXT[format](data)
	with open(path, "w", encoding="utf-8", newline="\n") as f:
		f.write("\n".join(lines) + "\n")


def pack_lines(format: str, lines: list, base: str = None) -> bytes:
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
