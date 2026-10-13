/*
	File:		host/HostUTF8.cpp

	Contains:	NewtonScript strings to and from UTF-8 (HostUTF8.h).
*/

#include "HostUTF8.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Unicode.h"
#include <string.h>


// A NewtonScript string as UTF-8 (nil, or not a string: "")
void
HostUTF8Of(RefArg text, char* out, long size)
{
	out[0] = 0;
	if (ISNIL(text) || !IsString(text))
		return;
	const UniChar* s = GetCString(text);
	long o = 0;
	for (; *s != 0; s++)
	{
		unsigned long cp = *s;
		if (cp >= 0xD800 && cp <= 0xDBFF && s[1] >= 0xDC00 && s[1] <= 0xDFFF)
		{
			cp = 0x10000 + ((cp - 0xD800) << 10) + (s[1] - 0xDC00);
			s++;
		}
		long n = cp < 0x80 ? 1 : cp < 0x800 ? 2 : cp < 0x10000 ? 3 : 4;
		if (o + n >= size)
			break;
		if (n == 1)
			out[o++] = (char) cp;
		else if (n == 2)
		{
			out[o++] = (char) (0xC0 | (cp >> 6));
			out[o++] = (char) (0x80 | (cp & 0x3F));
		}
		else if (n == 3)
		{
			out[o++] = (char) (0xE0 | (cp >> 12));
			out[o++] = (char) (0x80 | ((cp >> 6) & 0x3F));
			out[o++] = (char) (0x80 | (cp & 0x3F));
		}
		else
		{
			out[o++] = (char) (0xF0 | (cp >> 18));
			out[o++] = (char) (0x80 | ((cp >> 12) & 0x3F));
			out[o++] = (char) (0x80 | ((cp >> 6) & 0x3F));
			out[o++] = (char) (0x80 | (cp & 0x3F));
		}
	}
	out[o] = 0;
}


// UTF-8 as a NewtonScript string (a malformed byte taken as itself)
Ref
HostStringOfUTF8(const char* utf8)
{
	long size = (long) strlen(utf8) + 1;
	UniChar* units = new UniChar[size * 2];
	const unsigned char* p = (const unsigned char*) utf8;
	long o = 0;
	while (*p)
	{
		unsigned long cp = *p;
		int n = 1;
		if ((*p & 0xE0) == 0xC0)
			cp = *p & 0x1F, n = 2;
		else if ((*p & 0xF0) == 0xE0)
			cp = *p & 0x0F, n = 3;
		else if ((*p & 0xF8) == 0xF0)
			cp = *p & 0x07, n = 4;
		bool good = true;
		for (int k = 1; k < n; k++)
			if ((p[k] & 0xC0) != 0x80)
				good = false;
			else
				cp = (cp << 6) | (p[k] & 0x3F);
		if (!good)
			cp = *p, n = 1;
		p += n;
		if (cp >= 0x10000)
		{
			cp -= 0x10000;
			units[o++] = (UniChar) (0xD800 + (cp >> 10));
			units[o++] = (UniChar) (0xDC00 + (cp & 0x3FF));
		}
		else
			units[o++] = (UniChar) cp;
	}
	RefVar string(MakeString(units, o));
	delete[] units;
	return string;
}
