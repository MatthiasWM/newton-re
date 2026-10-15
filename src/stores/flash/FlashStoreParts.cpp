/*
	File:		stores/flash/FlashStoreParts.cpp

	Contains:	The flash store's small parts (FlashStore.h): the header and
				directory entry tests, the log entries' guards, the lookup
				cache, the tracker, the compaction state, and TObjRef.

	Reconstructed from the MP2x00 US ROM; each function cites its origin.
*/

#include "FlashStore.h"
#include "NewtonMemory.h"
#include "NewtonDebug.h"
#include "host/RomBugs.h"

#include <string.h>


/*------------------------------------------------------------------------------
	S O b j e c t ,   S D i r E n t ,   i d s
------------------------------------------------------------------------------*/

// ROM 0x000c509c IsValidPSSID__FUl
// Not nought, not all ones, and more than one bit set and clear: an id
// that a single bit going wrong on the flash could turn into another is
// never handed out.
Boolean
IsValidPSSID(PSSId id)
{
	if (id == 0 || (id & (id - 1)) == 0 || id == 0x0FFFFFFF)
		return false;
	return ((~id - 1) & ~id) != 0;
}


// ROM 0x000c4e84 IsValid__7SObjectFP11TFlashStore
// A header that has been written (bit 0 of its second word cleared) with
// an id that could be one.
Boolean
SObject::IsValid(TFlashStore* store)
{
	if ((store->fVirginWord & 1) == (fWord1 & 1))
		return false;
	return IsValidPSSID(fWord0 & 0x0FFFFFFF);
}


// ROM 0x000c4eb0 ObjectStateToTransBits__FiP11TFlashStore
// The bits a state is written as: its code's complement, since on flash
// they are cleared rather than set.
ULong
ObjectStateToTransBits(int state, TFlashStore*)
{
	return ~(ULong) gObjectStateToTransBits[state];
}


// ROM 0x000c4f48 IsValid__7SDirEntFP11TFlashStore
// Neither blank (all ones) nor zapped (noughts), and written.
Boolean
SDirEnt::IsValid(TFlashStore* store)
{
	if ((fWord & 0xFFFFFF00) == 0 || (fWord >> 8) == 0x00FFFFFF)
		return false;
	return (store->fZapWord & 1) == ((fWord & 0xF) >> 3);
}


// ROM 0x000c4f7c IsValidMigratedObjectInfo__7SDirEntSFlT1
// An object number that fits its fourteen bits and a block that fits its
// ten: `subs r12,r0,#0x3fc0; cmpge r12,#0x3f` leaves "le" for every number
// up to 0x3fff (below 0x3fc0 the subtraction is already negative), and
// `cmple r1,#0x3ff` then passes blocks up to 0x3ff.  (This read "< 0x3FC0
// && < 0x3FF" until 2026-09-30, which dropped the migration entries of
// numbers 0x3fc0-0x3fff and of block 0x3ff.)  So at most 1024 blocks can
// be named - 128 MB of 128 KB blocks; an object that migrates to a block
// past that, or whose number is past 0x3fff, is left without an entry and
// found by TFlashStore::Lookup's search of every block.
Boolean
SDirEnt::IsValidMigratedObjectInfo(long objectNumber, long block)
{
	return objectNumber <= 0x3FFF && block <= 0x3FF;
}


// ROM 0x000c4fa0 SetMigratedObjectInfo__7SDirEntFlT1
void
SDirEnt::SetMigratedObjectInfo(long objectNumber, long block)
{
	fWord = (fWord & 0xFF) | (((ULong) objectNumber | ((ULong) block << 14)) << 8);
}


// ROM 0x000c4fb8 GetMigratedObjectInfo__7SDirEntCFPlT1
void
SDirEnt::GetMigratedObjectInfo(long* objectNumber, long* block) const
{
	*block = (long) (fWord >> 8) >> 14;
	*objectNumber = (fWord >> 8) & 0x3FFF;
}


