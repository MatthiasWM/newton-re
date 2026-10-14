#!/usr/bin/env python3
"""Tests of inktables.py.

    python tools/tables/test_inktables.py [--rom build/MP2x00US]

The four committed tables the formats were made for - the two ink code
books, the trigrams and the Letter Shapes pictures, texttable(...) in
romsrc/ - are packed, unpacked and packed back to the same bytes, and the
text unpacked again is the committed text; with --rom, the bytes must be the ROM's own - the object at the
address the file is named after (its data after the 12-byte object
header).  Then edits are read back: a code word's value changed and a code
word added (the table's size and count grow and the entry lands among
the codes of its length), a trigram's weight changed and one added, a
point moved and a stroke added to a picture (every later offset moves).
"""
import os
import struct
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import inktables				# noqa: E402

RES = os.path.join(HERE, "..", "..", "romsrc", "resources")
ROM_BUILD = None
COMMITTED = (
	("code-book", os.path.join(RES, "Comp", "5bc4ed.txt")),			# Rparagraphcodebook1, the writing book
	("code-book", os.path.join(RES, "Comp", "63dedd.txt")),			# Rparagraphcodebook2 (@145), the ink book
	("trigrams", os.path.join(RES, "Trigrams", "5ba4b1.txt")),		# Rtrig
	("letter-images", os.path.join(RES, "letterimages", "5c2e69.txt")),
)


def read(path):
	with open(path, "rb") as f:
		return f.read()


def committed_bytes(path):
	"""A committed table's bytes: its text packed."""
	return inktables.pack(path)


def text_of(format, path, tmp):
	out = os.path.join(tmp, "t.txt")
	inktables.unpack(committed_bytes(path), format, out)
	with open(out, encoding="utf-8") as f:
		return f.read()


def pack_text(format, text):
	return inktables.pack_lines(format, text.split("\n"), HERE)


class RoundTrip(unittest.TestCase):
	def test_committed(self):
		rom = read(os.path.join(ROM_BUILD, "rom.bin")) if ROM_BUILD else None
		with tempfile.TemporaryDirectory() as tmp:
			for format, path in COMMITTED:
				with self.subTest(os.path.basename(path)):
					data = committed_bytes(path)
					text = text_of(format, path, tmp)
					with open(path, encoding="utf-8") as f:
						self.assertEqual(f.read(), text)
					packed = pack_text(format, text)
					self.assertEqual(packed, data)
					out = os.path.join(tmp, "again.txt")
					inktables.unpack(packed, format, out)
					with open(out, encoding="utf-8") as f:
						self.assertEqual(f.read(), text)
					with open(out, "w", encoding="utf-8", newline="\n") as f:
						f.write(text)
					self.assertEqual(inktables.pack(out), data)
					if rom is not None:
						address = int(os.path.splitext(os.path.basename(path))[0], 16) - 1
						size = struct.unpack(">I", rom[address:address + 4])[0] >> 8
						self.assertEqual(packed, rom[address + 12:address + size])

	def test_wrong_format(self):
		with self.assertRaises(ValueError):
			inktables.pack_lines("trigrams", ["format code-book"], HERE)


