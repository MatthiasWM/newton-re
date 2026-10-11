/*
	File:		host/esp32/main/newtonmain.cpp

	Contains:	The ESP32-S3 host's Newton side (src/host/esp32/README.md):
				the OS booted (milestone B, docs/host-tdeck-pro.md) - the
				ROM's objects from the baked image mapped from flash, the
				kernel and its tasks on FreeRTOS (the task runtime's
				ESP-IDF branch), the newt world, a 240x320 one-bit display
				shown on the e-paper panel (tdeck_panel.cpp), the touch
				panel as the pen and the keyboard as the keyboard
				(tdeck_input.cpp), the store in RAM - with a NewtonScript
				prompt on the USB console: each line the console types is
				evaluated in the newt world (a 'host/'eval event), its
				result printed.  The desktop's newton (host/newton.cpp) is
				what this follows, its window the board's panel.
*/

#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Compiler.h"
#include "REPTranslators.h"
#include "ROMImport.h"
#include "NativeFunctions.h"
#include "NewtonExceptions.h"
#include "Boot.h"
#include "UserBoot.h"
#include "NewtWorld.h"
#include "AEventHandler.h"
#include "NameServer.h"
#include "UserPorts.h"
#include "UserTasks.h"
#include "hal/FIQTimer.h"
#include "hal/host/Host.h"
#include "memory/host/KernelHeap.h"
#include "os600/kernel/host/TaskRuntime.h"
#include "host/HostViews.h"
#include "host/HostStores.h"
#include "host/HostKeyboard.h"
#include "hal/host/HostScreen.h"
#include "Unicode.h"
#include "hal/host/HostFlash.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "esp32host.h"

// the budget the device-sized run found enough (docs/host-tdeck-pro.md):
// the kernel heap in PSRAM with the NewtonScript heap inside it, a 4 MB
// internal flash (held in PSRAM: not kept between starts yet)
const Size		kKernelHeapSize = 3 * 1024 * 1024;
const long		kObjectHeapSize = 1024 * 1024;
const ULong		kFlashSize = 4 * 1024 * 1024;
const long		kDisplayWidth = 240;
const long		kDisplayHeight = 320;
const long		kDisplayDepth = 1;

static long long	gStart;


static void
Step(const char* what)
{
	unsigned long internalFree, psramFree;
	HostDeviceMemory(&internalFree, &psramFree);
	HostDeviceProfileMark(what);
	printf("newton: %s at %lld ms (internal RAM free %lu KB, PSRAM free %lu KB)\n",
		   what, (HostDeviceMicroseconds() - gStart) / 1000, internalFree >> 10, psramFree >> 10);
}


/*------------------------------------------------------------------------------
	NewtonScript for the board
------------------------------------------------------------------------------*/

// DeviceMilliseconds(): the board's clock, for timing NewtonScript on it;
// DeviceMemory(): [internal RAM free, PSRAM free], in KB
static Ref
FDeviceMilliseconds(RefArg /*rcvr*/)
{
	return MAKEINT((long) ((HostDeviceMicroseconds() / 1000) & 0x1fffffff));
}

// the internal flash's writes and erases, to the store partition
static void
StoreWrite(ULong offset, const unsigned char* bytes, ULong size)
{
	HostDeviceStoreWrite((unsigned long) offset, bytes, (unsigned long) size);
}

static void
StoreErase(ULong offset, ULong size, ULong lanes)
{
	HostDeviceStoreErase((unsigned long) offset, (unsigned long) size, (unsigned long) lanes);
}

// DeviceProfileDump(): the boot's profile printed (tdeck_profile.cpp,
// tools/tdeck/profile.py); the profiler stops
static Ref
FDeviceProfileDump(RefArg /*rcvr*/)
{
	HostDeviceProfileDump();
	return NILREF;
}

// DeviceStore(): [the flash words written to the store partition, its erases]
static Ref
FDeviceStore(RefArg /*rcvr*/)
{
	unsigned long writes, erases;
	HostDeviceStoreCounts(&writes, &erases);
	RefVar list(MakeArray(2));
	SetArraySlot(list, 0, RefVar(MAKEINT((long) writes)));
	SetArraySlot(list, 1, RefVar(MAKEINT((long) erases)));
	return list;
}


