#!/usr/bin/env python3
"""Tests for tools/armpart (newtonarm.py, armv4.py): every protocol part of
the packages in romsrc/rex round-trips byte for byte through its assembly
source, an instruction inserted into a function assembles with every
branch, load, address, class-info offset and relocated word after it moved
along, and the assembler's encodings mean what capstone says they mean
(skipped when capstone is not installed).

    python tools/armpart/test_newtonarm.py [-v] [--packages DIR]

DIR (default romsrc/rex) holds ScreenBuffer.pkg, ScreenDrivers.pkg,
newtdev.pkg, inetenbl.pkg and inetstup.pkg.
"""

from __future__ import annotations

import contextlib
import io
import os
import random
import re
import shutil
import struct
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import armv4			# noqa: E402
import newtonarm		# noqa: E402

PACKAGES_DIR = os.path.join(HERE, "..", "..", "romsrc", "rex")
PACKAGES = ["ScreenBuffer.pkg", "ScreenDrivers.pkg", "newtdev.pkg", "inetenbl.pkg", "inetstup.pkg"]
# the protocol parts of each (inetstup has none)
EXPECTED_PARTS = {"ScreenBuffer.pkg": [0], "ScreenDrivers.pkg": [0], "newtdev.pkg": [2, 3, 4, 5, 8],
	"inetenbl.pkg": [2, 3, 4, 5, 6, 7, 9, 10], "inetstup.pkg": []}

try:
	import capstone
except ImportError:
	capstone = None


def corpus():
	"""(package name, ProtocolPart) for every protocol part."""
	out = []
	for name in PACKAGES:
		with open(os.path.join(PACKAGES_DIR, name), "rb") as f:
			pkg = f.read()
		for pp in newtonarm.protocol_parts(pkg):
			out.append((name, pp))
	return out


_CORPUS = None


def parts():
	global _CORPUS
	if _CORPUS is None:
		_CORPUS = corpus()
	return _CORPUS


class RoundTrip(unittest.TestCase):
	def test_the_parts_found(self):
		found = {}
		for name, pp in parts():
			found.setdefault(name, []).append(pp.index)
		for name in PACKAGES:
			self.assertEqual(found.get(name, []), EXPECTED_PARTS[name], name)

	def test_every_part_round_trips(self):
		for name, pp in parts():
			with self.subTest(package=name, part=pp.index):
				text = newtonarm.disassemble(pp.data, pp.relocations, pp.origin)
				back = newtonarm.assemble(text)
				self.assertEqual(back.data, pp.data)
				self.assertEqual(back.relocations, pp.relocations)
				self.assertEqual(back.origin, pp.origin)

	def test_fixture_packages(self):
		"""The protocol parts of the third-party and Apple packages under
		fixtures/packages round-trip too (when the checkout has them)."""
		root = os.path.join(HERE, "..", "..", "fixtures", "packages")
		count = 0
		for dirpath, _, files in os.walk(root):
			for name in files:
				if not name.lower().endswith(".pkg"):
					continue
				with open(os.path.join(dirpath, name), "rb") as f:
					pkg = f.read()
				if pkg[:7] != b"package":
					continue
				for pp in newtonarm.protocol_parts(pkg):
					with self.subTest(package=name, part=pp.index):
						self.assertTrue(newtonarm.roundtrips(pp.data, pp.relocations, pp.origin))
					count += 1
		if not count:
			self.skipTest("no fixtures/packages")

	def test_mostly_code(self):
		"""The structure (class info, branches, prologues) finds the code: at
		least 85% of every part's words are instructions (half of a small
		part's, whose names and tables weigh more)."""
		for name, pp in parts():
			p = newtonarm.Part(pp.data, pp.relocations, pp.origin)
			with self.subTest(package=name, part=pp.index):
				self.assertGreater(4 * len(p.code) / len(pp.data), 0.5 if len(pp.data) < 1024 else 0.85)

	def test_unpack_and_pack_files(self):
		tmp = tempfile.mkdtemp(prefix="armpart-")
		try:
			name, pp = [x for x in parts() if x[0] == "newtdev.pkg" and x[1].index == 5][0]
			path = os.path.join(tmp, "part5.s")
			newtonarm.unpack(pp.data, path, pp.relocations, pp.origin)
			self.assertEqual(newtonarm.pack(path), pp.data)
			self.assertEqual(newtonarm.assemble_file(path).relocations, pp.relocations)
			# another origin: the relocated words move with it
			moved = newtonarm.assemble_file(path, origin=pp.origin + 0x100)
			for r in pp.relocations:
				self.assertEqual(struct.unpack_from(">I", moved.data, r)[0],
					struct.unpack_from(">I", pp.data, r)[0] + 0x100)
			with contextlib.redirect_stdout(io.StringIO()) as out:
				self.assertEqual(newtonarm.main(["check", os.path.join(PACKAGES_DIR, "ScreenBuffer.pkg")]), 0)
			self.assertIn("part 0: identical", out.getvalue())
		finally:
			shutil.rmtree(tmp)

	def test_classinfo_is_symbolic(self):
		name, pp = [x for x in parts() if x[0] == "newtdev.pkg" and x[1].index == 4][0]
		text = newtonarm.disassemble(pp.data, pp.relocations, pp.origin)
		self.assertIn("\t.word ImplementationName - .", text)
		self.assertIn('ImplementationName:\n\t.asciz "TLanternCardHandler"', text)
		self.assertIn("\tb Sizeof", text)
		self.assertIn("\tadr r0, ClassInfoTable", text)


