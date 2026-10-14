/*
	File:		print/host/dnssd/HostDNSSD.cpp

	Contains:	The host's DNS-SD browse for IPP printers (HostDNSSD.h).

	Host only.
*/

#include "HostDNSSD.h"

#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <mutex>
#include <thread>
#include <chrono>

#if defined(_WIN32)
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include <windns.h>
typedef SOCKET MDNSSocket;
#define MDNS_NO_SOCKET		INVALID_SOCKET
#define MDNSClose			closesocket
#else
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#if !defined(ESP_PLATFORM)
#include <ifaddrs.h>
#include <net/if.h>
#endif
typedef int MDNSSocket;
#define MDNS_NO_SOCKET		(-1)
#define MDNSClose			close
#endif

static std::mutex			gLock;
#ifndef HOST_LARGE_STATIC						// (host/host_compat.h's, where this is built without it)
#define HOST_LARGE_STATIC
#endif
static HostDNSSDPrinter		gFound[64] HOST_LARGE_STATIC;
static int					gFoundCount = 0;
static int					gBusy = 0;
static char*				gInjected = NULL;
static int					gInjectionLooked = 0;


// a printer found, kept unless it is there already (by name)
static void
Found(const HostDNSSDPrinter* printer)
{
	std::lock_guard<std::mutex> hold(gLock);
	for (int i = 0; i < gFoundCount; i++)
		if (strcmp(gFound[i].fName, printer->fName) == 0)
			return;
	if (gFoundCount < (int) (sizeof(gFound) / sizeof(gFound[0])))
		gFound[gFoundCount++] = *printer;
}


// what a pdl key lists: PostScript, PCL
static void
Formats(const char* pdl, HostDNSSDPrinter* printer)
{
	// (media types are case-insensitive: HP's printers say vnd.hp-PCL)
	char lower[512];
	size_t n = 0;
	for (; pdl[n] != 0 && n + 1 < sizeof(lower); n++)
		lower[n] = (char) tolower((unsigned char) pdl[n]);
	lower[n] = 0;
	printer->fPostScript = strstr(lower, "application/postscript") != NULL;
	printer->fPCL = strstr(lower, "application/vnd.hp-pcl") != NULL;
}


// The URI a printer answers at: its address, port and the path its TXT
// record's rp gives (ipp/print when it gives none).
static void
MakeURI(HostDNSSDPrinter* printer, const char* address, int port, const char* rp)
{
	if (rp == NULL || rp[0] == 0)
		rp = "ipp/print";
	while (*rp == '/')
		rp++;
	snprintf(printer->fURI, sizeof(printer->fURI), "ipp://%s:%d/%s", address, port, rp);
}


void
HostDNSSDInject(const char* list)
{
	std::lock_guard<std::mutex> hold(gLock);
	free(gInjected);
	gInjected = (list != NULL && list[0] != 0) ? strdup(list) : NULL;
	gInjectionLooked = 1;
}


// "NAME|URI|FORMATS;..." taken as found
static void
TakeInjected(const char* list)
{
	const char* p = list;
	while (*p != 0)
	{
		const char* end = strchr(p, ';');
		size_t n = end != NULL ? (size_t) (end - p) : strlen(p);
		char entry[512];
		if (n >= sizeof(entry))
			n = sizeof(entry) - 1;
		memcpy(entry, p, n);
		entry[n] = 0;
		char* uri = strchr(entry, '|');
		if (uri != NULL)
		{
			*uri++ = 0;
			char* formats = strchr(uri, '|');
			if (formats != NULL)
				*formats++ = 0;
			HostDNSSDPrinter printer;
			memset(&printer, 0, sizeof(printer));
			snprintf(printer.fName, sizeof(printer.fName), "%s", entry);
			snprintf(printer.fURI, sizeof(printer.fURI), "%s", uri);
			if (formats != NULL)
			{
				printer.fPostScript = strstr(formats, "ps") != NULL;
				printer.fPCL = strstr(formats, "pcl") != NULL;
			}
			Found(&printer);
		}
		p += n;
		if (*p == ';')
			p++;
	}
}


