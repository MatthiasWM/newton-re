/*
	File:		packages/ValidatePackage.h

	Contains:	The package validation driver and the pipe a package is fed
				to it through.

				TValidatePackageDriver is a protocol interface with no DDK
				header: the package manager makes one at its start
				(TPackageEventHandler::InitValidatePackageDriver,
				NewByName("TValidatePackageDriver", "TValidatePackage")) and,
				when there is one, asks it about every package before the
				package goes in (TPackageEventHandler::ValidatePackage):
				ValidateBegin with the package's name, where it lies (a
				package mapped from a store; nil for a streamed one), its
				size, and where its last part's data lies when the package's
				flag 0x01000000 says so; and for a package on a store that
				ValidateBegin did not settle, the package itself, backed up
				through a CValidateBackupPipe whose WriteChunk hands each
				block to ValidateNextBlock, and then ValidateEnd with what
				the backup came to.  What ValidateEnd answers is whether the
				package goes in.

				It is the hook a security add-on would use (a package
				signed, the signature in its last part).  No implementation
				is registered in a MessagePad as it ships - the U.S. ROM
				and its extension have none - so the manager's driver is
				always nil and nothing reaches any of this; a protocol part
				that registers a "TValidatePackage" implementation of this
				interface before the manager starts would.  The interface's
				methods are the ROM's ProtocolGen glue (0x00387ad4-
				0x00387b3c), here virtuals (protocols/Protocols.h).

	Reconstructed from the MP2x00 US ROM (0x0015dc14-0x0015dcac,
	0x0015e06c, 0x0015e7fc-0x0015fe48, 0x00387ad4-0x00387b3c); each
	function cites its origin.
*/

#ifndef __VALIDATEPACKAGE_H
#define __VALIDATEPACKAGE_H

#ifndef __PROTOCOLS_H
#include "Protocols.h"
#endif
#ifndef __PIPES_H
#include "Pipes.h"
#endif

// the package flag that says its last part's data is to be handed to
// ValidateBegin (the only reader of the bit in the ROM)
const ULong kValidateLastPartFlag = 0x01000000;


PROTOCOL TValidatePackageDriver : public TProtocol
{
public:
	static TValidatePackageDriver*	New(char* implementation);		// ROM 0x00387ad4 New__22TValidatePackageDriverSFPc
	void			Delete(void);										// ROM 0x00387b00 Delete__22TValidatePackageDriverFv

	// The package named, where it lies (nil: being streamed in), its size,
	// and where its last part's data is (nil: not asked for).  ==> noErr to
	// take it without more ado; kError_Bad_Package to refuse it; anything
	// else, for a package on a store, to be fed the package itself.
	VIRTUAL NewtonErr	ValidateBegin(UniChar* name, char* package, ULong size, char* lastPart) ENDVIRTUAL;	// ROM 0x00387b1c ValidateBegin__22TValidatePackageDriverFPUsPcUlT2
	// A block of the package, as BackupPackage writes it.
	VIRTUAL NewtonErr	ValidateNextBlock(char* data, ULong size) ENDVIRTUAL;	// ROM 0x00387b28 ValidateNextBlock__22TValidatePackageDriverFPcUl
	// The package has all been fed (err: what the backup came to); ==> the
	// verdict.
	VIRTUAL NewtonErr	ValidateEnd(long err) ENDVIRTUAL;					// ROM 0x00387b34 ValidateEnd__22TValidatePackageDriverFl
};


/*------------------------------------------------------------------------------
	C V a l i d a t e B a c k u p P i p e
	A pipe that only writes, every chunk going to the driver's
	ValidateNextBlock: the pipe BackupPackage is given when a package on a
	store is validated.  Everything else does nothing, every position is
	0.  (8 bytes in the ROM.)
------------------------------------------------------------------------------*/

class CValidateBackupPipe : public CPipe
{
public:
					CValidateBackupPipe();									// ROM 0x0015dc14 __ct__19CValidateBackupPipeFv
	virtual			~CValidateBackupPipe();									// ROM 0x0015dc5c __dt__19CValidateBackupPipeFv

	void			Init(TValidatePackageDriver* driver);					// ROM 0x0015e06c Init__19CValidateBackupPipeFP22TValidatePackageDriver

	virtual long	ReadSeek(long offset, int mode);						// ROM 0x0015e7fc ReadSeek__19CValidateBackupPipeFli
	virtual long	ReadPosition(void) const;								// ROM 0x0015fa88 ReadPosition__19CValidateBackupPipeCFv
	virtual long	WriteSeek(long offset, int mode);						// ROM 0x0015fe28 WriteSeek__19CValidateBackupPipeFli
	virtual long	WritePosition(void) const;								// ROM 0x0015fe30 WritePosition__19CValidateBackupPipeCFv
	virtual void	ReadChunk(void* data, long& count, Boolean& eof);		// ROM 0x0015fe38 ReadChunk__19CValidateBackupPipeFPvRlRUc
	virtual void	WriteChunk(const void* data, long count, Boolean flush);	// ROM 0x0015fe3c WriteChunk__19CValidateBackupPipeFPvlUc
	virtual void	FlushRead(void);										// ROM 0x0015fe44 FlushRead__19CValidateBackupPipeFv
	virtual void	FlushWrite(void);										// ROM 0x0015dc9c FlushWrite__19CValidateBackupPipeFv
	virtual void	Reset(void);											// ROM 0x0015dca0 Reset__19CValidateBackupPipeFv
	virtual void	Overflow(void);											// ROM 0x0015dca4 Overflow__19CValidateBackupPipeFv
	virtual void	Underflow(long count, Boolean& eof);					// ROM 0x0015dca8 Underflow__19CValidateBackupPipeFlRUc

	TValidatePackageDriver*	fDriver;		// +0x04
};

#endif	/* __VALIDATEPACKAGE_H */
