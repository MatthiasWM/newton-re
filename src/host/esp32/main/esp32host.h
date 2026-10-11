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

// the panel (tdeck_panel.cpp): its task started (before the OS boots), then
// given the display's grays to show (one byte a pixel, 0 white .. 255
// black, width per row - host/HostWindow.h's form) once there is a display
void		HostDevicePanelStart(void);
void		HostDevicePanelShow(const unsigned char* grays, long width, long height);
bool		HostDevicePanelSet(const char* name, long value);	// a refresh setting changed (tdeck_panel.cpp lists them) ==> whether there is one so named
// the touch panel and the keyboard (tdeck_input.cpp): read from the start,
// handed to the window shims below
void		HostDeviceInputStart(void);
// the internal flash on the board's `store` partition (tdeck_store.cpp):
// started before the OS boots (==> whether there is one), then opened by
// the Newton's side - its image, read in place, its size, whether it was
// used before - and written and erased through these (from a Newton task)
bool		HostDeviceStoreStart(void);
bool		HostDeviceStoreOpen(unsigned char** bytes, unsigned long* size, bool* existed);
void		HostDeviceStoreWrite(unsigned long offset, const unsigned char* bytes, unsigned long size);
void		HostDeviceStoreErase(unsigned long offset, unsigned long size, unsigned long lanes);
void		HostDeviceStoreCounts(unsigned long* writes, unsigned long* erases);

// (the task runtime's threads - os600/kernel/host/TaskRuntime.cpp declares
//  them for itself, extern "C")
extern "C" {
	int		HostDeviceStartThread(void (*entry)(void*), void* arg, size_t stackBytes);
	[[noreturn]] void	HostDeviceEndThread(void);
	// the window's shims (host/HostKeyboard.cpp), as every host's window
	// calls them: the pen in the display's pixels, a key as its Windows
	// virtual key code - from any thread
	void	HostWindowPenDown(long x, long y);
	void	HostWindowPenMove(long x, long y);
	void	HostWindowPenUp(void);
	void	HostWindowKey(long virtualKey, int down);
}

#endif	/* __ESP32HOST_H */
