#!/usr/bin/env python3
"""Tests of hwrtables.py.

    python tools/tables/test_hwrtables.py [--rom build/MP2x00US]

The four committed tables of the cursive recogniser - DTEHeader,
DTEMain, PPDMain and DTETrigrams, texttable(...) in romsrc/ - are packed,
unpacked to their committed text and packed back to the same bytes; with --rom, the
bytes must be the ROM's own - the object at the address the file is named
after (its data after the 12-byte object header).  Then edits are read
back through Python mirrors of the C++ readers (ParaGraph.cpp's
GetSymDescriptor and CreatePDFHeader, XrPostCalc.cpp's GetXrCorr
addressing, XrRules.cpp's PDFGetRule, Xrlv.cpp's trigram lookup): a
header string, a variant's vex and a prototype added to a variant (every
later descriptor moves), a queue's code and weight changed and a rule
added for a new neighbour (every later offset, size and weight index
moves), and trigram weights.  The names the text gives the engine's codes
and the trigram classes are checked against the generated C++ tables.
"""
import os
import re
import struct
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import hwrtables				# noqa: E402

RES = os.path.join(HERE, "..", "..", "romsrc", "resources")
SRC = os.path.join(HERE, "..", "..", "src", "recognition")
ROM_BUILD = None
COMMITTED = (
	("dte-header", os.path.join(RES, "DTEH", "5c72b1.txt")),
	("dte-main", os.path.join(RES, "DTEM", "5c73ad.txt")),
	("ppd-main", os.path.join(RES, "PPDB", "60a475.txt")),
	("dte-trigrams", os.path.join(RES, "Trigram", "623fc9.txt")),
)


def read(path):
	"""A file's bytes; a committed table's (its .txt in romsrc/) packed."""
	if path.endswith(".txt"):
		return hwrtables.pack(path)
	with open(path, "rb") as f:
		return f.read()


def text_of(format, path, tmp):
	out = os.path.join(tmp, "t.txt")
	hwrtables.unpack(read(path), format, out)
	with open(out, encoding="utf-8") as f:
		return f.read()


def pack_text(format, text):
	return hwrtables.pack_lines(format, text.split("\n"))


def edited(format, path, change):
	with tempfile.TemporaryDirectory() as tmp:
		text = text_of(format, path, tmp)
	new = change(text)
	assert new != text, "the edit changed nothing"
	return pack_text(format, new)


def cpp_table(name, source):
	"""A generated `const unsigned char name[N] = {...}` table's bytes."""
	with open(os.path.join(SRC, source), encoding="utf-8") as f:
		m = re.search(r"\b%s\[\d+\]\s*=\s*\{(.*?)\};" % name, f.read(), re.S)
	return [int(x, 16) for x in re.findall(r"0x[0-9a-fA-F]+", m.group(1))]


# --- the C++ readers, in Python ----------------------------------------------------

W = lambda d, o: struct.unpack(">I", d[o:o + 4])[0]
H = lambda d, o: struct.unpack(">H", d[o:o + 2])[0]
SH = lambda d, o: struct.unpack(">h", d[o:o + 2])[0]


def descriptor(dtem, c):
	"""GetSymDescriptor's ROM half: DTEMain's data after its first word, and
	the descriptor of code c in it (or None)."""
	t = dtem[4:]
	o = W(t, 4 * c)
	return (t, o) if o else (t, None)


def xrp(dtem, c, var, idx):
	"""GetXrCorr's addressing: the prototype element idx of variant var."""
	t, o = descriptor(dtem, c)
	if o is None or var >= t[o] or t[o + 4 + var] <= idx:
		return None
	el = o + 0x54 + sum(t[o + 4 + i] for i in range(var)) * 0x4c + idx * 0x4c
	return t[el:el + 0x4c]


def pdf_sections(ppd):
	"""CreatePDFHeader: the three sections of PPDMain's data after its first word."""
	p = ppd[4:]
	offset = W(p, 0x1c)
	return p, 0x10, offset + 0x10, SH(p, 0x0c) * 2 + offset + 0x10