/*------------------------------------------------------------------------------
	A   q u e s t i o n   a s k e d   o n   t h e   l i n k   ( m D N S )

	Where the host has no browse of its own - a Linux where avahi-browse is missing or finds nothing
	(the reMarkable found no printer), ESP-IDF (the T-Deck Pro) - the question is put on the
	local link through the host's own sockets: a "legacy unicast" mDNS query
	(RFC 6762 6.7) for _ipp._tcp.local's PTR records, sent to 224.0.0.251:5353
	from a port of our own, so every responder answers to that port and
	nothing listens on 5353 (which the host's own responder may hold).  The
	answers' SRV, TXT and A records make each printer's URI; what an answer
	leaves out is asked for in a second round, and a printer whose address
	never comes is taken at the address it answered from.  DEVIATION: the
	host's browse is still used first where there is one.
------------------------------------------------------------------------------*/

struct MDNSInstance
{
	char		fName[256];			// "Office\.Laser._ipp._tcp.local" (dots in a label escaped)
	char		fTarget[256];		// the SRV record's host
	int			fPort;
	char		fRP[128];
	char		fPDL[512];
	int			fHaveSRV;
	int			fHaveTXT;
	uint32_t	fFrom;				// the address it answered from (network order)
};

struct MDNSHost
{
	char		fName[256];
	uint32_t	fAddress;			// network order
};

struct MDNSState
{
	MDNSInstance	fInstances[32];
	int				fInstanceCount;
	MDNSHost		fHosts[32];
	int				fHostCount;
};

static const char kIPPService[] = "_ipp._tcp.local";

enum { kMDNS_A = 1, kMDNS_PTR = 12, kMDNS_TXT = 16, kMDNS_SRV = 33 };


static int
SameName(const char* a, const char* b)
{
	for (; *a != 0 && *b != 0; a++, b++)
		if (tolower((unsigned char) *a) != tolower((unsigned char) *b))
			return 0;
	return *a == *b;
}


// A name read from a packet (compression followed) as dotted text, a dot or
// backslash inside a label escaped.  ==> the offset after it in the record,
// or -1 if it is damaged.
static int
ReadName(const unsigned char* packet, int size, int offset, char* out, size_t outSize)
{
	size_t n = 0;
	int end = -1;
	int jumps = 0;
	out[0] = 0;
	while (offset < size)
	{
		int length = packet[offset];
		if (length == 0)
		{
			if (end < 0)
				end = offset + 1;
			out[n] = 0;
			return end;
		}
		if ((length & 0xC0) == 0xC0)
		{
			if (offset + 1 >= size || ++jumps > 32)
				return -1;
			if (end < 0)
				end = offset + 2;
			offset = ((length & 0x3F) << 8) | packet[offset + 1];
			continue;
		}
		if ((length & 0xC0) != 0 || offset + 1 + length > size)
			return -1;
		if (n != 0 && n + 1 < outSize)
			out[n++] = '.';
		for (int i = 0; i < length; i++)
		{
			char c = (char) packet[offset + 1 + i];
			if ((c == '.' || c == '\\') && n + 1 < outSize)
				out[n++] = '\\';
			if (n + 1 < outSize)
				out[n++] = c;
		}
		offset += 1 + length;
	}
	return -1;
}


// A dotted name (as ReadName makes them) written as labels.  ==> its length.
static int
WriteName(const char* name, unsigned char* out, int room)
{
	int n = 0;
	while (*name != 0)
	{
		int at = n++;
		int length = 0;
		while (*name != 0 && *name != '.')
		{
			if (*name == '\\' && name[1] != 0)
				name++;
			if (n >= room - 1 || length == 63)
				return -1;
			out[n++] = (unsigned char) *name++;
			length++;
		}
		out[at] = (unsigned char) length;
		if (*name == '.')
			name++;
	}
	if (n >= room)
		return -1;
	out[n++] = 0;
	return n;
}


static MDNSInstance*
Instance(MDNSState* state, const char* name)
{
	for (int i = 0; i < state->fInstanceCount; i++)
		if (SameName(state->fInstances[i].fName, name))
			return &state->fInstances[i];
	if (state->fInstanceCount == (int) (sizeof(state->fInstances) / sizeof(state->fInstances[0])))
		return NULL;
	MDNSInstance* instance = &state->fInstances[state->fInstanceCount++];
	memset(instance, 0, sizeof(*instance));
	snprintf(instance->fName, sizeof(instance->fName), "%s", name);
	return instance;
}


