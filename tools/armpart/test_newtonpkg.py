#!/usr/bin/env python3
"""Tests for tools/armpart/newtonpkg.py: every package in romsrc/rex (and,
unless --no-fixtures, every package under fixtures/packages) splits into its
text form and goes back together byte for byte, and edits - an instruction
inserted into a protocol part, the package renamed - give a package whose
parts, relocation chunk and frames parts' refs all moved along.

    python tools/armpart/test_newtonpkg.py [-v] [--packages DIR] [--no-fixtures]
"""

from __future__ import annotations

import glob
import os
import shutil
import struct
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "newton-rom", "analysis"))

import newtonarm		# noqa: E402
import newtonpkg		# noqa: E402
import packages			# noqa: E402

ROOT = os.path.join(HERE, "..", "..")
PACKAGES_DIR = os.path.join(ROOT, "romsrc", "rex")
FIXTURES = True		# (fixtures/packages, when the checkout has it)


def package_files():
	files = sorted(glob.glob(os.path.join(PACKAGES_DIR, "*.pkg")))
	if FIXTURES:
		for path in sorted(glob.glob(os.path.join(ROOT, "fixtures", "packages", "**", "*"), recursive=True)):
			if path.lower().endswith(".pkg"):
				with open(path, "rb") as f:
					if f.read(7) == b"package":
						files.append(path)
	return files


def load(name):
	with open(os.path.join(PACKAGES_DIR, name), "rb") as f:
		return f.read()


def directory(data):
	"""(the package's parse, the offset its parts start at)."""
	p = packages.parse_package(data, 0)
	base = p["directory_size"]
	if p["flags"] & newtonpkg.RELOCATION_FLAG:
		base += struct.unpack_from(">I", data, base + 4)[0]
	return p, base


class RoundTrip(unittest.TestCase):
	def test_every_package(self):
		files = package_files()
		self.assertGreaterEqual(len(files), 5)
		for path in files:
			with self.subTest(package=os.path.relpath(path, ROOT)):
				with open(path, "rb") as f:
					self.assertTrue(newtonpkg.roundtrips(f.read()))

	def test_the_text_form(self):
		tmp = tempfile.mkdtemp(prefix="newtonpkg-")
		try:
			newtonpkg.unpack(load("inetenbl.pkg"), tmp)
			names = sorted(os.listdir(tmp))
			self.assertIn("package.txt", names)
			self.assertIn("part2.s", names)
			self.assertIn("part0.bin", names)
			with open(os.path.join(tmp, "package.txt"), encoding="utf-8") as f:
				text = f.read()
			self.assertIn('name "Newton Internet Enabler\\0"', text)
			self.assertIn('trailer "Newton Toolkit 1.6.4b2c2\\0"', text)
			self.assertIn("relocation-page-size 1024", text)
			self.assertIn("\tfile part2.s", text)
		finally:
			shutil.rmtree(tmp)


class Edits(unittest.TestCase):
	def setUp(self):
		self.tmp = tempfile.mkdtemp(prefix="newtonpkg-")

	def tearDown(self):
		shutil.rmtree(self.tmp)

	def check_moved(self, old, new, moved):
		"""Every part of new is old's, moved by moved(old package offset) ->
		delta: protocol parts' relocated words and frames parts' refs with
		them; the relocation chunk names the moved words."""
		po, base_old = directory(old)
		pn, base_new = directory(new)
		self.assertEqual(len(po["parts"]), len(pn["parts"]))
		_, relocs_old = newtonarm.read_relocations(old, po["directory_size"]) if po["flags"] & newtonpkg.RELOCATION_FLAG else (0, [])
		_, relocs_new = newtonarm.read_relocations(new, pn["directory_size"]) if pn["flags"] & newtonpkg.RELOCATION_FLAG else (0, [])
		self.assertEqual(sorted(relocs_new), sorted(r + moved(r) for r in relocs_old))
		self.assertEqual(len(new), struct.unpack_from(">I", new, 28)[0])
		for i, (a, b) in enumerate(zip(po["parts"], pn["parts"])):
			so, sn = base_old + a["offset"], base_new + b["offset"]
			delta = moved(so)
			self.assertEqual(sn, so + delta, "part %d" % i)
			part_old = bytearray(old[so:so + a["size"]])
			part_new = new[sn:sn + b["size"]]
			if a["flags"] & 3 == 1 and delta:
				packages.rebase_frames_part(part_old, so, so + a["size"], delta, 4)
			for r in relocs_old:
				if so <= r < so + a["size"]:
					v = struct.unpack_from(">I", old, r)[0]
					if struct.unpack_from(">I", part_old, r - so)[0] == v:
						struct.pack_into(">I", part_old, r - so, v + moved(v))
			yield i, bytes(part_old), part_new

	def test_insert_an_instruction(self):
		"""`mov r0, r0` inserted into newtdev's protocol part 2: part 2 grows
		by four, everything after it moves along."""
		old = load("newtdev.pkg")
		newtonpkg.unpack(old, self.tmp)
		path = os.path.join(self.tmp, "part2.s")
		with open(path, encoding="utf-8") as f:
			lines = f.read().splitlines()
		at = next(i for i, line in enumerate(lines) if line.strip() == "mov ip, sp")
		lines.insert(at + 1, "\tmov r0, r0")
		with open(path, "w", encoding="utf-8") as f:
			f.write("\n".join(lines) + "\n")
		new = newtonpkg.pack(self.tmp)
		self.assertEqual(len(new), len(old) + 4)
		po, base = directory(old)
		part2 = base + po["parts"][2]["offset"]
		insertion = part2 + newtonarm.assemble("\n".join(lines), part2).lines[at + 2]	# (line numbers count from 1)
		moved = lambda o: 4 if o >= insertion else 0
		for i, before, after in self.check_moved(old, new, moved):
			if i == 2:
				p2 = newtonarm.assemble("\n".join(lines), part2)
				self.assertEqual(after, p2.data)
				self.assertEqual(struct.unpack_from(">I", after, insertion - part2)[0], 0xE1A00000)
			else:
				self.assertEqual(before, after, "part %d" % i)

	def test_rename(self):
		"""A longer name grows the directory: every part moves, the frames
		parts are rebased and the relocated words follow."""
		old = load("newtdev.pkg")
		newtonpkg.unpack(old, self.tmp)
		path = os.path.join(self.tmp, "package.txt")
		with open(path, encoding="utf-8") as f:
			text = f.read()
		self.assertIn('name " Newton Devices\\0"', text)		# (sic: NTK's leading space)
		text = text.replace('name " Newton Devices\\0"', 'name " Newton Devices, renamed\\0"')
		with open(path, "w", encoding="utf-8") as f:
			f.write(text)
		new = newtonpkg.pack(self.tmp)
		pn, _ = directory(new)
		self.assertEqual(pn["name"], " Newton Devices, renamed")
		grow = pn["directory_size"] - directory(old)[0]["directory_size"]
		self.assertEqual(grow, 20)
		for i, before, after in self.check_moved(old, new, lambda o: grow if o >= 1016 else 0):
			self.assertEqual(before, after, "part %d" % i)


if __name__ == "__main__":
	if "--packages" in sys.argv:
		i = sys.argv.index("--packages")
		PACKAGES_DIR = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	if "--no-fixtures" in sys.argv:
		FIXTURES = False
		sys.argv.remove("--no-fixtures")
	unittest.main()