def _bit(p, o, n):
	return (p[o + n // 8] & (0x80 >> (n % 8))) != 0


def _slot(p, o, n):
	return sum(_bit(p, o, i) for i in range(n))


def pdf_get_rule(ppd, c, var, connection=-1, rule=-1):
	"""PDFGetRule: the rule's offset in the data, or None."""
	p, main, _, _ = pdf_sections(ppd)
	if not _bit(p, main + 0x10, c):
		return None
	ch = main + W(p, main + 0x30 + 4 * _slot(p, main + 0x10, c))
	if not _bit(p, ch + 4, var):
		return None
	v = ch + W(p, ch + 8 + 4 * _slot(p, ch + 4, var))
	if connection == -1:
		if W(p, v + 0x24) == 0:
			return None
		return v + (_slot(p, v + 4, 0x100) - 1) * 4 + 0x2c
	if not _bit(p, v + 4, connection):
		return None
	conn = v + W(p, v + 0x28 + 4 * _slot(p, v + 4, connection))
	if not _bit(p, conn + 4, rule):
		return None
	return conn + W(p, conn + 8 + 4 * _slot(p, conn + 4, rule))


def rule_queues(ppd, r):
	"""CalculateGroupResult's view of a rule: (weight, queue bytes) each."""
	p, _, _, sec2 = pdf_sections(ppd)
	out = []
	q = r + 0x20
	for i in range(H(p, r)):
		L = H(p, r + 2 + 2 * i)
		out.append((SH(p, sec2 + 2 * H(p, r + 0x16 + 2 * i)), p[q:q + L]))
		q += L
	return out


def trigram(tri, a, b, c):
	"""Xrlv.cpp: the weight of class c after a, b."""
	t = tri[4:]
	return (t[a * 400 + b * 10 + (c >> 2)] >> ((c & 3) << 1)) & 3


# --- the tests -------------------------------------------------------------------------

class RoundTrip(unittest.TestCase):
	def test_committed(self):
		rom = read(os.path.join(ROM_BUILD, "rom.bin")) if ROM_BUILD else None
		with tempfile.TemporaryDirectory() as tmp:
			for format, path in COMMITTED:
				with self.subTest(os.path.basename(path)):
					data = read(path)
					text = text_of(format, path, tmp)
					with open(path, encoding="utf-8") as f:
						self.assertEqual(f.read(), text)
					packed = pack_text(format, text)
					self.assertEqual(packed, data)
					again = os.path.join(tmp, "again.txt")
					hwrtables.unpack(packed, format, again)
					with open(again, encoding="utf-8") as f:
						self.assertEqual(f.read(), text)
					if rom is not None:
						address = int(os.path.splitext(os.path.basename(path))[0], 16) - 1
						size = struct.unpack(">I", rom[address:address + 4])[0] >> 8
						self.assertEqual(data, rom[address + 12:address + size])

	def test_cli_check(self):
		import contextlib
		import io
		for format, path in COMMITTED:
			with tempfile.TemporaryDirectory() as tmp:
				binary = os.path.join(tmp, "t.bin")
				with open(binary, "wb") as f:
					f.write(read(path))
				with contextlib.redirect_stdout(io.StringIO()) as out:
					self.assertEqual(hwrtables.main(["check", format, binary]), 0)
			self.assertIn("the same", out.getvalue())


class Names(unittest.TestCase):
	def test_engine_codes(self):
		# os_rec_ctbl_intl: (Mac Roman, engine code) pairs
		table = cpp_table("os_rec_ctbl_intl", "ParaGraphTables.cpp")
		rec = {}
		for i in range(0, len(table), 2):
			if table[i] and table[i + 1] >= 0x7f and table[i + 1] not in rec:
				rec[table[i + 1]] = bytes([table[i]]).decode("mac_roman")
		for code, ch in hwrtables.REC_CHARS.items():
			self.assertEqual(rec.get(code), ch, hex(code))

	def test_trigram_classes(self):
		mapping = cpp_table("triads_mapping", "XrReaderTables.cpp")
		for n, s in enumerate(hwrtables._TRI_SYMBOLS):
			byte = 0x20 if s == "_" else s.encode("mac_roman")[0]
			self.assertEqual(mapping[byte] - 1, n, s)


class Editing(unittest.TestCase):
	def test_header_text(self):
		data = edited("dte-header", COMMITTED[0][1], lambda t: t.replace("DTI4EngM2.00", "DTI4EngM2.01"))
		self.assertEqual(data[0x84:0x90], b"DTI4EngM2.01")
		self.assertEqual(len(data), 216)

	def test_dte_vex_and_prototype(self):
		src = read(COMMITTED[1][1])

		def change(t):
			t = re.sub(r"^variant a\.0 vex \d+", "variant a.0 vex 3", t, flags=re.M)
			last = re.search(r"^xrp !\.0\.5 .*$", t, re.M).group(0)		# the variant's last of six
			added = re.sub(r"^xrp !\.0\.5 xr 0x\w+", "xrp !.0.6 xr 0x2a", last)
			return t.replace(last, last + "\n" + added)
		data = edited("dte-main", COMMITTED[1][1], change)
		t, o = descriptor(data, ord("a"))
		self.assertEqual(t[o + 0x14], 3)
		t, o = descriptor(data, ord("!"))
		self.assertEqual(t[o + 4], 7)					# the variant's prototype count
		self.assertEqual(xrp(data, ord("!"), 0, 6)[0], 0x2a)
		self.assertEqual(xrp(data, ord("!"), 0, 6)[1:], xrp(src, ord("!"), 0, 5)[1:])
		self.assertEqual(xrp(data, ord("!"), 1, 0), xrp(src, ord("!"), 1, 0))
		# every later descriptor moved, and reads the same
		self.assertEqual(descriptor(data, ord("a"))[1], descriptor(src, ord("a"))[1] + 0x4c)
		self.assertEqual(xrp(data, ord("z"), 3, 2), xrp(src, ord("z"), 3, 2))
		self.assertEqual(len(data), len(src) + 0x4c)

	def test_ppd_queue_and_rule(self):
		src = read(COMMITTED[2][1])
		before = rule_queues(src, pdf_get_rule(src, ord("a"), 0))

		def change(t):
			t = t.replace("queue a.0 own -5 : 100 ;", "queue a.0 own -7 : 101 ;")
			# a rule for a.0 next to 0xa1's variant 9 (no rule for a.0 had it)
			return t.replace("variant a.1\n", "next a.0 0xa1\nrule a.0 0xa1.9\n"
							 "queue a.0 0xa1.9 -2 : xr 1 top ; xr 2 next.bottom ; sub ; call CalculateAbs\n"
							 "variant a.1\n", 1)
		data = edited("ppd-main", COMMITTED[2][1], change)
		after = rule_queues(data, pdf_get_rule(data, ord("a"), 0))
		self.assertEqual(after[0][0], -7)
		self.assertEqual(after[0][1][:2], bytes((0x0b, 101)))
		self.assertEqual(after[0][1][2:], before[0][1][2:])
		self.assertEqual(after[1:], before[1:])
		new = pdf_get_rule(data, ord("a"), 0, 0xa1, 9)
		self.assertIsNotNone(new)
		self.assertEqual(rule_queues(data, new),
						 [(-2, bytes((0x0f, 1, 4, 0x0f, 2, 12, 0x0c, 1, 0x0e, 0, 0)))])
		self.assertIsNone(pdf_get_rule(data, ord("a"), 0, 0xa1, 8))
		# later rules moved and read the same; the constants still found
		for c, v, n, r in ((ord("z"), 0, -1, -1), (0xa1, 0, -1, -1), (ord("b"), 1, -1, -1)):
			if pdf_get_rule(src, c, v, n, r) is not None:
				self.assertEqual(rule_queues(data, pdf_get_rule(data, c, v, n, r)),
								 rule_queues(src, pdf_get_rule(src, c, v, n, r)))
		p, _, sec1, _ = pdf_sections(data)
		self.assertEqual((SH(p, sec1), SH(p, sec1 + 2)), (150, 320))
		self.assertEqual(H(p, 0x0e), H(src[4:], 0x0e) + 1)		# one weight more

	def test_trigrams(self):
		a, z, t, h, e = 1, 26, 20, 8, 5
		data = edited("dte-trigrams", COMMITTED[3][1],
					  lambda s: re.sub(r"^the 3$", "the 1", s, flags=re.M) + "zzz 2\n")
		self.assertEqual(trigram(data, t, h, e), 1)
		self.assertEqual(trigram(data, z, z, z), 2)
		self.assertEqual(trigram(read(COMMITTED[3][1]), z, z, z), 0)
		self.assertEqual(trigram(data, t, h, a), trigram(read(COMMITTED[3][1]), t, h, a))

	def test_refusals(self):
		with self.assertRaises(ValueError):
			edited("dte-main", COMMITTED[1][1], lambda t: t.replace("xrp !.0.1 ", "xrp !.0.9 ", 1))
		with self.assertRaises(ValueError):
			edited("ppd-main", COMMITTED[2][1], lambda t: t.replace("call CalculateAbs", "call NoSuchFunction", 1))
		with self.assertRaises(ValueError):
			edited("dte-trigrams", COMMITTED[3][1], lambda s: s + "the 2\n")


if __name__ == "__main__":
	if "--rom" in sys.argv:
		i = sys.argv.index("--rom")
		ROM_BUILD = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	unittest.main()
