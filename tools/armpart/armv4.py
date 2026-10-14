#!/usr/bin/env python3
"""A disassembler and assembler for the ARMv4 instruction set (the StrongARM
SA-110's, as the MessagePad 2x00 runs it), one the inverse of the other.
Pure Python (stdlib only).

decode(word, at) gives the instruction's text in one canonical syntax and
encode(text, at, ...) gives the word back; newtonarm.py builds its source
files on the pair and keeps an instruction as text only when
encode(decode(word)) == word, so a part always assembles back byte for
byte.  A word that is no ARMv4 instruction, or one that is but whose
encoding the canonical text would not give back (a should-be-zero field
that is not, an immediate rotated otherwise than the canonical way when
the explicit `#imm8, #rot` form does not apply), decodes as None and is
kept as a `.word`.

The syntax is ARM's unified one as capstone prints it, with the classic
(pre-unified) spellings where those are plainer:

    the condition after any `s` or size/mode suffix:
        addseq, ldrbeq, ldrbteq, ldmdbne, strhne, mulseq, umullseq, swpbeq
    registers r0-r8, sb, sl, fp, ip, sp, lr, pc (r9-r15 read too)
    data processing  op{s}{cond} rd, rn, <op2>; mov/mvn rd, <op2>;
                     tst/teq/cmp/cmn rn, <op2>
        <op2>  #imm | #imm8, #rot (an immediate not rotated canonically) |
               rm | rm, lsl|lsr|asr|ror #n | rm, rrx | rm, lsl|... rs
        (a shifted mov stays `mov r0, r1, lsl #2`: no lsl/lsr aliases)
    loads/stores     ldr|str{b}{t} rd, [rn{, #+-imm | , +-rm{, shift}}]{!}
                     ldr|str{b}{t} rd, [rn], #+-imm | +-rm{, shift}
                     ldrh|strh|ldrsb|ldrsh rd, [rn, #+-imm | +-rm]{!}, post too
        `#-0` is kept: it is an encoding of its own (U clear)
    load/store many  ldm|stm{ia|ib|da|db} rn{!}, {regs}{^}   (no push/pop)
    branches         b|bl{cond} target
    swi              swi{cond} #imm24
    multiplies       mul rd, rm, rs; mla rd, rm, rs, rn;
                     umull|umlal|smull|smlal rdlo, rdhi, rm, rs
    swap             swp{b} rd, rm, [rn]
    status           mrs rd, cpsr|spsr; msr cpsr|spsr_<fsxc>, rm|#imm
    coprocessor      cdp p#, #op1, cd, cn, cm, #op2;
                     mcr|mrc p#, #op1, rd, cn, cm, #op2;
                     ldc|stc{l} p#, cd, [rn, #+-imm]{!} | [rn], #+-imm |
                     [rn], {option}

Labels: a branch's target, and the address a pc-relative load or an
`add|sub rd, pc, #imm` reaches, are an expression (a label, a number, `.`,
sums and differences) the caller resolves: encode() is given a resolve
function from the expression's text to a number.  In a branch a number is
the target itself (an offset from wherever the caller's addresses start);
`ldr rd, <expr>` is a pc-relative load from the address and
`adr rd, <expr>` is `add|sub rd, pc, #...` for it (`adr rd, <expr>, #rot`
rotates the immediate right by rot, for the compiler's own choice where it
is not the canonical one).  decode() gives such an
instruction's reference as Insn.ref (kind, target) and its text with the
target in a template, so the caller can put a label in.
"""

from __future__ import annotations

import re