def mapped(o, at):
	return o + 4 if o >= at else o


class Edits(unittest.TestCase):
	def insert_and_check(self, name, index, new_line="mov r0, r0"):
		"""Inserts an instruction after a prologue's `mov ip, sp` half-way
		through the part and checks every word of the result against the
		original's, offsets after the insertion moved by four."""
		pp = [x for x in parts() if x[0] == name and x[1].index == index][0][1]
		p = newtonarm.Part(pp.data, pp.relocations, pp.origin)
		text = p.text()
		lines = text.splitlines()
		original = newtonarm.assemble(text)
		at_line = None
		for number in sorted(original.lines):
			o = original.lines[number]
			if o >= len(pp.data) // 2 and o in p.code and p.code[o].text == "mov ip, sp":
				at_line = number
				break
		self.assertIsNotNone(at_line)
		ins = original.lines[at_line] + 4
		lines.insert(at_line, "\t" + new_line)
		edited = newtonarm.assemble("\n".join(lines))
		new = edited.data
		old = pp.data
		self.assertEqual(len(new), len(old) + 4)
		self.assertEqual(struct.unpack_from(">I", new, ins)[0], armv4.encode(new_line))
		self.assertEqual(edited.relocations, [mapped(r, ins) for r in pp.relocations])
		n = len(old)
		# the instructions whose reference is written as a label (and so moves)
		labelled = set()
		for number, o in original.lines.items():
			src = newtonarm.strip_comment(lines[number - 1 if number <= at_line else number]).split(None, 1)[-1]
			if set(re.findall(r"[A-Za-z_][A-Za-z0-9_.$]*", src)) & set(original.labels):
				labelled.add(o)
		checked = 0
		for a in range(0, n - 3, 4):
			ow = struct.unpack_from(">I", old, a)[0]
			nw = struct.unpack_from(">I", new, mapped(a, ins))[0]
			if a in p.code:
				oi, ni = armv4.decode(ow, a), armv4.decode(nw, mapped(a, ins))
				if oi.ref and 0 <= oi.ref[1] < n and a in labelled:
					self.assertEqual(ni.ref[0], oi.ref[0])
					self.assertEqual(ni.ref[1], mapped(oi.ref[1], ins), "at %#x: %s -> %s" % (a, oi.text, ni.text))
					self.assertEqual(ni.template, oi.template)
					checked += 1
				else:
					self.assertEqual(nw, ow, "at %#x: %s" % (a, oi.text))
			elif a in p.fixed and p.fixed[a][0] == "rword":
				self.assertEqual(nw - pp.origin, mapped(ow - pp.origin, ins))
			elif a in p.fixed and p.fixed[a][0] == "delta" and ow:
				self.assertEqual(mapped(a, ins) + nw, mapped(a + ow, ins))
			else:
				self.assertEqual(nw, ow, "data at %#x" % a)
		self.assertGreater(checked, 10)
		return edited

	def test_insert_in_a_driver(self):
		self.insert_and_check("ScreenDrivers.pkg", 0)

	def test_insert_in_a_relocated_part(self):
		self.insert_and_check("newtdev.pkg", 5)

	def test_insert_in_the_largest_part(self):
		self.insert_and_check("inetenbl.pkg", 2)

	def test_assembler_errors(self):
		with self.assertRaises(armv4.AsmError) as e:
			newtonarm.assemble("start:\n\tb nowhere\n")
		self.assertIn(":2:", str(e.exception))
		with self.assertRaises(armv4.AsmError):
			newtonarm.assemble("\tmov r0, #0x101\n")		# no rotated byte
		with self.assertRaises(armv4.AsmError):
			newtonarm.assemble("\tldr r0, far\n\t.space 8192\nfar:\t.word 0\n")

	def test_source_syntax(self):
		src = "\n".join([
			"\t.origin 0x100",
			"top:\tadr r0, msg\t\t; a comment; with \"quotes\"",
			"\tldr r1, value",
			"\tbl helper",
			"\tb 0x1000\t\t\t; outside the part",
			"helper:\tmov pc, lr",
			"value:\t.rword msg",
			"\t.word msg - ., 7, top + 3",
			'msg:\t.asciz "hi; \\"there\\"\\x01\\n"',
			"\t.align 4",
			"\t.byte 1, 0x2",
			"\t.space 2",
			"\tstmdb sp!, {r4-r6, lr}",
			"\tpush {r0, r1}",
			"\tldr r2, [pc, #-0]",
		])
		r = newtonarm.assemble(src)
		w = lambda o: struct.unpack_from(">I", r.data, o)[0]
		msg = r.labels["msg"]
		self.assertEqual(w(0), armv4.encode("add r0, pc, #%d" % (msg - 8)))
		self.assertEqual(w(4), armv4.encode("ldr r1, [pc, #%d]" % (r.labels["value"] - 12)))
		self.assertEqual(w(12) & 0xFFFFFF, (0x1000 - 20) >> 2)
		self.assertEqual(w(r.labels["value"]), 0x100 + msg)
		self.assertEqual(r.relocations, [r.labels["value"]])
		self.assertEqual(w(r.labels["value"] + 4), msg - (r.labels["value"] + 4))
		self.assertEqual(w(r.labels["value"] + 12), 3)
		self.assertEqual(r.data[msg:msg + 14], b'hi; "there"\x01\n\0')
		end = len(r.data)
		self.assertEqual(w(end - 12), 0xE92D4070)
		self.assertEqual(w(end - 8), 0xE92D0003)
		self.assertEqual(w(end - 4), 0xE51F2000)


