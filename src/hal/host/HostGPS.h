/*
	File:		hal/host/HostGPS.h

	Contains:	The host's GPS receiver: what a Newton GPS application
				reads from a receiver plugged into a serial port.

				Newton GPS software (GPS Map, GPS Monitor, GPS View - the
				fixtures under fixtures/packages/apps/GPS*) opens an
				asynchronous serial endpoint ('aser') on the port the user
				picks and reads NMEA 0183 sentences ($GPGGA, $GPRMC,
				$GPGLL, $GPVTG, ...) off it, one burst a second at 4800
				baud; there is no GPS service in the OS.  So the host's
				GPS is a receiver at the far end of a serial port - serial
				port 2 ('mdem', a port of its own) or the external one
				(HostSerialChip.h's HostSerialChipSetGPS) - and this
				is the receiver: a thread of its own that each second puts
				a fix into sentences, and hears what the Newton sends it.

				The fix comes from a source (the spec, newton --gps):
				  sim[:LAT,LON[,KNOTS]]  a pretend receiver going round a
				                         circle of 500 m about the point
				                         (Melbourne, at 10 knots, unless
				                         given)
				  fixed:LAT,LON[,ALT]    a pretend receiver standing still
				  nmea:FILE              an NMEA log replayed, a second for
				                         each cycle (a cycle begins with the
				                         log's first kind of sentence), from
				                         the start again at the end
				  tcp:HOST:PORT          NMEA from a TCP server (a phone's
				                         "GPS over network" app, gpsd's
				                         gpspipe -r | nc -l ...)
				  gpsd[:HOST[:PORT]]     gpsd (localhost:2947), asked for
				                         its NMEA ("?WATCH" with nmea true)
				  serial:DEVICE[@BAUD]   a receiver plugged into the host
				                         (COM3, /dev/ttyUSB0; 4800 unless
				                         given)
				LAT and LON in degrees, north and east positive; ALT in
				metres.  A pretend source makes its own sentences; the
				others' are passed on as they come (a real receiver's), and
				read for the fix that HostGPSStatus reports.

				The receiver is one of two kinds (HostGPSSetKind):
				  NMEA      sentences all the time, whatever is sent to it
				            (an init string - "$PGRMO,..." - is heard and
				            ignored)
				  Tripmate  a DeLorme Tripmate, as GPS View wants: it says
				            "ASTRAL" each second until the host answers
				            "ASTRAL", then sends NMEA, the sentences
				            "$PRWIILOG,<type>,A|V,..." switches on and off
				            ($PRWIIRST... starts it over: ASTRAL again)

				Portable C++ with nothing of the Newton's (std::thread and
				std::mutex, so built as the cellular engine is - without
				the Newton include paths); the NewtonScript natives are
				host/HostGPSNatives.cpp:

					HostGPSAvailable()	true when newton has a GPS source
					HostGPSStatus()		{source, kind, plugged, port, fix,
										latitude, longitude, altitude,
										speed, course, satellites, time}:
										kind 'nmea or 'tripmate, plugged
										true when it is on a serial port,
										port which ("mdem" serial port 2,
										"extr" the external one), fix
										true when the receiver
										has one; latitude and longitude in
										degrees (reals), altitude in
										metres, speed in knots, course in
										degrees true; time the fix's in
										minutes since 1904 (UTC; Time()
										is the Newton's zone's) and seconds
										the seconds into that minute - nil
										what the receiver has not given
					HostGPSSetPosition(lat, lon, alt, knots, course)
										a pretend source moved there (and,
										for sim, its circle's centre)
*/

#ifndef __HOSTGPS_H
#define __HOSTGPS_H

const long	kHostGPSSourceSize = 160;

enum HostGPSKind
{
	kHostGPSNMEA,						// sentences all the time
	kHostGPSTripmate					// a DeLorme Tripmate: ASTRAL first
};

struct HostGPSFix
{
	bool		valid;					// a fix (the rest of it means something)
	double		latitude;				// degrees, north positive
	double		longitude;				// degrees, east positive
	double		altitude;				// metres above the geoid
	double		knots;					// speed over the ground
	double		course;					// degrees true
	int			satellites;				// used in the fix
	double		hdop;
	long long	time;					// seconds since 1970, UTC (0: none)
	int			millis;					// ... and its milliseconds
};

// The receiver started on its source (spec as above) ==> whether it was;
// why says why not.  Once only.
bool	HostGPSStart(const char* spec, char* why, long size);
bool	HostGPSStarted(void);
void	HostGPSSource(char* spec, long size);		// the spec it was started with

void		HostGPSSetKind(HostGPSKind kind);
HostGPSKind	HostGPSGetKind(void);

// The serial port's side (any thread): the receiver powered up (its
// output from now on: what it said while nobody listened is gone, a
// Tripmate starts over with ASTRAL) or down; what it has said since, up
// to size bytes ==> how many; what the Newton sent it.
void	HostGPSPlug(bool plugged);
bool	HostGPSPlugged(void);
long	HostGPSRead(unsigned char* bytes, long size);
void	HostGPSWrite(const void* bytes, long size);

void	HostGPSStatus(HostGPSFix* fix);
bool	HostGPSSetPosition(double latitude, double longitude, double altitude, double knots, double course);

// (the engine's sentences, for its tests - hal/tests/test_HostGPS.cpp)
// one second's NMEA from a fix: GGA, GLL, RMC, VTG, and every fifth
// second GSA and GSV, each ended by CR LF ==> the length
long	HostGPSSentences(const HostGPSFix* fix, long second, char* out, long size);
// the sentence's (with or without its CR LF) news put into fix ==> whether
// it was a checked GGA, RMC or GLL (a sentence with a checksum that does
// not add up is not read)
bool	HostGPSParse(const char* sentence, HostGPSFix* fix);
// the two hex digits after the '*' for the characters between '$' and '*'
unsigned	HostGPSChecksum(const char* sentence);
// a pretend source's spec read: sim or fixed, the point and the speed (or
// altitude) ==> whether it was one
bool	HostGPSParsePretend(const char* spec, bool* moving, double* latitude, double* longitude, double* third);

void	HostRegisterGPSFunctions(void);		// the natives (host/HostViews.cpp)

#endif	/* __HOSTGPS_H */
