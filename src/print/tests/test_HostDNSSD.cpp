/*
	File:		print/tests/test_HostDNSSD.cpp

	Contains:	Tests of the host's DNS-SD layer (print/host/dnssd/HostDNSSD.h):
				an injected list taken as found (names, URIs, formats, a
				lookup by name, a lookup started again), canned mDNS answers
				taken as the mDNS question takes them (NEWTON_TEST_MDNS=1
				asks the real link too), and a real browse
				of the local network, which must finish within its time
				whatever it finds (ctest print.HostDNSSD).
*/

#include "HostDNSSD.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <chrono>
#include <thread>

static int gFailures = 0;

static void
Check(bool ok, const char* what)
{
	printf("%s: %s\n", ok ? "ok" : "FAILED", what);
	if (!ok)
		gFailures++;
}


static void
TestInjected(void)
{
	HostDNSSDInject("Office Laser|ipp://10.0.0.5:631/ipp/print|ps,pcl;Hall Inkjet|ipp://10.0.0.6:8631/printers/hall|pcl;Plotter|ipp://10.0.0.7:631/ipp/print|");
	HostDNSSDStart();
	Check(!HostDNSSDBusy(), "an injected list is found at once");
	Check(HostDNSSDCount() == 3, "three printers found");
	HostDNSSDPrinter p;
	Check(HostDNSSDGet(0, &p) && strcmp(p.fName, "Office Laser") == 0
		&& strcmp(p.fURI, "ipp://10.0.0.5:631/ipp/print") == 0 && p.fPostScript && p.fPCL, "the first: PostScript and PCL");
	Check(HostDNSSDGet(1, &p) && strcmp(p.fName, "Hall Inkjet") == 0 && !p.fPostScript && p.fPCL, "the second: PCL only");
	Check(HostDNSSDGet(2, &p) && !p.fPostScript && !p.fPCL, "the third: neither");
	Check(!HostDNSSDGet(3, &p), "nothing beyond them");
	Check(HostDNSSDFind("Hall Inkjet", &p) && strcmp(p.fURI, "ipp://10.0.0.6:8631/printers/hall") == 0, "found by name");
	Check(!HostDNSSDFind("Office", &p), "a name must be whole");
	Check(HostDNSSDResolve("Office Laser", &p, 100), "resolved by name");
	Check(!HostDNSSDResolve("Nobody", &p, 100), "an unknown name is not resolved");
	HostDNSSDInject("Other|ipp://10.0.0.9:631/ipp/print|ps");
	HostDNSSDStart();
	Check(HostDNSSDCount() == 1 && HostDNSSDGet(0, &p) && strcmp(p.fName, "Other") == 0, "a lookup started again forgets the last");
}


// a canned mDNS answer, made as a responder would
static unsigned char gPacket[2][600];
static int gPacketSize[2];

static int
Label(unsigned char* p, const char* text)
{
	int n = (int) strlen(text);
	p[0] = (unsigned char) n;
	memcpy(p + 1, text, (size_t) n);
	return n + 1;
}

static int
Record(unsigned char* p, int type, const unsigned char* data, int length)
{
	p[0] = (unsigned char) (type >> 8); p[1] = (unsigned char) type;
	p[2] = 0x80; p[3] = 1;											// IN, cache flush
	p[4] = 0; p[5] = 0; p[6] = 0x11; p[7] = 0x94;					// TTL 4500
	p[8] = (unsigned char) (length >> 8); p[9] = (unsigned char) length;
	memcpy(p + 10, data, (size_t) length);
	return 10 + length;
}