class Codec(unittest.TestCase):
	KNOWN = {
		"mov r0, #0": 0xE3A00000, "mov pc, lr": 0xE1A0F00E, "mov ip, sp": 0xE1A0C00D,
		"stmdb sp!, {fp, ip, lr, pc}": 0xE92DD800, "sub fp, ip, #4": 0xE24CB004,
		"ldmdb fp, {fp, sp, pc}": 0xE91BA800, "ldr pc, [pc, #-4]": 0xE51FF004,
		"addls pc, pc, r1, lsl #2": 0x908FF101, "mov ip, #0x13000": 0xE3A0CA13,
		"add r1, pc, #108, #30": 0xE28F1F6C, "strb r6, [r4, #0x15]": 0xE5C46015,
		"swi #0": 0xEF000000, "mul r2, r1, r2": 0xE0020291, "ldrh r0, [r1, #-2]!": 0xE17100B2,
	}

	def test_known_encodings(self):
		for text, word in self.KNOWN.items():
			self.assertEqual(armv4.encode(text), word, text)
			self.assertEqual(armv4.decode(word).text, text)

	def test_random_words(self):
		"""Whatever decodes to text either assembles back to the word or
		differs from it only in should-be-zero fields (and is then kept as a
		.word: roundtrips() says None)."""
		rng = random.Random(1)
		for _ in range(20000):
			w = rng.getrandbits(32) & 0xEFFFFFFF
			i = armv4.decode(w, 0x100)
			if i is None:
				continue
			e = armv4.encode(i.text, 0x100)
			if e != w:
				self.assertIsNone(armv4.roundtrips(w, 0x100))
				self.assertEqual(armv4.decode(e, 0x100).text, i.text)


# capstone's spelling made ours (unified-syntax aliases back to the classic forms)
COND = "(eq|ne|hs|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le)?"
PSR = {"apsr_nzcvq": "cpsr_f", "apsr_g": "cpsr_s", "apsr_nzcvqg": "cpsr_fs", "apsr_nzcv": "pc"}


