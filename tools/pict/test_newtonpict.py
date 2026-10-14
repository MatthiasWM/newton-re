#!/usr/bin/env python3
"""Tests of newtonpict.py (ctests tools.NewtonPict, tools.NewtonPictROM).

    python tools/pict/test_newtonpict.py [--rom build/MP2x00US]

Each of the 32 QuickDraw pictures committed under romsrc/ (a directory
with a picture.txt: picture(...) in the object files) is packed, unpacked
to the text form and packed again: the text must be the committed text,
the bytes must come back identical - with --rom, the ROM object's own
bytes, for the pictures named after their address - with nothing kept raw (no row's
packed bytes, padding bits, alignment byte or undecoded data), and
unpacking the packed bytes must write the same picture.txt.  Then edits
are tried on a copy: a pixel flipped in a PNG changes that one bit of the
picture and still unpacks; a PNG of another size is refused with a message
naming the bounds to set; and a synthetic version 2 picture with an
opcode of every operand kind, a nonzero alignment byte, a row packed
unlike any packer, padding bits, a mask region and an undecoded pixel map
round-trips, as does a version 1 picture with rows of more than 250 bytes
(a word count) and bytes after OpEndPic.
"""
import os
import struct
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import newtonpict as np			# noqa: E402
sys.path.insert(0, os.path.join(HERE, "..", "imaging"))
import png						# noqa: E402

ROOT = os.path.normpath(os.path.join(HERE, "..", ".."))
ROMSRC = os.path.join(ROOT, "romsrc")
ROM_BUILD = None


def committed():
	"""The committed pictures: each a directory with a picture.txt
	(picture(...) in romsrc/'s object files)."""
	found = []
	for top, dirs, files in os.walk(ROMSRC):
		if np.TEXT in files:
			found.append(top)
	return sorted(found)


def picture(path):
	"""A committed picture's bytes: its directory packed."""
	return np.pack(path)


def read_text(path):
	with open(path, encoding="utf-8") as f:
		return f.read()


def bitmaps(data):
	return [item[1] for item in np.parse(data)[3] if item[0] == "bits"]


class RoundTrip(unittest.TestCase):
	def test_committed(self):
		files = committed()
		self.assertEqual(len(files), 32)
		rom = None
		if ROM_BUILD:
			with open(os.path.join(ROM_BUILD, "rom.bin"), "rb") as f:
				rom = f.read()
		with tempfile.TemporaryDirectory() as tmp:
			for path in files:
				with self.subTest(os.path.relpath(path, ROMSRC)):
					data = picture(path)
					a = os.path.join(tmp, "a")
					b = os.path.join(tmp, "b")
					notes = np.unpack_notes(data, a)
					self.assertEqual(notes, [])
					self.assertEqual(read_text(os.path.join(a, np.TEXT)), read_text(os.path.join(path, np.TEXT)))
					packed = np.pack(a)
					self.assertEqual(packed, data)
					np.unpack(packed, b)
					self.assertEqual(read_text(os.path.join(a, np.TEXT)), read_text(os.path.join(b, np.TEXT)))
					name = os.path.basename(path)
					if rom is not None and all(c in "0123456789abcdef" for c in name):
						address = int(name, 16) - 1		# (the object's ref, named by romsrc.py)
						size = struct.unpack(">I", rom[address:address + 4])[0] >> 8
						self.assertEqual(data, rom[address + 12:address + size], "%s is not the ROM's" % name)

	def test_cli_check(self):
		with tempfile.TemporaryDirectory() as tmp:
			files = []
			for k, path in enumerate(committed()):
				out = os.path.join(tmp, "%d.pict" % k)
				with open(out, "wb") as f:
					f.write(bytes(np.PICT_HEADER) + picture(path))
				files.append(out)
			out = subprocess.run([sys.executable, os.path.join(HERE, "newtonpict.py"), "check"] + files,
								 capture_output=True, text=True)
		self.assertEqual(out.returncode, 0, out.stdout + out.stderr)
		self.assertEqual(out.stdout.count(": identical\n"), 32)