CONDS = ["eq", "ne", "hs", "lo", "mi", "pl", "vs", "vc", "hi", "ls", "ge", "lt", "gt", "le", "", "nv"]
COND_ALIASES = {"cs": 2, "cc": 3, "al": 14}
DP_OPS = ["and", "eor", "sub", "rsb", "add", "adc", "sbc", "rsc", "tst", "teq", "cmp", "cmn", "orr", "mov", "bic", "mvn"]
REG_NAMES = ["r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "sb", "sl", "fp", "ip", "sp", "lr", "pc"]
SHIFTS = ["lsl", "lsr", "asr", "ror"]
LDM_MODES = ["da", "ia", "db", "ib"]		# by P,U: 00 da, 01 ia, 10 db, 11 ib
PC = 15


class AsmError(Exception):
	pass


class Insn:
	"""A decoded instruction: its canonical text, and when it refers to an
	address (a branch's target, a pc-relative load's or an address
	computed from pc), ref = (kind, target) with kind 'branch', 'load' or
	'adr' and template the text with "{}" where the target's label goes
	(the text itself has the target as a number in the branch's case and
	in the pc-relative form - `[pc, #0x14]`, `sub r0, pc, #0x44` - in the
	others)."""

	__slots__ = ("text", "ref", "template", "op", "cond", "info")

	def __init__(self, text, op, cond, ref=None, template=None, **info):
		self.text, self.op, self.cond = text, op, cond
		self.ref, self.template = ref, template
		self.info = info

	def __repr__(self):
		return "Insn(%r)" % self.text


# ---------------------------------------------------------------------------
# small helpers

def ror(v: int, n: int) -> int:
	n &= 31
	return ((v >> n) | (v << (32 - n))) & 0xFFFFFFFF if n else v & 0xFFFFFFFF


def rol(v: int, n: int) -> int:
	return ror(v, (32 - n) & 31)


def num(v: int) -> str:
	"""A number as capstone prints one: decimal to 9, hex above."""
	if v < 0:
		return "-" + num(-v)
	return str(v) if v <= 9 else "0x%x" % v


def reg(r: int) -> str:
	return REG_NAMES[r]


def canonical_rotation(value: int):
	"""(rot, imm8) for the value as an ARM rotated immediate, chosen as LLVM
	(and so capstone) does: no rotation for a byte, else the smallest
	right rotation that leaves the low set bit in imm8's bit 0 or 1; None
	when the value is no rotated byte."""
	value &= 0xFFFFFFFF
	if value < 256:
		return 0, value
	tz = (value & -value).bit_length() - 1
	amt = tz & ~1
	if ror(value, amt) < 256:
		return ((32 - amt) & 31) // 2, ror(value, amt)
	if value & 63:
		low = value & ~63
		if low:
			tz2 = (low & -low).bit_length() - 1
			amt2 = tz2 & ~1
			if ror(value, amt2) < 256:
				return ((32 - amt2) & 31) // 2, ror(value, amt2)
	for rot in range(16):					# a value that wraps round
		if rol(value, 2 * rot) < 256:
			return rot, rol(value, 2 * rot)
	return None


def imm_text(rot: int, imm8: int) -> str:
	value = ror(imm8, 2 * rot)
	if canonical_rotation(value) == (rot, imm8):
		return "#" + num(value)
	return "#%d, #%d" % (imm8, 2 * rot)


def reglist_text(mask: int) -> str:
	return "{" + ", ".join(reg(r) for r in range(16) if mask >> r & 1) + "}"


def shift_text(stype: int, amount: int) -> str:
	"""An immediate shift (as encoded: amount 0 meaning 32 for lsr/asr and
	rrx for ror); "" for none."""
	if stype == 0:
		return "" if amount == 0 else ", lsl #%d" % amount
	if stype == 3 and amount == 0:
		return ", rrx"
	return ", %s #%d" % (SHIFTS[stype], amount or 32)


# ---------------------------------------------------------------------------
# decoding

def decode(word: int, at: int = 0):
	"""The instruction at address `at` as an Insn, or None when the word is no
	ARMv4 instruction this module writes as text."""
	cond = word >> 28
	if cond == 15:
		return None
	c = CONDS[cond]
	op27 = (word >> 25) & 7
	if op27 == 5:							# B, BL
		off = word & 0xFFFFFF
		if off & 0x800000:
			off -= 0x1000000
		target = at + 8 + off * 4
		m = ("bl" if word >> 24 & 1 else "b") + c
		return Insn("%s %s" % (m, hexaddr(target)), m, cond, ("branch", target), m + " {}")
	if (word >> 24) & 15 == 15:
		return Insn("swi%s #%s" % (c, num(word & 0xFFFFFF)), "swi", cond)
	if op27 in (0, 1):
		return decode_dp_misc(word, at, c, cond)
	if op27 in (2, 3):
		if op27 == 3 and word & 0x10:
			return None						# undefined (the media space)
		return decode_ldst(word, at, c, cond)
	if op27 == 4:
		return decode_ldm(word, c, cond)
	if op27 == 6:
		return decode_ldc(word, c, cond)
	if op27 == 7:							# CDP, MCR, MRC
		cp = (word >> 8) & 15
		if word & 0x10:
			m = ("mrc" if word >> 20 & 1 else "mcr") + c
			return Insn("%s p%d, #%d, %s, c%d, c%d, #%d" % (m, cp, (word >> 21) & 7, reg((word >> 12) & 15),
					(word >> 16) & 15, word & 15, (word >> 5) & 7), m, cond)
		m = "cdp" + c
		return Insn("%s p%d, #%d, c%d, c%d, c%d, #%d" % (m, cp, (word >> 20) & 15, (word >> 12) & 15,
				(word >> 16) & 15, word & 15, (word >> 5) & 7), m, cond)
	return None


def hexaddr(v: int) -> str:
	return "-0x%x" % -v if v < 0 else "0x%x" % v


def decode_dp_misc(word, at, c, cond):
	i = word >> 25 & 1
	if not i and (word & 0x90) == 0x90:		# multiplies, swap, halfword transfers
		sh = (word >> 5) & 3
		if sh == 0:
			if (word >> 22) & 0x3F == 0:	# MUL, MLA
				s = "s" if word >> 20 & 1 else ""
				rd, rn, rs, rm = (word >> 16) & 15, (word >> 12) & 15, (word >> 8) & 15, word & 15
				if word >> 21 & 1:
					m = "mla" + s + c
					return Insn("%s %s, %s, %s, %s" % (m, reg(rd), reg(rm), reg(rs), reg(rn)), m, cond)
				m = "mul" + s + c
				return Insn("%s %s, %s, %s" % (m, reg(rd), reg(rm), reg(rs)), m, cond, sbz=rn)
			if (word >> 23) & 0x1F == 1:	# long multiplies
				name = ["umull", "umlal", "smull", "smlal"][(word >> 21) & 3]
				m = name + ("s" if word >> 20 & 1 else "") + c
				return Insn("%s %s, %s, %s, %s" % (m, reg((word >> 12) & 15), reg((word >> 16) & 15),
						reg(word & 15), reg((word >> 8) & 15)), m, cond)
			if (word >> 23) & 0x1F == 2 and (word >> 20) & 3 == 0 and (word >> 8) & 15 == 0:
				m = "swp" + ("b" if word >> 22 & 1 else "") + c
				return Insn("%s %s, %s, [%s]" % (m, reg((word >> 12) & 15), reg(word & 15), reg((word >> 16) & 15)), m, cond)
			return None
		return decode_ldrh(word, at, c, cond, sh)
	op = (word >> 21) & 15
	s = word >> 20 & 1
	if 8 <= op <= 11 and not s:				# MRS, MSR (or nothing)
		return decode_status(word, c, cond)
	rn, rd = (word >> 16) & 15, (word >> 12) & 15
	if i:
		rot, imm8 = (word >> 8) & 15, word & 0xFF
		op2 = imm_text(rot, imm8)
		if rn == PC and op in (2, 4) and not s:
			value = ror(imm8, 2 * rot)
			target = at + 8 + (value if op == 4 else -value)
			m = DP_OPS[op] + c
			text = "%s %s, pc, %s" % (m, reg(rd), op2)
			explicit = "" if canonical_rotation(value) == (rot, imm8) else ", #%d" % (2 * rot)
			return Insn(text, m, cond, ("adr", target), "adr%s %s, {}%s" % (c, reg(rd), explicit))
	else:
		rm = word & 15
		stype = (word >> 5) & 3
		if word & 0x10:
			op2 = "%s, %s %s" % (reg(rm), SHIFTS[stype], reg((word >> 8) & 15))
		else:
			op2 = reg(rm) + shift_text(stype, (word >> 7) & 31)
	name = DP_OPS[op]
	if 8 <= op <= 11:
		m = name + c
		return Insn("%s %s, %s" % (m, reg(rn), op2), m, cond, sbz=rd)
	m = name + ("s" if s else "") + c
	if op in (13, 15):
		return Insn("%s %s, %s" % (m, reg(rd), op2), m, cond, sbz=rn)
	return Insn("%s %s, %s, %s" % (m, reg(rd), reg(rn), op2), m, cond)


def decode_status(word, c, cond):
	r = "spsr" if word >> 22 & 1 else "cpsr"
	if (word & 0x0FBF0FFF) == 0x010F0000:
		m = "mrs" + c
		return Insn("%s %s, %s" % (m, reg((word >> 12) & 15), r), m, cond)
	mask = (word >> 16) & 15
	if not word >> 21 & 1 or not mask or (word >> 12) & 15 != 15:
		return None
	fields = "".join(f for f, b in zip("fsxc", (8, 4, 2, 1)) if mask & b)
	m = "msr" + c
	if word & 0x02000000:
		return Insn("%s %s_%s, %s" % (m, r, fields, imm_text((word >> 8) & 15, word & 0xFF)), m, cond)
	if (word & 0x0FB0FFF0) == 0x0120F000:
		return Insn("%s %s_%s, %s" % (m, r, fields, reg(word & 15)), m, cond)
	return None


def decode_ldrh(word, at, c, cond, sh):
	p, u, imm, w, load = word >> 24 & 1, word >> 23 & 1, word >> 22 & 1, word >> 21 & 1, word >> 20 & 1
	if not load and sh != 1:
		return None							# ldrd/strd (ARMv5TE)
	if not p and w:
		return None
	name = ("ldr" if load else "str") + {1: "h", 2: "sb", 3: "sh"}[sh]
	m = name + c
	rn, rd = (word >> 16) & 15, (word >> 12) & 15
	sign = "" if u else "-"
	if imm:
		off = ((word >> 4) & 0xF0) | (word & 15)
		if rn == PC and p and not w:
			target = at + 8 + (off if u else -off)
			text = "%s %s, %s" % (m, reg(rd), address_text("pc", 1, 0, "#" + sign + num(off), off == 0 and u))
			return Insn(text, m, cond, ("load", target), "%s %s, {}" % (m, reg(rd)))
		addr = address_text(reg(rn), p, w, "#" + sign + num(off), off == 0 and u)
	else:
		if (word >> 8) & 15:
			return None
		addr = address_text(reg(rn), p, w, sign + reg(word & 15), False)
	return Insn("%s %s, %s" % (m, reg(rd), addr), m, cond)


def address_text(base, p, w, offset, none):
	if p:
		if none and not w:
			return "[%s]" % base
		return "[%s, %s]%s" % (base, offset, "!" if w else "")
	return "[%s], %s" % (base, offset)


def decode_ldst(word, at, c, cond):
	i, p, u, b, w, load = (word >> 25 & 1, word >> 24 & 1, word >> 23 & 1, word >> 22 & 1,
		word >> 21 & 1, word >> 20 & 1)
	t = not p and w
	m = ("ldr" if load else "str") + ("b" if b else "") + ("t" if t else "") + c
	rn, rd = (word >> 16) & 15, (word >> 12) & 15
	sign = "" if u else "-"
	if not i:
		off = word & 0xFFF
		if rn == PC and p and not w:
			target = at + 8 + (off if u else -off)
			text = "%s %s, %s" % (m, reg(rd), address_text("pc", 1, 0, "#" + sign + num(off), off == 0 and u))
			return Insn(text, m, cond, ("load", target), "%s %s, {}" % (m, reg(rd)))
		addr = address_text(reg(rn), p, w and p, "#" + sign + num(off), off == 0 and u)
	else:
		offset = sign + reg(word & 15) + shift_text((word >> 5) & 3, (word >> 7) & 31)
		addr = address_text(reg(rn), p, w and p, offset, False)
	return Insn("%s %s, %s" % (m, reg(rd), addr), m, cond)


def decode_ldm(word, c, cond):
	mask = word & 0xFFFF
	if not mask:
		return None
	mode = LDM_MODES[(word >> 23) & 3]
	m = ("ldm" if word >> 20 & 1 else "stm") + mode + c
	text = "%s %s%s, %s%s" % (m, reg((word >> 16) & 15), "!" if word >> 21 & 1 else "",
		reglist_text(mask), "^" if word >> 22 & 1 else "")
	return Insn(text, m, cond)


def decode_ldc(word, c, cond):
	p, u, n, w, load = word >> 24 & 1, word >> 23 & 1, word >> 22 & 1, word >> 21 & 1, word >> 20 & 1
	if not p and not w and not u:
		return None							# MCRR/MRRC space (ARMv5TE)
	m = ("ldc" if load else "stc") + ("l" if n else "") + c
	off = (word & 0xFF) * 4
	sign = "" if u else "-"
	base = reg((word >> 16) & 15)
	if not p and not w:
		addr = "[%s], {%d}" % (base, word & 0xFF)
	else:
		addr = address_text(base, p, w, "#" + sign + num(off), False)
	return Insn("%s p%d, c%d, %s" % (m, (word >> 8) & 15, (word >> 12) & 15, addr), m, cond)


# ---------------------------------------------------------------------------
# encoding

def _mnemonics():
	"""Every mnemonic the assembler takes -> (class, fields)."""
	table = {}

	def add(name, kind, **f):
		for ci, cn in enumerate(CONDS):
			if ci == 15:
				continue
			for cname in [cn] + [a for a, v in COND_ALIASES.items() if v == ci]:
				key = name + cname
				if key in table and table[key] != (kind, dict(f, cond=ci)):
					raise AssertionError("ambiguous mnemonic " + key)
				table[key] = (kind, dict(f, cond=ci))
	for op, name in enumerate(DP_OPS):
		if 8 <= op <= 11:
			add(name, "dp", op=op, s=1)
		else:
			add(name, "dp", op=op, s=0)
			add(name + "s", "dp", op=op, s=1)
	add("adr", "adr")
	add("b", "b", link=0)
	add("bl", "b", link=1)
	add("swi", "swi")
	add("svc", "swi")
	for load in (0, 1):
		base = "ldr" if load else "str"
		for b in (0, 1):
			for t in (0, 1):
				add(base + ("b" if b else "") + ("t" if t else ""), "ldst", load=load, b=b, t=t)
		add(base + "h", "ldrh", load=load, sh=1)
	add("ldrsb", "ldrh", load=1, sh=2)
	add("ldrsh", "ldrh", load=1, sh=3)
	for load in (0, 1):
		for mi, mode in enumerate(LDM_MODES):
			add(("ldm" if load else "stm") + mode, "ldm", load=load, pu=mi)
		add("ldm" if load else "stm", "ldm", load=load, pu=1)
	for alias, (load, pu) in {"ldmfd": (1, 1), "ldmea": (1, 2), "ldmed": (1, 3), "ldmfa": (1, 0),
			"stmfd": (0, 2), "stmea": (0, 1), "stmed": (0, 0), "stmfa": (0, 3)}.items():
		add(alias, "ldm", load=load, pu=pu)
	add("push", "pushpop", load=0)
	add("pop", "pushpop", load=1)
	add("mul", "mul", a=0, s=0)
	add("muls", "mul", a=0, s=1)
	add("mla", "mul", a=1, s=0)
	add("mlas", "mul", a=1, s=1)
	for k, name in enumerate(["umull", "umlal", "smull", "smlal"]):
		add(name, "mull", k=k, s=0)
		add(name + "s", "mull", k=k, s=1)
	add("swp", "swp", b=0)
	add("swpb", "swp", b=1)
	add("mrs", "mrs")
	add("msr", "msr")
	add("cdp", "cdp")
	add("mcr", "mcr", load=0)
	add("mrc", "mcr", load=1)
	for load in (0, 1):
		for n in (0, 1):
			add(("ldc" if load else "stc") + ("l" if n else ""), "ldc", load=load, n=n)
	return table


MNEMONICS = _mnemonics()
REGS = {name: i for i, name in enumerate(REG_NAMES)}
REGS.update({"r%d" % i: i for i in range(16)})


def split_operands(text: str):
	"""Operands split at the commas outside brackets and braces."""
	out, depth, cur = [], 0, ""
	for ch in text:
		if ch in "[{":
			depth += 1
		elif ch in "]}":
			depth -= 1
		if ch == "," and depth == 0:
			out.append(cur.strip())
			cur = ""
		else:
			cur += ch
	if cur.strip():
		out.append(cur.strip())
	return out


def parse_reg(t: str) -> int:
	t = t.strip().lower()
	if t not in REGS:
		raise AsmError("not a register: %r" % t)
	return REGS[t]


def parse_int(t: str) -> int:
	t = t.strip()
	if t.startswith("#"):
		t = t[1:].strip()
	try:
		return int(t, 0)
	except ValueError:
		raise AsmError("not a number: %r" % t)


def parse_imm(t: str):
	"""(value, negative zero) of `#n`/`#-n`."""
	t = t.strip()
	if not t.startswith("#"):
		raise AsmError("not an immediate: %r" % t)
	body = t[1:].strip()
	return parse_int(body), body.startswith("-") and parse_int(body) == 0


def encode_imm(ops):
	"""The 12-bit rotated immediate field for `#v` or `#imm8, #rot`."""
	if len(ops) == 2:
		imm8, rot2 = parse_int(ops[0]), parse_int(ops[1])
		if not 0 <= imm8 < 256 or rot2 & 1 or not 0 <= rot2 < 32:
			raise AsmError("bad explicit immediate")
		return (rot2 // 2) << 8 | imm8
	v = parse_int(ops[0]) & 0xFFFFFFFF
	enc = canonical_rotation(v)
	if enc is None:
		raise AsmError("immediate %#x is not a rotated byte" % v)
	return enc[0] << 8 | enc[1]


SHIFT_RE = re.compile(r"^(lsl|lsr|asr|ror)\s+(.+)$|^(rrx)$", re.I)


def encode_shift(t: str, allow_reg: bool):
	"""The shift field (bits 4-11) of `lsl #n`, `rrx`, `lsl rs`..."""
	m = SHIFT_RE.match(t.strip())
	if not m:
		raise AsmError("bad shift %r" % t)
	if m.group(3):
		return 3 << 5
	stype = SHIFTS.index(m.group(1).lower())
	arg = m.group(2).strip()
	if arg.startswith("#"):
		n = parse_int(arg)
		if stype == 0 and not 0 <= n <= 31 or stype in (1, 2) and not 1 <= n <= 32 or stype == 3 and not 1 <= n <= 31:
			raise AsmError("bad shift amount %r" % t)
		return ((n & 31) << 7) | (stype << 5)
	if not allow_reg:
		raise AsmError("register shift not allowed here")
	return (parse_reg(arg) << 8) | (stype << 5) | 0x10


def encode_op2(ops):
	"""(I bit, operand-2 field) of a data-processing instruction's last
	operand(s)."""
	if ops[0].startswith("#"):
		return 1, encode_imm(ops)
	rm = parse_reg(ops[0])
	if len(ops) == 1:
		return 0, rm
	if len(ops) != 2:
		raise AsmError("too many operands")
	return 0, rm | encode_shift(ops[1], True)


def parse_address(t: str):
	"""[rn, ...]{!} / [rn], ... split into (rn, pre-indexed, writeback, offset
	parts or [])."""
	t = t.strip()
	ops = split_operands(t)
	first = ops[0]
	if first.endswith("!"):
		inner, bang = first[:-1].strip(), True
	else:
		inner, bang = first, False
	if not inner.startswith("["):
		raise AsmError("bad address %r" % t)
	if inner.endswith("]") and inner.count("[") == 1:
		body = split_operands(inner[1:-1])
		rn = parse_reg(body[0])
		if len(ops) > 1:				# post-indexed
			if bang or len(body) != 1:
				raise AsmError("bad post-indexed address %r" % t)
			return rn, False, False, ops[1:]
		return rn, True, bang, body[1:]
	raise AsmError("bad address %r" % t)


def encode(text: str, at: int = 0, resolve=None) -> int:
	"""The word for one instruction at address `at`; resolve(expr) gives the
	value of a target expression (default: a number)."""
	if resolve is None:
		resolve = lambda e: parse_int(e)
	text = text.strip()
	parts = text.split(None, 1)
	mn = parts[0].lower()
	rest = parts[1] if len(parts) > 1 else ""
	if mn not in MNEMONICS:
		raise AsmError("unknown mnemonic %r" % parts[0])
	kind, f = MNEMONICS[mn]
	cond = f["cond"] << 28
	ops = split_operands(rest)
	enc = globals()["_enc_" + kind]
	return enc(ops, f, cond, at, resolve) & 0xFFFFFFFF


def _enc_dp(ops, f, cond, at, resolve):
	op = f["op"]
	word = cond | op << 21 | f["s"] << 20
	if op in (13, 15):
		rd, rest = parse_reg(ops[0]), ops[1:]
		word |= rd << 12
	elif 8 <= op <= 11:
		word |= parse_reg(ops[0]) << 16
		rest = ops[1:]
	else:
		word |= parse_reg(ops[0]) << 12 | parse_reg(ops[1]) << 16
		rest = ops[2:]
	if not rest:
		raise AsmError("missing operand")
	i, op2 = encode_op2(rest)
	return word | i << 25 | op2


def _enc_adr(ops, f, cond, at, resolve):
	if len(ops) not in (2, 3):
		raise AsmError("adr takes a register, an address and perhaps a rotation")
	rd = parse_reg(ops[0])
	delta = resolve(ops[1]) - (at + 8)
	op = 4 if delta >= 0 else 2
	if len(ops) == 3:				# the rotation given: `adr rd, label, #30`
		rot2 = parse_int(ops[2])
		if rot2 & 1 or not 0 <= rot2 < 32 or rol(abs(delta), rot2) > 255:
			raise AsmError("adr: %d bytes away is not an immediate rotated right by %d" % (delta, rot2))
		enc = (rot2 // 2, rol(abs(delta), rot2))
	else:
		enc = canonical_rotation(abs(delta))
	if enc is None:
		raise AsmError("adr: %d bytes away cannot be reached in one instruction" % delta)
	return cond | 1 << 25 | op << 21 | PC << 16 | rd << 12 | enc[0] << 8 | enc[1]


def _enc_b(ops, f, cond, at, resolve):
	if len(ops) != 1:
		raise AsmError("a branch takes one target")
	off = resolve(ops[0]) - (at + 8)
	if off & 3 or not -(1 << 25) <= off < (1 << 25):
		raise AsmError("branch target out of reach or unaligned")
	return cond | 0x0A000000 | f["link"] << 24 | ((off >> 2) & 0xFFFFFF)


def _enc_swi(ops, f, cond, at, resolve):
	v = parse_int(ops[0])
	if not 0 <= v < 1 << 24:
		raise AsmError("swi number out of range")
	return cond | 0x0F000000 | v


def _pcrel(ops, at, resolve, limit):
	"""(U, offset) of a load's address given as an expression."""
	delta = resolve(ops[1]) - (at + 8)
	if abs(delta) > limit:
		raise AsmError("pc-relative load %d bytes away is out of reach" % delta)
	return (1 if delta >= 0 else 0), abs(delta)


def _enc_ldst(ops, f, cond, at, resolve):
	if len(ops) < 2:
		raise AsmError("missing address")
	rd = parse_reg(ops[0])
	word = cond | 1 << 26 | f["b"] << 22 | f["load"] << 20 | rd << 12
	addr = ", ".join(ops[1:])
	if not addr.startswith("["):
		if f["t"] or len(ops) != 2:
			raise AsmError("bad address")
		u, off = _pcrel(ops, at, resolve, 4095)
		return word | 1 << 24 | u << 23 | PC << 16 | off
	rn, pre, bang, off = parse_address(addr)
	if f["t"] and pre:
		raise AsmError("ldrt/strt take a post-indexed address")
	word |= rn << 16 | (1 << 24 if pre else 0) | (1 << 21 if bang or f["t"] else 0)
	if not off:
		return word | 1 << 23
	if off[0].startswith("#"):
		if len(off) != 1:
			raise AsmError("bad offset")
		v, negzero = parse_imm(off[0])
		if abs(v) > 4095:
			raise AsmError("offset out of range")
		return word | (0 if v < 0 or negzero else 1 << 23) | abs(v)
	r = off[0]
	u = 1
	if r.startswith("-"):
		u, r = 0, r[1:]
	elif r.startswith("+"):
		r = r[1:]
	word |= 1 << 25 | u << 23 | parse_reg(r)
	if len(off) == 2:
		word |= encode_shift(off[1], False)
	elif len(off) > 2:
		raise AsmError("bad offset")
	return word


def _enc_ldrh(ops, f, cond, at, resolve):
	rd = parse_reg(ops[0])
	word = cond | f["load"] << 20 | rd << 12 | 0x90 | f["sh"] << 5
	addr = ", ".join(ops[1:])
	if not addr.startswith("["):
		u, off = _pcrel(ops, at, resolve, 255)
		return word | 1 << 24 | u << 23 | 1 << 22 | PC << 16 | (off & 0xF0) << 4 | off & 15
	rn, pre, bang, off = parse_address(addr)
	word |= rn << 16 | (1 << 24 if pre else 0) | (1 << 21 if bang else 0)
	if not off:
		return word | 1 << 23 | 1 << 22
	if len(off) != 1:
		raise AsmError("bad offset")
	if off[0].startswith("#"):
		v, negzero = parse_imm(off[0])
		if abs(v) > 255:
			raise AsmError("offset out of range")
		a = abs(v)
		return word | 1 << 22 | (0 if v < 0 or negzero else 1 << 23) | (a & 0xF0) << 4 | a & 15
	r = off[0]
	u = 1
	if r.startswith("-"):
		u, r = 0, r[1:]
	elif r.startswith("+"):
		r = r[1:]
	return word | u << 23 | parse_reg(r)


def parse_reglist(t: str) -> int:
	t = t.strip()
	if not (t.startswith("{") and t.endswith("}")):
		raise AsmError("bad register list %r" % t)
	mask = 0
	for item in t[1:-1].split(","):
		item = item.strip()
		if not item:
			continue
		if "-" in item:
			a, b = item.split("-")
			for r in range(parse_reg(a), parse_reg(b) + 1):
				mask |= 1 << r
		else:
			mask |= 1 << parse_reg(item)
	if not mask:
		raise AsmError("empty register list")
	return mask


def _enc_ldm(ops, f, cond, at, resolve):
	if len(ops) != 2:
		raise AsmError("ldm/stm take a base and a register list")
	base = ops[0].strip()
	w = base.endswith("!")
	rn = parse_reg(base.rstrip("!"))
	lst = ops[1].strip()
	s = lst.endswith("^")
	mask = parse_reglist(lst.rstrip("^").strip())
	return cond | 0x08000000 | f["pu"] << 23 | s << 22 | w << 21 | f["load"] << 20 | rn << 16 | mask


def _enc_pushpop(ops, f, cond, at, resolve):
	mask = parse_reglist(", ".join(ops))
	pu = 1 if f["load"] else 2
	return cond | 0x08000000 | pu << 23 | 1 << 21 | f["load"] << 20 | 13 << 16 | mask


def _enc_mul(ops, f, cond, at, resolve):
	if len(ops) != (4 if f["a"] else 3):
		raise AsmError("wrong number of operands")
	rd, rm, rs = parse_reg(ops[0]), parse_reg(ops[1]), parse_reg(ops[2])
	rn = parse_reg(ops[3]) if f["a"] else 0
	return cond | f["a"] << 21 | f["s"] << 20 | rd << 16 | rn << 12 | rs << 8 | 0x90 | rm


def _enc_mull(ops, f, cond, at, resolve):
	if len(ops) != 4:
		raise AsmError("wrong number of operands")
	lo, hi, rm, rs = (parse_reg(o) for o in ops)
	return cond | 1 << 23 | f["k"] << 21 | f["s"] << 20 | hi << 16 | lo << 12 | rs << 8 | 0x90 | rm


def _enc_swp(ops, f, cond, at, resolve):
	if len(ops) != 3 or not (ops[2].startswith("[") and ops[2].endswith("]")):
		raise AsmError("swp rd, rm, [rn]")
	return (cond | 1 << 24 | f["b"] << 22 | parse_reg(ops[2][1:-1]) << 16 | parse_reg(ops[0]) << 12 | 0x90
		| parse_reg(ops[1]))


def _psr(t):
	t = t.strip().lower()
	r, _, fields = t.partition("_")
	if r not in ("cpsr", "spsr"):
		raise AsmError("bad status register %r" % t)
	return (1 if r == "spsr" else 0), fields


def _enc_mrs(ops, f, cond, at, resolve):
	r, fields = _psr(ops[1])
	if fields:
		raise AsmError("mrs reads the whole register")
	return cond | 0x010F0000 | r << 22 | parse_reg(ops[0]) << 12


def _enc_msr(ops, f, cond, at, resolve):
	r, fields = _psr(ops[0])
	mask = 0
	for ch in fields:
		if ch not in "fsxc":
			raise AsmError("bad field %r" % ch)
		mask |= {"f": 8, "s": 4, "x": 2, "c": 1}[ch]
	if not mask:
		raise AsmError("msr needs a field mask")
	word = cond | 0x0120F000 | r << 22 | mask << 16
	if ops[1].startswith("#"):
		return word | 1 << 25 | encode_imm(ops[1:])
	return word | parse_reg(ops[1])


def _cp(t):
	t = t.strip().lower()
	if not re.match(r"^p\d+$", t) or int(t[1:]) > 15:
		raise AsmError("bad coprocessor %r" % t)
	return int(t[1:])


def _creg(t):
	t = t.strip().lower()
	if not re.match(r"^c\d+$", t) or int(t[1:]) > 15:
		raise AsmError("bad coprocessor register %r" % t)
	return int(t[1:])


def _enc_cdp(ops, f, cond, at, resolve):
	if len(ops) != 6:
		raise AsmError("cdp p#, #op1, cd, cn, cm, #op2")
	return (cond | 0x0E000000 | parse_int(ops[1]) << 20 | _creg(ops[3]) << 16 | _creg(ops[2]) << 12
		| _cp(ops[0]) << 8 | parse_int(ops[5]) << 5 | _creg(ops[4]))


def _enc_mcr(ops, f, cond, at, resolve):
	if len(ops) != 6:
		raise AsmError("mcr p#, #op1, rd, cn, cm, #op2")
	return (cond | 0x0E000010 | parse_int(ops[1]) << 21 | f["load"] << 20 | _creg(ops[3]) << 16
		| parse_reg(ops[2]) << 12 | _cp(ops[0]) << 8 | parse_int(ops[5]) << 5 | _creg(ops[4]))


def _enc_ldc(ops, f, cond, at, resolve):
	word = cond | 0x0C000000 | f["n"] << 22 | f["load"] << 20 | _cp(ops[0]) << 8 | _creg(ops[1]) << 12
	addr = ", ".join(ops[2:])
	rn, pre, bang, off = parse_address(addr)
	word |= rn << 16 | (1 << 24 if pre else 0) | (1 << 21 if bang else 0)
	if not off:
		return word | 1 << 23
	o = off[0].strip()
	if o.startswith("{"):
		if pre:
			raise AsmError("an option goes with [rn], {n}")
		return (word | 1 << 23 | parse_int(o[1:-1])) & ~(1 << 21)
	if not pre:
		word |= 1 << 21
	v, negzero = parse_imm(o)
	if abs(v) > 1020 or v & 3:
		raise AsmError("coprocessor offset out of range")
	return word | (0 if v < 0 or negzero else 1 << 23) | abs(v) // 4


def roundtrips(word: int, at: int = 0):
	"""The word's Insn when its text assembles back to the word, else None."""
	insn = decode(word, at)
	if insn is None:
		return None
	try:
		if encode(insn.text, at) != word:
			return None
	except AsmError:
		return None
	return insn
