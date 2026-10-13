/*
	File:		host/HostUTF8.h

	Contains:	NewtonScript strings (UTF-16) to and from the UTF-8 the
				hosts' engines speak (the cellular modem's,
				HostCellularNatives.cpp; the LoRa mesh's,
				HostMeshNatives.cpp).
*/

#ifndef __HOSTUTF8_H
#define __HOSTUTF8_H

#include "Frames.h"

// A NewtonScript string as UTF-8, cut at a character to fit size with its
// terminator (nil, or not a string: "")
void	HostUTF8Of(RefArg text, char* out, long size);

// UTF-8 as a NewtonScript string (a malformed byte taken as itself)
Ref		HostStringOfUTF8(const char* utf8);

#endif
