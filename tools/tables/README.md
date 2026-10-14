# tools/tables: the Unicode, collation and locale tables as text

The ROM keeps its character tables as binaries in NewtonScript objects:
the 'unicode frame's (Runicode, installed by `frames/UnicodeTables.cpp`'s
`InitUnicode`: the three encodings' maps to and from Unicode, the
character classes, their types and the four case tables), the sorting
tables (`Rsorttables`, `frames/SortTables.h`) and each locale's
`wordBreakTable` and `lineBreakTable` (`qd/Text.cpp`'s `FindWordBreaks`).
`romsrc/` keeps all sixteen as text - `texttable(class, "path.txt")` in
the object files - and `newtontables.py` makes the ROM's bytes out of
them, exactly the ROM's for the committed files.

Each file says what it is on its first line, `format <kind>`; `#` starts
a comment, and the unpacker puts the character a line is about in one.

| format | what | a line |
|---|---|---|
| `to-unicode` | an encoding's `mapToUnicode`: the character each byte stands for; the header's four halfwords (kind 0, 256 entries, flags, segments) | `0x80 U+00C4` |
| `from-unicode` | its `mapFromUnicode`: `segment U+first U+last`, then each character of it and its byte; the segments' bytes lie one after another, and a character in none becomes 0x1a | `U+00C4 0x80` |
| `char-classes` | `charClass`: the class of each Mac Roman character | `0x41 2` |
| `class-types` | `typelist`: each class's type flags | `2 0x01` |
| `class-deltas` | `upperList`, `lowerList`, `upperNoMarkList`, `noMarkList`: what is added to a character of each class | `3 -32` |
| `sort-table` | a sorting table: `id`, each `range`'s characters with their projection (primary weight; 0 ignored, 0xffff a ligature) and second-order weight, the `singles` (any order: they are sorted), the `ligatures` (the character, the two it sorts as, the least character sorting the same) and the `lowest` table (the least character of each primary weight). The counts and offsets in the header are worked out. | `U+0061 0x0041 0x0007` |
| `break-table` | a break table: `flags`, `backup` (how near the start the backward scan is skipped), the `classes` of the 256 characters, the `aux` bytes, then the `backward` and `forward` state machines - `states` (each entry's row; a state is named by its offset into that list, two to an entry) and the `row`s (the next state for each class, `*` where a word may begin or end) | `row 0 20* 4* 6* 8 8 0 0 0 8 0 0` |

## Use

    python tools/tables/newtontables.py unpack sort-table X.bin X.txt
    python tools/tables/newtontables.py pack X.txt X.bin
    python tools/tables/newtontables.py check sort-table X.bin...

`romsrc.py extract` writes a binary of class 'UniC (by its slot),
'Sort, or 'Intl (a `wordBreakTable` or `lineBreakTable` slot) this way when
it comes back the same, and `romsrc.py build` packs `texttable(...)`.

Tests: `test_newtontables.py [--rom build/MP2x00US]` (ctests
`tools.NewtonTables`, `tools.NewtonTablesROM`: the sixteen committed
files pack to the ROM's bytes and unpack to their committed text, and
edits read back); `table_edit_test.py` (ctest `host.ROMSourceTableEdit`:
a and z given each other's weights in the default sorting table, and the
booted machine's `StrCompare("apple", "zebra")` changes sign).

## The ink code books, the trigrams and the letter pictures (`inktables.py`)

Three more kinds of the ROM's trained data, which `romsrc/` kept as raw
binaries, have a text form made and read by `inktables.py` - the same
conventions (`format <kind>` first, `#` comments), the ROM's own bytes
for every committed file:

| format | what | a line |
|---|---|---|
| `code-book` | an ink code book ('Comp: `codebook1` = `Rparagraphcodebook1`, the writing book, and `codebook2` = `Rparagraphcodebook2` = @145, the ink book; `ink/CICCodec.h`). Eight `table N`s, each its four header words - `base-down`, `base-up`, `escape-up`, `escape-down` (`CodeTableBaseDown` ...) - and its code words: the value, then its code as the bits come out of the stream, first bit first (`DecodeWord_OLD` reads `code \|= bit << n`). A table's size and count are worked out, and its entries put in order of code length (stably), which the decoder needs; a code that begins with another is refused, since the decoder would never get to it. | `27 100011` |
| `trigrams` | the 'Trigrams binary (`Rtrig`): a weight 1-3 for each three-symbol sequence that has one, the symbols `a`-`z`, `'` and `_` (the edge of a word); a sequence not listed is 0 | `the 3` |
| `letter-images` | the 'letterimages binary of `charsetInfoResources` (`recognition/LetterShapes.h`): each `letter` (its Mac Roman byte, the character in a comment), each of its variants as `variant group G` in order, and each variant's strokes as `x,y` points in the 0-255 box (the letter's body between y 0x55 and 0xaa). Every count and offset is worked out. | `stroke 127,22 127,58 127,89 127,127 127,145` |

What each format's bytes are, and how it was established:

- **code-book.** A table is six big-endian halfwords - size
  (12 + 8 x count), count, base-down, base-up, escape-up, escape-down -
  then eight bytes an entry: the value (signed), the code's length in
  bits, and the code as a word whose bit 0 is the first bit read
  (`ink/CICDecoder.cpp`'s `CodeTable*` accessors and `DecodeWord_OLD`).
  `DcdrSelectCodeBook` takes eight tables one after another by their
  sizes; the eight are read for, in order, the x and y of the step to
  where a stroke starts, of a segment's end (or a short stroke's step),
  and of a segment's two bending numbers (`ReadNewStroke`,
  `ReadSegmentNear`, `ReadShortStroke`; the unpacker says which in a
  comment).  Both books are exactly eight tables with nothing after, in
  order of code length, every code shorter than 2^length, and every
  table's codes **complete** - the sum of 2^-length over a table is
  exactly 1 (checked over both committed books), so any string of bits
  begins with some code.  A value is therefore added by splitting a code
  in two (`v 0101` becomes `v 01010` and `w 01011`), not by inventing a
  fresh one, which would begin with an existing code and be refused.
  Who reads the second book: `romsrc/magic.tsv` names @145 `obj_63dedd`;
  the ROM constant `Rparagraphcodebook2` (0x0068133c) is that magic
  pointer (0x247), the word at 0x003af248 - the magic-pointer table's
  entry - is the only other place the ROM holds 0x0063dedd, and the one
  function that reads the constant is `InitializeParagraphCompression`
  (0x001543a4, found with `analysis/xrefs.py ... Rparagraphcodebook2`),
  which makes it `globalCodeBookPtrInk`, the book `LockCodeBook(2)`
  answers - the ink book, used for ink formats 2 and 3.
- **trigrams.** 8192 bytes: 32 x 32 x 32 two-bit entries, entry
  (a x 32 + b) x 32 + c in byte i >> 2 at bits 2 x (i & 3) - the first
  entry of a byte in its lowest bits.  Established from the data: read
  that way, exactly the symbols 1-28 are used in every position (read
  most significant first, the third position uses 0 and 31 and not 3 or
  28, which no alphabet explains); 1-26 are a-z by their frequencies
  (`q` is followed only by `u`, `the`, `ing`, `ion` weigh 3); 27 is an
  apostrophe (the trigrams with it are `n't`, `'ll`, `'re`, `'ve`, `'s`,
  `'d`, `'m`) and 28 the edge of a word (it comes first in trigrams
  such as `_th` and last in ones such as `ng_`, and `x__` is set for
  nearly every letter x).  Symbols 0 and 29-31 are written
  `<n>` should one ever be used.  **Nothing in the ROM's code reads this
  table**: the only place its reference (0x005ba4b1) occurs in the ROM is
  `Rtrig` (0x00680eb4), whose only reference is `RStrig`, the constant's
  export for packages, which nothing references either (`analysis/
  xrefs.py ... Rtrig RStrig`, and a byte search of `rom.bin`).  The
  cursive recogniser's trigrams are a different table, `DTETrigrams`
  (`obj_623fc9`, 40 symbols, read by `Xrlv.cpp`).  So what the weights
  1-3 mean is not established.
- **letter-images.** As `recognition/LetterShapes.h` describes it (from
  `LILetterCount`, `GetNextLetter`, `LIGetVariantInfo`, `LIGetStrokeInfo`
  and `LIGetPoint`): a word, the letter count; each letter its byte, its
  variant count and a halfword offset per variant; a variant its group,
  its stroke count and a halfword offset per stroke; a stroke its point
  count and an x and a y byte per point.  The ROM lays out all the
  letters' headers, then every variant, then every stroke, each in order
  with no gaps and nothing shared (checked when unpacking), so packing
  lays them out the same way and no offset is kept in the text.  The
  order of the letters and of a letter's variants is kept: the slip
  numbers variants across the letters (`LIGetVariantIndex`).  89 letters,
  831 strokes.

Use:

    python tools/tables/inktables.py unpack code-book X.bin X.txt
    python tools/tables/inktables.py pack X.txt X.bin
    python tools/tables/inktables.py check code-book X.bin...

As a module: `FORMATS`, `unpack(data, format, path)`,
`pack_lines(format, lines, base)` (the text split on newlines, its format
line included; `base` is the text's directory, which none of these
formats needs) and `pack(path)`.  Tests: `test_inktables.py [--rom
build/MP2x00US]` - the four committed binaries unpack and pack back to
the same bytes and the same text (with `--rom`, the ROM's own bytes), and
edits read back: a code word's value, a code split to add a value (the
table's size and count and every later table move), a code that begins
with another refused, trigram weights, a point moved and a stroke added
to a picture (every later offset moves).
