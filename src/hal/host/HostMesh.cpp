/*
	File:		hal/host/HostMesh.cpp

	Contains:	The host's LoRa mesh node (HostMesh.h): MeshCore's
				BaseChatMesh on the radio the host gives, run on one thread
				of the host's own.

	Written by:	The reconstruction, from lilyphone1's
				src/apps/mesh_net.cpp (the owner's own code)
*/

#include "HostMesh.h"

#include <MeshCore.h>
#include <Mesh.h>
#include <helpers/BaseChatMesh.h>
#include <helpers/StaticPoolPacketManager.h>
#include <helpers/SimpleMeshTables.h>
#include <helpers/AdvertDataHelpers.h>

#include <atomic>
#include <chrono>
#include <condition_variable>
#include <mutex>
#include <random>
#include <thread>
#include <stdio.h>
#include <string.h>
#include <time.h>

#ifndef HOST_LARGE_STATIC
#define HOST_LARGE_STATIC
#endif


// ----------------------------------------------------------------------
// The presets (lilyphone1's): the wide ones are what the MeshCore
// community publishes per region; the narrow one is what the mesh in
// Victoria runs - all four settings have to match a mesh's to hear it.

struct Preset
{
	const char*		name;
	float			frequency, bandwidth;
	int				spreadingFactor, codingRate;
};

static const Preset kPresets[] =
{
	{ "Victoria AU",	916.575f,	62.5f,	7,	8 },
	{ "Aus / NZ",		915.800f,	250.0f,	10,	5 },
	{ "EU / UK",		869.525f,	250.0f,	10,	5 },
	{ "US / Canada",	910.525f,	250.0f,	10,	5 },
};
const long		kPresetCount = (long) (sizeof(kPresets) / sizeof(kPresets[0]));
const int		kTxPowerMax = 22;

// Every MeshCore node has the same key for the public channel: it is the
// open conversation on the frequency, not a secret
#define PUBLIC_CHANNEL_KEY	"izOH6cXN6mrJ5e26oRXNcg=="
#define PUBLIC_CHANNEL_NAME	"Public"

const unsigned long	kAdvertPeriodMs = 10 * 60 * 1000;	// this node announced unprompted this often
const unsigned long	kFirstAdvertMs = 3000;				// ... and this long after starting
const unsigned long	kContactsSaveMs = 10 * 1000;		// contacts kept this long after they last changed
const int			kSendAttempts = 3;
const int			kMessagesKept = 32;					// received and not yet taken
const int			kSendsKept = 32;


// ----------------------------------------------------------------------
// The clocks.  The mesh clock is the host's once the host knows the time
// (a board learns it from the network after it starts): until then it
// counts on from the last time it was told (lilyphone1's
// VolatileRTCClock, which nothing ever ticked, so its time stood still)

static unsigned long
NowMs(void)
{
	using namespace std::chrono;
	return (unsigned long) duration_cast<milliseconds>(steady_clock::now().time_since_epoch()).count();
}

class HostMillis : public mesh::MillisecondClock
{
public:
	unsigned long	getMillis() override { return NowMs(); }
};

const uint32_t	kTimeKnown = 1700000000;		// (Nov 2023) a host clock before this does not know the time

class HostRTC : public mesh::RTCClock
{
	uint32_t		fBase = 1715770351;			// MeshCore's own start (May 2024)
	unsigned long	fBaseMs = NowMs();
public:
	uint32_t getCurrentTime() override
	{
		time_t host = time(NULL);
		if ((uint32_t) host >= kTimeKnown)
			return (uint32_t) host;
		return fBase + (uint32_t) ((NowMs() - fBaseMs) / 1000);
	}
	void setCurrentTime(uint32_t t) override
	{
		fBase = t;
		fBaseMs = NowMs();
	}
};

class HostRNG : public mesh::RNG
{
public:
	void random(uint8_t* dest, size_t size) override { HostMeshRandom(dest, size); }
};

