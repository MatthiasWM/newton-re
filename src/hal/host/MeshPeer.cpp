/*
	File:		hal/host/MeshPeer.cpp

	Contains:	meshpeer - a mesh node on a desktop's pretend air
				(HostMesh.h, HostMeshAir.cpp) for newton's Mesh application
				to talk to, and for the engine's own tests: it announces
				itself, prints what it hears, and answers as it is told.

					meshpeer [--air lan[:port]] [--name NAME] [--state PREFIX]
							 [--echo] [--channel TEXT] [--send-to NAME --text TEXT]
							 [--until TEXT] [--seconds N]

				--air		the air (as newton --mesh-air; lan:3685 by default)
				--name		this node's name (meshpeer)
				--state		where its identity and contacts are kept (none: a
							new node each run)
				--echo		each message to it answered "echo: <text>"
				--channel	TEXT said on the Public channel once a node has been
							heard
				--send-to	TEXT (--text) sent to the node of that name once it
							has been heard, and how it went printed
				--until		stops (exit 0) once a message holding TEXT comes, to
							it or on a channel (and --send-to's message has
							been settled)
				--seconds	stops (exit 1) after so long (60; 0 never)

				It prints, a line each: "meshpeer: up <id>", "meshpeer: heard
				<name>", "meshpeer: from <name>: <text>", "meshpeer: channel
				<channel> <name>: <text>", "meshpeer: sent <state>".  Used by
				ctest hal.MeshPeers and the Mesh demos (tools/mesh/meshrun.py).
*/

#include "HostMesh.h"

#include <chrono>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <thread>

static const char*
StateName(int state)
{
	switch (state)
	{
	case kHostMeshSendBusy:			return "busy";
	case kHostMeshSendSent:			return "sent";
	case kHostMeshSendDelivered:	return "delivered";
	case kHostMeshSendFailed:		return "failed";
	}
	return "none";
}


int
main(int argc, char** argv)
{
	const char* air = "lan";
	const char* name = "meshpeer";
	const char* state = NULL;
	const char* channelText = NULL;
	const char* sendTo = NULL;
	const char* sendText = NULL;
	const char* until = NULL;
	bool echo = false;
	long seconds = 60;
	for (int i = 1; i < argc; i++)
	{
		const char* a = argv[i];
		const char* v = i + 1 < argc ? argv[i + 1] : NULL;
		if (strcmp(a, "--echo") == 0)
			echo = true;
		else if (v == NULL)
		{
			fprintf(stderr, "meshpeer: %s wants a value\n", a);
			return 2;
		}
		else if (strcmp(a, "--air") == 0)
			air = v, i++;
		else if (strcmp(a, "--name") == 0)
			name = v, i++;
		else if (strcmp(a, "--state") == 0)
			state = v, i++;
		else if (strcmp(a, "--channel") == 0)
			channelText = v, i++;
		else if (strcmp(a, "--send-to") == 0)
			sendTo = v, i++;
		else if (strcmp(a, "--text") == 0)
			sendText = v, i++;
		else if (strcmp(a, "--until") == 0)
			until = v, i++;
		else if (strcmp(a, "--seconds") == 0)
			seconds = atol(v), i++;
		else
		{
			fprintf(stderr, "meshpeer: what is %s?\n", a);
			return 2;
		}
	}
	setvbuf(stdout, NULL, _IONBF, 0);
	if (!HostMeshAirStart(air, state, name))
	{
		fprintf(stderr, "meshpeer: no air (%s)\n", air);
		return 2;
	}

	using namespace std::chrono;
	steady_clock::time_point start = steady_clock::now();
	HostMeshStatusInfo status;
	do
	{
		std::this_thread::sleep_for(milliseconds(20));
		HostMeshGetStatus(&status);
	} while (status.state == kHostMeshStarting);
	printf("meshpeer: up %.8s as %s\n", status.key, status.name);

	static HostMeshContact contacts[kHostMeshContactsMax];
	static char heard[kHostMeshContactsMax][kHostMeshKeyHexSize];
	long heardCount = 0;
	bool channelSaid = false, untilSeen = false;
	long sendId = 0;
	int sendState = kHostMeshSendNone;
	for (;;)
	{
		std::this_thread::sleep_for(milliseconds(50));
		if (seconds > 0 && steady_clock::now() - start > std::chrono::seconds(seconds))
		{
			printf("meshpeer: no more time\n");
			return 1;
		}

		// the nodes heard
		long count = HostMeshGetContacts(contacts, kHostMeshContactsMax);
		for (long k = 0; k < count && k < kHostMeshContactsMax; k++)
		{
			bool known = false;
			for (long h = 0; h < heardCount && !known; h++)
				known = strcmp(heard[h], contacts[k].key) == 0;
			if (known || heardCount == kHostMeshContactsMax)
				continue;
			strcpy(heard[heardCount++], contacts[k].key);
			printf("meshpeer: heard %s\n", contacts[k].name);
			if (sendTo != NULL && sendText != NULL && sendId == 0 && strcmp(contacts[k].name, sendTo) == 0)
				sendId = HostMeshSendText(contacts[k].key, sendText);
		}
		if (channelText != NULL && !channelSaid && heardCount > 0)
		{
			channelSaid = true;
			HostMeshSendText(NULL, channelText);
		}
		if (sendId != 0)
		{
			int now = HostMeshGetSendState(sendId);
			if (now != sendState && now != kHostMeshSendBusy)
				printf("meshpeer: sent %s\n", StateName(now));
			sendState = now;
		}

		// what came
		HostMeshMessage m;
		while (HostMeshNextMessage(&m))
		{
			if (m.channel[0] != 0)
				printf("meshpeer: channel %s %s: %s\n", m.channel, m.name, m.text);
			else
			{
				printf("meshpeer: from %s: %s\n", m.name, m.text);
				if (echo)
				{
					char reply[kHostMeshTextSize];
					snprintf(reply, sizeof(reply), "echo: %s", m.text);
					HostMeshSendText(m.key, reply);
				}
			}
			if (until != NULL && strstr(m.text, until) != NULL)
				untilSeen = true;
		}
		if (untilSeen && (sendId == 0 || sendState != kHostMeshSendBusy))
			return 0;
	}
}
