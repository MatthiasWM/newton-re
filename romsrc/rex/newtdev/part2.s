; " Newton Devices" part 2: protocol (660 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	; .origin: the address its first byte falls at, worked out where it is built

ClassInfoTable:
	.word 0x00000000			; fReserved1
	.word ImplementationName - .		; fNameDelta
	.word InterfaceName - .			; fInterfaceDelta
	.word Signature - .			; fSignatureDelta
	.word BTable - .			; fBTableDelta
	.word EntryProc - .			; fEntryProcDelta
	b EntryProc				; fSizeofBranch
	.word 0x00000000			; fAllocBranch
	.word 0x00000000			; fFreeBranch
	b DefaultNew				; fDefaultNewBranch
	b DefaultDelete				; fDefaultDeleteBranch
	.word 0x00010000			; fVersion
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
	.asciz "TDriverAPI"
InterfaceName:
	.asciz "TLanternDriverAPI"
Signature:
	.asciz ""
	.align 4
BTable:
	.word 0x00000000			; dispatch slot 0
	b ClassInfo				; dispatch slot 1
	b DefaultNew				; dispatch slot 2
	b DefaultDelete				; dispatch slot 3
	b Method4				; dispatch slot 4
	b Method5				; dispatch slot 5
	b Method6				; dispatch slot 6
	b Method7				; dispatch slot 7
	b Method8				; dispatch slot 8
	b Method9				; dispatch slot 9
	b Method10				; dispatch slot 10
	b Method11				; dispatch slot 11
	b Method12				; dispatch slot 12
	b Method13				; dispatch slot 13
	b Method14				; dispatch slot 14
	b Method15				; dispatch slot 15
	b Method16				; dispatch slot 16

EntryProc:
	mov r0, #0x14
	mov pc, lr

DefaultNew:
	mov pc, lr

Method11:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, r3
	ldr r3, [fp, #4]
	ldr ip, [r0, #0x10]!
	stmdb sp!, {r3}
	mov r3, lr
	mov r0, ip
	ldr ip, [ip]
	mov lr, pc
	add pc, ip, #0x3c
	ldmdb fp, {fp, sp, pc}

Method12:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #4]
	ldr r3, [r0, #0x10]!
	mov r0, #0xc
	ldr r1, [fp, #0x10]
	add r2, r0, r1, lsl #2
	add r1, fp, #8
	mov r0, r3
	ldr r3, [r3]
	mov lr, pc
	add pc, r3, #0x40
	ldmdb fp, {fp, sp, pc}

Method13:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #4]
	ldr r3, [r0, #0x10]!
	mov r0, #0xc
	ldr r1, [fp, #0x10]
	add r2, r0, r1, lsl #2
	add r1, fp, #8
	mov r0, r3
	ldr r3, [r3]
	mov lr, pc
	add pc, r3, #0x44
	ldmdb fp, {fp, sp, pc}

Method14:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #4]
	ldr ip, [r0, #0x10]!
	mov r0, #0xc
	ldr r1, [fp, #0x14]
	add r3, r0, r1, lsl #2
	add r2, fp, r0
	mov r0, ip
	ldr r1, [fp, #8]
	ldr ip, [ip]
	mov lr, pc
	add pc, ip, #0x48
	ldmdb fp, {fp, sp, pc}

Method15:
	ldr ip, [r0, #0x10]!
	mov r0, ip
	mov r3, #0
	mov r2, #0
	ldr ip, [ip]
	add pc, ip, #0x4c

Method16:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #4]
	ldr ip, [r0, #0x10]!
	ldr r0, [fp, #0xc]
	mov r3, r0, lsl #2
	add r2, fp, #0x10
	mov r0, ip
	ldr r1, [fp, #8]
	ldr ip, [ip]
	mov lr, pc
	add pc, ip, #0x4c
	ldmdb fp, {fp, sp, pc}

DefaultDelete:
	mov pc, lr

Method4:
	str r1, [r0, #0x10]!
	mov r0, #0
	mov pc, lr

Method5:
	and r2, r2, #0xff
	ldr r3, [r0, #0x10]!
	mov r0, r3
	ldr r3, [r3]
	add pc, r3, #0x24

Method6:
	and r2, r2, #0xff
	ldr r3, [r0, #0x10]!
	mov r0, r3
	ldr r3, [r3]
	add pc, r3, #0x28

Method7:
	ldr r2, [r0, #0x10]!
	mov r0, r2
	ldr r2, [r2]
	add pc, r2, #0x2c

Method8:
	ldr r3, [r0, #0x10]!
	mov r0, r3
	ldr r3, [r3]
	add pc, r3, #0x30

Method9:
	ldr r0, [r0, #0x10]
	ldr r1, [r0]
	add pc, r1, #0x34

Method10:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #4]
	add r2, fp, #0x18
	ldr r3, [r0, #0x10]!
	mov r0, r3
	ldr r1, [fp, #8]
	ldr r3, [r3]
	mov lr, pc
	add pc, r3, #0x38
	ldmdb fp, {fp, sp, pc}
