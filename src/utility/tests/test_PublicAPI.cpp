// The utility functions of the public jump table that nothing in the ROM
// calls.  TIdleTimer and TAEventHandler::ResetIdle with a port
// (utility/IdleTimer.h, AEventHandler.cpp): the remnants of an older idle
// timer, every one a bare return in the ROM - each is called, and nothing
// it was given is touched.  TAppWorldState::GetError (AppWorld.h): the
// last receive's result.

#include "IdleTimer.h"
#include "AEventHandler.h"
#include "UserPorts.h"
#include "AppWorld.h"

#include <new>
#include <stdio.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; printf("FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)

int
main()
{
	// (the class has no fields: the bytes it is made over are left as they were)
	alignas(8) unsigned char bytes[16];
	memset(bytes, 0x5a, sizeof(bytes));
	TIdleTimer* timer = new (bytes) TIdleTimer;
	timer->Init(5, kSeconds, 0x1234, 1);
	timer->Start();
	timer->Start((TUPort*) nil);
	timer->Reset();
	timer->Reset(2, kMilliseconds);
	timer->Reset(2, kMilliseconds, (TUPort*) nil);
	timer->Stop();
	for (size_t i = 0; i < sizeof(bytes); i++)
		EXPECT(bytes[i] == 0x5a);

	// a handler's ResetIdle with a port: no idle timer is made or started,
	// so the handler still has none to start
	TAEventHandler handler;
	handler.ResetIdle(3, kSeconds, (TUPort*) nil);
	EXPECT(handler.StartIdle() != noErr);

	// a world state's error: its first word, noErr when it is made
	TAppWorldState state;
	EXPECT(state.GetError() == noErr);
	state.fError = -10021;
	EXPECT(state.GetError() == -10021);

	if (failures == 0)
		printf("test_PublicAPI: all passed\n");
	else
		printf("test_PublicAPI: %d failures\n", failures);
	return failures != 0;
}
