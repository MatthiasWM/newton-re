/*
	File:		host/HostWifi.cpp

	Contains:	The host's WiFi natives over its provider (HostWifi.h).
*/

#include "HostWifi.h"
#include "Frames.h"
#include "ObjectHeap.h"
#include "Interpreter.h"
#include "Unicode.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const HostWifiProvider*	gProvider = nil;


/*------------------------------------------------------------------------------
	NEWTON_FAKE_WIFI: a pretend WiFi on a host with none of its own (a
	desktop), so that Internet Setup's Wi-Fi slip can be worked and tested
	there (demo/wifisetup.ns, ctest host.NewtonWifiSetup): three networks in
	range, and the strongest remembered one joined at once.
------------------------------------------------------------------------------*/

static const struct { const char* ssid; long rssi; bool secure; } kFakeSeen[] = {
	{ "Newton Lab", -42, true }, { "Coffee Shop", -61, false }, { "Upstairs", -74, true } };
const long		kFakeSeenCount = sizeof(kFakeSeen) / sizeof(kFakeSeen[0]);
static char		gFakeKnown[8][kHostWifiSSIDSize];
static long		gFakeKnownCount = 0;

static long
FakeKnownIndex(const char* ssid)
{
	for (long i = 0; i < gFakeKnownCount; i++)
		if (strcmp(gFakeKnown[i], ssid) == 0)
			return i;
	return -1;
}

static long
FakeScan(HostWifiNetwork* networks, long max)
{
	long n = 0;
	for (long i = 0; i < kFakeSeenCount && n < max; i++, n++)
	{
		strncpy(networks[n].ssid, kFakeSeen[i].ssid, kHostWifiSSIDSize);
		networks[n].rssi = kFakeSeen[i].rssi;
		networks[n].secure = kFakeSeen[i].secure;
		networks[n].known = FakeKnownIndex(kFakeSeen[i].ssid) >= 0;
	}
	return n;
}

static long
FakeKnown(char (*ssids)[kHostWifiSSIDSize], long max)
{
	long n = 0;
	for (; n < gFakeKnownCount && n < max; n++)
		strncpy(ssids[n], gFakeKnown[n], kHostWifiSSIDSize);
	return n;
}

static bool
FakeRemember(const char* ssid, const char* /*password*/)
{
	if (FakeKnownIndex(ssid) >= 0)
		return true;
	if (gFakeKnownCount == 8)
		return false;
	strncpy(gFakeKnown[gFakeKnownCount++], ssid, kHostWifiSSIDSize);
	return true;
}

static bool
FakeForget(const char* ssid)
{
	long i = FakeKnownIndex(ssid);
	if (i < 0)
		return false;
	memmove(gFakeKnown[i], gFakeKnown[i + 1], (gFakeKnownCount - i - 1) * kHostWifiSSIDSize);
	gFakeKnownCount--;
	return true;
}

static void
FakeStatus(HostWifiStatusInfo* info)
{
	info->state = kHostWifiSearching;
	info->ssid[0] = 0;
	info->address = 0;
	info->rssi = 0;
	for (long i = 0; i < kFakeSeenCount; i++)
		if (FakeKnownIndex(kFakeSeen[i].ssid) >= 0)
		{
			info->state = kHostWifiConnected;
			strncpy(info->ssid, kFakeSeen[i].ssid, kHostWifiSSIDSize);
			info->address = (10UL << 24) | 42;
			info->rssi = kFakeSeen[i].rssi;
			return;
		}
}

static const HostWifiProvider	gFakeProvider = { FakeScan, FakeKnown, FakeRemember, FakeForget, FakeStatus };

void
HostWifiSetProvider(const HostWifiProvider* provider)
{
	gProvider = provider;
}


// a NewtonScript string as a C string of at most size - 1 bytes (Mac Roman)
static void
CStringOf(RefArg text, char* buffer, long size)
{
	buffer[0] = 0;
	if (ISNIL(text) || !IsString(text))
		return;
	ConvertFromUnicode(GetCString(text), buffer, kMacRomanEncoding, size - 1);
	buffer[size - 1] = 0;
}


static Ref
FHostWifiAvailable(RefArg /*rcvr*/)
{
	return gProvider != nil ? TRUEREF : NILREF;
}