// Whether a name is an instance of the IPP service ("<label>._ipp._tcp.local").
static int
IsIPPInstance(const char* name)
{
	size_t length = strlen(name), service = strlen(kIPPService);
	return length > service + 1 && name[length - service - 1] == '.' && name[length - service - 2] != '\\'
		&& SameName(name + length - service, kIPPService);
}


// a TXT string's value copied (cut to fit)
static void
TXTValue(const unsigned char* value, int length, char* out, size_t outSize)
{
	size_t k = (size_t) length < outSize - 1 ? (size_t) length : outSize - 1;
	memcpy(out, value, k);
	out[k] = 0;
}

// One TXT record's strings: rp= and pdl= (no buffers on the stack: the
// browse's thread on ESP-IDF has 3 KB)
static void
ReadTXT(const unsigned char* data, int length, MDNSInstance* instance)
{
	int i = 0;
	while (i < length)
	{
		int n = data[i++];
		if (i + n > length)
			break;
		if (n >= 3 && memcmp(data + i, "rp=", 3) == 0)
			TXTValue(data + i + 3, n - 3, instance->fRP, sizeof(instance->fRP));
		else if (n >= 4 && memcmp(data + i, "pdl=", 4) == 0)
			TXTValue(data + i + 4, n - 4, instance->fPDL, sizeof(instance->fPDL));
		i += n;
	}
	instance->fHaveTXT = 1;
}


// Every record of one answer taken into the state.
static void
TakeAnswer(MDNSState* state, const unsigned char* packet, int size, uint32_t from)
{
	if (size < 12 || (packet[2] & 0x80) == 0)				// (answers only, not others' questions)
		return;
	int questions = (packet[4] << 8) | packet[5];
	int records = ((packet[6] << 8) | packet[7]) + ((packet[8] << 8) | packet[9]) + ((packet[10] << 8) | packet[11]);
	int offset = 12;
	char name[256];
	for (int i = 0; i < questions; i++)
	{
		offset = ReadName(packet, size, offset, name, sizeof(name));
		if (offset < 0 || offset + 4 > size)
			return;
		offset += 4;
	}
	for (int i = 0; i < records; i++)
	{
		offset = ReadName(packet, size, offset, name, sizeof(name));
		if (offset < 0 || offset + 10 > size)
			return;
		int type = (packet[offset] << 8) | packet[offset + 1];
		int length = (packet[offset + 8] << 8) | packet[offset + 9];
		offset += 10;
		if (offset + length > size)
			return;
		const unsigned char* data = packet + offset;
		char other[256];
		if (type == kMDNS_PTR && SameName(name, kIPPService))
		{
			if (ReadName(packet, size, offset, other, sizeof(other)) > 0 && IsIPPInstance(other))
			{
				MDNSInstance* instance = Instance(state, other);
				if (instance != NULL && instance->fFrom == 0)
					instance->fFrom = from;
			}
		}
		else if (type == kMDNS_SRV && length > 6 && IsIPPInstance(name))
		{
			MDNSInstance* instance = Instance(state, name);
			if (instance != NULL && ReadName(packet, size, offset + 6, other, sizeof(other)) > 0)
			{
				instance->fPort = (data[4] << 8) | data[5];
				snprintf(instance->fTarget, sizeof(instance->fTarget), "%s", other);
				instance->fHaveSRV = 1;
				if (instance->fFrom == 0)
					instance->fFrom = from;
			}
		}
		else if (type == kMDNS_TXT && IsIPPInstance(name))
		{
			MDNSInstance* instance = Instance(state, name);
			if (instance != NULL)
				ReadTXT(data, length, instance);
		}
		else if (type == kMDNS_A && length == 4)
		{
			int known = 0;
			for (int h = 0; h < state->fHostCount; h++)
				if (SameName(state->fHosts[h].fName, name))
					known = 1;
			if (!known && state->fHostCount < (int) (sizeof(state->fHosts) / sizeof(state->fHosts[0])))
			{
				MDNSHost* host = &state->fHosts[state->fHostCount++];
				snprintf(host->fName, sizeof(host->fName), "%s", name);
				memcpy(&host->fAddress, data, 4);
			}
		}
		offset += length;
	}
}


