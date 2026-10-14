#!/usr/bin/env python3
"""Tests of newtonstore.py (ctests tools.NewtonStore, tools.NewtonStoreROM,
host.NewtonStoreMount).

    python tools/stores/test_newtonstore.py [--rom build/MP2x00US] [--newton <newton>]

The WorldData package's store - romsrc/rex/WorldData.pkg when the tree
keeps the package whole, the ROM extension's own with --rom - unpacks and
packs back to its bytes; a tree that keeps it unpacked
(romsrc/rex/WorldData/) packs and unpacks back to its own text, and to the
package's bytes.  The character tables built in are romsrc's.  Then edits
are read back: an entry renamed, one added and one removed, an entry's
slots written in another order, a key of the wrong type.  With --newton,
the edited store is put in a package of its own and mounted by the host,
whose queries must find the edits - by the name index, the country index
and the word hints.  Temporary files go under the repository's tmp/.
"""

import io
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import newtonstore as ns		# noqa: E402

ROOT = os.path.normpath(os.path.join(HERE, "..", ".."))
ROMSRC = os.path.join(ROOT, "romsrc")
PACKAGE = os.path.join(ROMSRC, "rex", "WorldData.pkg")
TREE = os.path.join(ROMSRC, "rex", "WorldData")
TMP = os.path.join(ROOT, "tmp")
ROM_BUILD = None
NEWTON = None


def rom_package():
	"""The WorldData package as the ROM extension holds it (--rom)."""
	sys.path.insert(0, os.path.join(ROOT, "tools", "newton-rom", "analysis"))
	import packages
	rom, pkgs = packages.rex_packages(ROM_BUILD)
	pkg = next(p for p in pkgs if p["name"] == "WorldData")
	return rom[pkg["base"]:pkg["base"] + pkg["size"]]


def package_bytes():
	"""The WorldData package: the ROM's (--rom), else the tree's .pkg; None
	when neither is there."""
	if ROM_BUILD:
		return rom_package()
	if os.path.exists(PACKAGE):
		with open(PACKAGE, "rb") as f:
			return f.read()
	head = os.path.join(ROMSRC, "rex", "WorldData.head.txt")
	if os.path.exists(head) and os.path.isdir(TREE):
		# the tree's: its directory (tools/rex/rextext.py, laid out as rex.tsv
		# has the pieces) and the store packed
		sys.path.insert(0, os.path.join(ROOT, "tools", "rex"))
		import rextext
		return rextext.parse(head).render(rextext.tree_layout(ROMSRC), "rex/WorldData.head.txt") + ns.pack(TREE)
	return None


def part_of(package):
	offset, size = ns.soup_part(package)
	return package[offset:offset + size]


def worlddata_part():
	package = package_bytes()
	if package is not None:
		return part_of(package)
	if os.path.isdir(TREE):
		return ns.pack(TREE)
	raise unittest.SkipTest("no WorldData package or tree")


def read(path):
	with open(path, encoding="utf-8") as f:
		return f.read()


def write(path, text):
	with open(path, "w", encoding="utf-8", newline="\n") as f:
		f.write(text)


class Tables(unittest.TestCase):
	def test_romsrc(self):
		"""The tables built in are romsrc's: the Mac Roman map, the folding
		(charClass + upperNoMarkList), the break table."""
		if not os.path.isdir(os.path.join(ROMSRC, "objects")):
			self.skipTest("no romsrc tree")
		mac, fold, delims = ns.tables_from_romsrc(ROMSRC)
		self.assertEqual(mac, ns.MAC_ROMAN)
		self.assertEqual(fold, ns.FOLD)
		self.assertEqual(delims, ns.DELIMITERS)

	def test_characters(self):
		self.assertEqual(ns.canonical_character(ord("e")), ord("E"))
		self.assertEqual(ns.canonical_character(0xe9), ord("E"))		# é
		self.assertEqual(ns.canonical_character(0x4e00), 0x1a)		# no Mac Roman form
		self.assertTrue(ns.is_delimiter(ord(" ")) and ns.is_delimiter(ord(",")))
		self.assertFalse(ns.is_delimiter(ord("a")) or ns.is_delimiter(ord("_")) or ns.is_delimiter(0xe9))

	def test_unicode_coder(self):
		text = "São Paulo 東京 " + "x" * 300
		data = text.encode("utf-16-be") + b"\0\0"
		packed = ns.unicode_compress(data)
		self.assertLess(len(packed), len(data))
		self.assertEqual(ns.unicode_decompress(packed), data)