// ROM 0x000c4fd8 HashPSSID__FUl
ULong
HashPSSID(PSSId id)
{
	return id ^ (id >> 24) ^ (id >> 16) ^ (id >> 8);
}


// ROM 0x000c5140 CeilLog2__FUl
ULong
CeilLog2(ULong value)
{
	ULong log = 0;
	for (ULong v = value; v > 1; v >>= 1)
		log++;
	if (((ULong) 1 << log) < value)
		log++;
	return log;
}


/*------------------------------------------------------------------------------
	S F l a s h L o g E n t r y
------------------------------------------------------------------------------*/

// ROM 0x000c4ec8 PrivateFlashLogEntryIsValid__FP14SFlashLogEntryUl
// The entry at offset guards itself with its own address, twice, and says
// "newt"; and no entry is as big as 256 bytes.
Boolean
PrivateFlashLogEntryIsValid(SFlashLogEntry* entry, ULong offset)
{
	return entry->fGuard1 == (FlashWord) (offset ^ 'dyer')
		&& entry->fGuard2 == (FlashWord) (~offset ^ 'foo!')
		&& entry->fNewt == 'newt'
		&& entry->fSize < 0x100;
}


// ROM 0x000c4ec4 IsValid__14SFlashLogEntryFUl
Boolean
SFlashLogEntry::IsValid(ULong offset)
{
	return PrivateFlashLogEntryIsValid(this, offset);
}


// ROM 0x000c4f30 PrivateFlashLogEntryPhysOffset__FP14SFlashLogEntry
// Where the entry itself is.
ULong
PrivateFlashLogEntryPhysOffset(SFlashLogEntry* entry)
{
	return entry->fGuard1 ^ 'dyer';
}


// ROM 0x000c4f2c PhysOffset__14SFlashLogEntryFv
ULong
SFlashLogEntry::PhysOffset(void)
{
	return PrivateFlashLogEntryPhysOffset(this);
}


/*------------------------------------------------------------------------------
	S C o m p a c t S t a t e
------------------------------------------------------------------------------*/

// ROM 0x00070ed4 Init__13SCompactStateFv
void
SCompactState::Init(void)
{
	memset(this, 0, 100);
	fStep = 0;
	fMagicKey = 'bltg';
	fOtherMagicKey = 'zarf';
}


// ROM 0x00070f14 IsValid__13SCompactStateFv
Boolean
SCompactState::IsValid(void)
{
	return fMagicKey == 'bltg' && fOtherMagicKey == 'zarf';
}


// ROM 0x00070f44 InProgress__13SCompactStateFv
Boolean
SCompactState::InProgress(void)
{
	return IsValid() && fStep != 0;
}


/*------------------------------------------------------------------------------
	T S t o r e D r i v e r
	A RAM store's memory, seen as one run of offsets: the persistent part
	first (offsets below fPersistentSize), then the ordinary part.  The
	persistent part is memory that only one byte of each word holds: four
	planes of 128K, byte offset & 0x1ffff of plane offset >> 17 in byte
	lane 3 - plane of word offset & 0x1ffff, so consecutive offsets are
	four bytes apart; the ordinary part is plain memory.  (Only a RAM
	store reaches one, and TFlashStore::Init still refuses those.)
------------------------------------------------------------------------------*/

// ROM 0x001faf08 Init__12TStoreDriverFPcUlT1T2
void
TStoreDriver::Init(char* base, ULong size, char* persistentBase, ULong persistentSize)
{
	fBase = base;
	fSize = size;
	fPersistentBase = persistentBase;
	fPersistentSize = persistentSize;
	fTotalSize = size + persistentSize;
}


