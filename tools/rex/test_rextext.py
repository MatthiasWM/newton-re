#!/usr/bin/env python3
"""Tests of rextext.py (ctests tools.RExText, tools.RExTextROM).

    python tools/rex/test_rextext.py [--rom build/MP2x00US]

Every text piece of romsrc/rex.tsv and romsrc/romdata.tsv is built where
rex.tsv puts it, written back as text by the extractor's writers and
built again to the same bytes; with --rom the bytes must be the ROM's own
at the piece's address (the package directories with the parts' sizes
the ROM has: help_book's part has grown since, which the builder's
layout follows).  Then edits are read back: a pin table's word, a
package's name (the directory grows and its InfoRefs move), a patch
table's target, a parameter block's word, the header following a piece
that grew, and the mistakes a reader is told of.
"""
import os
import struct
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import rextext					# noqa: E402

ROMSRC = os.path.join(HERE, "..", "..", "romsrc")
ROM_BUILD = None


def committed():
	"""The tree's text pieces: (rel, address, built bytes)."""
	layout = rextext.tree_layout(ROMSRC)
	out = []
	for rel, offset, size in layout.pieces:
		if rel.endswith(".txt"):
			out.append((rel, layout.base + offset, rextext.parse(os.path.join(ROMSRC, rel)).render(layout, rel)))
	with open(os.path.join(ROMSRC, "romdata.tsv"), encoding="utf-8") as f:
		for line in f:
			if not line.startswith("#"):
				address, _, rel = line.rstrip("\n").split("\t")
				if rel.endswith(".txt"):
					out.append((rel, int(address, 16), rextext.pack(os.path.join(ROMSRC, rel))))
	return layout, out


def whole_package_at(layout, address):
	"""(a package rex.tsv keeps whole as text - a directory with a
	package.txt - that address is in, the offset), or None."""
	for rel, offset, size in layout.pieces:
		if rel.endswith("/") and os.path.exists(os.path.join(ROMSRC, rel, "package.txt")) \
				and layout.base + offset <= address < layout.base + offset + size:
			return rel, address - layout.base - offset
	return None


def text_piece(text):
	return rextext._from_text(text)


def read(rel):
	with open(os.path.join(ROMSRC, rel), encoding="utf-8") as f:
		return f.read()


class RoundTrip(unittest.TestCase):
	def test_committed(self):
		layout, pieces = committed()
		self.assertEqual(len(pieces), 20)			# the header, 3 config tables, 8 directories, 3 pads, 2 page tables, 'fexp, 'jump; gParamBlock
		rom = None
		if ROM_BUILD:
			with open(os.path.join(ROM_BUILD, "rom.bin"), "rb") as f:
				rom = f.read()
		for rel, address, data in pieces:
			with self.subTest(rel):
				if rel.startswith("rex/"):
					self.assertEqual(len(data), layout.at(rel, rel)[1])
				if rom is not None:
					self.assertEqual(data, rom[address:address + len(data)], "%s is not the ROM's bytes" % rel)
				piece = rextext.parse(os.path.join(ROMSRC, rel))
				again = self.unpacked(piece, data, address, layout, rel)
				self.assertIsNotNone(again, "%s: no text gives the bytes back" % rel)

	def unpacked(self, piece, data, address, layout, rel):
		"""The writer's text for the bytes (None if it would not give them back)."""
		if isinstance(piece, rextext.Header):
			return rextext.header_text(data, layout, rel)
		if isinstance(piece, rextext.ConfigTable):
			tag = [t for t, cols in rextext.CONFIG_COLUMNS.items() if tuple(piece.columns) == cols][0]
			return rextext.config_table_text(tag, data)
		if isinstance(piece, rextext.PageTable):
			return rextext.page_table_text(b"ptpt", data)
		if isinstance(piece, rextext.Refs):
			return rextext.refs_text(data)
		if isinstance(piece, rextext.PatchTable):
			return rextext.patch_table_text(data, piece.at, piece_of=lambda a: whole_package_at(layout, a), layout=layout)
		if isinstance(piece, rextext.Pad):
			return rextext.pad_text(data, address, piece.align)
		if isinstance(piece, rextext.PackageDirectory):
			return rextext.package_directory_text(data, layout, rel)
		return rextext.words_text(data, address)

	def test_writers_give_the_committed_text(self):
		# what the extractor would write is what is committed (the writers
		# that need nothing but the bytes and the layout)
		layout, pieces = committed()
		for rel, address, data in pieces:
			piece = rextext.parse(os.path.join(ROMSRC, rel))
			with self.subTest(rel):
				if isinstance(piece, rextext.Header):
					self.assertEqual(rextext.header_text(data, layout, rel), read(rel))
				elif isinstance(piece, rextext.PackageDirectory):
					name = os.path.basename(rel)[:-len(".head.txt")]
					self.assertEqual(rextext.package_directory_text(data, layout, rel, name), read(rel))
				elif isinstance(piece, rextext.Pad):
					self.assertEqual(rextext.pad_text(data, address, piece.align), read(rel))
				elif isinstance(piece, rextext.ConfigTable):
					tag = os.path.basename(rel)[:4].replace("_", " ").encode("latin-1")		# (dio_71fcf8.txt: 'dio ')
					self.assertEqual(rextext.config_table_text(tag, data), read(rel))
				elif isinstance(piece, rextext.PageTable):
					self.assertEqual(rextext.page_table_text(os.path.basename(rel)[:4].encode("latin-1"), data), read(rel))