class RoundTrip(unittest.TestCase):
	def setUp(self):
		os.makedirs(TMP, exist_ok=True)
		self.dir = tempfile.mkdtemp(prefix="newtonstore-", dir=TMP)

	def tearDown(self):
		shutil.rmtree(self.dir, ignore_errors=True)

	def test_part(self):
		"""Unpacked and packed back: the same bytes; and the only object
		not derived is a B-tree node's parent id."""
		data = worlddata_part()
		self.assertEqual(len(data), 225736)
		ns.unpack(data, self.dir)
		self.assertEqual(ns.pack(self.dir), data)
		package = package_bytes()
		if package is not None:
			self.assertEqual(ns.replace_soup_part(package, data), package)
		entries = read(os.path.join(self.dir, "entries.ns"))
		self.assertEqual(len(re.findall(r"^\{", entries, re.M)), 753)
		self.assertEqual(len(re.findall(r"^soup\(", entries, re.M)), 9)
		self.assertIn('{_uniqueID: 0, _modTime: 0, name: "Kabul", airport: "KBL"', entries)
		overrides = [line.split("\t") for line in read(os.path.join(self.dir, "overrides.txt")).splitlines()
					 if line and not line.startswith("#")]
		self.assertEqual(len(overrides), 1)
		for object_id, label, digest, patch in overrides:
			self.assertIn(" node ", label)
			for run in patch.split():
				offset, data_hex = run.split(":")
				self.assertTrue(4 <= int(offset) and int(offset) + len(data_hex) // 2 <= 8, "only the parent id")

	def test_tree(self):
		"""A tree that keeps the store unpacked packs to the package's bytes
		and unpacks back to its own text."""
		if not os.path.isdir(TREE):
			self.skipTest("romsrc keeps WorldData as a package")
		data = ns.pack(TREE)
		package = package_bytes()
		if package is not None:
			self.assertEqual(data, part_of(package))
		ns.unpack(data, self.dir)
		for name in sorted(os.listdir(TREE)):
			self.assertEqual(read(os.path.join(self.dir, name)), read(os.path.join(TREE, name)), name)


def edited_store(directory):
	"""WorldData unpacked into directory and edited: Kabul renamed, a city
	of Atlantis (in Australia) added to the Cities, Zaire taken out of the
	Countries, and the store named WorldDataEdit."""
	ns.unpack(worlddata_part(), directory)
	path = os.path.join(directory, "entries.ns")
	lines = read(path).split("\n")
	kabul = next(i for i, line in enumerate(lines) if 'name: "Kabul"' in line)
	lines[kabul] = lines[kabul].replace('name: "Kabul"', 'name: "Kabul Town"')
	countries = lines.index('soup("Countries");')
	lines.insert(countries - 1, '{_uniqueID: 476, _modTime: 0, name: "Atlantis", airport: "ATL", areacode: "", '
				 'country: \'Australia, gmt: 3600, latitude: 61591024, longitude: 29552755, notes: nil, region: ""};')
	zaire = next(i for i, line in enumerate(lines) if 'name: "Zaire"' in line)
	del lines[zaire]
	write(path, "\n".join(lines))
	store = os.path.join(directory, "store.ns")
	write(store, read(store).replace('name: "WorldData", nameIndex', 'name: "WorldDataEdit", nameIndex'))
	return path


def entries_of(data):
	"""{soup: [entry frames]} of a part."""
	_, _, script = ns.decode(data)
	soups = {}
	current = None
	for kind, arg in script:
		if kind == "soup":
			current = arg
		else:
			soups.setdefault(current, []).append(arg)
	return soups


class Edits(unittest.TestCase):
	def setUp(self):
		os.makedirs(TMP, exist_ok=True)
		self.dir = tempfile.mkdtemp(prefix="newtonstore-", dir=TMP)

	def tearDown(self):
		shutil.rmtree(self.dir, ignore_errors=True)

	def test_edits(self):
		path = edited_store(self.dir)
		warnings = io.StringIO()
		data = ns.pack(self.dir, warn=warnings)
		# the city added falls in the node the override is about
		self.assertIn("override of object 41", warnings.getvalue())
		soups = entries_of(data)
		self.assertEqual(len(soups["Cities"]), 477)
		self.assertEqual(len(soups["Countries"]), 153)
		names = [ns.string_text_of(e.get("name")) for e in soups["Cities"]]
		self.assertIn("Kabul Town", names)
		self.assertNotIn("Kabul", names)
		self.assertEqual(names[-1], "Atlantis")
		self.assertNotIn("Zaire", [ns.string_text_of(e.get("name")) for e in soups["Countries"]])
		# unpacked again: the same text, and nothing the derivation misses
		again = os.path.join(self.dir, "again")
		ns.unpack(data, again)
		self.assertEqual(read(os.path.join(again, "entries.ns")), read(path))
		self.assertFalse(os.path.exists(os.path.join(again, "overrides.txt")))
		# the indexes hold the edits: the name index has the new names, the
		# country index Atlantis among Australia's cities
		store_frame, _, _ = ns.decode(data)
		self.assertEqual(ns.string_text_of(store_frame.get("name")), "WorldDataEdit")
		raw = ns.parse_package_store(data)[0]
		_, map_id, sym_id, frame_id = struct.unpack_from(">iIII", raw[0], 4)
		name_info = ns.ObjectReader(raw, map_id, sym_id, frame_id).read().get("nameIndex")
		soup_ids = {k[2:].decode("utf-16-be"): struct.unpack(">I", d[0])[0] for k, d in ns.walk_index(raw, name_info)}
		cities = ns.ObjectReader(raw, map_id, sym_id, soup_ids["Cities"]).read()
		index = {ns.format_value(d.get("path")): d.get("index") for d in cities.get("indexes").items}
		keys = [k[2:].decode("utf-16-be") for k, _ in ns.walk_index(raw, index["'name"])]
		self.assertIn("Kabul Town", keys)
		self.assertIn("Atlantis", keys)
		self.assertNotIn("Kabul", keys)
		self.assertEqual(keys, sorted(keys, key=lambda k: [ns.folded_for_compare(ord(c)) for c in k]))
		australia = [d for k, d in ns.walk_index(raw, index["'country"]) if k[2:] == b"Australia"][0]
		self.assertEqual(len(australia), 7)

	def test_slot_order(self):
		"""An entry's slots may be written in any order: the store's is
		the symbols' hash order."""
		ns.unpack(worlddata_part(), self.dir)
		path = os.path.join(self.dir, "entries.ns")
		text = read(path)
		before = ns.pack(self.dir, warn=None)
		line = next(line for line in text.split("\n") if 'name: "Kabul"' in line)
		parser = ns.Parser(line[:-1], "line")
		frame = parser.value()
		frame.slots.reverse()
		write(path, text.replace(line, ns.format_value(frame) + ";"))
		self.assertEqual(ns.pack(self.dir, warn=None), before)

	def test_bad_key(self):
		"""A key of the wrong type for its index is an error naming the entry."""
		ns.unpack(worlddata_part(), self.dir)
		path = os.path.join(self.dir, "entries.ns")
		write(path, read(path).replace("{_uniqueID: 5, _modTime: 0, name: \"Luanda\"",
										"{_uniqueID: 5, _modTime: 0, name: 'Luanda", 1))
		with self.assertRaises(ValueError) as e:
			ns.pack(self.dir, warn=None)
		self.assertIn("entry Cities 5", str(e.exception))


def package_with(part, package, name):
	"""package with its 'soup part replaced by part and its name (9
	characters, as WorldData's) by name."""
	new = bytearray(ns.replace_soup_part(package, part))
	old = "WorldData".encode("utf-16-be")
	i = new.index(old)
	new[i:i + len(old)] = name.encode("utf-16-be")
	return bytes(new)


MOUNT_SCRIPT = r"""
storeCheckStart := Ticks();
storeCheckPoll := func() begin
	local st := GetPackageStore("WorldDataEdit");
	if st then begin
		foreach name in st:GetSoupNames() do
			Print("store: soup " & name & " " & st:GetSoup(name):Query(nil):CountEntries());
		local c := st:GetSoup("Cities"):Query({indexPath: 'name, beginKey: "Atlantis", endKey: "Atlantis"});
		local e := c:Entry();
		Print("store: by name " & (if e then e.airport else "none"));
		c := st:GetSoup("Cities"):Query({words: ["Atlantis"]});
		e := c:Entry();
		Print("store: by words " & (if e then e.name else "none"));
		c := st:GetSoup("Cities"):Query({indexPath: 'country, beginKey: 'Australia, endKey: 'Australia});
		Print("store: Australia " & c:CountEntries());
		c := st:GetSoup("Countries"):Query({indexPath: 'name, beginKey: "Zaire", endKey: "Zaire"});
		Print("store: Zaire " & c:CountEntries());
		Print("store: done");
		HostQuit();
	end else if Ticks() - storeCheckStart > 3600 then begin
		Print("store: waited in vain");
		HostQuit();
	end else
		AddDelayedCall(storeCheckPoll, nil, 250);
end;
AddDelayedCall(storeCheckPoll, nil, 250);
"""


class Mount(unittest.TestCase):
	def test_mount(self):
		"""The edited store, in a package of its own, mounted by the host:
		its soups, the name index, the country index and the word hints
		find the edits."""
		if not NEWTON:
			self.skipTest("no --newton")
		package = package_bytes()
		if package is None:
			self.skipTest("no WorldData package to put the store in")
		os.makedirs(TMP, exist_ok=True)
		d = tempfile.mkdtemp(prefix="newtonstore-mount-", dir=TMP)
		try:
			edited_store(os.path.join(d, "store"))
			part = ns.pack(os.path.join(d, "store"), warn=None)
			pkg = os.path.join(d, "WorldDat2.pkg")
			with open(pkg, "wb") as f:
				f.write(package_with(part, package, "WorldDat2"))
			script = os.path.join(d, "mount.ns")
			write(script, MOUNT_SCRIPT)
			run = subprocess.run([NEWTON, "--display", "320x480", "--headless", "60", "--package", pkg,
								  "--script", script], capture_output=True, text=True, timeout=180, cwd=ROOT)
			out = run.stdout + run.stderr
			for expected in ('"store: soup Cities 477"', '"store: soup Countries 153"', '"store: by name ATL"',
							 '"store: by words Atlantis"', '"store: Australia 7"', '"store: Zaire 0"',
							 '"store: done"'):
				self.assertIn(expected, out)
		finally:
			shutil.rmtree(d, ignore_errors=True)


if __name__ == "__main__":
	argv = sys.argv[:1]
	args = sys.argv[1:]
	while args:
		a = args.pop(0)
		if a == "--rom":
			ROM_BUILD = args.pop(0)
		elif a == "--newton":
			NEWTON = args.pop(0)
		else:
			argv.append(a)
	unittest.main(argv=argv)
