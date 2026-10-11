/*
	File:		host/HostWifi.h

	Contains:	The host's WiFi, where the host has one to manage - the
				ESP32-S3 host (src/host/esp32/main/tdeck_wifi.cpp): its
				networks scanned for, the ones to join remembered (several:
				the host joins whichever of them it finds), and how it is
				connected.  A desktop's operating system manages its own
				network, so a desktop has no provider and the natives say
				there is no WiFi.

				The NewtonScript natives (registered with the view
				functions, host/HostViews.cpp):

					HostWifiAvailable()			true when there is a provider
					HostWifiScan()				[{ssid, rssi, secure, known}, ...],
												strongest first; nil: none
					HostWifiKnown()				["ssid", ...] - the networks remembered
					HostWifiRemember(ssid, password)
												remembered (a password of nil or
												"" for an open one) and joined
												if it is in range ==> true
					HostWifiForget(ssid)		==> true when it was remembered
					HostWifiStatus()			{state, ssid, address, rssi}:
												state 'off, 'searching,
												'connecting or 'connected; the
												address a string "a.b.c.d"

				Internet Setup's Host network setup has a Wi-Fi slip made of
				them (comms/host/HostLink.ns).
*/

#ifndef __HOSTWIFI_H
#define __HOSTWIFI_H

const long	kHostWifiSSIDSize = 33;			// 32 bytes and the terminator
const long	kHostWifiPasswordSize = 65;		// 64 and the terminator

struct HostWifiNetwork
{
	char	ssid[kHostWifiSSIDSize];
	long	rssi;							// dBm
	bool	secure;							// a password is wanted
	bool	known;							// remembered
};

enum HostWifiState
{
	kHostWifiOff,
	kHostWifiSearching,						// no remembered network in range yet
	kHostWifiConnecting,
	kHostWifiConnected
};

struct HostWifiStatusInfo
{
	HostWifiState	state;
	char			ssid[kHostWifiSSIDSize];	// the network joined or being joined
	unsigned long	address;				// IPv4, a.b.c.d as a << 24 | ...; 0 none
	long			rssi;
};

// What a host with WiFi provides (each from a Newton task; each may wait)
struct HostWifiProvider
{
	long	(*scan)(HostWifiNetwork* networks, long max);			// ==> how many found (strongest first), -1 when it could not scan
	long	(*known)(char (*ssids)[kHostWifiSSIDSize], long max);	// ==> how many remembered
	bool	(*remember)(const char* ssid, const char* password);
	bool	(*forget)(const char* ssid);
	void	(*status)(HostWifiStatusInfo* info);
};

void	HostWifiSetProvider(const HostWifiProvider* provider);	// (before the newt world boots)
void	HostRegisterWifiFunctions(void);						// the natives (host/HostViews.cpp)

#endif	/* __HOSTWIFI_H */
