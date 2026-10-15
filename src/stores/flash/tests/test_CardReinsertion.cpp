// GetCardReinsertionInfo (stores/flash/PSSManager.h): where the package page
// the ROM domain manager noted (gCardReinsertionTracker) lies.  The host has
// no domain manager, so nothing ever notes one and the answer is false;
// here the tracker is filled in as the domain manager's Fault would, for a
// package (a fixture's) copied into a large object on a THostStore and
// mapped, and the part found is checked against the package's own
// directory.  Runs as the kernel services task (the companders need it).

#include "PSSManager.h"
#include "LargeObjects.h"
#include "StoreCompander.h"
#include "Store.h"
#include "Compression.h"
#include "PackageIterator.h"
#include "Boot.h"
#include "UserBoot.h"
#include "OSErrors.h"
#include "host/TaskRuntime.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; fprintf(stderr, "FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)


static UByte*
ReadFile(const char* path, long* size)
{
	FILE* f = fopen(path, "rb");
	if (f == nil)
		return nil;
	fseek(f, 0, SEEK_END);
	*size = ftell(f);
	fseek(f, 0, SEEK_SET);
	UByte* bytes = (UByte*) malloc(*size);
	if (fread(bytes, 1, *size, f) != (size_t) *size)
	{
		free(bytes);
		bytes = nil;
	}
	fclose(f);
	return bytes;
}


static void
Scenario()
{
	RegisterStoreImplementations();
	InitializeCompression();
	InitializeStoreCompanders();

	// nothing noted: false, the info untouched
	TCardReinsertionInfo info, before;
	memset(&info, 0xa5, sizeof(info));
	before = info;
	gCardReinsertionTracker.fReinserted = true;
	gCardReinsertionTracker.fStore = nil;
	EXPECT(!GetCardReinsertionInfo(&info) && memcmp(&info, &before, sizeof(info)) == 0);

	long size = 0;
	UByte* package = ReadFile(NEWTON_TEST_PACKAGE, &size);
	EXPECT(package != nil && size > 0);
	if (package == nil)
	{
		HostStopTasks();
		return;
	}
	TStore* store = TStore::New("THostStore");
	EXPECT(store != nil && store->Init(nil, 0x100000, 0, 0, kStoreIsInternal, nil) == noErr);
	store->Format();
	ULong id = 0, address = 0;
	EXPECT(CreateLargeObject(&id, store, size, (char*) "TSimpleStoreCompander", nil, 0) == noErr);
	EXPECT(MapLargeObject(&address, store, id, false) == noErr && address != 0);
	memcpy((void*) address, package, size);

	TPackageIterator iter((void*) address);
	EXPECT(iter.Init() == noErr && iter.NumberOfParts() >= 1);
	ULong last = iter.NumberOfParts() - 1;
	PartInfo first, lastPart;
	iter.GetPartInfo(0, &first);
	iter.GetPartInfo(last, &lastPart);

	// an address 0x10 into the last part
	gCardReinsertionTracker.fStore = store;
	gCardReinsertionTracker.fPackageId = id;
	gCardReinsertionTracker.fOffset = lastPart.data - address + 0x10;
	EXPECT(GetCardReinsertionInfo(&info));
	EXPECT(info.fPartIndex == last && info.fPartKind == lastPart.kind && info.fPartData == lastPart.data);
	EXPECT(info.fPartSize == lastPart.size && info.fOffset == 0x10);
	// the first byte of the first part's data
	gCardReinsertionTracker.fOffset = first.data - address;
	EXPECT(GetCardReinsertionInfo(&info) && info.fPartIndex == 0 && info.fOffset == 0);
	// in the directory, before any part: no part
	gCardReinsertionTracker.fOffset = 4;
	EXPECT(!GetCardReinsertionInfo(&info));
	// a package that is not mapped: false
	gCardReinsertionTracker.fPackageId = id + 1000;
	EXPECT(!GetCardReinsertionInfo(&info));

	gCardReinsertionTracker.fStore = nil;
	UnmapLargeObject(address);
	free(package);
	HostStopTasks();
}


int main()
{
	gHostKernelServicesTask = Scenario;
	OsBoot();
	if (failures == 0)
		printf("test_CardReinsertion: all passed\n");
	else
		printf("test_CardReinsertion: %d failures\n", failures);
	return failures != 0;
}
