/*
	File:		GCSafeList.cpp

	Contains:	TGCSafeList and TGCSafeSortedList (GCSafeList.h): lists of
				Refs the garbage collector marks and updates.  Public API
				only - nothing in the ROM makes one.

	Reconstructed from the MP2x00 US ROM (0x000d7074-0x000d7380); each
	function cites its origin.  The two classes' functions are the same code
	twice over (the ROM has both copies).
*/

#include "GCSafeList.h"
#include "ListIterator.h"


/* -------------------------------------------------------------------------------
	TGCSafeList
------------------------------------------------------------------------------- */

// ROM 0x000d7074 __ct__11TGCSafeListFv
TGCSafeList::TGCSafeList()
{
	DIYGCRegister(this, GCMarkRefs, GCUpdateRefs);
}


// ROM 0x000d70c0 __dt__11TGCSafeListFv
TGCSafeList::~TGCSafeList()
{
	DIYGCUnregister(this);
}


// ROM 0x000d71f8 GCMarkItems__11TGCSafeListFv
void
TGCSafeList::GCMarkItems()
{
	CListIterator iter(this);
	for (void* item = iter.FirstItem(); iter.More(); item = iter.NextItem())
		DIYGCMark((Ref) item);
}


// ROM 0x000d7264 GCUpdateItems__11TGCSafeListFv
// Each item replaced in its element by the ref the collector gives back.
void
TGCSafeList::GCUpdateItems()
{
	CListIterator iter(this);
	for (void* item = iter.FirstItem(); iter.More(); item = iter.NextItem())
	{
		Ref updated = DIYGCUpdate((Ref) item);
		*(Ref*) ElementPtrAt(iter.CurrentIndex()) = updated;
	}
}


// ROM 0x000d71f0 GCMarkRefs__11TGCSafeListSFPv
void
TGCSafeList::GCMarkRefs(void* list)
{
	((TGCSafeList*) list)->GCMarkItems();
}


// ROM 0x000d71f4 GCUpdateRefs__11TGCSafeListSFPv
void
TGCSafeList::GCUpdateRefs(void* list)
{
	((TGCSafeList*) list)->GCUpdateItems();
}


/* -------------------------------------------------------------------------------
	TGCSafeSortedList
------------------------------------------------------------------------------- */

// ROM 0x000d72f0 __ct__17TGCSafeSortedListFP13CItemComparer
TGCSafeSortedList::TGCSafeSortedList(CItemComparer* comparer)
	: CSortedList(comparer)
{
	DIYGCRegister(this, GCMarkRefs, GCUpdateRefs);
}


// ROM 0x000d7344 __dt__17TGCSafeSortedListFv
TGCSafeSortedList::~TGCSafeSortedList()
{
	DIYGCUnregister(this);
}


// ROM 0x000d70f8 GCMarkItems__17TGCSafeSortedListFv
void
TGCSafeSortedList::GCMarkItems()
{
	CListIterator iter(this);
	for (void* item = iter.FirstItem(); iter.More(); item = iter.NextItem())
		DIYGCMark((Ref) item);
}


// ROM 0x000d7164 GCUpdateItems__17TGCSafeSortedListFv
// (An object's new address does not reorder the list: the comparer is not
// asked.)
void
TGCSafeSortedList::GCUpdateItems()
{
	CListIterator iter(this);
	for (void* item = iter.FirstItem(); iter.More(); item = iter.NextItem())
	{
		Ref updated = DIYGCUpdate((Ref) item);
		*(Ref*) ElementPtrAt(iter.CurrentIndex()) = updated;
	}
}


// ROM 0x000d737c GCMarkRefs__17TGCSafeSortedListSFPv
void
TGCSafeSortedList::GCMarkRefs(void* list)
{
	((TGCSafeSortedList*) list)->GCMarkItems();
}


// ROM 0x000d7380 GCUpdateRefs__17TGCSafeSortedListSFPv
void
TGCSafeSortedList::GCUpdateRefs(void* list)
{
	((TGCSafeSortedList*) list)->GCUpdateItems();
}
