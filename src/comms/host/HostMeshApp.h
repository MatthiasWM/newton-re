/*
	File:		comms/host/HostMeshApp.h

	Contains:	The Mesh application (HostMesh.ns, compiled into the
				program) evaluated, kept in the global HostMesh:host and
				started, when the host has a LoRa mesh node
				(hal/host/HostMesh.h's engine started: the T-Deck Pro's
				radio, or newton --mesh-air).

				DEVIATION (host addition): the ROM has no mesh
				(docs/host-tdeck-pro-mesh.md).

	Host code (no ROM counterpart).
*/

#ifndef __COMMS_HOSTMESHAPP_H
#define __COMMS_HOSTMESHAPP_H

// a program calls it once the NewtonScript world is up (its PreMain hook)
void	HostMeshAppStart(void);

#endif
