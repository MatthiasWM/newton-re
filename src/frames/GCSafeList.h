/*
	File:		GCSafeList.h

	Contains:	TGCSafeList and TGCSafeSortedList: a CList (CSortedList) of
				Refs that the garbage collector knows about.  Each registers
				itself with the collector (DIYGCRegister) as it is made and
				unregisters as it goes; at a collection its items are marked
				(DIYGCMark) and then updated in place to where their objects
				moved (DIYGCUpdate) - a Ref kept in a list the collector
				would otherwise not see.

				Public API: nothing in the ROM makes one; they are in the
				public jump table for packages' native code.  The DDK does
				not declare them.  Neither has fields of its own: the ROM's
				sizes are its base class's (0x18 and 0x1c).

	Reconstructed from the MP2x00 US ROM (0x000d7074-0x000d7380); each
	function cites its origin.
*/

#ifndef __GCSAFELIST_H
#define __GCSAFELIST_H

#ifndef __OBJECTS_H
#include "objects.h"
#endif
#ifndef __LIST_H
#include "List.h"
#endif
#ifndef __SORTEDLIST_H
#include "SortedList.h"
#endif


class TGCSafeList : public CList
{
public:
					TGCSafeList();							// ROM 0x000d7074 __ct__11TGCSafeListFv
					~TGCSafeList();							// ROM 0x000d70c0 __dt__11TGCSafeListFv

	void			GCMarkItems(void);						// ROM 0x000d71f8 GCMarkItems__11TGCSafeListFv
	void			GCUpdateItems(void);					// ROM 0x000d7264 GCUpdateItems__11TGCSafeListFv

	static void		GCMarkRefs(void* list);					// ROM 0x000d71f0 GCMarkRefs__11TGCSafeListSFPv - the collector's mark proc
	static void		GCUpdateRefs(void* list);				// ROM 0x000d71f4 GCUpdateRefs__11TGCSafeListSFPv - and its update proc
};


class TGCSafeSortedList : public CSortedList
{
public:
					TGCSafeSortedList(CItemComparer* comparer);	// ROM 0x000d72f0 __ct__17TGCSafeSortedListFP13CItemComparer
					~TGCSafeSortedList();						// ROM 0x000d7344 __dt__17TGCSafeSortedListFv

	void			GCMarkItems(void);						// ROM 0x000d70f8 GCMarkItems__17TGCSafeSortedListFv
	void			GCUpdateItems(void);					// ROM 0x000d7164 GCUpdateItems__17TGCSafeSortedListFv

	static void		GCMarkRefs(void* list);					// ROM 0x000d737c GCMarkRefs__17TGCSafeSortedListSFPv
	static void		GCUpdateRefs(void* list);				// ROM 0x000d7380 GCUpdateRefs__17TGCSafeSortedListSFPv
};

#endif	/* __GCSAFELIST_H */
