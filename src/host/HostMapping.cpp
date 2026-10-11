/*
	File:		host/HostMapping.cpp

	Contains:	Memory at a chosen address - HostMapping.h.
*/

#include "HostMapping.h"

#ifdef _WIN32

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>

void*
HostReserveAt(uintptr_t base, size_t size)
{
	void* p = VirtualAlloc((void*) base, size, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
	return p == (void*) base ? p : 0;
}


void*
HostMapFileAt(const char* path, uintptr_t base, size_t size)
{
	HANDLE file = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
	if (file == INVALID_HANDLE_VALUE)
		return 0;
	HANDLE mapping = CreateFileMappingA(file, 0, PAGE_READONLY, 0, 0, 0);
	CloseHandle(file);
	if (mapping == 0)
		return 0;
	void* p = MapViewOfFileEx(mapping, FILE_MAP_READ, 0, 0, size, (void*) base);
	CloseHandle(mapping);			// (the view keeps the mapping)
	return p == (void*) base ? p : 0;
}

#else

#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

// (MAP_FIXED_NOREPLACE is Linux 4.17's: elsewhere the address is a hint,
//  and a mapping put anywhere else is given back)
#ifndef MAP_FIXED_NOREPLACE
#define MAP_FIXED_NOREPLACE 0
#endif

static void*
Placed(void* p, uintptr_t base, size_t size)
{
	if (p == MAP_FAILED)
		return 0;
	if (p != (void*) base)
	{
		munmap(p, size);
		return 0;
	}
	return p;
}


void*
HostReserveAt(uintptr_t base, size_t size)
{
	void* p = mmap((void*) base, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
	return Placed(p, base, size);
}


void*
HostMapFileAt(const char* path, uintptr_t base, size_t size)
{
	int fd = open(path, O_RDONLY);
	if (fd < 0)
		return 0;
	void* p = mmap((void*) base, size, PROT_READ, MAP_PRIVATE | MAP_FIXED_NOREPLACE, fd, 0);
	close(fd);						// (the mapping keeps the file)
	return Placed(p, base, size);
}

#endif
