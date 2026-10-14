# tools/armpart - packages' native ARM code as editable assembly

A Newton package's *protocol part* (part kind 0: NTK's native code - a
driver, a comms tool, a card handler) is big-endian ARMv4 code and data
that starts with the `TClassInfo` the package manager registers
(`headers/OS600/Protocols.h`; `docs/packages/README.md` "Protocol parts").
The host does not run these (the parts in `romsrc/rex` are the screen
drivers of the ROM extension and the Newton Internet Enabler's), but
`romsrc/` keeps the ROM's world as source, so they need a source form too.

`newtonarm.py` turns a protocol part into one assembly file - instructions
with labels, the class-info table and strings as data directives with
symbolic references, the package's relocations as symbolic `.rword`s - and
assembles it back, **byte for byte** for an unedited file and with every
branch, load, address, offset and relocated word following its target for
an edited one. `armv4.py` is the instruction set under it: a disassembler
and an assembler for ARMv4 (the StrongARM SA-110's), written as each
other's inverse. `newtonpkg.py` splits a whole package into its directory
(text), its protocol parts (`.s`) and its other parts (bytes) and puts it
back together. All three are Python 3.9+, standard library only; capstone
(`requirements.txt`) only cross-checks the assembler in the tests.

## Commands

    python tools/armpart/newtonarm.py unpack FILE.pkg --part N OUT.s [--rom BUILD]
    python tools/armpart/newtonarm.py unpack PART.bin OUT.s [--origin N] [--relocations OFF,...] [--rom BUILD]
    python tools/armpart/newtonarm.py pack IN.s OUT.bin [--origin N]
    python tools/armpart/newtonarm.py check FILE.pkg...

    python tools/armpart/newtonpkg.py unpack FILE.pkg DIR [--rom BUILD]
    python tools/armpart/newtonpkg.py pack DIR FILE.pkg
    python tools/armpart/newtonpkg.py check FILE.pkg...

`unpack` writes the source and then assembles it again, refusing (exit 1)
unless that gives back the input exactly. Taken from a package, a part
comes with its relocations (the package's relocation chunk names words in
it) and its offset in the package; a bare part file takes them as options.
`--rom build/MP2x00US` (an extracted ROM: `rom.bin`, `symbols.txt`) names
the ROM function each NTK glue stub reaches - `ldr pc, [pc, #-4]` and a
word 0x018xxxxx, which the ROM maps onto a table of branches at physical
0x13000 into its jump table - so `bl glue_01802550` reads
`bl GetContiguousMemory__FP6TUPhysUlT2UcT4`; it changes only names, never
bytes. `pack` assembles (`--origin` puts the part elsewhere in its
package); `check` round-trips every protocol part of the packages and
says how much of each is code.

As modules:

    newtonarm.unpack(part, path, relocations=(), origin=0, rom=None, title=None) -> stats
    newtonarm.pack(path, origin=None) -> bytes
    newtonarm.assemble_file(path, origin=None) / assemble(text, origin=None, name) -> Assembled
        .data, .relocations (offsets in the part of the .rword words), .origin,
        .labels (name -> offset), .lines (source line -> offset)
    newtonarm.disassemble(part, relocations=(), origin=0, rom=None, title=None) -> text
    newtonarm.protocol_parts(package bytes) -> [ProtocolPart(.index, .data, .relocations, .origin)]
    newtonarm.RomNames(build_dir)         the --rom names
    newtonpkg.unpack(data, dir, rom=None); newtonpkg.pack(dir) -> bytes; newtonpkg.roundtrips(data)
    armv4.decode(word, at) -> Insn | None; armv4.encode(text, at, resolve) -> word

## The source file

    ; "Newton Devices" part 4: protocol (3372 bytes)
    ; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

        .origin 0x2a68          ; the part's offset in its package as linked (.rword values add it)

    ClassInfoTable:
        .word 0x00000000                    ; fReserved1
        .word ImplementationName - .        ; fNameDelta
        .word InterfaceName - .             ; fInterfaceDelta
        .word Signature - .                 ; fSignatureDelta
        .word BTable - .                    ; fBTableDelta
        .word EntryProc - .                 ; fEntryProcDelta
        b Sizeof                            ; fSizeofBranch
        .word 0x00000000                    ; fAllocBranch
        ...
    ClassInfo:
        adr r0, ClassInfoTable
        mov pc, lr
    ImplementationName:
        .asciz "TLanternCardHandler"
    InterfaceName:
        .asciz "TCardHandler"
    Signature:
        .asciz ""
        .align 4
    BTable:
        .word 0x00000000                    ; dispatch slot 0
        b ClassInfo                         ; dispatch slot 1
        b DefaultNew                        ; dispatch slot 2
        ...
    sub_00d8:
        mov ip, sp
        stmdb sp!, {r4, r5, fp, ip, lr, pc}
        sub fp, ip, #4
        movs r4, r0
        mov r5, r1
        bne loc_0108
        mov r0, #8
        bl __nw__FUi
        ...
        adr r2, str_018c, #30
        bl Lookup__12TUNameServerFPcT1PUlT3
        ...
    str_018c:
        .asciz "TUPort"
        .align 4
    ...
    __nw__FUi:
        ldr pc, lit_0d28
    lit_0d28:
        .word 0x01800e04                    ; glue 01800e04 -> __nw__FUi

| Line | Means |
|---|---|
| `; ...` | a comment, to the end of the line (not inside a string) |
| `name:` | a label; its value is its offset in the part (labels may share a line with what follows) |
| `.origin N` | where the part lies in its package as linked (its offset from the package's start: the relocation chunk's base address is 0) - what `.rword` adds; `pack --origin` overrides it |
| `.word e, ...` | words; `e` sums numbers, labels and `.` (this word's offset) with `+`/`-`: `.word Label - .` is a self-relative offset |
| `.rword e` | a word the package's relocation chunk names: `.origin + e`. `pack` reports their offsets so the package's chunk can be rebuilt |
| `.byte n, ...`, `.ascii "s"`, `.asciz "s"`, `.space n`, `.align n` | bytes; strings take `\"`, `\\`, `\n`, `\t`, `\r`, `\0`, `\xHH`; `.space` is noughts; `.align 4` pads with noughts to a multiple of four from the part's start |
| an instruction | ARMv4 in the syntax `armv4.py`'s docstring gives (capstone's unified syntax with the classic `ldmia`/`stmdb`, `mov rd, rm, lsl #n` and `swi` spellings, the condition last: `ldrbeq`, `addseq`, `ldmdbne`) |

In instructions, a branch target, the address of `ldr rd, <e>` (a
pc-relative load, also `ldrb`/`ldrh`/...) and of `adr rd, <e>` (`add|sub
rd, pc, #imm`) are expressions. A number as a branch target is an offset
from the part's start: one outside the part (the ROM extension's parts
branch straight into the ROM, e.g. `b 0x165aa00` in ScreenBuffer's class
info) keeps reaching the same place wherever the instruction moves. `adr
rd, label, #30` gives the immediate's rotation: the compiler (Norcroft)
sometimes rotates a small offset by 30 where the canonical encoding would
not rotate it, and the source keeps that choice. `#imm8, #rot` is the
same for any other immediate. `push`/`pop`, `ldmfd`/`stmfd`-style
aliases and register ranges `{r4-r6}` are accepted on input.

### How the disassembler tells code from data

- The class info at offset 0: its five self-relative offsets become `.word
  Label - .` with the names, the capability list (`Signature`), the
  dispatch table (`BTable`) and the monitor entry (`EntryProc`) labelled;
  its branch fields that hold a `B` (or `mov pc, lr`) are instructions and
  their targets are entry points (`Sizeof`, `DefaultNew`, ...); the
  dispatch table's `B`s are entry points too (`ClassInfo`, `New`, `Delete`,
  `MethodN`).
