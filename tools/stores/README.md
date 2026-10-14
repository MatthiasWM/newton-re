# tools/stores - stores as files

Two tools for the persistent store system (`src/stores/`,
[docs/stores/README.md](../../docs/stores/README.md)), Python 3.9+,
standard library only:

* `newtonstore.py` - a **package store** (a package's `'soup` part, which
  the package manager mounts as a read-only `TPackageStore`) as text a
  person can edit, and back, byte for byte.  The ROM extension's WorldData
  package - the countries and cities Setup's "where are you" page and Time
  Zones query - is one.
* `flashimage.py` - the host's internal flash images (`newton --store`):
  describe one, convert between the flat and the sparse format (its
  docstring has the formats and the commands).

## newtonstore.py

    python tools/stores/newtonstore.py unpack PART DIR [--package]
    python tools/stores/newtonstore.py pack DIR OUT
    python tools/stores/newtonstore.py check PART... [--package]
    python tools/stores/newtonstore.py chartables ROMSRC

`PART` is the part's bytes; with `--package` it is a package file and its
first `'soup` part is taken (`romsrc/rex/WorldData.pkg`).  `unpack`
writes `DIR` and then packs it again, failing unless that gives back the
part's bytes exactly.  `pack` makes the part out of a directory, edited
or not.  `check` says whether each part comes back the same.
`chartables` prints the character tables the tool has built in, made from
a romsrc tree (below).

As a module: `unpack(data, path)`, `pack(path) -> bytes`,
`soup_part(package) -> (offset, size)`, `replace_soup_part(package, part)
-> package` (the part put in place of the package's `'soup` part, the
sizes in the package's directory fixed).

### What a package store is

A directory - the root object's id, the number of objects, an offset per
object and one past the end - then the objects, which are a store's as the
MessagePad's soup code writes them: the root (`'WALY'`, version 4, the
ids of the map table, the symbol table and the store's persistent frame),
the two hash tables and their buckets, the persistent frames of the store
and of each soup (store objects: the tagged stream of
`TStoreObjectWriter`), each index's `IndexInfo` and its B-tree nodes, and
the entries with their text objects (`docs/stores/README.md` has every
format).  WorldData's 2128 objects are exactly what the ROM's code makes
when it formats a store, creates the nine soups and adds the 753 entries,
in that order: the ids are the order the objects were made in (the store
was written on a flash store and copied out with its objects renumbered
in id order), down to which symbol bucket an entry's new country made
before its text object, and which B-tree node a split made before the
entry after it.

So `pack` does what the MessagePad did.  It formats an empty store and
replays the history - soups created, entries added - through a Python
re-expression of the ROM's own code: the store object writer (the
stream, the precedents, the map table's sorted maps and their hash, the
symbol table, the strings' text gathered and compressed with the Unicode
coder, the word hints - `TWordHintsHandler`'s quadgram chunks), the soup
indexes (`TSoupIndex`'s key fields, binary search, node splits, key
fields with duplicates and the duplicate nodes, the node cache writing a
node back compact when an operation dirtied it, with the parent id the
last read left in it) and the order objects are made in.  Every byte of
the store is derived from the text; nothing but the history is stored.

### The directory

| File | What |
|---|---|
| `store.ns` | `store := {...};` the store's persistent frame, then `soup("Name", {...});` each soup's (`class: 'DiskSoup`, `indexes`, `signature`, ...), in the order the soups were created. `indexobject()` stands where a frame holds the id of an index's `IndexInfo` object (the store's `nameIndex`, each index description's `index`), which pack assigns. |
| `entries.ns` | the history: `soup("Name");` creates that soup (the first time) and makes it the one the entries after it are added to; each `{...};` is an entry, one to a line, `_uniqueID`, `_modTime` and `name` first and then the other slots by name. An entry's place decides its store object's id; its slots may be written in any order (the store keeps them sorted by symbol hash, and pack sorts them). |
| `overrides.txt` | only when the replay does not give an object's bytes back: `id label digest patch`, tab-separated - the object's id, what it is, the first 16 hex digits of the SHA-1 of the bytes pack derives for it, and the part's bytes where they differ (`offset:hex` runs; `=hex`, the whole object, when the sizes differ). Pack applies an override only while it still derives those very bytes for that object, so an edit that changes the object drops it, with a warning. |

The values are written as romsrc writes them
(`tools/newton-rom/analysis/romsrc.py`'s docstring): `12`, `nil`,
`true`, `$a`, `$é`, `@12`, `#1a3`, `'name`, `'|odd name|`,
`"text"` (class `'string`, the terminator implied), `string('cls,
"text")`, `bytes('cls, "0a1b")`, `stringbytes('cls, "0041")` (a string's
UniChars when they are not text and one terminator), `{tag: value}`,
`[value]` (class `'array`), `[cls: value]`, `array(cls, value)`; `//` and
`/* */` are comments.  A symbol met twice in an object is the same object,
as the store keeps it; any other object is written once.

An excerpt of WorldData's `entries.ns`:

    soup("Cities");
    {_uniqueID: 0, _modTime: 0, name: "Kabul", airport: "KBL", areacode: "", country: 'Afghanistan, gmt: 16200, latitude: 51400418, longitude: 102900258, notes: nil, region: ""};
    {_uniqueID: 1, _modTime: 0, name: "Tirana", airport: "TIA", areacode: "42", country: 'Albania, gmt: 3600, latitude: 61591024, longitude: 29552755, notes: nil, region: ""};
    ...
    soup("Countries");
    {_uniqueID: 0, _modTime: 0, name: "USA", continent: 'northAmerica, countryCode: 1, currency: "Dollar", daylight: 'northAmerica, ...};

and of its `store.ns`:

    store := {ephemerals: nil, name: "WorldData", nameIndex: indexobject(), signature: 16838};

    soup("Cities", {class: 'DiskSoup, flags: 3, indexes: [{index: indexobject(), path: '_uniqueID, structure: 'slot, type: 'int}, {index: indexobject(), path: 'name, structure: 'slot, type: 'string}, ...], indexesModTime: 0, infoModTime: 0, lastUID: nil, signature: 5758});

### What can be edited

Anything in the text: an entry's slots (renamed, added, taken out, a
value changed - its text object, hint chunks and every index it is in
follow), entries added, removed or moved (every id after them moves, and
the indexes' data with them), soups added (with their index descriptions,
`index: indexobject()` in each), the store's name.  An entry needs a
`_uniqueID` unique in its soup (the `_uniqueID` index takes no
duplicates: pack says which entry), and an indexed slot must hold its
index's type (pack names the entry and the index); `_modTime` is kept as
written.

The replay compares string keys as the ROM does for an index with no sort
table - each character folded to upper case without diacritics through
the Mac Roman class tables (`OldCompareText`) - and splits words for the
hints with the ASCII break table; the tool has those tables built in
(`MAC_ROMAN`, `FOLD`, `DELIMITERS`), made by `chartables` from romsrc's
Mac Roman map, `charClass`, `upperNoMarkList` and the break table (magic
pointer @6), and the test checks them against romsrc.

What unpack refuses (WorldData has none of them): an object other than
a symbol shared within one store object, large binaries, `'tags`
indexes, index descriptions with a sort table, index types other than
string, int, symbol, char, real and multi-slot ones of those, and a
store whose objects the replay cannot account for (an object count that
differs; objects that differ go to `overrides.txt`).

### WorldData's one override

The replay gives back every byte of WorldData but four: object 41, the
first node of the Cities soup's `country` index, holds parent id 0x84
where the replay gives 0.  A node's parent field is whatever `ReadANode`
last set it to before the node was last written, and means nothing - every
read sets it again; the replay gets the stale ones right for all the other
nodes (111 of WorldData's 424 child links have one).  This node the
MessagePad wrote once more after the index's root split, read through the
new root and unchanged but for that field, by something the history of
adds does not show (an entry changed, or a key deleted and added back).
`overrides.txt` keeps it as the patch `7:84`, applied while the node
derives to the same bytes; an edit that adds a city of a country from
Afghanistan to Austria changes the node, and the override goes.

### Tests

    python tools/stores/test_newtonstore.py [--rom build/MP2x00US] [--newton build/host/host/newton]

* the character tables are romsrc's;
* WorldData's part (romsrc's package, or with `--rom` the ROM
  extension's) unpacks and packs back to its 225,736 bytes, the one
  override touching only a node's parent id; a tree keeping the store
  unpacked (`romsrc/rex/WorldData/`) packs to those bytes and unpacks to
  its own text;
* edits read back: Kabul renamed, a city of Atlantis added to Australia's,
  Zaire taken out of the Countries - the entries, the `name` index and the
  `country` index hold the edits, and the store unpacks again to the
  edited text with no override; an entry's slots written in another order
  pack the same; a key of the wrong type is an error naming the entry;
* with `--newton`, the edited store is put in a package of its own (named
  `WorldDat2`, the store `WorldDataEdit`), the host boots with it
  (`newton --package ... --script ...`) and its queries - every soup's
  count, a `name` index query, a `words` query (the hint chunks) and a
  `country` index query - find the edits.

Temporary files go under the repository's `tmp/`.
