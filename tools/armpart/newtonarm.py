#!/usr/bin/env python3
"""A package's protocol part - native ARM code - as editable assembly
source and back, byte for byte.  Pure Python (stdlib only; capstone only
cross-checks it in the tests).

A protocol part (part kind 0: NTK's native code - a driver, a comms tool,
a card handler) is big-endian ARMv4 code and data that the package manager
registers by the TClassInfo it starts with (headers/OS600/Protocols.h,
docs/packages/README.md "Protocol parts").  This turns one into an assembly
file whose instructions, labels, class-info table, strings and relocated
words can be edited - instructions inserted or removed, code moved - and
assembles it again; for an unedited file the bytes are the part's exactly.

    python tools/armpart/newtonarm.py unpack FILE.pkg --part N OUT.s [--rom BUILD]
    python tools/armpart/newtonarm.py unpack PART.bin OUT.s [--origin N] [--relocations OFF,...] [--rom BUILD]
        writes OUT.s, then assembles it again and refuses (exit 1) unless
        that gives back the part's bytes (and relocations) exactly.  From a
        package the part's relocations and its place in the package come
        with it; --rom names the ROM functions NTK's glue stubs reach
        (an extracted ROM: rom.bin, symbols.txt).
    python tools/armpart/newtonarm.py pack IN.s OUT.bin [--origin N]
        assembles a source file; says how many words it relocates.
    python tools/armpart/newtonarm.py check FILE.pkg...
        whether every protocol part of each package round-trips, with how
        much of it is code and how much had to stay as data.

The source (tools/armpart/README.md has the details):

    ; comment                   to the end of the line
    name:                       a label: its value is its offset in the part
    .origin 0x1038              the part's offset in its package as linked
                                (what .rword adds to a label); a part of a
                                package unpacked by newtonpkg.py, or a
                                native binary of romsrc, has none: its
                                origin is worked out where it is built
    .word expr                  a word: expr is numbers, labels, `.` (here),
                                + and -; the class info's self-relative
                                offsets are `.word Label - .`
    .rword expr                 a word the package's relocation chunk names:
                                .origin + expr (a pointer into the part)
    .byte n, ...  .ascii "..."  .asciz "..."  .space n  .align n
    b loc_0124 / ldr r1, lit_00c8 / adr r0, ClassInfoTable / ...
                                ARMv4 instructions (armv4.py has the syntax);
                                a branch (or pc-relative load) to a number
                                goes to that address - .origin plus its
                                offset from the part's start - so one out of
                                the part keeps reaching the same place when
                                the part moves; `adr rd,
                                label, #30` keeps a rotation the compiler chose

As a module: unpack(part, path, relocations=(), origin=0, rom=None) ->
stats, pack(path, origin=None) -> bytes, assemble_file(path) /
assemble(text) -> Assembled (.data, .relocations: the relocated words'
offsets in the part, .origin), disassemble(part, ...) -> text,
protocol_parts(package bytes) -> [ProtocolPart(index, data, relocations,
origin)].
"""

from __future__ import annotations

import os
import re
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import armv4			# noqa: E402
from armv4 import AsmError		# noqa: E402

RELOCATION_FLAG = 0x04000000		# kRelocationFlag: a relocation chunk follows the directory

# TClassInfo (headers/OS600/Protocols.h): fifteen words
CLASSINFO_FIELDS = ["fReserved1", "fNameDelta", "fInterfaceDelta", "fSignatureDelta", "fBTableDelta",
	"fEntryProcDelta", "fSizeofBranch", "fAllocBranch", "fFreeBranch", "fDefaultNewBranch",
	"fDefaultDeleteBranch", "fVersion", "fFlags", "fSelectorBranch", "fReserved2"]
CLASSINFO_SIZE = 4 * len(CLASSINFO_FIELDS)
DELTA_LABELS = {"fNameDelta": "ImplementationName", "fInterfaceDelta": "InterfaceName",
	"fSignatureDelta": "Signature", "fBTableDelta": "BTable", "fEntryProcDelta": "EntryProc"}
BRANCH_LABELS = {"fSizeofBranch": "Sizeof", "fAllocBranch": "OperatorNew", "fFreeBranch": "OperatorDelete",
	"fDefaultNewBranch": "DefaultNew", "fDefaultDeleteBranch": "DefaultDelete", "fSelectorBranch": "Selector",
	"fReserved2": "Reserved2Target"}
