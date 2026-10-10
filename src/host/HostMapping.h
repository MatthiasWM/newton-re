/*
	File:		host/HostMapping.h

	Contains:	Memory at an address of the caller's choosing - what a baked
				object image needs (frames/ROMImport.h, docs/host-tdeck-pro.md
				"The baked object image"): its objects point at each other by
				address, so it is made where it will be mapped and mapped
				where it was made.  A device maps it from flash at a known
				address; a desktop host maps the file there, read-only.

				One implementation per host, built into the host window's
				library (no Newton headers: the Windows headers and they do
				not mix): Windows (VirtualAlloc, MapViewOfFileEx) and POSIX
				(mmap with MAP_FIXED_NOREPLACE, or a hint checked).
*/

#ifndef __HOSTMAPPING_H
#define __HOSTMAPPING_H

#include <stddef.h>
#include <stdint.h>

// Writable memory of size bytes at exactly base (rounded to the system's
// granularity by the caller) ==> base, or 0 when it cannot be had there.
void*	HostReserveAt(uintptr_t base, size_t size);

// The first size bytes of the file mapped read-only at exactly base
// ==> base, or 0 when the file cannot be opened or mapped there.
void*	HostMapFileAt(const char* path, uintptr_t base, size_t size);

#endif	/* __HOSTMAPPING_H */
