/*
	File:		host/HostPenReplay.h

	Contains:	A pen recorded on one host played back on another: a file
				of pen events (one a line, "milliseconds what x y" - what
				0 down, 1 move, 2 up; x and y in display pixels), as the
				reMarkable window writes it with NEWTON_RM_PENLOG
				(host/remarkable/HostWindow.cpp), handed to the window's pen
				shims at the times it was recorded at (HostWindowPostPen),
				so the tablet driver samples it as it sampled the real one.
				docs/host-remarkable.md, "Handwriting".

				HostPenTapStart: a tap at one point played the same way (a
				demo tapping what it has just drawn, at any display size).

				No Newton headers: newton.cpp's HostPenReplay and HostPenTap
				natives call it.
*/

#ifndef __HOSTPENREPLAY_H
#define __HOSTPENREPLAY_H

long	HostPenReplayStart(const char* path);	// the playing started on a thread of its own: ==> how many events, -1 if the file could not be read
bool	HostPenReplayDone(void);					// the last event has been played
long	HostPenTapStart(double x, double y);		// a tap (down, held 150 ms, up) at a display point: ==> 3, -1 while another is playing

#endif	/* __HOSTPENREPLAY_H */