BTABLE_SLOTS = {1: "ClassInfo", 2: "New", 3: "Delete"}

# NTK's glue (tools/newton-rom/analysis/pkgdisasm.py): `ldr pc,[pc,#-4]` and
# an address 0x018xxxxx, which the ROM maps onto a table of branches at
# physical 0x13000, one per word, into its jump table
GLUE_STUB = 0xE51FF004
MOV_LR_PC = 0xE1A0E00F
GLUE_BASE, GLUE_TABLE, GLUE_SIZE = 0x01800000, 0x13000, 0x3000

# label kinds by priority: a target several things reach takes the first
PRIORITY = {"glue": 0, "named": 1, "sub": 2, "loc": 3, "lit": 4, "str": 5, "data": 6}
PREFIX = {"sub": "sub_", "loc": "loc_", "lit": "lit_", "str": "str_", "data": "data_"}


def word_at(data, at):
	return struct.unpack_from(">I", data, at)[0]


# ---------------------------------------------------------------------------
# the ROM's names for glue addresses (optional)

class RomNames:
	"""The ROM functions NTK's glue addresses reach, read from an extracted
	ROM (rom.bin and symbols.txt in the build directory)."""

	def __init__(self, build_dir: str):
		with open(os.path.join(build_dir, "rom.bin"), "rb") as f:
			self.rom = f.read()
		self.names = {}
		with open(os.path.join(build_dir, "symbols.txt"), encoding="utf-8", errors="replace") as f:
			for line in f:
				m = re.match(r"^(\S+) code\s+(\S+)", line)
				if m:
					self.names.setdefault(int(m.group(1), 16), m.group(2))

	def glue(self, address: int):
		if not GLUE_BASE <= address < GLUE_BASE + GLUE_SIZE or address & 3:
			return None
		w = word_at(self.rom, GLUE_TABLE + address - GLUE_BASE)
		if w >> 24 != 0xEA:
			return None
		off = w & 0xFFFFFF
		if off & 0x800000:
			off -= 0x1000000
		target = address + 8 + off * 4
		return self.names.get(target, "rom_%x" % target)


# ---------------------------------------------------------------------------
# protocol parts in a package

class ProtocolPart:
	"""A package's protocol part: its index, bytes, the offsets (in the
	part) of the words the package's relocation chunk names, and its offset
	in the package (the address it was linked at: the chunk's base is 0)."""

	def __init__(self, index, data, relocations, origin):
		self.index, self.data, self.relocations, self.origin = index, data, relocations, origin


def read_relocations(pkg: bytes, directory_size: int):
	"""(chunk size, the offsets in the package of the words the relocation
	chunk names) - TSimpleCRelocator::Relocate's reading of it: a header
	(reserved, size, page size, entry count, base address), then per page
	its number, a count and that many word indices, padded to four."""
	reserved, size, page_size, count, base = struct.unpack_from(">5I", pkg, directory_size)
	offsets = []
	p = directory_size + 20
	end = directory_size + size
	while p + 4 <= end:
		page, n = struct.unpack_from(">HH", pkg, p)
		offsets += [page * page_size + pkg[p + 4 + i] * 4 for i in range(n)]
		p += 4 + ((n + 3) & ~3)
	return size, offsets


def protocol_parts(pkg: bytes):
	"""Every protocol part (kind 0) of the package in pkg."""
	sig = pkg[:8]
	if sig not in (b"package0", b"package1"):
		raise ValueError("not a package")
	flags = word_at(pkg, 12)
	directory_size, num_parts = struct.unpack_from(">II", pkg, 44)
	parts_base = directory_size
	relocs = []
	if flags & RELOCATION_FLAG:
		size, relocs = read_relocations(pkg, directory_size)
		parts_base += size
	out = []
	for i in range(num_parts):
		offset, size, _, _, _, pflags = struct.unpack_from(">IIIIII", pkg, 52 + 32 * i)
		if pflags & 3 != 0:
			continue
		start = parts_base + offset
		mine = sorted(r - start for r in relocs if start <= r < start + size)
		out.append(ProtocolPart(i, bytes(pkg[start:start + size]), mine, start))
	return out


# ---------------------------------------------------------------------------
# the analysis: which words are code