def capstone_text(mnemonic, ops, cs_word):
	m = re.match(r"^(lsl|lsr|asr|ror|rrx)(s?)" + COND + "$", mnemonic)
	if m:
		o = armv4.split_operands(ops)
		if m.group(1) == "rrx":
			return "mov%s%s" % (m.group(2), m.group(3) or ""), "%s, %s, rrx" % (o[0], o[1])
		return "mov%s%s" % (m.group(2), m.group(3) or ""), "%s, %s, %s %s" % (o[0], o[1], m.group(1), o[2])
	m = re.match(r"^(push|pop)" + COND + "$", mnemonic)
	if m:
		regs = armv4.split_operands(ops.strip("{}"))
		if len(regs) == 1 and (cs_word & 0x0E000000) == 0x04000000:	# one register: ldr/str
			if m.group(1) == "push":
				return "str" + (m.group(2) or ""), "%s, [sp, #-4]!" % regs[0]
			return "ldr" + (m.group(2) or ""), "%s, [sp], #4" % regs[0]
		return ("stmdb" if m.group(1) == "push" else "ldmia") + (m.group(2) or ""), "sp!, " + ops
	m = re.match(r"^(ldm|stm)" + COND + "$", mnemonic)
	if m:
		return m.group(1) + "ia" + (m.group(2) or ""), ops
	m = re.match(r"^svc" + COND + "$", mnemonic)
	if m:
		return "swi" + (m.group(1) or ""), ops
	if re.match(r"^bl?" + COND + "$", mnemonic):
		return mnemonic, ops.lstrip("#")
	for k, v in PSR.items():
		ops = ops.replace(k, v)
	return mnemonic, ops


TOKEN = re.compile(r"#?-?0x[0-9a-f]+|#?-?\d+|[a-z_][a-z0-9_]*|\S")


def tokens(s):
	out = []
	for t in TOKEN.findall(s.lower()):
		b = t.lstrip("#")
		if re.match(r"^-?(0x[0-9a-f]+|\d+)$", b):
			v = int(b, 0)
			out.append(("n", v & 0xFFFFFFFF, b.startswith("-") and v == 0))
		else:
			out.append(t)
	return out


@unittest.skipIf(capstone is None, "capstone is not installed (tools/newton-rom/requirements.txt)")
class CapstoneCrossCheck(unittest.TestCase):
	def setUp(self):
		self.md = capstone.Cs(capstone.CS_ARCH_ARM, capstone.CS_MODE_ARM | capstone.CS_MODE_BIG_ENDIAN)

	def check(self, word, at, text):
		cs = list(self.md.disasm(struct.pack(">I", word), at))
		self.assertTrue(cs, "capstone cannot decode %08x (%s)" % (word, text))
		m, o = capstone_text(cs[0].mnemonic, cs[0].op_str, word)
		mine = text.split(None, 1)
		self.assertEqual((mine[0], tokens(mine[1] if len(mine) > 1 else "")), (m, tokens(o)),
			"%08x at %#x: ours %r, capstone %r" % (word, at, text, cs[0].mnemonic + " " + cs[0].op_str))

	def test_every_instruction_in_the_corpus(self):
		"""Each instruction of every part, assembled from its text, is what
		capstone reads the word as."""
		count = 0
		for name, pp in parts():
			p = newtonarm.Part(pp.data, pp.relocations, pp.origin)
			for a, insn in sorted(p.code.items()):
				word = armv4.encode(insn.text, a)
				self.assertEqual(word, struct.unpack_from(">I", pp.data, a)[0])
				self.check(word, a, insn.text)
				count += 1
		self.assertGreater(count, 40000)

	def test_random_words(self):
		rng = random.Random(2)
		for _ in range(20000):
			w = rng.getrandbits(32) & 0xEFFFFFFF
			insn = armv4.roundtrips(w, 0x1000)
			if insn is None or insn.op.startswith(("cdp", "mcr", "mrc", "ldc", "stc")) and (w >> 8) & 15 in (9, 10, 11):
				continue			# (coprocessors 9-11 capstone reads as VFP)
			self.check(w, 0x1000, insn.text)


if __name__ == "__main__":
	if "--packages" in sys.argv:
		i = sys.argv.index("--packages")
		PACKAGES_DIR = sys.argv[i + 1]
		del sys.argv[i:i + 2]
	unittest.main()
