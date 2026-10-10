/*
	File:		frames/ROMImport.h

	Contains:	The ROM object importer: the MessagePad's ROM holds the frames
				the OS is built on - 46538 objects in one area (gROMSoupData:
				the symbol table, the built-in functions, the protos and the
				magic pointer table that names them) - in the ARM's layout
				(32-bit big-endian words, 4-byte rounding).  On the MessagePad
				they are used in place; the host reads them out of a ROM image
				into a read-only object area of its own in the host layout
				(ObjHeader.h) through the object area importer
				(ObjectAreaImport.h), and fills in the constants the C++
				names (ROMConstants.h, RSSymbols.h).

	Not a reconstruction: the ROM has nothing to import.  A host stand-in
	for the ROM being mapped at address 0.  ImportROMObjects must run
	before InitObjects, which then uses the ROM's symbol table (and not
	InitROMSymbols' small symbol space).
*/

#ifndef __ROMIMPORT_H
#define __ROMIMPORT_H

#ifndef __NEWTON_H
#include "Newton.h"
#endif
#ifndef __OBJECTS_H
#include "objects.h"
#endif
#include <stddef.h>
#include <stdint.h>

// rom is the ROM as it appears at address 0 (build/MP2x00US/rom.bin) or the
// AIF image it was extracted from (DebugRom/...: the 128-byte header is
// skipped).  Answers kError_Bad_Parameters for a ROM without the object
// area where this build's ROMConstants.h says it is, kError_No_Memory when
// the area cannot be made.
NewtonErr	ImportROMObjects(const void* rom, ULong romSize);

// the same from a file - which may instead be the ROM-free track's object
// file (below), told by its signature
NewtonErr	ImportROMObjectsFromFile(const char* path);

// The objects from the ROM-free track's object file instead of a ROM
// image: the area and the magic pointers built from the ROM source tree
// (tools/newton-rom/analysis/romsrc.py build -o; docs/rom-free/README.md).
// There is no image behind them, so ROMImageBase answers nil.
NewtonErr	ImportBuiltObjects(const void* data, ULong size);
NewtonErr	ImportBuiltObjectsFromFile(const char* path);

// The builder's stamp an object file carries (version 4): which builder
// wrote it, so that a host built with another one can refuse it rather
// than boot objects laid out in a way it does not expect
// (host/HostObjectsFile.h's HostObjectsFileMatches).  nil, with *length 0,
// for an older file or one that is not an object file at all.
const char*	BuiltObjectsStamp(const void* data, ULong size, ULong* length);

Boolean		ROMObjectsImported(void);
// What the import keeps in host memory: the object file read whole (an
// object file's import; nought for a ROM image's) and the converted area
// with its index - what a small device would map from flash instead
// (docs/host-tdeck-pro.md) - and a baked image's bytes, mapped rather
// than held.
void		ROMObjectsMemory(ULong* fileBytes, ULong* areaBytes, ULong* mappedBytes);

// The baked object image (docs/host-tdeck-pro.md, "The baked object
// image"): what importing an object file makes - the host's objects, their
// index, the magic pointers, the lexicons and the other blocks - laid out
// in one region at the address it will be mapped at, and written out as
// it lies.  Mapped there again (read-only: nothing writes to a ROM object)
// it is the ROM's objects at once, with nothing read, converted or held in
// RAM; a device maps it from flash.  It is the host's own layout (pointer
// size, byte order, object header), so it is made by a build of the same
// kind as the one that maps it, and says which it is.
//
// The host gives the frames library its mapping (host/HostMapping.h) before
// either is used: a region reserved at an address, a file mapped at one.
typedef void* (*HostReserveAtProc)(uintptr_t base, size_t size);
typedef void* (*HostMapFileAtProc)(const char* path, uintptr_t base, size_t size);
void		SetHostMappers(HostReserveAtProc reserve, HostMapFileAtProc mapFile);
uintptr_t	DefaultBakedObjectsBase(void);		// where an image is made and mapped unless told otherwise
// An object file baked into an image at base (0: the default); the
// region reserved for the making is reserve bytes.  ==> noErr, or why not.
NewtonErr	BakeBuiltObjectsFile(const char* objectsPath, const char* imagePath, uintptr_t base, size_t reserve);
// A baked image's builder stamp (the object file's it was made from), as
// BuiltObjectsStamp answers an object file's; nil when data is not one.
const char*	BakedObjectsStamp(const void* data, ULong size, ULong* length);
long		ROMObjectCount(void);
void		ROMObjectAreaBounds(char** start, char** end);	// where the imported ROM objects lie (both nil: none) - Uriah's gUriahROM
Ref			TranslateROMRef(ULong32 ref);		// a ROM ref as a host ref (nil: a pointer that is not a ROM object's)

// The ROM's own bytes, with ROM address 0 at the start (an AIF image's
// header already stepped over); nil when nothing has been imported.  The
// device's ROM is simply there to be read - its extension's package list
// and the packages themselves are in it - so the host keeps the image the
// objects came from rather than letting it go.  An image handed to
// ImportROMObjects must outlive the import for this to answer it.
const void*	ROMImageBase(ULong* size);

// The ROM's bytes at a ROM address, `length` of them: out of the image, or
// out of the blocks of ROM data an object file carries (the lexicons); nil
// when neither has them.
const void*	ROMBytesAt(ULong address, ULong length);
// where a block of ROM data an object file moved now lies (a lexicon an
// edit of romsrc/ made bigger than its room: romsrc.py's
// place_grown_lexicons); any other address answered as it is
ULong		ROMMovedAddress(ULong address);

// The places the ROM's bytes are: the image (address 0 on), then each block
// an object file carries (the lexicons, the ROM extension).  ROMAddressOf
// says whether a pointer is into one of them, and at what ROM address -
// what a package in the ROM extension is imported at.
long		ROMRegionCount(void);
const void*	ROMRegion(long index, ULong* address, ULong* size);
Boolean		ROMAddressOf(const void* p, ULong* address, const void** regionStart);

#endif	/* __ROMIMPORT_H */
