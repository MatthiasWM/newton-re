/*
	File:		host/esp32/main/newtonmain.cpp

	Contains:	The ESP32-S3 host's Newton side (src/host/esp32/README.md):
				the ROM's objects from the baked image mapped from flash,
				the object system, the natives, and the NewtonScript REP on
				the USB console - what the desktop's newtonscript does
				(host/newtonscript.cpp), with each step timed.  Milestone A
				of the port (docs/host-tdeck-pro.md): NewtonScript on the
				board; the OS's tasks are not started yet.
*/

#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "REPTranslators.h"
#include "ROMImport.h"
#include "NativeFunctions.h"
#include "memory/host/KernelHeap.h"
#include "host/HostNatives.h"
#include <stdio.h>
#include <string.h>

#include "esp32host.h"

// the budget the device-sized run found enough (docs/host-tdeck-pro.md):
// the kernel heap in PSRAM, the NewtonScript heap inside it
const Size kKernelHeapSize = 3 * 1024 * 1024;
const long kObjectHeapSize = 1024 * 1024;


// DeviceMilliseconds(): the board's clock, for timing NewtonScript on it
// (the OS's Ticks does not run: its tasks are not started in milestone A);
// DeviceMemory(): [internal RAM free, PSRAM free], in KB
static Ref
FDeviceMilliseconds(RefArg /*rcvr*/)
{
	return MAKEINT((long) ((HostDeviceMicroseconds() / 1000) & 0x1fffffff));
}

static Ref
FDeviceMemory(RefArg /*rcvr*/)
{
	unsigned long internalFree, psramFree;
	HostDeviceMemory(&internalFree, &psramFree);
	RefVar list(MakeArray(2));
	SetArraySlot(list, 0, RefVar(MAKEINT((long) (internalFree >> 10))));
	SetArraySlot(list, 1, RefVar(MAKEINT((long) (psramFree >> 10))));
	return list;
}


static void
Step(const char* what, long long since)
{
	unsigned long internalFree, psramFree;
	HostDeviceMemory(&internalFree, &psramFree);
	printf("newton: %s: %lld ms (internal RAM free %lu KB, PSRAM free %lu KB)\n",
		   what, (HostDeviceMicroseconds() - since) / 1000, internalFree >> 10, psramFree >> 10);
}


void
NewtonMainOnDevice(const void* image, size_t size)
{
	long long t = HostDeviceMicroseconds();
	InitHostStandaloneHeap(kKernelHeapSize);
	Step("the kernel heap", t);

	t = HostDeviceMicroseconds();
	if (image == nil || ImportBakedObjects(image, size) != noErr)
		printf("newton: no baked ROM objects - running without them\n");
	else
		Step("the ROM's objects (the baked image)", t);

	t = HostDeviceMicroseconds();
	gObjectHeapSize = kObjectHeapSize;
	InitObjects();
	Step("the object system", t);

	t = HostDeviceMicroseconds();
	RegisterAllNatives();
	Step("the natives", t);

	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DeviceMilliseconds")), RefVar(MakeCFunction((void*) FDeviceMilliseconds, 0, nil)));
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DeviceMemory")), RefVar(MakeCFunction((void*) FDeviceMemory, 0, nil)));
	HostInitREP(stdout, stdin);
	while (gREPin->FrameAvailable())
		REPAcceptLine();
}