// The printers the state knows enough of: an SRV record and an address.
static int
TakePrinters(MDNSState* state)
{
	int found = 0;
	for (int i = 0; i < state->fInstanceCount; i++)
	{
		MDNSInstance* instance = &state->fInstances[i];
		if (!instance->fHaveSRV)
			continue;
		uint32_t address = instance->fFrom;
		for (int h = 0; h < state->fHostCount; h++)
			if (SameName(state->fHosts[h].fName, instance->fTarget))
				address = state->fHosts[h].fAddress;
		if (address == 0)
			continue;
		HostDNSSDPrinter printer;
		memset(&printer, 0, sizeof(printer));
		// the name is the instance's own label, its escapes undone
		const char* s = instance->fName;
		size_t n = 0;
		for (; *s != 0 && *s != '.' && n + 1 < sizeof(printer.fName); s++)
		{
			if (*s == '\\' && s[1] != 0)
				s++;
			printer.fName[n++] = *s;
		}
		printer.fName[n] = 0;
		const unsigned char* a = (const unsigned char*) &address;
		char text[32];
		snprintf(text, sizeof(text), "%u.%u.%u.%u", a[0], a[1], a[2], a[3]);
		MakeURI(&printer, text, instance->fPort, instance->fRP);
		Formats(instance->fPDL, &printer);
		Found(&printer);
		found++;
	}
	return found;
}


int
HostDNSSDTakeMDNSAnswers(const unsigned char* const* packets, const int* sizes, const unsigned long* from, int count)
{
	static MDNSState state HOST_LARGE_STATIC;
	memset(&state, 0, sizeof(state));
	for (int i = 0; i < count; i++)
		TakeAnswer(&state, packets[i], sizes[i], (uint32_t) from[i]);
	return TakePrinters(&state);
}


// A question for each (name, type) put in one packet.  ==> its length.
static int
MakeQuery(unsigned char* packet, int room, const char* const* names, const int* types, int count)
{
	if (room < 12)
		return -1;
	memset(packet, 0, 12);
	packet[1] = 0x4E;										// (an id: legacy queries are answered with it)
	packet[4] = (unsigned char) (count >> 8);
	packet[5] = (unsigned char) count;
	int n = 12;
	for (int i = 0; i < count; i++)
	{
		int length = WriteName(names[i], packet + n, room - n - 4);
		if (length < 0)
			return -1;
		n += length;
		packet[n++] = (unsigned char) (types[i] >> 8);
		packet[n++] = (unsigned char) types[i];
		packet[n++] = 0;
		packet[n++] = 1;									// class IN
	}
	return n;
}


// The host's IPv4 interfaces that are up and take multicast (network
// order), loopback left out.  ==> how many; none (ESP-IDF, whose lwIP has
// no getifaddrs and one interface) means the default route's.
static int
Interfaces(uint32_t* addresses, int maxCount)
{
	int n = 0;
#if defined(_WIN32)
	SOCKET s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (s == INVALID_SOCKET)
		return 0;
	INTERFACE_INFO list[32];
	DWORD bytes = 0;
	if (WSAIoctl(s, SIO_GET_INTERFACE_LIST, NULL, 0, list, sizeof(list), &bytes, NULL, NULL) != SOCKET_ERROR)
		for (DWORD i = 0; i < bytes / sizeof(INTERFACE_INFO) && n < maxCount; i++)
		{
			u_long flags = list[i].iiFlags;
			if ((flags & IFF_UP) != 0 && (flags & IFF_MULTICAST) != 0 && (flags & IFF_LOOPBACK) == 0
			 && list[i].iiAddress.Address.sa_family == AF_INET)
				addresses[n++] = list[i].iiAddress.AddressIn.sin_addr.s_addr;
		}
	closesocket(s);
#elif !defined(ESP_PLATFORM)
	struct ifaddrs* all = NULL;
	if (getifaddrs(&all) != 0)
		return 0;
	for (struct ifaddrs* ifa = all; ifa != NULL && n < maxCount; ifa = ifa->ifa_next)
		if (ifa->ifa_addr != NULL && ifa->ifa_addr->sa_family == AF_INET
		 && (ifa->ifa_flags & IFF_UP) != 0 && (ifa->ifa_flags & IFF_MULTICAST) != 0 && (ifa->ifa_flags & IFF_LOOPBACK) == 0)
			addresses[n++] = ((struct sockaddr_in*) ifa->ifa_addr)->sin_addr.s_addr;
	freeifaddrs(all);
#endif
	return n;
}