static void (*gRandomSource)(void* bytes, size_t size) = NULL;

extern "C" void
HostMeshRandom(void* bytes, size_t size)
{
	if (gRandomSource != NULL)
	{
		gRandomSource(bytes, size);
		return;
	}
	static std::random_device device;
	unsigned char* p = (unsigned char*) bytes;
	for (size_t k = 0; k < size; k++)
		p[k] = (unsigned char) (device() & 0xFF);
}


// ----------------------------------------------------------------------
// The engine's state, shared under gLock: the snapshot the natives read,
// the queues, the requests

static std::mutex				gLock;
static std::condition_variable	gWake;
static std::atomic<bool>		gWillRun(false);
static std::atomic<bool>		gStarted(false);

static HostMeshStatusInfo		gStatus;
static HOST_LARGE_STATIC HostMeshContact	gContacts[kHostMeshContactsMax];
static long						gContactCount = 0;

static HOST_LARGE_STATIC HostMeshMessage	gMessages[kMessagesKept];
static int						gMessageHead = 0, gMessageCount = 0;

struct Send
{
	long		id;
	int			state;			// HostMeshSendState
	bool		channel;
	uint8_t		key[kHostMeshKeySize];
	char		text[kHostMeshTextSize];
	int			attempt;		// 0: not yet sent
	uint32_t	timestamp;		// the same for every attempt (the receiver drops repeats by it)
	uint32_t	ack;
	unsigned long deadline;
};
static HOST_LARGE_STATIC Send	gSends[kSendsKept];
static long						gNextSendId = 1;

// requests the engine's thread takes up
static bool					gAdvertAsked = false;
static bool					gNameAsked = false;
static char					gNameWanted[kHostMeshNameSize];
static long					gRegionWanted = -1;

// the power
static bool					(*gPowerSwitch)(bool on) = NULL;
static std::atomic<bool>	gPowered(true);
static std::atomic<bool>	gSleepAsked(false);
static std::atomic<bool>	gWakeAsked(false);


static void
HexOf(const uint8_t* bytes, long size, char* hex)
{
	static const char kDigits[] = "0123456789ABCDEF";
	for (long k = 0; k < size; k++)
	{
		hex[2 * k] = kDigits[bytes[k] >> 4];
		hex[2 * k + 1] = kDigits[bytes[k] & 15];
	}
	hex[2 * size] = 0;
}


// ==> whether hex was a whole key
static bool
KeyOf(const char* hex, uint8_t* key)
{
	for (long k = 0; k < kHostMeshKeySize; k++)
	{
		int v = 0;
		for (int n = 0; n < 2; n++)
		{
			char c = hex[2 * k + n];
			int d = c >= '0' && c <= '9' ? c - '0' : c >= 'a' && c <= 'f' ? c - 'a' + 10 : c >= 'A' && c <= 'F' ? c - 'A' + 10 : -1;
			if (d < 0)
				return false;
			v = v * 16 + d;
		}
		key[k] = (uint8_t) v;
	}
	return hex[2 * kHostMeshKeySize] == 0;
}


// text cut to at most size - 1 bytes, at a character's start (UTF-8)
static void
CopyUTF8(char* to, const char* from, size_t size)
{
	size_t n = strlen(from);
	if (n >= size)
	{
		n = size - 1;
		while (n > 0 && (((unsigned char) from[n]) & 0xC0) == 0x80)
			n--;
	}
	memcpy(to, from, n);
	to[n] = 0;
}


// ----------------------------------------------------------------------
// What is kept across restarts

struct KeptSettings
{
	uint32_t	version;
	char		name[kHostMeshNameSize];
	int32_t		region;
	int32_t		txPower;
};
const uint32_t	kSettingsVersion = 1;

// a contact as kept: MeshCore's ContactInfo without its cached secret
struct KeptContact
{
	uint8_t		key[PUB_KEY_SIZE];
	char		name[32];
	uint8_t		type, flags, outPathLength, unused;
	uint8_t		outPath[MAX_PATH_SIZE];
	uint32_t	lastAdvert, lastmod;
	int32_t		latitude, longitude;
	uint32_t	syncSince;
};
const long		kContactsMagic = 0x4D43431;		// "MCC" 1


