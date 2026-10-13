/*
	File:		hal/host/HostMeshAir.cpp

	Contains:	A desktop's pretend LoRa radio for the mesh engine
				(HostMesh.h, newton --mesh-air): each packet a datagram to a
				UDP multicast group, so that every newton (and
				tools/mesh's peer) on the same group and port - on this
				host or the link - hears what the others send, as nodes in
				range of each other do.  A datagram is "MCA1", the sender's
				own random tag (a node hears its own sends come back on
				loopback, and drops them), and the packet's bytes.  Sends are
				as quick as the network: the airtime MeshCore is told is a
				real LoRa packet's at the preset's settings, which its
				timeouts are reckoned from.

				The node's blobs (identity, settings, contacts) are files
				beside the store, "<store>.mesh-<name>"; without a store
				they are kept nowhere and the node is a new one each run.
*/

#include "HostMesh.h"
#include "HostSockets.h"

#include <Dispatcher.h>

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <thread>

const uint32_t	kAirGroup = (239u << 24) | (255u << 16) | (78u << 8) | 121u;	// 239.255.78.121
const uint16_t	kAirPort = 3685;
static const char	kAirMagic[4] = { 'M', 'C', 'A', '1' };

class AirRadio : public mesh::Radio
{
public:
	int						fHandle = -1;
	uint16_t				fPort = kAirPort;
	uint8_t					fTag[4];
	HostMeshRadioSettings	fSettings = { 916.575f, 62.5f, 7, 8, 22 };
	uint32_t				fInterfaces[8];
	int						fInterfaceCount = 0;

	int recvRaw(uint8_t* bytes, int size) override
	{
		uint8_t datagram[8 + MAX_TRANS_UNIT];
		for (;;)
		{
			size_t got = 0;
			uint32_t from = 0;
			if (fHandle < 0 || HostUDPReceive(fHandle, datagram, sizeof(datagram), &got, &from) != kHostSocketOK || got == 0)
				return 0;
			if (got <= 8 || memcmp(datagram, kAirMagic, 4) != 0 || memcmp(datagram + 4, fTag, 4) == 0)
				continue;							// not the air's, or this node's own
			int n = (int) got - 8;
			if (n > size)
				continue;
			memcpy(bytes, datagram + 8, n);
			return n;
		}
	}

	// a LoRa packet's time on the air (Semtech's AN1200.13): an explicit
	// header, CRC on, a 16-symbol preamble as MeshCore's SX1262 set-up has
	uint32_t getEstAirtimeFor(int length) override
	{
		double sf = fSettings.spreadingFactor, bw = fSettings.bandwidth * 1000.0;
		double symbol = pow(2.0, sf) / bw;
		int lowRate = symbol > 0.016 ? 1 : 0;
		double payload = 8 + fmax(ceil((8.0 * length - 4 * sf + 28 + 16) / (4 * (sf - 2 * lowRate))) * (fSettings.codingRate), 0.0);
		double seconds = (16 + 4.25) * symbol + payload * symbol;
		return (uint32_t) (seconds * 1000.0 + 0.5);
	}

	float	packetScore(float, int) override { return 1.0f; }		// (no back-off: the air is perfect)

	bool startSendRaw(const uint8_t* bytes, int length) override
	{
		uint8_t datagram[8 + MAX_TRANS_UNIT];
		if (fHandle < 0 || length > MAX_TRANS_UNIT)
			return false;
		memcpy(datagram, kAirMagic, 4);
		memcpy(datagram + 4, fTag, 4);
		memcpy(datagram + 8, bytes, length);
		if (fInterfaceCount == 0)
			HostUDPMulticastSend(fHandle, kAirGroup, fPort, 0, datagram, 8 + length);
		for (int i = 0; i < fInterfaceCount; i++)
			HostUDPMulticastSend(fHandle, kAirGroup, fPort, fInterfaces[i], datagram, 8 + length);
		return true;
	}

	bool	isSendComplete() override { return true; }
	void	onSendFinished() override { }
	bool	isInRecvMode() const override { return true; }
	float	getLastRSSI() const override { return -60.0f; }
	float	getLastSNR() const override { return 10.0f; }
};

static AirRadio			gAir;
static HostMeshPlatform	gAirPlatform;
static char				gStatePrefix[1024];
static char				gAirName[kHostMeshNameSize];


static bool
AirStart(void*, const HostMeshRadioSettings* settings)
{
	gAir.fSettings = *settings;
	return gAir.fHandle >= 0;
}


static void
AirSleep(void*)
{
}


static bool
StatePath(const char* name, char* path, size_t size)
{
	if (gStatePrefix[0] == 0)
		return false;
	snprintf(path, size, "%s.mesh-%s", gStatePrefix, name);
	return true;
}


static bool
AirLoad(void*, const char* name, void* bytes, long* size)
{
	char path[1100];
	if (!StatePath(name, path, sizeof(path)))
		return false;
	FILE* f = fopen(path, "rb");
	if (f == NULL)
		return false;
	long got = (long) fread(bytes, 1, (size_t) *size, f);
	fclose(f);
	*size = got;
	return true;
}


static void
AirSave(void*, const char* name, const void* bytes, long size)
{
	char path[1100], temporary[1110];
	if (!StatePath(name, path, sizeof(path)))
		return;
	snprintf(temporary, sizeof(temporary), "%s.new", path);
	FILE* f = fopen(temporary, "wb");
	if (f == NULL)
		return;
	bool written = fwrite(bytes, 1, (size_t) size, f) == (size_t) size;
	written = fclose(f) == 0 && written;
	if (written)
	{
		remove(path);
		rename(temporary, path);
	}
}


bool
HostMeshAirStart(const char* spec, const char* statePrefix, const char* name)
{
	if (spec == NULL || strncmp(spec, "lan", 3) != 0)
		return false;
	if (spec[3] == ':')
		gAir.fPort = (uint16_t) atoi(spec + 4);
	else if (spec[3] != 0)
		return false;
	HostSocketsInit();
	if (HostInterfaceAddresses(gAir.fInterfaces, 8, &gAir.fInterfaceCount) != kHostSocketOK)
		gAir.fInterfaceCount = 0;
	if (gAir.fInterfaceCount > 8)
		gAir.fInterfaceCount = 8;
	int joined = 0;
	if (HostUDPMulticastOpen(kAirGroup, gAir.fPort, gAir.fInterfaces, gAir.fInterfaceCount, &gAir.fHandle, &joined) != kHostSocketOK)
	{
		fprintf(stderr, "[mesh] the air (239.255.78.121:%u) could not be opened\n", (unsigned) gAir.fPort);
		return false;
	}
	HostMeshRandom(gAir.fTag, sizeof(gAir.fTag));
	snprintf(gStatePrefix, sizeof(gStatePrefix), "%s", statePrefix != NULL ? statePrefix : "");
	snprintf(gAirName, sizeof(gAirName), "%s", name != NULL && name[0] != 0 ? name : "Newton");

	gAirPlatform.ref = NULL;
	gAirPlatform.radio = &gAir;
	gAirPlatform.radioStart = AirStart;
	gAirPlatform.radioSleep = AirSleep;
	gAirPlatform.load = AirLoad;
	gAirPlatform.save = AirSave;
	gAirPlatform.defaultName = gAirName;
	HostMeshWillRun();
	std::thread([] { HostMeshRun(&gAirPlatform); }).detach();
	fprintf(stderr, "[host] mesh air 239.255.78.121:%u\n", (unsigned) gAir.fPort);
	return true;
}
