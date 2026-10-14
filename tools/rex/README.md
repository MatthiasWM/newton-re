# tools/rex: the ROM extension's pieces and the parameter block as text

`romsrc/` (`romsrc/README.md`) keeps the ROM extension - the "high"
file, at `ROM$$Size`, 0x71fc4c - cut into pieces in address order
(`rex.tsv`), and the ROM's other data that code reads at its ROM address
by name (`romdata.tsv`). The packages' frames parts are trees of objects
of their own; `rextext.py` is the text form of what lies around them -
the extension's header, its config entries, the package directories,
the page, export and patch tables, the padding - and of the parameter
block `gParamBlock`. It makes their bytes back, the ROM's own for every
committed file (`romsrc.py build` packs them; `romsrc.py extract` writes
them, keeping a piece's bytes as `.bin` when its text would not give
them back).

Each file says what it is on its first line that is not a comment,
`format <kind>`; `#` starts a comment, `"strings"` are UTF-8 with
`\uXXXX` escapes, `'tags'` are four characters.

| format | files | what | a line |
|---|---|---|---|
| `rex-header` | `rex/header.txt` | the extension's header (`RExHeader`, `headers/OS600/ROMExtension.h`): signatures, checksum (which nothing in the ROM reads), version words, id, and an `entry` per config entry naming the rex.tsv piece it starts at and, when it covers several, the piece it runs up to (`end`: the extension's end). **Worked out:** the length, the start, the count, every entry's offset and length - so an entry follows its pieces wherever they now lie | `entry 'pkgl' rex/Cardfile.head.txt rex/pad_7ebfc8.txt` |
| `config-table` | `rex/dio_*.txt`, `gpio_*.txt`, `ralc_*.txt` | a version word, then rows of words: `columns` names a row's words (documentation - the row's width is their number), a `row` line each. **Worked out:** the count. What reads them: `TBIOInterface::Init` 0x0026b620 ('dio '), `TGPIOInterface::Init` 0x0026c0d0 ('gpio'), `RAMAllocTable` ('ralc') | `row 15 0x8000 0 0 1 0 0 0 0 0` |
| `page-table` | `rex/ptpt_*.txt`, `glpt_*.txt` | a coarse page table: runs of entries, each the page's physical address and the small-page descriptor's 12 bits of flags. 'ptpt maps the 1 MB at 0x01e00000 + id MB where the patch table is seen (`UseROMJumpTables` 0x001832e8, `BuildPatchTablePageTable` 0x00183230); 'glpt is the same 4 MB on, for a machine whose ROM lies there. Carried as they are: they name the patch table's page in the ROM, which nothing on the host reads | `0-223 0x007ee000 0xaae` |
| `refs` | `rex/fexp_*.txt` | words, one to a line: the frame export table, the refs of the objects the packages export (magic-pointer table 2), each with a comment naming its package and the object's path. `build --relayout` moves each with its object and appends entries for the packages it adds | `0x00720bad # 0: Cardfile obj_720bad` |
| `patch-table` | `rex/jump_*.txt` | the C patch table: `at`, the virtual address it is seen at (0x01e00000), then each entry's target - an ARM `B` encoded relative to the entry's own virtual address. The eighteen entries go into ScreenBuffer's and ScreenDrivers' code | `0x007a5690 # 0: ScreenBuffer.pkg +0x13c` |
| `pad` | `rex/pad_*.txt` | padding: its `fill` byte and the `align`ment the piece after it starts on. **Worked out:** its length | `align 0x1000` |
| `package-directory` | `rex/<Package>.head.txt` | a package's directory (packages.py): signature, type, flags, version, copyright and name (UTF-16 in the package; the terminator added), creation date, the two reserved words, a `part` line per part (type, reserved word, flags, info, compressor name), the `trailer` (NTK's signature, which nothing points at) and the `fill` byte. **Worked out:** the package's and the directory's sizes, every InfoRef, each part's offset and size - the parts are the rex.tsv pieces after it, so a part that grows or shrinks is followed | `name "Cardfile"` |
| `words` | `romdata/gParamBlock.txt` | a block of words: `at`, then each word's address, its name (the ROM's symbol, or `word`) and value; `zeros N` for N bytes of nought. A line's address must be where the line before it ends, so a line left out is caught | `0x13dc gROMVersion 0x00020002` |

What is still bytes in `rex/`: the packages with no frames part split
out - ScreenBuffer and ScreenDrivers (ARM protocol code) and WorldData
(a soup) - as `.pkg` files, and the three packages added to the
extension (`newtdev`, `inetenbl`, `inetstup`).

## Use

    python tools/rex/rextext.py pack romsrc/rex/ptpt_7ec000.txt OUT.bin
    python tools/rex/rextext.py pack romsrc/rex/Cardfile.head.txt OUT.bin --tree romsrc
    python tools/rex/rextext.py check romsrc

`pack` writes a text piece's bytes (the `rex-header`,
`package-directory` and `pad` formats need `--tree`: they are laid out
as that tree's `rex.tsv` places the pieces - the ROM's addresses);
`check` builds every text piece of a tree and prints its address and
size. As a module: `load(path)` gives a piece with `size(address)` and
`render(layout, rel)`; `Layout` is where the pieces lie; the
`*_text(...)` writers give the text, or None when it would not give the
bytes back.

Tests: `test_rextext.py [--rom build/MP2x00US]` (ctests
`tools.RExText`, `tools.RExTextROM`: each committed text piece built
where rex.tsv puts it, the writers give the committed text back, with
the image the bytes are the ROM's own; edits read back - a pin table's
word and a row added, a package's name lengthened (the directory and
its InfoRefs follow), a patch table's target, a parameter block word,
the header following a piece that grew; and malformed files refused).
The whole-tree proofs are `romsrc.py`'s: `roundtrip` (a fresh
extraction, text pieces and all, builds the ROM byte for byte) and
`--git-ref romsrc-rom --original --check` (the tree before the text
forms, `.bin` pieces and all, still does).