class Editing(unittest.TestCase):
	SRC = os.path.join(ROMSRC, "resources", "picture", "432fe5")

	def test_flip_pixel(self):
		data = picture(self.SRC)
		with tempfile.TemporaryDirectory() as tmp:
			d = os.path.join(tmp, "p")
			np.unpack(data, d)
			name = os.path.join(d, "bits1.png")
			w, h, levels = png.read_gray(name, 1)
			x, y = 37, 50
			levels[y][x] ^= 1
			png.write_gray(name, w, h, levels, 1)
			edited = np.pack(d)
			self.assertNotEqual(edited, data)
			before, = bitmaps(data)
			after, = bitmaps(edited)
			for row in range(h):
				if row != y:
					self.assertEqual(before["rows"][row], after["rows"][row])
			diff = bytes(p ^ q for p, q in zip(before["rows"][y], after["rows"][y]))
			want = bytearray(len(diff))
			want[x >> 3] = 0x80 >> (x & 7)
			self.assertEqual(diff, bytes(want))
			self.assertEqual(struct.unpack(">H", edited[:2])[0], len(edited) & 0xffff)
			again = os.path.join(tmp, "q")
			np.unpack(edited, again)
			self.assertEqual(np.pack(again), edited)
			self.assertEqual(png.read_gray(os.path.join(again, "bits1.png"), 1)[2], levels)

	def test_size_change_reported(self):
		with tempfile.TemporaryDirectory() as tmp:
			d = os.path.join(tmp, "p")
			np.unpack(picture(self.SRC), d)
			name = os.path.join(d, "bits1.png")
			w, h, levels = png.read_gray(name, 1)
			png.write_gray(name, w + 16, h, [row + [1] * 16 for row in levels], 1)
			with self.assertRaises(np.PictError) as e:
				np.pack(d)
			self.assertIn("set bounds to 132 8 233 136", str(e.exception))
			text = read_text(os.path.join(d, np.TEXT)).replace("bounds 132 8 233 120", "bounds 132 8 233 136")
			with open(os.path.join(d, np.TEXT), "w", encoding="utf-8", newline="\n") as f:
				f.write(text)
			wider, = bitmaps(np.pack(d))
			self.assertEqual(wider["rowBytes"], 16)			# rowBytes auto follows the width


def v2_synthetic():
	body = bytearray()
	body += b"\x00\x11\x02\xff"
	body += struct.pack(">Hiiiiii", 0x0c00, -1, 0, 0, 40 << 16, 20 << 16, 0)
	body += struct.pack(">H", 0x001e)
	body += struct.pack(">HH4h", 0x0001, 10, 0, 0, 20, 40)
	body += struct.pack(">HB", 0x0004, 1) + b"\x55"						# TxFace, a nonzero alignment byte
	body += struct.pack(">Hhh", 0x0028, 12, 3) + bytes([5]) + b'H"\\\x01i'	# LongText
	body += struct.pack(">HH4h4h", 0x0071, 18, 0, 0, 10, 10, 1, 2, 3, 4)	# paintPoly
	body += struct.pack(">HH4h", 0x0081, 14, 0, 0, 5, 5) + b"\x00\x01\x7f\xff"	# paintRgn
	body += struct.pack(">HHH", 0x00a1, 100, 3) + b"abc" + b"\x00"			# LongComment, aligned
	body += struct.pack(">Hi", 0x0006, 0x18000)							# SpExtra 1.5
	body += struct.pack(">H3H", 0x001a, 0xffff, 0x8000, 0)					# RGBFgCol
	body += struct.pack(">H", 0x0009) + bytes(range(8))					# PnPat
	# PackBitsRgn: 70 pixels in 10 bytes a row, three rows
	rows = [bytes(10), bytes([0xaa] * 8 + [0, 0]), bytes([1, 2, 3, 3, 3, 3, 4, 5, 6, 0x03])]
	body += struct.pack(">HH4h4h4hH", 0x0099, 10, 0, 0, 3, 70, 0, 0, 3, 70, 0, 0, 3, 70, 1)
	body += struct.pack(">H4h", 10, 0, 0, 3, 70)
	body += bytes([2, 0xf7, 0])													# row 0: classic
	body += bytes([11, 9]) + rows[1]												# row 1: one literal (not the packer's)
	body += bytes([10, 1, 1, 2, 0xfd, 3, 3, 4, 5, 6, 3])							# row 2: classic, padding bits set
	# BitsRect, 12 pixels in rowBytes 4 (auto would be 2)
	body += struct.pack(">HH4h4h4hH", 0x0090, 4, 0, 0, 2, 12, 0, 0, 2, 12, 0, 0, 2, 12, 0)
	body += bytes([0xff, 0xf0, 0, 0, 0x80, 0x10, 0, 0])
	# a pixel map: kept as data with all after it
	body += struct.pack(">HH", 0x0098, 0x8000 | 8) + bytes(40) + struct.pack(">H", 0x00ff)
	return struct.pack(">H4h", (10 + len(body)) & 0xffff, 0, 0, 20, 40) + bytes(body)


