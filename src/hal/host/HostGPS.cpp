/*
	File:		hal/host/HostGPS.cpp

	Contains:	The host's GPS receiver (HostGPS.h): one thread making or
				passing on NMEA 0183 sentences, a buffer of what it has
				said that the serial port reads, and what the Newton sends
				it heard a line at a time.

	Host code (no ROM counterpart).  The sentences are NMEA 0183 version
	2.0's, as the receivers of the Newton's day sent them (a Garmin 12's:
	whole seconds, minutes of arc to three places, no mode indicator), so
	that software written against those reads them; the Tripmate's
	commands are DeLorme's, as GPS View (fixtures/packages/apps/GPSView)
	sends them.
*/

#include "HostGPS.h"
#include "HostSockets.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <time.h>
#include <atomic>
#include <chrono>
#include <thread>
#include <mutex>

// (a receiver on a host serial port: Windows' COM ports, POSIX terminals;
// a board's own receiver would be a source of its own - ESP-IDF builds
// without it)
#if defined(ESP_PLATFORM)
#define HOST_GPS_NO_SERIAL 1
#elif defined(_WIN32)
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#include <fcntl.h>
#include <termios.h>
#include <unistd.h>
#include <poll.h>
#endif

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

const long		kOutSize = 4096;			// what the receiver has said and the port not yet read
const long		kLineSize = 120;			// a sentence (NMEA's are 82 at most)
const long		kFileLimit = 8 * 1024 * 1024;
const double	kMetresPerDegree = 111320.0;
const double	kSimRadius = 500.0;			// the pretend receiver's circle, metres
const double	kKnot = 1852.0 / 3600.0;	// metres a second

enum SourceKind { kSourceNone, kSourceSim, kSourceFixed, kSourceFile, kSourceTCP, kSourceGPSD, kSourceSerial };

