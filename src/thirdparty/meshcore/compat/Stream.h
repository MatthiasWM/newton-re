/*
	File:		thirdparty/meshcore/compat/Stream.h

	Contains:	The little of Arduino's Stream that MeshCore's Identity and
				Utils use (readFrom/writeTo/printTo(Stream&), printHex):
				bytes in and out, and a character or a string printed.  The
				reconstruction keeps identities through their buffer forms
				(LocalIdentity::writeTo(uint8_t*, size_t)), so nothing here
				is more than the interface: a subclass says where the bytes
				go.
*/

#ifndef __MESHCORE_COMPAT_STREAM_H
#define __MESHCORE_COMPAT_STREAM_H

#include <stdint.h>
#include <stddef.h>
#include <string.h>

class Stream
{
public:
	virtual			~Stream() { }
	virtual size_t	readBytes(uint8_t* buffer, size_t length) { return 0; }
	virtual size_t	write(const uint8_t* buffer, size_t length) { return 0; }
	size_t			write(uint8_t c) { return write(&c, 1); }
	size_t			print(char c) { return write((const uint8_t*) &c, 1); }
	size_t			print(const char* s) { return write((const uint8_t*) s, strlen(s)); }
	size_t			println(void) { return print('\n'); }
};

#endif