// ROM 0x001faf1c AddressOf__12TStoreDriverFUlPUc
// Where an offset's byte is, and (when asked) whether the bytes from it
// on are plain memory (linear) or a byte a word.
char*
TStoreDriver::AddressOf(ULong offset, UChar* isLinear)
{
	char* at;
	if (fPersistentSize > offset)
	{
		at = fPersistentBase + (offset & 0x1ffff) * 4 + (3 ^ (offset >> 17));
		if (isLinear != nil)
			*isLinear = false;
	}
	else
	{
		at = fBase + (offset - fPersistentSize);
		if (isLinear != nil)
			*isLinear = true;
	}
	return at;
}


// ROM 0x001faf74 AddressOfAligned__12TStoreDriverFUlPUc
// The same, but for the persistent part the word that holds the byte.
char*
TStoreDriver::AddressOfAligned(ULong offset, UChar* isLinear)
{
	char* at;
	if (fPersistentSize > offset)
	{
		at = fPersistentBase + (offset & 0x1ffff) * 4;
		if (isLinear != nil)
			*isLinear = false;
	}
	else
	{
		at = fBase + (offset - fPersistentSize);
		if (isLinear != nil)
			*isLinear = true;
	}
	return at;
}


// ROM 0x001fafc0 PersistentCopy__12TStoreDriverFUlN21
// A copy that can be carried on with after it was cut short: where it is
// from and to and how far it has got are kept in the driver, and it is
// started.  In plain memory it goes a word at a time (the count in words),
// in the persistent part a byte at a time; when the two overlap it goes
// the way that does not tread on what it has still to copy, from the end
// when it copies upwards.
void
TStoreDriver::PersistentCopy(ULong from, ULong to, ULong size)
{
	fCopyFrom = from;
	fCopyTo = to;
	UChar isLinear;
	AddressOf(from, &isLinear);
	fCopyCount = isLinear ? size >> 2 : size;
	fCopyIndex = 0;
	ULong distance = (from <= to) ? to - from : from - to;
	if (distance < size)
	{
		fOverlapping = true;
		if (fCopyFrom < fCopyTo)
			fCopyIndex = fCopyCount - 1;
	}
	else
		fOverlapping = false;
	fCopying = true;
	DoPersistentCopy(fCopyFrom, fCopyTo);
}


// ROM 0x001fb064 ContinuePersistentCopy__12TStoreDriverFv
// The copy under way, carried on (from the start when the two do not
// overlap: copying again what was copied does no harm).  Nothing here
// says the copy is over - fCopying stays set.
void
TStoreDriver::ContinuePersistentCopy(void)
{
	if (fCopying)
		DoPersistentCopy(fCopyFrom, fCopyTo);
}


// ROM 0x001fb07c DoPersistentCopy__12TStoreDriverFUlT1
// An overlapping copy keeps how far it has got in fCopyIndex before each
// word or byte, so ContinuePersistentCopy picks it up there.
void
TStoreDriver::DoPersistentCopy(ULong from, ULong to)
{
	if (fOverlapping)
	{
		if (fPersistentSize > from)
		{
			char* src = AddressOf(from, nil);
			char* dst = AddressOf(to, nil);
			long i = fCopyIndex;
			if (fCopyFrom < fCopyTo)
			{
				for ( ; i >= 0; i--)
				{
					fCopyIndex = i;
					dst[i * 4] = src[i * 4];
				}
			}
			else
			{
				for ( ; (long) fCopyCount > i; i++)
				{
					fCopyIndex = i;
					dst[i * 4] = src[i * 4];
				}
			}
		}
		else
		{
			ULong32* src = (ULong32*) AddressOfAligned(from, nil);
			ULong32* dst = (ULong32*) AddressOfAligned(to, nil);
			long i = fCopyIndex;
			if (fCopyFrom < fCopyTo)
			{
				for ( ; i >= 0; i--)
				{
					fCopyIndex = i;
					dst[i] = src[i];
				}
			}
			else
			{
				for ( ; (long) fCopyCount > i; i++)
				{
					fCopyIndex = i;
					dst[i] = src[i];
				}
			}
		}
	}
	else if (fPersistentSize > from)
	{
		char* src = AddressOf(from, nil);
		char* dst = AddressOf(to, nil);
		for (ULong i = 0; i < fCopyCount; i++)
			dst[i * 4] = src[i * 4];
	}
	else
	{
		char* dst = AddressOfAligned(to, nil);
		char* src = AddressOfAligned(from, nil);
		BlockMove(src, dst, fCopyCount * 4);
	}
}