class Editing(unittest.TestCase):
	def setUp(self):
		self.tmp = tempfile.TemporaryDirectory()

	def tearDown(self):
		self.tmp.cleanup()

	def edited(self, which, change):
		format, path = COMMITTED[which]
		text = text_of(format, path, self.tmp.name)
		new = change(text)
		self.assertNotEqual(new, text, "the edit changed nothing")
		return committed_bytes(path), pack_text(format, new)

	def test_code_word_value(self):
		# the ink book's first table, first entry: 5 1000
		old, new = self.edited(1, lambda t: t.replace("\n5 1000\n", "\n-5 1000\n", 1))
		self.assertEqual(struct.unpack(">h", new[12:14])[0], -5)
		self.assertEqual(new[14:], old[14:])

	def test_code_word_added(self):
		# The books' codes are complete (every string of bits begins with
		# one), so a value is added by splitting a code in two: the ink
		# book's first table's last entry (43, a 15-bit code) gets the code
		# with a 0 after it and 1234 the code with a 1.  The table grows by
		# eight bytes, its count by one, and every later table moves along.
		def change(t):
			first = t[t.index("\ntable 0"):t.index("\ntable 1")]
			value, bits = first.strip().split("\n")[-1].split()
			self.assertEqual((value, len(bits)), ("43", 15))
			return t.replace("\n43 %s\n" % bits, "\n43 %s0\n1234 %s1\n" % (bits, bits), 1)
		old, new = self.edited(1, change)
		size, count = struct.unpack(">HH", old[:4])
		self.assertEqual(struct.unpack(">HH", new[:4]), (size + 8, count + 1))
		self.assertEqual(len(new), len(old) + 8)
		was = struct.unpack(">hHI", old[size - 8:size])
		entries = [struct.unpack(">hHI", new[12 + 8 * i:20 + 8 * i]) for i in range(count + 1)]
		self.assertEqual(entries[-2], (43, 16, was[2]))
		self.assertEqual(entries[-1], (1234, 16, was[2] | 0x8000))
		self.assertEqual(new[size + 8:], old[size:])

	def test_code_word_prefix_refused(self):
		# "1000" is already a code: one beginning with it would never be read
		with self.assertRaises(ValueError):
			self.edited(1, lambda t: t.replace("\ntable 1", "\n77 10001\n\ntable 1", 1))

	def test_trigram(self):
		def change(t):
			t = t.replace("\nthe 3\n", "\nthe 1\n")
			return t.replace("\naar 3\n", "\naar 3\nqqq 2\n")
		old, new = self.edited(2, change)

		def weight(d, s):
			i = 0
			for ch in s:
				i = i * 32 + ord(ch) - ord("a") + 1
			return (d[i >> 2] >> (2 * (i & 3))) & 3
		self.assertEqual((weight(old, "the"), weight(new, "the")), (3, 1))
		self.assertEqual((weight(old, "qqq"), weight(new, "qqq")), (0, 2))
		self.assertEqual(sum(a != b for a, b in zip(old, new)), 2)

	def test_letter_point_and_stroke(self):
		# '!' is the first letter: its first stroke's first point moved, and
		# a third stroke (one point) added to it
		def change(t):
			t = t.replace("stroke 127,22 127,58", "stroke 120,20 127,58", 1)
			return t.replace("stroke 127,168\n", "stroke 127,168\nstroke 140,168\n", 1)
		old, new = self.edited(3, change)
		self.assertEqual(len(new), len(old) + 2 + 3)
		count = struct.unpack(">I", new[:4])[0]
		self.assertEqual(new[4:6], b"\x21\x01")
		v = struct.unpack(">H", new[6:8])[0]
		self.assertEqual(new[v:v + 2], b"\x00\x03")
		s1, s2, s3 = struct.unpack(">3H", new[v + 2:v + 8])
		self.assertEqual(new[s1:s1 + 3], bytes([5, 120, 20]))
		self.assertEqual(new[s3:s3 + 3], bytes([1, 140, 168]))
		self.assertEqual(s3, s2 + 3)
		# the next letter's first variant two bytes on, its strokes five on
		self.assertEqual(count, struct.unpack(">I", old[:4])[0])
		v2_old = struct.unpack(">H", old[10:12])[0]
		v2_new = struct.unpack(">H", new[10:12])[0]
		self.assertEqual(v2_new, v2_old + 2)
		self.assertEqual(struct.unpack(">H", new[v2_new + 2:v2_new + 4])[0],
						 struct.unpack(">H", old[v2_old + 2:v2_old + 4])[0] + 5)


if __name__ == "__main__":
	if "--rom" in sys.argv:
		i = sys.argv.index("--rom")
		ROM_BUILD = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	unittest.main()
