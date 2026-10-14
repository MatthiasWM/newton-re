# tools/pict - the Newton's QuickDraw pictures as text and PNG

The ROM keeps some of its pictures (class `'picture`) as QuickDraw PICTs:
32 of them, in the base ROM's objects and in the Setup, help book and
Cardfile parts of the ROM extension. The ROM source tree (`romsrc/`) keeps
each as `picture('picture, "resources/picture/<addr>")` - the directory
described below, which `romsrc.py build` packs (`romsrc.py extract` writes
a picture so when it comes back the same, and otherwise as `pict(...)`, a
PICT file: 512 bytes of nought then the picture). `newtonpict.py` (Python 3.9+, standard library
plus [`tools/imaging/png.py`](../imaging/png.py)) turns a picture into a
directory a person can edit with a text editor and a paint program, and
packs it back byte for byte. How the Newton plays a picture is
`src/qd/PicPlay.cpp` (`ParsePicCodes`, `GetPicBits`).

## Commands

    python tools/pict/newtonpict.py unpack X.pict DIR
    python tools/pict/newtonpict.py pack DIR X.pict
    python tools/pict/newtonpict.py check X.pict...

`unpack` writes `DIR` afresh (`picture.txt` and a PNG per bitmap) and
packs it again, failing (exit 1) unless that gives back the picture
exactly. `pack` writes a PICT file (the 512-byte header, then the picture)
from a directory, edited or not. `check` says whether each picture
round-trips, and what (if anything) had to be kept raw. A `.pict` given
to `unpack` or `check` may have the 512-byte header or not (a file whose
first 512 bytes are all nought is taken to have it). A mistake in the
directory is reported as `error: DIR/picture.txt line N: ...` (exit 1).

As a module (what `romsrc.py` would call):

    unpack(data: bytes, path: str) -> None        # data: the picture, without the 512-byte header
    pack(path: str) -> bytes                      # the picture, without the 512-byte header
    roundtrips(data: bytes) -> (bool, [str])      # whether it comes back, and what was kept raw
    unpack_notes(data, path) -> [str]             # unpack, returning what was kept raw
    PictError                                     # raised for a picture or directory it cannot take

## picture.txt

One line per opcode, in the picture's order. `#` starts a comment (the
unpacker puts what an operand is in one); rectangles are `top left bottom
right`, points `v h`, as QuickDraw stores them. Numbers may be decimal or
`0x` hex.

| Line | What |
|---|---|
| `picSize auto` | the picture's first word: `auto` is its length's low 16 bits (what QuickDraw writes); a number is written as given |
| `picFrame T L B R` | the picture's frame |
| `version 1` / `version 2` | `0x11 0x01`, or `0x0011 0x02ff`: one-byte opcodes, or two-byte opcodes with each opcode's data padded to an even length |
| `Name operands...` | an opcode by Apple's name (`Clip`, `PnSize`, `ShortLine`, `ShortComment`, `LongComment`, `HeaderOp`, `DefHilite`, `paintRect`, `frameSameOval`, `LongText`, `OpEndPic`, ...; the full table is `OPS` in the script) |
| `pad 0xNN` | a version 2 alignment byte that is not nought (none of the ROM's) |
| `data HEX` | bytes copied as they are: an opcode the script does not decode and everything after it, or bytes after `OpEndPic` (none of the ROM's) |

Operands: regions (`Clip`, `paintRgn`, ...) are their rect then, for a
region that is not a rectangle, the rest of it in hex - the size word is
worked out. Polygons are the bounding rect then the points. Transfer modes
go by name (`srcCopy`, `srcOr`, ..., `notPatBic`, `ditherCopy`), comment
kinds by number (`ShortComment 130`, the unpacker naming it `picDwgBeg` in
a comment; the name is accepted too), a long comment's data in hex (`-`
for none), strings quoted with `\"`, `\\` and `\xNN` escapes, patterns as
16 hex digits, 16.16 numbers as decimals (`1.5`). `HeaderOp` (version 2's
`0x0c00`) is its version (`-1`), the frame as 16.16 `left top right
bottom`, and the reserved long.

A bitmap opcode - `BitsRect`, `BitsRgn`, `PackBitsRect`, `PackBitsRgn` -
names its PNG and is followed by its fields (indented by convention):

| Field | What |
|---|---|
| `rowBytes auto` | the bytes in a row: `auto` is the bounds' width in bytes rounded up to an even number (every ROM bitmap's); a number is used as given |
| `bounds T L B R` | the bitmap's bounds: its size must be the PNG's |
| `srcRect`, `dstRect` | what of the bitmap is drawn, and where |
| `mode` | the transfer mode |
| `maskRgn` | (`BitsRgn`, `PackBitsRgn`) the mask region |
| `packing` | (PackBits, `rowBytes` 8 or more) which packer made the rows, below |
| `packed ROW HEX` | a row the packer does not reproduce: its packed bytes (without the count). Used only while they still unpack to the row; a row edited since is packed afresh. None of the ROM's. |
| `padding ROW HEX` | a row's bits past the bounds' width, when not nought: the whole row's bytes with every pixel's bit clear, OR'd in on packing. None of the ROM's. |