// One round: the query sent on every interface (twice, a moment apart, as
// a lost datagram is common on Wi-Fi - the default route's alone would miss
// a printer on Wi-Fi when the host's multicast route is another interface,
// as Windows' often is a virtual adapter's) and the answers taken for
// `milliseconds`.
static void
AskRound(MDNSSocket s, MDNSState* state, const unsigned char* query, int length, unsigned char* packet, int packetSize, int milliseconds)
{
	uint32_t interfaces[16];
	int interfaceCount = Interfaces(interfaces, 16);
	struct sockaddr_in group;
	memset(&group, 0, sizeof(group));
	group.sin_family = AF_INET;
	group.sin_port = htons(5353);
	group.sin_addr.s_addr = inet_addr("224.0.0.251");
	auto start = std::chrono::steady_clock::now();
	int sent = 0;
	for (;;)
	{
		int elapsed = (int) std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - start).count();
		if (elapsed >= milliseconds)
			break;
		if (sent < 2 && elapsed >= sent * 300)
		{
			if (interfaceCount == 0)
				sendto(s, (const char*) query, length, 0, (const struct sockaddr*) &group, sizeof(group));
			for (int i = 0; i < interfaceCount; i++)
			{
				struct in_addr from;
				from.s_addr = interfaces[i];
				setsockopt(s, IPPROTO_IP, IP_MULTICAST_IF, (const char*) &from, sizeof(from));
				sendto(s, (const char*) query, length, 0, (const struct sockaddr*) &group, sizeof(group));
			}
			sent++;
		}
		fd_set readable;
		FD_ZERO(&readable);
		FD_SET(s, &readable);
		struct timeval wait;
		wait.tv_sec = 0;
		wait.tv_usec = 100 * 1000;
		if (select((int) s + 1, &readable, NULL, NULL, &wait) <= 0)
			continue;
		struct sockaddr_in source;
		socklen_t sourceSize = sizeof(source);
		int got = (int) recvfrom(s, (char*) packet, packetSize, 0, (struct sockaddr*) &source, &sourceSize);
		if (got > 0)
			TakeAnswer(state, packet, got, (uint32_t) source.sin_addr.s_addr);
	}
}


// the question's buffers, off the stack (the browse's thread on ESP-IDF has
// 3 KB), one question at a time
struct MDNSQuery
{
	MDNSState		fState;
	unsigned char	fPacket[9000];
	unsigned char	fQuery[1500];
	const char*		fNames[64];
	int				fTypes[64];
};

static std::mutex			gQueryLock;
static MDNSQuery			gQuery HOST_LARGE_STATIC;

int
HostDNSSDQueryMDNS(int milliseconds)
{
	std::lock_guard<std::mutex> hold(gQueryLock);
	MDNSState& state = gQuery.fState;
	unsigned char* query = gQuery.fQuery;
	const char** names = gQuery.fNames;
	int* types = gQuery.fTypes;
#if defined(_WIN32)
	WSADATA wsa;
	if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0)
		return 0;