// ----------------------------------------------------------------------
// The node

class HostMeshNode;
static HostMeshNode*			gNode = NULL;
static const HostMeshPlatform*	gPlatform = NULL;
static KeptSettings				gSettings;
static bool						gContactsChanged = false;
static unsigned long			gContactsChangedAt = 0;

static void		RecordMessage(const char* key, const char* name, const char* channel, const char* text, uint32_t sent);

class HostMeshNode : public BaseChatMesh
{
public:
	HostMeshNode(mesh::Radio& radio, mesh::MillisecondClock& ms, mesh::RNG& rng, mesh::RTCClock& rtc, mesh::PacketManager& mgr, mesh::MeshTables& tables)
		: BaseChatMesh(radio, ms, rng, rtc, mgr, tables) { }

	// a node in a pocket is a poor repeater and forwarding costs battery
	bool	allowPacketForward(const mesh::Packet*) override { return false; }

	void onDiscoveredContact(ContactInfo& contact, bool isNew, uint8_t, const uint8_t*) override
	{
		gContactsChanged = true;
		gContactsChangedAt = NowMs();
		Mirror();
	}

	void onContactPathUpdated(const ContactInfo&) override
	{
		gContactsChanged = true;
		gContactsChangedAt = NowMs();
		Mirror();
	}

	ContactInfo* processAck(const uint8_t* data) override
	{
		uint32_t ack;
		memcpy(&ack, data, 4);
		std::lock_guard<std::mutex> hold(gLock);
		for (int k = 0; k < kSendsKept; k++)
		{
			Send& s = gSends[k];
			if (s.id != 0 && s.state == kHostMeshSendBusy && !s.channel && s.attempt > 0 && s.ack == ack)
			{
				s.state = kHostMeshSendDelivered;
				return lookupContactByPubKey(s.key, PUB_KEY_SIZE);
			}
		}
		return NULL;
	}

	void onMessageRecv(const ContactInfo& contact, mesh::Packet*, uint32_t timestamp, const char* text) override
	{
		char key[kHostMeshKeyHexSize];
		HexOf(contact.id.pub_key, PUB_KEY_SIZE, key);
		RecordMessage(key, contact.name, "", text, timestamp);
	}

	void onSignedMessageRecv(const ContactInfo& contact, mesh::Packet* pkt, uint32_t timestamp, const uint8_t*, const char* text) override
	{
		onMessageRecv(contact, pkt, timestamp, text);
	}

	void onChannelMessageRecv(const mesh::GroupChannel& channel, mesh::Packet*, uint32_t timestamp, const char* text) override
	{
		// MeshCore's channel text is "<sender>: <text>"
		char name[kHostMeshNameSize] = "";
		const char* colon = strstr(text, ": ");
		if (colon != NULL && colon - text < kHostMeshNameSize)
		{
			memcpy(name, text, colon - text);
			name[colon - text] = 0;
			text = colon + 2;
		}
		ChannelDetails details;
		int index = findChannelIdx(channel);
		const char* channelName = index >= 0 && getChannel(index, details) ? details.name : "?";
		RecordMessage("", name, channelName, text, timestamp);
	}

	// commands are for repeaters and room servers: nothing here answers one
	void onCommandDataRecv(const ContactInfo&, mesh::Packet*, uint32_t, const char*) override { }
	uint8_t onContactRequest(const ContactInfo&, uint32_t, const uint8_t*, uint8_t, uint8_t*) override { return 0; }
	void onContactResponse(const ContactInfo&, const uint8_t*, uint8_t) override { }

