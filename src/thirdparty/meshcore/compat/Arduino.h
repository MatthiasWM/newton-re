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

// Arduino's ltoa (TxtDataHelpers.cpp), which Windows' C library has and
// newlib's and glibc's have not
#if !defined(_WIN32)
inline char*
ltoa(long value, char* s, int radix)
{
	char digits[sizeof(long) * 8 + 1];
	unsigned long v = value < 0 && radix == 10 ? 0UL - (unsigned long) value : (unsigned long) value;
	int n = 0;
	do
	{
		int d = (int) (v % (unsigned long) radix);
		digits[n++] = (char) (d < 10 ? '0' + d : 'a' + d - 10);
		v /= (unsigned long) radix;
	} while (v != 0);
	char* p = s;
	if (value < 0 && radix == 10)
		*p++ = '-';
	while (n > 0)
		*p++ = digits[--n];
	*p = 0;
	return s;
}
#endif

// MeshCore's RadioLib wrappers (helpers/radiolib: the T-Deck Pro's radio,
// built with MESHCORE_RADIOLIB and this header forced in - src/host/esp32/
// main/CMakeLists.txt) also want SPIClass by name (CustomSX1262::std_init's
// argument, always NULL here: the board's RadioLib HAL owns the bus),
// Serial's print, millis() (the board's, tdeck_lora.cpp) and Arduino's min
// and max
#ifdef MESHCORE_RADIOLIB
class SPIClass;

struct MeshCoreSerial
{
	void	print(const char* s) { printf("%s", s); }
	void	println(long v) { printf("%ld\n", v); }
};
static MeshCoreSerial Serial;

unsigned long	millis(void);

// Arduino's random(low, high), from the host's random bytes (HostMesh.h)
extern "C" void	HostMeshRandom(void* bytes, size_t size);
inline long
random(long low, long high)
{
	uint32_t v;
	HostMeshRandom(&v, sizeof(v));
	return high > low ? low + (long) (v % (uint32_t) (high - low)) : low;
}

template <class A, class B> inline auto min(A a, B b) -> decltype(a + b) { return a < b ? a : b; }
template <class A, class B> inline auto max(A a, B b) -> decltype(a + b) { return a > b ? a : b; }
#endif

#endif