#endif
	int found = 0;
	MDNSSocket s = socket(AF_INET, SOCK_DGRAM, 0);
	if (s != MDNS_NO_SOCKET)
	{
		struct sockaddr_in any;
		memset(&any, 0, sizeof(any));
		any.sin_family = AF_INET;
		any.sin_port = 0;
		any.sin_addr.s_addr = htonl(INADDR_ANY);
		if (bind(s, (const struct sockaddr*) &any, sizeof(any)) == 0)
		{
			memset(&state, 0, sizeof(state));
			names[0] = kIPPService;
			types[0] = kMDNS_PTR;
			int length = MakeQuery(query, (int) sizeof(gQuery.fQuery), names, types, 1);
			AskRound(s, &state, query, length, gQuery.fPacket, (int) sizeof(gQuery.fPacket), milliseconds * 2 / 3);
			// what the answers left out asked for by name
			int count = 0;
			for (int i = 0; i < state.fInstanceCount && count + 2 <= 64; i++)
			{
				MDNSInstance* instance = &state.fInstances[i];
				if (!instance->fHaveSRV)
					names[count] = instance->fName, types[count++] = kMDNS_SRV;
				if (!instance->fHaveTXT)
					names[count] = instance->fName, types[count++] = kMDNS_TXT;
			}
			if (count > 0)
			{
				length = MakeQuery(query, (int) sizeof(gQuery.fQuery), names, types, count);
				if (length > 0)
					AskRound(s, &state, query, length, gQuery.fPacket, (int) sizeof(gQuery.fPacket), milliseconds / 3);
			}
			count = 0;
			for (int i = 0; i < state.fInstanceCount && count < 64; i++)
			{
				MDNSInstance* instance = &state.fInstances[i];
				int known = !instance->fHaveSRV;
				for (int h = 0; h < state.fHostCount; h++)
					if (SameName(state.fHosts[h].fName, instance->fTarget))
						known = 1;
				if (!known)
					names[count] = instance->fTarget, types[count++] = kMDNS_A;
			}
			if (count > 0)
			{
				length = MakeQuery(query, (int) sizeof(gQuery.fQuery), names, types, count);
				if (length > 0)
					AskRound(s, &state, query, length, gQuery.fPacket, (int) sizeof(gQuery.fPacket), milliseconds / 3);
			}
			found = TakePrinters(&state);
		}
		MDNSClose(s);
	}
#if defined(_WIN32)
	WSACleanup();
#endif
	return found;
}


/*------------------------------------------------------------------------------
	W i n d o w s :   D n s S e r v i c e B r o w s e
------------------------------------------------------------------------------*/

#if defined(_WIN32)

struct ResolveContext
{
	HANDLE				fDone;
	HostDNSSDPrinter	fPrinter;
	int					fGot;
};

static char gInstances[64][256];
static int gInstanceCount = 0;
static std::mutex gInstancesLock;

static void
ToUTF8(PCWSTR wide, char* out, size_t size)
{
	if (wide == NULL)
	{
		out[0] = 0;
		return;
	}
	if (WideCharToMultiByte(CP_UTF8, 0, wide, -1, out, (int) size, NULL, NULL) == 0)
		out[0] = 0;
}

static VOID WINAPI
BrowseCallback(DWORD status, PVOID /*context*/, PDNS_RECORD record)
{
	if (status != ERROR_SUCCESS || record == NULL)
		return;
	for (PDNS_RECORDW r = (PDNS_RECORDW) record; r != NULL; r = r->pNext)
	{
		if (r->wType != DNS_TYPE_PTR)
			continue;
		char name[256];
		ToUTF8(r->Data.PTR.pNameHost, name, sizeof(name));
		std::lock_guard<std::mutex> hold(gInstancesLock);
		int known = 0;
		for (int i = 0; i < gInstanceCount; i++)
			if (strcmp(gInstances[i], name) == 0)
				known = 1;
		if (!known && gInstanceCount < 64)
			strcpy(gInstances[gInstanceCount++], name);
	}
	DnsRecordListFree(record, DnsFreeRecordList);
}

static VOID WINAPI
ResolveCallback(DWORD status, PVOID context, PDNS_SERVICE_INSTANCE instance)
{
	ResolveContext* c = (ResolveContext*) context;
	if (status == ERROR_SUCCESS && instance != NULL)
	{
		char host[256];
		char rp[128] = "";
		char pdl[512] = "";
		ToUTF8(instance->pszHostName, host, sizeof(host));
		if (instance->ip4Address != NULL)
		{
			const unsigned char* a = (const unsigned char*) instance->ip4Address;
			snprintf(host, sizeof(host), "%u.%u.%u.%u", a[0], a[1], a[2], a[3]);
		}
		for (DWORD i = 0; i < instance->dwPropertyCount; i++)
		{
			char key[64], value[512];
			ToUTF8(instance->keys[i], key, sizeof(key));
			ToUTF8(instance->values[i], value, sizeof(value));
			if (strcmp(key, "rp") == 0)
				snprintf(rp, sizeof(rp), "%s", value);
			else if (strcmp(key, "pdl") == 0)
				snprintf(pdl, sizeof(pdl), "%s", value);
		}
		MakeURI(&c->fPrinter, host, instance->wPort, rp);
		Formats(pdl, &c->fPrinter);
		c->fGot = 1;
		DnsServiceFreeInstance(instance);
	}
	SetEvent(c->fDone);
}