class Edits(unittest.TestCase):
	def test_config_row(self):
		text = read("rex/gpio_71ff40.txt")
		before = text_piece(text).data()
		edited = text.replace("row\t15\t0x8000\t0\t0\t1\t", "row\t15\t0x8000\t1\t0\t1\t", 1)
		self.assertNotEqual(edited, text)
		after = text_piece(edited).data()
		# row 15's dir word: after the version and count, 15 rows of 10 words, then bit and mask
		at = 8 + 15 * 40 + 8
		self.assertEqual(struct.unpack_from(">I", after, at)[0], 1)
		self.assertEqual(before[:at] + before[at + 4:], after[:at] + after[at + 4:])
		# a row more: the count follows
		more = text_piece(edited + "row\t16\t0x10000\t0\t0\t0\t0\t0\t0\t0\t0\n").data()
		self.assertEqual(struct.unpack_from(">I", more, 4)[0], 17)
		self.assertEqual(len(more), len(after) + 40)

	def test_package_name(self):
		layout = rextext.tree_layout(ROMSRC)
		rel = "rex/Setup.head.txt"
		text = read(rel)
		before = text_piece(text).render(layout, rel)
		edited = text_piece(text.replace('name\t"Setup"', 'name\t"Setup and more"'))
		size = edited.size(0)
		self.assertEqual(size % 4, 0)			# (what the strings need, padded to a word)
		self.assertGreater(size, len(before))
		# a layout with the directory grown: its part after it
		pieces = []
		grow = size - len(before)
		for r, offset, n in layout.pieces:
			pieces.append((r, offset + (grow if offset > layout.at(rel, rel)[0] else 0), size if r == rel else n))
		grown = rextext.Layout(layout.base, layout.length + grow, pieces)
		after = edited.render(grown, rel)
		self.assertEqual(len(after), size)
		(co_off, co_len, nm_off, nm_len, pkg_size) = struct.unpack_from(">HHHHI", after, 20)
		dir_size = struct.unpack_from(">I", after, 44)[0]
		base = 52 + 32
		self.assertEqual(after[base + nm_off:base + nm_off + nm_len].decode("utf-16-be"), "Setup and more\0")
		part_size = layout.at("rex/Setup/", "test")[1]
		self.assertEqual((dir_size, pkg_size), (size, size + part_size))
		self.assertEqual(struct.unpack_from(">II", after, 52 + 4), (part_size, part_size))
		info_off, info_len = struct.unpack_from(">HH", after, 52 + 24)
		self.assertEqual(after[base + info_off:base + info_off + info_len], b"A Newton Toolkit application")

	def test_patch_target(self):
		layout, _ = committed()
		text = read("rex/jump_7ee000.txt")
		# an entry given as an address
		piece = text_piece(text.replace("rex/ScreenBuffer/\t+0x144", "0x007a56a8", 1))
		word = struct.unpack_from(">I", piece.render(layout, "rex/jump_7ee000.txt"), 4)[0]
		self.assertEqual(rextext.branch(0x01e00004, 0x007a56a8, "test"), word)
		self.assertEqual(word >> 24, 0xea)
		with self.assertRaises(ValueError):
			text_piece(text.replace("rex/ScreenBuffer/\t+0x144", "0x007a5699", 1)).render(layout, "rex/jump_7ee000.txt")		# not a word's address
		# an entry naming a piece follows it where it lies
		moved = rextext.Layout(layout.base, layout.length, [(rel, offset + (0x100 if rel == "rex/ScreenBuffer/" else 0), size)
														  for rel, offset, size in layout.pieces])
		word = struct.unpack_from(">I", text_piece(text).render(moved, "rex/jump_7ee000.txt"), 4)[0]
		self.assertEqual(rextext.branch(0x01e00004, 0x007a5554 + 0x100 + 0x144, "test"), word)
		with self.assertRaises(ValueError):
			text_piece(text).data()						# (it needs the layout)

	def test_param_block(self):
		text = read("romdata/gParamBlock.txt")
		data = text_piece(text.replace("gROMVersion\t0x00020002", "gROMVersion\t0x00020003")).data()
		self.assertEqual(len(data), 0x1000)
		self.assertEqual(struct.unpack_from(">I", data, 0x3dc)[0], 0x00020003)
		with self.assertRaises(ValueError):						# a line left out: the next one's address is wrong
			text_piece(text.replace("0x13e0\tgROMStage\t0x00008000\n", "")).data()

	def test_header_follows(self):
		layout = rextext.tree_layout(ROMSRC)
		header = rextext.parse(os.path.join(ROMSRC, "rex/header.txt"))
		before = header.render(layout, "rex/header.txt")
		# the gpio table one row longer: everything after it moves on 40 bytes
		gpio = layout.at("rex/gpio_71ff40.txt", "test")[0]
		pieces = [(r, o + (40 if o > gpio else 0), n + (40 if o == gpio else 0)) for r, o, n in layout.pieces]
		after = header.render(rextext.Layout(layout.base, layout.length + 40, pieces), "rex/header.txt")
		self.assertEqual(struct.unpack_from(">I", after, 0x18)[0], layout.length + 40)
		entries = lambda d: [struct.unpack_from(">4sII", d, 0x28 + 12 * i) for i in range(struct.unpack_from(">I", d, 0x24)[0])]
		for (t, o, n), (t2, o2, n2) in zip(entries(before), entries(after)):
			self.assertEqual(t, t2)
			self.assertEqual(o2, o + 40 if o > gpio else o)
			self.assertEqual(n2, n + 40 if t == b"gpio" else n)

	def test_mistakes(self):
		for text in ("format rex-header\nentry\t'pkgl'\trex/x.txt\n",			# no signature
					 "format nonsense\n",
					 "format words\n0x1000\tword\t1\n",							# no `at`
					 "format config-table\nversion\t1\ncolumns\ta\tb\nrow\t1\n",	# a short row
					 "format page-table\n1-2\t0x1000\t0x2\n",					# not from 0
					 "format pad\nfill\t0\nalign\t3\n"):
			with self.subTest(text.split("\n")[0]):
				with self.assertRaises(ValueError):
					text_piece(text).data()


if __name__ == "__main__":
	if "--rom" in sys.argv:
		i = sys.argv.index("--rom")
		ROM_BUILD = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	unittest.main()
