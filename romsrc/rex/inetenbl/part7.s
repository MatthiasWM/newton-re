; "Newton Internet Enabler" part 7: protocol (6524 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	; .origin: the address its first byte falls at, worked out where it is built

ClassInfoTable:
	.word 0x00000000			; fReserved1
	.word ImplementationName - .		; fNameDelta
	.word InterfaceName - .			; fInterfaceDelta
	.word Signature - .			; fSignatureDelta
	.word BTable - .			; fBTableDelta
	.word AllocInstanceByName__FPCcT1 - .	; fEntryProcDelta
	b Sizeof				; fSizeofBranch
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
	.asciz "PSerialDriverModule"
InterfaceName:
	.asciz "PStrDriverModule"
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

AllocInstanceByName__FPCcT1:
	ldr pc, lit_00b8
lit_00b8:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

Sizeof:
	mov r0, #0x40
	mov pc, lr

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x10]
	str r1, [r0, #0x14]
	str r1, [r0, #0x18]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x38]
	mvn r1, #0
	str r1, [r0, #0x20]
	mov pc, lr

Method11:
	mvn r0, #3
	mov pc, lr

Method12:
	mov r0, #0
	mov pc, lr

Method13:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, #1
	strb r4, [r0, #0x25]
	mov r2, r1, lsl #16
	mov r2, r2, lsr #16
	sub r2, r2, #3
	mov r1, r1, lsr #16
	cmp r2, #8
	addls pc, pc, r2, lsl #2
	b loc_0188
	b loc_0150
	b loc_0164
	b loc_018c
	b loc_018c
	b loc_0188
	b loc_0188
	b loc_0188
	b loc_0188

sub_0148:
	bl sub_0344
	b loc_018c
loc_0150:
	ldr r2, [r0, #0x3c]
	ldr r2, [r2, #0x50]
	ldr r0, [r0, #0x1c]
	bl sub_1194
	b loc_018c
loc_0164:
	ldr r2, [r0, #0x3c]
	ldr r3, [r2, #0x88]
	stmdb sp!, {r3}
	ldr r3, [r2, #0x94]
	ldr r2, [r2, #0xe8]
	ldr r0, [r0, #0x1c]
	bl sub_11bc
	add sp, sp, #4
	b loc_018c
loc_0188:
	mov r4, #0
loc_018c:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

Method14:
	ldr r0, [r0, #0x20]
	mov pc, lr

Method15:
	mov r0, #0
	str r0, [r1]
	mov pc, lr

sub_01a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r1, [r0, #0x38]
	mov r0, #0
	bl __ct__15TOptionIteratorFP12TOptionArray
	movs r6, r0
	mov r7, #0x7a
	sub r7, r7, #0x3f00
	moveq r5, r7
	subeq sp, sp, #8
	beq loc_022c
	mov r0, r4
	mov r1, #0
	bl sub_03e0
	movs r5, r0
	subne sp, sp, #8
	bne loc_0220
	mov r0, r6
	ldr r1, lit_023c
	bl FindOption__15TOptionIteratorFUl
	sub sp, sp, #8
	teq r0, #0
	ldrne r1, [r0, #0x10]!
	teqne r1, #0
	bne loc_0240
	mov r5, r7
	mov r0, r4
	bl sub_07bc
loc_0220:
	mov r0, r6
	mov r1, #1
	bl __dt__15TOptionIteratorFv
loc_022c:
	mov r1, r5
	mov r0, r4
	bl sub_0838
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_023c:
	.word 0x73696420			; 'sid '
loc_0240:
	ldr r0, [r4, #0x3c]
	add r7, r0, #0xc
	mov r0, sp
	bl __ct__6TUPortFUl
	mov r0, r7
	ldr r1, [sp]
	bl CopyObject__8TUObjectFCUl
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, #5
	ldr r1, [r4, #0x3c]
	str r0, [r1, #4]!
	mov r0, r4
	bl sub_02c0
	b loc_0220

sub_0280:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0x3c]
	teq r0, #0
	moveq r5, #0x79
	subeq r5, r5, #0x3f00
	beq loc_02b0
	mov r0, r4
	bl sub_07bc
loc_02b0:
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_0840

sub_02c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [r0, #0x3c]
	teq r0, #0
	addne r1, r0, #0xc
	movne r5, r1
	ldrne r1, [r1]
	teqne r1, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	add ip, r0, #0x98
	add lr, r0, #0xa8
	add r0, r0, #0xb0
	mov r1, #0x24
	mov r2, #0
	mov r3, #0
	mov r4, #8
	mov r6, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	mov r2, #1
	mov r1, r4
	mov r0, #8
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, lr
	stmdb sp!, {r3}
	add r0, ip, r0
	ldr r2, [r0]
	mov r0, r5
	mov r3, #0
	ldr r1, [ip]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0344:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x3c]
	teq r0, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	ldr r1, [r0, #0xc0]
	teq r1, #2
	ldreq r0, [r0, #0xbc]
	teqeq r0, #0x24
	mov r0, r4
	ldmdbne fp, {r4, fp, sp, lr}
	bne sub_02c0
	mov r1, #0
	bl sub_0858
	ldr r0, [r4, #0x3c]
	ldr r1, [r0]
	ldr r0, [r4, #0x1c]!
	ldmdb fp, {r4, fp, sp, lr}
	b sub_0d60

sub_0398:
	mov r1, #0
	strb r1, [r0, #0x25]
	ldr r2, [r0, #0x3c]
	teq r2, #0
	moveq r1, #0x79
	subeq r1, r1, #0x3f00
	b loc_0850

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl Method10
	mov r1, #0x100
	ldr r0, [r4, #0x18]
	bl sub_1668
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_07bc

sub_03e0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r0, #0xec
	bl __nw__FUi
	movs r6, r0
	mov r7, #0
	beq loc_0458
	strb r7, [r6, #0x10]
	str r7, [r6, #0xc]
	add r0, r6, #0x14
	bl __ct__19TCommToolPutRequestFv
	add r0, r6, #0x30
	bl __ct__14TUAsyncMessageFv
	add r0, r6, #0x40
	bl __ct__17TCommToolPutReplyFv
	add r0, r6, #0x54
	bl __ct__19TCommToolGetRequestFv
	add r0, r6, #0x70
	bl __ct__14TUAsyncMessageFv
	add r0, r6, #0x80
	bl __ct__17TCommToolGetReplyFv
	add r0, r6, #0x98
	bl __ct__14TUAsyncMessageFv
	add r0, r6, #0xa8
	bl __ct__15TCommToolAEventFv
	add r0, r6, #0xb0
	bl __ct__22TCommToolGetEventReplyFv
loc_0458:
	movs r0, r6
	str r6, [r4, #0x3c]
	moveq r6, #0xe9
	subeq r6, r6, #0x2800
	beq loc_0534
	str r5, [r0]
	ldr r0, [r4, #0x3c]
	str r7, [r0, #4]!
	ldr r0, [r4, #0x3c]
	strb r7, [r0, #8]
	mov r0, #3
	orr r2, r0, r5, lsl #16
	ldr r0, [r4, #0x3c]
	add r1, r0, #0x30
	mov r0, r4
	bl sub_0764
	movs r6, r0
	bne loc_0534
	mov r0, #4
	orr r2, r0, r5, lsl #16
	ldr r0, [r4, #0x3c]
	add r1, r0, #0x70
	mov r0, r4
	bl sub_0764
	movs r6, r0
	bne loc_0534
	mov r0, #0xb
	orr r2, r0, r5, lsl #16
	ldr r0, [r4, #0x3c]
	add r1, r0, #0x98
	mov r0, r4
	bl sub_0764
	movs r6, r0
	bne loc_0534
	ldr r0, [r4, #0x3c]
	str r7, [r0, #0x28]!
	ldr r0, [r4, #0x3c]
	str r7, [r0, #0x2c]!
	ldr r0, [r4, #0x3c]
	str r7, [r0, #0x68]!
	ldr r0, [r4, #0x3c]
	str r7, [r0, #0x6c]!
	ldr r0, [r4, #0x3c]
	str r7, [r0, #0xe8]!
	ldr r0, [r4, #0x3c]
	str r7, [r0, #0xdc]!
	mov r0, #0x26c
	ldr r1, [r4, #0x3c]
	str r0, [r1, #0xd4]!
	ldr r1, [r4, #0x3c]
	str r0, [r1, #0xe0]!
	mov r2, r5
	ldr r0, [r4, #0x1c]!
	ldr r1, [r4, #0x20]!
	bl sub_121c
loc_0534:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_053c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r8, #0
	mov r7, #0
	ldr r0, [r0, #0x3c]
	teq r0, #0
	moveq r6, #0x79
	subeq r6, r6, #0x3f00
	beq loc_075c
	ldr r0, [r0, #0xdc]
	mov sb, #0xe9
	sub sb, sb, #0x2800
	ldr r5, lit_0680
	mov sl, #0
	teq r0, #0
	bne loc_0624
	bl sub_1854
	ldr r1, [r4, #0x3c]
	str r0, [r1, #0xd8]!
	teq r0, #0
	ldr r1, [r4, #0x3c]
	beq loc_0678
	ldr r0, [r1, #0xd4]!
	mov r1, r5
	bl NewNamedPtr
	ldr r1, [r4, #0x3c]
	str r0, [r1, #0xdc]!
	teq r0, #0
	beq loc_0678
	bl sub_185c
	movs r8, r0
	beq loc_0678
	mvn r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	ldr r0, [r4, #0x3c]
	ldr r2, [r0, #0xd4]!
	ldr r1, [r0, #8]
	mov r0, r8
	mov r3, #1
	bl Init__14CBufferSegmentFPvlUcN22
	add sp, sp, #8
	movs r6, r0
	bne loc_06ec
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xd8]
	mov r1, #1
	bl Init__11CBufferListFUc
	movs r6, r0
	bne loc_06ec
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xd8]
	mov r1, r8
	bl InsertLast__11CBufferListFP7CBuffer
	movs r6, r0
	bne loc_06ec
loc_0624:
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xe8]
	teq r0, #0
	bne loc_06e4
	bl sub_1854
	ldr r1, [r4, #0x3c]
	str r0, [r1, #0xe4]!
	teq r0, #0
	ldr r1, [r4, #0x3c]
	beq loc_0678
	ldr r0, [r1, #0xe0]!
	mov r1, r5
	bl NewNamedPtr
	ldr r1, [r4, #0x3c]
	str r0, [r1, #0xe8]!
	teq r0, #0
	moveq r6, sb
	beq loc_0728
	bl sub_185c
	movs r7, r0
	bne loc_0684
loc_0678:
	mov r6, sb
	b loc_070c
lit_0680:
	.word 0x4d555820			; 'MUX '
loc_0684:
	mvn r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	ldr r0, [r4, #0x3c]
	ldr r2, [r0, #0xe0]!
	ldr r1, [r0, #8]
	mov r0, r7
	mov r3, #1
	bl Init__14CBufferSegmentFPvlUcN22
	add sp, sp, #8
	movs r6, r0
	bne loc_06ec
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xe4]
	mov r1, #1
	bl Init__11CBufferListFUc
	movs r6, r0
	bne loc_06ec
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xe4]
	mov r1, r7
	bl InsertLast__11CBufferListFP7CBuffer
	movs r6, r0
	bne loc_06ec
loc_06e4:
	mov r6, #0
	b loc_075c
loc_06ec:
	teq r6, #0
	beq loc_075c
	teq r7, #0
	beq loc_070c
	mov r0, r7
	mov r1, #1
	bl __dt__14CBufferSegmentFv
	b loc_0728
loc_070c:
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xe8]
	teq r0, #0
	beq loc_0728
	bl free
	ldr r0, [r4, #0x3c]
	str sl, [r0, #0xe8]!
loc_0728:
	teq r8, #0
	beq loc_0740
	mov r0, r8
	mov r1, #1
	bl __dt__14CBufferSegmentFv
	b loc_075c
loc_0740:
	ldr r0, [r4, #0x3c]
	ldr r0, [r0, #0xdc]
	teq r0, #0
	beq loc_075c
	bl free
	ldr r0, [r4, #0x3c]!
	str sl, [r0, #0xdc]!
loc_075c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_0764:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	mov r0, r1
	mov r1, #1
	bl Init__14TUAsyncMessageFUc
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r5
	mov r0, r4
	bl SetUserRefCon__14TUSharedMemMsgFUl
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r6, #0x34]!
	ldr r1, [r0]
	mov r0, r4
	bl SetCollectorPort__14TUAsyncMessageFUl
	teq r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_07bc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x3c]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r2, [r0]
	mov r1, #0
	ldr r0, [r4, #0x1c]
	bl sub_121c
	mov r6, #0
	ldr r5, [r4, #0x3c]
	teq r5, #0
	beq loc_0830
	add r0, r5, #0x98
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0x70
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0x30
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0xc
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r5
	bl __dl__FPv
loc_0830:
	str r6, [r4, #0x3c]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0838:
	str r1, [r0, #0x28]!
	mov pc, lr
loc_0840:
	ldrb r2, [r0, #0x24]
	teq r2, #0
	streq r1, [r0, #0x2c]!
	mov pc, lr
loc_0850:
	str r1, [r0, #0x30]!
	mov pc, lr

sub_0858:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0xf
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x10]
	mov r1, sp
	bl sub_183c
	ldmdb fp, {fp, sp, pc}

sub_0880:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #7
	ldr ip, [fp, #4]
	sub sp, sp, #0x14
	stmda sp!, {r1, r2, r3, ip}
	str lr, [sp]
	ldr r0, [r0, #0x10]
	mov r1, sp
	bl sub_183c
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

Method4:
	mov r0, #1
	mov pc, lr

sub_08bc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #8
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x10]
	mov r1, sp
	bl sub_183c
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_08ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r2, #0
	bl sub_1678
	mov r7, r0
	ldr r8, [r6, #0xd4]
	cmp r8, r0
	bge loc_0964
	add r0, r7, #0x32
	str r0, [r6, #0xd4]
	ldr r1, lit_09ac
	bl NewNamedPtr
	teq r0, #0
	streq r8, [r6, #0xd4]!
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	str r0, [r6, #0xdc]
	ldr r0, [r6, #0xd8]
	bl Last__11CBufferListFv
	mvn r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	mov r3, #1
	ldr r1, [r6, #0xdc]
	ldr r2, [r6, #0xd4]
	bl Init__14CBufferSegmentFPvlUcN22
	add sp, sp, #8
loc_0964:
	mov r3, r7
	mov r1, r4
	mov r0, r5
	ldr r2, [r6, #0xdc]
	bl sub_1688
	ldr r0, [r6, #0xd8]!
	bl Last__11CBufferListFv
	movs r4, r0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r0, r4
	bl Reset__14CBufferSegmentFv
	mov r0, r4
	bl GetSize__14CBufferSegmentCFv
	sub r1, r0, r7
	mov r0, r4
	mov r2, #1
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b Hide__14CBufferSegmentFli
lit_09ac:
	.word 0x4d555820			; 'MUX '

sub_09b0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [r1, #0xd8]
	str r0, [r1, #0x1c]
	mvn r0, #0
	mov ip, #0
	str r0, [r1, #0x20]
	strb ip, [r1, #0x24]
	strb ip, [r1, #0x25]
	add r4, r1, #0xc
	add lr, r1, #0x30
	add r5, r1, #0x14
	add r0, r1, #0x40
	mov r1, #0x14
	mov r2, #0
	mov r3, #0
	mov r6, #2
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, ip
	mov r2, #1
	mov r1, r6
	mov r0, #0x1c
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	stmdb sp!, {r3}
	mov r0, r4
	mov r3, #0
	ldr r1, [lr], #8
	ldr r2, [lr]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0a30:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r0, [r1, #0xe4]!
	bl Reset__11CBufferListFv
	ldr r0, [r4, #0xe4]
	str r0, [r4, #0x5c]
	mov r0, #1
	strb r0, [r4, #0x64]
	mov ip, #0
	str r0, [r4, #0x60]
	strb ip, [r4, #0x65]
	strb ip, [r4, #0x66]
	add r5, r4, #0xc
	add lr, r4, #0x70
	add r6, r4, #0x54
	add r0, r4, #0x80
	mov r1, #0x18
	mov r2, #0
	mov r3, #0
	mov r4, #1
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, ip
	mov r2, #1
	mov r1, r4
	mov r0, #0x1c
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #0
	ldr r1, [lr], #8
	ldr r2, [lr]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0ac0:
	ldr r0, [r1, #4]!
	teq r0, #5
	movne r0, #0
	moveq r0, #1
	and r0, r0, #0xff
	mov pc, lr

Method5:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r0, r0, #0x10
	stmia r0, {r1, r2, r3}
	sub r0, r0, #0x10
	mov r0, r3
	ldr r3, lit_0b38
	ldr r2, lit_0b3c
	ldr r1, lit_0b40
	bl sub_1660
	teq r0, #1
	movne r0, #0xa8
	subne r0, r0, #0x1c00
	ldmdbne fp, {r4, fp, sp, pc}
	mov r1, #0x100
	ldr r0, [r4, #0x18]
	bl sub_1690
	str r0, [r4, #0x1c]
	mov r1, r4
	bl sub_16c8
	mov r0, #0
	ldmdb fp, {r4, fp, sp, pc}
lit_0b38:
	.rword sub_0dc4				; relocated
lit_0b3c:
	.rword sub_1288				; relocated
lit_0b40:
	.rword data_177c			; relocated

Method6:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r0, r0, #0x34
	stmia r0, {r1, r2}
	sub r0, r0, #0x34
	mov r0, #1
	strb r0, [r4, #0x24]
	mov r0, #0
	strb r0, [r4, #0x25]
	mov r0, r4
	bl sub_01a8
	ldr r0, [r4, #0x28]!
	ldmdb fp, {r4, fp, sp, pc}

Method7:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	strb r0, [r4, #0x24]
	strb r0, [r4, #0x25]
	mov r0, r4
	bl sub_0280
	ldr r0, [r4, #0x2c]!
	ldmdb fp, {r4, fp, sp, pc}

Method8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	strb r0, [r4, #0x25]
	mov r0, r4
	bl sub_0398
	ldr r0, [r4, #0x30]!
	ldmdb fp, {r4, fp, sp, pc}

Method9:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x20]
	cmn r0, #1
	movne r0, r4
	blne Method10
	ldr r3, [r4, #0x14]
	stmdb sp!, {r3}
	mov r0, r4
	mov r3, #0
	mov r2, #0
	mov r1, #0x100
	bl sub_0880
	add sp, sp, #4
	str r0, [r4, #0x20]
	cmp r0, #0
	mvnlt r0, #0
	strlt r0, [r4, #0x20]!
	movlt r0, #0x8e
	sublt r0, r0, #0xeb00
	ldmdblt fp, {r4, r5, fp, sp, pc}
	mov r0, r4
	bl sub_053c
	mov r5, r0
	cmp r0, #0
	bne loc_0c68
	ldr r0, [r4, #0x3c]
	ldr r1, [r0]
	ldr r0, [r4, #0x1c]
	bl sub_0d9c
	ldr r0, [r4, #0x3c]
	ldr r1, [r0]
	ldr r0, [r4, #0x1c]!
	bl sub_161c
	b loc_0c70
loc_0c68:
	movne r0, r4
	blne Method10
loc_0c70:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

Method10:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x20]
	cmn r0, #1
	beq loc_0cac
	mov r0, r4
	mov r2, #0
	mov r1, #0x100
	bl sub_08bc
	mvn r0, #0
	str r0, [r4, #0x20]!
loc_0cac:
	mov r0, #0
	ldmdb fp, {r4, fp, sp, pc}

sub_0cb4:
	teq r3, #2
	ldr r2, [r0, #4]
	mvneq r0, #0
	moveq pc, lr
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	cmp r1, #2
	mvnge r0, #1
	movge pc, lr
	ldr r3, [r0, #0x18]
	teq r3, #0
	bne loc_0d18
	add r3, r1, r1, lsl #2
	add r2, r2, r3, lsl #3
	add r2, r2, #0x18
	str r2, [r0, #0x18]
	ldr ip, [r0, #0x30]
	str r2, [ip, #0x18]!
	str r0, [r2, #4]
	ldr r0, [r0, #0x30]
	str r0, [r2, #8]
	mov r0, #1
	strb r0, [r2, #1]
	mov r0, #0
	strb r0, [r2]
loc_0d18:
	mov r0, r1
	mov pc, lr

sub_0d20:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, r0
	ldr r0, [r0, #4]
	mov r5, #0
	ldr r4, [r1, #0x18]!
	teq r4, #0
	moveq r0, r5
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r1, r4
	bl sub_1238
	mov r0, r5
	strb r5, [r4, #1]
	strb r5, [r4]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0d60:
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	add r1, r1, r1, lsl #2
	add r0, r0, r1, lsl #3
	add r0, r0, #0x18
	mov r1, #2
	str r1, [r0, #0x18]!
	mov pc, lr

sub_0d80:
	ldr r1, [r0, #0x18]
	tst r1, #2
	moveq r0, #0
	bicne r1, r1, #2
	strne r1, [r0, #0x18]!
	movne r0, #1
	mov pc, lr

sub_0d9c:
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	add r1, r1, r1, lsl #2
	add r0, r0, r1, lsl #3
	add r0, r0, #0x18
	mov r1, #2
	strb r1, [r0, #1]
	mov r1, #0
	strb r1, [r0]
	mov pc, lr

sub_0dc4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r6, r0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r8, #0
	mov sl, #3
	mov sb, #1

sub_0de8:
	add r0, r8, r8, lsl #2
	add r0, r6, r0, lsl #3
	add r5, r0, #0x18
	ldr r0, [r5]
	movs r0, r0, lsr #16
	beq loc_1068
	ldr r0, [r5, #0x1c]
	teq r0, #0
	bne loc_0e28
	mov r1, r5
	mov r0, r6
	bl sub_1238
	mov r0, #0
	strb r0, [r5, #1]
	strb r0, [r5]
	b loc_1068
loc_0e28:
	mov r0, r5
	bl sub_163c
	teq r0, #1
	ldreq r0, [r5]
	moveq r0, r0, lsr #16
	teqeq r0, #2
	bne loc_0e58
	strb sl, [r5, #1]
	mov r0, #0
	strb r0, [r5]
	strb sb, [r5, #0x17]
	strb r0, [r5, #0x16]
loc_0e58:
	mov r0, r5
	bl sub_0d80
	teq r0, #1
	bne loc_0ef8
	mov r7, #0
	strb r7, [r5, #0x17]
	strb r7, [r5, #0x16]
	ldr r0, [r5]
	mov r0, r0, lsr #16
	teq r0, #2
	bne loc_0ea4
	strb sb, [r5, #1]
	strb r7, [r5]
	mov r1, r5
	mov r0, r6
	mvn r3, #6
	mov r2, #0x12
	bl sub_1078
	b loc_0ef8
loc_0ea4:
	teq r0, #3
	bne loc_0ed4
	mov r1, r5
	mov r0, r6
	mov r2, #1
	bl sub_110c
	mov r1, r5
	mov r0, r6
	bl sub_1238
	strb sb, [r5, #1]
	strb r7, [r5]
	b loc_0ef8
loc_0ed4:
	teq r0, #5
	bne loc_0ef8
	mov r0, #6
	strb r0, [r5, #1]
	strb r7, [r5]
	mov r1, r5
	mov r0, r6
	mov r2, #2
	bl sub_110c
loc_0ef8:
	ldr r0, [r5, #0x16]
	mov r0, r0, lsr #16
	teq r0, #1
	ldreq r0, [r5]
	moveq r0, r0, lsr #16
	teqeq r0, #3
	bne loc_0f34
	ldr r0, [r5, #8]
	bl sub_16bc
	teq r0, #0
	beq loc_0f34
	mov r2, r0
	mov r1, r5
	mov r0, r6
	bl sub_13e8
loc_0f34:
	ldr r0, [r5, #0x18]
	tst r0, #8
	beq loc_1014
	ldr r1, [r5]
	mov r1, r1, lsr #16
	teq r1, #3
	bicne r0, r0, #8
	strne r0, [r5, #0x18]!
	bne loc_1068
	mov r0, r6
	mov r1, #0
	add r3, r5, #0x20
	ldmia r3, {r2, r3}
	bl sub_1680
	movs r7, r0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r0, [r5, #0x18]
	bic r0, r0, #8
	str r0, [r5, #0x18]
	ldr r0, [r5, #4]
	ldr r0, [r0, #0x10]
	bl sub_1698
	teq r0, #1
	ldreq r0, [r5, #0x14]
	moveq r0, r0, lsr #16
	teqeq r0, #0
	bne loc_0fbc
	ldr r0, [r5, #4]
	ldr r0, [r0, #0x10]
	mov r1, r7
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_1014
loc_0fbc:
	ldr r0, [r5, #0x14]
	mov r0, r0, lsr #16
	cmp r0, #0x10
	blt sub_0fdc
	mov r1, r7
	mov r0, r6
	bl sub_1670
	b loc_1014

sub_0fdc:
	ldr r0, [r5, #0xc]
	teq r0, #0
	ldrne r0, [r5, #0x10]
	strne r7, [r0]
	streq r7, [r5, #0xc]
	str r7, [r5, #0x10]
	ldr r0, [r5, #0x14]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r5, #0x15]
	mov r0, r0, asr #8
	strb r0, [r5, #0x14]
	mov r0, #0
	str r0, [r7]
loc_1014:
	ldr r0, [r5, #0x18]
	tst r0, #8
	andeq r1, r0, #0x10
	teqeq r1, #0
	ldreq r1, [r5]
	moveq r1, r1, lsr #16
	teqeq r1, #3
	bne loc_1068
	orr r0, r0, #0x10
	str r0, [r5, #0x18]
	mov r0, r4
	ldr r1, [r5, #0x1c]
	bl sub_0a30
	teq r0, #0
	beq loc_1068
	ldr r0, [r5, #0x18]
	bic r0, r0, #0x10
	mov r1, r8
	str r0, [r5, #0x18]!
	mov r0, r4
	bl sub_0d60
loc_1068:
	add r8, r8, #1
	cmp r8, #2
	blo sub_0de8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_1078:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r6, r2
	mov r5, r3
	mov r2, #3
	mov r1, #0xc
	bl sub_16dc
	movs r1, r0
	bne loc_10d0
	mov r0, #4
	strb r0, [r4, #1]
	mov r0, #0
	strb r0, [r4]
	ldr r0, [r4, #4]!
	ldr r0, [r0, #0x10]
	mov r3, #1
	mvn r2, #7
	mov r1, #0x8a
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_16a4
loc_10d0:
	mov r0, #0x83
	ldr r2, [r1, #0x18]
	strb r0, [r2, #9]
	ldr r0, [r1, #0x10]
	add r0, r0, #0xc
	str r0, [r1, #0x10]
	mov r2, #3
	ldr r0, [r1, #0xc]
	stmia r0, {r2, r6}
	str r5, [r0, #8]
	ldr r0, [r4, #4]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	ldr pc, [r2]

sub_110c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	mov r2, #3
	mov r1, #4
	bl sub_16dc
	movs r1, r0
	bne loc_1160
	mov r0, #4
	strb r0, [r4, #1]
	mov r0, #0
	strb r0, [r4]
	ldr r0, [r4, #4]!
	ldr r0, [r0, #0x10]
	mov r3, #1
	mvn r2, #7
	mov r1, #0x8a
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_16a4
loc_1160:
	mov r2, #0x83
	ldr r0, [r1, #0x18]
	strb r2, [r0, #9]
	ldr r0, [r1, #0x10]
	add r0, r0, #4
	str r0, [r1, #0x10]
	ldr r0, [r1, #0xc]
	str r5, [r0]
	ldr r0, [r4, #4]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_1194:
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	add r1, r1, r1, lsl #2
	add r0, r0, r1, lsl #3
	add r0, r0, #0x18
	mov r1, #1
	strb r1, [r0, #0x17]
	mov r1, #0
	strb r1, [r0, #0x16]
	mov pc, lr

sub_11bc:
	stmdb sp!, {r4, lr}
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	ldr ip, [sp, #8]
	add r4, r1, r1, lsl #2
	add lr, r0, r4, lsl #3
	add lr, lr, #0x18
	ldr r4, [lr, #0x18]
	bic r4, r4, #0x10
	teq r3, #0
	str r4, [lr, #0x18]
	beq loc_11fc
	orr r4, r4, #8
	str r4, [lr, #0x18]!
	add lr, lr, #8
	stmia lr, {r2, r3}
loc_11fc:
	teq ip, #0
	ldmiaeq sp!, {r4, pc}
	mov r2, ip
	add ip, r2, #0x3e80
	cmn ip, #9
	ldmiaeq sp!, {r4, lr}
	beq sub_0d60
	ldmia sp!, {r4, pc}

sub_121c:
	mov r2, r2, lsl #16
	mov r2, r2, lsr #16
	add r2, r2, r2, lsl #2
	add r0, r0, r2, lsl #3
	add r0, r0, #0x18
	str r1, [r0, #0x1c]!
	mov pc, lr

sub_1238:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0xc]
	teq r1, #0
	beq loc_1274
loc_1258:
	ldr r0, [r1]
	str r0, [r4, #0xc]
	mov r0, r5
	bl sub_1670
	ldr r1, [r4, #0xc]
	teq r1, #0
	bne loc_1258
loc_1274:
	mov r0, #0
	str r0, [r4, #0x10]
	strb r0, [r4, #0x15]
	strb r0, [r4, #0x14]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1288:
	mov r2, r0
	ldr r1, lit_1298
	mov r0, #0x68
	b loc_16e4
lit_1298:
	.word 0x53455220			; 'SER '

sub_129c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, #0
	ldr r1, [r0, #0x18]
	teq r1, #0
	ldr r6, [r0, #4]
	bne loc_12d4
loc_12c4:
	mov r1, r4
	mov r0, r6
	bl sub_1670
	b loc_13e0
loc_12d4:
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	cmp r0, #0xe
	beq loc_1354
	bgt loc_12fc
	teq r0, #0
	beq loc_1388
	teq r0, #1
	bne loc_13c8
	b loc_13b8
loc_12fc:
	teq r0, #0x83
	beq loc_13b8
	teq r0, #0x86
	bne loc_13c8
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #2
	movne r0, r5
	movne r1, #0
	blne sub_16d0
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_12c4
	mov r1, #0
	ldr r0, [r5, #0x30]
	bl sub_16d0
	ldr r0, [r4, #0xc]
	ldrb r1, [r0]
	bic r1, r1, #2
	strb r1, [r0]
	b loc_136c
loc_1354:
	mvn r0, #0
	ldr r1, [r4, #0xc]
	str r0, [r1, #0x10]!
	mov r1, #0x82
	ldr r0, [r4, #0x18]
	strb r1, [r0, #9]
loc_136c:
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_13e0
loc_1388:
	ldr r0, [r1, #0x16]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_13a8
	mov r2, r4
	mov r0, r6
	bl sub_13e8
	b loc_13e0
loc_13a8:
	mov r1, r4
	mov r0, r5
	bl sub_16b0
	b loc_13e0
loc_13b8:
	mov r2, r4
	mov r0, r6
	bl sub_147c
	b loc_13e0
loc_13c8:
	ldr r0, [r1, #4]!
	ldr r0, [r0, #0x10]
	mov r3, #1
	mvn r2, #2
	mov r1, #0x8a
	bl sub_16a4
loc_13e0:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_13e8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r7, #0
	ldr r0, [r1, #0x1c]
	teq r0, #0
	bne loc_1428
	mov r1, r4
	mov r0, r5
	bl sub_1238
	strb r7, [r4, #1]
	strb r7, [r4]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_1428:
	ldr r0, [r4]
	mov r0, r0, lsr #16
	teq r0, #3
	bne loc_146c
	mov r1, r6
	mov r0, r5
	mov r2, #0
	bl sub_1678
	mov r1, r6
	mov r0, r5
	ldr r2, [r4, #0x1c]
	bl sub_08ec
	strb r7, [r4, #0x17]
	strb r7, [r4, #0x16]
	mov r0, r5
	ldr r1, [r4, #0x1c]!
	bl sub_09b0
loc_146c:
	mov r1, r6
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_1670

sub_147c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	ldr r0, [r1, #0x1c]
	teq r0, #0
	bne loc_14bc
	mov r1, r4
	mov r0, r5
	bl sub_1238
	mov r0, #0
	strb r0, [r4, #1]
	strb r0, [r4]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_14bc:
	add r1, r6, #0xc
	ldmia r1, {r0, r1}
	sub r1, r1, r0
	teq r1, #4
	beq loc_14f8
	ldr r0, [r4, #4]!
	ldr r0, [r0, #0x10]
	mov r3, #1
	mvn r2, #4
	mov r1, #0x8a
	bl sub_16a4
	mov r1, r6
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_1670
loc_14f8:
	mov r1, r6
	ldr r7, [r0]
	mov r0, r5
	bl sub_1670
	teq r7, #0x12
	beq loc_1538
	teq r7, #0x13
	moveq r1, r4
	moveq r0, r5
	moveq r2, #2
	beq loc_1588
	mov r2, r7
	mov r1, r4
	mov r0, r5
	mvn r3, #4
	b loc_1560
loc_1538:
	ldr r0, [r4]
	mov r0, r0, lsr #16
	teq r0, #4
	teqne r0, #2
	teqne r0, #5
	bne loc_1568
loc_1550:
	mov r2, r7
	mov r1, r4
	mov r0, r5
	mvn r3, #5
loc_1560:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_1078
loc_1568:
	mov r0, r5
	ldr r1, [r4, #0x1c]
	bl sub_0ac0
	teq r0, #1
	bne loc_1550
	mov r1, r4
	mov r0, r5
	mov r2, #0
loc_1588:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_110c

sub_1590:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	beq loc_1614
	ldr r0, [r4, #0x10]
	bl sub_1698
	teq r0, #1
	bne loc_1614
loc_15c0:
	ldr r1, [r5, #0xc]
	teq r1, #0
	beq loc_1614
	ldr r0, [r1]
	str r0, [r5, #0xc]
	teq r0, #0
	streq r6, [r5, #0x10]
	ldr r0, [r5, #0x14]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r5, #0x15]
	mov r0, r0, asr #8
	strb r0, [r5, #0x14]
	ldr r0, [r4, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	ldr r0, [r4, #0x10]
	bl sub_1698
	teq r0, #1
	beq loc_15c0
loc_1614:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_161c:
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	add r1, r1, r1, lsl #2
	add r0, r0, r1, lsl #3
	add r0, r0, #0x18
	mov r1, #1
	str r1, [r0, #0x18]!
	mov pc, lr

sub_163c:
	ldr r1, [r0, #0x18]
	tst r1, #1
	moveq r0, #0
	bicne r1, r1, #1
	strne r1, [r0, #0x18]!
	movne r0, #1
	mov pc, lr
str_1658:
	.asciz "serial"
	.align 4

sub_1660:
	ldr ip, [r0, #8]
	ldr pc, [ip, #4]

sub_1668:
	ldr r2, [r0, #8]
	ldr pc, [r2, #8]

sub_1670:
	ldr r2, [r0, #8]
	ldr pc, [r2, #0x24]

sub_1678:
	ldr r3, [r0, #8]
	ldr pc, [r3, #0x28]

sub_1680:
	ldr ip, [r0, #8]
	ldr pc, [ip, #0x38]

sub_1688:
	ldr ip, [r0, #8]
	ldr pc, [ip, #0x40]

sub_1690:
	ldr r2, [r0, #8]
	ldr pc, [r2, #0xc]

sub_1698:
	ldr r1, [r0, #4]
	ldr r1, [r1, #8]
	ldr pc, [r1, #0x5c]

sub_16a4:
	ldr ip, [r0, #4]
	ldr ip, [ip, #8]
	ldr pc, [ip, #0x60]

sub_16b0:
	ldr r2, [r0, #4]
	ldr r2, [r2, #8]
	ldr pc, [r2, #0x64]

sub_16bc:
	ldr r1, [r0, #4]
	ldr r1, [r1, #8]
	ldr pc, [r1, #0x68]

sub_16c8:
	str r1, [r0, #0xc]!
	mov pc, lr

sub_16d0:
	ldr r2, [r0, #4]
	ldr r2, [r2, #8]
	ldr pc, [r2, #0x74]

sub_16dc:
	ldr r3, [r0, #8]
	ldr pc, [r3, #0x10]
loc_16e4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	bl NewNamedPtr
	movs r6, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r4
	mov r0, r6
	bl sub_1724
	ldmia r5, {r1, r2, r3, ip, lr}
	stmia r6, {r1, r2, r3, ip, lr}
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1724:
	sub r2, r1, #0x14
	add r0, r0, #0x14
	mov r1, #0
	b memset
data_1734:
	.word 0x01000000
	.rword str_1658				; relocated
	.word 0x00011068			; andeq r1, r1, r8, rrx
	.word 0x00010000			; andeq r0, r1, r0
data_1744:
	.word 0x00000000
	.rword sub_1590				; relocated
	.rword sub_0cb4				; relocated
	.rword sub_0d20				; relocated
	.word 0x00000000
	.rword data_1734			; relocated
	.word 0x00000000
data_1760:
	.rword sub_129c				; relocated
	.space 16
	.rword data_1734			; relocated
	.word 0x00000000
data_177c:
	.rword data_1744			; relocated
	.rword data_1760			; relocated
	.word 0x00000000
	.word 0x00000000

sub_178c:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_1794:
	.asciz "PMuxTool"
	.align 4

sub_17a0:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_178c
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_17cc:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_17e0
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_17e0:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_17e8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_17f4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_1800:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_180c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_1818:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_1824:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_1830:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_183c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_1848:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_1854:
	mov r0, #0
	b __ct__11CBufferListFv

sub_185c:
	mov r0, #0
	b __ct__14CBufferSegmentFv

CopyObject__8TUObjectFCUl:
	ldr pc, lit_1868
lit_1868:
	.word 0x01800f14			; glue 01800f14 -> CopyObject__8TUObjectFCUl

FindOption__15TOptionIteratorFUl:
	ldr pc, lit_1870
lit_1870:
	.word 0x018002e0			; glue 018002e0 -> FindOption__15TOptionIteratorFUl

FreeInstance__FP9TProtocol:
	ldr pc, lit_1878
lit_1878:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

GetSize__14CBufferSegmentCFv:
	ldr pc, lit_1880
lit_1880:
	.word 0x01801b2c			; glue 01801b2c -> GetSize__14CBufferSegmentCFv

Hide__14CBufferSegmentFli:
	ldr pc, lit_1888
lit_1888:
	.word 0x01801b40			; glue 01801b40 -> Hide__14CBufferSegmentFli

Init__11CBufferListFUc:
	ldr pc, lit_1890
lit_1890:
	.word 0x01801b58			; glue 01801b58 -> Init__11CBufferListFUc

Init__14CBufferSegmentFPvlUcN22:
	ldr pc, lit_1898
lit_1898:
	.word 0x01801b78			; glue 01801b78 -> Init__14CBufferSegmentFPvlUcN22

Init__14TUAsyncMessageFUc:
	ldr pc, lit_18a0
lit_18a0:
	.word 0x01801160			; glue 01801160 -> Init__14TUAsyncMessageFUc

InsertLast__11CBufferListFP7CBuffer:
	ldr pc, lit_18a8
lit_18a8:
	.word 0x01801bd0			; glue 01801bd0 -> InsertLast__11CBufferListFP7CBuffer

Last__11CBufferListFv:
	ldr pc, lit_18b0
lit_18b0:
	.word 0x01801c1c			; glue 01801c1c -> Last__11CBufferListFv

NewNamedPtr:
	ldr pc, lit_18b8
lit_18b8:
	.word 0x01801808			; glue 01801808 -> NewNamedPtr

Reset__11CBufferListFv:
	ldr pc, lit_18c0
lit_18c0:
	.word 0x01801d28			; glue 01801d28 -> Reset__11CBufferListFv

Reset__14CBufferSegmentFv:
	ldr pc, lit_18c8
lit_18c8:
	.word 0x01801d38			; glue 01801d38 -> Reset__14CBufferSegmentFv

SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime:
	ldr pc, lit_18d0
lit_18d0:
	.word 0x01801418			; glue 01801418 -> SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime

SetCollectorPort__14TUAsyncMessageFUl:
	ldr pc, lit_18d8
lit_18d8:
	.word 0x0180145c			; glue 0180145c -> SetCollectorPort__14TUAsyncMessageFUl

SetUserRefCon__14TUSharedMemMsgFUl:
	ldr pc, lit_18e0
lit_18e0:
	.word 0x018014dc			; glue 018014dc -> SetUserRefCon__14TUSharedMemMsgFUl

__ct__11CBufferListFv:
	ldr pc, lit_18e8
lit_18e8:
	.word 0x0180188c			; glue 0180188c -> __ct__11CBufferListFv

__ct__14CBufferSegmentFv:
	ldr pc, lit_18f0
lit_18f0:
	.word 0x018018d0			; glue 018018d0 -> __ct__14CBufferSegmentFv

__ct__14TUAsyncMessageFv:
	ldr pc, lit_18f8
lit_18f8:
	.word 0x01800d78			; glue 01800d78 -> __ct__14TUAsyncMessageFv

__ct__15TCommToolAEventFv:
	ldr pc, lit_1900
lit_1900:
	.word 0x01801e98			; glue 01801e98 -> __ct__15TCommToolAEventFv

__ct__15TOptionIteratorFP12TOptionArray:
	ldr pc, lit_1908
lit_1908:
	.word 0x018001c4			; glue 018001c4 -> __ct__15TOptionIteratorFP12TOptionArray

__ct__17TCommToolGetReplyFv:
	ldr pc, lit_1910
lit_1910:
	.word 0x01801e88			; glue 01801e88 -> __ct__17TCommToolGetReplyFv

__ct__17TCommToolPutReplyFv:
	ldr pc, lit_1918
lit_1918:
	.word 0x01801e84			; glue 01801e84 -> __ct__17TCommToolPutReplyFv

__ct__19TCommToolGetRequestFv:
	ldr pc, lit_1920
lit_1920:
	.word 0x01801ea4			; glue 01801ea4 -> __ct__19TCommToolGetRequestFv

__ct__19TCommToolPutRequestFv:
	ldr pc, lit_1928
lit_1928:
	.word 0x01801ea0			; glue 01801ea0 -> __ct__19TCommToolPutRequestFv

__ct__22TCommToolGetEventReplyFv:
	ldr pc, lit_1930
lit_1930:
	.word 0x01801e94			; glue 01801e94 -> __ct__22TCommToolGetEventReplyFv

__ct__6TUPortFUl:
	ldr pc, lit_1938
lit_1938:
	.word 0x01800d98			; glue 01800d98 -> __ct__6TUPortFUl

__dl__FPv:
	ldr pc, lit_1940
lit_1940:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__14CBufferSegmentFv:
	ldr pc, lit_1948
lit_1948:
	.word 0x01801938			; glue 01801938 -> __dt__14CBufferSegmentFv

__dt__14TUAsyncMessageFv:
	ldr pc, lit_1950
lit_1950:
	.word 0x01800ddc			; glue 01800ddc -> __dt__14TUAsyncMessageFv

__dt__15TOptionIteratorFv:
	ldr pc, lit_1958
lit_1958:
	.word 0x01800208			; glue 01800208 -> __dt__15TOptionIteratorFv

__dt__8TUObjectFv:
	ldr pc, lit_1960
lit_1960:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_1968
lit_1968:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

free:
	ldr pc, lit_1970
lit_1970:
	.word 0x01801024			; glue 01801024 -> free

memset:
	ldr pc, lit_1978
lit_1978:
	.word 0x01800124			; glue 01800124 -> memset