- The flow is followed from every entry point: branches and calls add
  their targets; an unconditional branch, a load of pc or a data
  processing instruction writing pc ends a path (unless `mov lr, pc` comes
  just before it: a call, as a virtual call `add pc, rN, #slot*4` is);
  `add pc, pc, rN, lsl #2`
  makes the run of `B`s after it a jump table; a pc-relative word load
  makes its target a literal (`.word`, with a four-character or glue
  comment).
- What nothing reached is tried speculatively, word by word: a path that
  starts with an unconditional instruction and stays plausible (no
  coprocessor, status-register or user-bank transfers, no landing in data
  or off the part) is kept whole (`sub_XXXX`); else the words are data.
  This finds the functions reached only through relocated pointers and
  the monitors' selector tables.
- The relocation chunk's words are `.rword label` (the pointers in the NIE's
  parts are all in it); the rest is data: C strings (four printable
  characters or more, then a nought) as `.asciz`, padding as `.align 4`,
  runs of noughts as `.space`, words as `.word 0x...` with what they read
  as in a comment (a four-character code, the instruction).
- An instruction is written as text only if that text assembles back to
  the same word - otherwise (a should-be-zero field that is not, an
  encoding the canonical text would not give) it is a `.word`; a reference
  is written as a label only if the labelled text assembles back to the
  same word. So `assemble(disassemble(x)) == x` by construction, and
  `unpack` checks it anyway.