	// how long to wait for an acknowledgement (lilyphone1's): a flood has
	// to cross the mesh and be answered back across it
	uint32_t calcFloodTimeoutMillisFor(uint32_t airtime) const override { return 12000 + airtime * 12; }
	uint32_t calcDirectTimeoutMillisFor(uint32_t airtime, uint8_t pathLength) const override { return 6000 + airtime * 2 * (pathLength + 2); }

	// BaseChatMesh keeps one timeout, for the last message sent: each send
	// keeps its own here (CheckSends)
	void	onSendTimeout() override { }

	// the contacts as the natives see them, newest first
	void Mirror()
	{
		std::lock_guard<std::mutex> hold(gLock);
		long count = 0;
		ContactsIterator walk = startContactsIterator();
		ContactInfo c;
		while (count < kHostMeshContactsMax && walk.hasNext(this, c))
		{
			if (c.type == ADV_TYPE_NONE)
				continue;
			HostMeshContact& m = gContacts[count++];
			HexOf(c.id.pub_key, PUB_KEY_SIZE, m.key);
			CopyUTF8(m.name, c.name, sizeof(m.name));
			m.kind = c.type;
			m.hops = c.out_path_len == OUT_PATH_UNKNOWN ? -1 : c.out_path_len;
			m.heard = c.lastmod;
		}
		// newest first (insertion: there are few)
		for (long i = 1; i < count; i++)
			for (long j = i; j > 0 && gContacts[j].heard > gContacts[j - 1].heard; j--)
			{
				HostMeshContact t = gContacts[j];
				gContacts[j] = gContacts[j - 1];
				gContacts[j - 1] = t;
			}
		gContactCount = count;
		gStatus.contacts = count;
	}

	void SaveContacts()
	{
		static HOST_LARGE_STATIC KeptContact kept[kHostMeshContactsMax];
		long count = 0;
		ContactsIterator walk = startContactsIterator();
		ContactInfo c;
		while (count < kHostMeshContactsMax && walk.hasNext(this, c))
		{
			if (c.type == ADV_TYPE_NONE)
				continue;
			KeptContact& k = kept[count++];
			memset(&k, 0, sizeof(k));
			memcpy(k.key, c.id.pub_key, PUB_KEY_SIZE);
			memcpy(k.name, c.name, sizeof(k.name));
			k.type = c.type;
			k.flags = c.flags;
			k.outPathLength = c.out_path_len;
			memcpy(k.outPath, c.out_path, MAX_PATH_SIZE);
			k.lastAdvert = c.last_advert_timestamp;
			k.lastmod = c.lastmod;
			k.latitude = c.gps_lat;
			k.longitude = c.gps_lon;
			k.syncSince = c.sync_since;
		}
		static HOST_LARGE_STATIC uint8_t blob[8 + sizeof(kept)];
		uint32_t magic = kContactsMagic, n = (uint32_t) count;
		memcpy(blob, &magic, 4);
		memcpy(blob + 4, &n, 4);
		memcpy(blob + 8, kept, count * sizeof(KeptContact));
		gPlatform->save(gPlatform->ref, "contacts", blob, 8 + count * (long) sizeof(KeptContact));
	}

	void LoadContacts()
	{
		static HOST_LARGE_STATIC uint8_t blob[8 + kHostMeshContactsMax * sizeof(KeptContact)];
		long size = sizeof(blob);
		if (!gPlatform->load(gPlatform->ref, "contacts", blob, &size) || size < 8)
			return;
		uint32_t magic, n;
		memcpy(&magic, blob, 4);
		memcpy(&n, blob + 4, 4);
		if (magic != kContactsMagic || 8 + n * (long) sizeof(KeptContact) > size)
			return;
		for (uint32_t i = 0; i < n; i++)
		{
			KeptContact k;
			memcpy(&k, blob + 8 + i * sizeof(KeptContact), sizeof(k));
			ContactInfo c;
			memset(&c, 0, sizeof(c));
			c.id = mesh::Identity(k.key);
			memcpy(c.name, k.name, sizeof(c.name));
			c.name[sizeof(c.name) - 1] = 0;
			c.type = k.type;
			c.flags = k.flags;
			c.out_path_len = k.outPathLength;
			memcpy(c.out_path, k.outPath, MAX_PATH_SIZE);
			c.last_advert_timestamp = k.lastAdvert;
			c.lastmod = k.lastmod;
			c.gps_lat = k.latitude;
			c.gps_lon = k.longitude;
			c.sync_since = k.syncSince;
			addContact(c);
		}
	}

