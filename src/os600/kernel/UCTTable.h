/*
	File:		UCTTable.h

	Contains:	TUCTTable: thirty-two task queues, a task filed in one by a
				key - the key kept in the task's fUnknown9c (the word
				TTaskQueue::FindAndRemove looks for), the queue the key's
				bits 4-8 choose - with the task's state bit 0x4000 set while
				it is in one.  The table is the queued task's container (so a
				task leaving it through its container is taken out of its
				queue).  Each change is made with FIQs masked.

				The ROM has only these four functions, in the public jump
				table: nothing in the ROM makes a TUCTTable or calls them,
				so what the table was for, what its name stands for and
				what its first 0x10 bytes after the vtable held are not
				known.  The DDK does not declare it.

	Layout:		vtable +0 (the TTaskContainer's), four words +4-+0x10 not
				used by these functions, the queues +0x14 (8 bytes each).

	Reconstructed from the MP2x00 US ROM (0x00256300-0x002563ec); each
	function cites its origin.
*/

#ifndef __UCTTABLE_H
#define __UCTTABLE_H

#ifndef __TASK_H
#include "Task.h"
#endif

const ULong kUCTTableQueues = 32;


class TUCTTable : public TTaskContainer
{
	public:
		void			Add(TTask* task, ULong key);					// ROM 0x00256300 Add__9TUCTTableFP5TTaskUl
		TTask*			Remove(ULong key);								// ROM 0x00256348 Remove__9TUCTTableFUl - the first task filed by the key
		virtual TTaskContainer*	Remove(TTask* task);					// ROM 0x0025638c Remove__9TUCTTableFP5TTask
		Boolean			HeldBy(TTask* task, ULong key);					// ROM 0x002563d8 HeldBy__9TUCTTableFP5TTaskUl - the task's key is this one

		ULong			fUnknown04[4];		// +0x04
		TTaskQueue		fQueues[kUCTTableQueues];	// +0x14

	private:
		TTaskQueue*		QueueFor(ULong key)	{ return &fQueues[(key >> 4) & 0x1f]; }
};

#endif	/* __UCTTABLE_H */