Labels: `ClassInfoTable`, the class-info names above, glue stubs by the
ROM function (or `glue_018xxxxx` without `--rom`), `sub_XXXX` (called, or
found speculatively), `loc_XXXX` (branched to), `lit_XXXX` (loaded),
`str_XXXX` (a string), `data_XXXX` (an address taken); `XXXX` is the
offset in the part as unpacked.

### What an edit may do

Insert, remove or change instructions and data anywhere: branches, calls,
pc-relative loads, `adr`s, the class info's self-relative offsets and the
relocated words follow their labels, and `pack` reports the `.rword`s'
new offsets. The assembler says (with the line) when a target is out of
reach: a pc-relative load beyond 4095 bytes, an `adr` offset that is no
rotated byte (move the data, or load the address from a literal), a branch
beyond 32 MB, an undefined label. What does not follow an edit: a word the
disassembler kept as data that is really code or an address (none of the
corpus's), `mov rX, pc` (ScreenDrivers' `mov r0, pc; mov pc, lr` hands back the
address of the string that follows: keep the three together - the source
comments every such instruction), and a number in a branch outside the
part (deliberately fixed).

## The package's text form (newtonpkg.py)

    # A Newton package's directory: python tools/armpart/newtonpkg.py pack DIR OUT.pkg
    signature package1
    type 'xxxx'
    flags 0x46000000
    version 2001
    copyright "Copyright ©1997 Newton, Inc.  All rights reserved.\0"
    name "Newton Internet Enabler\0"
    date 0xb0558164
    reserved2 0x00000000
    reserved3 0x00000000
    trailer "Newton Toolkit 1.6.4b2c2\0"
    pad 0xff
    relocation-page-size 1024
    relocation-base 0x0
    relocation-reserved 0x0
    relocation-slack 376

    part 0
        file part0.bin
        type 'auto'
        flags 0x81
        info "Newton Toolkit 1.6.4b2c2; platform file Newton 2.1 v5"
        compressor ""
        linked-at 0x804

    part 2
        file part2.s
        type 0x00000000
        flags 0x30
        info "Newton Toolkit 1.6.4b2c2; platform file Newton 2.1 v5"
        compressor ""