	void Advertise()
	{
		mesh::Packet* advert = createSelfAdvert(gSettings.name);
		if (advert != NULL)
			sendFlood(advert);
	}

	// each send waiting for its turn, its acknowledgement or its timeout
	void CheckSends()
	{
		unsigned long now = NowMs();
		for (int k = 0; k < kSendsKept; k++)
		{
			Send s;
			{
				std::lock_guard<std::mutex> hold(gLock);
				if (gSends[k].id == 0 || gSends[k].state != kHostMeshSendBusy)
					continue;
				if (gSends[k].attempt > 0 && (long) (now - gSends[k].deadline) < 0)
					continue;
				s = gSends[k];
			}
			int state = kHostMeshSendBusy;
			uint32_t ack = 0, timeout = 0;
			if (s.channel)
			{
				ChannelDetails publicChannel;
				state = getChannel(0, publicChannel)
					 && sendGroupMessage(s.timestamp, publicChannel.channel, gSettings.name, s.text, (int) strlen(s.text))
						? kHostMeshSendSent : kHostMeshSendFailed;
				if (state == kHostMeshSendSent)
				{
					std::lock_guard<std::mutex> hold(gLock);
					gStatus.sent++;
				}
			}
			else if (s.attempt >= kSendAttempts)
				state = kHostMeshSendFailed;			// the last attempt's timeout
			else
			{
				ContactInfo* contact = lookupContactByPubKey(s.key, PUB_KEY_SIZE);
				if (contact == NULL)
					state = kHostMeshSendFailed;
				else
				{
					// the last attempt by flood: the route may have gone
					if (s.attempt == kSendAttempts - 1 && contact->out_path_len != OUT_PATH_UNKNOWN)
						resetPathTo(*contact);
					if (sendMessage(*contact, s.timestamp, (uint8_t) s.attempt, s.text, ack, timeout) == MSG_SEND_FAILED)
						state = kHostMeshSendFailed;
					else if (s.attempt == 0)
					{
						std::lock_guard<std::mutex> hold(gLock);
						gStatus.sent++;
					}
				}
			}
			std::lock_guard<std::mutex> hold(gLock);
			Send& t = gSends[k];
			if (t.id != s.id || t.state != kHostMeshSendBusy)
				continue;						// (settled meanwhile)
			t.state = state;
			if (state == kHostMeshSendBusy)
			{
				t.attempt++;
				t.ack = ack;
				t.deadline = NowMs() + timeout;
			}
		}
	}
};


static void
RecordMessage(const char* key, const char* name, const char* channel, const char* text, uint32_t sent)
{
	std::lock_guard<std::mutex> hold(gLock);
	if (gMessageCount == kMessagesKept)
	{
		gMessageHead = (gMessageHead + 1) % kMessagesKept;		// the oldest dropped
		gMessageCount--;
	}
	HostMeshMessage& m = gMessages[(gMessageHead + gMessageCount++) % kMessagesKept];
	memset(&m, 0, sizeof(m));
	CopyUTF8(m.key, key, sizeof(m.key));
	CopyUTF8(m.name, name, sizeof(m.name));
	CopyUTF8(m.channel, channel, sizeof(m.channel));
	CopyUTF8(m.text, text, sizeof(m.text));
	m.sent = sent;
	m.received = gNode != NULL ? gNode->getRTCClock()->getCurrentTime() : 0;
	gStatus.received++;
}


// ----------------------------------------------------------------------
// The engine's thread

static HostMillis		gMillis;
static HostRTC			gRTC;
static HostRNG			gRNG;
static SimpleMeshTables	gTables;