// ROM 0x001fb244 Copy__12TStoreDriverFUlN21
// Bytes copied within the store, from the end when the two overlap and the
// copy goes upwards.  An overlapping copy goes by the kind of memory it
// starts from; a copy from one part to the other a byte a word on its
// persistent side.  (A run that crosses from one part to the other is not
// looked for.)
void
TStoreDriver::Copy(ULong from, ULong to, ULong size)
{
	UChar srcLinear, dstLinear;
	char* src = AddressOf(from, &srcLinear);
	char* dst = AddressOf(to, &dstLinear);
	ULong distance = (from <= to) ? to - from : from - to;
	if (distance < size)
	{
		if (from < to)
		{
			if (!srcLinear)
				for (long i = size - 1; i >= 0; i--)
					dst[i * 4] = src[i * 4];
			else
				for (long i = size - 1; i >= 0; i--)
					dst[i] = src[i];
		}
		else
		{
			if (!srcLinear)
				for (long i = 0; i < (long) size; i++)
					dst[i * 4] = src[i * 4];
			else
				for (long i = 0; i < (long) size; i++)
					dst[i] = src[i];
		}
	}
	else if (srcLinear == dstLinear)
	{
		if (!srcLinear)
			for (ULong i = 0; i < size; i++)
				dst[i * 4] = src[i * 4];
		else
			BlockMove(src, dst, size);
	}
	else if (!srcLinear)
		for (long i = 0; i < (long) size; i++)
			dst[i] = src[i * 4];
	else
		for (long i = 0; i < (long) size; i++)
			dst[i * 4] = src[i];
}


// ROM 0x001fb3d4 Set__12TStoreDriverFUlN21
// Bytes set to the low byte of value.
void
TStoreDriver::Set(ULong offset, ULong size, ULong value)
{
	UChar isLinear;
	char* at = AddressOf(offset, &isLinear);
	UChar byte = (UChar) value;
	if (isLinear)
		FillBytes(at, size, byte);
	else
		for (long i = 0; i < (long) size; i++)
			at[i * 4] = byte;
}


// ROM 0x001fb430 Read__12TStoreDriverFPcUlT2
void
TStoreDriver::Read(char* buffer, ULong offset, ULong size)
{
	UChar isLinear;
	char* at = AddressOf(offset, &isLinear);
	if (isLinear)
		BlockMove(at, buffer, size);
	else
		for (long i = 0; i < (long) size; i++)
			buffer[i] = at[i * 4];
}


// ROM 0x001fb49c Write__12TStoreDriverFPcUlT2
void
TStoreDriver::Write(char* buffer, ULong offset, ULong size)
{
	UChar isLinear;
	char* at = AddressOf(offset, &isLinear);
	if (isLinear)
		BlockMove(buffer, at, size);
	else
		for (long i = 0; i < (long) size; i++)
			at[i * 4] = buffer[i];
}


/*------------------------------------------------------------------------------
	T F l a s h S t o r e L o o k u p C a c h e
------------------------------------------------------------------------------*/

// ROM 0x000c4aa4 Matches__27SFlashStoreLookupCacheEntryFUli
// The same id in the same state; or, asked for state 0 (whatever a reader
// should see), in a state a reader sees.
Boolean
SFlashStoreLookupCacheEntry::Matches(PSSId id, int state)
{
	if (fId != id)
		return false;
	if (fState == state)
		return true;
	if (state == kObjNoState)
	{
		switch (fState)
		{
		case kRAMObjNew:
		case kRAMObjCommitted:
		case kRAMObjSuperceder:
		case kFlashObjNew:
		case kFlashObjCommitted:
		case kFlashObjSuperceder:
			return true;
		}
	}
	return false;
}


