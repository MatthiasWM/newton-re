/*
	File:		host/HostQuickSheet.h

	Contains:	The quick sheet and the lock screen (HostQuickSheet.ns): a
				sheet pulled down from the top of the screen - the screen
				locked from it, and the board's radios and receivers (the
				4G module, the GPS, the LoRa radio) switched on and off -
				and the lock screen it locks to, which covers the whole
				screen with the time and a slider dragged across to unlock.

				A host with a touch screen and no other way to lock it (the
				T-Deck Pro: host/esp32/main/tdeck_input.cpp sees the finger
				pulled down from the screen's top edge) installs it and
				calls HostQuickSheetPulled; the desktop's newton installs it
				only for testing (--quick-sheet; demo/quicksheet.ns).

				The NewtonScript side answers the frame in the global
				QuickSheet:host - Pulled() opens the sheet (or closes it,
				open already), Lock() and Unlock() - and tells the host
				through HostScreenLocked(on), which calls the host's hook:
				the board leaves the keyboard's keys out and its light off
				while the screen is locked.
*/

#ifndef __HOSTQUICKSHEET_H
#define __HOSTQUICKSHEET_H

void	HostQuickSheetSetLockHook(void (*locked)(bool on));	// before boot: told when the screen is locked and unlocked
void	HostInstallQuickSheet(void);		// in the newt world, once its globals are built: HostScreenLocked, QuickSheet:host
void	HostQuickSheetPulled(void);			// in the newt world's task: the sheet pulled down (opened, or closed if open)

#endif	/* __HOSTQUICKSHEET_H */
