/*
	File:		thirdparty/meshcore/compat/Arduino.h

	Contains:	What MeshCore's sources want of <Arduino.h> when they are
				built without Arduino - on a desktop, and on the T-Deck Pro
				under plain ESP-IDF (thirdparty/meshcore/README.md).  The
				parts compiled here include it only for the C library's
				types and string functions (BaseChatMesh.h, ContactInfo.h,
				ChannelDetails.h, AdvertDataHelpers.cpp, TxtDataHelpers.cpp,
				BaseSerialInterface.h); Stream is <Stream.h>, beside this.
*/

#ifndef __MESHCORE_COMPAT_ARDUINO_H
#define __MESHCORE_COMPAT_ARDUINO_H

#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "Stream.h"

#endif