// The set an id's entries go in.
// ROM BUG (fixed): the set is the hash masked with ~fWays where
// ~(fWays - 1) was meant, so only bit 3 is cleared and the eight-entry sets
// overlap.  The fix masks with ~(fWays - 1): sets of eight on a boundary of
// eight.  (The cache is in RAM and every lookup asks the same CacheSet, so
// either is consistent.)
static inline SFlashStoreLookupCacheEntry*
CacheSet(TFlashStoreLookupCache* cache, PSSId id)
{
	if (RomBugFixed())
		return cache->fEntries + (HashPSSID(id) & (cache->fSize - 1) & ~(cache->fWays - 1));
	return cache->fEntries + (HashPSSID(id) & (cache->fSize - 1) & ~cache->fWays);
}


// ROM 0x000c4b10 Init__22TFlashStoreLookupCacheFUl
NewtonErr
TFlashStoreLookupCache::Init(ULong size)
{
	fSize = size;
	fNext = 0;
	fWays = 8;
	fEntries = (SFlashStoreLookupCacheEntry*) NewPtr(size * sizeof(SFlashStoreLookupCacheEntry));
	if (fEntries == nil)
		return -1;
	memset(fEntries, 0, fSize * sizeof(SFlashStoreLookupCacheEntry));
	return noErr;
}


// ROM 0x000c4bc8 Destroy__22TFlashStoreLookupCacheFv
void
TFlashStoreLookupCache::Destroy(void)
{
	DisposePtr((Ptr) fEntries);
	fEntries = nil;
}


// ROM 0x000c4bec Lookup__22TFlashStoreLookupCacheFUli
ULong
TFlashStoreLookupCache::Lookup(PSSId id, int state)
{
	SFlashStoreLookupCacheEntry* set = CacheSet(this, id);
	for (ULong i = 0; i < fWays; i++)
		if (set[i].Matches(id, state))
			return set[i].fDirEntOffset;
	return 0xFFFFFFFF;
}


// ROM 0x000c4c78 Add__22TFlashStoreLookupCacheFUlT1i
// An entry that matches is brought up to date; otherwise the next way in
// turn is replaced (the turn is the cache's, not the set's).
void
TFlashStoreLookupCache::Add(PSSId id, ULong dirEntOffset, int state)
{
	SFlashStoreLookupCacheEntry* set = CacheSet(this, id);
	for (ULong i = 0; i < fWays; i++)
	{
		if (set[i].Matches(id, state))
		{
			set[i].fDirEntOffset = dirEntOffset;
			return;
		}
	}
	set[fNext].fId = id;
	set[fNext].fState = state;
	set[fNext].fDirEntOffset = dirEntOffset;
	fNext = (fNext + 1) & (fWays - 1);
}


// ROM 0x000c4e28 Add__22TFlashStoreLookupCacheFR7TObjRef
void
TFlashStoreLookupCache::Add(TObjRef& ref)
{
	int state = ref.State();
	ULong dirEntOffset = ref.GetDirEntOffset();
	Add(ref.Id(), dirEntOffset, state);
}


// ROM 0x000c4d48 Forget__22TFlashStoreLookupCacheFUli
// Every entry for the id, whatever its state.
void
TFlashStoreLookupCache::Forget(PSSId id, int)
{
	SFlashStoreLookupCacheEntry* set = CacheSet(this, id);
	for (ULong i = 0; i < fWays; i++)
	{
		if (set[i].fId == id)
		{
			set[i].fId = 0;
			set[i].fDirEntOffset = 0;
		}
	}
}