static long long
Millis(void)
{
	return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

static long long
WallMillis(void)
{
	return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
}


/*------------------------------------------------------------------------------
	The state: written by the receiver's thread and the port's, under gLock
------------------------------------------------------------------------------*/

static std::mutex		gLock;
static std::atomic<bool> gStarted(false);
static char				gSpec[kHostGPSSourceSize] = "";
static SourceKind		gSource = kSourceNone;
static HostGPSKind		gKind = kHostGPSNMEA;
static bool				gPlugged = false;
static unsigned char	gOut[kOutSize];
static long				gOutHead = 0, gOutCount = 0;
static HostGPSFix		gFix;
// the pretend source: where it is (the circle's centre for sim), how fast
// it goes and which way (fixed), and when it set off
static double			gLatitude = -37.8136, gLongitude = 144.9631, gAltitude = 31.0;
static double			gKnots = 10.0, gCourse = 0.0;
static long long		gSetOff = 0;
// the Tripmate: answered ASTRAL yet; the sentences it sends ($PRWIILOG)
static bool				gAstral = false;
static char				gLogged[16][4];
static int				gLoggedCount = 0;
// what the Newton sent, a line at a time
static char				gIn[kLineSize];
static long				gInCount = 0;
// sent on to a real receiver (a serial or TCP source), for its thread
static unsigned char	gPassOn[1024];
static long				gPassOnCount = 0;


// what the receiver says, as the port will read it (the oldest dropped when
// nobody reads it); called with gLock held
static void
Say(const char* text, long length)
{
	if (!gPlugged)
		return;
	for (long i = 0; i < length; i++)
	{
		if (gOutCount == kOutSize)
		{
			gOutHead = (gOutHead + 1) % kOutSize;
			gOutCount--;
		}
		gOut[(gOutHead + gOutCount) % kOutSize] = (unsigned char) text[i];
		gOutCount++;
	}
}


// the Tripmate's power-up: ASTRAL until answered, then the default sentences
static void
TripmateReset(void)
{
	static const char* const kDefaults[] = { "GGA", "GSA", "GSV", "RMC" };
	gAstral = false;
	gLoggedCount = 0;
	for (const char* d : kDefaults)
		strcpy(gLogged[gLoggedCount++], d);
}

static bool
TripmateLogs(const char* type)
{
	for (int i = 0; i < gLoggedCount; i++)
		if (strncmp(gLogged[i], type, 3) == 0)
			return true;
	return false;
}

static void
TripmateLog(const char* type, bool on)
{
	for (int i = 0; i < gLoggedCount; i++)
		if (strncmp(gLogged[i], type, 3) == 0)
		{
			if (!on)
			{
				memmove(gLogged[i], gLogged[i + 1], (gLoggedCount - i - 1) * sizeof(gLogged[0]));
				gLoggedCount--;
			}
			return;
		}
	if (on && gLoggedCount < 16)
	{
		memcpy(gLogged[gLoggedCount], type, 3);
		gLogged[gLoggedCount++][3] = 0;
	}
}


// a sentence the receiver says (a whole line, CR LF ended): all of them from
// an NMEA receiver, from a Tripmate only once it has been answered and only
// the kinds it logs; called with gLock held
static void
SaySentence(const char* line, long length)
{
	if (gKind == kHostGPSTripmate)
	{
		if (!gAstral || length < 6 || line[0] != '$' || !TripmateLogs(line + 3))
			return;
	}
	Say(line, length);
}


// a line the Newton sent; called with gLock held
static void
Heard(const char* line)
{
	if (gKind != kHostGPSTripmate)
		return;							// (an NMEA receiver's init string: heard, ignored)
	if (strstr(line, "ASTRAL") != NULL)
	{
		gAstral = true;
		return;
	}
	if (strncmp(line, "$PRWIIRST", 9) == 0)
	{
		TripmateReset();
		return;
	}
	if (strncmp(line, "$PRWIILOG,", 10) == 0 && strlen(line) >= 15)
		TripmateLog(line + 10, line[14] == 'A');
}


/*------------------------------------------------------------------------------
	Sentences
------------------------------------------------------------------------------*/

unsigned
HostGPSChecksum(const char* sentence)
{
	const char* p = sentence;
	if (*p == '$' || *p == '!')
		p++;
	unsigned sum = 0;
	while (*p && *p != '*' && *p != '\r' && *p != '\n')
		sum ^= (unsigned char) *p++;
	return sum;
}


// body (without '$') made a sentence: $body*hh CR LF, appended at out[*used]
static void
Emit(char* out, long size, long* used, const char* body)
{
	char line[kLineSize + 8];
	snprintf(line, sizeof(line), "$%s", body);
	snprintf(line + strlen(line), sizeof(line) - strlen(line), "*%02X\r\n", HostGPSChecksum(line));
	long n = (long) strlen(line);
	if (*used + n < size)
	{
		memcpy(out + *used, line, n + 1);
		*used += n;
	}
}

static void
Angle(char* out, long size, double degrees, bool latitude)
{
	char hemisphere = latitude ? (degrees < 0 ? 'S' : 'N') : (degrees < 0 ? 'W' : 'E');
	degrees = fabs(degrees);
	int whole = (int) degrees;
	double minutes = (degrees - whole) * 60.0;
	if (minutes >= 59.9995)
	{
		whole++;
		minutes = 0;
	}
	snprintf(out, size, latitude ? "%02d%06.3f,%c" : "%03d%06.3f,%c", whole, minutes, hemisphere);
}

// the pretend receiver's satellites: PRN, elevation, azimuth, SNR
static const int kSatellites[8][4] = {
	{ 2, 62, 47, 46 }, { 5, 41, 132, 44 }, { 9, 27, 205, 40 }, { 12, 75, 290, 48 },
	{ 15, 18, 330, 36 }, { 18, 33, 88, 42 }, { 21, 12, 170, 33 }, { 25, 50, 250, 45 }
};

long
HostGPSSentences(const HostGPSFix* fix, long second, char* out, long size)
{
	long used = 0;
	if (size > 0)
		out[0] = 0;
	char body[kLineSize], hms[16], date[16], lat[24], lon[24];
	time_t t = (time_t) fix->time;
	struct tm utc;
#if defined(_WIN32)
	gmtime_s(&utc, &t);
#else
	gmtime_r(&t, &utc);
#endif
	snprintf(hms, sizeof(hms), "%02d%02d%02d", utc.tm_hour, utc.tm_min, utc.tm_sec);
	snprintf(date, sizeof(date), "%02d%02d%02d", utc.tm_mday, utc.tm_mon + 1, utc.tm_year % 100);
	if (fix->valid)
	{
		Angle(lat, sizeof(lat), fix->latitude, true);
		Angle(lon, sizeof(lon), fix->longitude, false);
	}
	else
	{
		strcpy(lat, ",");
		strcpy(lon, ",");
	}
	int used_sats = fix->valid ? fix->satellites : 0;
	if (fix->valid)
		snprintf(body, sizeof(body), "GPGGA,%s,%s,%s,1,%02d,%.1f,%.1f,M,0.0,M,,", hms, lat, lon, used_sats, fix->hdop, fix->altitude);
	else
		snprintf(body, sizeof(body), "GPGGA,%s,%s,%s,0,00,,,M,,M,,", hms, lat, lon);
	Emit(out, size, &used, body);
	snprintf(body, sizeof(body), "GPGLL,%s,%s,%s,%c", lat, lon, hms, fix->valid ? 'A' : 'V');
	Emit(out, size, &used, body);
	if (fix->valid)
		snprintf(body, sizeof(body), "GPRMC,%s,A,%s,%s,%05.1f,%05.1f,%s,,", hms, lat, lon, fix->knots, fix->course, date);
	else
		snprintf(body, sizeof(body), "GPRMC,%s,V,%s,%s,,,%s,,", hms, lat, lon, date);
	Emit(out, size, &used, body);
	if (fix->valid)
		snprintf(body, sizeof(body), "GPVTG,%05.1f,T,,M,%05.1f,N,%05.1f,K", fix->course, fix->knots, fix->knots * 1.852);
	else
		snprintf(body, sizeof(body), "GPVTG,,T,,M,,N,,K");
	Emit(out, size, &used, body);
	if (second % 5 == 0)
	{
		// the satellites used and those in view
		snprintf(body, sizeof(body), "GPGSA,A,%d", fix->valid ? 3 : 1);
		for (int i = 0; i < 12; i++)
			if (i < used_sats && i < 8)
				snprintf(body + strlen(body), sizeof(body) - strlen(body), ",%02d", kSatellites[i][0]);
			else
				strcat(body, ",");
		if (fix->valid)
			snprintf(body + strlen(body), sizeof(body) - strlen(body), ",%.1f,%.1f,%.1f", fix->hdop * 1.6, fix->hdop, fix->hdop * 1.3);
		else
			strcat(body, ",,,");
		Emit(out, size, &used, body);
		for (int m = 0; m < 2; m++)
		{
			snprintf(body, sizeof(body), "GPGSV,2,%d,08", m + 1);
			for (int i = 4 * m; i < 4 * m + 4; i++)
				snprintf(body + strlen(body), sizeof(body) - strlen(body), ",%02d,%02d,%03d,%02d", kSatellites[i][0], kSatellites[i][1], kSatellites[i][2],
						 fix->valid ? kSatellites[i][3] : 0);
			Emit(out, size, &used, body);
		}
	}
	return used;
}


// a sentence's fields, split at the commas (and the '*'): ==> how many
static int
Fields(const char* sentence, char fields[][24], int most)
{
	int n = 0;
	const char* p = sentence;
	while (n < most)
	{
		int k = 0;
		while (*p && *p != ',' && *p != '*' && *p != '\r' && *p != '\n')
		{
			if (k < 23)
				fields[n][k++] = *p;
			p++;
		}
		fields[n++][k] = 0;
		if (*p != ',')
			break;
		p++;
	}
	return n;
}

static bool
ParseAngle(const char* value, const char* hemisphere, double* degrees)
{
	if (value[0] == 0 || hemisphere[0] == 0)
		return false;
	double v = atof(value);
	double whole = floor(v / 100.0);
	double d = whole + (v - whole * 100.0) / 60.0;
	if (hemisphere[0] == 'S' || hemisphere[0] == 'W')
		d = -d;
	*degrees = d;
	return true;
}

// hhmmss[.ss] put into the fix's time of day (on its date, today's if none)
static void
ParseTime(const char* hms, HostGPSFix* fix)
{
	if (strlen(hms) < 6)
		return;
	int h = (hms[0] - '0') * 10 + (hms[1] - '0');
	int m = (hms[2] - '0') * 10 + (hms[3] - '0');
	double s = atof(hms + 4);
	long long day = fix->time != 0 ? fix->time - fix->time % 86400 : (WallMillis() / 1000) / 86400 * 86400;
	fix->time = day + h * 3600 + m * 60 + (long long) s;
	fix->millis = (int) ((s - floor(s)) * 1000.0 + 0.5);
}

// days since 1970 of a date (the civil calendar)
static long long
DaysFromCivil(int y, int m, int d)
{
	y -= m <= 2;
	long long era = (y >= 0 ? y : y - 399) / 400;
	long long yoe = y - era * 400;
	long long doy = (153 * (m + (m > 2 ? -3 : 9)) + 2) / 5 + d - 1;
	long long doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
	return era * 146097 + doe - 719468;
}

bool
HostGPSParse(const char* sentence, HostGPSFix* fix)
{
	if (sentence[0] != '$' || strlen(sentence) < 7)
		return false;
	const char* star = strchr(sentence, '*');
	if (star != NULL)
	{
		unsigned given = (unsigned) strtoul(star + 1, NULL, 16);
		if (given != HostGPSChecksum(sentence))
			return false;
	}
	char f[20][24];
	int n = Fields(sentence + 1, f, 20);
	const char* type = f[0] + 2;		// (after the talker: GP, GN, ...)
	if (strlen(f[0]) != 5)
		return false;
	if (strcmp(type, "RMC") == 0 && n >= 10)
	{
		fix->valid = f[2][0] == 'A';
		if (strlen(f[9]) == 6)
		{
			int d = (f[9][0] - '0') * 10 + (f[9][1] - '0');
			int m = (f[9][2] - '0') * 10 + (f[9][3] - '0');
			int y = (f[9][4] - '0') * 10 + (f[9][5] - '0');
			y += y < 80 ? 2000 : 1900;
			fix->time = DaysFromCivil(y, m, d) * 86400;
		}
		ParseTime(f[1], fix);
		if (fix->valid)
		{
			ParseAngle(f[3], f[4], &fix->latitude);
			ParseAngle(f[5], f[6], &fix->longitude);
			fix->knots = atof(f[7]);
			fix->course = atof(f[8]);
		}
		return true;
	}
	if (strcmp(type, "GGA") == 0 && n >= 10)
	{
		ParseTime(f[1], fix);
		fix->valid = atoi(f[6]) > 0;
		if (fix->valid)
		{
			ParseAngle(f[2], f[3], &fix->latitude);
			ParseAngle(f[4], f[5], &fix->longitude);
			fix->satellites = atoi(f[7]);
			fix->hdop = atof(f[8]);
			fix->altitude = atof(f[9]);
		}
		return true;
	}
	if (strcmp(type, "GLL") == 0 && n >= 7)
	{
		fix->valid = f[6][0] == 'A';
		ParseTime(f[5], fix);
		if (fix->valid)
		{
			ParseAngle(f[1], f[2], &fix->latitude);
			ParseAngle(f[3], f[4], &fix->longitude);
		}
		return true;
	}
	return false;
}


/*------------------------------------------------------------------------------
	The pretend receivers: sim and fixed
------------------------------------------------------------------------------*/

bool
HostGPSParsePretend(const char* spec, bool* moving, double* latitude, double* longitude, double* third)
{
	const char* rest;
	if (strncmp(spec, "sim", 3) == 0 && (spec[3] == 0 || spec[3] == ':'))
	{
		*moving = true;
		rest = spec[3] == ':' ? spec + 4 : NULL;
	}
	else if (strncmp(spec, "fixed:", 6) == 0)
	{
		*moving = false;
		rest = spec + 6;
	}
	else
		return false;
	if (rest == NULL)
		return true;
	double v[3];
	int n = 0;
	const char* p = rest;
	while (n < 3 && *p)
	{
		char* end;
		v[n] = strtod(p, &end);
		if (end == p)
			return false;
		n++;
		p = end;
		if (*p == ',')
			p++;
		else if (*p != 0)
			return false;
	}
	if (n < 2 || fabs(v[0]) > 90 || fabs(v[1]) > 180)
		return false;
	*latitude = v[0];
	*longitude = v[1];
	if (n == 3)
		*third = v[2];
	return true;
}


// where the pretend receiver is now; called with gLock held
static void
PretendFix(HostGPSFix* fix, long long wallMs)
{
	double seconds = (Millis() - gSetOff) / 1000.0;
	double north = 0, east = 0, course = gCourse;
	if (gSource == kSourceSim)
	{
		double speed = gKnots * kKnot;
		double theta = speed > 0 ? seconds * speed / kSimRadius : 0;
		north = kSimRadius * cos(theta);
		east = kSimRadius * sin(theta);
		course = fmod(theta * 180.0 / M_PI + 90.0, 360.0);
	}
	else
	{
		double travelled = gKnots * kKnot * seconds;
		north = travelled * cos(gCourse * M_PI / 180.0);
		east = travelled * sin(gCourse * M_PI / 180.0);
	}
	fix->valid = true;
	fix->latitude = gLatitude + north / kMetresPerDegree;
	fix->longitude = gLongitude + east / (kMetresPerDegree * cos(gLatitude * M_PI / 180.0));
	if (fix->longitude > 180)
		fix->longitude -= 360;
	else if (fix->longitude < -180)
		fix->longitude += 360;
	fix->altitude = gAltitude;
	fix->knots = gKnots;
	fix->course = course;
	fix->satellites = 8;
	fix->hdop = 0.9;
	fix->time = wallMs / 1000;
	fix->millis = 0;
}


bool
HostGPSSetPosition(double latitude, double longitude, double altitude, double knots, double course)
{
	if (gSource != kSourceSim && gSource != kSourceFixed)
		return false;
	if (fabs(latitude) > 90 || fabs(longitude) > 180 || knots < 0)
		return false;
	std::lock_guard<std::mutex> hold(gLock);
	gLatitude = latitude;
	gLongitude = longitude;
	gAltitude = altitude;
	gKnots = knots;
	gCourse = fmod(fmod(course, 360.0) + 360.0, 360.0);
	gSetOff = Millis();
	return true;
}


/*------------------------------------------------------------------------------
	The real sources' links: a TCP connection, a host serial port
------------------------------------------------------------------------------*/

struct Link
{
	char	host[96];
	unsigned short port;
	int		socket;						// -1 none
	long long retryAt;
	bool	gpsd;
#if defined(_WIN32) && !defined(HOST_GPS_NO_SERIAL)
	HANDLE	device;
#else
	int		device;
#endif
	char	path[96];
	long	baud;
};

static Link	gLink;

static bool
OpenDevice(Link* link)
{
#if defined(HOST_GPS_NO_SERIAL)
	(void) link;
	return false;
#elif defined(_WIN32)
	char name[128];
	snprintf(name, sizeof(name), strncmp(link->path, "\\\\.\\", 4) == 0 ? "%s" : "\\\\.\\%s", link->path);
	link->device = CreateFileA(name, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (link->device == INVALID_HANDLE_VALUE)
		return false;
	DCB dcb;
	memset(&dcb, 0, sizeof(dcb));
	dcb.DCBlength = sizeof(dcb);
	GetCommState(link->device, &dcb);
	dcb.BaudRate = (DWORD) link->baud;
	dcb.ByteSize = 8;
	dcb.Parity = NOPARITY;
	dcb.StopBits = ONESTOPBIT;
	dcb.fBinary = TRUE;
	dcb.fOutxCtsFlow = FALSE;
	dcb.fOutxDsrFlow = FALSE;
	dcb.fDtrControl = DTR_CONTROL_ENABLE;
	dcb.fRtsControl = RTS_CONTROL_ENABLE;
	dcb.fOutX = dcb.fInX = FALSE;
	SetCommState(link->device, &dcb);
	COMMTIMEOUTS timeouts;
	memset(&timeouts, 0, sizeof(timeouts));
	timeouts.ReadIntervalTimeout = MAXDWORD;
	timeouts.ReadTotalTimeoutMultiplier = MAXDWORD;
	timeouts.ReadTotalTimeoutConstant = 200;
	timeouts.WriteTotalTimeoutConstant = 500;
	SetCommTimeouts(link->device, &timeouts);
	return true;
#else
	link->device = open(link->path, O_RDWR | O_NOCTTY);
	if (link->device < 0)
		return false;
	struct termios tio;
	if (tcgetattr(link->device, &tio) == 0)
	{
		cfmakeraw(&tio);
		speed_t speed = link->baud == 9600 ? B9600 : link->baud == 19200 ? B19200 : link->baud == 38400 ? B38400
					  : link->baud == 57600 ? B57600 : link->baud == 115200 ? B115200 : B4800;
		cfsetispeed(&tio, speed);
		cfsetospeed(&tio, speed);
		tio.c_cflag |= CLOCAL | CREAD;
		tcsetattr(link->device, TCSANOW, &tio);
	}
	return true;
#endif
}

// ==> how many bytes came (0: none within a fifth of a second), -1 the
// link is gone (it is tried again later)
static long
LinkRead(Link* link, unsigned char* bytes, long size)
{
	if (gSource == kSourceSerial)
	{
#if defined(HOST_GPS_NO_SERIAL)
		return -1;
#elif defined(_WIN32)
		DWORD got = 0;
		if (!ReadFile(link->device, bytes, (DWORD) size, &got, NULL))
			return -1;
		return (long) got;
#else
		struct pollfd p = { link->device, POLLIN, 0 };
		if (poll(&p, 1, 200) <= 0)
			return 0;
		ssize_t got = read(link->device, bytes, size);
		return got > 0 ? (long) got : -1;
#endif
	}
	if (link->socket < 0)
	{
		if (Millis() < link->retryAt)
		{
			std::this_thread::sleep_for(std::chrono::milliseconds(200));
			return 0;
		}
		link->retryAt = Millis() + 5000;
		uint32_t addresses[4];
		int count = 0;
		if (HostResolveName(link->host, addresses, 4, &count) != kHostSocketOK || count == 0)
			return 0;
		int handle;
		if (HostTCPConnect(addresses[0], link->port, &handle) != kHostSocketOK
		 && HostSocketConnected(handle) != kHostSocketWouldBlock)
			return 0;
		long long until = Millis() + 3000;
		int state;
		while ((state = HostSocketConnected(handle)) == kHostSocketWouldBlock && Millis() < until)
			std::this_thread::sleep_for(std::chrono::milliseconds(20));
		if (state != kHostSocketOK)
		{
			HostSocketClose(handle);
			return 0;
		}
		link->socket = handle;
		fprintf(stderr, "[host] GPS: connected to %s:%u\n", link->host, (unsigned) link->port);
		if (link->gpsd)
		{
			static const char kWatch[] = "?WATCH={\"enable\":true,\"nmea\":true};\n";
			size_t sent;
			HostSocketSend(link->socket, kWatch, sizeof(kWatch) - 1, &sent);
		}
	}
	size_t got = 0;
	int result = HostSocketReceive(link->socket, bytes, (size_t) size, &got);
	if (result == kHostSocketClosed || result < 0)
	{
		HostSocketClose(link->socket);
		link->socket = -1;
		fprintf(stderr, "[host] GPS: %s:%u closed\n", link->host, (unsigned) link->port);
		return -1;
	}
	if (got == 0)
		std::this_thread::sleep_for(std::chrono::milliseconds(50));
	return (long) got;
}

static void
LinkWrite(Link* link, const unsigned char* bytes, long size)
{
	if (size <= 0)
		return;
	if (gSource == kSourceSerial)
	{
#if defined(HOST_GPS_NO_SERIAL)
		(void) bytes;
#elif defined(_WIN32)
		DWORD put;
		WriteFile(link->device, bytes, (DWORD) size, &put, NULL);
#else
		ssize_t put = write(link->device, bytes, size);
		(void) put;
#endif
	}
	else if (link->socket >= 0 && !link->gpsd)
	{
		size_t sent;
		HostSocketSend(link->socket, bytes, (size_t) size, &sent);
	}
}


/*------------------------------------------------------------------------------
	The receiver's thread
------------------------------------------------------------------------------*/

static char*	gFile = NULL;			// nmea: the log
static long		gFileSize = 0;

// each second on the second: the pretend receiver's sentences (or a
// Tripmate's ASTRAL); a log's next cycle
static void
RunTimed(void)
{
	long second = 0;
	long filePos = 0;
	char first[8] = "";
	for (;;)
	{
		long long now = WallMillis();
		std::this_thread::sleep_for(std::chrono::milliseconds(1000 - now % 1000));
		now = WallMillis();
		std::lock_guard<std::mutex> hold(gLock);
		if (gKind == kHostGPSTripmate && !gAstral)
			Say("ASTRAL\r\n", 8);
		if (gSource == kSourceFile)
		{
			// one cycle: the lines up to the next of the log's first kind
			bool begun = false;
			while (gFileSize > 0)
			{
				if (filePos >= gFileSize)
					filePos = 0;
				long end = filePos;
				while (end < gFileSize && gFile[end] != '\n')
					end++;
				char line[kLineSize + 4];
				long n = end - filePos;
				if (n > kLineSize)
					n = kLineSize;
				memcpy(line, gFile + filePos, n);
				while (n > 0 && (line[n - 1] == '\r' || line[n - 1] == '\n'))
					n--;
				line[n] = 0;
				if (line[0] == '$' && n >= 6)
				{
					if (first[0] == 0)
						memcpy(first, line + 1, 5);
					if (strncmp(line + 1, first, 5) == 0 && begun)
						break;				// (the next cycle's: left for next time)
					begun = true;
					HostGPSParse(line, &gFix);
					strcpy(line + n, "\r\n");
					SaySentence(line, n + 2);
				}
				filePos = end + 1;
			}
		}
		else
		{
			PretendFix(&gFix, now);
			char sentences[1024];
			long n = HostGPSSentences(&gFix, second, sentences, sizeof(sentences));
			for (char* p = sentences; p < sentences + n; )
			{
				char* e = strchr(p, '\n');
				long length = (long) (e - p + 1);
				SaySentence(p, length);
				p += length;
			}
		}
		second++;
	}
}

// a real receiver's sentences passed on as they come (and read for the
// fix), what the Newton sent passed to it; a Tripmate's ASTRAL each second
static void
RunRelay(void)
{
	char line[kLineSize + 4];
	long lineCount = 0;
	long long lastAstral = 0;
	for (;;)
	{
		unsigned char bytes[512];
		long got = LinkRead(&gLink, bytes, sizeof(bytes));
		unsigned char passOn[sizeof(gPassOn)];
		long passOnCount;
		{
			std::lock_guard<std::mutex> hold(gLock);
			passOnCount = gPassOnCount;
			memcpy(passOn, gPassOn, passOnCount);
			gPassOnCount = 0;
			if (gKind == kHostGPSTripmate && !gAstral && Millis() - lastAstral >= 1000)
			{
				Say("ASTRAL\r\n", 8);
				lastAstral = Millis();
			}
			for (long i = 0; i < got; i++)
			{
				char c = (char) bytes[i];
				if (c == '\n' || c == '\r')
				{
					line[lineCount] = 0;
					if (lineCount > 0 && (line[0] == '$' || line[0] == '!'))
					{
						HostGPSParse(line, &gFix);
						strcpy(line + lineCount, "\r\n");
						SaySentence(line, lineCount + 2);
					}
					lineCount = 0;
				}
				else if (lineCount < kLineSize)
					line[lineCount++] = c;
			}
		}
		LinkWrite(&gLink, passOn, passOnCount);
		if (got < 0 && gSource == kSourceSerial)
			std::this_thread::sleep_for(std::chrono::milliseconds(1000));
	}
}


bool
HostGPSStart(const char* spec, char* why, long size)
{
	if (gStarted)
	{
		snprintf(why, size, "it is already started");
		return false;
	}
	bool moving;
	double third = -1;
	memset(&gFix, 0, sizeof(gFix));
	memset(&gLink, 0, sizeof(gLink));
	gLink.socket = -1;
	if (HostGPSParsePretend(spec, &moving, &gLatitude, &gLongitude, &third))
	{
		gSource = moving ? kSourceSim : kSourceFixed;
		if (moving)
			gKnots = third >= 0 ? third : 10.0;
		else
		{
			gKnots = 0;
			if (third != -1)
				gAltitude = third;
		}
		gSetOff = Millis();
	}
	else if (strncmp(spec, "nmea:", 5) == 0)
	{
		FILE* f = fopen(spec + 5, "rb");
		if (f == NULL)
		{
			snprintf(why, size, "%s cannot be read", spec + 5);
			return false;
		}
		gFile = (char*) malloc(kFileLimit);
		gFileSize = gFile != NULL ? (long) fread(gFile, 1, kFileLimit, f) : 0;
		fclose(f);
		if (gFileSize == 0 || memchr(gFile, '$', gFileSize) == NULL)
		{
			snprintf(why, size, "%s holds no sentences", spec + 5);
			return false;
		}
		gSource = kSourceFile;
	}
	else if (strncmp(spec, "tcp:", 4) == 0 || strncmp(spec, "gpsd", 4) == 0)
	{
		bool gpsd = spec[0] == 'g';
		const char* rest = gpsd ? (spec[4] == ':' ? spec + 5 : "") : spec + 4;
		if (gpsd && spec[4] != 0 && spec[4] != ':')
		{
			snprintf(why, size, "no such source %s", spec);
			return false;
		}
		snprintf(gLink.host, sizeof(gLink.host), "%s", rest[0] ? rest : "127.0.0.1");
		char* colon = strrchr(gLink.host, ':');
		long port = gpsd ? 2947 : 0;
		if (colon != NULL)
		{
			*colon = 0;
			port = strtol(colon + 1, NULL, 10);
		}
		if (gLink.host[0] == 0)
			strcpy(gLink.host, "127.0.0.1");
		if (port <= 0 || port > 65535)
		{
			snprintf(why, size, "%s wants a port (tcp:HOST:PORT)", spec);
			return false;
		}
		if (HostSocketsInit() != kHostSocketOK)
		{
			snprintf(why, size, "no sockets");
			return false;
		}
		gLink.port = (unsigned short) port;
		gLink.gpsd = gpsd;
		gSource = gpsd ? kSourceGPSD : kSourceTCP;
	}
	else if (strncmp(spec, "serial:", 7) == 0)
	{
		snprintf(gLink.path, sizeof(gLink.path), "%s", spec + 7);
		char* at = strrchr(gLink.path, '@');
		gLink.baud = 4800;
		if (at != NULL)
		{
			*at = 0;
			gLink.baud = strtol(at + 1, NULL, 10);
		}
		gSource = kSourceSerial;
		if (!OpenDevice(&gLink))
		{
			snprintf(why, size, "%s cannot be opened", gLink.path);
			gSource = kSourceNone;
			return false;
		}
	}
	else
	{
		snprintf(why, size, "no such source %s (sim, fixed:, nmea:, tcp:, gpsd, serial:)", spec);
		return false;
	}
	snprintf(gSpec, sizeof(gSpec), "%s", spec);
	TripmateReset();
	gStarted = true;
	std::thread(gSource == kSourceSim || gSource == kSourceFixed || gSource == kSourceFile ? RunTimed : RunRelay).detach();
	return true;
}


bool		HostGPSStarted(void)		{ return gStarted; }

void
HostGPSSource(char* spec, long size)
{
	snprintf(spec, size, "%s", gSpec);
}


void
HostGPSSetKind(HostGPSKind kind)
{
	std::lock_guard<std::mutex> hold(gLock);
	if (gKind != kind)
	{
		gKind = kind;
		TripmateReset();
	}
}

HostGPSKind
HostGPSGetKind(void)
{
	return gKind;
}


void
HostGPSPlug(bool plugged)
{
	std::lock_guard<std::mutex> hold(gLock);
	gPlugged = plugged;
	gOutHead = gOutCount = 0;
	gInCount = 0;
	TripmateReset();
}

bool		HostGPSPlugged(void)		{ return gPlugged; }


long
HostGPSRead(unsigned char* bytes, long size)
{
	std::lock_guard<std::mutex> hold(gLock);
	long n = 0;
	while (n < size && gOutCount > 0)
	{
		bytes[n++] = gOut[gOutHead];
		gOutHead = (gOutHead + 1) % kOutSize;
		gOutCount--;
	}
	return n;
}


void
HostGPSWrite(const void* bytes, long size)
{
	std::lock_guard<std::mutex> hold(gLock);
	const char* p = (const char*) bytes;
	for (long i = 0; i < size; i++)
	{
		if (gPassOnCount < (long) sizeof(gPassOn))
			gPassOn[gPassOnCount++] = (unsigned char) p[i];
		if (p[i] == '\r' || p[i] == '\n')
		{
			gIn[gInCount] = 0;
			if (gInCount > 0)
				Heard(gIn);
			gInCount = 0;
		}
		else if (gInCount < kLineSize - 1)
			gIn[gInCount++] = p[i];
	}
}


void
HostGPSStatus(HostGPSFix* fix)
{
	std::lock_guard<std::mutex> hold(gLock);
	*fix = gFix;
}