def writes_pc(insn, word):
	"""Whether the instruction sets pc (and so does not fall through when
	it is unconditional)."""
	op = insn.op
	if op.startswith("b") and not op.startswith("bic"):
		return not op.startswith("bl")
	if op.startswith("ldm"):
		return bool(word & 0x8000)
	if op.startswith("ldr"):
		return (word >> 12) & 15 == 15
	if (word >> 26) & 3 == 0 and (word & 0x0E000090) != 0x00000090:
		dp = (word >> 21) & 15
		if not 8 <= dp <= 11 and not op.startswith(("mrs", "msr", "mul", "mla", "swp", "umu", "uml", "smu", "sml")):
			return (word >> 12) & 15 == 15
	return False


def is_jump_table(word):
	"""`add pc, pc, rN, lsl #2`: a table of branches follows."""
	return (word & 0x0FFFF000) == 0x008FF000 and (word & 0xFF0) == 0x100


def plausible(insn, word):
	"""Whether an instruction is one a speculative path may hold (compiled
	code has no coprocessor or user-bank transfers; data decoded as code
	often does)."""
	op = insn.op
	if op.startswith(("cdp", "mcr", "mrc", "ldc", "stc", "msr", "mrs")):
		return False
	if op.startswith(("ldm", "stm")) and word & 0x00400000:
		return False
	if re.match(r"^(ldr|str)b?t", op):
		return False
	return True