// ROM 0x000c4dc4 Change__22TFlashStoreLookupCacheFUlT1i
void
TFlashStoreLookupCache::Change(PSSId id, ULong dirEntOffset, int state)
{
	HashPSSID(id);
	Forget(id, state);
	Add(id, dirEntOffset, state);
}


// ROM 0x000c4b6c Change__22TFlashStoreLookupCacheFR7TObjRef
void
TFlashStoreLookupCache::Change(TObjRef& ref)
{
	int state = ref.State();
	ULong dirEntOffset = ref.GetDirEntOffset();
	PSSId id = ref.Id();
	HashPSSID(id);
	Forget(id, state);
	Add(id, dirEntOffset, state);
}


// ROM 0x000c4e10 ForgetAll__22TFlashStoreLookupCacheFv
void
TFlashStoreLookupCache::ForgetAll(void)
{
	memset(fEntries, 0, fSize * sizeof(SFlashStoreLookupCacheEntry));
}


/*------------------------------------------------------------------------------
	T F l a s h T r a c k e r
------------------------------------------------------------------------------*/

// ROM 0x000cadbc __ct__13TFlashTrackerFv
TFlashTracker::TFlashTracker()
{
	fSize = 0;
	fCount = 0;
	fIds = nil;
	Init(0x80);
}


// ROM 0x000cae04 __dt__13TFlashTrackerFv
TFlashTracker::~TFlashTracker()
{
	Deinit();
}


// ROM 0x000cae30 Init__13TFlashTrackerFUl
// ROM QUIRK: the count is not set back (only the constructor clears it).
NewtonErr
TFlashTracker::Init(ULong size)
{
	Deinit();
	fOverflowed = false;
	fNesting = 0;
	fSize = size;
	fIds = (PSSId*) NewPtr(size * sizeof(PSSId));
	return MemError();
}


// ROM 0x000cae6c Deinit__13TFlashTrackerFv
void
TFlashTracker::Deinit(void)
{
	DisposePtr((Ptr) fIds);
	fIds = nil;
}


// ROM 0x000cae90 Add__13TFlashTrackerFUl
// Once it is full the commit has to walk the whole store.
void
TFlashTracker::Add(PSSId id)
{
	if (fOverflowed)
		return;
	fIds[fCount++] = id;
	if (fSize <= fCount)
		fOverflowed = true;
}


// ROM 0x000caec8 Remove__13TFlashTrackerFUl
void
TFlashTracker::Remove(PSSId id)
{
	for (ULong i = 0; i < fCount; i++)
	{
		if (fIds[i] == id)
		{
			fIds[i] = 0xFFFFFFFF;
			return;
		}
	}
}


/*------------------------------------------------------------------------------
	T O b j R e f
------------------------------------------------------------------------------*/

void
TObjRef::Init(TFlashStore* store)
{
	fWord0 = store->fVirginWord & 0x0FFFFFFF;
	fWord1 = 0;
	fOffset = 0xFFFFFFFF;
	fDirEntOffset = 0xFFFFFFFF;
	fStore = store;
	store->Add(this);
}


int
TObjRef::State(void)
{
	return gObjectTransBitsToState[(fStore->fVirginWord ^ ((fWord1 & 0xFFFF) >> 8)) & 0xFF];
}


// ROM 0x001482fc __as__7TObjRefFRC7TObjRef
// The header and where it is; not the store or the list.
TObjRef&
TObjRef::operator=(const TObjRef& other)
{
	fWord0 = other.fWord0;
	fWord1 = other.fWord1;
	fOffset = other.fOffset;
	fDirEntOffset = other.fDirEntOffset;
	return *this;
}


// ROM 0x00148318 Set__7TObjRefFUlT1
// The object at offset, or the one its directory entry points at, read.
// (The ROM has BasicRead inline.)
NewtonErr
TObjRef::Set(ULong offset, ULong dirEntOffset)
{
	fOffset = offset;
	fDirEntOffset = dirEntOffset;
	if (offset == 0xFFFFFFFF && dirEntOffset != 0xFFFFFFFF)
	{
		FlashWord entry;
		fStore->ReadWords(fStore->Translate(dirEntOffset), &entry, 1);
		fOffset = (entry >> 8) << 2;
	}
	fStore->ReadWords(fStore->Translate(fOffset), &fWord0, 2);
	return noErr;
}