static HostMeshRadioSettings
RadioSettings(void)
{
	const Preset& p = kPresets[gSettings.region];
	HostMeshRadioSettings r = { p.frequency, p.bandwidth, p.spreadingFactor, p.codingRate, (int) gSettings.txPower };
	return r;
}


static void
SaveSettings(void)
{
	gPlatform->save(gPlatform->ref, "settings", &gSettings, sizeof(gSettings));
}


static void
StatusRadio(void)
{
	std::lock_guard<std::mutex> hold(gLock);
	gStatus.radio = RadioSettings();
	CopyUTF8(gStatus.region, kPresets[gSettings.region].name, sizeof(gStatus.region));
	CopyUTF8(gStatus.name, gSettings.name, sizeof(gStatus.name));
}


void
HostMeshRun(const HostMeshPlatform* platform)
{
	gPlatform = platform;
	gStarted = true;
	{
		std::lock_guard<std::mutex> hold(gLock);
		gStatus.state = kHostMeshStarting;
	}

	// the settings
	memset(&gSettings, 0, sizeof(gSettings));
	long size = sizeof(gSettings);
	if (!platform->load(platform->ref, "settings", &gSettings, &size) || size != (long) sizeof(gSettings) || gSettings.version != kSettingsVersion)
	{
		memset(&gSettings, 0, sizeof(gSettings));
		gSettings.version = kSettingsVersion;
		CopyUTF8(gSettings.name, platform->defaultName != NULL ? platform->defaultName : "Newton", sizeof(gSettings.name));
		gSettings.region = 0;
		gSettings.txPower = kTxPowerMax;
	}
	if (gSettings.region < 0 || gSettings.region >= kPresetCount)
		gSettings.region = 0;

	static StaticPoolPacketManager* manager = new StaticPoolPacketManager(16);
	HostMeshNode* node = new HostMeshNode(*platform->radio, gMillis, gRNG, gRTC, *manager, gTables);

	// the identity: this node's name on the mesh for good
	uint8_t identity[PUB_KEY_SIZE + PRV_KEY_SIZE];
	long identitySize = sizeof(identity);
	if (platform->load(platform->ref, "identity", identity, &identitySize) && identitySize == (long) sizeof(identity))
		node->self_id.readFrom(identity, sizeof(identity));
	else
	{
		node->self_id = mesh::LocalIdentity(&gRNG);
		node->self_id.writeTo(identity, sizeof(identity));
		platform->save(platform->ref, "identity", identity, sizeof(identity));
		SaveSettings();
	}
	{
		std::lock_guard<std::mutex> hold(gLock);
		HexOf(node->self_id.pub_key, PUB_KEY_SIZE, gStatus.key);
	}
	StatusRadio();

	HostMeshRadioSettings radio = RadioSettings();
	bool radioUp = gPowered && platform->radioStart(platform->ref, &radio);
	node->begin();
	node->addChannel(PUBLIC_CHANNEL_NAME, PUBLIC_CHANNEL_KEY);
	node->LoadContacts();
	node->Mirror();
	gNode = node;
	{
		std::lock_guard<std::mutex> hold(gLock);
		gStatus.state = gPowered ? kHostMeshOn : kHostMeshOff;
	}
	fprintf(stderr, "[mesh] up as \"%s\" (%.8s), %s: %.3f MHz bw %.1f sf %d cr %d%s\n", gSettings.name, gStatus.key,
			kPresets[gSettings.region].name, radio.frequency, radio.bandwidth, radio.spreadingFactor, radio.codingRate,
			gPowered ? (radioUp ? "" : " - the radio would not start") : " - the radio is off");

	unsigned long nextAdvert = NowMs() + kFirstAdvertMs;
	for (;;)
	{
		// the power
		if (gSleepAsked.exchange(false))
		{
			platform->radioSleep(platform->ref);
			if (gPowerSwitch != NULL)
				gPowerSwitch(false);
			std::lock_guard<std::mutex> hold(gLock);
			gStatus.state = kHostMeshOff;
		}
		if (gWakeAsked.exchange(false))
		{
			std::this_thread::sleep_for(std::chrono::milliseconds(100));	// the module given a moment
			radio = RadioSettings();
			radioUp = platform->radioStart(platform->ref, &radio);
			fprintf(stderr, "[mesh] the radio on again%s\n", radioUp ? "" : " - it would not start");
			{
				std::lock_guard<std::mutex> hold(gLock);
				gStatus.state = kHostMeshOn;
			}
			nextAdvert = NowMs() + kFirstAdvertMs;
		}
		if (!gPowered)
		{
			std::unique_lock<std::mutex> hold(gLock);
			gWake.wait_for(hold, std::chrono::milliseconds(200));
			continue;
		}

		// the requests
		bool advert = false, rename = false;
		long region = -1;
		char name[kHostMeshNameSize];
		{
			std::lock_guard<std::mutex> hold(gLock);
			advert = gAdvertAsked;
			gAdvertAsked = false;
			rename = gNameAsked;
			gNameAsked = false;
			memcpy(name, gNameWanted, sizeof(name));
			region = gRegionWanted;
			gRegionWanted = -1;
		}
		if (rename)
		{
			memcpy(gSettings.name, name, sizeof(gSettings.name));
			SaveSettings();
			StatusRadio();
			advert = true;
		}
		if (region >= 0 && region < kPresetCount && region != gSettings.region)
		{
			gSettings.region = (int32_t) region;
			SaveSettings();
			StatusRadio();
			radio = RadioSettings();
			platform->radioStart(platform->ref, &radio);
			fprintf(stderr, "[mesh] %s: %.3f MHz bw %.1f sf %d cr %d\n", kPresets[region].name, radio.frequency, radio.bandwidth, radio.spreadingFactor, radio.codingRate);
			advert = true;										// nobody there has heard this node
		}

		node->CheckSends();
		node->loop();

		unsigned long now = NowMs();
		if (advert || (long) (now - nextAdvert) >= 0)
		{
			node->Advertise();
			nextAdvert = now + kAdvertPeriodMs;
		}
		if (gContactsChanged && now - gContactsChangedAt >= kContactsSaveMs)
		{
			gContactsChanged = false;
			node->SaveContacts();
		}

		// short enough not to miss a receive window, long enough to yield;
		// a request wakes it at once
		std::unique_lock<std::mutex> hold(gLock);
		gWake.wait_for(hold, std::chrono::milliseconds(5));
	}
}