class Part:
	def __init__(self, data: bytes, relocations=(), origin: int = 0, rom=None):
		self.data = bytes(data)
		self.n = len(data)
		self.origin = origin
		self.rom = rom
		self.code = {}				# offset -> Insn
		self.fixed = {}				# offset -> (directive text, comment) for a word placed by the structure
		self.lits = set()			# words loaded pc-relative
		self.strings = {}			# offset -> length (with the nul) of a string the structure names
		self.want = {}				# offset -> (priority, name)
		self.comments = {}			# offset -> comment for the line
		self.entries = []
		self.relocations = sorted(relocations)
		for r in self.relocations:
			v = word_at(self.data, r)
			self.fixed[r] = ("rword", v - origin)
			self.label(v - origin, "data")
		self.classinfo()
		self.trace(self.entries, False)
		self.speculate()

	# labels

	def label(self, at, kind, name=None):
		if not 0 <= at < self.n:
			return
		prio = PRIORITY[kind]
		if name is None:
			name = "%s%04x" % (PREFIX[kind], at)
		old = self.want.get(at)
		if old is None or prio < old[0]:
			self.want[at] = (prio, name)

	def is_data(self, at):
		return at in self.fixed or at in self.lits or any(s <= at < s + n for s, n in self.strings.items())

	# the class info

	def classinfo(self):
		if self.n < CLASSINFO_SIZE:
			return
		words = [word_at(self.data, 4 * i) for i in range(len(CLASSINFO_FIELDS))]
		def target(i):
			w = words[i]
			return 4 * i + (w - (1 << 32) if w & 0x80000000 else w) if w else None
		name = target(1)
		if name is None or not 0 <= name < self.n:
			return					# no class info
		self.label(0, "named", "ClassInfoTable")
		for i, field in enumerate(CLASSINFO_FIELDS):
			at = 4 * i
			w = words[i]
			if field in DELTA_LABELS:
				t = target(i)
				self.fixed[at] = ("delta", t)
				if t is not None and 0 <= t < self.n:
					self.label(t, "named", DELTA_LABELS[field])
					if field in ("fNameDelta", "fInterfaceDelta"):
						self.string(t)
					elif field == "fSignatureDelta":
						while True:	# name, value, ... ""
							length = self.string(t)
							if length <= 1:
								break
							t += length
					elif field == "fEntryProcDelta":
						self.entries.append(t)
				self.comments[at] = field
			elif field in BRANCH_LABELS:
				insn = armv4.roundtrips(w, at)
				if w and insn is not None and (insn.op == "b" or w == 0xE1A0F00E):
					self.entries.append(at)
					if insn.ref:
						self.label(insn.ref[1], "named", BRANCH_LABELS[field])
				else:
					self.fixed[at] = ("word", w)
				self.comments[at] = field
			else:
				self.fixed[at] = ("word", w)
				self.comments[at] = field
		bt = target(4)
		if bt is not None and 0 <= bt < self.n:
			slot = 0
			while bt + 4 * slot + 4 <= self.n and not self.is_data(bt + 4 * slot):
				at = bt + 4 * slot
				w = word_at(self.data, at)
				insn = armv4.roundtrips(w, at)
				if slot == 0 and w == 0:
					self.fixed[at] = ("word", 0)
				elif insn is not None and insn.op == "b":
					self.entries.append(at)
					self.label(insn.ref[1], "named", BTABLE_SLOTS.get(slot, "Method%d" % slot))
				else:
					break
				self.comments[at] = "dispatch slot %d" % slot
				slot += 1

	def string(self, at):
		"""Marks the C string at at; ==> its length with the nul (0: none)."""
		end = self.data.find(b"\0", at)
		if end < 0 or at in self.code:
			return 0
		self.strings[at] = end + 1 - at
		return end + 1 - at

	# following the code

	def trace(self, entries, speculative):
		"""Follows the flow from the entries; for a speculative trace,
		==> whether it holds (nothing committed otherwise)."""
		code, lits, labels = {}, set(), []
		work = list(entries)
		while work:
			a = work.pop()
			first = not code			# (only a speculative path's very start must be unconditional)
			while True:
				if a in self.code or a in code:
					break
				if a < 0 or a + 4 > self.n or a & 3 or self.is_data(a) or a in lits:
					if speculative:
						return False
					break
				w = word_at(self.data, a)
				insn = armv4.roundtrips(w, a)
				if insn is None or speculative and (not plausible(insn, w) or first and insn.cond != 14):
					if speculative:
						return False
					break
				first = False
				code[a] = insn
				if insn.ref:
					kind, t = insn.ref
					inside = 0 <= t < self.n
					if kind == "branch":
						if inside and not t & 3:
							work.append(t)
							labels.append((t, "sub" if insn.op.startswith("bl") else "loc"))
						elif speculative and (inside or t & 3):
							return False		# (a part in the ROM calls the ROM directly)
					elif kind == "load":
						if inside:
							labels.append((t, "lit"))
							if insn.op.startswith("ldr") and insn.op[3:4] not in ("b", "h", "s") and not t & 3:
								if t in code or t in self.code:
									if speculative:
										return False
								else:
									lits.add(t)
						elif speculative:
							return False
					elif inside:
						labels.append((t, "data"))
				if is_jump_table(w):
					b = a + 4
					while b + 4 <= self.n:
						bi = armv4.roundtrips(word_at(self.data, b), b)
						if bi is None or bi.op != "b":
							break
						work.append(b)
						b += 4
				if insn.cond == 14 and writes_pc(insn, w) and not (a >= 4 and word_at(self.data, a - 4) == MOV_LR_PC):
					break				# (after `mov lr, pc` it is a call: a virtual one, `add pc, rN, #slot*4`)
				a += 4
		if speculative and any(t in code for t in lits):
			return False
		self.code.update(code)
		self.lits |= lits
		for t, kind in labels:
			self.label(t, kind)
		return True

	def speculate(self):
		"""Code nothing reached: each stretch of unclaimed words is tried as
		the start of a function, the whole path kept only when it holds."""
		a = 0
		while a + 4 <= self.n:
			if a in self.code or self.is_data(a):
				a += 4
				continue
			if self.trace([a], True):
				self.label(a, "sub")
			a += 4

	# writing it out

	def ref(self, t):
		"""A target as an expression: a label, a label plus a few bytes when
		it lies inside an instruction, a number outside the part."""
		if not 0 <= t < self.n:
			return None
		w = t & ~3
		if t & 3 and (w in self.code or w in self.fixed or w in self.lits):
			self.label(w, "data")
			return (w, t & 3)
		self.label(t, "data")
		return (t, 0)

	def looks_like_string(self, at):
		nul = self.data.find(b"\0", at)
		return nul - at >= 4 and all(printable(c) for c in self.data[at:nul]) and at not in self.code

	def names(self):
		"""offset -> label name, unique."""
		used, out = set(), {}
		for at in sorted(self.want):
			prio, name = self.want[at]
			if prio >= PRIORITY["lit"] and at not in self.lits and self.looks_like_string(at):
				name = "%s%04x" % (PREFIX["str"], at)
			base, k = name, 2
			while name in used or name.lower() in armv4.REGS:
				name = "%s_%d" % (base, k)
				k += 1
			used.add(name)
			out[at] = name
		return out

	def text(self, title=None, origin_line=True):
		# `mov rX, pc` gives the address 8 bytes on (a string after a return, in ScreenDrivers)
		for a in self.code:
			w = word_at(self.data, a)
			if (w & 0x0FFF0FFF) == 0x01A0000F and (w >> 12) & 15 not in (14, 15) and a + 8 < self.n:
				self.label(a + 8, "data")
				self.comments.setdefault(a, "pc-relative: the address 8 bytes on")
		# glue stubs named after what they reach
		for a, insn in self.code.items():
			if word_at(self.data, a) == GLUE_STUB and a + 8 <= self.n and a + 4 in self.lits:
				v = word_at(self.data, a + 4)
				name = self.rom.glue(v) if self.rom else None
				if GLUE_BASE <= v < GLUE_BASE + GLUE_SIZE:
					self.label(a, "glue", re.sub(r"[^A-Za-z0-9_]", "_", name) if name else "glue_%08x" % v)
					self.comments.setdefault(a + 4, "glue %08x%s" % (v, " -> " + name if name else ""))
		# the targets every reference needs, then the names
		refs = {}
		for a, insn in self.code.items():
			if insn.ref:
				refs[a] = self.ref(insn.ref[1])
		for at, (kind, v) in self.fixed.items():
			if kind == "rword":
				refs[at] = self.ref(v)
			elif kind == "delta" and v is not None:
				refs[at] = self.ref(v)
		names = self.names()

		def expr(r):
			at, k = r
			return names[at] + ("+%d" % k if k else "")

		lines = []
		if title:
			lines += ["; " + line for line in title.splitlines()]
		lines.append("; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin")
		lines.append("")
		if origin_line:
			lines.append("\t.origin 0x%x\t\t; the part's offset in its package as linked (.rword values add it)" % self.origin)
		else:
			lines.append(WORKED_OUT_ORIGIN)
		lines.append("")
		breaks = set(names) | set(self.code) | set(self.fixed) | self.lits | set(self.strings)
		for a in self.code:
			breaks.add(a + 4)
		for at in list(self.fixed) + list(self.lits):
			breaks.add(at + 4)
		for s, n in self.strings.items():
			breaks.add(s + n)
		resolver = lambda e: resolve_static(e, {v: k for k, v in names.items()})
		a = 0
		while a < self.n:
			if a in names:
				if a in self.code and self.want[a][0] <= PRIORITY["sub"]:
					lines.append("")
				lines.append(names[a] + ":")
			comment = self.comments.get(a)
			if a in self.code:
				insn = self.code[a]
				w = word_at(self.data, a)
				t = insn.text
				r = refs.get(a)
				if r is not None:
					candidate = insn.template.format(expr(r))
					try:
						if armv4.encode(candidate, a, resolver) == w:
							t = candidate
					except AsmError:
						pass
				elif insn.ref is not None and self.origin:
					# a target outside the part: the address it reaches (.origin + offset)
					candidate = insn.template.format(armv4.hexaddr(self.origin + insn.ref[1]))
					try:
						if armv4.encode(candidate, self.origin + a) == w:
							t = candidate
					except AsmError:
						pass
				lines.append(line("\t" + t, comment))
				a += 4
				continue
			if a in self.fixed:
				kind, v = self.fixed[a]
				w = word_at(self.data, a)
				if kind == "rword":
					r = refs.get(a)
					lines.append(line("\t.rword " + (expr(r) if r else hexnum(v)), comment or "relocated"))
				elif kind == "delta":
					r = refs.get(a)
					lines.append(line("\t.word " + (expr(r) + " - ." if r else "0x%08x" % w), comment))
				else:
					lines.append(line("\t.word 0x%08x" % w, comment or describe(w, a)))
				a += 4
				continue
			if a in self.lits and a + 4 <= self.n:
				w = word_at(self.data, a)
				lines.append(line("\t.word 0x%08x" % w, comment or fourcc(w)))
				a += 4
				continue
			end = a + 1
			while end < self.n and end not in breaks:
				end += 1
			lines += self.data_lines(a, end, known=a in self.strings)
			a = end
		lines.append("")
		return "\n".join(lines)

	def data_lines(self, a, end, known=False):
		"""Lines for bytes [a, end) no structure claims: strings, words, bytes."""
		out = []
		d = self.data
		while a < end:
			nul = d.find(b"\0", a, end)
			if nul >= 0 and all(printable(c) for c in d[a:nul]) and (nul - a >= 4 or known and nul >= a):
				out.append("\t.asciz " + quote(d[a:nul]))
				a = nul + 1
				known = False
				pad = (-a) & 3
				if pad and a + pad <= end and not any(d[a:a + pad]):
					out.append("\t.align 4")
					a += pad
				continue
			known = False
			if not a & 3 and a + 4 <= end:
				zeros = a
				while zeros + 4 <= end and not any(d[zeros:zeros + 4]):
					zeros += 4
				if zeros - a >= 16:
					out.append("\t.space %d" % (zeros - a))
					a = zeros
					continue
				w = word_at(d, a)
				out.append(line("\t.word 0x%08x" % w, describe(w, a)))
				a += 4
				continue
			stop = min(end, (a | 3) + 1)
			if stop == (a | 3) + 1 and not any(d[a:stop]):
				out.append("\t.align 4")
				a = stop
				continue
			out.append("\t.byte " + ", ".join("0x%02x" % c for c in d[a:stop]))
			a = stop
		return out


