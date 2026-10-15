; "ScreenBuffer" part 0: protocol (256 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	; .origin: the address its first byte falls at, worked out where it is built

ClassInfoTable:
	.word 0x00000000			; fReserved1
	.word ImplementationName - .		; fNameDelta
	.word InterfaceName - .			; fInterfaceDelta
	.word Signature - .			; fSignatureDelta
	.word BTable - .			; fBTableDelta
	.word EntryProc - .			; fEntryProcDelta
	b 0x1e00000				; fSizeofBranch
	.word 0x00000000			; fAllocBranch
	.word 0x00000000			; fFreeBranch
	b 0x1e00004				; fDefaultNewBranch
	b 0x1e00008				; fDefaultDeleteBranch
	.word 0x00000000			; fVersion
	.word 0x00000000			; fFlags
	.word 0x00000000			; fSelectorBranch
	b Reserved2Target			; fReserved2

ClassInfo:
	adr r0, ClassInfoTable
	mov pc, lr

Reserved2Target:
	mov r0, #0
	mov pc, lr
ImplementationName:
	.asciz "TScreenMemory"
InterfaceName:
	.asciz "TReservedContiguousMemory"
Signature:
	.asciz ""
	.align 4
BTable:
	.word 0x00000000			; dispatch slot 0
	b ClassInfo				; dispatch slot 1
	b 0x1e00004				; dispatch slot 2
	b 0x1e00008				; dispatch slot 3
	b 0x1e0000c				; dispatch slot 4
	b 0x1e00010				; dispatch slot 5

EntryProc:
	mov r0, #0x10
	mov pc, lr

sub_0098:
	mov pc, lr

sub_009c:
	mov pc, lr

sub_00a0:
	mov ip, #0x13000
	ldr r0, [sp]
	str ip, [r1]
	ldr r1, lit_00c8
	str r1, [r2]
	mov r1, #0
	str r1, [r3]
	mov r1, #0x40000
	str r1, [r0]
	mov pc, lr
lit_00c8:
	.word 0x6c636464			; 'lcdd'

sub_00cc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, r1
	mov r3, #0
	stmdb sp!, {r3}
	mov r2, #0x13000
	ldr r1, lit_00f4
	bl GetContiguousMemory__FP6TUPhysUlT2UcT4
	ldmdb fp, {fp, sp, pc}
lit_00f4:
	.word 0x6c636464			; 'lcdd'

GetContiguousMemory__FP6TUPhysUlT2UcT4:
	ldr pc, lit_00fc
lit_00fc:
	.word 0x01802550			; glue 01802550 -> GetContiguousMemory__FP6TUPhysUlT2UcT4