The PNG is 1 bit deep, black a set bit (as `romsrc.py` writes bitmaps);
any PNG `png.py` reads is taken, by luminance. A row's count (a byte, or a
word when `rowBytes` is more than 250) is worked out; under 8 `rowBytes`
the rows are not packed, as QuickDraw has it. Pixel maps (`rowBytes` with
its top bit set) are not decoded: such an opcode and all after it become
`data` (none of the ROM's pictures has one).

### The packers

Each row is packed with PackBits (a byte `n` under 128: `n + 1` literal
bytes follow; over 128: the next byte `257 - n` times). The same row can be
packed in more than one way, and the ROM's pictures were made by three
packers; the unpacker picks, per bitmap, the one that reproduces the most
rows (all of them in every ROM picture):

| `packing` | Rule | ROM pictures |
|---|---|---|
| `classic` | a run of three or more equal bytes (up to 128) is a repeat; so is a row's last two bytes when they are equal; everything else gathers into literals of up to 128 | the 16 version 1 PackBits pictures |
| `runs3` | the same, but a pair at the end of a row stays literal | `help_book` 7748e1 (version 2) |
| `none` | every row one literal (per 128 bytes) - no packing at all | `help_book` `unistroke-letters`, `unistroke-others` (version 2) |

That `classic` is how the Toolbox's `PackBits` packs was established by
packing every row of the 16 version 1 pictures (1,680 rows) and getting
their bytes back; the version 2 ones came from other tools.

## Editing

- **Pixels**: edit the PNG at the same size and pack: rows are packed with
  the bitmap's `packing`, the counts and `picSize` worked out.
- **Size**: a PNG of another size is refused, the message giving the
  `bounds` to set (`bits1.png is 128 x 101 pixels but its bounds 132 8 233
  120 make 112 x 101: set bounds to 132 8 233 136 (and srcRect, dstRect,
  Clip, picFrame and HeaderOp to suit)`); `rowBytes auto` follows the
  width. What should be drawn of the bigger bitmap - `srcRect`, `dstRect`,
  the clip and the frame - is the editor's choice.
- **Opcodes**: lines can be added, removed or changed; version 2 padding
  is inserted as needed.

## Tests

`python tools/pict/test_newtonpict.py [--rom build/MP2x00US]` (unittest;
ctests `tools.NewtonPict`, `tools.NewtonPictROM`): all 32 committed
pictures (the directories under `romsrc/` holding a `picture.txt`) pack,
unpack to their committed `picture.txt` with nothing kept raw and pack
back byte for byte - with `--rom`, to the ROM object's bytes for the 30
named after their address - and `check` says so; a pixel flipped in a PNG changes just
that bit and the result unpacks again; a wider PNG is refused with the
bounds to set, and packs once they are; synthetic version 2 and version 1
pictures cover every operand kind, a nonzero alignment byte, a row kept
as `packed` (and packed afresh once edited), padding bits, a mask region,
an undecoded pixel map, word row counts and bytes after `OpEndPic`.
