// Host unit test for TUCTTable (src/os600/kernel/UCTTable.*): tasks filed by
// a key in the queue its bits 4-8 choose, found and taken out by the key or
// by the task, HeldBy comparing the task's key.

#include "UCTTable.h"
#include "hal/Atomic.h"

#include <stdio.h>
#include <string.h>

static int failures = 0;
#define EXPECT(cond) do { if (!(cond)) { failures++; printf("FAIL %s:%d: %s\n", __FILE__, __LINE__, #cond); } } while (0)

int main()
{
	TUCTTable* table = new TUCTTable;
	memset(table->fUnknown04, 0, sizeof(table->fUnknown04));
	TTask* a = new TTask;
	TTask* b = new TTask;
	TTask* c = new TTask;

	// a and b under keys of the same queue (0x120 and 0x12f: bits 4-8 are
	// 0x12), c under one of another (0x130)
	table->Add(a, 0x120);
	table->Add(b, 0x12f);
	table->Add(c, 0x130);
	EXPECT(a->fUnknown9c == 0x120 && (a->fState & kTaskState_InUCTTable) && a->fContainer == table);
	EXPECT(table->fQueues[0x12].Peek() == a && table->fQueues[0x13].Peek() == c);
	EXPECT(table->HeldBy(b, 0x12f) && !table->HeldBy(b, 0x120));

	// by key: the task filed under that key, not the first in its queue
	EXPECT(table->Remove((ULong) 0x12f) == b);
	EXPECT((b->fState & kTaskState_InUCTTable) == 0 && b->fContainer == nil);
	EXPECT(table->Remove((ULong) 0x12f) == nil);
	EXPECT(table->fQueues[0x12].Peek() == a);
	// HeldBy looks only at the key: b still has it
	EXPECT(table->HeldBy(b, 0x12f));

	// by task: through its container, as the kernel would
	EXPECT(a->fContainer->Remove(a) == table);
	EXPECT((a->fState & kTaskState_InUCTTable) == 0 && table->fQueues[0x12].Peek() == nil);
	// a task not in the table is left alone
	EXPECT(table->Remove(a) == table && a->fState == 0);
	EXPECT(table->Remove(c) == table && table->fQueues[0x13].Peek() == nil);

	// FIQs masked and unmasked again around each change
	int atomic = 0, fiq = 0;
	HostAtomicNesting(&atomic, &fiq);
	EXPECT(fiq == 0);

	if (failures == 0)
		printf("test_UCTTable: all passed\n");
	else
		printf("test_UCTTable: %d failures\n", failures);
	return failures != 0;
}