// ROM 0x001483a4 FindSuperceeded__7TObjRefFR7TObjRef
// The committed object this copy replaces.  (The ROM has the store's
// Lookup inline.)
NewtonErr
TObjRef::FindSuperceeded(TObjRef& superceded)
{
	return fStore->Lookup(Id(), fStore->State(kRAMObjSuperceded), superceded);
}


// ROM 0x001488a0 FindSuperceeder__7TObjRefFR7TObjRef
// The copy that replaces this committed object.  (Lookup inline again.)
NewtonErr
TObjRef::FindSuperceeder(TObjRef& superceder)
{
	return fStore->Lookup(Id(), fStore->State(kRAMObjSuperceder), superceder);
}


// ROM 0x001483d0 Delete__7TObjRefFv
// Its directory entry and its header zapped.
NewtonErr
TObjRef::Delete(void)
{
	ULong dirEntOffset = GetDirEntOffset();
	if (dirEntOffset != 0xFFFFFFFF)
		fStore->BlockAt(dirEntOffset)->ZapDirEnt(dirEntOffset);
	fStore->BlockAt(fOffset)->ZapObject(fOffset);
	fWord0 |= 0x0FFFFFFF;
	return noErr;
}


// ROM 0x00148444 Write__7TObjRefFPvUlT2
// (The ROM has the store's BasicWrite inline.)
NewtonErr
TObjRef::Write(void* buffer, ULong offset, ULong size)
{
	return fStore->BasicWrite(fStore->Translate(fOffset + offset + 8), buffer, size);
}


// ROM 0x00148488 Read__7TObjRefFPvUlT2
// (BasicRead inline.)
NewtonErr
TObjRef::Read(void* buffer, ULong offset, ULong size)
{
	fStore->BasicRead(fStore->Translate(fOffset + offset + 8), buffer, size);
	return noErr;
}


// ROM 0x001484cc SetSeparateTranny__7TObjRefFv
// Into a transaction of its own: a header whose two bits are still both
// set has one cleared; one that has been through a separate transaction
// already cannot go back, so it is copied and the copy put in one.
NewtonErr
TObjRef::SetSeparateTranny(void)
{
	NewtonErr err = noErr;
	ULong bits = SeparateBits();
	if (bits == 0)
	{
		TObjRef copy;
		copy.Init(fStore);
		err = Clone(State(), copy, true);
		if (err == noErr)
		{
			Delete();
			*this = copy;
		}
		fStore->Remove(&copy);
	}
	else if (bits == 3)
	{
		fWord1 = (fWord1 & ~6) | 4;
		err = ReWriteObjHeader();
	}
	return err;
}


// ROM 0x001485b0 ClearSeparateTranny__7TObjRefFv
NewtonErr
TObjRef::ClearSeparateTranny(void)
{
	if (SeparateBits() == 2)
	{
		fWord1 &= ~6;
		return ReWriteObjHeader();
	}
	return noErr;
}


// ROM 0x001485f0 ReWriteObjHeader__7TObjRefFv
// (BasicWrite inline.)
NewtonErr
TObjRef::ReWriteObjHeader(void)
{
	return fStore->WriteWords(fStore->Translate(fOffset), &fWord0, 2);
}


// ROM 0x00148624 GetDirEntOffset__7TObjRefFv
// Found by looking the object up again when it was reached by its header.
ULong
TObjRef::GetDirEntOffset(void)
{
	if (fDirEntOffset == 0xFFFFFFFF)
	{
		TObjRef found;
		found.Init(fStore);
		if (fStore->Lookup(Id(), State(), found) == noErr)
			fDirEntOffset = found.fDirEntOffset;
		fStore->Remove(&found);
	}
	return fDirEntOffset;
}


