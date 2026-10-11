/*
	File:		host/esp32/main/esp32runtime.cpp

	Contains:	The task runtime's entry points, as the ESP32-S3 host has
				them for milestone A (docs/host-tdeck-pro.md, "The ESP-IDF
				skeleton"): NewtonScript runs on one FreeRTOS task and the
				OS's tasks are not started, so a system call's exit path
				never switches and nothing is ever preempted.  The desktop's
				runtime (os600/kernel/host/TaskRuntime.cpp: a thread per
				task, a baton) is what milestone B re-expresses over
				FreeRTOS tasks and semaphores.  A stand-in, not the ROM's.
*/

#include "os600/kernel/host/TaskRuntime.h"

Boolean		gHostTasksStopping = false;


// after a system call's glue: no other task to switch to
Boolean
HostSWIExit(TTask* /*self*/, TRegister /*marker*/)
{
	return false;
}


Boolean
HostIsAlienThread()
{
	return false;
}


void
HostPreemptionPoint()
{
}