def v1_synthetic():
	body = bytearray(b"\x11\x01")
	body += struct.pack(">BH4h", 0x01, 10, 0, 0, 2, 2400)
	body += struct.pack(">B", 0xa0) + struct.pack(">H", 130)
	row0 = bytes(300)
	row1 = bytes(range(256)) + bytes(44)
	body += struct.pack(">BH4h4h4hH", 0x98, 300, 0, 0, 2, 2400, 0, 0, 2, 2400, 0, 0, 2, 2400, 0)
	for row in (row0, row1):
		pk = np.pack_bits(row, "classic")
		body += struct.pack(">H", len(pk)) + pk
	body += b"\xff" + b"junk"
	return struct.pack(">H4h", (10 + len(body)) & 0xffff, 0, 0, 2, 2400) + bytes(body)


class Synthetic(unittest.TestCase):
	def test_v2(self):
		data = v2_synthetic()
		with tempfile.TemporaryDirectory() as tmp:
			d = os.path.join(tmp, "p")
			notes = np.unpack_notes(data, d)
			self.assertEqual(np.pack(d), data)
			self.assertIn("pad", notes)
			self.assertIn("bits1.png row 1 packed", notes)
			self.assertIn("bits1.png row 2 padding", notes)
			self.assertTrue(any(n.startswith("data: a pixel map") for n in notes))
			text = read_text(os.path.join(d, np.TEXT))
			for line in ("TxFace 1", "pad 0x55", 'LongText 12 3 "H\\"\\\\\\x01i"',
						 "paintPoly 0 0 10 10 1 2 3 4", "paintRgn 0 0 5 5 00017fff",
						 "LongComment 100 616263", "SpExtra 1.5", "RGBFgCol 0xffff 0x8000 0x0000",
						 "PnPat 0001020304050607", "PackBitsRgn bits1.png", "maskRgn 0 0 3 70",
						 "packed 1 09aaaaaaaaaaaaaaaa0000", "padding 2 00000000000000000203",
						 "BitsRect bits2.png", "rowBytes 4", "mode srcOr"):
				self.assertIn(line, text)
			# an edit of the row kept raw packs it afresh
			name = os.path.join(d, "bits1.png")
			w, h, levels = png.read_gray(name, 1)
			levels[1][0] ^= 1
			png.write_gray(name, w, h, levels, 1)
			bits, = bitmaps(np.pack(d))[:1]
			self.assertEqual(bits["rows"][1], bytes([0x2a] + [0xaa] * 7 + [0, 0]))
			self.assertEqual(bits["rows"][2], bytes([1, 2, 3, 3, 3, 3, 4, 5, 6, 0x03]))

	def test_v1(self):
		data = v1_synthetic()
		with tempfile.TemporaryDirectory() as tmp:
			d = os.path.join(tmp, "p")
			notes = np.unpack_notes(data, d)
			self.assertEqual(np.pack(d), data)
			self.assertEqual(notes, ["data: after OpEndPic"])

	def test_packbits(self):
		self.assertEqual(np.pack_bits(bytes([1, 1]), "classic"), bytes([0xff, 1]))
		self.assertEqual(np.pack_bits(bytes([1, 1]), "runs3"), bytes([1, 1, 1]))
		self.assertEqual(np.pack_bits(bytes([1, 1, 2]), "classic"), bytes([2, 1, 1, 2]))
		self.assertEqual(np.pack_bits(bytes(130), "classic"), bytes([0x81, 0, 0xff, 0]))
		self.assertEqual(np.pack_bits(bytes(129), "classic"), bytes([0x81, 0, 0, 0]))
		self.assertEqual(np.pack_bits(bytes(4), "none"), bytes([3, 0, 0, 0, 0]))
		row = bytes((i * 7) % 5 for i in range(300))
		for packing in np.PACKINGS:
			self.assertEqual(np.unpack_bits(np.pack_bits(row, packing), 0, 300)[0], row)


if __name__ == "__main__":
	if "--rom" in sys.argv:
		i = sys.argv.index("--rom")
		ROM_BUILD = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	unittest.main()