// DevicePanelSet(name, value): a setting of the panel's refreshes
// (tdeck_panel.cpp) - name a symbol or a string ==> true when there is one
static Ref
FDevicePanelSet(RefArg /*rcvr*/, RefArg name, RefArg value)
{
	char text[32];
	if (IsSymbol(name))
		strncpy(text, SymbolName(name), sizeof(text) - 1);
	else
		ConvertFromUnicode(GetCString(name), text, kMacRomanEncoding, sizeof(text) - 1);
	text[sizeof(text) - 1] = 0;
	return HostDevicePanelSet(text, RINT(value)) ? TRUEREF : NILREF;
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


/*------------------------------------------------------------------------------
	The console's lines, evaluated in the newt world: a 'host/'eval event
	sent to the world's port (as the desktop's test of the world does,
	newt/tests/test_Newt.cpp), its handler installed by the world's boot
------------------------------------------------------------------------------*/

struct TDeviceEvalEvent : public TAEvent
{
	const char*	fSource;
};

class TDeviceEvalHandler : public TAEventHandler
{
public:
	virtual void	AEHandlerProc(TUMsgToken* token, ULong* size, TAEvent* event)
	{
		TDeviceEvalEvent* eval = (TDeviceEvalEvent*) event;
		long long t = HostDeviceMicroseconds();
		newton_try
		{
			RefVar fn(ParseString(RefVar(MakeString(eval->fSource))));
			if ((Ref) fn != NILREF)
			{
				RefVar result(InterpretBlock(fn, RefVar(gVarFrame)));
				PrintObject(result, 0);
			}
		}
		newton_catch_all
		{
			gREPout->ExceptionNotify(&_info.exception);
		}
		end_try;
		printf("\n(%lld ms)\n> ", (HostDeviceMicroseconds() - t) / 1000);
		SetReply(*size, event);
		if (token != nil && token->GetReplyId() != 0)
			ReplyImmed();
	}
};

static TDeviceEvalHandler*	gEvalHandler = nil;


// the world's boot (gNewtHostBoot): the desktop's, headless - the object
// system, the display, the toolbox (host/HostViews.cpp), the timers - and
// the eval handler in the world's task
static void
DeviceBoot(void)
{
	Step("the newt world starting");
	HostBootNewtWorld();
	THostScreenDriver* display = HostDisplay();
	if (display != nil)
		HostDevicePanelShow(display->Pixels(), display->Width(), display->Height());
	InitFIQTimer();
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DeviceMilliseconds")), RefVar(MakeCFunction((void*) FDeviceMilliseconds, 0, nil)));
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DeviceMemory")), RefVar(MakeCFunction((void*) FDeviceMemory, 0, nil)));
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DevicePanelSet")), RefVar(MakeCFunction((void*) FDevicePanelSet, 2, nil)));
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DeviceStore")), RefVar(MakeCFunction((void*) FDeviceStore, 0, nil)));
	SetFrameSlot(RefVar(gFunctionFrame), RefVar(Intern((char*) "DeviceProfileDump")), RefVar(MakeCFunction((void*) FDeviceProfileDump, 0, nil)));
	// results printed on the console (the world's REP out translator
	// otherwise prints nowhere)
	HostInitREP(stdout, nil);
	gEvalHandler = new TDeviceEvalHandler;
	gEvalHandler->Init('eval', 'host');
	Step("the newt world booted");
}


// the kernel services task (gHostKernelServicesTask): the keyboard's keys
// (host/HostKeyboard.cpp's queue, which tdeck_input.cpp fills) and the
// console's lines to the world, a hundredth of a second at a time
static void
DeviceServices(void)
{
	TUNameServer nameServer;
	TObjectId portId = 0;
	ULong spec = 0;
	while (nameServer.Lookup("newt", "TUPort", &portId, &spec) != noErr)
		Sleep(50 * kMilliseconds);
	while (!gNewtIsAliveAndWell)
		Sleep(50 * kMilliseconds);
	Step("the OS is up");
	printf("> ");
	TUPort newtPort(portId);
	static char line[512];
	for (;;)
	{
		HostKeyboardSendKeys(&newtPort);
		if (HostDeviceReadLine(line, sizeof(line)))
		{
			TDeviceEvalEvent eval;
			eval.fAEventClass = 'host';
			eval.fAEventID = 'eval';
			eval.fSource = line;
			ULong replySize = 0;
			newtPort.SendRPC(&replySize, &eval, sizeof(eval), &eval, sizeof(eval));
		}
		else
			Sleep(10 * kMilliseconds);
	}
}


void
NewtonMainOnDevice(const void* image, size_t size)
{
	gStart = HostDeviceMicroseconds();
	// every NewtonScript throw printed with its script stack (frames/Objects.cpp
	// reads it at the first throw): the board has no environment to set it in,
	// and the console is where a fault on it is found
	setenv("NEWTON_TRACE_EXCEPTIONS", "1", 1);
	if (image == nil || ImportBakedObjects(image, size) != noErr)
		printf("newton: no baked ROM objects - the OS cannot boot without them\n");
	else
		Step("the ROM's objects (the baked image)");

	HostSetKernelHeapSize(kKernelHeapSize);
	HostUseRealClock(true);
	// the internal flash on the board's store partition (tdeck_store.cpp),
	// the internal store the ROM's flash store on it, kept between starts;
	// without the partition, a store in memory
	static HostFlashBacking backing;
	unsigned char* flashBytes;
	unsigned long flashSize;
	bool existed;
	if (HostDeviceStoreOpen(&flashBytes, &flashSize, &existed))
	{
		backing.bytes = flashBytes;
		backing.size = (ULong) flashSize;
		backing.existed = existed;
		backing.write = StoreWrite;
		backing.erase = StoreErase;
		HostFlashSetBacking(&backing);
		HostSetStoreFile("store partition");		// (any name: the backing is the flash - hal/host/HostFlash.h)
		HostSetNewFlash(backing.size, true);
		Step(existed ? "the store partition (used before)" : "the store partition (new)");
	}
	else
	{
		HostSetStoreFile(nil);
		HostSetNewFlash(kFlashSize, false);
	}
	HostConfigureNewtWorld(nil, kObjectHeapSize, kDisplayWidth, kDisplayHeight, kDisplayDepth);
	gNewtHostBoot = DeviceBoot;
	NewtInstallUserMain();
	gHostKernelServicesTask = DeviceServices;
	Step("the OS booting");
	OsBoot();
}
