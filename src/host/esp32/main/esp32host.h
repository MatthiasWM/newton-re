/*
	File:		host/esp32/main/esp32host.h

	Contains:	What the ESP32-S3 host's two halves tell each other - the
				board's (esp32main.cpp, ESP-IDF's headers) and the Newton's
				(newtonmain.cpp, the DDK's) - in plain C types, since the
				two sets of headers do not mix.
*/

#ifndef __ESP32HOST_H
#define __ESP32HOST_H

#include <stddef.h>

// the Newton's side: the baked ROM objects at image (nil: none), then the
// OS booted, with a NewtonScript prompt on the console
void		NewtonMainOnDevice(const void* image, size_t size);

// the board's side
long long	HostDeviceMicroseconds(void);
void		HostDeviceMemory(unsigned long* internalFree, unsigned long* psramFree);
int			HostDeviceReadLine(char* line, size_t size);		// a line the console has typed, if one has come (never waits) ==> whether

// (the task runtime's threads - os600/kernel/host/TaskRuntime.cpp declares
//  them for itself, extern "C")
extern "C" {
	int		HostDeviceStartThread(void (*entry)(void*), void* arg, size_t stackBytes);
	[[noreturn]] void	HostDeviceEndThread(void);
}

#endif	/* __ESP32HOST_H */