static void
TestMDNSAnswers(void)
{
	// one: PTR, SRV, TXT and A, the instance's label holding a dot, names compressed
	unsigned char* p = gPacket[0];
	memset(p, 0, 12);
	p[2] = 0x84;													// a response, authoritative
	p[7] = 4;														// four answers
	int n = 12;
	int service = n;												// _ipp._tcp.local
	n += Label(p + n, "_ipp"); n += Label(p + n, "_tcp"); n += Label(p + n, "local"); p[n++] = 0;
	unsigned char data[200];
	int k = Label(data, "Office.Laser");
	data[k++] = 0xC0; data[k++] = (unsigned char) service;
	n += Record(p + n, 12, data, k);								// PTR
	int instance = n - k;
	unsigned char srv[64] = { 0, 0, 0, 0, 0x02, 0x77 };				// port 631
	k = 6 + Label(srv + 6, "laser");
	srv[k++] = 0xC0; srv[k++] = (unsigned char) (service + 10);		// .local
	p[n++] = 0xC0; p[n++] = (unsigned char) instance;
	n += Record(p + n, 33, srv, k);									// SRV
	int host = n - k + 6;
	const char* txt[] = { "txtvers=1", "rp=ipp/print", "pdl=application/octet-stream,application/postscript" };
	k = 0;
	for (int i = 0; i < 3; i++)
		k += Label(data + k, txt[i]);
	p[n++] = 0xC0; p[n++] = (unsigned char) instance;
	n += Record(p + n, 16, data, k);								// TXT
	const unsigned char address[4] = { 10, 0, 0, 5 };
	p[n++] = 0xC0; p[n++] = (unsigned char) host;
	n += Record(p + n, 1, address, 4);								// A
	gPacketSize[0] = n;

	// two: PTR and SRV only - the address it answered from is taken
	p = gPacket[1];
	memset(p, 0, 12);
	p[2] = 0x84;
	p[7] = 2;
	n = 12;
	service = n;
	n += Label(p + n, "_ipp"); n += Label(p + n, "_tcp"); n += Label(p + n, "local"); p[n++] = 0;
	k = Label(data, "Hall Inkjet");
	data[k++] = 0xC0; data[k++] = (unsigned char) service;
	n += Record(p + n, 12, data, k);
	instance = n - k;
	unsigned char srv2[64] = { 0, 0, 0, 0, 0x21, 0xB7 };			// port 8631
	k = 6 + Label(srv2 + 6, "hall");
	srv2[k++] = 0xC0; srv2[k++] = (unsigned char) (service + 10);
	p[n++] = 0xC0; p[n++] = (unsigned char) instance;
	n += Record(p + n, 33, srv2, k);
	gPacketSize[1] = n;

	const unsigned char* packets[2] = { gPacket[0], gPacket[1] };
	unsigned char from[4] = { 10, 0, 0, 6 };
	unsigned long source;
	unsigned int word;
	memcpy(&word, from, 4);
	source = word;
	const unsigned long sources[2] = { 0, source };
	Check(HostDNSSDTakeMDNSAnswers(packets, gPacketSize, sources, 2) == 2, "mDNS: two printers in the answers");
	HostDNSSDPrinter printer;
	Check(HostDNSSDFind("Office.Laser", &printer) && strcmp(printer.fURI, "ipp://10.0.0.5:631/ipp/print") == 0
		&& printer.fPostScript && !printer.fPCL, "mDNS: a whole answer (a dot in its name, PostScript)");
	Check(HostDNSSDFind("Hall Inkjet", &printer) && strcmp(printer.fURI, "ipp://10.0.0.6:8631/ipp/print") == 0,
		"mDNS: no address record - the address it answered from, the default path");
	unsigned char damaged[40];
	memcpy(damaged, gPacket[0], sizeof(damaged));
	const unsigned char* bad[1] = { damaged };
	int badSize[1] = { (int) sizeof(damaged) };
	Check(HostDNSSDTakeMDNSAnswers(bad, badSize, sources, 1) == 0, "mDNS: a cut-off answer is no printer");
}


// the question asked on the real link (NEWTON_TEST_MDNS=1: the network may
// well have no printer, so only that it finishes is checked)
static void
TestMDNSQuery(void)
{
	const char* wanted = getenv("NEWTON_TEST_MDNS");
	if (wanted == NULL || wanted[0] != '1')
		return;
	int before = HostDNSSDCount();
	int found = HostDNSSDQueryMDNS(2500);
	printf("the mDNS question found %d IPP printer(s)\n", found);
	HostDNSSDPrinter p;
	for (int i = before; HostDNSSDGet(i, &p); i++)
		printf("  %s at %s%s%s\n", p.fName, p.fURI, p.fPostScript ? " (PostScript)" : "", p.fPCL ? " (PCL)" : "");
}


// the host's own browse: whatever the network has, it finishes
static void
TestBrowse(void)
{
	HostDNSSDInject(NULL);
	HostDNSSDStart();
	int waited = 0;
	while (HostDNSSDBusy() && waited < 15000)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(50));
		waited += 50;
	}
	Check(!HostDNSSDBusy(), "a real browse finishes");
	printf("the local network has %d IPP printer(s)\n", HostDNSSDCount());
	HostDNSSDPrinter p;
	for (int i = 0; HostDNSSDGet(i, &p); i++)
		printf("  %s at %s%s%s\n", p.fName, p.fURI, p.fPostScript ? " (PostScript)" : "", p.fPCL ? " (PCL)" : "");
}


int
main()
{
	TestInjected();
	TestMDNSAnswers();
	TestMDNSQuery();
	TestBrowse();
	if (gFailures == 0)
		printf("test_HostDNSSD: all passed\n");
	else
		printf("test_HostDNSSD: %d FAILED\n", gFailures);
	return gFailures != 0;
}
