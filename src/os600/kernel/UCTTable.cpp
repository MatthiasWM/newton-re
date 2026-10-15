/*
	File:		UCTTable.cpp

	Contains:	TUCTTable (UCTTable.h): thirty-two task queues a task is
				filed in by a key.  Public API only - nothing in the ROM
				makes one or calls these.

	Reconstructed from the MP2x00 US ROM (0x00256300-0x002563ec); each
	function cites its origin.
*/

#include "UCTTable.h"
#include "hal/Atomic.h"


// ROM 0x00256300 Add__9TUCTTableFP5TTaskUl
// The task filed by the key (kept in its fUnknown9c), the table its container.
void
TUCTTable::Add(TTask* task, ULong key)
{
	TTaskQueue* queue = QueueFor(key);
	EnterFIQAtomic();
	task->fUnknown9c = key;
	queue->Add(task, kTaskState_InUCTTable, this);
	ExitFIQAtomic();
}


// ROM 0x00256348 Remove__9TUCTTableFUl
// The first task filed by the key, taken out; nil for none.
TTask*
TUCTTable::Remove(ULong key)
{
	TTaskQueue* queue = QueueFor(key);
	EnterFIQAtomic();
	TTask* task = queue->FindAndRemove(key, kTaskState_InUCTTable);
	ExitFIQAtomic();
	return task;
}


// ROM 0x0025638c Remove__9TUCTTableFP5TTask
// The task taken out of the queue its key chose, if it is in the table.
// (The ROM answers whatever is left in r0 - the task's state when it is not
// in the table; the reconstruction answers the table, as TTaskContainer's
// does.)
TTaskContainer*
TUCTTable::Remove(TTask* task)
{
	if ((task->fState & kTaskState_InUCTTable) == 0)
		return this;
	TTaskQueue* queue = QueueFor(task->fUnknown9c);
	EnterFIQAtomic();
	queue->RemoveFromQueue(task, kTaskState_InUCTTable);
	ExitFIQAtomic();
	return this;
}


// ROM 0x002563d8 HeldBy__9TUCTTableFP5TTaskUl
// Whether the task's key is this one (whether or not it is in the table).
Boolean
TUCTTable::HeldBy(TTask* task, ULong key)
{
	return task->fUnknown9c == key;
}
