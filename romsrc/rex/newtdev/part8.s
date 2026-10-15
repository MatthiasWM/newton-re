; " Newton Devices" part 8: protocol (9380 bytes)
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
	.asciz "PLinkEnet"
InterfaceName:
	.asciz "PLink"
Signature:
	.asciz "atlk"
	.asciz "pnet"
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

AllocInstanceByName__FPCcT1:
	ldr pc, lit_009c
lit_009c:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

At__11CBufferListFl:
	ldr pc, lit_00a4
lit_00a4:
	.word 0x01801a0c			; glue 01801a0c -> At__11CBufferListFl

sub_00a8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_00cc
	mov r0, #0x50
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_00cc:
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0x10]
	str r1, [r0, #0xc]
	str r1, [r0]
	ldmdb fp, {fp, sp, pc}

sub_00e8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #4]
	teq r0, #0
	movne r1, #1
	blne __dt__14CBufferSegmentFv
	ldr r0, [r4, #8]
	teq r0, #0
	movne r1, #1
	blne __dt__14CBufferSegmentFv
	ldr r0, [r4, #0xc]
	teq r0, #0
	movne r1, #1
	blne __dt__14CBufferSegmentFv
	ldr r0, [r4, #0x10]
	teq r0, #0
	movne r1, #1
	blne __dt__14CBufferSegmentFv
	ldr r0, [r4]
	teq r0, #0
	movne r1, #1
	blne __dt__11CBufferListFv
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0160:
	mov r2, #6
	b memcpy

sub_0168:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0]
	bl GetSize__11CBufferListCFv
	cmp r0, #0x3c
	bge loc_021c
	bl sub_2354
	str r0, [r4, #0xc]
	teq r0, #0
	beq loc_0224
	ldr r0, [r4]
	bl GetSize__11CBufferListCFv
	rsb r1, r0, #0x3c
	ldr r0, [r4, #0xc]
	bl Init__14CBufferSegmentFl
	movs r5, r0
	bne loc_0224
	mvn r2, #0
	mov r1, #0
	ldr r0, [r4, #0xc]
	bl Seek__14CBufferSegmentFli
	mov r5, #0
	ldr r0, [r4, #0xc]
	bl GetSize__14CBufferSegmentCFv
	cmp r0, #0
	ble sub_01f8
loc_01d8:
	mov r1, #0
	ldr r0, [r4, #0xc]
	bl Put__14CBufferSegmentFi
	add r5, r5, #1
	ldr r0, [r4, #0xc]
	bl GetSize__14CBufferSegmentCFv
	cmp r0, r5
	bgt loc_01d8

sub_01f8:
	mvn r2, #0
	mov r1, #0
	ldr r0, [r4, #0xc]
	bl Seek__14CBufferSegmentFli
	ldr r0, [r4], #0xc
	ldr r1, [r4]
	bl InsertLast__11CBufferListFP7CBuffer
	movs r5, r0
	bne loc_0224
loc_021c:
	mov r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_0224:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_022c:
	mov r2, #0
	cmp r1, #0x3c
	blo sub_026c
	mov r3, #0x260
	ldr r1, [r0, #0xc]
	cmp r3, r1, lsr #16
	blt sub_026c
	and r3, r1, #0xff00
	teq r3, #0xaa00
	andeq r1, r1, #0xff
	teqeq r1, #0xaa
	ldreq r1, [r0, #0x10]!
	moveq r0, #3
	teqeq r0, r1, lsr #24
	moveq r0, #1
	moveq pc, lr

sub_026c:
	mov r0, r2
	mov pc, lr

sub_0274:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r0
	bl sub_022c
	movs r1, r0
	mov r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r5, #0x10]
	bic r2, r1, #0xff000000
	mov r1, #0x9b
	add r1, r1, #0x8000
	sub ip, r2, #0x80000
	teq ip, #7
	ldreq r3, [r5, #0x14]
	teqeq r1, r3, lsr #16
	moveq r0, #4
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	teq r2, #0
	moveq r3, #0xf3
	addeq r3, r3, #0x8000
	ldreq r2, [r5, #0x14]!
	teqeq r3, r2, lsr #16
	moveq r2, r2, lsl #16
	moveq r2, r2, lsr #16
	teqeq r2, #1
	ldreq r2, [r4, #0x18]
	teqeq r1, r2, lsr #16
	andeq r1, r2, #0xff00
	teqeq r1, #0x600
	andeq r1, r2, #0xff
	teqeq r1, #4
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r1, [r4, #0x1c]!
	mov r1, r1, lsr #16
	teq r1, #1
	moveq r0, #1
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	teq r1, #2
	moveq r0, #2
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	teq r1, #3
	moveq r0, #3
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0328:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	mov r7, #0
	str r7, [r0]
	bl sub_234c
	str r0, [r4]
	teq r0, #0
	beq loc_03c0
	mov r1, #1
	bl Init__11CBufferListFUc
	movs r5, r0
	bne loc_03b0
	bl sub_2354
	movs r6, r0
	beq loc_03b0
	mov r0, r6
	mov r1, #0x2bc
	bl Init__14CBufferSegmentFl
	movs r5, r0
	bne loc_039c
	mov r1, r6
	ldr r0, [r4]
	bl Insert__11CBufferListFP7CBuffer
	movs r5, r0
	moveq r0, r7
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
loc_039c:
	teq r6, #0
	beq loc_03b0
	mov r0, r6
	mov r1, #1
	bl __dt__14CBufferSegmentFv
loc_03b0:
	ldr r0, [r4]
	teq r0, #0
	movne r1, #1
	blne __dt__11CBufferListFv
loc_03c0:
	teq r5, #0
	str r7, [r4]
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	movne r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_03d8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	strb r5, [r0, #0x14]
	bl sub_2354
	str r0, [r4, #4]
	teq r0, #0
	beq loc_0430
	mvn r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	add r1, r4, #0x1c
	mov r3, #0
	mov r2, #0x16
	bl Init__14CBufferSegmentFPvlUcN22
	add sp, sp, #8
	cmp r0, #0
	moveq r0, r5
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_0430:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_043c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	mov r5, #1
	teq r1, #0
	strne r1, [r4]
	strbne r6, [r4, #0x14]
	bne loc_047c
	mov r0, r4
	mov r1, #0x2bc
	bl sub_0328
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	strb r5, [r4, #0x14]
loc_047c:
	mvn r2, #0
	mov r1, #3
	ldr r0, [r4]
	bl Hide__11CBufferListFli
	ldmia r4, {r0, r1}
	bl InsertFirst__11CBufferListFP7CBuffer
	teq r0, #0
	strbeq r5, [r4, #0x15]
	moveq r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_04a4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #4
	ldr r0, [r0]
	mvn r2, #0
	mov r1, #0x1e
	bl Seek__11CBufferListFli
	ldr r0, [r4]
	bl Get__11CBufferListFv
	ldr r1, [sp]
	bic r1, r1, #0xff000000
	orr r0, r1, r0, lsl #24
	str r0, [sp]
	ldr r0, [r4]
	bl Get__11CBufferListFv
	ldr r1, [sp]
	bic r1, r1, #0xff0000
	and r0, r0, #0xff
	orr r0, r1, r0, lsl #16
	bic r0, r0, #0xff00
	orr r0, r0, #0x200
	str r0, [sp]
	ldr r0, [r4]
	bl Reset__11CBufferListFv
	mvn r1, #4
	ldr r0, [r4, #0x28]
	add r0, r1, r0, lsr #16
	str r0, [r5]
	mov r5, #0
	strb r5, [r4, #0x15]
	ldmia r4, {r0, r1}
	bl Remove__11CBufferListFP7CBuffer
	teq r0, #0
	bne loc_0554
	ldr r0, [r4]
	bl ResetMark__11CBufferListFv
	mov r1, sp
	mov r2, #3
	ldr r0, [r4]
	bl Putn__11CBufferListFPCUcl
	mov r0, r5
loc_0554:
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0558:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldrb r0, [r0, #0x15]
	mov r5, #0
	teq r0, #0
	beq loc_058c
	ldmia r4, {r0, r1}
	bl Remove__11CBufferListFP7CBuffer
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	strb r5, [r4, #0x15]
loc_058c:
	ldrb r0, [r4, #0x14]
	teq r0, #0
	ldr r0, [r4]
	beq loc_05b0
	teq r0, #0
	movne r1, #1
	blne __dt__11CBufferListFv
	strb r5, [r4, #0x14]
	b loc_05b4
loc_05b0:
	bl Reset__11CBufferListFv
loc_05b4:
	mov r0, r5
	str r5, [r4]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_05c0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x2c]
	bics r0, r0, #0xff000000
	moveq r2, #0xf3
	addeq r2, r2, #0x8000
	ldreq r1, [r4, #0x30]
	teqeq r2, r1, lsr #16
	bne loc_0620
	mvn r2, #0
	mov r1, #0x16
	ldr r0, [r4]
	bl Seek__11CBufferListFli
	add r1, r4, #0x34
	mov r2, #0x1c
	ldr r0, [r4]
	bl Getn__11CBufferListFPUcl
	ldr r0, [r4, #0x38]
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	str r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, pc}
loc_0620:
	sub ip, r0, #0x80000
	teq ip, #7
	moveq r0, #0x9b
	addeq r0, r0, #0x8000
	ldreq r1, [r4, #0x30]!
	teqeq r0, r1, lsr #16
	movne r0, #0
	moveq r0, #4
	ldmdb fp, {r4, fp, sp, pc}

sub_0644:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_234c
	str r0, [r4]
	teq r0, #0
	beq loc_0708
	bl sub_2354
	str r0, [r4, #4]
	teq r0, #0
	beq loc_0708
	mov r1, #0
	ldr r0, [r4]
	bl Init__11CBufferListFUc
	teq r0, #0
	bne loc_0700
	mvn r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	add r1, r4, #0x1c
	mov r3, #0
	mov r2, #0x16
	ldr r0, [r4, #4]
	bl Init__14CBufferSegmentFPvlUcN22
	add sp, sp, #8
	teq r0, #0
	bne loc_0700
	mov r1, #0
	ldmia r4, {r0, r2}
	bl InsertAt__11CBufferListFlP7CBuffer
	teq r0, #0
	bne loc_0700
	add r0, r4, #0x22
	mov r1, r5
	mov r2, #6
	bl memcpy
	ldr r0, lit_06fc
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x2c]
	bic r0, r0, #0xff000000
	orr r0, r0, #0x3000000
	str r0, [r4, #0x2c]!
	mov r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_06fc:
	.word 0x0008aaaa
loc_0700:
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_0708:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0714:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	mov r5, r1
	bne loc_073c
	mov r0, #8
	bl __nw__FUi
	movs r4, r0
	beq loc_074c
loc_073c:
	mov r1, r5
	mov r0, r4
	mov r2, #4
	bl memcpy
loc_074c:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0754:
	mov r2, r2, lsl #16
	mov r2, r2, lsr #16
	and r3, r3, #0xff
	strb r3, [r0, #4]
	strb r1, [r0]
	mov r1, r2, lsr #8
	strb r1, [r0, #1]
	strb r2, [r0, #2]
	strb r3, [r0, #3]
	mov pc, lr

sub_077c:
	ldrb r1, [r0, #3]
	add r1, r1, #1
	and r1, r1, #0xff
	strb r1, [r0, #3]
	cmp r1, #0xfd
	movgt r1, #1
	strbgt r1, [r0, #3]
	ldrb r1, [r0, #3]
	ldrb r0, [r0, #4]
	teq r1, r0
	movne r0, #0
	moveq r0, #0xee
	subeq r0, r0, #0x3000
	mov pc, lr

sub_07b4:
	ldrb r3, [r0, #1]
	ldrb r2, [r1, #1]
	teq r3, r2
	ldrbeq r2, [r0, #2]
	ldrbeq r3, [r1, #2]
	teqeq r2, r3
	ldrbeq r0, [r0, #3]
	ldrbeq r1, [r1, #3]
	teqeq r0, r1
	movne r0, #0
	moveq r0, #1
	mov pc, lr

sub_07e4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0]
	teq r0, #0
	bne loc_08e0
	mov r1, r5
	mov r0, r4
	bl sub_0644
	teq r0, #0
	bne loc_08d8
	ldr r0, [r4, #0x2c]
	and r0, r0, #0xff000000
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x30]
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	orr r0, r0, #0x80000000
	orr r0, r0, #0xf30000
	str r0, [r4, #0x30]
	bl sub_2354
	str r0, [r4, #8]
	teq r0, #0
	beq loc_08e0
	mvn r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	add r1, r4, #0x34
	mov r3, #0
	mov r2, #0x1c
	bl Init__14CBufferSegmentFPvlUcN22
	add sp, sp, #8
	teq r0, #0
	bne loc_08d8
	mov r1, #1
	ldr r0, [r4]
	ldr r2, [r4, #8]
	bl InsertAt__11CBufferListFlP7CBuffer
	teq r0, #0
	bne loc_08d8
	mov r0, r4
	bl sub_0168
	ldr r0, [r4, #0x28]
	add r0, r0, #0x1c0000
	str r0, [r4, #0x28]
	mov r0, #0x9b
	add r0, r0, #0x18000
	str r0, [r4, #0x34]
	mov r0, #0x2040000
	add r0, r0, #0x4000003
	str r0, [r4, #0x38]
	add r0, r4, #0x3c
	mov r1, r5
	bl sub_0160
	add r0, r4, #0x46
	mov r1, r5
	bl sub_0160
	mov r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_08d8:
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_08e0:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_08ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r7, r3
	add r0, r0, #0x1c
	mov r1, r2
	mov r2, #6
	ldr r8, [fp, #4]
	bl memcpy
	add r0, r4, #0x42
	mov r1, r7
	mov r2, #4
	bl memcpy
	add r0, r4, #0x4c
	mov r1, r8
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #0x38]
	mov r1, r0, lsr #16
	mov r1, r1, lsl #16
	mov r0, r5, lsl #16
	orr r0, r1, r0, lsr #16
	str r0, [r4, #0x38]
	str r5, [r4, #0x18]
	add r0, r4, #0x46
	teq r5, #1
	beq loc_097c
	teq r5, #2
	moveq r1, r6
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	beq sub_0160
	teq r5, #3
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_097c:
	sub sp, sp, #8
	ldr r2, lit_0998
	ldmia r2, {ip, lr}
	stmia sp, {ip, lr}
	mov r1, sp
	bl sub_0160
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_0998:
	.rword data_21a8			; relocated

sub_099c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0]
	teq r0, #0
	bne loc_0a08
	mov r0, r4
	bl sub_0644
	cmp r0, #0
	bne loc_0a04
	ldr r0, [r4, #0x2c]
	and r0, r0, #0xff000000
	orr r0, r0, #0x80000
	orr r0, r0, #7
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x30]
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	orr r0, r0, #0x80000000
	orr r0, r0, #0x9b0000
	str r0, [r4, #0x30]
	mov r0, #4
	str r0, [r4, #0x18]!
	mov r0, #0
	ldmdb fp, {r4, fp, sp, pc}
loc_0a04:
	ldmdbne fp, {r4, fp, sp, pc}
loc_0a08:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
	ldmdb fp, {r4, fp, sp, pc}

sub_0a14:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r1, #0
	mov r7, r1
	mov r0, r5
	bl At__11CBufferListFl
	teq r0, #0
	beq loc_0a70
loc_0a44:
	mov r1, r0
	ldr r0, [r4]
	bl InsertLast__11CBufferListFP7CBuffer
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	add r1, r7, #1
	mov r7, r1
	mov r0, r5
	bl At__11CBufferListFl
	teq r0, #0
	bne loc_0a44
loc_0a70:
	mov r0, r5
	bl GetSize__11CBufferListCFv
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	ldr r1, [r4, #0x28]
	add r0, r1, r0, lsl #16
	str r0, [r4, #0x28]
	add r0, r4, #0x1c
	mov r1, r6
	mov r2, #6
	bl memcpy
	mov r0, r4
	bl sub_0168
	teq r0, #0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_0aac:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r1, #1
	mov r5, r1
	ldr r0, [r0]
	bl At__11CBufferListFl
	teq r0, #0
	beq loc_0af4
loc_0ad4:
	mov r1, r0
	ldr r0, [r4]
	bl Remove__11CBufferListFP7CBuffer
	mov r1, r5
	ldr r0, [r4]
	bl At__11CBufferListFl
	teq r0, #0
	bne loc_0ad4
loc_0af4:
	ldr r0, [r4, #0xc]
	teq r0, #0
	beq loc_0b10
	mov r1, #1
	bl __dt__14CBufferSegmentFv
	mov r0, #0
	str r0, [r4, #0xc]
loc_0b10:
	ldr r0, [r4, #0x28]
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	orr r0, r0, #0x80000
	str r0, [r4, #0x28]!
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0b28:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #8
	mov r0, sp
	bl sub_0714
	mov r0, #0
	ldr r1, [r4, #0x18]
	teq r1, #4
	teqne r1, #0
	addne r1, r4, #0x4c
	movne r0, sp
	blne sub_07b4
	ldmdb fp, {r4, fp, sp, pc}

Sizeof:
	mov r0, #0x64
	mov pc, lr

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r0, #0x10]
	str r1, [r0, #0x18]
	str r1, [r0, #0x38]
	str r1, [r0, #0x1c]
	str r1, [r0, #0x44]
	str r1, [r0, #0x20]
	str r1, [r0, #0x4c]
	str r1, [r0, #0x54]
	str r1, [r0, #0x24]
	str r1, [r0, #0x48]
	mvn r2, #1
	str r2, [r0, #0x3c]
	mov r2, #1
	str r1, [r0, #0x34]
	strb r2, [r0, #0x59]
	str r1, [r0, #0x60]
	mov pc, lr

sub_0bb8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0xa
	mov r6, #3
	str r5, [r0, #0x40]
loc_0bd4:
	str r6, [r4, #0x3c]
	mov r0, r4
	bl sub_149c
	teq r0, #0
	bne loc_0c14
	ldr r0, [r4, #0x3c]
	teq r0, #4
	bne loc_0c20
	ldr r0, [r4, #0x38]
	bl sub_077c
	add ip, r0, #0x2f00
	cmn ip, #0x12
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	teq r0, #0
	streq r5, [r4, #0x40]
	beq loc_0bd4
loc_0c14:
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	b loc_0c44
loc_0c20:
	teq r0, #5
	bne loc_0c44
	ldr r0, [r4, #0x40]
	sub r0, r0, #1
	str r0, [r4, #0x40]
	cmp r0, #0
	bgt loc_0bd4
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_0c44:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0c50:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl Ticks__Fv
	mov r1, r0
	mov r0, #0xfc
	bl __rt_udiv
	add r0, r1, #1
	and r0, r0, #0xff
	ldmdb fp, {fp, sp, pc}

Method7:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #8
	mov r0, #0
	strb r0, [sp, #4]
	str r0, [sp]
	ldrb r0, [r1]
	teq r0, #0
	bne loc_0cb8
	mov r0, r4
	bl sub_0c50
	strb r0, [r6]
loc_0cb8:
	ldr r0, [r4, #0x38]
	ldrb r3, [r6]
	ldr r1, [r5]
	mov r2, r1, lsl #16
	mov r2, r2, lsr #16
	mov r1, #0
	bl sub_0754
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x38]
	bl sub_1d38
	mov r7, #0xee
	sub r7, r7, #0x3000
	teq r0, #0
	beq loc_0d28
loc_0cf0:
	ldr r0, [r4, #0x38]
	bl sub_077c
	teq r0, r7
	bne loc_0d14
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r7
	b loc_0e04
loc_0d14:
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x38]
	bl sub_1d38
	teq r0, #0
	bne loc_0cf0
loc_0d28:
	mov r0, sp
	bl Init__6TUPortFv
	teq r0, #0
	bne loc_0da4
	ldr r1, [sp]
	str r1, [r4, #0x28]
	ldr r0, [r4, #0x1c]
	bl sub_2298
	teq r0, #0
	bne loc_0da4
	mov r0, r4
	bl sub_0bb8
	mov r7, r0
	bl GetGlobals
	bl GetMyPort__9TAppWorldFv
	ldr r0, [r0]
	str r0, [r4, #0x28]
	mov r1, #0
	ldr r0, [r4, #0x1c]
	bl sub_2298
	teq r0, #0
	bne loc_0da4
	mov r0, #0xee
	sub r0, r0, #0x3000
	teq r7, r0
	bne loc_0d98

sub_0d90:
	mov r4, r0
	b loc_0df4
loc_0d98:
	teq r7, #0
	beq loc_0dc0
	mov r0, r7
loc_0da4:
	ldr r1, [r5]
	cmp r1, #0xff00
	blo sub_0d90
	mov r1, #0x10000
	sub r1, r1, #2
	str r1, [r5]
	b sub_0d90
loc_0dc0:
	ldr r0, [r4, #0x38]
	ldrb r0, [r0, #3]
	strb r0, [r6]
	ldr r0, [r4, #0x38]
	ldrb r1, [r0, #2]
	ldrb r0, [r0, #1]
	orr r0, r1, r0, lsl #8
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	str r0, [r5]
	mov r0, #6
	str r0, [r4, #0x3c]!
	mov r4, #0
loc_0df4:
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
loc_0e04:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_0e08:
	str r1, [r0, #0x48]
	teq r1, #0
	moveq pc, lr
	ldr r1, [r0, #0x3c]
	teq r1, #0
	movne pc, lr
	mov r1, #2
	str r1, [r0, #0x3c]
	ldr r0, [r0, #0x1c]
	b sub_22c8

sub_0e30:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [fp, #-0x18]
	cmp r0, #0x3c
	ldmdblo fp, {r4, r5, fp, sp, pc}
	ldr r0, [fp, #-0x20]
	ldr r1, [r0, #0x24]
	ldr r0, [r0, #0x10]
	bl sub_043c
	movs r4, r0
	mov r5, #1
	bne loc_0f58
	ldr r0, [fp, #-0x20]
	ldr r1, [r0, #0x10]
	ldr r3, [r1]
	ldr r2, [fp, #-0x1c]
	stmdb sp!, {r2, r3}
	ldr r0, [r0, #0x1c]
	mov r3, #2
	ldr r2, lit_0f7c
	ldr r1, lit_0f80
	bl sub_22e0
	add sp, sp, #8
	mov r4, r0
	add ip, r0, #0xee00
	cmn ip, #0x4d
	beq loc_0fe0
	teq r4, #0
	bne loc_0f4c
	ldr r0, [fp, #-0x20]
	ldr r0, [r0, #0x10]
	ldr r1, [fp, #-0x18]
	bl sub_05c0
	mov r2, r0
	teq r0, #1
	teqne r0, #2
	teqne r0, #3
	beq loc_0f84
	teq r0, #4
	bne loc_0fe0
	ldr r0, [fp, #-0x20]
	ldr r1, [r0, #0x24]
	teq r1, #0
	beq loc_0f94
	ldrb r1, [r0, #0x59]
	teq r1, #0
	beq loc_0f08
	sub r1, fp, #0x18
	bl sub_16a8
	teq r0, #0
	movne r1, #0
	ldrne r0, [fp, #-0x20]
	strbne r1, [r0, #0x59]
loc_0f08:
	ldr r0, [fp, #-0x20]
	ldr r0, [r0, #0x10]
	sub r1, fp, #0x18
	bl sub_04a4
	movs r4, r0
	bne loc_0f4c
	ldr r0, [fp, #-0x20]
	strb r5, [r0, #0x58]
	ldr r0, [fp, #-0x20]
	ldr r0, [r0, #0x10]
	bl sub_0558
	mov r1, #0
	ldr r0, [fp, #-0x20]
	ldr r2, [fp, #-0x18]
	bl sub_0ff0
	movs r4, r0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
loc_0f4c:
	ldr r0, [fp, #-0x20]
	ldr r0, [r0, #0x10]
	bl sub_0558
loc_0f58:
	ldr r0, [fp, #-0x20]
	strb r5, [r0, #0x58]
	ldr r0, [fp, #-0x20]
	ldr r1, [r0, #0x20]
	teq r1, #0
	movne r1, r4
	movne r2, #0
	blne sub_0ff0
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_0f7c:
	.word 0x72656343			; 'recC'
lit_0f80:
	.word 0x6c616e74			; 'lant'
loc_0f84:
	ldr r0, [fp, #-0x20]
	ldr r1, [r0, #0x10]
	bl sub_123c
	b loc_0fe0
loc_0f94:
	add r2, r0, #0x50
	ldmia r2, {r1, r2}
	cmp r2, r1
	blhs sub_1a78
	sub r2, fp, #0x20
	ldmia r2, {r0, r2}
	ldr r1, [r0, #0x4c]
	ldr r0, [r0, #0x54]
	str r2, [r1, r0, lsl #3]
	ldr r0, [fp, #-0x20]
	ldr r2, [fp, #-0x18]
	ldr r1, [r0, #0x4c]
	ldr r0, [r0, #0x54]
	add r0, r1, r0, lsl #3
	str r2, [r0, #4]!
	ldr r0, [fp, #-0x20]
	ldr r1, [r0, #0x54]
	add r1, r1, #1
	str r1, [r0, #0x54]!
loc_0fe0:
	ldr r0, [fp, #-0x20]
	ldr r0, [r0, #0x10]
	bl sub_0558
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0ff0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	sub sp, sp, #0x1c
	add r0, sp, #4
	bl __ct__17TCommToolGetReplyFv
	str r5, [sp, #0xc]
	teq r5, #0
	streq r6, [sp, #0x18]
	mov r1, sp
	ldr r0, [r4, #0x20]
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	mov r5, #0
	str r5, [r4, #0x24]
	str r5, [r4, #0x20]!
	ldr ip, [sp]
	add r3, sp, #4
	mov r0, ip
	mov r2, #0
	mov r1, #0
	ldr ip, [ip]
	mov lr, pc
	add pc, ip, #0xc
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1060:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0x3c]
	teq r0, #0
	beq loc_10e4
	teq r0, #3
	moveq r0, #5
	streq r0, [r4, #0x3c]
	beq loc_10d4
	teq r0, #7
	bne loc_10d4
	ldr r1, [r4, #0x40]
	sub r0, r1, #1
	cmp r1, #0
	str r0, [r4, #0x40]
	movle r5, #0xec
	suble r5, r5, #0x3000
	ble sub_10d0
	ldr r0, [r4, #0x14]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0xc8
	bl sub_1ae0
	movs r5, r0
	beq loc_10d4

sub_10d0:
	str r5, [r4, #0x34]
loc_10d4:
	ldr r0, [r4, #0x1c]
	bl sub_22c8
loc_10dc:
	str r5, [r4, #0x34]
	b loc_113c
loc_10e4:
	mov r3, #0
	ldr r2, lit_1160
	stmdb sp!, {r2, r3}
	add r1, r4, #0x48
	ldr r0, [r4, #0x1c]
	ldr r3, lit_1164
	mov r2, #4
	bl sub_22ec
	add sp, sp, #8
	movs r5, r0
	bne loc_10dc
	ldr r0, [r4, #0x48]
	teq r0, #0
	movne r0, #2
	bne loc_1138
	ldr r0, [r4, #0x40]
	sub r1, r0, #1
	cmp r0, #0
	str r1, [r4, #0x40]
	bgt loc_1148
	mov r0, #1
loc_1138:
	str r0, [r4, #0x3c]
loc_113c:
	ldr r0, [r4, #0x1c]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_22c8
loc_1148:
	mov r0, r4
	mov r1, #0x64
	bl sub_2098
	movs r5, r0
	bne loc_10dc
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_1160:
	.word 0x676c6974			; 'glit'
lit_1164:
	.word 0x6c616e74			; 'lant'

sub_1168:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl GetGlobals
	bl GetMyPort__9TAppWorldFv
	ldr r0, [r0]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x1c]
	ldr r1, lit_1218
	bl sub_2274
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r3, lit_121c
	stmdb sp!, {r3}
	mov r3, #1
	ldr r0, [r4, #0x1c]
	ldr r2, lit_1220
	ldr r5, lit_1224
	mov r1, r5
	bl sub_22a4
	add sp, sp, #4
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r3, lit_1228
	stmdb sp!, {r3}
	mov r3, #0
	ldr r0, [r4, #0x1c]
	ldr r2, lit_122c
	ldr r1, lit_1230
	bl sub_22a4
	add sp, sp, #4
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r3, lit_1234
	stmdb sp!, {r3}
	mov r3, #2
	ldr r0, [r4, #0x1c]!
	ldr r2, lit_1238
	mov r1, r5
	bl sub_22a4
	add sp, sp, #4
	teq r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_1218:
	.rword sub_1b38				; relocated
lit_121c:
	.rword sub_0e08				; relocated
lit_1220:
	.word 0x6c696e6b			; 'link'
lit_1224:
	.word 0x6c616e74			; 'lant'
lit_1228:
	.rword sub_1060				; relocated
lit_122c:
	.word 0x74696d72			; 'timr'
lit_1230:
	.word 0x706e6574			; 'pnet'
lit_1234:
	.rword sub_0e30				; relocated
lit_1238:
	.word 0x706b7420			; 'pkt '

sub_123c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	ldr r0, [r0, #0x3c]
	teq r0, #0
	beq loc_1350
	add r7, r6, #0x42
	teq r0, #3
	beq loc_12a0
	teq r0, #6
	beq loc_12e4
	teq r0, #7
	bne loc_1350
	teq r5, #2
	bne loc_12e4
	mov r1, r7
	ldr r0, [r4, #0x14]
	bl sub_0b28
	teq r0, #0
	movne r0, #6
	strne r0, [r4, #0x3c]
	b loc_1308
loc_12a0:
	mov r1, r7
	ldr r0, [r4, #0x38]
	bl sub_07b4
	teq r0, #0
	beq loc_1350
	teq r5, #2
	teqne r5, #3
	bne loc_1350
	mov r0, #4
	str r0, [r4, #0x3c]
	ldr r5, [r4, #0x38]
	mov r0, r4
	bl sub_0c50
	strb r0, [r5, #3]
	ldr r0, [r4, #0x1c]!
	bl sub_22c8
	b loc_1350
loc_12e4:
	teq r5, #2
	beq loc_1308
	teq r5, #1
	bne loc_1318
	add r1, r6, #0x4c
	ldr r0, [r4, #0x38]
	bl sub_07b4
	teq r0, #0
	beq loc_1324
loc_1308:
	add r2, r6, #0x3c
	mov r1, r7
	ldr r0, [r4, #0x44]
	bl sub_1da8
loc_1318:
	teq r5, #3
	teqne r5, #1
	bne loc_1340
loc_1324:
	mov r0, r6
	ldr r1, [r4, #0x38]
	bl sub_0b28
	teq r0, #0
	movne r1, r6
	movne r0, r4
	blne sub_1358
loc_1340:
	teq r5, #3
	moveq r1, r7
	ldreq r0, [r4, #0x44]!
	bleq sub_1e34
loc_1350:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_1358:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r3, r1, #0x42
	stmdb sp!, {r3}
	add r2, r1, #0x3c
	ldr r3, [r0, #0x38]
	ldr r0, [r0, #0x14]
	mov r1, #2
	bl sub_08ec
	add sp, sp, #4
	ldr r0, [r4, #0x14]
	ldr r3, [r0]
	stmdb sp!, {r3}
	mov r3, #1
	ldr r0, [r4, #0x1c]!
	ldr r2, lit_13b4
	ldr r1, lit_13b8
	bl sub_22e0
	add sp, sp, #4
	teq r0, #0
	ldmdb fp, {r4, fp, sp, pc}
lit_13b4:
	.word 0x736e6443			; 'sndC'
lit_13b8:
	.word 0x6c616e74			; 'lant'

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #8
	ldr r0, lit_1490
	ldmia r0, {r3, ip}
	stmia sp, {r3, ip}
	mov r5, #0
	ldr r0, [r4, #0x1c]
	teq r0, #0
	beq loc_141c
	mov r3, sp
	stmdb sp!, {r3}
	mov r3, #1
	ldr r2, lit_1494
	ldr r1, lit_1498
	bl sub_22e0
	add sp, sp, #4
	ldr r0, [r4, #0x1c]
	bl sub_228c
	ldr r0, [r4, #0x1c]
	bl sub_2228
	str r5, [r4, #0x1c]
loc_141c:
	mvn r0, #1
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x38]
	bl __dl__FPv
	ldr r0, [r4, #0x14]
	teq r0, #0
	movne r1, #1
	blne sub_00e8
	ldr r0, [r4, #0x10]
	teq r0, #0
	movne r1, #1
	blne sub_00e8
	ldr r0, [r4, #0x18]
	teq r0, #0
	movne r1, #1
	blne sub_00e8
	ldr r0, [r4, #0x44]
	teq r0, #0
	movne r1, #1
	blne sub_1d08
	ldr r0, [r4, #0x4c]
	bl __dl__FPv
	ldr r0, [r4, #0x60]
	teq r0, #0
	beq loc_148c
	mov r1, #1
	bl __dt__14CBufferSegmentFv
	str r5, [r4, #0x60]!
loc_148c:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_1490:
	.rword data_21b0			; relocated
lit_1494:
	.word 0x646d6361			; 'dmca'
lit_1498:
	.word 0x6c616e74			; 'lant'

sub_149c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #8
	mov r5, #0
	ldr r1, lit_1514
	ldmia r1, {ip, lr}
	stmia sp, {ip, lr}
	ldr r0, [r0, #0x38]
	mov r3, r0
	stmdb sp!, {r3}
	mov r3, r0
	add r2, sp, #4
	mov r1, #3
	ldr r0, [r4, #0x14]
	bl sub_08ec
	add sp, sp, #4
	ldr r0, [r4, #0x14]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0xc8
	bl sub_1ae0
	teq r0, #0
	bne loc_1510
	ldr r0, [r4, #0x1c]!
	bl sub_22b0
	teq r0, #0
	moveq r0, r5
loc_1510:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_1514:
	.rword data_21c0			; relocated

Method10:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	sub sp, sp, #8
	ldrb r3, [r1, #0xa]
	ldr r2, [r1, #8]
	mov r2, r2, lsr #16
	mov r0, sp
	mov r1, #0
	bl sub_0754
	ldr r0, [r4, #0x3c]
	teq r0, #6
	teqne r0, #7
	movne r0, #0xed
	subne r0, r0, #0x3000
	bne loc_16a4
	mov r1, sp
	ldr r0, [r4, #0x44]
	bl sub_1d38
	movs r6, r0
	beq loc_163c
	mov r0, r5
	mvn r2, #0
	mov r1, #3
	bl Hide__11CBufferListFli
	mov r0, r5
	bl ResetMark__11CBufferListFv
	mov r2, r6
	mov r1, r5
	ldr r0, [r4, #0x18]
	bl sub_0a14
	ldrb r0, [r4, #0x59]
	ldr r6, lit_15f8
	ldr r5, lit_15fc
	teq r0, #0
	beq loc_1600
	mov r0, r4
	bl sub_1884
	teq r0, #0
	beq loc_1600
	ldr r0, [r4, #0x5c]
	ldr r3, [r0]
	stmdb sp!, {r3}
	mov r3, #1
	mov r2, r6
	mov r1, r5
	ldr r0, [r4, #0x1c]
	bl sub_22e0
	add sp, sp, #4
	teq r0, #0
	bne loc_1698
	ldr r0, [r4, #0x5c]
	bl sub_0aac
	b loc_162c
lit_15f8:
	.word 0x736e6443			; 'sndC'
lit_15fc:
	.word 0x6c616e74			; 'lant'
loc_1600:
	ldr r0, [r4, #0x18]
	ldr r3, [r0]
	stmdb sp!, {r3}
	mov r3, #1
	mov r2, r6
	mov r1, r5
	ldr r0, [r4, #0x1c]
	bl sub_22e0
	add sp, sp, #4
	teq r0, #0
	bne loc_1698
loc_162c:
	ldr r0, [r4, #0x18]!
	bl sub_0aac
	mov r0, #0
	b loc_16a4
loc_163c:
	sub sp, sp, #8
	ldr r1, lit_1694
	ldmia r1, {ip, lr}
	stmia sp, {ip, lr}
	add r3, sp, #8
	stmdb sp!, {r3}
	add r2, sp, #4
	mov r1, #1
	ldr r0, [r4, #0x14]
	ldr r3, [r4, #0x38]
	bl sub_08ec
	add sp, sp, #4
	mov r0, #7
	str r0, [r4, #0x3c]
	mov r0, #0xa
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x14]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0xc8
	bl sub_1ae0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_1694:
	.rword data_21c8			; relocated
loc_1698:
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
loc_16a4:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_16a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r4, r0
	mvn r2, #0
	mov r1, #0x22
	bl Seek__11CBufferListFli
	mov r0, r4
	bl Get__11CBufferListFv
	teq r0, #6
	bne loc_1870
	mov r0, r4
	bl Get__11CBufferListFv
	teq r0, #6
	bne loc_1870
	mov r0, r4
	mvn r2, #0
	mov r1, #0x1c
	bl Seek__11CBufferListFli
	mov r0, r4
	bl Get__11CBufferListFv
	and sl, r0, #0xff
	mov r0, r4
	bl Get__11CBufferListFv
	and sb, r0, #0xff
	mov r0, r4
	mvn r2, #0
	mov r1, #0x1f
	bl Seek__11CBufferListFli
	mov r0, r4
	bl Get__11CBufferListFv
	and r8, r0, #0xff
	mov r0, r4
	mvn r2, #0
	mov r1, #0x25
	bl Seek__11CBufferListFli
	sub sp, sp, #4
	mov r0, r4
	bl Get__11CBufferListFv
	and r7, r0, #0xff
	mov r0, r4
	bl Get__11CBufferListFv
	and r6, r0, #0xff
	mov r0, r4
	bl Get__11CBufferListFv
	and r5, r0, #0xff
	mov r0, r4
	bl Get__11CBufferListFv
	and r0, r0, #0xff
	str r0, [sp]
	mov r0, r4
	mvn r2, #0
	mov r1, #0xd
	bl Seek__11CBufferListFli
	mov r0, r4
	mov r1, #0x1f
	bl Put__11CBufferListFi
	mov r0, r4
	mvn r2, #0
	mov r1, #0x17
	bl Seek__11CBufferListFli
	mov r0, r4
	mov r1, #0x17
	bl Put__11CBufferListFi
	mov r0, r4
	mvn r2, #0
	mov r1, #0x20
	bl Seek__11CBufferListFli
	mov r0, r4
	mov r1, #1
	bl Put__11CBufferListFi
	mov r0, r4
	mov r1, #1
	bl Put__11CBufferListFi
	mov r0, r4
	mov r1, #1
	bl Put__11CBufferListFi
	mov r1, sl
	mov r0, r4
	bl Put__11CBufferListFi
	mov r1, sb
	mov r0, r4
	bl Put__11CBufferListFi
	mov r0, r4
	mov r1, #8
	bl Put__11CBufferListFi
	mov r1, r8
	mov r0, r4
	bl Put__11CBufferListFi
	mov r1, r7
	mov r0, r4
	bl Put__11CBufferListFi
	mov r1, r6
	mov r0, r4
	bl Put__11CBufferListFi
	mov r0, r4
	mov r1, #0x80
	bl Put__11CBufferListFi
	mov r1, r5
	mov r0, r4
	bl Put__11CBufferListFi
	mov r0, r4
	ldr r1, [sp]
	bl Put__11CBufferListFi
	mov r0, r4
	mov r1, #0x82
	bl Put__11CBufferListFi
	mov r0, r4
	bl ResetMark__11CBufferListFv
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_1870:
	ldr r0, [r5, #0x10]!
	ldr r0, [r0]
	bl ResetMark__11CBufferListFv
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_1884:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #8
	ldr r0, lit_19f8
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	ldr r0, [r4, #0x18]
	ldr r0, [r0]
	mvn r2, #0
	mov r1, #0x22
	bl Seek__11CBufferListFli
	ldr r0, [r4, #0x18]
	ldr r0, [r0]
	bl Peek__11CBufferListFv
	teq r0, #5
	bne loc_19fc
	bl sub_234c
	mov r5, r0
	mov r1, #0
	bl Init__11CBufferListFUc
	mov r0, r5
	ldr r1, [r4, #0x60]
	bl Insert__11CBufferListFP7CBuffer
	mov r0, r5
	bl ResetMark__11CBufferListFv
	ldr r0, [r4, #0x18]
	ldr r0, [r0]
	mvn r2, #0
	mov r1, #0x16
	bl Seek__11CBufferListFli
	mov r6, #0

sub_1908:
	ldr r0, [r4, #0x18]
	ldr r0, [r0]
	bl Get__11CBufferListFv
	and r1, r0, #0xff
	mov r0, r5
	bl Put__11CBufferListFi
	add r6, r6, #1
	cmp r6, #0xd
	blt sub_1908
	mov r0, r5
	mvn r2, #0
	mov r1, #1
	bl Seek__11CBufferListFli
	mov r0, r5
	mov r1, #0x14
	bl Put__11CBufferListFi
	mov r0, r5
	mov r2, #0
	mov r1, #2
	bl Seek__11CBufferListFli
	mov r0, r5
	mov r1, #0
	bl Put__11CBufferListFi
	mov r0, r5
	mov r1, #0
	bl Put__11CBufferListFi
	mov r0, r5
	mov r2, #0
	mov r1, #4
	bl Seek__11CBufferListFli
	mov r0, r5
	mov r1, #6
	bl Put__11CBufferListFi
	mov r0, r5
	mov r1, #6
	bl Put__11CBufferListFi
	mov r0, r5
	mov r1, #6
	bl Put__11CBufferListFi
	mov r0, r5
	mov r1, #5
	bl Put__11CBufferListFi
	mov r6, #0

sub_19b4:
	mov r0, r5
	mov r1, #0
	bl Put__11CBufferListFi
	add r6, r6, #1
	cmp r6, #6
	blt sub_19b4
	mov r0, r5
	bl ResetMark__11CBufferListFv
	mov r2, sp
	mov r1, r5
	ldr r0, [r4, #0x5c]!
	bl sub_0a14
	movs r0, r5
	movne r1, #1
	blne __dt__11CBufferListFv
	mov r0, #1
	b loc_1a0c
lit_19f8:
	.rword data_21d0			; relocated
loc_19fc:
	ldr r0, [r4, #0x18]!
	ldr r0, [r0]
	bl ResetMark__11CBufferListFv
	mov r0, #0
loc_1a0c:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method11:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	add r0, r0, #0x20
	stmia r0, {r1, r2}
	sub r0, r0, #0x20
	strb r5, [r0, #0x58]
	b loc_1a64
loc_1a38:
	ldr r0, [r4, #0x4c]
	ldmia r0, {r6, r7}
	mov r0, r4
	bl sub_1a78
	mov r2, r7
	mov r1, r6
	mov r0, r4
	bl sub_0e30
	ldrb r0, [r4, #0x58]
	teq r0, #0
	bne loc_1a70
loc_1a64:
	ldr r0, [r4, #0x54]
	cmp r0, #0
	bhi loc_1a38
loc_1a70:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_1a78:
	mov r1, #0
	ldr r2, [r0, #0x50]
	sub r2, r2, #1
	cmp r2, #0
	bls sub_1ac0
loc_1a8c:
	ldr r2, [r0, #0x4c]
	add r3, r2, r1, lsl #3
	ldr r3, [r3, #8]
	str r3, [r2, r1, lsl #3]
	ldr r2, [r0, #0x4c]
	add r2, r2, r1, lsl #3
	ldr r3, [r2, #0xc]
	add r1, r1, #1
	str r3, [r2, #4]!
	ldr r2, [r0, #0x50]
	sub r2, r2, #1
	cmp r2, r1
	bhi loc_1a8c

sub_1ac0:
	ldr r1, [r0, #0x54]
	sub r1, r1, #1
	str r1, [r0, #0x54]!
	mov pc, lr

Method8:
	mov r0, #0
	mov pc, lr

Method9:
	mov r0, #0
	mov pc, lr

sub_1ae0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	mov r3, r1
	stmdb sp!, {r3}
	ldr r0, [r0, #0x1c]
	mov r3, #1
	ldr r2, lit_1b30
	ldr r1, lit_1b34
	bl sub_22e0
	add sp, sp, #4
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	mov r1, r5
	mov r0, r4
	bl sub_2098
	teq r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_1b30:
	.word 0x736e6443			; 'sndC'
lit_1b34:
	.word 0x6c616e74			; 'lant'

sub_1b38:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, r1
	mov r1, r2
	bl sub_0274
	teq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1b5c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x10
	mov r1, #0xa
	mov r0, #0
	bl sub_1c74
	str r0, [r4, #0x44]
	teq r0, #0
	beq loc_1c68
	mov r0, #8
	bl __nw__FUi
	cmp r0, #0
	str r0, [r4, #0x38]
	beq loc_1c68
	mov r3, #0
	ldr r2, lit_1c58
	stmdb sp!, {r2, r3}
	add r1, sp, #8
	ldr r0, [r4, #0x1c]
	ldr r3, lit_1c5c
	mov r2, #0x10
	bl sub_22ec
	add sp, sp, #8
	teq r0, #0
	bne loc_1c60
	mov r0, #2
	str r0, [r4, #0x50]
	mov r0, #0x10
	bl __nw__FUi
	str r0, [r4, #0x4c]
	teq r0, #0
	beq loc_1c68
	mov r0, #0
	bl sub_00a8
	str r0, [r4, #0x10]
	teq r0, #0
	beq loc_1c68
	bl sub_03d8
	teq r0, #0
	bne loc_1c60
	mov r0, #0
	bl sub_00a8
	str r0, [r4, #0x14]
	teq r0, #0
	beq loc_1c68
	mov r0, #0
	bl sub_00a8
	str r0, [r4, #0x18]
	teq r0, #0
	beq loc_1c68
	mov r0, #0
	bl sub_00a8
	str r0, [r4, #0x5c]
	teq r0, #0
	beq loc_1c68
	bl sub_2354
	mov r1, #0x14
	str r0, [r4, #0x60]!
	bl Init__14CBufferSegmentFl
	mov r0, #0
	b loc_1c70
lit_1c58:
	.word 0x67706273			; 'gpbs'
lit_1c5c:
	.word 0x6c616e74			; 'lant'
loc_1c60:
	teq r0, #0
	bne loc_1c70
loc_1c68:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
loc_1c70:
	ldmdb fp, {r4, fp, sp, pc}

sub_1c74:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	mov r5, r1
	bne loc_1ca4
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	bne loc_1ca4
loc_1c9c:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_1ca4:
	sub sp, sp, #8
	ldr r0, lit_1d04
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	add r0, r4, #4
	mov r1, sp
	mov r2, #6
	bl memcpy
	str r5, [r4, #0xc]
	mov r0, r5, lsl #4
	bl __nw__FUi
	str r0, [r4]
	mov r0, #0
	mov r1, #0
	cmp r5, #0
	bls sub_1cf8

sub_1ce4:
	ldr r2, [r4]
	str r1, [r2, r0, lsl #4]
	add r0, r0, #1
	cmp r0, r5
	blo sub_1ce4

sub_1cf8:
	str r1, [r4, #0x10]
	add sp, sp, #8
	b loc_1c9c
lit_1d04:
	.rword data_21d8			; relocated

sub_1d08:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0]
	bl __dl__FPv
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1d38:
	stmdb sp!, {r4, lr}
	ldrb ip, [r1, #3]
	teq ip, #0xff
	addeq r0, r0, #4
	ldmiaeq sp!, {r4, pc}
	mov r3, #0
	ldr r2, [r0]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bls sub_1da0
loc_1d60:
	ldr lr, [r2]
	teq lr, #1
	ldrbeq lr, [r2, #0xb]
	ldrbeq r4, [r1, #1]
	teqeq lr, r4
	ldrbeq r4, [r2, #0xc]
	ldrbeq lr, [r1, #2]
	teqeq r4, lr
	ldrbeq lr, [r2, #0xd]
	teqeq lr, ip
	addeq r0, r2, #4
	ldmiaeq sp!, {r4, pc}
	add r2, r2, #0x10
	add r3, r3, #1
	cmp r0, r3
	bhi loc_1d60

sub_1da0:
	mov r0, #0
	ldmia sp!, {r4, pc}

sub_1da8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	bl sub_1d38
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r4, #0x10]
	ldr r1, [r4]
	add r0, r1, r0, lsl #4
	add r0, r0, #4
	mov r1, r6
	mov r2, #6
	bl memcpy
	ldr r0, [r4]
	ldr r1, [r4, #0x10]
	add r0, r0, r1, lsl #4
	add r0, r0, #0xa
	mov r1, r5
	mov r2, #4
	bl memcpy
	mov r1, #1
	ldr r0, [r4]
	ldr r2, [r4, #0x10]
	str r1, [r0, r2, lsl #4]
	ldr r0, [r4, #0x10]
	add r0, r0, r1
	str r0, [r4, #0x10]
	ldr r1, [r4, #0xc]
	cmp r0, r1
	movhs r0, #0
	strhs r0, [r4, #0x10]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1e34:
	stmdb sp!, {r4, lr}
	mov r3, #0
	ldr ip, [r0, #0xc]
	cmp ip, #0
	ldr r2, [r0]
	ldmials sp!, {r4, pc}
	mov ip, #0
loc_1e50:
	ldr lr, [r2]
	teq lr, #1
	ldrbeq r4, [r2, #0xb]
	ldrbeq lr, [r1, #1]
	teqeq r4, lr
	ldrbeq r4, [r2, #0xc]
	ldrbeq lr, [r1, #2]
	teqeq r4, lr
	ldrbeq r4, [r2, #0xd]
	ldrbeq lr, [r1, #3]
	teqeq r4, lr
	streq ip, [r2]
	add r2, r2, #0x10
	add r3, r3, #1
	ldr lr, [r0, #0xc]
	cmp lr, r3
	bhi loc_1e50
	ldmia sp!, {r4, pc}

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov sb, #0
	str sb, [r0, #0x3c]
	adr r1, str_1f7c, #30
	adr r0, str_1f88, #30
	bl NewByName__FPCcT1
	str r0, [r4, #0x1c]
	teq r0, #0
	ldreq r7, lit_1f9c
	beq loc_1fb8
	adr r3, str_1fa0, #30
	stmdb sp!, {r3}
	mov r2, r4
	adr r3, str_1fa8, #30
	mov r1, #0
	bl sub_2268
	add sp, sp, #4
	movs r7, r0
	bne loc_1fc0
	mov r0, r4
	bl sub_1b5c
	movs r7, r0
	bne loc_1fb8
	mov r0, r4
	bl sub_1168
	movs r7, r0
	bne loc_1fb8
	add r1, r4, #0x2c
	mov r8, r1
	mov r0, r4
	bl sub_2120
	movs r7, r0
	bne loc_1fb0
	mov r1, r8
	ldr r0, [r4, #0x14]
	bl sub_07e4
	mov r1, r8
	ldr r0, [r4, #0x18]
	bl sub_099c
	mov r1, r8
	ldr r0, [r4, #0x5c]
	bl sub_099c
	mov r0, r4
	bl sub_1fe0
	movs r7, r0
	bne loc_1fb0
	mov r0, #2
	str r0, [r6]
	mov r0, #1
	str r0, [r5]
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
str_1f7c:
	.asciz "TClientAPI"
	.align 4
str_1f88:
	.asciz "TLanternClientAPI"
	.align 4
lit_1f9c:
	.word 0xffffd0eb
str_1fa0:
	.asciz "enet"
	.align 4
str_1fa8:
	.asciz "ATalk"
	.align 4
loc_1fb0:
	ldr r0, [r4, #0x1c]!
	bl sub_228c
loc_1fb8:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_1fc0:
	ldr r0, [r4, #0x1c]
	bl sub_2228
	str sb, [r4, #0x1c]!
	b loc_1fb8

Method5:
	mov r0, #0
	mov pc, lr

Method6:
	mov r0, #0
	mov pc, lr

sub_1fe0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x48]
	mov r5, #0
	teq r0, #0
	bne loc_2088
	mov r3, #0
	ldr r2, lit_2090
	stmdb sp!, {r2, r3}
	add r1, r4, #0x48
	ldr r0, [r4, #0x1c]
	ldr r3, lit_2094
	mov r2, #4
	bl sub_22ec
	add sp, sp, #8
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x48]
	teq r0, #0
	bne loc_2088
	mov r0, #0x64
	str r0, [r4, #0x40]
	mov r0, r4
	mov r1, #0x64
	bl sub_2098
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x1c]
	bl sub_22b0
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x34]
	teq r0, #0
	strne r5, [r4, #0x34]!
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x3c]!
	teq r0, #2
	movne r0, #0xec
	subne r0, r0, #0x3000
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_2088:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2090:
	.word 0x676c6974			; 'glit'
lit_2094:
	.word 0x6c616e74			; 'lant'

sub_2098:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x10
	add r0, sp, #8
	mov r2, #0x66
	add r2, r2, #0xe00
	bl __ct__5TTimeFUl9TimeUnits
	mov r0, sp
	bl GetGlobalTime
	sub sp, sp, #8
	add r1, sp, #8
	ldmia r1, {ip, lr}
	stmia sp, {ip, lr}
	mov r1, sp
	add r0, sp, #0x10
	bl CompAdd
	add r0, sp, #0x10
	ldmia sp!, {ip, lr}
	stmia r0, {ip, lr}
	mov r3, #0
	ldr r2, lit_2118
	stmdb sp!, {r2, r3}
	add r2, sp, #0x10
	ldr r0, [r4, #0x1c]!
	ldr r1, [r4, #0xc]!
	ldr r3, lit_211c
	bl sub_2304
	add sp, sp, #8
	teq r0, #0
	ldmdb fp, {r4, fp, sp, pc}
lit_2118:
	.word 0x74696d72			; 'timr'
lit_211c:
	.word 0x706e6574			; 'pnet'

sub_2120:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #8
	ldr r0, lit_2198
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	mov r3, #6
	mov r2, r1
	stmdb sp!, {r2, r3}
	mov r3, #2
	ldr r0, [r4, #0x1c]
	ldr r2, lit_219c
	ldr r5, lit_21a0
	mov r1, r5
	bl sub_22e0
	add sp, sp, #8
	teq r0, #0
	bne loc_2194
	mov r3, sp
	stmdb sp!, {r3}
	mov r3, #1
	ldr r0, [r4, #0x1c]!
	ldr r2, lit_21a4
	mov r1, r5
	bl sub_22e0
	add sp, sp, #4
	teq r0, #0
loc_2194:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2198:
	.rword data_21b8			; relocated
lit_219c:
	.word 0x67647661			; 'gdva'
lit_21a0:
	.word 0x6c616e74			; 'lant'
lit_21a4:
	.word 0x616d6361			; 'amca'
data_21a8:
	.word 0x00000000
	.word 0x00000000
data_21b0:
	.word 0x090007ff			; stmdbeq r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl}
	.word 0xffff0000
data_21b8:
	.word 0x090007ff			; stmdbeq r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl}
	.word 0xffff0000
data_21c0:
	.word 0x090007ff			; stmdbeq r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl}
	.word 0xffff0000
data_21c8:
	.word 0x090007ff			; stmdbeq r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl}
	.word 0xffff0000
data_21d0:
	.word 0x090007ff			; stmdbeq r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl}
	.word 0xffff0000
data_21d8:
	.word 0x090007ff			; stmdbeq r0, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl}
	.word 0xffff0000

sub_21e0:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_21e8:
	.asciz "TLanternClientAPI"
	.align 4

sub_21fc:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_21e0
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_2228:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_223c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_223c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_2244:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_2250:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_225c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_2268:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_2274:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_2280:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_228c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_2298:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_22a4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_22b0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_22bc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_22c8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

sub_22d4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_22e0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_22ec:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48

sub_22f8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c

sub_2304:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x50

sub_2310:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x54

sub_231c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x58

sub_2328:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x5c

sub_2334:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x60

sub_2340:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x64

sub_234c:
	mov r0, #0
	b __ct__11CBufferListFv

sub_2354:
	mov r0, #0
	b __ct__14CBufferSegmentFv

CompAdd:
	ldr pc, lit_2360
lit_2360:
	.word 0x01801750			; glue 01801750 -> CompAdd

FreeInstance__FP9TProtocol:
	ldr pc, lit_2368
lit_2368:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

GetGlobalTime:
	ldr pc, lit_2370
lit_2370:
	.word 0x018010a4			; glue 018010a4 -> GetGlobalTime

GetGlobals:
	ldr pc, lit_2378
lit_2378:
	.word 0x018010a0			; glue 018010a0 -> GetGlobals

GetMyPort__9TAppWorldFv:
	ldr pc, lit_2380
lit_2380:
	.word 0x01801b08			; glue 01801b08 -> GetMyPort__9TAppWorldFv

GetSize__11CBufferListCFv:
	ldr pc, lit_2388
lit_2388:
	.word 0x01801b24			; glue 01801b24 -> GetSize__11CBufferListCFv

GetSize__14CBufferSegmentCFv:
	ldr pc, lit_2390
lit_2390:
	.word 0x01801b2c			; glue 01801b2c -> GetSize__14CBufferSegmentCFv

GetUserRefCon__14TUSharedMemMsgFPUl:
	ldr pc, lit_2398
lit_2398:
	.word 0x01801120			; glue 01801120 -> GetUserRefCon__14TUSharedMemMsgFPUl

Get__11CBufferListFv:
	ldr pc, lit_23a0
lit_23a0:
	.word 0x01801ad8			; glue 01801ad8 -> Get__11CBufferListFv

Getn__11CBufferListFPUcl:
	ldr pc, lit_23a8
lit_23a8:
	.word 0x01801b0c			; glue 01801b0c -> Getn__11CBufferListFPUcl

Hide__11CBufferListFli:
	ldr pc, lit_23b0
lit_23b0:
	.word 0x01801b3c			; glue 01801b3c -> Hide__11CBufferListFli

Init__11CBufferListFUc:
	ldr pc, lit_23b8
lit_23b8:
	.word 0x01801b58			; glue 01801b58 -> Init__11CBufferListFUc

Init__14CBufferSegmentFPvlUcN22:
	ldr pc, lit_23c0
lit_23c0:
	.word 0x01801b78			; glue 01801b78 -> Init__14CBufferSegmentFPvlUcN22

Init__14CBufferSegmentFl:
	ldr pc, lit_23c8
lit_23c8:
	.word 0x01801b74			; glue 01801b74 -> Init__14CBufferSegmentFl

Init__6TUPortFv:
	ldr pc, lit_23d0
lit_23d0:
	.word 0x0180118c			; glue 0180118c -> Init__6TUPortFv

InsertAt__11CBufferListFlP7CBuffer:
	ldr pc, lit_23d8
lit_23d8:
	.word 0x01801bb4			; glue 01801bb4 -> InsertAt__11CBufferListFlP7CBuffer

InsertFirst__11CBufferListFP7CBuffer:
	ldr pc, lit_23e0
lit_23e0:
	.word 0x01801bcc			; glue 01801bcc -> InsertFirst__11CBufferListFP7CBuffer

InsertLast__11CBufferListFP7CBuffer:
	ldr pc, lit_23e8
lit_23e8:
	.word 0x01801bd0			; glue 01801bd0 -> InsertLast__11CBufferListFP7CBuffer

Insert__11CBufferListFP7CBuffer:
	ldr pc, lit_23f0
lit_23f0:
	.word 0x01801bac			; glue 01801bac -> Insert__11CBufferListFP7CBuffer

NewByName__FPCcT1:
	ldr pc, lit_23f8
lit_23f8:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

Peek__11CBufferListFv:
	ldr pc, lit_2400
lit_2400:
	.word 0x01801c80			; glue 01801c80 -> Peek__11CBufferListFv

Put__11CBufferListFi:
	ldr pc, lit_2408
lit_2408:
	.word 0x01801cac			; glue 01801cac -> Put__11CBufferListFi

Put__14CBufferSegmentFi:
	ldr pc, lit_2410
lit_2410:
	.word 0x01801cb8			; glue 01801cb8 -> Put__14CBufferSegmentFi

Putn__11CBufferListFPCUcl:
	ldr pc, lit_2418
lit_2418:
	.word 0x01801cc4			; glue 01801cc4 -> Putn__11CBufferListFPCUcl

Remove__11CBufferListFP7CBuffer:
	ldr pc, lit_2420
lit_2420:
	.word 0x01801cf0			; glue 01801cf0 -> Remove__11CBufferListFP7CBuffer

ResetMark__11CBufferListFv:
	ldr pc, lit_2428
lit_2428:
	.word 0x01801d5c			; glue 01801d5c -> ResetMark__11CBufferListFv

Reset__11CBufferListFv:
	ldr pc, lit_2430
lit_2430:
	.word 0x01801d28			; glue 01801d28 -> Reset__11CBufferListFv

Seek__11CBufferListFli:
	ldr pc, lit_2438
lit_2438:
	.word 0x01801d6c			; glue 01801d6c -> Seek__11CBufferListFli

Seek__14CBufferSegmentFli:
	ldr pc, lit_2440
lit_2440:
	.word 0x01801d70			; glue 01801d70 -> Seek__14CBufferSegmentFli

Ticks__Fv:
	ldr pc, lit_2448
lit_2448:
	.word 0x01801fec			; glue 01801fec -> Ticks__Fv

__ct__11CBufferListFv:
	ldr pc, lit_2450
lit_2450:
	.word 0x0180188c			; glue 0180188c -> __ct__11CBufferListFv

__ct__14CBufferSegmentFv:
	ldr pc, lit_2458
lit_2458:
	.word 0x018018d0			; glue 018018d0 -> __ct__14CBufferSegmentFv

__ct__17TCommToolGetReplyFv:
	ldr pc, lit_2460
lit_2460:
	.word 0x01801e88			; glue 01801e88 -> __ct__17TCommToolGetReplyFv

__ct__5TTimeFUl9TimeUnits:
	ldr pc, lit_2468
lit_2468:
	.word 0x01800d94			; glue 01800d94 -> __ct__5TTimeFUl9TimeUnits

__dl__FPv:
	ldr pc, lit_2470
lit_2470:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__11CBufferListFv:
	ldr pc, lit_2478
lit_2478:
	.word 0x0180191c			; glue 0180191c -> __dt__11CBufferListFv

__dt__14CBufferSegmentFv:
	ldr pc, lit_2480
lit_2480:
	.word 0x01801938			; glue 01801938 -> __dt__14CBufferSegmentFv

__dt__8TUObjectFv:
	ldr pc, lit_2488
lit_2488:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_2490
lit_2490:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

__rt_udiv:
	ldr pc, lit_2498
lit_2498:
	.word 0x01800014			; glue 01800014 -> __rt_udiv

memcpy:
	ldr pc, lit_24a0
lit_24a0:
	.word 0x0180011c			; glue 0180011c -> memcpy