static void
PlatformBrowse(void)
{
	{
		std::lock_guard<std::mutex> hold(gInstancesLock);
		gInstanceCount = 0;
	}
	DNS_SERVICE_BROWSE_REQUEST request;
	memset(&request, 0, sizeof(request));
	request.Version = DNS_QUERY_REQUEST_VERSION1;
	request.InterfaceIndex = 0;
	request.QueryName = L"_ipp._tcp.local";
	request.pBrowseCallback = BrowseCallback;
	request.pQueryContext = NULL;
	DNS_SERVICE_CANCEL cancel;
	memset(&cancel, 0, sizeof(cancel));
	if (DnsServiceBrowse(&request, &cancel) != DNS_REQUEST_PENDING)
		return;
	Sleep(2000);			// (mDNS answers come within a second or so)
	DnsServiceBrowseCancel(&cancel);
	int count;
	{
		std::lock_guard<std::mutex> hold(gInstancesLock);
		count = gInstanceCount;
	}
	for (int i = 0; i < count; i++)
	{
		WCHAR wide[256];
		if (MultiByteToWideChar(CP_UTF8, 0, gInstances[i], -1, wide, 256) == 0)
			continue;
		ResolveContext context;
		memset(&context, 0, sizeof(context));
		context.fDone = CreateEventW(NULL, TRUE, FALSE, NULL);
		// the instance's name is the part before "._ipp._tcp.local"
		snprintf(context.fPrinter.fName, sizeof(context.fPrinter.fName), "%s", gInstances[i]);
		char* dot = strstr(context.fPrinter.fName, "._ipp.");
		if (dot != NULL)
			*dot = 0;
		DNS_SERVICE_RESOLVE_REQUEST resolve;
		memset(&resolve, 0, sizeof(resolve));
		resolve.Version = DNS_QUERY_REQUEST_VERSION1;
		resolve.QueryName = wide;
		resolve.pResolveCompletionCallback = ResolveCallback;
		resolve.pQueryContext = &context;
		DNS_SERVICE_CANCEL resolveCancel;
		memset(&resolveCancel, 0, sizeof(resolveCancel));
		if (DnsServiceResolve(&resolve, &resolveCancel) == DNS_REQUEST_PENDING)
		{
			if (WaitForSingleObject(context.fDone, 3000) != WAIT_OBJECT_0)
			{
				DnsServiceResolveCancel(&resolveCancel);
				WaitForSingleObject(context.fDone, 1000);
			}
			if (context.fGot)
				Found(&context.fPrinter);
		}
		CloseHandle(context.fDone);
	}
}

#elif defined(__linux__) || defined(__FreeBSD__) || defined(__NetBSD__) || defined(__OpenBSD__)

/*------------------------------------------------------------------------------
	L i n u x   a n d   t h e   B S D s :   a v a h i - b r o w s e
------------------------------------------------------------------------------*/

// avahi-browse's parsable output escapes a byte as \DDD (decimal)
static void
Unescape(char* s)
{
	char* out = s;
	while (*s != 0)
	{
		if (s[0] == '\\' && s[1] >= '0' && s[1] <= '9' && s[2] >= '0' && s[2] <= '9' && s[3] >= '0' && s[3] <= '9')
		{
			*out++ = (char) ((s[1] - '0') * 100 + (s[2] - '0') * 10 + (s[3] - '0'));
			s += 4;
		}
		else
			*out++ = *s++;
	}
	*out = 0;
}

