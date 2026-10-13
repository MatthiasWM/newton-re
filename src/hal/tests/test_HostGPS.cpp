// The GPS receiver (hal/host/HostGPS.h): its sentences checked against
// NMEA 0183's own examples and worked out by hand, its parsing read back,
// the pretend sources' specs; then the receiver itself, run - a fixed one's
// sentences each second, a Tripmate's ASTRAL until answered and the
// sentences $PRWIILOG switches off, and (test_HostGPS replay, ctest
// hal.GPSReplay) a log replayed a cycle a second.  Its use by GPS software
// is the ctests host.NewtonAppGPS*.

#include "HostGPS.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <chrono>
#include <thread>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)

static bool
Near(double a, double b, double within)
{
	return fabs(a - b) <= within;
}


static void
TestChecksums()
{
	// NMEA's own examples, with the checksums they are given with
	EXPECT(HostGPSChecksum("$GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A") == 0x6A);
	EXPECT(HostGPSChecksum("$GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47") == 0x47);
}


static void
TestParse()
{
	HostGPSFix fix;
	memset(&fix, 0, sizeof(fix));
	EXPECT(HostGPSParse("$GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A\r\n", &fix));
	EXPECT(fix.valid);
	EXPECT(Near(fix.latitude, 48 + 7.038 / 60, 1e-9) && Near(fix.longitude, 11 + 31.0 / 60, 1e-9));
	EXPECT(Near(fix.knots, 22.4, 1e-9) && Near(fix.course, 84.4, 1e-9));
	// 1994-03-23 12:35:19 UTC
	EXPECT(fix.time == 764426119LL);
	EXPECT(HostGPSParse("$GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47", &fix));
	EXPECT(fix.satellites == 8 && Near(fix.hdop, 0.9, 1e-9) && Near(fix.altitude, 545.4, 1e-9));
	EXPECT(fix.time == 764426119LL);
	// a checksum that does not add up is not read
	HostGPSFix other = fix;
	EXPECT(!HostGPSParse("$GPRMC,123519,A,4807.038,S,01131.000,W,022.4,084.4,230394,003.1,W*6B", &other));
	EXPECT(other.latitude == fix.latitude);
	// south and west; no fix
	EXPECT(HostGPSParse("$GPGLL,3748.816,S,14457.786,W,010203,A", &fix));
	EXPECT(Near(fix.latitude, -(37 + 48.816 / 60), 1e-9) && Near(fix.longitude, -(144 + 57.786 / 60), 1e-9));
	EXPECT(HostGPSParse("$GPRMC,010203,V,,,,,,,230394,,", &fix) && !fix.valid);
	EXPECT(!HostGPSParse("$PGRMO,,2", &fix));
}


static void
TestSentences()
{
	HostGPSFix fix;
	memset(&fix, 0, sizeof(fix));
	fix.valid = true;
	fix.latitude = -(37 + 48.816 / 60);
	fix.longitude = 144 + 57.786 / 60;
	fix.altitude = 31;
	fix.knots = 5;
	fix.course = 99.5;
	fix.satellites = 8;
	fix.hdop = 0.9;
	fix.time = 764426119LL;					// 1994-03-23 12:35:19
	char out[1024];
	long n = HostGPSSentences(&fix, 1, out, sizeof(out));
	EXPECT(n == (long) strlen(out));
	EXPECT(strstr(out, "$GPGGA,123519,3748.816,S,14457.786,E,1,08,0.9,31.0,M,0.0,M,,*") == out);
	EXPECT(strstr(out, "$GPRMC,123519,A,3748.816,S,14457.786,E,005.0,099.5,230394,,*") != NULL);
	EXPECT(strstr(out, "$GPGLL,3748.816,S,14457.786,E,123519,A*") != NULL);
	EXPECT(strstr(out, "$GPVTG,099.5,T,,M,005.0,N,009.3,K*") != NULL);
	EXPECT(strstr(out, "$GPGSA") == NULL);	// (every fifth second only)
	// each line checks, and reads back
	HostGPSFix back;
	memset(&back, 0, sizeof(back));
	int lines = 0;
	for (char* p = out; *p; lines++)
	{
		char* e = strstr(p, "\r\n");
		EXPECT(e != NULL);
		if (e == NULL)
			break;
		char line[128];
		memcpy(line, p, e - p);
		line[e - p] = 0;
		char* star = strrchr(line, '*');
		EXPECT(star != NULL && strtoul(star + 1, NULL, 16) == HostGPSChecksum(line));
		HostGPSParse(line, &back);
		p = e + 2;
	}
	EXPECT(lines == 4);
	EXPECT(back.valid && Near(back.latitude, fix.latitude, 1e-6) && Near(back.longitude, fix.longitude, 1e-6) && back.time == fix.time);
	n = HostGPSSentences(&fix, 5, out, sizeof(out));
	EXPECT(strstr(out, "$GPGSA,A,3,02,05,09,12,15,18,21,25,,,,,1.4,0.9,1.2*") != NULL);
	EXPECT(strstr(out, "$GPGSV,2,1,08,02,62,047,46,") != NULL && strstr(out, "$GPGSV,2,2,08,") != NULL);
	// no fix: the fields empty, the status V
	fix.valid = false;
	HostGPSSentences(&fix, 1, out, sizeof(out));
	EXPECT(strstr(out, "$GPRMC,123519,V,,,,,,,230394,,*") != NULL);
	EXPECT(strstr(out, "$GPGGA,123519,,,,,0,00,") != NULL);
}