// ROM 0x001486c4 CloneEmpty__7TObjRefFiUlR7TObjRefUc
// A new object with the same id, in the state given, not yet filled.
NewtonErr
TObjRef::CloneEmpty(int state, ULong size, TObjRef& clone, UChar separate)
{
	return fStore->AddObject(Id(), state, size, clone, separate, false);
}


// ROM 0x00148708 CloneEmpty__7TObjRefFiR7TObjRefUc
NewtonErr
TObjRef::CloneEmpty(int state, TObjRef& clone, UChar separate)
{
	return CloneEmpty(state, Size(), clone, separate);
}


// ROM 0x00148734 Clone__7TObjRefFiR7TObjRefUc
// Copied whole; a copy whose bytes did not all go down is thrown away and
// made again somewhere else.
NewtonErr
TObjRef::Clone(int state, TObjRef& clone, UChar separate)
{
	NewtonErr err;
	for (;;)
	{
		err = CloneEmpty(state, clone, separate);
		if (err == noErr)
			err = CopyTo(clone, 0, Size());
		if (err != kSError_WriteError)
			break;
		clone.Delete();
	}
	return err;
}


// ROM 0x001487a0 CopyTo__7TObjRefFR7TObjRefUlT2
// Part of this object's data into another's.
// ROM BUG (fixed): on a memory-mapped store the write's result, and on a
// TFlash the copy's, are dropped: the answer is always noErr.  The fix
// answers them (so Clone makes a copy that failed again).
NewtonErr
TObjRef::CopyTo(TObjRef& to, ULong offset, ULong size)
{
	ULong dst = fStore->Translate(to.fOffset + offset + 8);
	ULong src = fStore->Translate(fOffset + offset + 8);
	NewtonErr err = noErr;
	if (fStore->fStoreDriver == nil)
	{
		if (RomBugFixed())
		{
			if (!fStore->fUsesTFlash)
				err = fStore->BasicWrite(dst, fStore->fBase + src, size);
			else
				err = fStore->fFlash->Copy(src, dst, size);
		}
		else if (!fStore->fUsesTFlash)
			fStore->BasicWrite(dst, fStore->fBase + src, size);
		else
			fStore->fFlash->Copy(src, dst, size);
	}
	else
	{
		for (;;)
		{
			newton_try
			{
				fStore->fStoreDriver->Copy(src, dst, size);
			}
			newton_catch(exAbort)
			{
				err = kSError_WriteProtected;
			}
			end_try;
			if (err == noErr)
				break;
			fStore->SendAlertMgrWPBitch(0);
		}
	}
	return err;
}


// The header written in its new state: on flash the state's bits are
// cleared among those already cleared, in RAM they are simply set.
static NewtonErr
WriteState(TObjRef* ref, int state)
{
	if (!ref->fStore->fIsSRAM)
		ref->fWord1 &= ~((ULong) gObjectStateToTransBits[state] << 8);
	else
		ref->fWord1 = (ref->fWord1 & 0xFFFF00FF) | ((~(ULong) gObjectStateToTransBits[state] & 0xFF) << 8);
	return ref->fStore->WriteWords(ref->fStore->Translate(ref->fOffset), &ref->fWord0, 2);
}


// ROM 0x001487fc SetState__7TObjRefFi
// (BasicWrite inline.)
NewtonErr
TObjRef::SetState(int state)
{
	return WriteState(this, state);
}


// ROM 0x00148874 SetCommittedState__7TObjRefFv
// Committed, and out of any separate transaction.  (BasicWrite inline.)
NewtonErr
TObjRef::SetCommittedState(void)
{
	if (IsSeparate())
		fWord1 &= ~6;
	return WriteState(this, fStore->State(kRAMObjCommitted));
}