static void
PlatformBrowse(void)
{
	FILE* avahi = popen("avahi-browse --resolve --parsable --terminate _ipp._tcp 2>/dev/null", "r");
	int found = 0;
	if (avahi != NULL)
	{
		char line[2048];
		while (fgets(line, sizeof(line), avahi) != NULL)
		{
			// =;interface;protocol;name;type;domain;host;address;port;txt
			if (line[0] != '=')
				continue;
			char* fields[10];
			int n = 0;
			char* p = line;
			while (n < 10)
			{
				fields[n++] = p;
				char* semi = (n < 10) ? strchr(p, ';') : NULL;
				if (semi == NULL)
					break;
				*semi = 0;
				p = semi + 1;
			}
			if (n < 10 || strcmp(fields[2], "IPv4") != 0)
				continue;
			HostDNSSDPrinter printer;
			memset(&printer, 0, sizeof(printer));
			Unescape(fields[3]);
			snprintf(printer.fName, sizeof(printer.fName), "%s", fields[3]);
			const char* txt = fields[9];
			char rp[128] = "";
			const char* r = strstr(txt, "\"rp=");
			if (r != NULL)
			{
				r += 4;
				size_t k = 0;
				while (*r != 0 && *r != '"' && k + 1 < sizeof(rp))
					rp[k++] = *r++;
				rp[k] = 0;
			}
			const char* pdl = strstr(txt, "\"pdl=");
			Formats(pdl != NULL ? pdl : "", &printer);
			MakeURI(&printer, fields[7], atoi(fields[8]), rp);
			Found(&printer);
			found++;
		}
		pclose(avahi);
	}
	// no avahi-browse, or it found nothing (the reMarkable found none): the
	// question asked on the link
	if (found == 0)
		HostDNSSDQueryMDNS(2500);
}

#else

// (ESP-IDF on the T-Deck Pro, and any other host without a browse)
static void
PlatformBrowse(void)
{
	HostDNSSDQueryMDNS(2500);
}

#endif


/*------------------------------------------------------------------------------
	T h e   l o o k u p
------------------------------------------------------------------------------*/

void
HostDNSSDStart(void)
{
	char* injected;
	{
		std::lock_guard<std::mutex> hold(gLock);
		if (gBusy)
			return;
		if (!gInjectionLooked)
		{
			const char* list = getenv("NEWTON_FOUND_PRINTERS");
			gInjected = (list != NULL && list[0] != 0) ? strdup(list) : NULL;
			gInjectionLooked = 1;
		}
		gFoundCount = 0;
		injected = gInjected != NULL ? strdup(gInjected) : NULL;
		if (injected == NULL)
			gBusy = 1;
	}
	if (injected != NULL)
	{
		TakeInjected(injected);
		free(injected);
		return;
	}
	std::thread([]() {
		PlatformBrowse();
		std::lock_guard<std::mutex> hold(gLock);
		gBusy = 0;
	}).detach();
}


int
HostDNSSDBusy(void)
{
	std::lock_guard<std::mutex> hold(gLock);
	return gBusy;
}


int
HostDNSSDCount(void)
{
	std::lock_guard<std::mutex> hold(gLock);
	return gFoundCount;
}


int
HostDNSSDGet(int index, HostDNSSDPrinter* printer)
{
	std::lock_guard<std::mutex> hold(gLock);
	if (index < 0 || index >= gFoundCount)
		return 0;
	*printer = gFound[index];
	return 1;
}


int
HostDNSSDFind(const char* name, HostDNSSDPrinter* printer)
{
	std::lock_guard<std::mutex> hold(gLock);
	for (int i = 0; i < gFoundCount; i++)
		if (strcmp(gFound[i].fName, name) == 0)
		{
			*printer = gFound[i];
			return 1;
		}
	return 0;
}


int
HostDNSSDResolve(const char* name, HostDNSSDPrinter* printer, int milliseconds)
{
	if (HostDNSSDFind(name, printer))
		return 1;
	if (!HostDNSSDBusy())
		HostDNSSDStart();
	for (int waited = 0; waited < milliseconds; waited += 50)
	{
		if (HostDNSSDFind(name, printer))
			return 1;
		if (!HostDNSSDBusy())
			break;
		std::this_thread::sleep_for(std::chrono::milliseconds(50));
	}
	return HostDNSSDFind(name, printer);
}
