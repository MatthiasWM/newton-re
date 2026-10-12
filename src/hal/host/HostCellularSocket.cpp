/*
	File:		hal/host/HostCellularSocket.cpp

	Contains:	A desktop's cellular module: a TCP connection taken on a
				listening port (newton --cell-port), the module at the
				other end being tools/modem/fakecell.py.  The engine
				(HostCellular.cpp) runs on a thread of its own over it; a
				connection that closes is waited for again, as a module
				powered off and on.
*/

#include "HostCellular.h"
#include "hal/host/HostSockets.h"
#include <chrono>
#include <thread>

struct SocketLink
{
	int		listener;
	int		connection;				// -1 none yet
};

static SocketLink		gSocket = { -1, -1 };
static HostCellularLink	gSocketLink;


static long
SocketRead(void* ref, unsigned char* bytes, long size, long timeoutMs)
{
	SocketLink* link = (SocketLink*) ref;
	auto until = std::chrono::steady_clock::now() + std::chrono::milliseconds(timeoutMs);
	for (;;)
	{
		if (link->connection < 0)
		{
			uint32_t address;
			uint16_t port;
			int handle;
			if (HostTCPAccept(link->listener, &handle, &address, &port) == kHostSocketOK)
				link->connection = handle;
		}
		if (link->connection >= 0)
		{
			size_t count = 0;
			int result = HostSocketReceive(link->connection, bytes, (size_t) size, &count);
			if (result == kHostSocketOK && count > 0)
				return (long) count;
			if (result == kHostSocketClosed || result < 0)
			{
				HostSocketClose(link->connection);
				link->connection = -1;
			}
		}
		if (std::chrono::steady_clock::now() >= until)
			return 0;
		std::this_thread::sleep_for(std::chrono::milliseconds(5));
	}
}


static void
SocketWrite(void* ref, const void* bytes, long size)
{
	SocketLink* link = (SocketLink*) ref;
	const char* p = (const char*) bytes;
	while (size > 0 && link->connection >= 0)
	{
		size_t count = 0;
		int result = HostSocketSend(link->connection, p, (size_t) size, &count);
		if (result < 0)
			return;
		p += count;
		size -= (long) count;
		if (count == 0)
			std::this_thread::sleep_for(std::chrono::milliseconds(1));
	}
}


bool
HostCellularListen(unsigned short port, unsigned short* listening)
{
	HostSocketsInit();
	uint16_t at = port;
	if (HostTCPListen(0x7F000001, &at, &gSocket.listener) != kHostSocketOK)
		return false;
	*listening = at;
	gSocketLink.ref = &gSocket;
	gSocketLink.read = SocketRead;
	gSocketLink.write = SocketWrite;
	std::thread([] { HostCellularRun(&gSocketLink); }).detach();
	return true;
}