The header's fields are as the directory has them (the package format:
`tools/newton-rom/analysis/packages.py`'s docstring). `copyright` and `name`
are UTF-16 (`\0` the terminator, `\uXXXX` an unprintable character), `info`
and `compressor` bytes (`\xHH`). The directory data is the strings one
after another - copyright, name, each part's info and compressor, unless a
`layout` line orders them otherwise - and the runs of bytes no InfoRef
points at where they lie (`trailer`, `trailer2`, ...: NTK's own name, the
NewtCard stacks' noughts), padded to four with `pad`. A part is its
`file`: a `.s` for a protocol part, assembled at the offset it falls at, or
the bytes, with (`relocations`, part-relative) the words of it the
relocation chunk names and (`linked-at`) the offset it was linked at. A
part's `size2`, `reserved` are written only when they are not the size
and nought.

`pack` works out the rest: the directory's size, each part's offset (one
after another, padded to four) and size, the relocation chunk (its header
from the `relocation-*` lines; then for each page, ascending, its number,
count and word indices, padded to four; then `relocation-slack` noughts,
room NTK reserved and did not use), which moves every part after it, and
the package's size. A part that ends up somewhere other than it was
linked moves its relocated words with it, and a frames part is rebased
too (its pointer refs are offsets in the package; `packages.py`'s
`rebase_frames_part`). So an edited protocol part, a renamed package or a
longer info string gives a consistent package. Frames parts stay bytes:
making them source trees is separate work (`romsrc/`'s NewtonScript
trees).

`unpack` refuses a package laid out otherwise than this reads (strings
overlapping, bytes between parts or after the last, a relocation chunk not
in this order); every package in `romsrc/rex` and under
`fixtures/packages` round-trips (the NS Basic files there are not packages).

## Round trips

| Package | Part | Bytes | Instructions | Data words | Relocated |
|---|---|---|---|---|---|
| ScreenBuffer | 0 | 256 | 38 | 26 | 0 |
| ScreenDrivers | 0 | 4172 | 969 | 74 | 0 |
| Newton Devices (newtdev) | 2 | 660 | 145 | 20 | 0 |
| | 3 | 4604 | 1076 | 75 | 0 |
| | 4 | 3372 | 743 | 100 | 0 |
| | 5 | 13492 | 3193 | 180 | 27 |
| | 8 | 9380 | 2213 | 132 | 11 |
| Newton Internet Enabler (inetenbl) | 2 | 74076 | 17996 | 523 | 209 |
| | 3 | 13184 | 3194 | 102 | 0 |
| | 4 | 22568 | 5520 | 122 | 0 |
| | 5 | 648 | 108 | 54 | 0 |
| | 6 | 580 | 95 | 50 | 0 |
| | 7 | 6524 | 1539 | 92 | 12 |
| | 9 | 288 | 41 | 31 | 0 |
| | 10 | 18340 | 4416 | 169 | 0 |

All identical (`newtonarm.py check romsrc/rex/*.pkg`; Internet Setup,
inetstup, has no protocol part). The data words are the class infos,
names, literals and tables. The 20 protocol parts of the NIE packages
under `fixtures/packages` (copies of these and the Ethernet, LocalTalk and
modem modules) round-trip as well.

## Tests

- `python tools/armpart/test_newtonarm.py [--packages DIR]`: every protocol
  part of the five packages round-trips (and those under
  `fixtures/packages`); the class info is symbolic; an instruction
  inserted half-way through ScreenDrivers, newtdev's part 5 (relocated) and
  inetenbl's part 2 assembles with every word after it checked against the
  original - each label reference moved by four, each relocated word and
  self-relative offset following, everything else unchanged; the source
  syntax and the assembler's errors; the codec on known and random
  words; and (with capstone, `pip install -r tools/armpart/requirements.txt`,
  else skipped) every instruction in the corpus and 20000 random words,
  assembled from their text, read back by capstone as the same
  instruction.
- `python tools/armpart/test_newtonpkg.py [--packages DIR] [--no-fixtures]`:
  every package in `romsrc/rex` and under `fixtures/packages` splits and
  goes back together byte for byte; an instruction inserted into newtdev's
  part 2 and a longer package name give packages whose parts, relocation
  chunk, relocated words and frames parts' refs all moved along.

Both are plain `unittest` (no ROM image needed); ctests for them would be

    add_test(NAME tools.ARMPart COMMAND ${Python3_EXECUTABLE} ${CMAKE_SOURCE_DIR}/../tools/armpart/test_newtonarm.py)
    add_test(NAME tools.NewtonPackageText COMMAND ${Python3_EXECUTABLE} ${CMAKE_SOURCE_DIR}/../tools/armpart/test_newtonpkg.py)