def printable(c):
	return 0x20 <= c < 0x7F or c in (9, 10, 13)


def quote(b: bytes) -> str:
	out = []
	for c in b:
		if c == 0x22:
			out.append('\\"')
		elif c == 0x5C:
			out.append("\\\\")
		elif c == 9:
			out.append("\\t")
		elif c == 10:
			out.append("\\n")
		elif c == 13:
			out.append("\\r")
		elif 0x20 <= c < 0x7F:
			out.append(chr(c))
		else:
			out.append("\\x%02x" % c)
	return '"' + "".join(out) + '"'


def fourcc(w):
	b = struct.pack(">I", w)
	return "'%s'" % b.decode("ascii") if all(0x20 <= c < 0x7F for c in b) else None


def describe(w, at):
	"""A comment for a data word: what it reads as."""
	parts = []
	f = fourcc(w)
	if f:
		parts.append(f)
	insn = armv4.roundtrips(w, at)
	if insn is not None and w:
		parts.append(insn.text)
	return "  ".join(parts) or None


def hexnum(v):
	return "-0x%x" % -v if v < 0 else "0x%x" % v


def line(text, comment=None):
	if not comment:
		return text
	pad = max(1, (48 - len(text.expandtabs(8)) + 7) // 8)
	return text + "\t" * pad + "; " + comment


def disassemble(part: bytes, relocations=(), origin: int = 0, rom=None, title=None) -> str:
	"""The part as source text."""
	return Part(part, relocations, origin, rom).text(title)


def analyse(part: bytes, relocations=(), origin: int = 0):
	"""The part's analysis: .code (offset -> armv4.Insn) and the rest."""
	return Part(part, relocations, origin)


# ---------------------------------------------------------------------------
# the assembler

class Assembled:
	"""An assembled part: .data, .relocations (the offsets of its .rword
	words), .origin, .labels (name -> offset) and .lines (source line
	number -> the offset of what it assembled)."""

	def __init__(self, data, relocations, origin, labels, lines):
		self.data, self.relocations, self.origin, self.labels, self.lines = data, relocations, origin, labels, lines


TOKEN = re.compile(r"\s*(?:(0x[0-9A-Fa-f]+|\d+)|([A-Za-z_.$][A-Za-z0-9_.$]*)|([-+]))")


def evaluate(expr: str, labels: dict, here: int) -> int:
	"""A sum of numbers, labels and `.`."""
	pos, total, sign, expect_term = 0, 0, 1, True
	expr = expr.strip()
	if not expr:
		raise AsmError("missing expression")
	while pos < len(expr):
		m = TOKEN.match(expr, pos)
		if not m or m.end() == pos:
			raise AsmError("bad expression %r" % expr)
		pos = m.end()
		if m.group(3):
			if expect_term:
				sign = -sign if m.group(3) == "-" else sign
			else:
				sign = -1 if m.group(3) == "-" else 1
				expect_term = True
			continue
		if not expect_term:
			raise AsmError("bad expression %r" % expr)
		if m.group(1):
			v = int(m.group(1), 0)
		elif m.group(2) == ".":
			v = here
		elif m.group(2) in labels:
			v = labels[m.group(2)]
		else:
			raise AsmError("undefined label %r" % m.group(2))
		total += sign * v
		sign, expect_term = 1, False
	if expect_term:
		raise AsmError("bad expression %r" % expr)
	return total


def resolve_static(e, labels):
	return evaluate(e, labels, 0)


def strip_comment(text: str) -> str:
	quoted = escaped = False
	for i, ch in enumerate(text):
		if escaped:
			escaped = False
		elif quoted and ch == "\\":
			escaped = True
		elif ch == '"':
			quoted = not quoted
		elif ch == ";" and not quoted:
			return text[:i]
	return text


def unquote(t: str) -> bytes:
	t = t.strip()
	if len(t) < 2 or t[0] != '"' or t[-1] != '"':
		raise AsmError("bad string %s" % t)
	out = bytearray()
	i, body = 0, t[1:-1]
	while i < len(body):
		ch = body[i]
		if ch == "\\":
			i += 1
			e = body[i]
			if e == "x":
				out.append(int(body[i + 1:i + 3], 16))
				i += 2
			else:
				out.append({"n": 10, "t": 9, "r": 13, "0": 0, "\\": 0x5C, '"': 0x22}[e])
		else:
			out += ch.encode("latin-1")
		i += 1
	return bytes(out)


LABEL = re.compile(r"^\s*([A-Za-z_$][A-Za-z0-9_.$]*)\s*:(.*)$")


def assemble(text: str, origin=None, name: str = "<source>") -> Assembled:
	"""Assembles source text; origin overrides its .origin."""
	items = []					# (line number, offset, kind, argument)
	labels = {}
	at = 0
	file_origin = 0
	for number, raw in enumerate(text.splitlines(), 1):
		s = strip_comment(raw).strip()
		while True:
			m = LABEL.match(s)
			if not m:
				break
			if m.group(1) in labels:
				raise AsmError("%s:%d: label %s defined twice" % (name, number, m.group(1)))
			labels[m.group(1)] = at
			s = m.group(2).strip()
		if not s:
			continue
		try:
			if s.startswith("."):
				d, arg = (s.split(None, 1) + [""])[:2]
				d, arg = d.lower(), arg.strip()
				if d == ".origin":
					file_origin = evaluate(arg, {}, 0)
					continue
				if d in (".word", ".rword"):
					for e in armv4.split_operands(arg):
						items.append((number, at, d, e))
						at += 4
				elif d == ".byte":
					values = [evaluate(e, {}, 0) for e in armv4.split_operands(arg)]
					items.append((number, at, d, bytes(v & 0xFF for v in values)))
					at += len(values)
				elif d in (".ascii", ".asciz"):
					b = unquote(arg) + (b"\0" if d == ".asciz" else b"")
					items.append((number, at, ".byte", b))
					at += len(b)
				elif d == ".space":
					n = evaluate(arg, {}, 0)
					items.append((number, at, ".byte", b"\0" * n))
					at += n
				elif d == ".align":
					n = evaluate(arg, {}, 0)
					pad = (-at) % n
					items.append((number, at, ".byte", b"\0" * pad))
					at += pad
				else:
					raise AsmError("unknown directive " + d)
			else:
				items.append((number, at, "insn", s))
				at += 4
		except (AsmError, ValueError, KeyError, IndexError) as e:
			raise AsmError("%s:%d: %s" % (name, number, e))
	if origin is None:
		origin = file_origin
	placed = {k: origin + v for k, v in labels.items()}		# (the labels' addresses)
	out = bytearray()
	relocations = []
	for number, at, kind, arg in items:
		try:
			if kind == ".byte":
				out += arg
			elif kind == ".word":
				out += struct.pack(">I", evaluate(arg, labels, at) & 0xFFFFFFFF)
			elif kind == ".rword":
				out += struct.pack(">I", (origin + evaluate(arg, labels, at)) & 0xFFFFFFFF)
				relocations.append(at)
			else:
				# encoded at its address, .origin + offset: a target given as a
				# number is an address, and stays one when the part moves
				here = origin + at
				out += struct.pack(">I", armv4.encode(arg, here, lambda e: evaluate(e, placed, here)))
		except (AsmError, ValueError, KeyError, IndexError) as e:
			raise AsmError("%s:%d: %s" % (name, number, e))
	return Assembled(bytes(out), relocations, origin, labels, {number: at for number, at, _, _ in items})


def assemble_file(path: str, origin=None) -> Assembled:
	with open(path, encoding="utf-8") as f:
		return assemble(f.read(), origin, path)


def pack(path: str, origin=None) -> bytes:
	"""The part's bytes from a source file."""
	return assemble_file(path, origin).data


# what a source says in place of its .origin when whatever builds it gives
# the origin (newtonpkg.py a package's part, romsrc.py a native binary):
# written there, it would go stale as soon as anything before it grew
WORKED_OUT_ORIGIN = "\t; .origin: the address its first byte falls at, worked out where it is built"


def unpack(part: bytes, path: str, relocations=(), origin: int = 0, rom=None, title=None, origin_line=True) -> dict:
	"""Writes the part's source to path; ==> stats (code words, data words,
	instructions written as .word in code).  Raises ValueError unless the
	source assembles back to the part exactly.  origin_line False: the
	source has no .origin (WORKED_OUT_ORIGIN) - what builds it gives it."""
	p = Part(part, relocations, origin, rom)
	text = p.text(title, origin_line)
	back = assemble(text, origin, path)
	if back.data != bytes(part) or back.relocations != sorted(relocations):
		raise ValueError("%s: the source does not give the part back byte for byte" % path)
	with open(path, "w", encoding="utf-8", newline="\n") as f:
		f.write(text)
	return stats(p)


def stats(p: Part) -> dict:
	return {"bytes": p.n, "code": len(p.code), "data_words": (p.n - 4 * len(p.code)) // 4,
		"labelled": sum(1 for i in p.code.values() if i.ref)}


def roundtrips(part: bytes, relocations=(), origin: int = 0) -> bool:
	back = assemble(disassemble(part, relocations, origin))
	return back.data == bytes(part) and back.relocations == sorted(relocations)


# ---------------------------------------------------------------------------
# the command line

def parse_number(t):
	return int(t, 0)


def main(argv=None):
	import argparse
	argv = sys.argv[1:] if argv is None else argv
	ap = argparse.ArgumentParser(description="A package's protocol part as ARM assembly source and back.")
	sub = ap.add_subparsers(dest="command")
	u = sub.add_parser("unpack", help="a part (or a package's part N) -> source")
	u.add_argument("input")
	u.add_argument("output")
	u.add_argument("--part", type=int, help="the input is a package: its part N")
	u.add_argument("--origin", type=parse_number, default=0)
	u.add_argument("--relocations", default="", help="relocated words' offsets in the part, comma-separated")
	u.add_argument("--rom", help="an extracted ROM's build directory, to name glue calls")
	p = sub.add_parser("pack", help="source -> part")
	p.add_argument("input")
	p.add_argument("output")
	p.add_argument("--origin", type=parse_number)
	c = sub.add_parser("check", help="every protocol part of the packages round-trips")
	c.add_argument("packages", nargs="+")
	c.add_argument("--rom")
	a = ap.parse_args(argv)
	rom = RomNames(a.rom) if getattr(a, "rom", None) else None
	if a.command == "unpack":
		with open(a.input, "rb") as f:
			data = f.read()
		title = None
		if a.part is not None:
			found = [pp for pp in protocol_parts(data) if pp.index == a.part]
			if not found:
				print("%s: part %d is no protocol part" % (a.input, a.part), file=sys.stderr)
				return 1
			pp = found[0]
			data, relocs, origin = pp.data, pp.relocations, pp.origin
			title = "%s part %d (%d bytes)" % (os.path.basename(a.input), a.part, len(data))
		else:
			relocs = [int(x, 0) for x in a.relocations.split(",") if x.strip()]
			origin = a.origin
		try:
			s = unpack(data, a.output, relocs, origin, rom, title)
		except ValueError as e:
			print(e, file=sys.stderr)
			return 1
		print("%s -> %s: %d instructions, %d data words" % (a.input, a.output, s["code"], s["data_words"]))
		return 0
	if a.command == "pack":
		try:
			r = assemble_file(a.input, a.origin)
		except AsmError as e:
			print(e, file=sys.stderr)
			return 1
		with open(a.output, "wb") as f:
			f.write(r.data)
		print("%s -> %s, %d bytes, %d relocated words" % (a.input, a.output, len(r.data), len(r.relocations)))
		return 0
	if a.command == "check":
		bad = 0
		for path in a.packages:
			with open(path, "rb") as f:
				pkg = f.read()
			try:
				found = protocol_parts(pkg)
			except ValueError as e:
				print("%s: %s" % (path, e))
				bad += 1
				continue
			for pp in found:
				ok = roundtrips(pp.data, pp.relocations, pp.origin)
				s = stats(Part(pp.data, pp.relocations, pp.origin, rom))
				bad += not ok
				print("%s part %d: %s, %d bytes: %d instructions, %d data words, %d relocated" % (
					os.path.basename(path), pp.index, "identical" if ok else "DIFFERS", s["bytes"],
					s["code"], s["data_words"], len(pp.relocations)))
		return 1 if bad else 0
	ap.print_help(sys.stderr)
	return 2


if __name__ == "__main__":
	sys.exit(main())