void
HostMeshWillRun(void)
{
	gWillRun = true;
	std::lock_guard<std::mutex> hold(gLock);
	if (gStatus.state == kHostMeshNone)
		gStatus.state = kHostMeshStarting;
}


bool
HostMeshStarted(void)
{
	return gWillRun || gStarted;
}


// ----------------------------------------------------------------------
// The interface (any thread)

void
HostMeshGetStatus(HostMeshStatusInfo* status)
{
	std::lock_guard<std::mutex> hold(gLock);
	*status = gStatus;
}


long
HostMeshGetContacts(HostMeshContact* contacts, long max)
{
	std::lock_guard<std::mutex> hold(gLock);
	for (long k = 0; k < gContactCount && k < max; k++)
		contacts[k] = gContacts[k];
	return gContactCount;
}


bool
HostMeshNextMessage(HostMeshMessage* message)
{
	std::lock_guard<std::mutex> hold(gLock);
	if (gMessageCount == 0)
		return false;
	*message = gMessages[gMessageHead];
	gMessageHead = (gMessageHead + 1) % kMessagesKept;
	gMessageCount--;
	message->now = gRTC.getCurrentTime();
	return true;
}


long
HostMeshSendText(const char* key, const char* text)
{
	if (!HostMeshStarted() || text == NULL || text[0] == 0)
		return 0;
	Send s;
	memset(&s, 0, sizeof(s));
	s.channel = key == NULL || key[0] == 0;
	if (!s.channel && !KeyOf(key, s.key))
		return 0;
	// (MeshCore takes MAX_TEXT_LEN, 160 bytes; a channel's has the
	// sender's name in front, which it cuts to fit)
	CopyUTF8(s.text, text, MAX_TEXT_LEN + 1);
	s.state = kHostMeshSendBusy;
	s.timestamp = gRTC.getCurrentTimeUnique();
	std::lock_guard<std::mutex> hold(gLock);
	int slot = -1;
	for (int k = 0; k < kSendsKept && slot < 0; k++)
		if (gSends[k].id == 0)
			slot = k;
	for (int k = 0; k < kSendsKept && slot < 0; k++)
		if (gSends[k].state != kHostMeshSendBusy)
			slot = k;							// the oldest settled one forgotten
	if (slot < 0)
		return 0;
	s.id = gNextSendId++;
	gSends[slot] = s;
	gWake.notify_one();
	return s.id;
}


