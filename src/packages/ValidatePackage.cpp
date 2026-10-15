/*
	File:		packages/ValidatePackage.cpp

	Contains:	TValidatePackageDriver's New/Delete glue and
				CValidateBackupPipe (ValidatePackage.h).  The manager's side,
				TPackageEventHandler::ValidatePackage, is in
				PackageManager.cpp.

	Reconstructed from the MP2x00 US ROM; each function cites its origin.
*/

#include "ValidatePackage.h"


/*------------------------------------------------------------------------------
	T V a l i d a t e P a c k a g e D r i v e r
------------------------------------------------------------------------------*/

// ROM 0x00387ad4 New__22TValidatePackageDriverSFPc
TValidatePackageDriver*
TValidatePackageDriver::New(char* implementation)
{
	TValidatePackageDriver* p = (TValidatePackageDriver*) AllocInstanceByName("TValidatePackageDriver", implementation);
	return p != nil ? (TValidatePackageDriver*) p->GlueNew() : nil;
}


// ROM 0x00387b00 Delete__22TValidatePackageDriverFv
void
TValidatePackageDriver::Delete(void)
{
	GlueDelete();
}


/*------------------------------------------------------------------------------
	C V a l i d a t e B a c k u p P i p e
------------------------------------------------------------------------------*/

// ROM 0x0015dc14 __ct__19CValidateBackupPipeFv
CValidateBackupPipe::CValidateBackupPipe()
{
	fDriver = nil;
}


// ROM 0x0015dc5c __dt__19CValidateBackupPipeFv
CValidateBackupPipe::~CValidateBackupPipe()
{ }


// ROM 0x0015e06c Init__19CValidateBackupPipeFP22TValidatePackageDriver
void
CValidateBackupPipe::Init(TValidatePackageDriver* driver)
{
	fDriver = driver;
}


// ROM 0x0015e7fc ReadSeek__19CValidateBackupPipeFli
long
CValidateBackupPipe::ReadSeek(long /*offset*/, int /*mode*/)
{
	return 0;
}


// ROM 0x0015fa88 ReadPosition__19CValidateBackupPipeCFv
long
CValidateBackupPipe::ReadPosition(void) const
{
	return 0;
}


// ROM 0x0015fe28 WriteSeek__19CValidateBackupPipeFli
long
CValidateBackupPipe::WriteSeek(long /*offset*/, int /*mode*/)
{
	return 0;
}


// ROM 0x0015fe30 WritePosition__19CValidateBackupPipeCFv
long
CValidateBackupPipe::WritePosition(void) const
{
	return 0;
}


// ROM 0x0015fe38 ReadChunk__19CValidateBackupPipeFPvRlRUc
// Nothing to read (the count and eof left as they were).
void
CValidateBackupPipe::ReadChunk(void* /*data*/, long& /*count*/, Boolean& /*eof*/)
{ }


// ROM 0x0015fe3c WriteChunk__19CValidateBackupPipeFPvlUc
// A block of the package handed to the driver (what it answers is not
// looked at).
void
CValidateBackupPipe::WriteChunk(const void* data, long count, Boolean /*flush*/)
{
	fDriver->ValidateNextBlock((char*) data, (ULong) count);
}


// ROM 0x0015fe44 FlushRead__19CValidateBackupPipeFv
void
CValidateBackupPipe::FlushRead(void)
{ }


// ROM 0x0015dc9c FlushWrite__19CValidateBackupPipeFv
void
CValidateBackupPipe::FlushWrite(void)
{ }


// ROM 0x0015dca0 Reset__19CValidateBackupPipeFv
void
CValidateBackupPipe::Reset(void)
{ }


// ROM 0x0015dca4 Overflow__19CValidateBackupPipeFv
void
CValidateBackupPipe::Overflow(void)
{ }


// ROM 0x0015dca8 Underflow__19CValidateBackupPipeFlRUc
void
CValidateBackupPipe::Underflow(long /*count*/, Boolean& /*eof*/)
{ }
