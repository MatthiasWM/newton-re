/*
	File:		host/HostDeveloper.h

	Contains:	The Developer preferences panel: tools for looking into the
				OS as it runs, from the Newton's own Preferences
				(HostDeveloper.ns, docs/host-settings.md "The Developer
				panel") - for now the NewtonScript profiler
				(frames/FunctionProfiler.h): on and off, its counts cleared,
				its report written.

				The NewtonScript side sees HostDeveloperReportPath(): where
				the panel writes the profile - "<store>.nsprofile.txt"
				beside the store file, "newton-nsprofile.txt" in the
				working directory with no store file, nil (the console)
				where the host has no file for it (the T-Deck Pro).
*/

#ifndef __HOSTDEVELOPER_H
#define __HOSTDEVELOPER_H

void	HostDeveloperSetReportFile(const char* storePath);	// before boot: the profile written beside the store file (nil: in the working directory)
void	HostInstallDeveloper(void);			// in the newt world, once its globals are built: the native, HostDeveloper:host, the panel

#endif	/* __HOSTDEVELOPER_H */