int
HostMeshGetSendState(long id)
{
	std::lock_guard<std::mutex> hold(gLock);
	for (int k = 0; k < kSendsKept; k++)
		if (gSends[k].id == id)
			return gSends[k].state;
	return kHostMeshSendNone;
}


bool
HostMeshAdvertise(void)
{
	if (!HostMeshStarted())
		return false;
	std::lock_guard<std::mutex> hold(gLock);
	gAdvertAsked = true;
	gWake.notify_one();
	return true;
}


bool
HostMeshSetName(const char* name)
{
	if (!HostMeshStarted() || name == NULL || name[0] == 0)
		return false;
	std::lock_guard<std::mutex> hold(gLock);
	CopyUTF8(gNameWanted, name, sizeof(gNameWanted));
	gNameAsked = true;
	gWake.notify_one();
	return true;
}


long
HostMeshRegionCount(void)
{
	return kPresetCount;
}


const char*
HostMeshRegionName(long index)
{
	return index >= 0 && index < kPresetCount ? kPresets[index].name : NULL;
}


long
HostMeshRegion(void)
{
	std::lock_guard<std::mutex> hold(gLock);
	for (long k = 0; k < kPresetCount; k++)
		if (strcmp(gStatus.region, kPresets[k].name) == 0)
			return k;
	return 0;
}


bool
HostMeshSetRegion(long index)
{
	if (!HostMeshStarted() || index < 0 || index >= kPresetCount)
		return false;
	std::lock_guard<std::mutex> hold(gLock);
	gRegionWanted = index;
	CopyUTF8(gStatus.region, kPresets[index].name, sizeof(gStatus.region));	// (as the natives will read it)
	gWake.notify_one();
	return true;
}


// ----------------------------------------------------------------------
// The power

void
HostMeshSetPowerSwitch(bool (*powerSwitch)(bool on), bool on)
{
	gPowerSwitch = powerSwitch;
	gPowered = on;
	std::lock_guard<std::mutex> hold(gLock);
	if (!on)
		gStatus.state = kHostMeshOff;
}


bool
HostMeshPowerSwitchable(void)
{
	return gPowerSwitch != NULL;
}


bool
HostMeshPowered(void)
{
	return gPowered;
}


bool
HostMeshSetPower(bool on)
{
	if (gPowerSwitch == NULL)
		return false;
	if (on == gPowered)
		return true;
	if (on)
	{
		// the supply on now; the engine starts the radio again once it has
		// had a moment
		if (!gPowerSwitch(true))
			return false;
		gPowered = true;
		gWakeAsked = true;
	}
	else
	{
		// the engine puts the radio to sleep, then switches it off
		gPowered = false;
		gSleepAsked = true;
		if (!gStarted)
		{
			gSleepAsked = false;
			gPowerSwitch(false);
		}
	}
	std::lock_guard<std::mutex> hold(gLock);
	gStatus.state = on ? kHostMeshStarting : kHostMeshOff;
	gWake.notify_one();
	return true;
}
