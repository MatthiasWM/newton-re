# Newton Devices (newtdev.pkg), as source

Apple's Newton Devices (the network card driver and its name server interface) - one of the three packages of the Newton
Internet Enabler 2.0 that `romsrc/` adds to the ROM extension
(`romsrc/README.md`, "The Newton Internet Enabler, built in") - as text:
`package.txt` (the directory: `tools/armpart/newtonpkg.py`), each frames
part a NewtonScript source tree (`partN/`, as the ROM's own packages'
parts are), each protocol part ARM source (`partN.s`, `tools/armpart/`).
The builder builds the package file from it and puts that into the form
the ROM keeps its packages in (`rex.tsv`: `rom-form`).

It was made from Apple's package (`fixtures/packages/apple/NIE2/ENETSUP/newtdev.pkg`,
the same bytes) with

    python tools/newton-rom/analysis/romsrc.py package unpack fixtures/packages/apple/NIE2/ENETSUP/newtdev.pkg romsrc/rex/newtdev --rom build/MP2x00US --newtonscript build/host/host/newtonscript

and `romsrc.py package pack romsrc/rex/newtdev X.pkg --newtonscript ...`
builds the package file alone.

It is Apple's as it is: unchanged.  Its two native modules (NTK native
code: `part1/` and `part6/`'s `resources/nativeModule/*.s`) are ARM source
whose `.rword` lines are the words the package's relocation chunk names;
the builder makes the chunk from them.