static Ref
FHostWifiScan(RefArg /*rcvr*/)
{
	if (gProvider == nil)
		return NILREF;
	const long kMax = 24;
	HostWifiNetwork networks[kMax];
	long count = gProvider->scan(networks, kMax);
	if (count < 0)
		return NILREF;
	RefVar list(MakeArray(count));
	for (long i = 0; i < count; i++)
	{
		RefVar network(AllocateFrame());
		SetFrameSlot(network, RefVar(Intern((char*) "ssid")), RefVar(MakeString(networks[i].ssid)));
		SetFrameSlot(network, RefVar(Intern((char*) "rssi")), RefVar(MAKEINT(networks[i].rssi)));
		SetFrameSlot(network, RefVar(Intern((char*) "secure")), networks[i].secure ? RefVar(TRUEREF) : RefVar(NILREF));
		SetFrameSlot(network, RefVar(Intern((char*) "known")), networks[i].known ? RefVar(TRUEREF) : RefVar(NILREF));
		SetArraySlot(list, i, network);
	}
	return list;
}


static Ref
FHostWifiKnown(RefArg /*rcvr*/)
{
	if (gProvider == nil)
		return NILREF;
	const long kMax = 16;
	char ssids[kMax][kHostWifiSSIDSize];
	long count = gProvider->known(ssids, kMax);
	RefVar list(MakeArray(count > 0 ? count : 0));
	for (long i = 0; i < count; i++)
		SetArraySlot(list, i, RefVar(MakeString(ssids[i])));
	return list;
}


static Ref
FHostWifiRemember(RefArg /*rcvr*/, RefArg ssid, RefArg password)
{
	if (gProvider == nil)
		return NILREF;
	char name[kHostWifiSSIDSize], secret[kHostWifiPasswordSize];
	CStringOf(ssid, name, sizeof(name));
	CStringOf(password, secret, sizeof(secret));
	if (name[0] == 0)
		return NILREF;
	return gProvider->remember(name, secret) ? TRUEREF : NILREF;
}


static Ref
FHostWifiForget(RefArg /*rcvr*/, RefArg ssid)
{
	if (gProvider == nil)
		return NILREF;
	char name[kHostWifiSSIDSize];
	CStringOf(ssid, name, sizeof(name));
	return gProvider->forget(name) ? TRUEREF : NILREF;
}


static Ref
FHostWifiStatus(RefArg /*rcvr*/)
{
	if (gProvider == nil)
		return NILREF;
	HostWifiStatusInfo info;
	memset(&info, 0, sizeof(info));
	gProvider->status(&info);
	static const char* const kStates[] = { "off", "searching", "connecting", "connected" };
	RefVar status(AllocateFrame());
	SetFrameSlot(status, RefVar(Intern((char*) "state")), RefVar(Intern((char*) kStates[info.state])));
	SetFrameSlot(status, RefVar(Intern((char*) "ssid")), info.ssid[0] != 0 ? RefVar(MakeString(info.ssid)) : RefVar(NILREF));
	if (info.address != 0)
	{
		char address[16];
		snprintf(address, sizeof(address), "%lu.%lu.%lu.%lu", (info.address >> 24) & 0xFF, (info.address >> 16) & 0xFF,
				 (info.address >> 8) & 0xFF, info.address & 0xFF);
		SetFrameSlot(status, RefVar(Intern((char*) "address")), RefVar(MakeString(address)));
	}
	else
		SetFrameSlot(status, RefVar(Intern((char*) "address")), RefVar(NILREF));
	SetFrameSlot(status, RefVar(Intern((char*) "rssi")), RefVar(MAKEINT(info.rssi)));
	return status;
}


void
HostRegisterWifiFunctions(void)
{
	static const char* const fake = getenv("NEWTON_FAKE_WIFI");		// (read once)
	if (gProvider == nil && fake != nil && fake[0] != 0 && fake[0] != '0')
		gProvider = &gFakeProvider;
	RefVar functions(gFunctionFrame);
	SetFrameSlot(functions, RefVar(Intern((char*) "HostWifiAvailable")), RefVar(MakeCFunction((void*) FHostWifiAvailable, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostWifiScan")), RefVar(MakeCFunction((void*) FHostWifiScan, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostWifiKnown")), RefVar(MakeCFunction((void*) FHostWifiKnown, 0, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostWifiRemember")), RefVar(MakeCFunction((void*) FHostWifiRemember, 2, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostWifiForget")), RefVar(MakeCFunction((void*) FHostWifiForget, 1, nil)));
	SetFrameSlot(functions, RefVar(Intern((char*) "HostWifiStatus")), RefVar(MakeCFunction((void*) FHostWifiStatus, 0, nil)));
}