static void
TestSpecs()
{
	bool moving;
	double lat = 0, lon = 0, third = -1;
	EXPECT(HostGPSParsePretend("sim", &moving, &lat, &lon, &third) && moving && third == -1);
	EXPECT(HostGPSParsePretend("fixed:-37.8136,144.9631,31", &moving, &lat, &lon, &third) && !moving);
	EXPECT(lat == -37.8136 && lon == 144.9631 && third == 31);
	EXPECT(HostGPSParsePretend("sim:51.4779,-0.0015,4", &moving, &lat, &lon, &third) && moving && third == 4);
	EXPECT(!HostGPSParsePretend("fixed:91,0", &moving, &lat, &lon, &third));
	EXPECT(!HostGPSParsePretend("fixed:12", &moving, &lat, &lon, &third));
	EXPECT(!HostGPSParsePretend("simulated", &moving, &lat, &lon, &third));
	EXPECT(!HostGPSParsePretend("nmea:x.log", &moving, &lat, &lon, &third));
}


// what the receiver says over the next ms milliseconds
static void
Listen(long ms, char* out, long size)
{
	long used = 0;
	auto until = std::chrono::steady_clock::now() + std::chrono::milliseconds(ms);
	while (std::chrono::steady_clock::now() < until)
	{
		used += HostGPSRead((unsigned char*) out + used, size - 1 - used);
		std::this_thread::sleep_for(std::chrono::milliseconds(50));
	}
	out[used] = 0;
}


static void
TestReceiver()
{
	char why[160];
	EXPECT(HostGPSStart("fixed:-37.8136,144.9631,31", why, sizeof(why)));
	EXPECT(!HostGPSStart("sim", why, sizeof(why)));		// (once only)
	char out[4096];
	// unplugged, it says nothing anyone hears
	Listen(1200, out, sizeof(out));
	EXPECT(out[0] == 0);
	HostGPSPlug(true);
	Listen(2200, out, sizeof(out));
	EXPECT(strstr(out, "$GPRMC,") != NULL && strstr(out, ",A,3748.816,S,14457.786,E,000.0,") != NULL);
	EXPECT(strstr(out, "$GPGGA,") != NULL && strstr(out, ",1,08,0.9,31.0,M,") != NULL);
	HostGPSWrite("$PGRMO,,2\r\n", 11);	// (an NMEA receiver ignores what it is sent)
	HostGPSFix fix;
	HostGPSStatus(&fix);
	EXPECT(fix.valid && Near(fix.latitude, -37.8136, 1e-9));
	// moved
	EXPECT(HostGPSSetPosition(51.4779, -0.0015, 46, 0, 0));
	Listen(2200, out, sizeof(out));
	EXPECT(strstr(out, ",5128.674,N,00000.090,W,") != NULL);

	// a Tripmate: ASTRAL until answered, then its sentences - not those
	// it is told to leave out
	HostGPSSetKind(kHostGPSTripmate);
	HostGPSPlug(true);
	Listen(2200, out, sizeof(out));
	EXPECT(strstr(out, "ASTRAL\r\n") != NULL && strstr(out, "$GP") == NULL);
	const char* answer = "ASTRAL\r\n$PRWIILOG,GGA,V,,,\r\n$PRWIILOG,GSV,V,,,\r\n";
	HostGPSWrite(answer, (long) strlen(answer));
	// (an ASTRAL said just before the answer was heard is still waiting)
	while (HostGPSRead((unsigned char*) out, sizeof(out)) > 0)
		;
	Listen(2200, out, sizeof(out));
	EXPECT(strstr(out, "$GPRMC,") != NULL && strstr(out, "$GPGGA") == NULL && strstr(out, "$GPGLL") == NULL);
	EXPECT(strstr(out, "ASTRAL") == NULL);
	HostGPSWrite("$PRWIIRST,\r\n", 12);		// (started over)
	Listen(1500, out, sizeof(out));
	EXPECT(strstr(out, "ASTRAL\r\n") != NULL);
	HostGPSPlug(false);
}


// a log of two cycles (RMC first, then GGA), replayed a cycle a second
static void
TestReplay()
{
	const char* path = "test_HostGPS_replay.nmea";
	FILE* f = fopen(path, "wb");
	EXPECT(f != NULL);
	if (f == NULL)
		return;
	fputs("$GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A\r\n"
		  "$GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47\r\n"
		  "noise\r\n"
		  "$GPRMC,123520,A,4807.040,N,01131.000,E,022.4,084.4,230394,003.1,W*61\r\n", f);
	fclose(f);
	char why[160];
	char spec[200];
	snprintf(spec, sizeof(spec), "nmea:%s", path);
	EXPECT(HostGPSStart(spec, why, sizeof(why)));
	HostGPSPlug(true);
	char out[4096];
	Listen(3300, out, sizeof(out));
	// each cycle in its own second, the noise left out, round again
	EXPECT(strstr(out, "$GPRMC,123519,") != NULL && strstr(out, "$GPRMC,123520,") != NULL);
	EXPECT(strstr(out, "noise") == NULL);
	EXPECT(strstr(out, "$GPRMC,123520,A,4807.040,N,01131.000,E,022.4,084.4,230394,003.1,W*61\r\n$GPRMC,123519,") != NULL);
	HostGPSFix fix;
	HostGPSStatus(&fix);
	EXPECT(fix.valid && fix.satellites == 8 && Near(fix.altitude, 545.4, 1e-9));
	remove(path);
}


int
main(int argc, char** argv)
{
	if (argc > 1 && strcmp(argv[1], "replay") == 0)
		TestReplay();
	else
	{
		TestChecksums();
		TestParse();
		TestSentences();
		TestSpecs();
		TestReceiver();
	}
	if (failures == 0)
		printf("test_HostGPS: all passed\n");
	return failures == 0 ? 0 : 1;
}
