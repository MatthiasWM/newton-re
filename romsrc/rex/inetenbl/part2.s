; "Newton Internet Enabler" part 2: protocol (74076 bytes)
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
	.asciz "PInetToolMux"
InterfaceName:
	.asciz "PMuxTool"
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

AllocInstanceByName__FPCcT1:
	ldr pc, lit_009c
lit_009c:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

sub_00a0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_00c4
	mov r0, #0x18
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_00c4:
	mvn r1, #0
	str r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	str r1, [r0, #0x10]
	str r1, [r0, #0x14]
	ldmdb fp, {fp, sp, pc}

sub_00e0:
	str r1, [r0, #4]!
	mov pc, lr

Method7:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x18]
	teq r0, r1
	bne loc_0134
	ldr r0, [r4, #0x1c]
	teq r0, #0
	beq loc_0134
	mov r0, r4
	mov r3, #0
	mov r2, #0x8e
	sub r2, r2, #0xeb00
	mov r1, #0x14
	bl sub_096c
	mov r0, #0
	str r0, [r4, #0x18]!
loc_0134:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_11d28

Method8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #8
	mov r0, sp
	bl GetGlobalTime
	ldr r5, [sp, #4]
	ldr r0, [r4, #0x10]
	mov r2, r0
	ldr r1, [r0, #0x58]
	sub r1, r5, r1
	ldr r0, [r0, #0x60]
	teq r0, #0
	beq loc_0198
	ldr r0, [r2, #0x5c]!
	bl __rt_udiv
	mov r1, r0
	cmp r0, #4
	movhi r0, #4
	movls r0, r1
	b loc_019c
loc_0198:
	mov r0, #0x14
loc_019c:
	mov r6, r0
	sub sp, sp, #8
loc_01a4:
	ldr r0, [r4, #0x1c]
	bl sub_8afc
	ldr r0, [r4, #0x1c]
	bl sub_8674
	sub r6, r6, #1
	cmp r6, #0
	bgt loc_01a4
	mov r0, sp
	bl GetGlobalTime
	ldr r0, [sp, #4]
	ldr r1, [r4, #0x10]
	str r0, [r1, #0x58]!
	ldr r0, [r4, #0x10]
	ldrb r1, [r0]
	teq r1, #0
	beq sub_0214
	ldr r0, [r0, #4]
	sub r0, r5, r0
	subs ip, r0, #0x1500000
	cmphs ip, #0x18000
	bls sub_0214
	mov r0, r4
	mov r2, #0
	mov r1, #0
	bl sub_0ca0
	mov r0, #0
	ldr r1, [r4, #0x10]!
	strb r0, [r1]

sub_0214:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method9:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r7, r3
	ldr r0, [r0, #0x20]
	teq r0, #0
	ldrne r0, [r0, #0x24]
	teqne r0, #0
	beq loc_0268
	mov r3, r7
	mov r2, r5
	mov r1, r6
	bl sub_1209c
	teq r0, #0
	ldrne r0, [r4, #0x1c]!
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, lr}
	bne sub_8674
loc_0268:
	mov r3, r7
	mov r2, r5
	mov r1, r6
	ldr r0, [r4, #0x14]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b loc_11c9c

Method10:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	ldr r0, [r0, #0x20]
	teq r0, #0
	ldrne r0, [r0, #0x24]
	teqne r0, #0
	beq loc_02c8
	mov r2, r6
	mov r1, r5
	bl sub_120a8
	teq r0, #0
	ldrne r0, [r4, #0x1c]!
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne sub_8674
loc_02c8:
	mov r2, r6
	mov r1, r5
	ldr r0, [r4, #0x14]!
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b loc_11ca8

Method12:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x1c]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r6, #0

sub_02fc:
	add r1, r6, r6, lsl #1
	add r1, r1, r6, lsl #3
	ldr r0, [r4, #0x1c]
	add r0, r0, r1, lsl #3
	add r5, r0, #0x18
	ldr r0, [r5]
	mov r0, r0, asr #16
	teq r0, #1
	bne loc_03c4
	ldr r0, [r5, #2]
	mov r0, r0, asr #16
	tst r0, #2
	beq loc_0358
	add r2, r5, #4
	bic r0, r0, #3
	strb r0, [r5, #3]
	mov r0, r0, asr #8
	strb r0, [r5, #2]
	ldr r1, [r5, #0x54]
	teq r1, #0
	movne r3, r6
	movne r0, r4
	blne sub_0cf8
loc_0358:
	ldr r0, [r5, #2]
	mov r0, r0, asr #16
	tst r0, #0x20
	beq loc_0390
	add r2, r5, #0x2c
	bic r0, r0, #0x30
	strb r0, [r5, #3]
	mov r0, r0, asr #8
	strb r0, [r5, #2]
	ldr r1, [r5, #0x54]
	teq r1, #0
	movne r3, r6
	movne r0, r4
	blne sub_0d24
loc_0390:
	ldr r0, [r5, #2]
	mov r0, r0, asr #16
	tst r0, #0x8000
	beq loc_03c4
	bic r0, r0, #0x8000
	strb r0, [r5, #3]
	mov r0, r0, asr #8
	strb r0, [r5, #2]
	ldr r1, [r5, #0x54]!
	teq r1, #0
	movne r2, r6
	movne r0, r4
	blne sub_0d50
loc_03c4:
	add r6, r6, #1
	cmp r6, #0x20
	blt sub_02fc
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method11:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r1]
	cmp r1, #0x1f
	addls pc, pc, r1, lsl #2
	b loc_0648
	b loc_0648
	b loc_047c
	b loc_049c
	b loc_04ac
	b loc_04bc
	b loc_04cc
	b loc_04dc
	b loc_04fc
	b loc_0514
	b loc_0524
	b loc_0538
	b loc_056c
	b loc_0574
	b loc_0584
	b loc_05a0
	b loc_05b4
	b loc_05c0
	b loc_05cc
	b loc_05e0
	b loc_05ec
	b loc_0648
	b loc_0600
	b loc_0648
	b loc_0648
	b loc_0648
	b loc_0610
	b loc_0620
	b loc_062c
	b loc_0648
	b loc_0648
	b loc_0638

sub_0470:
	ldr r1, [r4, #4]!
	ldmdb fp, {r4, fp, sp, lr}
	b sub_0d78
loc_047c:
	ldr r3, [r4, #8]
	stmdb sp!, {r3}
	ldr r1, [r4, #4]
	add r3, r4, #0x10
	ldmia r3, {r2, r3}
	ldr r0, [r0, #0x1c]
	bl sub_153c
	b loc_0598
loc_049c:
	ldmib r4, {r1, r2}
	ldr r0, [r0, #0x1c]
	bl sub_180c
	b loc_0650
loc_04ac:
	ldmib r4, {r1, r2}
	ldr r0, [r0, #0x1c]
	bl sub_12f8
	b loc_0650
loc_04bc:
	ldr r1, [r4, #4]
	ldr r0, [r0, #0x1c]
	bl sub_12f0
	b loc_0650
loc_04cc:
	ldmib r4, {r1, r2}
	ldr r0, [r0, #0x1c]
	bl sub_12e8
	b loc_0650
loc_04dc:
	ldr r3, [r4, #0x18]
	stmdb sp!, {r3}
	ldr r1, [r4, #4]
	add r3, r4, #0x10
	ldmia r3, {r2, r3}
	ldr r0, [r0, #0x1c]
	bl sub_169c
	b loc_0598
loc_04fc:
	ldr r3, [r4, #0x10]
	stmdb sp!, {r3}
	ldmib r4, {r1, r2, r3}
	ldr r0, [r0, #0x1c]
	bl sub_139c
	b loc_0598
loc_0514:
	ldmib r4, {r1, r2}
	ldr r0, [r0, #0x1c]
	bl sub_148c
	b loc_0650
loc_0524:
	ldr r1, [r4, #0x10]
	ldmib r4, {r2, r3}
	ldr r0, [r0, #0x1c]
	bl sub_1300
	b loc_0650
loc_0538:
	ldr r1, [r4, #4]
	cmp r1, #0x20
	bge loc_054c
	cmp r1, #0
	bge loc_0554
loc_054c:
	mov r0, #0
	b loc_0618
loc_0554:
	ldr r0, [r0, #0x1c]
	add ip, r1, r1, lsl #1
	add r1, ip, r1, lsl #3
	add r0, r0, r1, lsl #3
	add r0, r0, #0x18
	b loc_0618
loc_056c:
	ldr r0, [r0, #0x10]
	b loc_0618
loc_0574:
	ldr r1, [r4, #4]
	ldr r2, [r4, #0x10]
	bl sub_0e08
	b loc_0650
loc_0584:
	ldr r3, [r4, #0xc]
	stmdb sp!, {r3}
	ldmib r4, {r1, r3}
	ldr r2, [r4, #0x10]
	bl sub_0658
loc_0598:
	add sp, sp, #4
	b loc_0650
loc_05a0:
	ldr r2, [r4, #4]!
	mov r3, #1
	ldr r1, [r0, #0x20]
	ldmdb fp, {r4, fp, sp, lr}
	b sub_06f8
loc_05b4:
	ldr r1, [r0, #0x20]
	ldmdb fp, {r4, fp, sp, lr}
	b loc_08ec
loc_05c0:
	ldr r1, [r4, #4]
	bl sub_0744
	b loc_0650
loc_05cc:
	ldr r2, [r4, #4]!
	mov r3, #1
	ldr r1, [r0, #0x20]
	ldmdb fp, {r4, fp, sp, lr}
	b sub_07e8
loc_05e0:
	ldr r1, [r4, #4]
	bl sub_085c
	b loc_0650
loc_05ec:
	ldr r2, [r4, #4]!
	mov r3, #1
	ldr r1, [r0, #0x20]
	ldmdb fp, {r4, fp, sp, lr}
	b sub_08c4
loc_0600:
	ldr r1, [r4, #4]
	ldr r2, [r4, #0x10]
	bl sub_0e90
	b loc_0650
loc_0610:
	ldr r1, [r4, #4]
	bl sub_0aa0
loc_0618:
	str r0, [r4, #0x20]!
	ldmdb fp, {r4, fp, sp, pc}
loc_0620:
	ldr r1, [r4, #4]
	bl sub_0a7c
	b loc_0650
loc_062c:
	ldr r1, [r4, #4]
	bl sub_0ac4
	b loc_0650
loc_0638:
	bl sub_0c00
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	b loc_0650
loc_0648:
	mov r0, #0x7e
	sub r0, r0, #0x3f00
loc_0650:
	str r0, [r4, #0x1c]!
	ldmdb fp, {r4, fp, sp, pc}

sub_0658:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r2
	mov r5, r3
	mov r8, #0
	ldr sb, [fp, #4]
	bl sub_0aa0
	movs r7, r0
	ldrne r0, [r7, #0x24]
	teqne r0, #0
	ldreq r8, lit_06f4
	beq loc_06ec
	ldr r0, [r7]
	teq r0, #3
	beq loc_06ec
	mov r0, #7
	str r0, [r7]
	add r7, r7, #0xc
	stmia r7, {r5, sb}
	sub r7, r7, #0xc
	ldr r0, [r4, #0x14]
	bl sub_11cb4
	mov r1, r0
	mov r2, r6
	ldr r0, [r7, #0x24]
	bl sub_12054
	mov r8, r0
	add ip, r0, #0x3e80
	cmn ip, #1
	beq loc_06ec
	mov r2, r8
	mov r1, r7
	mov r0, r4
	mov r3, #0
	bl sub_06f8
loc_06ec:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_06f4:
	.word 0xffff1587

sub_06f8:
	stmdb sp!, {lr}
	and ip, r3, #0xff
	mvn r3, #0
	teq r1, #0
	beq loc_072c
	teq r2, #0
	ldr r3, [r1, #0x34]
	bne loc_072c
	ldr lr, [r1, #4]
	add lr, lr, #1
	str lr, [r1, #4]
	mov lr, #3
	str lr, [r1]
loc_072c:
	teq ip, #0
	movne r1, r2
	movne r2, r3
	ldmiane sp!, {lr}
	bne loc_0c48
	ldmia sp!, {pc}

sub_0744:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	bl sub_0aa0
	movs r5, r0
	moveq r6, #0x79
	subeq r6, r6, #0x3f00
	beq loc_07d8
	ldr r0, [r5, #4]
	cmp r0, #0
	subgt r0, r0, #1
	strgt r0, [r5, #4]
	ldr r0, [r5, #4]
	teq r0, #0
	bne loc_07d8
	mov r1, r5
	mov r0, r4
	bl sub_1018
	mov r6, #0x6a
	sub r6, r6, #0x3f00
	ldr r0, [r5, #0x24]
	teq r0, #0
	beq loc_07d8
	mov r1, #8
	str r1, [r5]
	bl sub_12060
	mov r6, r0
	add ip, r0, #0x3e80
	cmn ip, #1
	beq loc_07d8
	mov r2, r6
	mov r1, r5
	mov r0, r4
	mov r3, #0
	bl sub_07e8
loc_07d8:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Sizeof:
	mov r0, #0x24
	mov pc, lr

sub_07e8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	mov r6, r2
	and r8, r3, #0xff
	mvn r7, #0
	beq loc_0840
	ldr r3, [r4, #0x34]
	mov r7, r3
	mov r0, r5
	mov r2, #0x8e
	sub r2, r2, #0xeb00
	mov r1, #0xf
	bl sub_096c
	mov r1, r4
	mov r0, r5
	bl sub_0f68
	mov r0, r5
	ldr r1, [r4, #0x30]!
	bl sub_0b84
loc_0840:
	teq r8, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r2, r7
	mov r1, r6
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b loc_0c74

sub_085c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_0aa0
	movs r6, r0
	moveq r5, #0x79
	subeq r5, r5, #0x3f00
	beq loc_08bc
	ldr r0, [r6, #0x24]
	teq r0, #0
	moveq r5, #0x6a
	subeq r5, r5, #0x3f00
	beq loc_08a8
	bl sub_1206c
	mov r5, r0
	add ip, r0, #0x3e80
	cmn ip, #1
	beq loc_08bc
loc_08a8:
	mov r2, r5
	mov r1, r6
	mov r0, r4
	mov r3, #0
	bl sub_08c4
loc_08bc:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_08c4:
	and ip, r3, #0xff
	mvn r3, #0
	teq r1, #0
	moveq r2, #0x79
	subeq r2, r2, #0x3f00
	teq ip, #0
	movne r1, r2
	movne r2, r3
	bne loc_0ccc
	mov pc, lr
loc_08ec:
	teq r1, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x1c]
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r4
	mov r2, #0
	mov r1, #0xf
	ldr r3, [r5, #0x34]
	bl sub_096c
	teq r0, #0
	bne loc_0944
	mov r0, r4
	mov r1, #0
	ldr r2, [r5, #0x34]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_0ca0
loc_0944:
	sub sp, sp, #8
	mov r0, #1
	ldr r1, [r4, #0x10]
	strb r0, [r1]
	mov r0, sp
	bl GetGlobalTime
	ldr r0, [sp, #4]
	ldr r1, [r4, #0x10]!
	str r0, [r1, #4]!
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_096c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r7, r2
	mov r6, r3
	sub sp, sp, #0xa4
	mov r0, #0
	ldr r1, [r4, #0x1c]
	teq r1, #0
	beq loc_0a78
	ldr r0, [r4, #0x18]
	str r0, [sp, #0x24]
	mov r0, #1
	mov r1, #0

sub_09ac:
	add r2, sp, #0x24
	str r1, [r2, r0, lsl #2]
	add r0, r0, #1
	cmp r0, #0x20
	blt sub_09ac
	mov r8, #0

sub_09c4:
	add r1, r8, r8, lsl #1
	add r1, r1, r8, lsl #3
	ldr r0, [r4, #0x1c]
	add r1, r0, r1, lsl #3
	adds sb, r1, #0x18
	ldrne r1, [sb]
	movne r1, r1, asr #16
	teqne r1, #0
	ldrne r1, [sb, #0x54]
	teqne r1, #0
	beq loc_0a5c
	teq r5, #0x14
	moveq r2, r8
	moveq r1, #0
	bleq sub_148c
	mov r0, #0
	ldr r1, [sb, #0x54]!
	b loc_0a20
loc_0a0c:
	teq r2, r1
	beq loc_0a30
	add r0, r0, #1
	cmp r0, #0x20
	bge loc_0a30
loc_0a20:
	add r2, sp, #0x24
	ldr r2, [r2, r0, lsl #2]
	teq r2, #0
	bne loc_0a0c
loc_0a30:
	add r2, sp, #0x24
	ldr r2, [r2, r0, lsl #2]
	teq r2, r1
	beq loc_0a5c
	add r2, sp, #0x24
	str r1, [r2, r0, lsl #2]
	mov r0, r1
	stmia sp, {r5, r7}
	str r6, [sp, #8]
	mov r1, sp
	bl sub_11d50
loc_0a5c:
	add r8, r8, #1
	cmp r8, #0x20
	blt sub_09c4
	ldr r0, [sp, #0x28]
	movs r0, r0
	movne r0, #1
	and r0, r0, #0xff
loc_0a78:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_0a7c:
	ldr r0, [r0, #0x20]
	teq r0, #0
	beq loc_0a98
	ldr r0, [r0, #0x34]
	teq r0, r1
	moveq r0, #0
	moveq pc, lr
loc_0a98:
	mvn r0, #0
	mov pc, lr

sub_0aa0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_0a7c
	cmn r0, #1
	ldrne r0, [r4, #0x20]!
	moveq r0, #0
	ldmdb fp, {r4, fp, sp, pc}

sub_0ac4:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl sub_0aa0
	teq r0, #0
	ldrne r0, [r0]
	teqne r0, #0
	beq loc_0b00
	teq r0, #3
	moveq r0, #2
	ldmdbeq fp, {fp, sp, pc}
	teq r0, #7
	teqne r0, #8
	moveq r0, #1
	ldmdbeq fp, {fp, sp, pc}
loc_0b00:
	mov r0, #0
	ldmdb fp, {fp, sp, pc}

sub_0b08:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r6, [r0, #0x20]
	teq r6, #0
	bne loc_0b6c
	mov r0, #0x38
	bl __nw__FUi
	movs r6, r0
	addne r0, r6, #0x28
	blne sub_104c
	teq r6, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	str r6, [r4, #0x20]!
	mov r0, r6
	mov r2, #0x38
	mov r1, #0
	bl memset
	mov r0, #0
	str r0, [r6, #0x30]
	str r0, [r6]
loc_0b6c:
	ldr r0, [r6, #4]
	teq r0, #0
	streq r5, [r6, #0x34]!
	movne r0, #0x6a
	subne r0, r0, #0x3f00
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0b84:
	cmn r1, #1
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r5, [r0, #0x20]
	teq r5, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r5, #0x14]
	teq r0, #0
	blne __dl__FPv
	ldr r0, [r5, #0x18]
	teq r0, #0
	blne __dl__FPv
	ldr r0, [r5, #0x1c]
	teq r0, #0
	blne __dl__FPv
	add r0, r5, #0x28
	mov r1, #0
	bl sub_1088
	mov r0, r5
	bl __dl__FPv
	mov r0, #0
	str r0, [r4, #0x20]!
	ldmdb fp, {r4, r5, fp, sp, pc}

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x10]
	str r1, [r0, #0x14]
	str r1, [r0, #0x20]
	mov pc, lr

sub_0c00:
	ldr r1, [r0, #0x10]
	add r2, r1, #0x54
	ldr r1, [r2]
	mov r1, r1, lsr #16
	add r3, r1, #1
	strb r3, [r2, #1]
	mov r3, r3, asr #8
	strb r3, [r2]
	ldr r0, [r0, #0x10]
	ldr r2, [r0, #0x54]
	movs r2, r2, lsr #16
	bne loc_0c40
	mov r2, #0
	strb r2, [r0, #0x55]
	mov r2, #8
	strb r2, [r0, #0x54]
loc_0c40:
	mov r0, r1
	mov pc, lr
loc_0c48:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0xe
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x18]
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}
loc_0c74:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0x11
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x18]
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}

sub_0ca0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0xf
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x18]
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}
loc_0ccc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0x13
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x18]
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}

sub_0cf8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x16
	str r2, [sp, #-0x14]!
	sub sp, sp, #8
	stmdb sp!, {r0, r3}
	mov r0, r1
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}

sub_0d24:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x17
	str r2, [sp, #-0x14]!
	sub sp, sp, #8
	stmdb sp!, {r0, r3}
	mov r0, r1
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}

sub_0d50:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x18
	sub sp, sp, #0x1c
	stmdb sp!, {r0, r2}
	mov r0, r1
	mov r1, sp
	bl sub_11d50
	ldmdb fp, {fp, sp, pc}

sub_0d78:
	teq r1, #0
	teqne r1, #1
	beq loc_0d8c
	teq r1, #2
	beq loc_0db0
loc_0d8c:
	ldr r2, [r0, #0x10]
	ldr r3, [r2, #0x60]
	cmp r3, #0
	ldrgt r3, [r2, #0x60]!
	subgt r3, r3, #1
	bgt loc_0dbc
	mov r3, #0
	str r3, [r2, #0x60]!
	b loc_0dd4
loc_0db0:
	ldr r2, [r0, #0x10]
	ldr r3, [r2, #0x60]!
	add r3, r3, #1
loc_0dbc:
	str r3, [r2]
	ldr r2, [r0, #0x10]
	ldr r2, [r2, #0x60]
	teq r2, #0
	ldrne r1, lit_0dfc
	bne loc_0de0
loc_0dd4:
	teq r1, #0
	ldrne r1, lit_0e00
	ldreq r1, lit_0e04
loc_0de0:
	ldr r2, [r0, #0x10]
	ldr r3, [r2, #0x5c]
	teq r3, r1
	strne r1, [r2, #0x5c]!
	ldrne r0, [r0, #0x14]
	bne loc_11cd8
	mov pc, lr
lit_0dfc:
	.word 0x00059fd8
lit_0e00:
	.word 0x000e0f9c
lit_0e04:
	.word 0x008c9c18

sub_0e08:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	bl sub_0aa0
	teq r0, #0
	bne loc_0e4c
	mov r1, r5
	mov r0, r4
	bl sub_0b08
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r5
	mov r0, r4
	bl sub_0aa0
loc_0e4c:
	mov r2, r6
	mov r1, r0
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b loc_0ee8

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	teq r0, #0
	blne __dl__FPv
	ldr r0, [r4, #0x14]!
	teq r0, #0
	ldmdbne fp, {r4, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, fp, sp, pc}

sub_0e90:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	bl sub_0aa0
	teq r0, #0
	bne loc_0ed4
	mov r1, r5
	mov r0, r4
	bl sub_0b08
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r5
	mov r0, r4
	bl sub_0aa0
loc_0ed4:
	mov r2, r6
	mov r1, r0
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b loc_0f9c
loc_0ee8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r5, r1
	mov r1, r2
	teqne r1, #0
	moveq r6, #0x7a
	subeq r6, r6, #0x3f00
	beq loc_0f4c
	adr r0, str_0f54, #30
	bl NewByName__FPCcT1
	str r0, [r5, #0x24]
	teq r0, #0
	moveq r6, #0x6a
	subeq r6, r6, #0x3f00
	beq loc_0f4c
	add r3, r4, #0x18
	ldmia r3, {r2, r3}
	mov r1, r4
	bl sub_12048
	movs r6, r0
	movne r1, r5
	movne r0, r4
	blne sub_0f68
loc_0f4c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
str_0f54:
	.asciz "PStrDriverModule"
	.align 4

sub_0f68:
	teq r1, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r0, [r1, #0x24]
	teq r0, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	bl sub_12020
	mov r0, #0
	str r0, [r4, #0x24]!
	ldmdb fp, {r4, fp, sp, pc}
loc_0f9c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r5, r1
	mov r1, r2
	teqne r1, #0
	moveq r6, #0x7a
	subeq r6, r6, #0x3f00
	beq loc_1000
	adr r0, str_1008, #30
	bl NewByName__FPCcT1
	str r0, [r5, #0x20]
	teq r0, #0
	moveq r6, #0x6a
	subeq r6, r6, #0x3f00
	beq loc_1000
	add r3, r4, #0x18
	ldmia r3, {r2, r3}
	mov r1, r4
	bl sub_11f24
	movs r6, r0
	movne r1, r5
	movne r0, r4
	blne sub_1018
loc_1000:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
str_1008:
	.asciz "PStrLinkModule"
	.align 4

sub_1018:
	teq r1, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r0, [r1, #0x20]
	teq r0, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	bl sub_11efc
	mov r0, #0
	str r0, [r4, #0x20]!
	ldmdb fp, {r4, fp, sp, pc}

sub_104c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_1070
	mov r0, #8
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_1070:
	mov r1, #0x254
	str r1, [r0]
	mov r1, #0
	strb r1, [r0, #4]
	strb r1, [r0, #5]
	ldmdb fp, {fp, sp, pc}

sub_1088:
	tst r1, #1
	bne __dl__FPv
	mov pc, lr

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	str r1, [r0, #0x14]
	str r7, [r0, #0x1c]
	mov r6, #0xe9
	sub r6, r6, #0x2800
	str r7, [r0, #0x18]
	mov r0, #0x64
	bl __nw__FUi
	movs r5, r0
	beq loc_10e4
	add r0, r5, #8
	bl sub_00a0
	add r0, r5, #0x20
	bl sub_00a0
	add r0, r5, #0x38
	bl sub_00a0
loc_10e4:
	movs r0, r5
	str r5, [r4, #0x10]
	sub sp, sp, #8
	beq loc_11cc
	strb r7, [r0]
	mov r0, r4
	bl sub_11dc
	ldr r0, [r4, #0x10]
	add r0, r0, #8
	mov r1, #0x41
	bl sub_00e0
	ldr r0, [r4, #0x10]
	add r0, r0, #0x20
	mov r1, #0x42
	bl sub_00e0
	ldr r0, [r4, #0x10]
	add r0, r0, #0x38
	mov r1, #0x31
	bl sub_00e0
	mvn r1, #0
	ldr r0, [r4, #0x10]
	str r1, [r0, #0x50]!
	mov r1, #0
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x55]
	mov r1, #8
	strb r1, [r0, #0x54]
	bl sub_1294
	str r0, [r4, #0x1c]
	str r0, [r0]
	ldr r0, [r4, #0x1c]
	str r4, [r0, #0xc]!
	ldr r0, [r4, #0x1c]
	str r7, [r0, #0x10]!
	ldr r0, [r4, #0x1c]
	bl sub_2608
	mov r1, #0xf0
	ldr r0, [r4, #0x1c]
	bl sub_26c8
	ldr r1, [r4, #0x1c]
	str r0, [r1, #0x14]!
	ldr r0, [r4, #0x10]
	str r7, [r0, #0x5c]!
	mov r0, r4
	mov r1, #0
	bl sub_0d78
	ldr r0, [r4, #0x10]
	str r7, [r0, #0x60]!
	mov r0, sp
	bl GetGlobalTime
	ldr r1, [sp, #4]
	ldr r0, [r4, #0x10]
	str r1, [r0, #0x58]!
	ldr r0, [r4, #0x10]
	ldr r2, [r0, #0x5c]
	add r1, r1, r2
	mov r6, #0
	str r1, [r0, #0x58]!
loc_11cc:
	mov r1, r6
	ldr r0, [r4, #0x14]!
	bl sub_11c84
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_11dc:
	mov pc, lr

Method5:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r1, [r0, #0x20]
	bl sub_1018
	ldr r1, [r4, #0x20]
	mov r0, r4
	bl sub_0f68
	ldr r0, [r4, #0x1c]
	bl sub_12dc
	mov r0, #0
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x10]
	strb r0, [r1]
	mov r1, #0
	ldr r0, [r4, #0x14]!
	ldmdb fp, {r4, fp, sp, lr}
	b loc_11c90

Method6:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x18]
	teq r0, #0
	adrne r1, str_1268, #30
	adrne r0, str_1274, #30
	ldmdbne fp, {r4, fp, sp, lr}
	bne NewByName__FPCcT1
	adr r1, str_1284, #30
	adr r0, str_1274, #30
	bl NewByName__FPCcT1
	str r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, pc}
str_1268:
	.asciz "PInetToolCE"
str_1274:
	.asciz "PConnectionEnd"
	.align 4
str_1284:
	.asciz "PInetToolCCE"
	.align 4

sub_1294:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r1, lit_12d8
	mov r4, #0x31c
	add r4, r4, #0x800
	mov r0, r4
	bl NewNamedPtr
	movs r5, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r5
	mov r2, r4
	mov r1, #0
	bl memset
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_12d8:
	.word 0x494e4554			; 'INET'

sub_12dc:
	teq r0, #0
	bne DisposPtr
	mov pc, lr

sub_12e8:
	ldr r0, [r0, #0x14]
	b loc_1ed4

sub_12f0:
	ldr r0, [r0, #0x14]
	b loc_1f88

sub_12f8:
	ldr r0, [r0, #0x14]
	b loc_2114

sub_1300:
	ldr r0, [r0, #0x14]
	b loc_1814

sub_1308:
	add ip, r1, r1, lsl #1
	add r1, ip, r1, lsl #3
	add r0, r0, r1, lsl #3
	add r1, r0, #0x18
	ldr r0, [r1, #2]
	mov r0, r0, asr #16
	tst r0, #1
	moveq pc, lr
	orr r0, r0, #2
	strb r0, [r1, #3]
	mov r0, r0, asr #8
	strb r0, [r1, #2]
	mov pc, lr

sub_133c:
	add ip, r1, r1, lsl #1
	add r1, ip, r1, lsl #3
	add r0, r0, r1, lsl #3
	add r1, r0, #0x18
	ldr r0, [r1, #2]
	mov r0, r0, asr #16
	tst r0, #0x10
	moveq pc, lr
	orr r0, r0, #0x20
	strb r0, [r1, #3]
	mov r0, r0, asr #8
	strb r0, [r1, #2]
	mov pc, lr

sub_1370:
	add ip, r1, r1, lsl #1
	add r1, ip, r1, lsl #3
	add r0, r0, r1, lsl #3
	add r0, r0, #0x18
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	orr r1, r1, #0x8000
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	mov pc, lr

sub_139c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r7, [fp, #4]
	stmdb sp!, {r3}
	ldr r0, [r0, #0x14]
	mov r3, r2
	mov r2, r1
	mov r1, #0
	bl sub_1d38
	add sp, sp, #4
	movs r5, r0
	bmi loc_1478
	add r0, r5, r5, lsl #1
	add r0, r0, r5, lsl #3
	add r0, r4, r0, lsl #3
	add r0, r0, #0x18
	mov r6, r0
	mov r2, #0x58
	mov r1, #0
	bl memset
	mov r0, #1
	strb r0, [r6, #1]
	mov r0, #0
	strb r0, [r6]
	str r7, [r6, #0x54]!
	ldr r0, lit_1480
	bl sub_11bfc
	mov r3, r0
	stmdb sp!, {r3}
	ldr r6, lit_1484
	mov r0, r6
	bl sub_11bfc
	mov r3, r0
	stmdb sp!, {r3}
	mov r0, r6
	bl sub_11bfc
	mov r3, r0
	stmdb sp!, {r3}
	ldr r0, lit_1488
	bl sub_11bfc
	mov r3, r0
	ldr r0, [r4, #0x14]
	mov r2, r4
	mov r1, r5
	bl sub_1a60
	add sp, sp, #0xc
	mov r3, #0
	stmdb sp!, {r3}
	mov r1, r5
	mov r2, #0
	ldr r0, [r4, #0x14]!
	bl sub_19d4
	add sp, sp, #4
loc_1478:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_1480:
	.rword sub_1370				; relocated
lit_1484:
	.rword sub_133c				; relocated
lit_1488:
	.rword sub_1308				; relocated

sub_148c:
	cmp r2, #0x20
	bge loc_149c
	cmp r2, #0
	bge loc_14a4
loc_149c:
	mvn r0, #0
	mov pc, lr
loc_14a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	add r0, r2, r2, lsl #1
	add r0, r0, r2, lsl #3
	add r0, r5, r0, lsl #3
	add r6, r0, #0x18
	ldr r0, [r6]
	movs r0, r0, asr #16
	mvneq r0, #1
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r1, r4
	ldr r0, [r5, #0x14]
	bl sub_1e30
	mov r7, #0
	ldr r0, [r6, #0x40]
	teq r0, #0
	beq loc_14fc
	bl free
	str r7, [r6, #0x40]
loc_14fc:
	ldr r0, [r6, #0x18]
	teq r0, #0
	beq loc_1510
	bl free
	str r7, [r6, #0x18]
loc_1510:
	strb r7, [r6, #1]
	strb r7, [r6]
	mov r3, #0
	mov r2, #0
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	ldr r0, [r5, #0x14]!
	bl sub_1a60
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_153c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r8, r0
	mov r4, r2
	mov r5, r3
	cmp r1, #0x20
	ldr sb, [fp, #4]
	mvnge r7, #0
	bge loc_1690
	add r0, r1, r1, lsl #1
	add r0, r0, r1, lsl #3
	add r0, r8, r0, lsl #3
	add r6, r0, #0x18
	ldr r0, [r6]
	movs r0, r0, asr #16
	mvneq r7, #1
	beq loc_1690
	ldr r0, [r6, #2]
	mov r0, r0, lsl #15
	movs r0, r0, lsr #31
	mvnne r7, #2
	bne loc_1690
	mov r3, sb
	stmdb sp!, {r3}
	mov r3, r5
	mov r2, r4
	ldr r0, [r8, #0x14]
	bl sub_21c8
	add sp, sp, #4
	mov r7, r0
	cmn r0, #2
	cmnne r0, #1
	beq loc_15d4
	teq r0, #0
	moveq r0, r8
	bleq sub_8674
	b loc_1690
loc_15d4:
	ldr r8, [r6, #0x18]
	ldr sl, [r6, #0x28]
	add r0, r6, #4
	mov r2, #0x28
	mov r1, #0
	bl memset
	teq r4, #0
	str r8, [r6, #0x18]
	str sl, [r6, #0x28]
	beq loc_1664
	ldr r0, [r4, #8]
	teq r0, #0
	beq loc_1614
	ldr r0, [r4, #4]
	cmp r0, #0x54
	bls sub_161c
loc_1614:
	mvn r7, #6
	b loc_1690

sub_161c:
	add r1, r6, #0xc
	ldmia r4, {r0, r3, ip}
	stmia r1, {r0, r3, ip}
	teq r8, #0
	bne loc_164c
	ldr r1, lit_1698
	mov r0, #0x54
	bl NewNamedPtr
	teq r0, #0
	mvneq r7, #3
	beq loc_1690
	str r0, [r6, #0x18]
loc_164c:
	ldr r0, [r6, #0x18]
	str r0, [r6, #0x14]
	ldr r2, [r4, #4]!
	ldr r1, [r4, #4]
	ldr r0, [r6, #0x18]
	bl memcpy
loc_1664:
	teq r5, #0
	addne r0, r6, #0x1c
	ldmiane r5, {r3, r5, ip}
	stmiane r0, {r3, r5, ip}
	str sb, [r6, #8]
	ldr r0, [r6, #2]
	mov r0, r0, lsr #16
	orr r0, r0, #1
	strb r0, [r6, #3]
	mov r0, r0, asr #8
	strb r0, [r6, #2]
loc_1690:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_1698:
	.word 0x474c5545			; 'GLUE'

sub_169c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r6, r1
	mov r4, r2
	mov r5, r3
	ldr sb, [fp, #4]
	sub sp, sp, #4
	cmp r1, #0x20
	mvnge r6, #0
	bge loc_1804
	add r0, r6, r6, lsl #1
	add r0, r0, r6, lsl #3
	add r0, r7, r0, lsl #3
	add r8, r0, #0x18
	ldr r0, [r8]
	movs r0, r0, asr #16
	mvneq r6, #1
	beq loc_1804
	ldr r0, [r8, #2]
	mov r0, r0, lsr #16
	tst r0, #0x10
	bne loc_17c4
	mov r0, r7
	bl sub_8674
	mov r0, #0
	str r0, [sp]
	mov r3, sp
	stmdb sp!, {r3}
	mov r3, r5
	mov r2, r4
	mov r1, r6
	ldr r0, [r7, #0x14]!
	bl sub_23f4
	add sp, sp, #4
	mov r6, r0
	cmn r0, #6
	cmnne r0, #1
	beq loc_1754
	teq r0, #0
	bne loc_1804
	teq sb, #0
	ldrne r0, [sp]
	strne r0, [sb]
	b loc_1804
loc_1754:
	ldr r7, [r8, #0x40]
	ldr sb, [r8, #0x50]
	add r0, r8, #0x2c
	mov r2, #0x28
	mov r1, #0
	bl memset
	teq r4, #0
	str r7, [r8, #0x40]
	str sb, [r8, #0x50]
	beq loc_17dc
	ldr r0, [r4, #8]
	teq r0, #0
	beq loc_1794
	ldr r0, [r4]
	cmp r0, #0x54
	bls sub_179c
loc_1794:
	mvn r6, #6
	b loc_1804

sub_179c:
	add r0, r8, #0x34
	ldmia r4, {r3, r4, ip}
	stmia r0, {r3, r4, ip}
	teq r7, #0
	bne loc_17d4
	ldr r1, lit_17cc
	mov r0, #0x54
	bl NewNamedPtr
	teq r0, #0
	bne loc_17d0
loc_17c4:
	mvn r6, #3
	b loc_1804
lit_17cc:
	.word 0x474c5545			; 'GLUE'
loc_17d0:
	str r0, [r8, #0x40]
loc_17d4:
	ldr r0, [r8, #0x40]
	str r0, [r8, #0x3c]
loc_17dc:
	teq r5, #0
	addne r0, r8, #0x44
	ldmiane r5, {r3, r5, ip}
	stmiane r0, {r3, r5, ip}
	ldr r0, [r8, #2]
	mov r0, r0, lsr #16
	orr r0, r0, #0x10
	strb r0, [r8, #3]
	mov r0, r0, asr #8
	strb r0, [r8, #2]
loc_1804:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_180c:
	ldr r0, [r0, #0x14]
	b loc_2034
loc_1814:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	mov r6, r0
	mov r0, #0
	mov sb, #0
	str r0, [r6, #0x394]
	str r0, [r6, #0x398]
loc_183c:
	mov r7, #0
	mov r8, #0
	cmp r5, #0
	ble sub_197c

sub_184c:
	mov r0, #0
	strb r0, [r4, #7]
	strb r0, [r4, #6]
	ldr r0, [r4]
	cmp r0, #0
	blt sub_1884
	cmp r0, #0x20
	bge sub_1884
	rsb r0, r0, r0, lsl #3
	add r0, r6, r0, lsl #2
	add r1, r0, #0x14
	ldr r0, [r1, #4]
	teq r0, #0
	bne loc_188c

sub_1884:
	mov r0, #0x20
	b loc_18ac
loc_188c:
	ldrb r2, [r1, #2]
	teq r2, #0
	bne loc_18a8
	ldr r2, [r0, #0x20]
	mov r2, r2, lsr #16
	teq r2, #1
	bne loc_18b4
loc_18a8:
	mov r0, #8
loc_18ac:
	strb r0, [r4, #7]
	b loc_1940
loc_18b4:
	ldr r0, [r0, #8]
	teq r0, #0
	beq loc_18e8
	ldr r0, [r0, #0x18]
	ldrb r0, [r0, #9]
	cmp r0, #0x80
	ldr r0, [r4, #6]
	mov r0, r0, lsr #16
	orrle r0, r0, #1
	orrgt r0, r0, #2
	strb r0, [r4, #7]
	mov r0, r0, asr #8
	strb r0, [r4, #6]
loc_18e8:
	ldr r0, [r1, #4]!
	ldr r0, [r0, #0x30]
	bl sub_7f30
	teq r0, #1
	bne loc_1914
	ldr r0, [r4, #6]
	mov r0, r0, lsr #16
	orr r0, r0, #4
	strb r0, [r4, #7]
	mov r0, r0, asr #8
	strb r0, [r4, #6]
loc_1914:
	ldr r1, [r4, #6]
	mov r1, r1, lsr #16
	ldr r0, [r4, #4]
	mov r0, r0, lsr #16
	and r0, r1, r0
	strb r0, [r4, #7]
	mov r0, r0, asr #8
	strb r0, [r4, #6]
	ldr r0, [r4, #6]
	movs r0, r0, lsr #16
	beq loc_1944
loc_1940:
	mov r7, #1
loc_1944:
	add r8, r8, #1
	add r4, r4, #8
	cmp r8, r5
	blt sub_184c
	teq r7, #1
	bne sub_197c
	ldr r1, [r6, #0x398]
	teq r1, #0
	beq loc_1990
	mov r0, r6
	bl sub_8a04
	mov r0, #0
	str r0, [r6, #0x398]!
	b loc_1990

sub_197c:
	ldr r3, [fp, #-0x2c]
	teq r3, #0
	ldrne r0, [r6, #0x394]
	teqne r0, #1
	bne loc_1998
loc_1990:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_1998:
	teq sb, #0
	bne loc_19b4
	bl sub_76b0
	ldr r3, [fp, #-0x2c]
	add sl, r0, r3, asr #3
	mov sb, #1
	b loc_19c8
loc_19b4:
	bl sub_76b0
	cmp r0, sl
	movls r0, #0
	movhi r0, #1
	str r0, [r6, #0x394]
loc_19c8:
	mov r0, r6
	bl sub_8674
	b loc_183c

sub_19d4:
	cmp r1, #0
	blt sub_19e4
	cmp r1, #0x20
	blt sub_19ec

sub_19e4:
	mvn r0, #9
	mov pc, lr

sub_19ec:
	stmdb sp!, {lr}
	ldr ip, [sp, #4]
	rsb r1, r1, r1, lsl #3
	add r0, r0, r1, lsl #2
	add r1, r0, #0x14
	ldr lr, [r1, #4]
	teq lr, #0
	mvneq r0, #0xa
	ldmiaeq sp!, {pc}
	ldrb r0, [r1, #2]
	teq r0, #0
	ldmiane sp!, {pc}
	ldr r0, [lr, #0x20]
	mov r0, r0, lsr #16
	teq r0, #1
	mvneq r0, #0xd
	ldmiaeq sp!, {pc}
	mov r0, #0
	teq r2, #0
	moveq r0, #1
	teq r3, #0
	andeq r0, r0, #0xff
	orreq r0, r0, #2
	teq ip, #0
	andeq r0, r0, #0xff
	orreq r0, r0, #4
	strb r0, [r1, #3]
	mov r0, #0
	ldmia sp!, {pc}

sub_1a60:
	cmp r1, #0
	blt sub_1a70
	cmp r1, #0x20
	blt sub_1a78

sub_1a70:
	mvn r0, #9
	mov pc, lr

sub_1a78:
	stmdb sp!, {r4, r5, lr}
	ldr ip, [sp, #0x14]
	rsb r1, r1, r1, lsl #3
	add r0, r0, r1, lsl #2
	add r1, r0, #0x14
	add lr, sp, #0xc
	ldmia lr, {r4, lr}
	ldr r5, [r1, #4]
	teq r5, #0
	mvneq r0, #0xa
	ldmiaeq sp!, {r4, r5, pc}
	ldrb r0, [r1, #2]
	teq r0, #0
	ldmiane sp!, {r4, r5, pc}
	ldr r0, [r5, #0x20]
	mov r0, r0, lsr #16
	teq r0, #1
	mvneq r0, #0xd
	ldmiaeq sp!, {r4, r5, pc}
	mov r0, #0
	add r1, r1, #4
	stmib r1!, {r2, r3, r4, lr}
	str ip, [r1, #4]
	ldmia sp!, {r4, r5, pc}

sub_1ad8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r0
	ldr r1, lit_1b24
	mov r0, #0x3a8
	bl sub_7bf4
	teq r0, #0
	moveq r0, #0
	ldmdbeq fp, {fp, sp, pc}
	mov r2, #0
	add r1, r0, #0x14
	mvn r3, #0

sub_1b0c:
	strb r3, [r1, #1]
	strb r3, [r1], #0x1c
	add r2, r2, #1
	cmp r2, #0x20
	blt sub_1b0c
	ldmdb fp, {fp, sp, pc}
lit_1b24:
	.word 0x41504920			; 'API '

sub_1b28:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_8004
	movs r5, r0
	mov r6, #0
	beq loc_1ba0
loc_1b48:
	ldr r0, [r5, #0x18]
	ldrb r0, [r0, #9]
	cmp r0, #0x80
	bgt loc_1b7c
	ldr r0, [r4, #0x10]
	bl sub_7f30
	teq r0, #0
	bne loc_1b7c
	mov r2, r5
	ldr r1, [r4, #8]
	mov r0, r4
	bl sub_8030
	b loc_1bd8
loc_1b7c:
	mov r1, r5
	ldr r0, [r4, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, r4
	bl sub_8004
	movs r5, r0
	bne loc_1b48
loc_1ba0:
	ldr r5, [r4, #0x1c]
	teq r5, #0
	ldrne r0, [r5, #0xc]
	teqne r0, #0
	beq loc_1bd8
	ldr r0, [r4, #0x10]!
	bl sub_7f30
	teq r0, #1
	bne loc_1bd8
	ldr r0, [r5, #8]
	ldr r1, [r5]
	mov r1, r1, asr #16
	mov lr, pc
	ldr pc, [r5, #0xc]
loc_1bd8:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1be0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r7, [r0, #4]
	bl sub_93f0
	movs r4, r0
	mov r8, #0
	beq loc_1d18
	ldr r6, [r5, #0x1c]
	teq r6, #0
	beq loc_1c20
	ldrb r0, [r6, #2]
	teq r0, #0
	beq loc_1c30
loc_1c20:
	mov r1, r4
	mov r0, r7
	bl sub_7ed0
	b loc_1d18
loc_1c30:
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0x86
	beq loc_1c70
	teq r0, #0x8a
	bne loc_1ccc
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	strb r0, [r6, #2]
	mov r1, r4
	mov r0, r7
	bl sub_7ed0
	ldr r2, [r6, #0x18]
	teq r2, #0
	beq loc_1d18
	b loc_1d04
loc_1c70:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	movne r0, r5
	movne r1, #0
	blne sub_7fa0
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #2
	beq loc_1c20
	mov r1, #0
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r4, #0xc]
	ldrb r1, [r0]
	bic r1, r1, #1
	strb r1, [r0]
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	ldr r2, [r2]
	b loc_1d10
loc_1ccc:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	ldr r0, [r4, #0x18]!
	ldrb r0, [r0, #9]
	cmp r0, #0x80
	bgt loc_1cf8
	ldr r2, [r6, #0x14]
	teq r2, #0
	beq loc_1d18
	b loc_1d04
loc_1cf8:
	ldr r2, [r6, #0x10]
	teq r2, #0
	beq loc_1d18
loc_1d04:
	ldr r0, [r6, #8]
	ldr r1, [r6]
	mov r1, r1, asr #16
loc_1d10:
	mov lr, pc
	mov pc, r2
loc_1d18:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_1d20:
	add r0, r0, #0x39c
	stmia r0, {r1, r2}
	sub r0, r0, #0x39c
	mov r1, #1
	str r1, [r0, #0x3a4]!
	mov pc, lr

sub_1d38:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r2
	mov r4, r3
	mov r6, r0
	add r7, r0, #0x14
	mov r8, #0
	ldr sb, [fp, #4]

sub_1d5c:
	ldr r0, [r7]
	mov r0, r0, asr #16
	cmn r0, #1
	beq loc_1d7c
	add r8, r8, #1
	add r7, r7, #0x1c
	cmp r8, #0x20
	blt sub_1d5c
loc_1d7c:
	teq r8, #0x20
	mvneq r0, #8
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov r0, #0
	str r0, [r6, #0x3a4]
	ldr r0, lit_1e2c
	bl sub_11bfc
	mov r3, r0
	mov r2, r6
	mov r1, sb
	stmdb sp!, {r1, r2, r3}
	mov r3, r4
	mov r2, r5
	mov r0, r6
	mov r1, #0xf0
	bl sub_8d30
	add sp, sp, #0xc
	teq r0, #1
	mvnne r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r6, #0x3a4]
	teq r0, #0
	bne loc_1dec
loc_1dd8:
	mov r0, r6
	bl sub_8674
	ldr r0, [r6, #0x3a4]
	teq r0, #0
	beq loc_1dd8
loc_1dec:
	mov r0, r7
	mov r2, #0x1c
	mov r1, #0
	bl memset
	strb r8, [r7, #1]
	mov r0, r8, asr #8
	strb r0, [r7]
	ldr r0, [r6, #0x39c]
	str r0, [r7, #4]
	ldr r0, [r6, #0x39c]
	str r7, [r0, #0x1c]!
	ldr r0, [r6, #0x39c]!
	ldr r0, [r0, #0x30]
	str r7, [r0, #0x1c]!
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_1e2c:
	.rword sub_1d20				; relocated

sub_1e30:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	cmp r1, #0
	ldmdblt fp, {r4, r5, r6, r7, fp, sp, pc}
	cmp r1, #0x20
	ldmdbge fp, {r4, r5, r6, r7, fp, sp, pc}
	rsb r0, r1, r1, lsl #3
	add r0, r4, r0, lsl #2
	add r5, r0, #0x14
	mvn r0, #0
	strb r0, [r5, #1]
	strb r0, [r5]
	ldr r6, [r5, #4]
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r7, #0
	str r7, [r6, #0x1c]
	ldr r0, [r6, #0x30]
	str r7, [r0, #0x1c]!
	str r7, [r4, #0x3a4]
	ldr r0, lit_1ed0
	bl sub_11bfc
	mov r2, r0
	mov r1, r4
	mov r0, r6
	bl sub_8eb0
	teq r0, #1
	bne loc_1ec8
	ldr r0, [r4, #0x3a4]
	teq r0, #0
	bne loc_1ec8
loc_1eb4:
	mov r0, r4
	bl sub_8674
	ldr r0, [r4, #0x3a4]
	teq r0, #0
	beq loc_1eb4
loc_1ec8:
	str r7, [r5, #4]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_1ed0:
	.rword sub_1d20				; relocated
loc_1ed4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r2
	mov r5, r0
	cmp r1, #0
	blt sub_1ef8
	cmp r1, #0x20
	blt sub_1f00

sub_1ef8:
	mvn r0, #9
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1f00:
	rsb r0, r1, r1, lsl #3
	add r0, r5, r0, lsl #2
	add r6, r0, #0x14
	ldr r0, [r6, #4]
	teq r0, #0
	mvneq r0, #0xa
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldrb r0, [r6, #2]
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r0, #0
	str r0, [r5, #0x3a4]
	ldr r0, lit_1f84
	bl sub_11bfc
	mov r3, r0
	mov r2, r5
	mov r1, r4
	ldr r0, [r6, #4]!
	bl sub_8f90
	teq r0, #1
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r5, #0x3a4]
	teq r0, #0
	bne loc_1f74
loc_1f60:
	mov r0, r5
	bl sub_8674
	ldr r0, [r5, #0x3a4]
	teq r0, #0
	beq loc_1f60
loc_1f74:
	ldr r0, [r5, #0x3a0]!
	teq r0, #1
	moveq r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_1f84:
	.rword sub_1d20				; relocated
loc_1f88:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	cmp r1, #0
	blt sub_1fa8
	cmp r1, #0x20
	blt sub_1fb0

sub_1fa8:
	mvn r0, #9
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1fb0:
	rsb r0, r1, r1, lsl #3
	add r0, r4, r0, lsl #2
	add r5, r0, #0x14
	ldr r0, [r5, #4]
	teq r0, #0
	mvneq r0, #0xa
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldrb r0, [r5, #2]
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	mov r0, #0
	str r0, [r4, #0x3a4]
	ldr r0, lit_2030
	bl sub_11bfc
	mov r2, r0
	mov r1, r4
	ldr r0, [r5, #4]!
	bl sub_907c
	teq r0, #1
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x3a4]
	teq r0, #0
	bne loc_2020
loc_200c:
	mov r0, r4
	bl sub_8674
	ldr r0, [r4, #0x3a4]
	teq r0, #0
	beq loc_200c
loc_2020:
	ldr r0, [r4, #0x3a0]!
	teq r0, #1
	moveq r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2030:
	.rword sub_1d20				; relocated
loc_2034:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	cmp r1, #0
	blt sub_2064
	cmp r1, #0x20
	bge sub_2064
	cmp r2, #0
	blt sub_2064
	cmp r2, #0x20
	blt sub_206c

sub_2064:
	mvn r0, #9
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_206c:
	rsb r0, r1, r1, lsl #3
	add r0, r4, r0, lsl #2
	add r6, r0, #0x14
	rsb r0, r2, r2, lsl #3
	add r0, r4, r0, lsl #2
	add r5, r0, #0x14
	ldr r0, [r6, #4]
	teq r0, #0
	ldrne r0, [r5, #4]
	teqne r0, #0
	mvneq r0, #0xa
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	ldrb r0, [r5, #2]
	teq r0, #0
	ldrbeq r0, [r6, #2]
	teqeq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r7, #0
	str r7, [r4, #0x3a4]
	ldr r0, lit_2110
	bl sub_11bfc
	mov r3, r0
	ldr r1, [r5, #4]
	mov r2, r4
	ldr r0, [r6, #4]!
	bl sub_9124
	teq r0, #1
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r0, [r4, #0x3a4]
	teq r0, #0
	bne loc_20fc
loc_20e8:
	mov r0, r4
	bl sub_8674
	ldr r0, [r4, #0x3a4]
	teq r0, #0
	beq loc_20e8
loc_20fc:
	ldr r0, [r4, #0x3a0]
	cmp r0, #0
	strge r7, [r5, #4]!
	ldr r0, [r4, #0x3a0]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_2110:
	.rword sub_1d20				; relocated
loc_2114:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r2
	mov r5, r0
	cmp r1, #0
	blt sub_2138
	cmp r1, #0x20
	blt sub_2140

sub_2138:
	mvn r0, #9
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2140:
	rsb r0, r1, r1, lsl #3
	add r0, r5, r0, lsl #2
	add r6, r0, #0x14
	ldr r0, [r6, #4]
	teq r0, #0
	mvneq r0, #0xa
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldrb r0, [r6, #2]
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r0, #0
	str r0, [r5, #0x3a4]
	ldr r0, lit_21c4
	bl sub_11bfc
	mov r3, r0
	mov r2, r5
	mov r1, r4
	ldr r0, [r6, #4]!
	bl sub_92a8
	teq r0, #1
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r5, #0x3a4]
	teq r0, #0
	bne loc_21b4
loc_21a0:
	mov r0, r5
	bl sub_8674
	ldr r0, [r5, #0x3a4]
	teq r0, #0
	beq loc_21a0
loc_21b4:
	ldr r0, [r5, #0x3a0]!
	teq r0, #1
	moveq r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_21c4:
	.rword sub_1d20				; relocated

sub_21c8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r2
	mov r5, r3
	mov r8, r0
	cmp r1, #0
	ldr sb, [fp, #4]
	blt sub_21f4
	cmp r1, #0x20
	blt sub_21fc

sub_21f4:
	mvn r0, #9
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_21fc:
	rsb r0, r1, r1, lsl #3
	add r0, r8, r0, lsl #2
	add r7, r0, #0x14
	ldr r1, [r7, #4]
	teq r1, #0
	mvneq r0, #0xa
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldrb r0, [r7, #2]
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	teq r0, #1
	mvneq r0, #0xd
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	teq sb, #0
	beq loc_225c
	mvn r0, #2
	teq sb, #1
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	teq r4, #0
	ldrne r2, [r4, #4]
	teqne r2, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_225c:
	ldrb r0, [r7, #3]
	tst r0, #1
	beq loc_2284
	teq sb, #0
	bne loc_2284
	ldr r0, [r1, #0x30]!
	bl sub_7f30
	teq r0, #0
	mvneq r0, #1
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_2284:
	mov r6, #0
	mvn sl, #0
	teq r4, #0
	ldrne r3, [r4, #4]
	teqne r3, #0
	beq loc_22c8
	mov r1, r7
	mov r0, r8
	ldr r2, [r4, #8]!
	bl sub_23a4
	movs r6, r0
	beq loc_2304
	teq sb, #0
	movne r0, #0x83
	moveq r0, #1
	ldr r1, [r6, #0x18]
	strb r0, [r1, #9]
loc_22c8:
	mov r0, #0
	teq r5, #0
	ldrne r3, [r5, #4]
	teqne r3, #0
	beq loc_230c
	mov r1, r7
	mov r0, r8
	ldr r2, [r5, #8]!
	bl sub_23a4
	teq r0, #0
	bne loc_230c
	teq r6, #0
	movne r1, r6
	movne r0, r8
	blne sub_7ed0
loc_2304:
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_230c:
	cmp r6, #0
	bne loc_2324
	teq r0, #0
	moveq r0, #1
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	b loc_2328
loc_2324:
	bne loc_2330
loc_2328:
	mov r6, r0
	b loc_2348
loc_2330:
	teq r0, #0
	beq loc_2348
	mov r2, r0
	mov r1, r6
	mov r0, r8
	bl sub_7f00
loc_2348:
	teq sb, #0
	bne loc_2364
	ldr r0, [r7, #4]
	ldr r0, [r0, #0x30]
	bl sub_7f30
	teq r0, #1
	bne loc_237c
loc_2364:
	ldr r0, [r7, #4]!
	ldr r0, [r0, #0x30]
	mov r1, r6
	bl sub_81a0
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_237c:
	mov r0, r8
	bl sub_8674
	ldrb r0, [r7, #2]
	teq r0, #0
	beq loc_2348
	mov r1, r6
	mov r0, r8
	bl sub_7ed0
	ldrb r0, [r7, #2]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_23a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r7, r3
loc_23c0:
	mov r2, r7
	mov r1, r5
	mov r0, r4
	bl sub_76d8
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldrb r0, [r6, #3]
	tst r0, #2
	movne r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r0, r4
	bl sub_8674
	b loc_23c0

sub_23f4:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, r2
	mov r4, r3
	sub sp, sp, #0xc
	mov sl, r0
	cmp r1, #0
	blt sub_2424
	cmp r1, #0x20
	blt sub_242c

sub_2424:
	mvn r0, #9
	b loc_25fc

sub_242c:
	rsb r0, r1, r1, lsl #3
	add r0, sl, r0, lsl #2
	add r8, r0, #0x14
	ldr r1, [r8, #4]
	teq r1, #0
	mvneq r0, #0xa
	beq loc_25fc
	ldrb r0, [r8, #2]
	teq r0, #0
	bne loc_25fc
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	teq r0, #1
	mvneq r0, #0xd
	beq loc_25fc
loc_2468:
	ldr r0, [r8, #4]
	bl sub_8004
	movs r6, r0
	bne loc_24a4
	ldrb r0, [r8, #3]
	tst r0, #4
	mvnne r0, #5
	bne loc_25fc
	mov r0, sl
	bl sub_8674
	ldrb r0, [r8, #2]
	teq r0, #0
	beq loc_2468
	ldrb r0, [r8, #2]
	b loc_25fc
loc_24a4:
	mov r0, #0
	teq r5, #0
	strne r0, [r5, #4]
	ldrne r2, [r5, #8]
	strne r2, [sp, #4]
	teq r4, #0
	strne r0, [r4, #4]
	ldrne r2, [r4, #8]
	strne r2, [sp]
	mov r1, #0
	ldr r0, [fp, #0x14]
	str r1, [r0]
	mov r7, #0
	str r6, [sp, #8]
loc_24dc:
	ldr r0, [r6, #0x10]
	ldr r1, [r6, #0xc]
	sub sb, r0, r1
	ldr r0, [r6, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0
	beq loc_2568
	teq r0, #1
	teqne r0, #0x83
	mvnne r7, #7
	bne loc_25d4
	teq r5, #0
	mvneq r7, #3
	beq loc_25d4
	ldr r0, [r5, #4]
	add r0, r0, sb
	str r0, [r5, #4]
	ldr r1, [r5]
	cmp r0, r1
	bgt loc_258c
	mov r3, sb
	mov r1, r6
	mov r0, sl
	ldr r2, [sp, #4]
	bl sub_7938
	ldr r2, [sp, #4]
	add r2, r2, sb
	str r2, [sp, #4]
	ldr r0, [r6, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0x83
	moveq r1, #1
	ldreq r0, [fp, #0x14]
	streq r1, [r0]
	b loc_25b4
loc_2568:
	teq r4, #0
	mvneq r7, #4
	beq loc_25d4
	ldr r0, [r4, #4]
	add r0, r0, sb
	str r0, [r4, #4]
	ldr r1, [r4]
	cmp r0, r1
	ble sub_2594
loc_258c:
	mvn r7, #6
	b loc_25d4

sub_2594:
	mov r3, sb
	mov r1, r6
	mov r0, sl
	ldr r2, [sp]
	bl sub_7938
	ldr r2, [sp]
	add r2, r2, sb
	str r2, [sp]
loc_25b4:
	teq r7, #0
	bne loc_25cc
	ldr r6, [r6, #8]
	teq r6, #0
	bne loc_24dc
	b loc_25ec
loc_25cc:
	teq r7, #0
	beq loc_25ec
loc_25d4:
	ldr r0, [r8, #4]!
	ldr r1, [r0, #8]
	ldr r2, [sp, #8]
	bl sub_8030
	mov r0, r7
	b loc_25fc
loc_25ec:
	mov r0, sl
	ldr r1, [sp, #8]
	bl sub_7ed0
	mov r0, #0
loc_25fc:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
str_2600:
	.asciz "pseapi"
	.align 4

sub_2608:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r2, r0
	ldr r1, lit_269c
	mov r0, #0x144
	bl sub_7bf4
	movs r4, r0
	mvn sl, #0
	beq loc_2694
	mov sb, #1
	str sb, [r4, #0x140]
	str r4, [r4, #4]
	str r4, [r5, #4]
	ldr r0, lit_26a0
	str r0, [r4, #8]
	str r0, [r5, #8]!
	mov r0, r4
	mov r1, #0
	bl sub_8608
	mov r5, #0
	ldr r6, lit_26a4
	ldr r0, [r6]
	teq r0, #0
	beq loc_26c0
	ldr r8, lit_26a8
	ldr r7, lit_26ac
loc_2678:
	ldr r3, [r8, r5, lsl #2]
	ldr r2, [r7, r5, lsl #2]
	ldr r1, [r6, r5, lsl #2]
	mov r0, r4
	bl sub_8778
	teq r0, #1
	beq loc_26b0
loc_2694:
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_269c:
	.word 0x53545220			; 'STR '
lit_26a0:
	.rword data_116b4			; relocated
lit_26a4:
	.rword data_11678			; relocated
lit_26a8:
	.rword data_116a0			; relocated
lit_26ac:
	.rword data_1168c			; relocated
loc_26b0:
	add r5, r5, #1
	ldr r0, [r6, r5, lsl #2]
	teq r0, #0
	bne loc_2678
loc_26c0:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_26c8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [r0, #4]
	bl sub_88b8
	teq r0, #0
	moveq r0, #0
	ldrne r0, [r0, #0x10]
	ldmdb fp, {fp, sp, pc}

sub_26ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	ldr r1, [r2, #0xc]
	mov r7, r1
	mvn r3, #0x16
	ldr r2, [r1, #4]
	teq r2, #4
	bne loc_2784
	ldr r2, [r7, #0x14]
	teq r2, #1
	mvnne r0, #0x17
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r2, r1
	ldr r1, [r1, #8]
	ldr r2, [r2, r1]
	str r2, [r4, #0x18]
	ldr ip, [r5, #0xc]
	ldr r1, [r7, #0x18]
	ldrb r1, [ip, r1]
	strb r1, [r4, #0x13]
	mov r1, r1, asr #8
	strb r1, [r4, #0x12]
	mov r1, #0

sub_2754:
	add ip, r0, r1, lsl #2
	ldr r6, [ip, #0x40]!
	teq r6, #0
	beq loc_2770
	ldr ip, [r6, #0x28]
	teq ip, r2
	beq loc_277c
loc_2770:
	add r1, r1, #1
	cmp r1, #4
	blo sub_2754
loc_277c:
	teq r1, #4
	bne loc_278c
loc_2784:
	mov r0, r3
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_278c:
	ldr r1, [r6, #0x28]
	teq r1, #0
	bne loc_27ac
	ldr r1, [r4, #0x12]
	mov r1, r1, lsr #16
	teq r1, #0x11
	mvnne r0, #0x1e
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
loc_27ac:
	ldr r1, [r6, #0x18]
	teq r1, #0
	beq loc_27dc
	ldr r2, [r4, #0x12]
	mov r2, r2, lsr #16
loc_27c0:
	ldr r3, [r1, #0x12]
	teq r2, r3, lsr #16
	mvneq r0, #0x1d
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r1, [r1, #0x58]
	teq r1, #0
	bne loc_27c0
loc_27dc:
	str r6, [r4, #0x1c]
	mov r2, r4
	mov r1, r6
	bl sub_734c
	mov r0, #7
	strb r0, [r4, #5]
	mov r0, #0
	strb r0, [r4, #4]
	ldr r1, [r6, #0x30]
	mov r1, r1, lsr #16
	strb r1, [r4, #0x11]
	mov r1, r1, asr #8
	strb r1, [r4, #0x10]
	ldr r1, [r6, #0x2c]!
	ldr r1, [r1, #0x20]
	strb r1, [r4, #0x61]
	mov r1, r1, asr #8
	strb r1, [r4, #0x60]
	mov r1, #0x11
	str r0, [r7, #0x10]
	str r1, [r7]
	mov r0, #0x83
	ldr r1, [r5, #0x18]
	strb r0, [r1, #9]
	ldr r0, [r4, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_285c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	bl sub_72bc
	mov r0, #0
	strb r0, [r4, #5]
	strb r0, [r4, #4]
	ldr r1, [r4, #0x1c]
	teq r1, #0
	beq loc_28a0
	str r0, [r4, #0x1c]
	mov r1, r0
	mov r2, r4
	mov r0, r5
	bl sub_7378
loc_28a0:
	mov r0, r5
	mov r3, #0x86
	mov r2, #1
	mov r1, #0
	bl sub_70ec
	mov r1, r0
	mov r0, #3
	ldr r2, [r1, #0xc]
	strb r0, [r2]
	ldr r0, [r4, #0xc]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #0x13
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_28e0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r3, #0x54
	ldr r0, [r1, #4]
	mov r0, r0, lsr #16
	teq r0, #7
	moveq r3, #0x59
	ldr r2, lit_29c4
	mov r0, r5
	mov r1, #0
	bl sub_7b2c
	movs r7, r0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, #0x83
	ldr r1, [r7, #0x18]
	strb r0, [r1, #9]
	ldr r0, [r7, #0xc]
	ldr r1, [r4, #4]
	mov r1, r1, lsr #16
	mov r5, #1
	teq r1, #7
	bne loc_29a4
	ldr r1, [r4, #0x10]
	mov r1, r1, lsr #16
	str r1, [r0, #0x44]
	str r1, [r0, #0x34]
	str r1, [r0, #4]
	mov r1, #4
	str r1, [r0, #0x18]
	mov r1, #3
	str r1, [r0, #0x3c]
	str r5, [r0, #0x48]
	ldr r2, [r4, #0x18]
	ldr r1, [r7, #0xc]
	ldr r3, [r0, #0x1c]
	str r2, [r1, r3]
	ldr r1, [r4, #0x12]
	mov r1, r1, lsr #16
	ldr r2, [r7, #0xc]
	ldr r0, [r0, #0x4c]
	strb r1, [r2, r0]
loc_29a4:
	ldr r0, [r4, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r7
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_29c4:
	.rword data_118a0			; relocated

sub_29c8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #0x10
	mov r1, r2
	mov r2, #0
	bl sub_7860
	movs sb, r0
	mvneq r0, #0x12
	beq sub_2bc0
	ldr r0, [r4, #0x10]
	cmp sb, r0, lsr #16
	mvnhi r0, #8
	bhi sub_2bc0
	ldr sl, [r6, #0xc]
	ldr r0, [sl, #4]
	teq r0, #4
	beq loc_2a24
loc_2a1c:
	mvn r0, #0x16
	b sub_2bc0
loc_2a24:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, [r6, #0xc]
	ldr r1, [sl, #8]
	ldr r8, [r0, r1]
	str r8, [sp, #8]
	ldr r0, [r4, #0x1c]
	ldr r7, [r0]
	mov r7, r7, lsr #16
	add r0, r5, r7, lsl #2
	str r0, [sp, #0xc]
	ldr r1, [r0, #0xbc]!
	mov r0, r8
	bl sub_7460
	teq r0, #1
	teqne r0, #2
	beq loc_2a1c
	ldr r1, [r4, #0x18]
	teq r1, #0
	beq loc_2b08
	teq r0, #0
	teqne r0, #4
	beq loc_2aa4
	teq r0, #5
	bne loc_2b08
	ldr r0, [r4, #0x14]
	mov r0, r0, lsr #16
	tst r0, #0x400
	movne r0, #1
	strne r0, [sp, #4]
	b loc_2b08
loc_2aa4:
	ldr r0, [sp, #0xc]
	ldr r1, [r0, #0xbc]!
	mov r0, r8
	bl sub_7514
	mov r1, r0
	ldr r0, [r4, #0x1c]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x40]
	teq r0, #1
	bne loc_2af4
	mov r0, #0

sub_2ad0:
	add r2, r5, r0, lsl #2
	ldr r2, [r2, #0xac]
	teq r2, r1
	beq loc_2aec
	add r0, r0, #1
	cmp r0, #4
	blt sub_2ad0
loc_2aec:
	teq r0, #4
	bne loc_2b08
loc_2af4:
	mov r3, sp
	add r2, sp, #8
	mov r0, r5
	bl sub_64b8
	mov r7, r0
loc_2b08:
	teq r7, #4
	mvneq r0, #0x18
	beq sub_2bc0
	add r0, r5, r7, lsl #2
	ldr r7, [r0, #0x40]!
	mvn r0, #0xe
	teq r7, #0
	beq sub_2bc0
	ldr r1, [r7, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	bne sub_2bc0
	ldr r0, [r7, #0x40]
	mov r0, r0, asr #16
	cmp r0, #0
	movle r0, #0
	ble sub_2bc0
	ldr r0, [sp, #4]
	teq r0, #1
	bne loc_2b6c
	mov r3, r8
	mov r1, r4
	mov r0, r5
	ldr r2, [r6, #8]
	bl sub_3154
loc_2b6c:
	mov r2, sb
	ldr r3, [sl, #0xc]!
	ldr r1, [r4, #0x12]
	mov r1, r1, lsr #16
	mov r0, r8
	stmdb sp!, {r0, r1, r2, r3}
	ldr r3, [r4, #0x18]!
	mov r1, r7
	mov r0, r5
	ldr r2, [r6, #8]
	bl sub_2ff4
	str r0, [r6, #8]
	ldr r3, [sp, #0x10]!
	stmdb sp!, {r3}
	mov r2, r6
	mov r1, r7
	mov r0, r5
	ldr r3, [sp, #0xc]
	bl sub_2efc
	add sp, sp, #4
	mov r0, #1

sub_2bc0:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_2bc4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #8
	ldr r0, [r1, #0x7c]
	ldr r1, [r1, #0x28]
	teq r1, #0
	moveq r0, #1
	teq r0, #1
	beq loc_2c68
	mov r7, #0x214
	teq r0, #3
	beq loc_2c88
	teq r0, #4
	beq loc_2cbc
	teq r0, #5
	bne loc_2d84
	ldr r2, [r4, #0x80]
	mov r1, r4
	mov r0, r5
	bl sub_5328
	teq r0, #0
	bne loc_2c34
loc_2c2c:
	mov r0, r7
	b sub_2ef8
loc_2c34:
	add r2, sp, #4
	ldr r3, [r4, #0x74]
	mov r1, r4
	mov r0, r5
	bl sub_3108
	teq r0, #0
	bne sub_2ef8
	ldr r2, [sp, #4]
	ldr r0, [r2, #0x14]
	mov r0, r0, lsr #16
	tst r0, #0x200
	beq loc_2c2c
	b loc_2d7c
loc_2c68:
	add r2, sp, #4
	ldr r3, [r4, #0x74]
	mov r1, r4
	mov r0, r5
	bl sub_3108
	teq r0, #0
	bne sub_2ef8
	b loc_2dd8
loc_2c88:
	add r2, sp, #4
	ldr r3, [r4, #0x74]
	mov r1, r4
	mov r0, r5
	bl sub_3108
	teq r0, #0
	bne sub_2ef8
	ldr r2, [sp, #4]
	ldr r0, [r2, #0x14]
	mov r0, r0, lsr #16
	tst r0, #0x100
	beq loc_2c2c
	b loc_2d7c
loc_2cbc:
	ldr r0, [r4]
	mov r0, r0, lsr #16
	add r0, r5, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [r4, #0x80]
	bl sub_7514
	mov r8, r0
	mov r7, #0

sub_2cdc:
	add r0, r5, r7, lsl #2
	ldr r0, [r0, #0xac]
	teq r0, r8
	beq loc_2cf8
	add r7, r7, #1
	cmp r7, #4
	blo sub_2cdc
loc_2cf8:
	teq r7, #4
	beq loc_2dfc
	add r0, r5, r7, lsl #2
	ldr r3, [r4, #0x74]
	add r2, sp, #4
	ldr r1, [r0, #0x40]!
	mov r0, r5
	bl sub_3108
	teq r0, #0
	bne loc_2dfc
	ldr r2, [sp, #4]
	ldr r0, [r2, #0x14]
	mov r0, r0, lsr #16
	tst r0, #0x100
	beq loc_2dfc
	ldr r0, [r4]
	teq r7, r0, lsr #16
	beq loc_2d7c
	mov r1, r6
	mov r0, r5
	bl sub_7e24
	movs r7, r0
	beq loc_2dfc
	mov r3, r7
	mov r1, r4
	mov r0, r5
	ldr r2, [sp, #4]
	bl sub_41d8
	tst r0, #0x200
	movne r1, r7
	movne r0, r5
	blne sub_7ed0
	b loc_2dfc
loc_2d7c:
	mov r3, r6
	b loc_2de0
loc_2d84:
	ldr r0, [r4]
	mov r0, r0, lsr #16
	add r0, r5, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [r4, #0x80]
	bl sub_7514
	mov r8, r0
	mov r0, #0
	ldr r1, [r4, #0x80]

sub_2da8:
	add r2, r5, r0, lsl #2
	ldr r2, [r2, #0x9c]
	teq r2, r1
	bne loc_2df0
	add r0, r5, r0, lsl #2
	ldr r3, [r4, #0x74]
	add r2, sp, #4
	ldr r1, [r0, #0x40]!
	mov r0, r5
	bl sub_3108
	teq r0, #0
	bne sub_2ef8
loc_2dd8:
	mov r3, r6
	ldr r2, [sp, #4]
loc_2de0:
	mov r1, r4
	mov r0, r5
	bl sub_41d8
	b sub_2ef8
loc_2df0:
	add r0, r0, #1
	cmp r0, #4
	blo sub_2da8
loc_2dfc:
	add r2, r4, #0x80
	mov r3, sp
	mov r1, r8
	mov r0, r5
	bl sub_64b8
	mov r1, r0
	mov r0, #0x20c
	teq r1, #4
	addne r1, r5, r1, lsl #2
	ldrne r1, [r1, #0x40]
	teqne r1, #0
	beq sub_2ef8
	ldr r2, [r1, #0x20]
	mov r2, r2, lsr #16
	teq r2, #4
	bne sub_2ef8
	teq r1, r4
	moveq r0, #0x15
	addeq r0, r0, #0x200
	beq sub_2ef8
	ldr r0, [sp]
	teq r0, #0
	ldreq r0, [r1, #0x32]
	moveq r0, r0, lsr #16
	streq r0, [sp]
	ldr r0, [r6, #8]
	ldr r0, [r0, #0xc]
	ldr r2, [r4, #0x70]
	ldr r3, [r4, #0x6c]
	add r3, r2, r3
	ldr r2, [sp]
	cmp r3, r2
	bls sub_2ea4
	ldrb r3, [r0, #6]
	tst r3, #0x40
	beq sub_2ea4
	strb r2, [r4, #0x37]
	mov r0, r2, asr #8
	strb r0, [r4, #0x36]
	mov r0, #0x16
	add r0, r0, #0x200
	b sub_2ef8

sub_2ea4:
	ldrb r2, [r0, #8]
	sub r2, r2, #1
	ands r2, r2, #0xff
	strb r2, [r0, #8]
	moveq r0, #0x11
	addeq r0, r0, #0x200
	beq sub_2ef8
	ldr r0, [r1, #0x40]
	mov r0, r0, asr #16
	cmp r0, #0
	movle r0, #0xd
	addle r0, r0, #0x200
	ble sub_2ef8
	ldr r3, [sp]
	stmdb sp!, {r3}
	mov r2, r6
	mov r0, r5
	ldr r3, [r4, #0x80]!
	bl sub_2efc
	add sp, sp, #4
	mov r0, #0x80

sub_2ef8:
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_2efc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r1, r2
	mov r6, r3
	ldr sb, [fp, #4]
	ldr r0, [r2, #0x18]
	ldrb r0, [r0, #9]
	mov r8, #0
	teq r0, #0
	ldrne r7, [r1, #8]
	strne r8, [r1, #8]
	moveq r7, r1
	moveq r1, #0
	mov r0, r5
	mov r3, #1
	mov r2, #0x18
	bl sub_70ec
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #7
	str r2, [r0]
	mov r2, #4
	str r2, [r0, #4]
	mov r2, #0x14
	teq sb, #0
	str r2, [r0, #8]
	ldreq sb, [r4, #0x32]
	moveq sb, sb, lsr #16
	str sb, [r0, #0xc]!
	str r8, [r0, #4]
	ldr r0, [r1, #0xc]
	str r6, [r0, #0x14]!
	str r7, [r1, #8]
	ldr r0, [r4, #0x38]
	teq r0, #0
	ldrne r0, [r4, #0x3c]
	strne r1, [r0]
	streq r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r8, [r1]
	ldr r0, [r4, #0x40]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x41]
	mov r0, r0, asr #8
	strb r0, [r4, #0x40]
	b loc_2fd0
loc_2fc4:
	mov r1, r4
	mov r0, r5
	bl sub_3f3c
loc_2fd0:
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r4, #0x38]
	teq r0, #0
	bne loc_2fc4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_2ff4:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r6, r0
	mov r4, r1
	mov r7, r2
	mov r5, r3
	mov r3, #0
	mov r2, #0x14
	mov r1, #0
	add sl, fp, #0x14
	ldmia sl, {sb, sl}
	bl sub_70ec
	mov r8, r0
	ldr r0, [r0, #0xc]
	mov r1, #0x45
	str r7, [r8, #8]
	strb r1, [r0], #1
	mov r7, r0
	mov r0, #0
	strb r0, [r7], #1
	ldr r0, [fp, #0x1c]
	add r1, r0, #0x14
	mov r0, r7
	bl sub_76a0
	add r7, r7, #2
	ldr r1, [r4, #0x24]
	mov r1, r1, lsr #16
	add r0, r1, #1
	strb r0, [r4, #0x25]
	mov r0, r0, asr #8
	strb r0, [r4, #0x24]
	mov r0, r7
	bl sub_76a0
	add r0, r7, #2
	ldr r1, [fp, #0x20]
	teq r1, #1
	movne r1, #0
	moveq r1, #0x40
	strb r1, [r0], #1
	mov r1, #0
	strb r1, [r0], #1
	mov r7, r0
	ldr r0, [r4]
	mov r0, r0, lsr #16
	add r0, r6, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	mov r0, sb
	bl sub_7460
	teq r0, #3
	beq loc_30dc
	teq r0, #5
	ldrne r0, [r4, #0x34]
	movne r0, r0, lsr #16
	bne loc_30e8
loc_30d4:
	mov r0, #1
	b loc_30e8
loc_30dc:
	teq r5, #0
	bne loc_30d4
	mov r0, #0x3c
loc_30e8:
	strb r0, [r7], #1
	strb sl, [r7], #1
	mov r1, #0
	strb r1, [r7], #1
	strb r1, [r7], #1
	mov r0, r8
	stmia r7, {r5, sb}
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_3108:
	ldr r0, [r1, #0x18]!
	str r0, [r2]
	teq r0, #0
	moveq r0, #0x214
	moveq pc, lr
	mov r1, r3, lsl #16
	mov r1, r1, lsr #16
loc_3124:
	ldr r0, [r2]
	ldr r3, [r0, #0x12]
	teq r1, r3, lsr #16
	moveq r0, #0
	moveq pc, lr
	ldr r0, [r0, #0x58]
	str r0, [r2]
	teq r0, #0
	bne loc_3124
	mov r0, #0x13
	add r0, r0, #0x200
	mov pc, lr

sub_3154:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r7, r3
	ldr r0, [r1, #0x60]
	movs r0, r0, lsr #16
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r1, r4
	mov r0, r6
	bl sub_7e24
	movs r4, r0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r0, r6
	mov r3, #1
	mov r2, #0x20
	mov r1, #0
	bl sub_70ec
	str r4, [r0, #8]
	mov r2, #0x14
	ldr r1, [r0, #0xc]
	str r2, [r1]
	mov r2, #4
	mov r3, #0x18
	stmib r1, {r2, r3}
	str r2, [r1, #0xc]
	mov r2, #0x1c
	str r2, [r1, #0x10]
	mov r2, #0
	str r2, [r1, #0x14]!
	ldr r1, [r0, #0xc]
	str r7, [r1, #0x18]!
	ldr r2, [r5, #0x18]
	ldr r1, [r0, #0xc]
	str r2, [r1, #0x1c]!
	mov r2, r0
	mov r1, r5
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_7064

sub_31fc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	mov r3, #1
	mov r2, #0x14
	bl sub_70ec
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r3, #1
	str r3, [r0]
	ldr r2, [r4, #0x2c]
	ldr r2, [r2, #0x4c]
	str r2, [r0, #4]
	mov r2, #0
	mov ip, #2
	str r2, [r0, #8]
	strb ip, [r0, #0xd]
	strb r2, [r0, #0xc]
	strb r2, [r0, #0xf]
	strb r2, [r0, #0xe]
	str r2, [r0, #0x10]!
	strb r3, [r4, #0x21]
	strb r2, [r4, #0x20]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, fp, sp, lr}
	ldr pc, [r2]

sub_3274:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	mov r3, #0x83
	mov r2, #4
	bl sub_70ec
	mov r1, r0
	mov r0, #0
	ldr r2, [r1, #0xc]
	str r0, [r2]
	mov r2, #2
	strb r2, [r4, #0x21]
	strb r0, [r4, #0x20]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, fp, sp, lr}
	ldr pc, [r2]

sub_32c4:
	ldr r3, [r1, #0x20]
	mov r3, r3, lsr #16
	teq r3, #1
	movne r0, #1
	addne r0, r0, #0x300
	movne pc, lr
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl sub_3274
	mov r0, #1
	add r0, r0, #0x100
	ldmdb fp, {fp, sp, pc}

sub_32f8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r3, [r1, #0x20]
	mov r3, r3, lsr #16
	teq r3, #2
	bne loc_3320
	ldr ip, [r0, #0x60]
	teq ip, #0
	bne loc_3328
loc_3320:
	mov r0, #0x300
	ldmdb fp, {r4, fp, sp, pc}
loc_3328:
	ldr r3, [r2, #0xc]
	mov r4, #0x100
	ldr lr, [r3, #0x20]
	teq lr, #2
	ldreq lr, [r3, #0x3c]
	teqeq lr, #2
	beq loc_3360
	mvn r3, #0x14
	stmdb sp!, {r3}
	mov r1, ip
	mov r3, #0x200
	bl sub_6ec0
	add sp, sp, #4
	b loc_339c
loc_3360:
	ldr lr, [r1, #0x32]
	ldr r3, [r3, #4]
	mov r3, r3, lsl #16
	mov r3, r3, lsr #16
	cmp r3, lr, lsr #16
	strblt r3, [r1, #0x33]
	movlt r3, r3, asr #8
	strblt r3, [r1, #0x32]
	mov r3, #4
	strb r3, [r1, #0x21]
	mov r3, #0
	strb r3, [r1, #0x20]
	mov r1, ip
	mov r3, #0x200
	bl sub_6f14
loc_339c:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_33a4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r0, #0x60]
	ldr r3, [r4, #0x20]
	mov r3, r3, lsr #16
	mov r5, #0
	teq r3, #1
	beq loc_33f0
	teq r3, #2
	beq loc_3420
	teq r3, #4
	moveq r1, r4
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq sub_3454
	movne r0, #2
	addne r0, r0, #0x300
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_33f0:
	teq r1, #0
	bne loc_3404
	mov r1, r2
	bl sub_7ed0
	b loc_3418
loc_3404:
	mvn r3, #0x15
	stmdb sp!, {r3}
	mov r3, #0x200
	bl sub_6ec0
	add sp, sp, #4
loc_3418:
	mov r0, #3
	b loc_3440
loc_3420:
	teq r1, #0
	bne loc_3434
	mov r1, r2
	bl sub_7ed0
	b loc_343c
loc_3434:
	mov r3, #0x200
	bl sub_6f14
loc_343c:
	mov r0, #4
loc_3440:
	strb r0, [r4, #0x21]
	strb r5, [r4, #0x20]
	mov r0, #2
	add r0, r0, #0x100
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_3454:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	teq r0, #1
	teqne r0, #2
	beq loc_34ac
	teq r0, #4
	movne r0, #6
	addne r0, r0, #0x300
	ldmdbne fp, {r4, r5, fp, sp, pc}
	teq r2, #0
	movne r1, r2
	movne r0, r4
	blne sub_7ed0
	mov r1, r5
	mov r0, r4
	bl sub_351c
	b loc_34e0
loc_34ac:
	ldr r1, [r4, #0x60]
	teq r1, #0
	bne loc_34c8
	mov r1, r2
	mov r0, r4
	bl sub_7ed0
	b loc_34e0
loc_34c8:
	mvn r3, #0x15
	stmdb sp!, {r3}
	mov r0, r4
	mov r3, #0x200
	bl sub_6ec0
	add sp, sp, #4
loc_34e0:
	mov r0, #3
	strb r0, [r5, #0x21]
	mov r0, #0
	strb r0, [r5, #0x20]
	mov r1, r5
	mov r0, r4
	bl sub_5e28
	mov r0, #6
	add r0, r0, #0x100
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_3508:
	mov r0, #0x304
	mov pc, lr

sub_3510:
	mov r0, #5
	add r0, r0, #0x300
	mov pc, lr

sub_351c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x38]
	teq r1, #0
	beq loc_3570
loc_353c:
	ldr r0, [r1]
	str r0, [r4, #0x38]
	mov r0, r5
	bl sub_7ed0
	ldr r0, [r4, #0x40]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x41]
	mov r0, r0, asr #8
	strb r0, [r4, #0x40]
	ldr r1, [r4, #0x38]
	teq r1, #0
	bne loc_353c
loc_3570:
	mov r7, #0
	str r7, [r4, #0x3c]
	ldr r0, [r4]
	mov r0, r0, lsr #16
	add r1, r5, r0, lsl #2
	str r7, [r1, #0x9c]
	str r7, [r1, #0xac]!
	ldr r1, [r5, #0x90]
	teq r0, r1, lsr #16
	bne loc_35b4
	mov r0, #4
	strb r0, [r5, #0x91]
	strb r7, [r5, #0x90]
	mov r0, #0x80000000
	add r5, r5, #0x94
	stmia r5, {r0, r7}
	sub r5, r5, #0x94
loc_35b4:
	ldr r0, [r4, #0x8c]
	teq r0, #0
	beq loc_35dc
loc_35c0:
	ldr r2, [r4, #0x8c]
	mov r1, r4
	mov r0, r5
	bl sub_5354
	ldr r0, [r4, #0x8c]
	teq r0, #0
	bne loc_35c0
loc_35dc:
	ldr r6, [r4, #0x18]
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
loc_35e8:
	mov r1, r6
	mov r0, r5
	bl sub_72bc
	strb r7, [r6, #5]
	strb r7, [r6, #4]
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_7378
	str r7, [r6, #0x1c]
	mov r1, r6
	mov r0, r5
	mvn r3, #0xe
	mov r2, #0
	bl sub_6e6c
	ldr r6, [r4, #0x18]
	teq r6, #0
	bne loc_35e8
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_3634:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r3
	ldr r7, [r0, #4]
	ldr r0, [r7, #0x14]
	teq r0, #0
	bne loc_367c
	mov r0, r7
	bl sub_561c
	movs r8, r0
	beq loc_367c
	mov r0, r7
	bl sub_56c4
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_367c:
	teq r5, #2
	bne loc_3694
	mov r0, r7
	bl sub_591c
	mov r5, r0
	b loc_36a8
loc_3694:
	mov r5, r6, lsl #16
	mov r5, r5, lsr #16
	cmp r5, #3
	mvngt r0, #3
	ldmdbgt fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_36a8:
	cmp r5, #0
	mvnlt r0, #2
	ldmdblt fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, [r4, #0x18]
	teq r0, #0
	beq loc_36d0
	mov r1, r5
	mov r0, r7
	bl sub_59a0
	b loc_3738
loc_36d0:
	mov r0, r7
	bl sub_5730
	teq r0, #0
	bne loc_36f4
	mov r1, r5
	mov r0, r7
	bl sub_59a0
	mvn r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_36f4:
	cmp r5, #3
	bgt loc_3714
	add r1, r7, r5, lsl #2
	str r0, [r1, #0x5c]!
	add r1, r5, #1
	strb r1, [r0, #5]
	mov r1, r1, lsr #8
	strb r1, [r0, #4]
loc_3714:
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x30]
	str r0, [r1, #0x18]!
	str r4, [r0, #0xc]
	ldr r1, [r4, #0x30]!
	str r1, [r0, #8]
	strb r5, [r0, #1]
	mov r1, r5, lsr #8
	strb r1, [r0]
loc_3738:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_3740:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r6, [r0, #4]
	moveq r0, r7
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r1, #1
	ldr r0, [r5, #0xc]
	bl sub_7fa0
	mov r1, #1
	ldr r0, [r5, #8]
	bl sub_7fa0
	ldr r1, [r5]
	mov r1, r1, lsr #16
	mov r0, r6
	bl sub_59a0
	ldr r1, [r5, #0x1c]
	teq r1, #0
	movne r2, r5
	movne r0, r6
	blne sub_7378
	mov r1, r5
	mov r0, r6
	bl sub_5790
	mov r0, r7
	ldr r1, [r4, #0x30]
	str r7, [r1, #0x18]!
	str r7, [r4, #0x18]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_37c4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, #0
	ldr r1, [r0, #0x18]
	teq r1, #0
	ldr r6, [r0, #4]
	bne loc_37fc
loc_37ec:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_38b0
loc_37fc:
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #1
	beq loc_3890
	teq r0, #0xe
	beq loc_3880
	teq r0, #0x83
	beq loc_3890
	teq r0, #0x86
	bne loc_38a0
	ldr r1, [r4, #0xc]
	ldrb r0, [r1]
	tst r0, #2
	beq loc_3848
	bic r0, r0, #2
	strb r0, [r1]
	mov r0, r5
	mov r1, #1
	bl sub_7fa0
loc_3848:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_37ec
	mov r1, #1
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_38b0
loc_3880:
	mov r2, r4
	mov r0, r6
	bl sub_5a14
	b loc_38b0
loc_3890:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	b loc_38b0
loc_38a0:
	mov r2, r4
	mov r0, r6
	mvn r3, #1
	bl sub_6e6c
loc_38b0:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_38b8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r6, [r0, #4]
	ldr r0, [r1, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #1
	teqne r0, #0x83
	beq loc_38f4
	teq r0, #0x86
	beq loc_3904
	teq r0, #0x8a
	bne loc_3968
loc_38f4:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	b loc_3974
loc_3904:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_3930
	mov r0, r5
	mov r1, #1
	bl sub_7fa0
	ldr r0, [r4, #0xc]
	ldrb r1, [r0]
	bic r1, r1, #1
	strb r1, [r0]
loc_3930:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #2
	beq loc_3968
	mov r1, #1
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_3974
loc_3968:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
loc_3974:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_397c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r6, [r0, #0x18]
	teq r6, #0
	ldr r5, [r0, #4]
	bne loc_39b0
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_3aa0
loc_39b0:
	ldr r0, [r5, #0x88]
	movs r0, r0, lsr #16
	beq loc_39d0
	add r1, r5, #0x18
	mov r2, r6
	mov r0, r5
	mov r3, #0
	b loc_3a78
loc_39d0:
	ldr r0, [r5, #0x74]
	teq r0, #0
	beq loc_39f0
loc_39dc:
	mov r0, r5
	bl sub_6544
	ldr r0, [r5, #0x74]
	teq r0, #0
	bne loc_39dc
loc_39f0:
	ldr r0, [r6, #0x16]
	movs r0, r0, lsr #16
	beq loc_3a2c
	mov r1, r6
	mov r0, r5
	bl sub_4710
	ldr r0, [r6, #0x16]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r6, #0x17]
	mov r0, r0, asr #8
	strb r0, [r6, #0x16]
	ldr r0, [r6, #8]!
	bl sub_84a0
	b loc_3aa0
loc_3a2c:
	mov r0, r4
	bl sub_8004
	movs r8, r0
	beq loc_3a90
loc_3a3c:
	mov r2, r8
	mov r1, r6
	mov r0, r5
	bl sub_6cac
	teq r0, #0
	bne loc_3a80
	mov r2, r8
	ldr r1, [r4, #8]
	mov r0, r4
	bl sub_8030
	ldr r0, [r6, #0x1c]
	add r1, r0, #0x64
	mov r2, r6
	mov r0, r5
	mov r3, #4
loc_3a78:
	bl sub_7210
	b loc_3aa0
loc_3a80:
	mov r0, r4
	bl sub_8004
	movs r8, r0
	bne loc_3a3c
loc_3a90:
	ldr r1, [r6, #0x1c]!
	teq r1, #0
	movne r0, r5
	blne sub_3ca8
loc_3aa0:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_3aa8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r6, [r0, #4]
	bne loc_3adc
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_3b50
loc_3adc:
	ldr r0, [r6, #0x88]
	movs r0, r0, lsr #16
	beq loc_3afc
	mov r0, #1
	strb r0, [r5, #0x11]
	mov r0, r7
	strb r7, [r5, #0x10]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_3afc:
	ldr r0, [r5, #0x88]
	teq r0, #0
	beq loc_3b20
loc_3b08:
	mov r1, r5
	mov r0, r6
	bl sub_53a8
	ldr r0, [r5, #0x88]
	teq r0, #0
	bne loc_3b08
loc_3b20:
	mov r0, r4
	bl sub_8004
	teq r0, #0
	beq loc_3b50
loc_3b30:
	mov r2, r0
	mov r1, r5
	mov r0, r6
	bl sub_5fbc
	mov r0, r4
	bl sub_8004
	teq r0, #0
	bne loc_3b30
loc_3b50:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_3b58:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	bne loc_3b88
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_3bec
loc_3b88:
	ldr r0, [r4, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_3bec
loc_3b98:
	ldr r1, [r5, #0x64]
	teq r1, #0
	beq loc_3bec
	ldr r0, [r1]
	str r0, [r5, #0x64]
	teq r0, #0
	streq r6, [r5, #0x68]
	ldr r0, [r5, #0x60]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r5, #0x61]
	mov r0, r0, asr #8
	strb r0, [r5, #0x60]
	ldr r0, [r4, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	ldr r0, [r4, #0x10]
	bl sub_7f30
	teq r0, #1
	beq loc_3b98
loc_3bec:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_3bf4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r6, [r0, #4]
	bne loc_3c28
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_3ca0
loc_3c28:
	ldr r0, [r4, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_3c94
loc_3c38:
	ldr r1, [r5, #0x38]
	teq r1, #0
	beq loc_3c94
	ldr r0, [r1, #0xc]
	ldr r0, [r0]
	teq r0, #7
	bne loc_3c64
	mov r1, r5
	mov r0, r6
	bl sub_3f3c
	b loc_3c84
loc_3c64:
	ldr r0, [r1]
	str r0, [r5, #0x38]
	teq r0, #0
	streq r7, [r5, #0x3c]
	ldr r0, [r4, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_3c84:
	ldr r0, [r4, #0x10]
	bl sub_7f30
	teq r0, #1
	beq loc_3c38
loc_3c94:
	mov r1, r5
	mov r0, r6
	bl sub_3ca8
loc_3ca0:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_3ca8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r1, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	addne r1, r4, #0x64
	ldrne r4, [r1]
	teqne r4, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r2, r4
	mov r0, r5
	mov r3, #4
	bl sub_7264
	ldr r0, [r4, #8]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_84a0

sub_3cf8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x88]
	movs r0, r0, lsr #16
	add r1, r0, #1
	strb r1, [r4, #0x89]
	mov r1, r1, asr #8
	strb r1, [r4, #0x88]
	ldmdbne fp, {r4, fp, sp, pc}
	ldr r0, lit_3d64
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0
	mov r2, #0x20
	bl sub_843c
	ldr r0, lit_3d68
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0x64
	mov r2, #0
	bl sub_8924
	str r0, [r4, #0x8c]!
	ldmdb fp, {r4, fp, sp, pc}
lit_3d64:
	.rword sub_3d6c				; relocated
lit_3d68:
	.rword sub_3eb8				; relocated

sub_3d6c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x88]
	movs r0, r0, lsr #16
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	add r5, r4, #0x78
	mov r6, #0

sub_3d90:
	ldr r0, [r5]
	teq r0, #0
	bne loc_3dd0
	mov r0, r4
	mov r2, #1
	mov r1, #0x20
	bl sub_7c44
	str r0, [r5]
	teq r0, #0
	beq loc_3de0
	ldr r0, [r4, #0x88]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x89]
	mov r0, r0, asr #8
	strb r0, [r4, #0x88]
loc_3dd0:
	add r5, r5, #4
	add r6, r6, #1
	cmp r6, #4
	blo sub_3d90
loc_3de0:
	ldr r0, [r4, #0x88]
	movs r0, r0, lsr #16
	beq loc_3e0c
	ldr r0, lit_3eb4
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0
	mov r2, #0x20
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_843c
loc_3e0c:
	mov r6, #0
	ldr r1, [r4, #0x8c]
	teq r1, #0
	beq loc_3e28
	mov r0, r4
	bl sub_8a04
	str r6, [r4, #0x8c]
loc_3e28:
	ldr r5, [r4, #0x18]
	teq r5, #0
	beq loc_3e64
	add r7, r4, #0x18
loc_3e38:
	mov r1, r7
	mov r2, r5
	mov r0, r4
	mov r3, #0
	bl sub_7264
	ldr r0, [r5, #8]!
	teq r0, #0
	blne sub_84a0
	ldr r5, [r4, #0x18]
	teq r5, #0
	bne loc_3e38
loc_3e64:
	add r4, r4, #0x40
	mov r5, #0

sub_3e6c:
	ldr r0, [r4]
	teq r0, #0
	beq loc_3ea0
	ldr r1, [r0, #0x10]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_3ea0
	strb r6, [r0, #0x11]
	strb r6, [r0, #0x10]
	ldr r0, [r4]
	ldr r0, [r0, #0xc]
	teq r0, #0
	blne sub_84a0
loc_3ea0:
	add r4, r4, #4
	add r5, r5, #1
	cmp r5, #4
	blo sub_3e6c
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_3eb4:
	.rword sub_3d6c				; relocated

sub_3eb8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x88]
	movs r0, r0, lsr #16
	mov r0, #0
	beq loc_3f30

sub_3ed8:
	add r1, r4, r0, lsl #2
	ldr r1, [r1, #0x40]
	teq r1, #0
	beq loc_3f08
	ldr r2, [r1, #0x20]
	mov r2, r2, lsr #16
	teq r2, #4
	bne loc_3f08
	mov r0, r4
	mov r2, #0
	bl sub_3454
	b loc_3f14
loc_3f08:
	add r0, r0, #1
	cmp r0, #4
	blt sub_3ed8
loc_3f14:
	ldr r0, lit_3f38
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0x64
	mov r2, #0
	bl sub_8924
loc_3f30:
	str r0, [r4, #0x8c]!
	ldmdb fp, {r4, fp, sp, pc}
lit_3f38:
	.rword sub_3eb8				; relocated

sub_3f3c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #8
	ldr r6, [r1, #0x38]
	ldr r0, [r6]
	str r0, [r1, #0x38]
	teq r0, #0
	moveq r0, #0
	streq r0, [r5, #0x3c]
	ldr r0, [r5, #0x40]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r5, #0x41]
	mov r0, r0, asr #8
	strb r0, [r5, #0x40]
	ldr r1, [r6, #8]
	ldr sb, [r1, #0xc]
	ldrb r0, [sb]
	and r0, r0, #0xf
	mov r8, r0, lsl #2
	ldr r0, [r6, #0xc]
	ldr r7, [r0, #0xc]!
	mov r0, r4
	mov r2, #0
	bl sub_7860
	str r0, [sp]
	cmp r0, r7
	bls sub_4168
	ldrb r0, [sb, #6]
	tst r0, #0x40
	bne loc_3ff4
	sub r0, r7, r8
	mov sl, r0, lsl #16
	mov sl, sl, lsr #16
	bic sl, sl, #7
	ldr r0, [r6, #0x10]
	ldr r2, [r6, #0xc]
	sub r3, r0, r2
	mov r0, r4
	mov r1, #0
	bl sub_7b2c
	movs r7, r0
	bne loc_4004
loc_3ff4:
	mov r1, r6
	mov r0, r4
	bl sub_7ed0
	b loc_41d4
loc_4004:
	mov r1, #1
	ldr r0, [r7, #0x18]
	strb r1, [r0, #9]
	mov r3, r8
	mov r2, sb
	mov r0, r4
	mov r1, #0
	bl sub_7b2c
	str r0, [r7, #8]
	teq r0, #0
	beq loc_4044
	mov r0, r4
	ldr r1, [r6, #8]
	bl sub_7e24
	movs r1, r0
	bne loc_4054
loc_4044:
	mov r1, r7
	mov r0, r4
	bl sub_7ed0
	b loc_3ff4
loc_4054:
	mov r2, r8
	mov r0, r4
	bl sub_779c
	mov r1, r0
	mov r2, sl
	mov r0, r4
	bl sub_779c
	ldr r1, [r7, #8]
	str r0, [r1, #8]!
	ldr r0, [r5, #0x38]
	str r0, [r7]
	teq r0, #0
	streq r7, [r5, #0x3c]
	str r7, [r5, #0x38]
	ldr r0, [r5, #0x40]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r5, #0x41]
	mov r0, r0, asr #8
	strb r0, [r5, #0x40]
	add r2, r8, sl
	str r2, [sp, #4]
	mov r0, r4
	ldr r1, [r6, #8]
	bl sub_77f8
	ldrb r0, [sb, #6]
	orr r0, r0, #0x20
	strb r0, [sb, #6]
	add r0, sb, #2
	ldr r1, [sp, #4]
	bl sub_76a0
	ldr r0, [r7, #8]!
	ldr r4, [r0, #0xc]!
	ldr r0, [sp]
	sub r1, r0, sl
	add r0, r4, #2
	bl sub_76a0
	add r0, r4, #6
	mov r7, r0
	bl sub_7668
	add r1, r0, sl, lsr #3
	mov r0, r7
	bl sub_76a0
	add r0, r4, #0x14
	subs r1, r8, #0x14
	beq sub_4168
	mov r3, #1
loc_4110:
	ldrb ip, [r0]
	teq ip, #0
	beq sub_4168
	teq ip, #1
	addeq r0, r0, #1
	subeq r1, r1, #1
	beq loc_4160
	ldrb r2, [r0, #1]
	sub r1, r1, r2
	tst ip, #0x80
	bne loc_415c
	movs ip, r2
	sub r2, r2, #1
	beq loc_4160
loc_4148:
	strb r3, [r0], #1
	movs ip, r2
	sub r2, r2, #1
	bne loc_4148
	b loc_4160
loc_415c:
	add r0, r0, r2
loc_4160:
	teq r1, #0
	bne loc_4110

sub_4168:
	ldr r0, [r6, #8]
	ldr r0, [r0, #0xc]
	add r0, r0, #0xa
	mov r1, #0
	bl sub_76a0
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, r8
	mov r2, #0
	mov r1, #0
	ldr r0, [r6, #8]
	bl sub_7560
	mov r1, r0
	add sp, sp, #4
	ldr r0, [r6, #8]
	ldr r0, [r0, #0xc]
	add r0, r0, #0xa
	bl sub_76a0
	mov r0, #0
	ldr r1, [r6, #0xc]
	str r0, [r1, #0xc]!
	ldr r0, [r5, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r6
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_41d4:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_41d8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r5, r1
	mov r6, r2
	mov r4, r3
	sub sp, sp, #0xc
	ldr r0, [r3, #8]
	ldr r8, [r0, #0xc]!
	add r1, r8, #0xc
	mov r0, sp
	mov r2, #4
	bl memcpy
	add r0, r8, #4
	bl sub_7668
	mov sl, r0
	add r0, r8, #6
	bl sub_7668
	ldrb r1, [r8, #8]
	str r1, [sp, #4]
	and r1, r0, #0x2000
	mov r0, r0, lsl #3
	mov sb, r0, lsl #16
	mov sb, sb, lsr #16
	str r1, [sp, #8]
	ldr r8, [r6, #0x50]
	teq r8, #0
	beq loc_427c
	ldr r0, [sp]
loc_4250:
	ldr r1, [r8, #2]
	teq sl, r1, lsr #16
	ldreq r1, [r8, #8]
	teqeq r1, r0
	ldreq r2, [r8, #0xc]
	ldreq r1, [r5, #0x80]
	teqeq r2, r1
	beq loc_427c
	ldr r8, [r8, #0x24]
	teq r8, #0
	bne loc_4250
loc_427c:
	ldr r1, [sp, #8]
	cmp r1, #0
	bne loc_42c0
	teq sb, #0
	bne loc_42dc
	teq r8, #0
	beq loc_42a8
loc_4298:
	mov r2, r8
	mov r1, r6
	mov r0, r7
	bl sub_73c0
loc_42a8:
	mov r3, r4
	mov r2, r6
	mov r1, r5
	mov r0, r7
	bl sub_45f4
	b loc_457c
loc_42c0:
	ldrne r0, [r5, #0x70]
	andne r0, r0, #7
	teqne r0, #0
	beq loc_42dc

sub_42d0:
	mov r0, #7
	add r0, r0, #0x200
	b loc_457c
loc_42dc:
	teq r8, #0
	bne loc_4360
	mov r0, #0x2c
	bl sub_7b9c
	movs r8, r0
	beq sub_42d0
	mov r0, r8
	mov r2, #0x2c
	mov r1, #0
	bl memset
	ldr r0, [r6, #0x50]
	str r0, [r8, #0x24]
	teq r0, #0
	ldrne r0, [r6, #0x50]
	strne r8, [r0, #0x28]!
	streq r8, [r6, #0x54]
	str r8, [r6, #0x50]
	strb sl, [r8, #3]
	mov r0, sl, asr #8
	strb r0, [r8, #2]
	ldr r0, [sp]
	str r0, [r8, #8]
	ldr r0, [r5, #0x80]
	str r0, [r8, #0xc]
	ldr r0, [r5, #0x7c]
	strb r0, [r8, #1]
	ldr r0, [r5, #0x2c]
	ldr r0, [r0, #0x1c]
	strb r0, [r8, #5]
	mov r0, r0, asr #8
	strb r0, [r8, #4]
	str r5, [r8, #0x20]
	str r6, [r8, #0x1c]
loc_4360:
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x6c]
	strb r1, [r0, #1]
	mov r1, r1, asr #8
	strb r1, [r0]
	strb sb, [r0, #3]
	mov r1, sb, asr #8
	strb r1, [r0, #2]
	ldr r1, [r5, #0x70]
	strb r1, [r0, #5]
	mov r1, r1, asr #8
	strb r1, [r0, #4]
	ldr r1, [sp, #8]
	strb r1, [r0, #7]
	mov r1, r1, asr #8
	strb r1, [r0, #6]
	ldr r0, [r8, #0x10]
	teq r0, #0
	beq loc_43d4
loc_43ac:
	ldr r1, [r0, #0xc]
	ldr r2, [r1, #2]
	cmp sb, r2, lsr #16
	blt sub_43cc
	ldr r0, [r0]
	teq r0, #0
	bne loc_43ac
	b loc_43d4

sub_43cc:
	teq r0, #0
	bne loc_4440
loc_43d4:
	ldr r0, [r8, #0x14]
	teq r0, #0
	beq loc_4428
	ldr r1, [r0, #0xc]
	ldr r2, [r1, #2]
	mov r2, r2, lsr #16
	ldr r3, [r1, #4]
	mov r3, r3, lsr #16
	add r2, r2, r3
	mov r2, r2, lsl #16
	cmp sb, r2, lsr #16
	blt sub_42d0
	ldr r1, [r1, #6]
	movs r1, r1, lsr #16
	beq sub_42d0
	mov r1, #0
	str r4, [r0]
	str r0, [r4, #4]
	str r1, [r4]
	str r4, [r8, #0x14]
	b loc_44b4
loc_4428:
	str r4, [r8, #0x14]
	mov r1, #0
	str r4, [r8, #0x10]
	str r1, [r4]
	str r1, [r4, #4]!
	b loc_44b4
loc_4440:
	ldr r2, [r5, #0x70]
	add r2, r2, sb
	mov r2, r2, lsl #16
	mov r2, r2, lsr #16
	ldr r1, [r1, #2]
	cmp r2, r1, lsr #16
	bgt sub_42d0
	ldr r1, [sp, #8]
	teq r1, #0
	beq sub_42d0
	ldr r1, [r0, #4]
	teq r1, #0
	beq loc_44a4
	ldr r2, [r1, #0xc]
	ldr r3, [r2, #2]
	mov r3, r3, lsr #16
	ldr r2, [r2, #4]
	mov r2, r2, lsr #16
	add r2, r3, r2
	mov r2, r2, lsl #16
	cmp sb, r2, lsr #16
	blt sub_42d0
	str r4, [r1]
	str r4, [r0, #4]
	stmia r4, {r0, r1}
loc_44a4:
	str r4, [r0, #4]
	mov r1, #0
	stmia r4, {r0, r1}
	str r4, [r8, #0x10]
loc_44b4:
	mov sb, #0
	ldr r0, [r8, #0x10]
	movs r4, r0
	beq loc_4508
loc_44c4:
	ldr r1, [r0, #0xc]
	ldr r2, [r1, #2]
	teq sb, r2, lsr #16
	bne loc_4508
	ldr r2, [r1, #4]
	mov r2, r2, lsr #16
	add r2, r2, sb
	mov sb, r2, lsl #16
	mov sb, sb, lsr #16
	ldr r0, [r0]
	teq r0, #0
	bne loc_44c4
	teq sb, #0
	beq loc_4508
	ldr r0, [r1, #6]
	movs r0, r0, lsr #16
	beq loc_4584
loc_4508:
	ldr r1, [r8, #0x18]
	teq r1, #0
	beq loc_4524
	mov r0, r7
	bl sub_8a04
	mov r1, #0
	str r1, [r8, #0x18]
loc_4524:
	mov r1, #0
	strb r1, [r8]
	ldr r1, [sp, #4]
	add r0, r1, r1, lsl #2
	mov r0, r0, lsl #1
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	ldr r1, [r8, #4]
	cmp r0, r1, lsr #16
	strbgt r0, [r8, #5]
	movgt r0, r0, asr #8
	strbgt r0, [r8, #4]
	ldr r0, lit_4580
	bl sub_11bfc
	mov r1, r0
	ldr r3, [r8, #4]
	mov r3, r3, lsr #16
	mov r2, r8
	mov r0, r7
	bl sub_8924
	str r0, [r8, #0x18]!
	mov r0, #0x80
loc_457c:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_4580:
	.rword sub_46cc				; relocated
loc_4584:
	ldr sl, [r4]
	teq sl, #0
	beq loc_45d4
loc_4590:
	ldr r0, [sl, #0xc]
	ldr r1, [sl, #8]
	ldr r2, [r0]
	mov r2, r2, lsr #16
	mov r0, r7
	bl sub_779c
	str r0, [sl, #8]
	mov r2, r0
	mov r1, r4
	mov r0, r7
	bl sub_7f00
	mov r1, sl
	ldr sl, [sl]
	mov r0, r7
	bl sub_7e90
	teq sl, #0
	bne loc_4590
loc_45d4:
	str sb, [r5, #0x70]
	ldr r0, [r4, #0xc]
	ldr r0, [r0]
	mov r0, r0, lsr #16
	mov r1, #0
	str r0, [r5, #0x6c]
	str r1, [r8, #0x10]
	b loc_4298

sub_45f4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r7, r1
	mov r6, r2
	mov r4, r3
	ldr r0, [r2, #0x60]
	movs r0, r0, lsr #16
	moveq r0, #0xd
	addeq r0, r0, #0x200
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov sb, #0
	ldr r8, [r4, #8]
	str sb, [r4, #8]
	mov r1, r4
	mov r0, r5
	mov r3, #1
	mov r2, #0x20
	bl sub_70ec
	mov r4, r0
	ldr r0, [r0, #0xc]
	mov r1, #0x14
	str r1, [r0]
	mov r1, #4
	mov r2, #0x18
	stmib r0, {r1, r2}
	str r1, [r0, #0xc]
	mov r1, #0x1c
	add r0, r0, #0xc
	stmib r0!, {r1, sb}
	ldr r0, [r8, #0xc]
	add r1, r0, #0x10
	ldr r0, [r4, #0xc]
	add r0, r0, r2
	mov r2, #4
	bl memcpy
	ldr r0, [r8, #0xc]
	add r1, r0, #0xc
	ldr r0, [r4, #0xc]
	add r0, r0, #0x1c
	mov r2, #4
	bl memcpy
	mov r1, r8
	mov r0, r5
	ldr r2, [r7, #0x6c]!
	bl sub_779c
	str r0, [r4, #8]
	mov r2, r4
	mov r1, r6
	mov r0, r5
	bl sub_7064
	mov r0, #0x80
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_46cc:
	ldr r0, [r1, #0x18]
	teq r0, #0
	moveq pc, lr
	mov r0, #0
	str r0, [r1, #0x18]
	mov r0, #1
	strb r0, [r1]
	ldr r0, [r1, #0x1c]
	ldr r2, [r0, #0x16]!
	mov r2, r2, lsr #16
	add r2, r2, #1
	strb r2, [r0, #1]
	mov r2, r2, asr #8
	strb r2, [r0]
	ldr r0, [r1, #0x1c]!
	ldr r0, [r0, #8]
	b sub_84a0

sub_4710:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r6, [r1, #0x50]
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
loc_4730:
	ldrb r0, [r6]
	teq r0, #1
	bne loc_47b0
	ldr r0, [r4, #0x12]
	mov r0, r0, lsr #16
	teq r0, #1
	teqne r0, #2
	beq loc_47a0
	ldrb r0, [r6, #1]
	teq r0, #0
	bne loc_47a0
	ldr r1, [r6, #0x20]
	ldr r2, [r6, #0x10]
	ldr r0, [r2]
	str r0, [r6, #0x10]
	ldr r0, [r2, #0xc]
	ldr r3, [r0]
	mov r3, r3, lsr #16
	str r3, [r1, #0x6c]
	ldr r0, [r0, #4]
	mov r0, r0, lsr #16
	mov r3, #1
	str r0, [r1, #0x70]
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #0xb
	bl sub_4984
	add sp, sp, #4
loc_47a0:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_73c0
loc_47b0:
	ldr r6, [r6, #0x24]
	teq r6, #0
	bne loc_4730
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_47c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #4
	ldr r0, [r1, #0x28]
	teq r0, #0
	moveq r0, #7
	addeq r0, r0, #0x200
	beq sub_4980
	ldr sl, [r6, #8]
	ldr r0, [r4, #0x2c]
	ldr r7, [r4, #0x70]
	ldr sb, [r4, #0x6c]
	ldr r0, [r0, #0x44]
	teq r0, #0
	bne loc_483c
	mov r3, sb
	stmdb sp!, {r3}
	mov r3, r7
	mov r0, sl
	mov r2, #0
	mov r1, #0
	bl sub_7560
	add sp, sp, #4
	teq r0, #0
	movne r0, #0xa
	addne r0, r0, #0x200
	bne sub_4980
loc_483c:
	mov r0, #0xb
	add r0, r0, #0x200
	cmp r7, #8
	blo sub_4980
	mov r1, #0
	ldr r2, [r4, #0x80]

sub_4854:
	add r3, r5, r1, lsl #2
	ldr r3, [r3, #0x9c]
	teq r3, r2
	beq loc_4870
	add r1, r1, #1
	cmp r1, #4
	blo sub_4854
loc_4870:
	ldr r2, [sl, #0xc]
	add r8, r2, sb
	ldrb r2, [r8]
	cmp r2, #0xb
	beq loc_48d8
	bgt loc_48ac
	teq r2, #3
	teqne r2, #5
	beq loc_48d8
	teq r2, #8
	bne loc_4968
	teq r1, #4
	movne r0, #0
	bne loc_48d0
	b loc_4968
loc_48ac:
	teq r2, #0xd
	beq loc_48f4
	teq r2, #0xf
	bne loc_4968
	teq r1, #4
	beq loc_4968
	teq r7, #8
	bne sub_4980
	mov r0, #0x10
loc_48d0:
	strb r0, [r8]
	b loc_4940
loc_48d8:
	cmp r7, #0x1c
	blo sub_4980
	mov r2, r8
	mov r1, r4
	mov r0, r5
	bl sub_4cb0
	b loc_4968
loc_48f4:
	teq r1, #4
	beq loc_4968
	teq r7, #0x14
	bne sub_4980
	mov r0, #0xe
	strb r0, [r8]
	mov r0, r5
	bl sub_8b84
	add ip, r0, r0, lsl #3
	add r0, ip, r0, lsl #4
	mov r1, #0x80000000
	orr r1, r1, r0, lsl #2
	add r0, r8, #0xc
	str r0, [sp]
	bl sub_7680
	add r0, r8, #0x10
	mov r2, #4
	ldr r1, [sp]
	bl memcpy
loc_4940:
	mov r3, r7
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, sl
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_4ba4
	add sp, sp, #8
	b sub_4980
loc_4968:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_2bc4
	and r0, r0, #0x200
	orr r0, r0, #0x81

sub_4980:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_4984:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	mov r7, r3
	ldr sl, [fp, #4]
	sub sp, sp, #0xc
	ldr r0, [r1, #0x28]
	teq r0, #0
	beq loc_4ba0
	cmp r7, #5
	beq loc_4a08
	bgt loc_49e4
	teq r7, #3
	ldreq r0, [r4, #0x2c]
	ldreq r0, [r0, #0x28]
	beq loc_4a10
	teq r7, #4
	ldreq r0, [r4, #0x2c]
	ldreq r0, [r0, #0x2c]
	beq loc_4a10
	b sub_4a50
loc_49e4:
	teq r7, #0xb
	ldreq r0, [r4, #0x2c]
	ldreq r0, [r0, #0x30]
	beq loc_4a10
	teq r7, #0xc
	ldreq r0, [r4, #0x2c]
	ldreq r0, [r0, #0x34]
	beq loc_4a10
	b sub_4a50
loc_4a08:
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x38]
loc_4a10:
	teq r0, #0
	beq sub_4a50
	ldr r0, [r4, #0x40]
	mov r0, r0, asr #16
	cmp r0, #0
	ble sub_4a50
	ldr r0, [r5, #0xc]
	ldr r1, [r0, #0xc]
	teq r1, #4
	bne sub_4a50
	mov r1, r0
	ldr r0, [r0, #0x10]
	ldr r3, [r1, r0]
	str r3, [sp, #4]
	teq r3, #0
	bne loc_4a60

sub_4a50:
	mov r1, r5
	mov r0, r6
	bl sub_7ed0
	b loc_4ba0
loc_4a60:
	mov r0, r6
	mov r3, #0
	mov r2, #8
	mov r1, #0
	bl sub_70ec
	mov sb, r0
	ldr r0, [r0, #0xc]
	mov r8, r0
	mov r2, #8
	mov r1, #0
	bl memset
	ldr r0, [r4, #0x6c]
	add r2, r0, #8
	mov r0, r6
	ldr r1, [r5, #8]
	bl sub_77f8
	ldr r0, [r5, #8]
	str r0, [sb, #8]
	str sb, [r5, #8]
	mov r1, sb
	mov r0, r6
	mov r2, #0
	bl sub_7860
	str r0, [sp, #8]
	strb r7, [r8]
	ldr r0, [sb, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, #0xc
	mov r0, sp
	mov r2, #4
	bl memcpy
	teq r7, #5
	beq loc_4b14
	and r0, sl, #0xff
	teq r7, #0xc
	strbeq r0, [r8, #4]
	beq loc_4b24
	strb r0, [r8, #1]
	teq r7, #3
	teqeq sl, #4
	ldreq r1, [r4, #0x36]
	moveq r1, r1, lsr #16
	addeq r0, r8, #6
	bleq sub_76a0
	b loc_4b24
loc_4b14:
	ldr r3, [sp, #4]
	str r3, [sp]
	ldr r0, [r4, #0x80]
	str r0, [r8, #4]
loc_4b24:
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, sb
	mov r2, #0
	mov r1, #0
	ldr r3, [sp, #0xc]
	bl sub_7560
	mov r1, r0
	add sp, sp, #4
	add r0, r8, #2
	bl sub_76a0
	mov r3, #0
	mov r1, #1
	ldr r0, [sp]
	ldr r2, [sp, #8]
	stmdb sp!, {r0, r1, r2, r3}
	ldr r3, [r4, #0x28]
	mov r1, r4
	mov r0, r6
	ldr r2, [r5, #8]
	bl sub_2ff4
	add sp, sp, #0x10
	mov r3, #0
	str r0, [r5, #8]
	stmdb sp!, {r3}
	mov r2, r5
	mov r1, r4
	mov r0, r6
	ldr r3, [sp, #8]
	bl sub_2efc
	add sp, sp, #4
loc_4ba0:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_4ba4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r6, r1
	mov r4, r2
	mov r5, r3
	ldmib fp, {r8, sl}
	sub sp, sp, #4
	ldr r1, [r1, #0x40]
	mov r1, r1, asr #16
	mov r0, #0x81
	add r0, r0, #0x200
	cmp r1, #0
	ble sub_4cac
	ldr sb, [r4, #0xc]
	ldr r1, [sb, #0xc]
	teq r1, #4
	bne sub_4cac
	ldr r0, [r5, #0xc]
	add r0, r0, r8
	add r0, r0, #2
	mov r1, #0
	bl sub_76a0
	mov r3, r8
	stmdb sp!, {r3}
	mov r3, sl
	mov r0, r5
	mov r2, #0
	mov r1, #0
	bl sub_7560
	mov r1, r0
	add sp, sp, #4
	ldr r0, [r5, #0xc]!
	add r0, r0, r8
	add r0, r0, #2
	bl sub_76a0
	ldr r0, [r4, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, #0xc
	mov r0, sp
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, #0x10
	add r0, r0, #0xc
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #8]
	ldr r0, [r0, #0xc]
	add r0, r0, #0x10
	mov r1, sp
	mov r2, #4
	bl memcpy
	mov r3, #0
	stmdb sp!, {r3}
	ldr r0, [r4, #0xc]
	ldr r1, [sb, #0x10]!
	ldr r3, [r0, r1]
	mov r2, r4
	mov r1, r6
	mov r0, r7
	bl sub_2efc
	add sp, sp, #4
	mov r0, #0x81

sub_4cac:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_4cb0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0xc
	add r1, r2, #0x18
	add r0, sp, #8
	mov r2, #4
	bl memcpy
	ldr r0, [r6]
	mov r0, r0, lsr #16
	add r0, r4, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [sp, #8]
	bl sub_7514
	movs r7, r0
	beq loc_4e2c
	ldrb r0, [r5]
	teq r0, #3
	beq loc_4d50
	teq r0, #0xb
	beq loc_4d40
	add r1, r5, #4
	add r0, sp, #4
	mov r2, #4
	bl memcpy
	ldr r0, [r6]
	mov r0, r0, lsr #16
	add r0, r4, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [sp, #4]
	bl sub_7514
	movs r1, r0
	bne loc_4dc4
loc_4d40:
	mov r1, r7
	mov r0, r4
	bl sub_6930
	b loc_4e2c
loc_4d50:
	mov r2, r7
	ldr r1, [r4, #0x6c]
	mov r0, r4
	bl sub_6bc0
	teq r0, #0
	beq loc_4e2c
	ldrb r0, [r5, #1]
	teq r0, #4
	bne loc_4db0
	add r0, r5, #6
	bl sub_7668
	str r0, [sp]
	teq r0, #0
	moveq r0, #0x10000
	subeq r0, r0, #1
	streq r0, [sp]
	ldr r3, [sp]
	ldr r2, [r6]
	mov r2, r2, lsr #16
	stmdb sp!, {r2, r3}
	ldr r0, [r6, #0x2c]!
	ldr r3, [r0, #0x3c]!
	ldr r2, [sp, #0x10]
	b loc_4e1c
loc_4db0:
	mov r2, r7
	ldr r1, [r4, #0x6c]
	mov r0, r4
	bl sub_6c10
	b loc_4e2c
loc_4dc4:
	mov r3, sp
	add r2, sp, #4
	mov r0, r4
	bl sub_64b8
	mov r5, r0
	teq r0, #4
	moveq r1, r7
	moveq r0, r4
	bleq sub_6930
	add r0, r4, r5, lsl #2
	ldr r6, [r0, #0x40]!
	teq r6, #0
	moveq r1, r7
	moveq r0, r4
	bleq sub_6930
	ldr r3, [r6, #0x32]
	mov r3, r3, lsr #16
	mov r2, r5
	stmdb sp!, {r2, r3}
	ldr r0, [r6, #0x2c]!
	ldr r3, [r0, #0x3c]!
	ldr r2, [sp, #0xc]
loc_4e1c:
	mov r1, r7
	mov r0, r4
	bl sub_667c
	add sp, sp, #8
loc_4e2c:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_4e30:
	ldr r0, [r2, #0xc]!
	ldr r0, [r0, #0xc]
	strb r0, [r1, #0x15]
	mov r0, r0, asr #8
	strb r0, [r1, #0x14]
	mov r0, #0x13
	mov pc, lr

sub_4e4c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #4
	ldr r0, [r1, #0x28]
	teq r0, #0
	moveq r0, #7
	addeq r0, r0, #0x200
	beq sub_4f5c
	ldr r0, [r4, #0x70]
	cmp r0, #8
	movlo r0, #0xb
	addlo r0, r0, #0x200
	blo sub_4f5c
	ldr r1, [r4, #0x2c]
	ldr r1, [r1, #0x44]
	teq r1, #0
	bne loc_4ed0
	ldr r3, [r4, #0x6c]
	stmdb sp!, {r3}
	mov r3, r0
	mov r2, #0
	mov r1, #0
	ldr r0, [r6, #8]
	bl sub_7560
	add sp, sp, #4
	teq r0, #0
	movne r0, #0xa
	addne r0, r0, #0x200
	bne sub_4f5c
loc_4ed0:
	ldr r0, [r6, #8]
	ldr r1, [r0, #0xc]!
	ldr r0, [r4, #0x6c]
	ldrb r0, [r1, r0]!
	and r2, r0, #0xf0
	teq r2, #0x10
	bne loc_4f44
	and r0, r0, #0xf
	teq r0, #1
	beq loc_4f60
	teq r0, #2
	bne loc_4f44
	add r1, r1, #4
	mov r0, sp
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #0x80]
	ldr r2, [sp]
	teq r0, r2
	bne loc_4f44
	mov r1, r4
	mov r0, r5
	bl sub_5328
	teq r0, #0
	beq loc_4f44
	mov r2, r0
	mov r1, r4
	mov r0, r5
	bl sub_5410
loc_4f44:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_2bc4
	and r0, r0, #0x200
	orr r0, r0, #0x82

sub_4f5c:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_4f60:
	ldr r8, [r4, #0x8c]
	teq r8, #0
	beq loc_4f44
	ldr sb, lit_4fc8
loc_4f70:
	ldr r0, [r8, #8]
	teq r0, #0
	ldrbeq r0, [r8, #1]
	teqeq r0, #0
	bne loc_4fb8
	mov r2, r8
	mov r1, r4
	mov r0, r5
	bl sub_4fcc
	mov r7, r0
	mov r0, sb
	bl sub_11bfc
	mov r1, r0
	mov r2, r8
	mov r0, r5
	mov r3, r7
	bl sub_8924
	str r0, [r8, #8]
loc_4fb8:
	ldr r8, [r8, #0xc]
	teq r8, #0
	bne loc_4f70
	b loc_4f44
lit_4fc8:
	.rword sub_5484				; relocated

sub_4fcc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0
	add r3, r1, #0x28
	mov r1, #0

sub_4fe4:
	ldrb ip, [r3], #1
	add r0, ip, r0
	add r1, r1, #1
	cmp r1, #4
	blo sub_4fe4
	add r2, r2, #4
	mov r1, #0

sub_5000:
	ldrb r3, [r2], #1
	add r0, r3, r0
	add r1, r1, #1
	cmp r1, #4
	blo sub_5000
	mov r1, r0
	mov r0, #0x64
	bl __rt_udiv
	add r0, r1, #1
	ldmdb fp, {fp, sp, pc}

sub_5028:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r6, r2
	mov r5, r3
	mov r3, #1
	mov r2, #0x10
	mov r1, #0
	bl sub_70ec
	mov r7, r0
	ldr r0, [r0, #0xc]
	mov r1, #4
	str r1, [r0, #4]
	mov r1, #0xc
	str r1, [r0, #8]
	str r6, [r0]
	ldr r0, [r7, #0xc]
	str r5, [r0, #0xc]!
	mov r0, #1
	strb r0, [r4, #0x23]
	mov r5, #0
	strb r5, [r4, #0x22]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	ldreq r0, [r4, #0x38]
	teqeq r0, #0
	bne loc_50b8
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r7
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	ldr pc, [r2]
loc_50b8:
	ldr r0, [r4, #0x38]
	teq r0, #0
	ldrne r0, [r4, #0x3c]
	strne r7, [r0]
	streq r7, [r4, #0x38]
	str r7, [r4, #0x3c]
	str r5, [r7]
	ldr r0, [r4, #0x40]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x41]
	mov r0, r0, asr #8
	strb r0, [r4, #0x40]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_50f0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r6, [r2, #0xc]!
	ldr r0, [r6, #8]
	cmp r0, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	add r0, r4, r0, lsl #2
	ldr r5, [r0, #0x40]!
	mvn r0, #0xe
	teq r5, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r1, [r5, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, [r5, #0x28]
	teq r0, #0
	mvneq r0, #0x1e
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r7, [r6, #4]
	ldr r0, [r5]
	mov r0, r0, lsr #16
	add r0, r4, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	mov r0, r7
	bl sub_7460
	mvn r1, #0x16
	teq r0, #5
	bne loc_519c
	ldrb r0, [r6, #4]
	teq r0, #0xe0
	ldrbeq r0, [r6, #5]
	teqeq r0, #0
	ldrbeq r0, [r6, #6]
	teqeq r0, #0
	bne loc_51a4
	ldrb r0, [r6, #7]
	teq r0, #0
	teqne r0, #1
	bne loc_51a4
loc_519c:
	mov r0, r1
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_51a4:
	mov r2, r7
	mov r1, r5
	mov r0, r4
	bl sub_5328
	mov r8, #0x13
	teq r0, #0
	ldrbne r1, [r0, #2]
	addne r1, r1, #1
	strbne r1, [r0, #2]
	bne loc_5270
	mov r0, #0x14
	bl sub_7b9c
	movs r6, r0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r0, r6
	mov r2, #0x14
	mov r1, #0
	bl memset
	ldr r0, [r5, #0x8c]
	teq r0, #0
	streq r6, [r5, #0x8c]
	beq loc_5210
	ldr r0, [r5, #0x90]
	str r6, [r0, #0xc]!
	ldr r0, [r5, #0x90]
	str r0, [r6, #0x10]
loc_5210:
	mov r0, #1
	str r6, [r5, #0x90]
	strb r0, [r6, #2]
	ldr r0, [r5]
	mov r0, r0, lsr #16
	strb r0, [r6]
	str r7, [r6, #4]
	mov r3, r7
	mov r1, r5
	mov r0, r4
	mov r2, #0x1d
	bl sub_5028
	mov r2, r7
	mov r1, r5
	mov r0, r4
	bl sub_5544
	ldr r0, lit_5278
	bl sub_11bfc
	mov r1, r0
	mov r2, r6
	mov r0, r4
	mov r3, #0xa
	bl sub_8924
	str r0, [r6, #8]!
loc_5270:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_5278:
	.rword sub_5484				; relocated

sub_527c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r2, #0xc]!
	ldr r1, [r0, #8]
	cmp r1, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	add r1, r4, r1, lsl #2
	ldr r5, [r1, #0x40]!
	teq r5, #0
	mvneq r0, #0xe
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r1, [r5, #0x28]
	teq r1, #0
	mvneq r0, #0x1e
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r2, [r0, #4]!
	mov r8, r2
	mov r1, r5
	mov r0, r4
	bl sub_5328
	movs r6, r0
	mvneq r0, #0x16
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldrb r0, [r6, #2]
	sub r0, r0, #1
	ands r0, r0, #0xff
	strb r0, [r6, #2]
	mov r7, #0x13
	bne loc_5320
	mov r3, r8
	mov r1, r5
	mov r0, r4
	mov r2, #0x1e
	bl sub_5028
	mov r2, r6
	mov r1, r5
	mov r0, r4
	bl sub_5354
loc_5320:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_5328:
	ldr r0, [r1, #0x8c]!
	teq r0, #0
	beq loc_534c
loc_5334:
	ldr r1, [r0, #4]
	teq r1, r2
	moveq pc, lr
	ldr r0, [r0, #0xc]
	teq r0, #0
	bne loc_5334
loc_534c:
	mov r0, #0
	mov pc, lr

sub_5354:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl sub_5410
	ldr r0, [r4, #0x10]
	teq r0, #0
	ldrne r1, [r4, #0xc]
	strne r1, [r0, #0xc]!
	ldreq r0, [r4, #0xc]
	streq r0, [r5, #0x8c]
	ldr r0, [r4, #0xc]
	teq r0, #0
	ldrne r1, [r4, #0x10]
	strne r1, [r0, #0x10]!
	ldreq r0, [r4, #0x10]
	streq r0, [r5, #0x90]!
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_7be0

sub_53a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, #0
	mov r8, #0
	ldr r6, [r1, #0x84]

sub_53c8:
	ldr r0, [r6]
	teq r0, #0
	beq loc_53fc
	strb r8, [r0, #1]
	ldr r0, [r6]
	mov r1, r4
	ldr r2, [r0, #4]!
	mov r0, r5
	bl sub_5544
	str r8, [r6]
	ldr r0, [r4, #0x88]
	sub r0, r0, #1
	str r0, [r4, #0x88]
loc_53fc:
	add r7, r7, #1
	add r6, r6, #4
	cmp r7, #8
	blt sub_53c8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_5410:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	mov r6, #0
	ldr r1, [r2, #8]
	teq r1, #0
	beq loc_543c
	bl sub_8a04
	str r6, [r4, #8]
loc_543c:
	ldrb r0, [r4, #1]
	teq r0, #1
	bne loc_547c
	mov r1, #0
	ldr r0, [r5, #0x84]

sub_5450:
	ldr r2, [r0]
	teq r2, r4
	streq r6, [r0]
	beq loc_5470
	add r1, r1, #1
	add r0, r0, #4
	cmp r1, #8
	blt sub_5450
loc_5470:
	ldr r0, [r5, #0x88]
	sub r0, r0, #1
	str r0, [r5, #0x88]!
loc_547c:
	strb r6, [r4, #1]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_5484:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r6, r0
	mov r5, r1
	ldr r0, [r1, #8]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r0, #0
	str r0, [r5, #8]
	ldrb r0, [r5]
	add r0, r6, r0, lsl #2
	ldr r0, [r0, #0x40]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r1, [r0, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r2, #0
	ldr r1, [r0, #0x84]

sub_54dc:
	ldr r3, [r1]
	teq r3, #0
	bne loc_550c
	str r5, [r1]
	mov r1, #1
	strb r1, [r5, #1]
	ldr r1, [r0, #0x88]
	add r1, r1, #1
	str r1, [r0, #0x88]
	ldr r0, [r0, #0xc]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_84a0
loc_550c:
	add r2, r2, #1
	add r1, r1, #4
	cmp r2, #8
	blt sub_54dc
	ldr r0, lit_5540
	bl sub_11bfc
	mov r1, r0
	mov r2, r4
	mov r0, r6
	mov r3, #0xa
	bl sub_8924
	str r0, [r5, #8]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_5540:
	.rword sub_5484				; relocated

sub_5544:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0
	mov r2, #8
	mov r1, #0
	ldr r0, [fp, #-0x20]
	bl sub_70ec
	mov r5, r0
	ldr r0, [r0, #0xc]
	mov r4, r0
	mov r2, #8
	mov r1, #0
	bl memset
	mov r0, #0x12
	strb r0, [r4]
	add r0, r4, #4
	sub r1, fp, #0x18
	mov r2, #4
	bl memcpy
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #8
	mov r2, #0
	mov r1, #0
	bl sub_7560
	mov r1, r0
	add sp, sp, #4
	add r0, r4, #2
	bl sub_76a0
	mov r3, #0
	mov r2, #8
	mov r1, #2
	ldr r0, [fp, #-0x18]
	stmdb sp!, {r0, r1, r2, r3}
	ldr r1, [fp, #-0x1c]
	mov r2, r5
	ldr r3, [r1, #0x28]
	ldr r0, [fp, #-0x20]
	bl sub_2ff4
	add sp, sp, #0x10
	mov r3, #0
	stmdb sp!, {r3}
	mov r2, r0
	sub r3, fp, #0x20
	ldmia r3, {r0, r1, r3}
	bl sub_2efc
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_5608:
	mov r2, r0
	ldr r1, lit_5618
	mov r0, #0xcc
	b sub_7bf4
lit_5618:
	.word 0x49502020			; 'IP  '

sub_561c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #1
	str r0, [r4, #0x14]
	add r7, r4, #0x78
	mov r6, #0
	mvn r5, #0

sub_5640:
	mov r0, r4
	mov r2, #1
	mov r1, #0x20
	bl sub_7c44
	str r0, [r7], #4
	teq r0, #0
	beq loc_569c
	add r6, r6, #1
	cmp r6, #4
	blt sub_5640
	mov r0, #0x1c
	bl sub_7b9c
	str r0, [r4, #0x6c]
	teq r0, #0
	beq loc_569c
	mov r2, #0x1c
	mov r1, #0
	bl memset
	mov r0, #0x80
	bl sub_7b9c
	str r0, [r4, #0x70]
	teq r0, #0
	bne loc_56a4
loc_569c:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_56a4:
	mov r2, #0x80
	mov r1, #0
	bl memset
	mov r0, #4
	strb r0, [r4, #0x91]
	mov r0, #0
	strb r0, [r4, #0x90]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_56c4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r1, [r0, #0x6c]
	bl sub_59c8
	ldr r0, [r4, #0x70]
	teq r0, #0
	blne sub_7be0
	add r5, r4, #0x78
	mov r6, #0

sub_56f0:
	ldr r1, [r5]
	teq r1, #0
	movne r0, r4
	blne sub_7ed0
	add r5, r5, #4
	add r6, r6, #1
	cmp r6, #4
	blt sub_56f0
	ldr r1, [r4, #0x8c]
	teq r1, #0
	movne r0, r4
	blne sub_8a04
	mov r0, r4
	mov r1, #0xcc
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_7c34

sub_5730:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0x6c
	bl sub_7b9c
	movs r5, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r5
	mov r2, #0x6c
	mov r1, #0
	bl memset
	add r1, r4, #0x20
	mov r2, r5
	mov r0, r4
	mov r3, #1
	bl sub_7210
	mov r0, #0
	strb r0, [r5, #0x15]
	mov r0, #4
	strb r0, [r5, #0x14]
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_5790:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_72bc
	ldr r0, [r5]
	mov r0, r0, lsr #16
	mov r7, #0
	teq r0, #3
	bne loc_57e8
	ldr r6, [r4, #0x6c]
	ldr r1, [r6, #0x14]
	teq r1, #0
	movne r0, r4
	blne sub_59c8
	ldr r1, [r6, #0x18]
	teq r1, #0
	movne r0, r4
	blne sub_59c8
	str r7, [r6, #0x14]
	str r7, [r6, #0x18]!
loc_57e8:
	ldr r0, [r5]
	mov r0, r0, lsr #16
	cmp r0, #3
	addle r0, r4, r0, lsl #2
	strle r7, [r0, #0x5c]!
	mov r6, #0

sub_5800:
	add r0, r4, r6, lsl #3
	add r1, r0, #0x18
	mov r3, r6
	mov r2, r5
	mov r0, r4
	bl sub_7264
	add r6, r6, #1
	cmp r6, #4
	blo sub_5800
	ldr r0, [r5, #0x1c]
	teq r0, #0
	beq loc_5844
	add r1, r0, #0x64
	mov r2, r5
	mov r0, r4
	mov r3, #4
	bl sub_7264
loc_5844:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_7be0

sub_5850:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0x94
	bl sub_7b9c
	movs r5, r0
	mov r6, #0
	bne loc_587c
loc_5874:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_587c:
	mov r0, r5
	mov r2, #0x94
	mov r1, #0
	bl memset
	mov r0, #4
	strb r0, [r5, #1]
	strb r6, [r5]
	mov r0, #0x20
	bl sub_7b9c
	str r0, [r5, #0x84]
	teq r0, #0
	bne loc_58bc
	mov r1, r5
	mov r0, r4
	bl sub_58d0
	b loc_5874
loc_58bc:
	mov r2, #0x20
	mov r1, #0
	bl memset
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_58d0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r1]
	mov r1, r1, lsr #16
	teq r1, #4
	movne r2, #0
	addne r0, r0, r1, lsl #2
	strne r2, [r0, #0x40]!
	ldr r0, [r4, #0x2c]
	teq r0, #0
	blne sub_7be0
	ldr r0, [r4, #0x84]
	teq r0, #0
	blne sub_7be0
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_7be0

sub_591c:
	stmdb sp!, {lr}
	ldr r3, lit_5978
	add r1, r0, #0x54
	mov r2, #0

sub_592c:
	ldrb ip, [r1]
	teq ip, #0xff
	beq loc_5988
	mov r0, #0

sub_593c:
	teq r2, #0
	bne loc_594c
	cmp r0, #3
	bls sub_597c
loc_594c:
	add lr, r3, r0
	ldrb lr, [lr, #0x80]
	tst lr, ip
	bne sub_597c
	add r3, r3, r0
	ldrb r3, [r3, #0x80]
	ldrb ip, [r1]
	orr r3, r3, ip
	strb r3, [r1]
	add r0, r0, r2, lsl #3
	ldmia sp!, {pc}
lit_5978:
	.rword data_11730			; relocated

sub_597c:
	add r0, r0, #1
	cmp r0, #8
	blo sub_593c
loc_5988:
	add r2, r2, #1
	add r1, r1, #1
	cmp r2, #8
	blo sub_592c
	mvn r0, #0
	ldmia sp!, {pc}

sub_59a0:
	ldr r2, lit_59c4
	add r0, r0, r1, lsr #3
	ldrb r3, [r0, #0x54]
	and r1, r1, #7
	add r1, r1, r2
	ldrb r1, [r1, #0x80]
	bic r1, r3, r1
	strb r1, [r0, #0x54]
	mov pc, lr
lit_59c4:
	.rword data_11730			; relocated

sub_59c8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x14]
	teq r1, #0
	movne r0, r5
	blne sub_59c8
	ldr r1, [r4, #0x18]
	teq r1, #0
	movne r0, r5
	blne sub_59c8
	mov r1, r4
	mov r0, r5
	bl sub_6a24
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_7be0

sub_5a14:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	ldr r7, [r2, #0xc]
	ldr r0, [r1]
	movs r0, r0, lsr #16
	mvnne r0, #7
	bne loc_5a84
	ldr r0, [r7]
	sub ip, r0, #0x5300
	teq ip, #0xc
	beq loc_5a6c
	sub ip, r0, #0x5300
	teq ip, #0xd
	bne loc_5a80
	mov r1, r4
	mov r0, r5
	bl sub_5b54
	b loc_5a84
loc_5a6c:
	ldr r0, [r4, #8]
	ldr r1, [r0, #0xc]!
	mov r0, r5
	bl sub_5ad8
	b loc_5a84
loc_5a80:
	mvn r0, #0xb
loc_5a84:
	mov r8, #0
	teq r0, #1
	str r8, [r7, #0xc]
	moveq r1, #0x81
	ldreq r0, [r4, #0x18]
	strbeq r1, [r0, #9]
	beq loc_5ab0
	str r0, [r7, #0x10]!
	mov r0, #0x82
	ldr r1, [r4, #0x18]
	strb r0, [r1, #9]
loc_5ab0:
	mov r0, r5
	ldr r1, [r4, #8]
	bl sub_7ed0
	str r8, [r4, #8]
	ldr r0, [r6, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	ldr pc, [r2]

sub_5ad8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_5850
	teq r0, #0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r5, #8]
	str r1, [r0, #4]
	ldr r1, [r5, #4]!
	str r1, [r0, #8]
	ldr r2, [r1, #0x30]
	str r2, [r0, #0xc]
	str r0, [r1, #0x18]!
	ldr r1, [r0, #0xc]
	str r0, [r1, #0x18]!
	ldr r1, [r4, #0x50]
	teq r1, #0
	beq loc_5b48
loc_5b2c:
	ldr r2, [r1, #0x14]
	teq r2, #0
	movne r1, r2
	bne loc_5b2c
	str r0, [r1, #0x14]
	teq r1, #0
	bne loc_5b4c
loc_5b48:
	str r0, [r4, #0x50]!
loc_5b4c:
	mov r0, #1
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_5b54:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r1, #8]!
	ldr r0, [r0, #0xc]
	ldr r1, [r0, #8]!
	mov r8, r1
	mov r0, r4
	bl sub_5d6c
	mov r7, #0
	mov r6, #1
	teq r0, #0
	beq loc_5ba4
	ldr r1, [r0, #8]
	str r7, [r1, #0x18]!
	ldr r1, [r0, #0xc]
	str r7, [r1, #0x18]!
	mov r1, r0
	b loc_5c00
loc_5ba4:
	add r1, r4, #0x40
	mov r0, #0

sub_5bac:
	ldr r5, [r1], #4
	teq r5, #0
	beq loc_5bc4
	ldr r2, [r5, #4]
	teq r2, r8
	beq loc_5bd0
loc_5bc4:
	add r0, r0, #1
	cmp r0, #4
	blo sub_5bac
loc_5bd0:
	teq r0, #4
	bne loc_5be0
loc_5bd8:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_5be0:
	mov r1, r5
	mov r0, r4
	bl sub_351c
	ldr r0, [r5, #8]
	str r7, [r0, #0x18]!
	ldr r0, [r5, #0xc]
	mov r1, r5
	str r7, [r0, #0x18]!
loc_5c00:
	mov r0, r4
	bl sub_58d0
	b loc_5bd8

sub_5c0c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	sub sp, sp, #4
	ldr r7, [r2, #0xc]
	ldr r0, [r7, #8]
	str r0, [sp]
	cmp r0, #4
	mvnhs r0, #0xa
	bhs loc_5d68
	ldr r0, [sp]
	add r8, r4, r0, lsl #2
	ldr r0, [r8, #0x40]
	teq r0, #0
	mvnne r0, #0xc
	bne loc_5d68
	mov r0, #0x50
	bl sub_7b9c
	movs sl, r0
	mvneq r0, #0
	beq loc_5d68
	mov r0, r4
	ldr r1, [r7, #4]
	bl sub_5d6c
	movs r6, r0
	bne loc_5c8c
	mov r0, sl
	bl sub_7be0
	mvn r0, #0xd
	b loc_5d68
loc_5c8c:
	ldr sb, [r7, #0xc]
	mov r0, sb
	ldr r1, [r8, #0xbc]
	bl sub_7460
	teq r0, #0
	teqne r0, #1
	beq loc_5cb8
	mov r0, sl
	bl sub_7be0
	mvn r0, #0x16
	b loc_5d68
loc_5cb8:
	ldr r0, [sp]
	strb r0, [r6, #1]
	mov r0, r0, lsr #8
	strb r0, [r6]
	mov r2, sl
	mov r1, r5
	mov r0, r4
	mov r3, #0x50
	str r6, [r8, #0x40]
	bl sub_7938
	add r6, r6, #0x28
	stmia r6, {sb, sl}
	sub r6, r6, #0x28
	ldr r0, [r7, #0x10]
	strb r0, [r6, #0x31]
	mov r0, r0, asr #8
	strb r0, [r6, #0x30]
	ldr r0, [r7, #0x14]
	strb r0, [r6, #0x33]
	mov r0, r0, asr #8
	strb r0, [r6, #0x32]
	ldr r0, [r7, #0x24]
	strb r0, [r6, #0x41]
	mov r0, r0, asr #8
	strb r0, [r6, #0x40]
	ldr r0, [r7, #0x18]
	strb r0, [r6, #0x35]
	mov r0, r0, asr #8
	strb r0, [r6, #0x34]
	str sb, [r8, #0x9c]
	mov r0, sb
	ldr r1, [r8, #0xbc]
	bl sub_7514
	str r0, [r8, #0xac]!
	ldr r0, [r7, #0x4c]!
	cmn r0, #1
	mov r2, r5
	mov r1, r6
	mov r0, r4
	beq loc_5d60
	bl sub_31fc
	b loc_5d64
loc_5d60:
	bl sub_3274
loc_5d64:
	mov r0, #1
loc_5d68:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_5d6c:
	mov r3, #0
	ldr r2, [r0, #0x50]
	teq r2, #0
	beq loc_5db0
loc_5d7c:
	ldr ip, [r2, #4]
	teq ip, r1
	bne loc_5da0
	teq r3, #0
	ldreq r1, [r2, #0x14]
	streq r1, [r0, #0x50]!
	ldrne r0, [r2, #0x14]
	strne r0, [r3, #0x14]!
	b loc_5db0
loc_5da0:
	mov r3, r2
	ldr r2, [r2, #0x14]
	teq r2, #0
	bne loc_5d7c
loc_5db0:
	mov r0, r2
	mov pc, lr

sub_5db8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r3, [r2, #0xc]
	ldr ip, [r3, #4]
	cmp ip, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {fp, sp, pc}
	add r0, r0, ip, lsl #2
	ldr r0, [r0, #0x40]
	teq r0, #0
	moveq r0, #0
	ldrne r0, [r0, #0x20]
	movne r0, r0, lsr #16
	str r0, [r3, #8]
	mov r0, #0x300
	str r0, [r3]
	mov r3, #0x83
	ldr r0, [r2, #0x18]
	strb r3, [r0, #9]
	ldr r0, [r1, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r2
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {fp, sp, pc}

sub_5e28:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0xc
	ldr r4, [r0, #0x64]
	teq r4, #0
	beq loc_5ea0
	mov r2, #1
	add r2, r2, #0x300
	str r2, [sp]
	ldr r2, [r1]
	mov r2, r2, lsr #16
	str r2, [sp, #4]
	ldr r1, [r1, #0x20]
	mov r1, r1, lsr #16
	str r1, [sp, #8]
	mov r2, sp
	mov r3, #0xc
	mov r1, #0
	bl sub_7b2c
	movs r1, r0
	beq loc_5ea0
	mov r0, #0x83
	ldr r2, [r1, #0x18]
	strb r0, [r2, #9]
	ldr r0, [r4, #0xc]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_5ea0:
	ldmdb fp, {r4, fp, sp, pc}

sub_5ea4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	ldr r7, [r1, #0x1c]
	ldr r0, [r7, #0x28]
	teq r0, #0
	ldreq r0, [r7, #0x20]
	moveq r0, r0, lsr #16
	teqeq r0, #4
	bne loc_5fa8
	ldr sb, [r5, #0xc]
	ldr r1, [sb, #0x1c]
	teq r1, #0
	ldr r8, [sb, #4]
	ldreq r0, [r7]
	moveq r0, r0, lsr #16
	addeq r0, r4, r0, lsl #2
	ldreq r1, [r0, #0xbc]!
	mov sl, r1
	mov r0, r8
	bl sub_7460
	teq r0, #0
	bne loc_5fa8
	str r8, [r7, #0x28]
	str r8, [r6, #0x18]!
	ldr r0, [r7]
	mov r0, r0, lsr #16
	add r0, r4, r0, lsl #2
	str r8, [r0, #0x9c]!
	ldr r0, [r7]
	mov r0, r0, lsr #16
	add r0, r4, r0, lsl #2
	str sl, [r0, #0xbc]!
	mov r1, sl
	mov r0, r8
	bl sub_7514
	ldr r1, [r7]
	mov r1, r1, lsr #16
	add r1, r4, r1, lsl #2
	str r0, [r1, #0xac]!
	ldr r0, [sb, #8]
	teq r0, #0
	strbne r0, [r7, #0x31]
	movne r0, r0, asr #8
	strbne r0, [r7, #0x30]
	ldr r0, [sb, #0xc]
	teq r0, #0
	strbne r0, [r7, #0x33]
	movne r0, r0, asr #8
	strbne r0, [r7, #0x32]
	ldr r0, [sb, #0x10]!
	teq r0, #0
	strbne r0, [r7, #0x35]
	movne r0, r0, asr #8
	strbne r0, [r7, #0x34]
	ldr r0, [r7, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_5fb4
loc_5fa8:
	mov r1, r5
	mov r0, r4
	bl sub_7ed0
loc_5fb4:
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_5fbc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	ldr r0, [r2, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0x8a
	moveq r3, #6
	beq loc_6080
	ldr r0, [r5, #0xc]
	ldr r0, [r0]
	sub r0, r0, #3
	mov r7, #0
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b loc_607c
	b loc_6024
	b loc_602c
	b loc_6048
	b loc_6034
	b loc_607c
	b loc_6074

sub_601c:
	mov r3, #4
	b loc_6080
loc_6024:
	mov r3, #0
	b loc_6080
loc_602c:
	mov r3, #1
	b loc_6080
loc_6034:
	ldr r0, [r4, #0x22]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_607c
	b loc_605c
loc_6048:
	ldr r0, [r4, #0x22]
	mov r0, r0, lsr #16
	teq r0, #1
	movne r3, #2
	bne loc_6080
loc_605c:
	mov r1, r5
	mov r0, r6
	bl sub_7ed0
	strb r7, [r4, #0x23]
	strb r7, [r4, #0x22]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_6074:
	mov r3, #3
	b loc_6080
loc_607c:
	mov r3, #5
loc_6080:
	ldr ip, lit_6124
	mov r2, r5
	mov r1, r4
	mov r0, r6
	add r3, ip, r3, lsl #2
	mov lr, pc
	ldr pc, [r3, #0x88]
	mov r1, r0
	ldr r0, [r4, #0x74]
	teq r0, #1
	teqne r0, #2
	beq loc_619c
	ldr r0, [r4, #0x7c]
	teq r0, #0
	andeq r0, r1, #0x80
	teqeq r0, #0
	bne loc_619c
	mov r0, #0
	mov r3, #0
	and r2, r1, #0x7f
	sub r2, r2, #8
	cmp r2, #0xe
	addls pc, pc, r2, lsl #2
	b loc_6178
	b loc_6128
	b loc_6128
	b loc_6128
	b loc_6128
	b loc_6134
	b loc_6168
	b loc_6128
	b loc_6128
	b loc_6128
	b loc_6170
	b loc_6144
	b loc_6150
	b loc_615c
	b loc_613c

sub_6118:
	mov r0, #3
	mov r3, #4
	b loc_6180
lit_6124:
	.rword data_11730			; relocated
loc_6128:
	mov r0, #0xc
	ldr r3, [r4, #0x78]
	b loc_6180
loc_6134:
	mov r0, #3
	b loc_6180
loc_613c:
	mov r0, #5
	b loc_6180
loc_6144:
	mov r0, #3
	mov r3, #5
	b loc_6180
loc_6150:
	mov r0, #3
	mov r3, #2
	b loc_6180
loc_615c:
	mov r0, #3
	mov r3, #3
	b loc_6180
loc_6168:
	mov r0, #4
	b loc_6180
loc_6170:
	mov r0, #0xb
	b loc_6180
loc_6178:
	teq r0, #0
	beq loc_619c
loc_6180:
	stmdb sp!, {r3}
	mov r3, r0
	mov r2, r5
	mov r1, r4
	mov r0, r6
	bl sub_4984
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_619c:
	tst r1, #0x200
	movne r1, r5
	movne r0, r6
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, lr}
	bne sub_7ed0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_61b4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r0, #1
	str r0, [r1, #0x7c]
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	mov r7, #7
	add r7, r7, #0x300
	teq r0, #4
	bne loc_6204
	mov r1, r6
	mov r0, r5
	mov r2, #0
	bl sub_7860
	movs r8, r0
	bne loc_620c
loc_6204:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_620c:
	ldr sl, [r6, #8]
	ldr sb, [sl, #0xc]
	ldrb r2, [sb]
	and r0, r2, #0xf0
	mov r1, #0
	teq r0, #0x40
	movne r0, #9
	addne r0, r0, #0x300
	strne r1, [r4, #0x78]!
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, #0x308
	cmp r8, #0x14
	strlo r8, [r4, #0x78]!
	ldmdblo fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	and r2, r2, #0xf
	mov r2, r2, lsl #2
	str r2, [r4, #0x6c]
	cmp r2, #0x14
	strlo r1, [r4, #0x78]!
	ldmdblo fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	add r0, sb, #2
	bl sub_7668
	mov r7, r0
	cmp r0, r8
	bhi loc_627c
	ldr r0, [r4, #0x6c]
	cmp r0, r7
	blo sub_6290
loc_627c:
	mov r0, #2
	str r0, [r4, #0x78]!
	mov r0, #0xb
	add r0, r0, #0x300
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_6290:
	teq r7, r8
	beq loc_62a8
	mov r2, r7
	mov r1, sl
	mov r0, r5
	bl sub_77f8
loc_62a8:
	ldr r0, [r4, #0x6c]
	sub r1, r7, r0
	str r1, [r4, #0x70]
	ldr r1, [r4, #0x2c]
	ldr r1, [r1, #0x44]
	teq r1, #0
	bne loc_62fc
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, r0
	mov r0, sl
	mov r2, #0
	mov r1, #0
	bl sub_7560
	add sp, sp, #4
	teq r0, #0
	movne r0, #0xa
	strne r0, [r4, #0x78]!
	movne r0, #0xa
	addne r0, r0, #0x300
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_62fc:
	add r1, sb, #0x10
	add r0, r4, #0x80
	mov r2, #4
	bl memcpy
	ldr r0, [r4]
	mov r0, r0, lsr #16
	add r0, r5, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [r4, #0x80]
	bl sub_7460
	str r0, [r4, #0x7c]
	teq r0, #1
	teqne r0, #2
	moveq r0, #0xe
	addeq r0, r0, #0x300
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_696c
	ldrb r0, [sb, #9]
	str r0, [r4, #0x74]
	teq r0, #1
	beq loc_637c
	teq r0, #2
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	beq sub_4e4c
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	bne sub_2bc4
loc_637c:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	b sub_47c0

sub_6390:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #8
	ldr r7, [r1, #0x1c]
	ldr r8, [r2, #0xc]
	ldr r0, [r8, #8]
	str r0, [sp, #4]
	ldr r1, [r7]
	mov r1, r1, lsr #16
	add r1, r4, r1, lsl #2
	ldr r1, [r1, #0xbc]
	bl sub_7460
	teq r0, #0
	beq loc_6404
	teq r0, #3
	beq loc_63f4
	teq r0, #4
	beq loc_6404
	teq r0, #5
	mvnne r0, #0x16
	bne loc_645c
loc_63f4:
	ldr r0, [r7, #0x32]
	mov r0, r0, lsr #16
	str r0, [sp]
	b loc_6460
loc_6404:
	ldr r0, [r7]
	mov r0, r0, lsr #16
	add r0, r4, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [sp, #4]
	bl sub_7514
	mov r1, r0
	mov r3, sp
	add r2, sp, #4
	mov r0, r4
	bl sub_64b8
	teq r0, #4
	beq loc_6460
	add r0, r4, r0, lsl #2
	ldr r7, [r0, #0x40]!
	mvn r0, #0xe
	teq r7, #0
	beq loc_645c
	ldr r1, [r7, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	beq loc_6460
loc_645c:
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_6460:
	ldr r0, [sp]
	teq r0, #0
	ldreq r0, [r7, #0x32]
	moveq r0, r0, lsr #16
	streq r0, [sp]
	ldr r0, [sp]
	sub r0, r0, #0x14
	str r0, [r8, #0xc]
	mov r0, #3
	add r0, r0, #0x300
	mov r1, #0x83
	str r0, [r8]
	ldr r0, [r5, #0x18]
	strb r1, [r0, #9]
	ldr r0, [r6, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	b loc_645c

sub_64b8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r2
	mov r5, r3
	mov r0, #0
	str r0, [r3]

sub_64d8:
	add r2, r4, r0, lsl #2
	ldr r2, [r2, #0xac]
	teq r2, r1
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	add r0, r0, #1
	cmp r0, #4
	blo sub_64d8
	mov r2, r1
	ldr r3, [r4, #0x6c]
	mov r0, r4
	mov r1, r3
	bl sub_6bc0
	teq r0, #0
	ldreq r0, [r4, #0x98]
	streq r0, [r6]
	ldreq r0, [r4, #0x90]
	moveq r0, r0, lsr #16
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r1, [r0, #0xc]
	str r1, [r6]
	ldr r1, [r0, #6]
	mov r1, r1, lsr #16
	str r1, [r5]
	mov r1, #1
	strb r1, [r0, #2]
	ldrb r0, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_6544:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x70]
	ldr r8, lit_65b4
	mov r6, #0

sub_6564:
	ldr r0, [r5]
	teq r0, #0
	beq loc_65d8
	strb r6, [r0, #1]
	ldr r0, [r5]
	ldrb r1, [r0, #2]
	teq r1, #1
	bne loc_65b8
	strb r6, [r0, #2]
	mov r0, r8
	bl sub_11bfc
	mov r1, r0
	ldr r2, [r5]
	ldr r3, [r2, #4]
	mov r3, r3, lsr #16
	mov r0, r4
	bl sub_8924
	ldr r1, [r5]
	str r0, [r1, #0x10]!
	b loc_65c8
lit_65b4:
	.rword sub_6a9c				; relocated
loc_65b8:
	ldr r2, [r0, #8]!
	ldr r1, [r4, #0x6c]
	mov r0, r4
	bl sub_6c10
loc_65c8:
	str r6, [r5]
	ldr r0, [r4, #0x74]
	sub r0, r0, #1
	str r0, [r4, #0x74]
loc_65d8:
	add r7, r7, #1
	add r5, r5, #4
	cmp r7, #0x20
	blt sub_6564
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_65ec:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r1, [r2, #0xc]!
	ldr r2, [r1, #0xc]
	cmp r2, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {fp, sp, pc}
	add r3, r0, r2, lsl #2
	ldr r3, [r3, #0x40]
	teq r3, #0
	mvneq r0, #0xe
	ldmdbeq fp, {fp, sp, pc}
	ldr ip, [r1, #4]
	teq ip, #0
	bne loc_6650
	strb r2, [r0, #0x91]
	mov r2, r2, asr #8
	strb r2, [r0, #0x90]
	ldr r1, [r1, #8]
	str r1, [r0, #0x98]
	mvn r1, #0x80000000
	str r1, [r0, #0x94]!
	mov r0, #0x13
	ldmdb fp, {fp, sp, pc}
loc_6650:
	ldr lr, [r1, #0x10]
	cmp lr, #0x7d00
	mvnhs r0, #0x19
	ldmdbhs fp, {fp, sp, pc}
	mov r3, #0
	stmdb sp!, {r2, r3}
	mov r3, lr
	ldr r2, [r1, #8]!
	mov r1, ip
	bl sub_667c
	ldmdb fp, {fp, sp, pc}

sub_667c:
	teq r2, #0
	mvneq r0, #0x1a
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r7, r2
	mov r5, r3
	mov r0, #0
	ldr sb, [fp, #8]
	ldr sl, [fp, #4]

sub_66b0:
	add r1, r4, r0, lsl #2
	ldr r1, [r1, #0xac]
	teq r1, r6
	mvneq r0, #0x1b
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	add r0, r0, #1
	cmp r0, #4
	blt sub_66b0
	mov r2, r6
	ldr r1, [r4, #0x6c]
	mov r0, r4
	bl sub_6bc0
	movs r8, r0
	bne loc_6708
	mov r2, r6
	ldr r1, [r4, #0x6c]
	mov r0, r4
	bl sub_6b3c
	movs r8, r0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	b loc_6714
loc_6708:
	ldr r0, [r8, #4]
	movs r0, r0, lsr #16
	moveq r5, #0
loc_6714:
	strb sl, [r8]
	add r8, r8, #8
	stmia r8, {r6, r7}
	sub r8, r8, #8
	strb r5, [r8, #5]
	mov r0, r5, lsr #8
	strb r0, [r8, #4]
	teq sb, #0
	beq loc_676c
	sub ip, sb, #0xff00
	teq ip, #0xff
	strbne sb, [r8, #7]
	movne r0, sb, lsr #8
	bne loc_67c8
	ldr r0, lit_6768
	ldr r1, [r0]
	movs r1, r1, lsr #16
	beq loc_67b4
	ldr r1, [r8, #6]
	mov r1, r1, lsr #16
	b loc_678c
lit_6768:
	.rword data_117d4			; relocated
loc_676c:
	ldr r0, [r8, #6]
	movs r0, r0, lsr #16
	addeq r0, r4, sl, lsl #2
	ldreq r0, [r0, #0x40]
	ldreq r0, [r0, #0x32]
	moveq r0, r0, lsr #16
	beq loc_67c0
	b loc_67cc
loc_678c:
	ldr r2, [r0]
	cmp r1, r2, lsr #16
	bgt loc_67a8
	ldr r2, [r0, #2]!
	movs r2, r2, lsr #16
	bne loc_678c
	b loc_67b4
loc_67a8:
	ldr r1, [r0]
	movs r1, r1, lsr #16
	bne loc_67b8
loc_67b4:
	sub r0, r0, #2
loc_67b8:
	ldr r0, [r0]
	mov r0, r0, lsr #16
loc_67c0:
	strb r0, [r8, #7]
	mov r0, r0, asr #8
loc_67c8:
	strb r0, [r8, #6]
loc_67cc:
	teq r5, #0
	beq loc_6810
	ldrb r0, [r8, #2]
	teq r0, #0
	ldreq r0, [r8, #0x10]
	teqeq r0, #0
	bne loc_681c
	ldr r0, lit_680c
	bl sub_11bfc
	mov r1, r0
	mov r3, r5
	mov r2, r8
	mov r0, r4
	bl sub_8924
	str r0, [r8, #0x10]
	b loc_681c
lit_680c:
	.rword sub_6a9c				; relocated
loc_6810:
	mov r1, r8
	mov r0, r4
	bl sub_6a24
loc_681c:
	mov r0, #1
	strb r0, [r8, #2]
	mov r0, #0x13
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_682c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r1, [r2, #0xc]!
	ldr r1, [r1, #4]
	mov r4, #0x13
	teq r1, #0
	bne loc_687c
	ldr r1, [r0, #0x94]
	cmn r1, #0x80000001
	mvnne r0, #0x18
	ldmdbne fp, {r4, fp, sp, pc}
	mov r1, #0
	mov r2, #4
	str r1, [r0, #0x98]
	strb r2, [r0, #0x91]
	strb r1, [r0, #0x90]
	mov r1, #0x80000000
	str r1, [r0, #0x94]!
	b loc_6880
loc_687c:
	bl sub_6930
loc_6880:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_6888:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	ldr r6, [r2, #0xc]
	ldr r2, [r6, #4]
	teq r2, #0
	bne loc_68c8
	ldr r1, [r0, #0x98]
	str r1, [r6, #8]
	ldr r0, [r0, #0x90]
	mov r0, r0, lsr #16
	str r0, [r6, #0xc]
	mov r0, #0
	b loc_68f4
loc_68c8:
	ldr r1, [r0, #0x6c]
	bl sub_6bc0
	teq r0, #0
	mvneq r0, #0x18
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r1, [r0, #0xc]
	str r1, [r6, #8]
	ldrb r1, [r0]
	str r1, [r6, #0xc]
	ldr r0, [r0, #4]
	mov r0, r0, lsr #16
loc_68f4:
	str r0, [r6, #0x10]
	mov r0, #2
	add r0, r0, #0x300
	str r0, [r6]
	mov r0, #0x83
	ldr r1, [r4, #0x18]
	strb r0, [r1, #9]
	ldr r0, [r5, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_6930:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r2, r5
	ldr r1, [r0, #0x6c]
	bl sub_6bc0
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r2, r5
	ldr r1, [r4, #0x6c]
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_6c10

sub_696c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #4
	ldr r0, [r2, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, #0xc
	mov r0, sp
	mov r2, #4
	bl memcpy
	ldr r0, [r4]
	mov r0, r0, lsr #16
	add r0, r5, r0, lsl #2
	ldr r1, [r0, #0xbc]!
	ldr r0, [sp]
	bl sub_7514
	teq r0, #0
	beq loc_6a20
	mov r1, #0

sub_69c4:
	add r2, r5, r1, lsl #2
	ldr r2, [r2, #0xac]
	teq r2, r0
	beq loc_6a20
	add r1, r1, #1
	cmp r1, #4
	blt sub_69c4
	ldr r1, [r6, #0xc]!
	ldr r2, [r1, #0xc]
	teq r2, #4
	bne loc_6a20
	mov r3, #0
	ldr r2, [r4]
	mov r2, r2, lsr #16
	stmdb sp!, {r2, r3}
	ldr r2, [r1, #0x10]
	ldr r2, [r1, r2]
	ldr r1, [r4, #0x2c]!
	ldr r3, [r1, #0x3c]!
	mov r1, r0
	mov r0, r5
	bl sub_667c
	add sp, sp, #8
loc_6a20:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_6a24:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x10]
	mov r6, #0
	teq r1, #0
	beq loc_6a54
	mov r0, r5
	bl sub_8a04
	str r6, [r4, #0x10]
loc_6a54:
	ldrb r0, [r4, #1]
	teq r0, #1
	bne loc_6a94
	mov r1, #0
	ldr r0, [r5, #0x70]

sub_6a68:
	ldr r2, [r0]
	teq r2, r4
	streq r6, [r0]
	beq loc_6a88
	add r1, r1, #1
	add r0, r0, #4
	cmp r1, #0x20
	blt sub_6a68
loc_6a88:
	ldr r0, [r5, #0x74]
	sub r0, r0, #1
	str r0, [r5, #0x74]!
loc_6a94:
	strb r6, [r4, #1]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_6a9c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r0
	mov r6, r1
	ldr r0, [r1, #0x10]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r0, #0
	str r0, [r6, #0x10]
	mov r1, #0
	ldr r0, [r5, #0x70]

sub_6ad0:
	ldr r2, [r0]
	teq r2, #0
	bne loc_6b04
	str r6, [r0]
	mov r0, #1
	strb r0, [r6, #1]
	ldr r0, [r5, #0x74]
	add r0, r0, #1
	str r0, [r5, #0x74]
	ldr r0, [r5, #0x68]!
	ldr r0, [r0, #8]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_84a0
loc_6b04:
	add r1, r1, #1
	add r0, r0, #4
	cmp r1, #0x20
	blt sub_6ad0
	ldr r0, lit_6b38
	bl sub_11bfc
	mov r1, r0
	mov r2, r4
	mov r0, r5
	mov r3, #0xa
	bl sub_8924
	str r0, [r6, #0x10]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_6b38:
	.rword sub_6a9c				; relocated

sub_6b3c:
	teq r2, #0
	moveq r0, r1
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	ands r8, r2, #1
	ldrne r7, [r4, #0x18]
	ldreq r7, [r4, #0x14]
	teq r7, #0
	bne loc_6bac
	mov r0, #0x1c
	bl sub_7b9c
	movs r7, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r0, r7
	mov r2, #0x1c
	mov r1, #0
	bl memset
	mov r0, #4
	strb r0, [r7]
	teq r8, #0
	strne r7, [r4, #0x18]!
	streq r7, [r4, #0x14]!
loc_6bac:
	mov r2, r5, lsr #1
	mov r1, r7
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b sub_6b3c

sub_6bc0:
	mov r3, r0
	mov r0, r1
	mov r1, #0
	teq r2, #0
	bne loc_6be4
	ldrb r2, [r0]
	teq r2, #4
	movne pc, lr
	b loc_6bf8
loc_6be4:
	tst r2, #1
	ldrne r0, [r0, #0x18]
	ldreq r0, [r0, #0x14]
	teq r0, #0
	bne loc_6c00
loc_6bf8:
	mov r0, r1
	mov pc, lr
loc_6c00:
	mov r2, r2, lsr #1
	mov r1, r0
	mov r0, r3
	b sub_6bc0

sub_6c10:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, #0
	teq r2, #0
	beq loc_6c64
	tst r2, #1
	mov r2, r2, lsr #1
	bne loc_6c50
	mov r0, r5
	ldr r1, [r4, #0x14]
	bl sub_6c10
	str r0, [r4, #0x14]
	b loc_6c7c
loc_6c50:
	mov r0, r5
	ldr r1, [r4, #0x18]
	bl sub_6c10
	str r0, [r4, #0x18]
	b loc_6c7c
loc_6c64:
	mov r1, r4
	mov r0, r5
	bl sub_6a24
	mov r0, #4
	strb r0, [r4]
	strb r6, [r4, #2]
loc_6c7c:
	ldr r0, [r4, #0x14]
	teq r0, #0
	ldreq r0, [r4, #0x18]
	teqeq r0, #0
	movne r0, r4
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r5, #0x6c]!
	teq r0, r4
	movne r0, r4
	blne sub_7be0
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_6cac:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r8, #0x10000
	sub r8, r8, #1
	str r8, [sp, #-4]!
	mov r3, sp
	bl sub_6d78
	teq r0, #0
	teqne r0, #1
	beq loc_6d08
	mov r7, #1
	teq r0, #0x13
	bne loc_6d0c
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldr r3, [sp]
	bl sub_6f14
	b loc_6d70
loc_6d08:
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_6d0c:
	ldr r1, [sp]
	teq r1, #8
	beq loc_6d38
	teq r1, r8
	bne loc_6d50
	mov r3, r0
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_6e6c
	b loc_6d70
loc_6d38:
	mov r3, r0
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_6f5c
	b loc_6d70
loc_6d50:
	mov r3, r0
	stmdb sp!, {r3}
	mov r3, r1
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_6ec0
	add sp, sp, #4
loc_6d70:
	mov r0, r7
	b loc_6d08

sub_6d78:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	ldr r0, [r1, #2]
	mov r0, r0, lsr #16
	teq r0, #1
	mvneq r0, #4
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	add r1, r4, #0xc
	ldmia r1, {r0, r1}
	sub sb, r1, r0
	mvn r8, #5
	cmp sb, #4
	blo sub_6e34
	ldr r0, [r0]
	str r0, [r3]
	cmp r0, #9
	bls sub_6dfc
	cmp r0, #0x200
	blo sub_6de0
	subs ip, r0, #0x208
	cmphs ip, #3
	bls sub_6df0

sub_6de0:
	teq r0, #0x500
	mvnne r0, #6
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov r0, #0x20c

sub_6df0:
	add r0, r0, #0xf000000a
	sub r0, r0, #0x200
	add r0, r0, #0x10000000

sub_6dfc:
	ldr r1, lit_6e3c
	add r0, r1, r0, lsl #3
	add r7, r0, #0xb8
	ldr r1, [r5, #4]
	mov r1, r1, lsr #16
	ldrb r2, [r7]
	mov r0, r6
	bl sub_6ff8
	teq r0, #0
	mvneq r0, #7
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldrb r0, [r7, #1]
	cmp r0, sb
	bls sub_6e40

sub_6e34:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_6e3c:
	.rword data_11730			; relocated

sub_6e40:
	bhs loc_6e54
	ldrb r0, [r7, #2]
	tst r0, #1
	mvneq r0, #8
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_6e54:
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldr ip, [r7, #4]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	mov pc, ip

sub_6e6c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	mov r5, r3
	mov r2, #1
	strb r2, [r4, #3]
	mov r2, #0
	strb r2, [r4, #2]
	mov r3, #0x8a
	mov r2, #1
	bl sub_70ec
	mov r1, r0
	ldr r0, [r0, #0xc]
	strb r5, [r0]
	ldr r0, [r4, #0xc]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_6ec0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x83
	mov r2, #0x10
	ldr r6, [fp, #4]
	bl sub_70ec
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0x12
	stmia r0, {r2, r4, r6}
	mov r2, #0
	str r2, [r0, #0xc]!
	ldr r0, [r5, #0xc]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	ldr pc, [r2]

sub_6f14:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x83
	mov r2, #8
	bl sub_70ec
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0x13
	stmia r0, {r2, r4}
	ldr r0, [r5, #0xc]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_6f5c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r7, r3
	ldr r0, [r1, #0x60]
	movs r0, r0, lsr #16
	moveq r1, r4
	moveq r0, r5
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, lr}
	beq sub_7ed0
	ldr r1, [r4, #8]
	teq r1, #0
	beq loc_6fac
	mov r0, r5
	bl sub_7ed0
	mov r0, #0
	str r0, [r4, #8]
loc_6fac:
	add r1, r4, #0xc
	ldmia r1, {r0, r1}
	sub r0, r1, r0
	cmp r0, #0x14
	bhs loc_6fd4
	mov r3, r7
	mov r2, r4
	mov r1, r6
	mov r0, r5
	bl sub_6e6c
loc_6fd4:
	mov r1, #0x15
	ldr r0, [r4, #0xc]
	mov r2, r4
	str r1, [r0], #0x10
	str r7, [r0]
	mov r1, r6
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_7064

sub_6ff8:
	mov r0, #1
	cmp r2, #0x14
	beq loc_705c
	bgt loc_7024
	teq r2, #5
	teqne r2, #6
	bne loc_7054
	teq r1, r2
	teqne r1, #0
	moveq pc, lr
	b loc_705c
loc_7024:
	teq r2, #0x15
	beq loc_7044
	teq r2, #0x16
	bne loc_7054
	teq r1, #7
	teqne r1, #0
	moveq pc, lr
	b loc_705c
loc_7044:
	teq r1, #1
	teqne r1, #2
	movne pc, lr
	b loc_705c
loc_7054:
	teq r1, r2
	moveq pc, lr
loc_705c:
	mov r0, #0
	mov pc, lr

sub_7064:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	ldr r0, [r1, #0x64]
	teq r0, #0
	bne loc_70b0
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_70b0
	ldr r0, [r4, #0xc]!
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]
loc_70b0:
	ldr r0, [r4, #0x64]
	teq r0, #0
	ldrne r0, [r4, #0x68]
	strne r5, [r0]
	streq r5, [r4, #0x64]
	mov r0, #0
	str r5, [r4, #0x68]
	str r0, [r5]
	ldr r0, [r4, #0x60]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x61]
	mov r0, r0, asr #8
	strb r0, [r4, #0x60]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_70ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	mov r7, r3
	tst r2, #3
	moveq r8, r5
	bicne r0, r5, #3
	addne r8, r0, #4
	teq r4, #0
	bne loc_7134
loc_7120:
	mov r1, r8
	mov r0, r6
	bl sub_71b8
	mov r4, r0
	b loc_7180
loc_7134:
	ldr r0, [r4, #0x18]
	ldrb r1, [r0, #8]
	teq r1, #1
	bne loc_7154
	ldmia r0, {r0, r1}
	sub r0, r1, r0
	cmp r0, r8
	bhs loc_7164
loc_7154:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_7120
loc_7164:
	ldr r1, [r4, #8]
	teq r1, #0
	beq loc_7180
	mov r0, r6
	bl sub_7ed0
	mov r0, #0
	str r0, [r4, #8]
loc_7180:
	ldr r0, [r4, #0x18]
	strb r7, [r0, #9]
	ldr r0, [r4, #0x18]
	ldr r0, [r0, #4]
	sub r0, r0, r5
	str r0, [r4, #0xc]
	ands r1, r0, #3
	subne r0, r0, r1
	strne r0, [r4, #0xc]
	ldr r0, [r4, #0xc]
	add r0, r0, r5
	str r0, [r4, #0x10]
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_71b8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r2, #2
	bl sub_7c44
	movs r5, r0
	bne loc_7208
	add r0, r4, #0x78
	ldr r1, [r0]
	teq r1, #0
	bne loc_71f4
loc_71e8:
	ldr r1, [r0, #4]!
	teq r1, #0
	beq loc_71e8
loc_71f4:
	mov r1, #0
	ldr r5, [r0]
	str r1, [r0]
	mov r0, r4
	bl sub_3cf8
loc_7208:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_7210:
	stmdb sp!, {lr}
	add ip, r2, r3
	ldrb r0, [ip, #0x48]
	teq r0, #1
	ldmiaeq sp!, {pc}
	add r0, r2, r3, lsl #3
	add r0, r0, #0x20
	ldr lr, [r1]
	teq lr, #0
	ldrne lr, [r1, #4]
	addne r3, lr, r3, lsl #3
	strne r2, [r3, #0x24]!
	streq r2, [r1]
	ldr r3, [r1, #4]
	str r3, [r0]
	mov r3, #0
	str r3, [r0, #4]!
	mov r0, #1
	str r2, [r1, #4]!
	strb r0, [ip, #0x48]
	ldmia sp!, {pc}

sub_7264:
	stmdb sp!, {lr}
	add ip, r2, r3
	ldrb r0, [ip, #0x48]
	teq r0, #0
	ldmiaeq sp!, {pc}
	add r0, r2, r3, lsl #3
	ldr r2, [r0, #0x20]!
	teq r2, #0
	addne r2, r2, r3, lsl #3
	ldrne lr, [r0, #4]
	strne lr, [r2, #0x24]!
	ldreq r2, [r0, #4]
	streq r2, [r1]
	ldr r2, [r0, #4]
	teq r2, #0
	ldr r0, [r0]
	addne r1, r2, r3, lsl #3
	strne r0, [r1, #0x20]!
	streq r0, [r1, #4]!
	mov r0, #0
	strb r0, [ip, #0x48]
	ldmia sp!, {pc}

sub_72bc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x64]
	teq r1, #0
	beq loc_7310
loc_72dc:
	ldr r0, [r4, #0x60]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x61]
	mov r0, r0, asr #8
	strb r0, [r4, #0x60]
	ldr r0, [r1]
	str r0, [r4, #0x64]
	mov r0, r5
	bl sub_7ed0
	ldr r1, [r4, #0x64]
	teq r1, #0
	bne loc_72dc
loc_7310:
	mov r6, #0
	str r6, [r4, #0x68]
	ldr r0, [r4, #0x50]
	teq r0, #0
	beq loc_7340
loc_7324:
	ldr r2, [r4, #0x50]
	mov r1, r4
	mov r0, r5
	bl sub_73c0
	ldr r0, [r4, #0x50]
	teq r0, #0
	bne loc_7324
loc_7340:
	strb r6, [r4, #0x17]
	strb r6, [r4, #0x16]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_734c:
	ldr r0, [r1, #0x1c]
	str r0, [r2, #0x5c]
	teq r0, #0
	ldrne r0, [r1, #0x1c]
	strne r2, [r0, #0x58]!
	streq r2, [r1, #0x18]
	mov r0, #0
	str r2, [r1, #0x1c]
	str r1, [r2, #0x1c]!
	str r0, [r2, #0x3c]
	mov pc, lr

sub_7378:
	teq r1, #0
	teqne r2, #0
	moveq pc, lr
	ldr r0, [r2, #0x5c]
	teq r0, #0
	ldrne r3, [r2, #0x58]
	strne r3, [r0, #0x58]!
	ldreq r0, [r2, #0x58]
	streq r0, [r1, #0x18]
	ldr r0, [r2, #0x58]
	teq r0, #0
	ldrne r1, [r2, #0x5c]
	strne r1, [r0, #0x5c]!
	ldreq r0, [r2, #0x5c]
	streq r0, [r1, #0x1c]!
	mov r0, #0
	str r0, [r2, #0x1c]!
	mov pc, lr

sub_73c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r7, #0
	ldr r1, [r2, #0x18]
	teq r1, #0
	beq loc_73f4
	mov r0, r6
	bl sub_8a04
	str r7, [r4, #0x18]
loc_73f4:
	strb r7, [r4]
	ldr r1, [r4, #0x10]
	teq r1, #0
	beq loc_7420
loc_7404:
	ldr r0, [r1]
	str r0, [r4, #0x10]
	mov r0, r6
	bl sub_7ed0
	ldr r1, [r4, #0x10]
	teq r1, #0
	bne loc_7404
loc_7420:
	ldr r0, [r4, #0x28]
	teq r0, #0
	ldrne r1, [r4, #0x24]
	strne r1, [r0, #0x24]!
	ldreq r0, [r4, #0x24]
	streq r0, [r5, #0x50]
	ldr r0, [r4, #0x24]
	teq r0, #0
	ldrne r1, [r4, #0x28]
	strne r1, [r0, #0x28]!
	ldreq r0, [r4, #0x28]
	streq r0, [r5, #0x54]!
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_7be0
data_745c:
	.word 0x69700000

sub_7460:
	mov ip, sp
	stmdb sp!, {r0, r1, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [fp, #-0x14]
	teq r0, #0
	moveq r0, #1
	ldmdbeq fp, {fp, sp, pc}
	ldr r0, [fp, #-0x14]
	cmn r0, #1
	moveq r0, #3
	ldmdbeq fp, {fp, sp, pc}
	ldrb r0, [fp, #-0x14]
	and r0, r0, #0xf0
	mov r0, r0, asr #4
	sub r0, r0, #8
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b loc_74f0
	b loc_74e0
	b loc_74e0
	b loc_74e0
	b loc_74e0
	b loc_74d4
	b loc_74d4
	b loc_74cc

sub_74c4:
	mov r0, #2
	ldmdb fp, {fp, sp, pc}
loc_74cc:
	mov r0, #5
	ldmdb fp, {fp, sp, pc}
loc_74d4:
	teq r1, #0
	moveq r1, #0xff
	beq loc_74f8
loc_74e0:
	teq r1, #0
	moveq r1, #0x10000
	subeq r1, r1, #1
	beq loc_74f8
loc_74f0:
	teq r1, #0
	mvneq r1, #0xff000000
loc_74f8:
	mvn r0, r1
	ldr r1, [fp, #-0x14]
	and r1, r0, r1
	teq r1, r0
	movne r0, #0
	moveq r0, #4
	ldmdb fp, {fp, sp, pc}

sub_7514:
	mov ip, sp
	stmdb sp!, {r0, r1, fp, ip, lr, pc}
	sub fp, ip, #4
	teq r1, #0
	ldrne r0, [fp, #-0x14]
	andne r0, r0, r1
	ldmdbne fp, {fp, sp, pc}
	ldrb r0, [fp, #-0x14]
	and r0, r0, #0xc0
	teq r0, #0x80
	ldreq r0, [fp, #-0x14]
	moveq r0, r0, lsr #16
	moveq r0, r0, lsl #16
	ldmdbeq fp, {fp, sp, pc}
	teq r0, #0xc0
	ldr r0, [fp, #-0x14]
	biceq r0, r0, #0xff
	andne r0, r0, #0xff000000
	ldmdb fp, {fp, sp, pc}

sub_7560:
	stmdb sp!, {r4, r5, lr}
	mov ip, #0
	mov lr, #1
	movs r5, r2
	sub r2, r2, #1
	ldr r4, [sp, #0xc]
	beq loc_75ac
	b loc_7588
loc_7580:
	teq lr, #1
	bne loc_7594
loc_7588:
	ldrb r5, [r1], #1
	mov r5, r5, lsl #8
	b loc_7598
loc_7594:
	ldrb r5, [r1], #1
loc_7598:
	add ip, r5, ip
	eor lr, lr, #1
	movs r5, r2
	sub r2, r2, #1
	bne loc_7580
loc_75ac:
	teq r4, #0
	beq loc_75d4
loc_75b4:
	ldr r1, [r0, #0x10]
	ldr r2, [r0, #0xc]
	sub r1, r1, r2
	cmp r1, r4
	bhi loc_75d4
	subs r4, r4, r1
	ldr r0, [r0, #8]
	bne loc_75b4
loc_75d4:
	ldr r1, [r0, #0xc]
	add r1, r1, r4
	movs r2, r3
	sub r3, r3, #1
	beq loc_7624
loc_75e8:
	teq lr, #1
	ldrb r2, [r1]
	moveq r2, r2, lsl #8
	add ip, r2, ip
	eor lr, lr, #1
	add r1, r1, #1
	ldr r2, [r0, #0x10]
	teq r1, r2
	bne loc_7618
	ldr r0, [r0, #8]
	teq r0, #0
	ldrne r1, [r0, #0xc]
loc_7618:
	movs r2, r3
	sub r3, r3, #1
	bne loc_75e8
loc_7624:
	mov r0, ip, lsl #16
	mov r0, r0, lsr #16
	add r0, r0, ip, lsr #16
	add r0, r0, r0, lsr #16
	mvn r0, r0
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	ldmia sp!, {r4, r5, pc}

sub_7644:
	ldrb r1, [r0], #1
	mov r1, r1, lsl #24
	ldrb r2, [r0], #1
	orr r1, r1, r2, lsl #16
	ldrb r2, [r0], #1
	orr r1, r1, r2, lsl #8
	ldrb r0, [r0]
	orr r0, r1, r0
	mov pc, lr

sub_7668:
	ldrb r1, [r0], #1
	ldrb r0, [r0]
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	mov pc, lr

sub_7680:
	mov r2, r1, lsr #24
	strb r2, [r0], #1
	mov r2, r1, lsr #16
	strb r2, [r0], #1
	mov r2, r1, lsr #8
	strb r2, [r0], #1
	strb r1, [r0]
	mov pc, lr

sub_76a0:
	mov r2, r1, lsr #8
	strb r2, [r0], #1
	strb r1, [r0]
	mov pc, lr

sub_76b0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #8
	mov r0, sp
	bl GetGlobalTime
	mov r0, sp
	mov r1, #0x384000
	bl ConvertTo__5TTimeF9TimeUnits
	ldmdb fp, {fp, sp, pc}

sub_76d8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	cmn r2, #1
	beq loc_7710
	mov r3, r4
	mov r2, r1
	mov r0, r5
	mov r1, #0
	bl sub_7b2c
	mov r7, r0
	b loc_7794
loc_7710:
	mov r0, r1
	mov r8, r1
	bl GetSize__11CBufferListCFv
	mov r1, r0
	mov r4, r0
	mov r0, r5
	mov r2, #2
	bl sub_7c44
	movs r7, r0
	beq loc_7794
	mov r5, r7
	mov r0, r8
	mvn r2, #0
	mov r1, #0
	bl Seek__11CBufferListFli
	teq r4, #0
	beq loc_7794
loc_7754:
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #4]
	ldr r1, [r5, #0x10]
	sub r0, r0, r1
	cmp r0, r4
	movhi r6, r4
	movls r6, r0
	mov r2, r6
	mov r0, r8
	bl Getn__11CBufferListFPUcl
	ldr r0, [r5, #0x10]
	add r0, r0, r6
	subs r4, r4, r6
	str r0, [r5, #0x10]
	ldr r5, [r5, #8]
	bne loc_7754
loc_7794:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_779c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r0, r1
	mov r4, r2
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
loc_77b8:
	add r2, r0, #0xc
	ldmia r2, {r1, r2}
	sub r1, r2, r1
	cmp r1, r4
	ldrhi r1, [r0, #0xc]
	addhi r1, r1, r4
	strhi r1, [r0, #0xc]
	ldmdbhi fp, {r4, r5, r6, fp, sp, pc}
	sub r4, r4, r1
	ldr r6, [r0, #8]
	mov r1, r0
	mov r0, r5
	bl sub_7e90
	movs r0, r6
	bne loc_77b8
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_77f8:
	teq r1, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
loc_7810:
	add r3, r4, #0xc
	ldmia r3, {r1, r3}
	sub r1, r3, r1
	cmp r1, r2
	bhs loc_7838
	sub r2, r2, r1
	ldr r4, [r4, #8]
	teq r4, #0
	bne loc_7810
	ldmdb fp, {r4, fp, sp, pc}
loc_7838:
	ldr r1, [r4, #0xc]
	add r1, r1, r2
	str r1, [r4, #0x10]
	ldr r1, [r4, #8]
	teq r1, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	bl sub_7ed0
	mov r0, #0
	str r0, [r4, #8]!
	ldmdb fp, {r4, fp, sp, pc}

sub_7860:
	stmdb sp!, {lr}
	mov r0, #0
	teq r1, #0
	ldmiaeq sp!, {pc}
	and r3, r2, #0xff
loc_7874:
	cmn r2, #1
	ldrne ip, [r1, #0x18]
	ldrbne ip, [ip, #9]
	teqne ip, r3
	bne loc_7898
	ldr ip, [r1, #0x10]
	ldr lr, [r1, #0xc]
	sub ip, ip, lr
	add r0, ip, r0
loc_7898:
	ldr r1, [r1, #8]
	teq r1, #0
	bne loc_7874
	ldmia sp!, {pc}

sub_78a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r6, r2
	movs r4, r3
	ldr r0, [fp, #4]
	moveq r0, r4
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r8, #0
	teq r5, #0
	beq loc_7930
loc_78d8:
	add r2, r5, #0xc
	ldmia r2, {r1, r2}
	sub r2, r2, r1
	cmp r2, r0
	subls r0, r0, r2
	bls sub_7924
	sub r2, r2, r0
	cmp r2, r4
	movhi r7, r4
	movls r7, r2
	add r1, r1, r0
	mov r2, r7
	mov r0, r6
	bl memcpy
	subs r4, r4, r7
	add r6, r6, r7
	add r8, r8, r7
	beq loc_7930
	mov r0, #0

sub_7924:
	ldr r5, [r5, #8]
	teq r5, #0
	bne loc_78d8
loc_7930:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_7938:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov ip, r3
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, ip
	bl sub_78a8
	ldmdb fp, {fp, sp, pc}

sub_795c:
	teq r1, #0
	beq loc_7990
loc_7964:
	ldr r0, [r1, #0x10]
	ldr r3, [r1, #0xc]
	sub r0, r0, r3
	cmp r0, r2
	ldrhi r0, [r1, #0xc]!
	ldrbhi r0, [r0, r2]
	movhi pc, lr
	sub r2, r2, r0
	ldr r1, [r1, #8]
	teq r1, #0
	bne loc_7964
loc_7990:
	mvn r0, #0
	mov pc, lr

sub_7998:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r6, r0
	movs r4, r1
	mov r7, r2
	mov r5, r3
	beq sub_7a08
	ldr r2, [fp, #0x14]
	teq r2, #0
	ldreq r0, [r4, #0x18]
	ldrbeq r1, [r0, #8]
	teqeq r1, #1
	bne sub_7a08
	ldr r1, [r4, #0xc]
	ldr r0, [r0]
	sub r0, r1, r0
	cmp r0, r5
	blo sub_7a08
	sub r0, r1, r5
	mov r2, r5
	mov r1, r7
	bl memcpy
	ldr r0, [r4, #0xc]
	sub r0, r0, r5
	str r0, [r4, #0xc]
	b loc_7b24

sub_7a08:
	mov r1, r5
	mov r0, r6
	mov r2, #2
	bl sub_7c44
	movs r8, r0
	bne loc_7a28
loc_7a20:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_7a28:
	mov sb, r8
	teq r5, #0
	beq loc_7a78
loc_7a34:
	ldr r0, [sb, #0x18]
	ldr r1, [r0, #4]!
	ldr r0, [sb, #0x10]
	sub r1, r1, r0
	cmp r1, r5
	movhi sl, r5
	movls sl, r1
	mov r2, sl
	mov r1, r7
	bl memcpy
	ldr r0, [sb, #0x10]
	add r0, r0, sl
	add r7, r7, sl
	subs r5, r5, sl
	str r0, [sb, #0x10]
	ldr sb, [sb, #8]
	bne loc_7a34
loc_7a78:
	teq r4, #0
	bne loc_7a88
loc_7a80:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_7a88:
	ldr r2, [fp, #0x14]
	teq r2, #0
	bne loc_7aa8
	mov r2, r4
	mov r1, r8
	mov r0, r6
	bl sub_7f00
	b loc_7a80
loc_7aa8:
	ldr r2, [fp, #0x14]
	cmn r2, #1
	moveq r2, r8
	moveq r1, r4
	beq loc_7b1c
	mov r1, r4
	mov r0, r6
	bl sub_7e24
	movs r5, r0
	bne loc_7ae0
	mov r1, r8
	mov r0, r6
	bl sub_7ed0
	b loc_7a20
loc_7ae0:
	mov r1, r4
	mov r0, r6
	ldr r2, [fp, #0x14]
	bl sub_77f8
	mov r1, r5
	mov r0, r6
	ldr r2, [fp, #0x14]
	bl sub_779c
	mov r5, r0
	mov r2, r8
	mov r1, r4
	mov r0, r6
	bl sub_7f00
	mov r2, r5
	mov r1, r8
loc_7b1c:
	mov r0, r6
	bl sub_7f00
loc_7b24:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_7b2c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov ip, r3
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, ip
	bl sub_7998
	ldmdb fp, {fp, sp, pc}

sub_7b50:
	teq r1, #0
	beq loc_7b88
loc_7b58:
	ldr r0, [r1, #0x10]
	ldr ip, [r1, #0xc]
	sub r0, r0, ip
	cmp r0, r2
	ldrhi r0, [r1, #0xc]!
	strbhi r3, [r0, r2]
	movhi r0, #1
	movhi pc, lr
	sub r2, r2, r0
	ldr r1, [r1, #8]
	teq r1, #0
	bne loc_7b58
loc_7b88:
	mov r0, #0
	mov pc, lr

sub_7b90:
	mov r0, #2
	add r0, r0, #0x600
	mov pc, lr

sub_7b9c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	subs ip, r0, #0x600
	cmphs ip, #2
	bhi loc_7bd4
	mov r0, r4
	ldr r1, lit_7bdc
	bl NewNamedPtr
	teq r0, #0
	strne r4, [r0]
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_7bd4:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_7bdc:
	.word 0x50534520			; 'PSE '

sub_7be0:
	teq r0, #0
	bne DisposPtr
	mov pc, lr

sub_7bec:
	mov r0, #1
	mov pc, lr

sub_7bf4:
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
	bl sub_7c34
	ldmia r5, {r1, r2, r3, ip, lr}
	stmia r6, {r1, r2, r3, ip, lr}
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_7c34:
	sub r2, r1, #0x14
	add r0, r0, #0x14
	mov r1, #0
	b memset

sub_7c44:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	add r4, r1, #8
	mov r1, r4
	bl sub_7bec
	movs r1, r0
	mov r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r6, #0
	mov sl, #0
	mov r7, #0
	cmp r4, #0
	bls sub_7d14
	mov sb, r0

sub_7c84:
	sub r1, r4, r7
	mov r0, r5
	bl sub_7d34
	movs r8, r0
	bne loc_7cac
loc_7c98:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_7cac:
	mov r0, #0x1c
	bl sub_7b9c
	teq r0, #0
	bne loc_7cc8
	mov r0, r8
	bl sub_7be0
	b loc_7c98
loc_7cc8:
	str sb, [r0]
	str sb, [r0, #4]
	str sb, [r0, #8]
	ldr r1, [r8]
	str r1, [r0, #0xc]
	ldr r1, [r8]
	str r1, [r0, #0x10]
	str r8, [r0, #0x18]
	strb sb, [r0, #0x14]
	ldr r1, [r8, #4]
	ldr r2, [r8]
	sub r1, r1, r2
	add r7, r1, r7
	teq r6, #0
	strne r0, [sl, #8]!
	moveq r6, r0
	mov sl, r0
	cmp r7, r4
	blo sub_7c84

sub_7d14:
	ldr r0, [r6, #0xc]
	add r0, r0, #8
	str r0, [r6, #0xc]
	ldr r0, [r6, #0x10]
	add r0, r0, #8
	str r0, [r6, #0x10]
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_7d34:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	add r1, r1, #0x10
	mov r0, #2
	add r0, r0, #0x600
	cmp r1, r0
	movhi r1, r0
	mov r0, r1
	bl sub_7b9c
	mov r2, #0
	teq r0, #0
	moveq r0, r2
	ldmdbeq fp, {fp, sp, pc}
	ldr r1, [r0]
	sub r1, r1, #0x10
	add r3, r0, #0x10
	str r3, [r0]
	add r1, r3, r1
	str r1, [r0, #4]
	mov r1, #1
	strb r1, [r0, #8]
	strb r2, [r0, #9]
	ldmdb fp, {fp, sp, pc}

sub_7d94:
	mov r0, #0
	teq r1, #0
	moveq pc, lr
loc_7da0:
	ldr r2, [r1, #0x18]
	ldmia r2, {r2, r3}
	sub r2, r3, r2
	add r0, r2, r0
	ldr r1, [r1, #8]
	teq r1, #0
	bne loc_7da0
	mov pc, lr

sub_7dc0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r1
	mov r5, #0
	beq loc_7de8
	mov r0, #0x1c
	bl sub_7b9c
	teq r0, #0
	bne loc_7df0
loc_7de8:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_7df0:
	ldr r1, [r4, #0xc]
	str r1, [r0, #0xc]
	ldr r1, [r4, #0x10]
	str r1, [r0, #0x10]
	ldr r1, [r4, #0x18]!
	str r1, [r0, #0x18]
	str r5, [r0]
	str r5, [r0, #4]
	str r5, [r0, #8]
	ldrb r2, [r1, #8]!
	add r2, r2, #1
	strb r2, [r1]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_7e24:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	mov r6, #0
	mov r7, #0
	beq loc_7e88
loc_7e44:
	mov r1, r4
	mov r0, r5
	bl sub_7dc0
	teq r0, #0
	bne loc_7e6c
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_7e6c:
	teq r6, #0
	strne r0, [r7, #8]!
	moveq r6, r0
	mov r7, r0
	ldr r4, [r4, #8]
	teq r4, #0
	bne loc_7e44
loc_7e88:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_7e90:
	teq r1, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r0, [r1, #0x18]
	ldrb r1, [r0, #8]!
	sub r1, r1, #1
	ands r1, r1, #0xff
	strb r1, [r0]
	ldreq r0, [r4, #0x18]
	bleq sub_7be0
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_7be0

sub_7ed0:
	teq r1, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
loc_7ee8:
	mov r0, r4
	ldr r5, [r1, #8]
	bl sub_7e90
	movs r1, r5
	bne loc_7ee8
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_7f00:
	teq r1, #0
	teqne r2, #0
	moveq pc, lr
	ldr r0, [r1, #8]
	teq r0, #0
	beq loc_7f28
loc_7f18:
	ldr r1, [r1, #8]
	ldr r0, [r1, #8]
	teq r0, #0
	bne loc_7f18
loc_7f28:
	str r2, [r1, #8]!
	mov pc, lr

sub_7f30:
	ldr r1, [r0]
	ldr r1, [r1, #4]
	teq r1, #0
	bne loc_7f60
loc_7f40:
	ldr r1, [r0, #0x10]
	teq r1, #0
	beq loc_7f60
	mov r0, r1
	ldr r1, [r1]
	ldr r1, [r1, #4]
	teq r1, #0
	beq loc_7f40
loc_7f60:
	ldr r1, [r0, #0x24]
	mov r1, r1, lsr #16
	tst r1, #4
	beq loc_7f88
	orr r1, r1, #8
	strb r1, [r0, #0x25]
	mov r1, r1, asr #8
	strb r1, [r0, #0x24]
	mov r0, #0
	mov pc, lr
loc_7f88:
	bic r1, r1, #8
	strb r1, [r0, #0x25]
	mov r1, r1, asr #8
	strb r1, [r0, #0x24]
	mov r0, #1
	mov pc, lr

sub_7fa0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r6, [r0, #8]
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
loc_7fc0:
	teq r5, #1
	ldr r7, [r6]
	ldrne r0, [r6, #0x18]
	ldrbne r0, [r0, #9]
	teqne r0, #0
	teqne r0, #1
	teqne r0, #0x83
	bne loc_7ff8
	mov r1, r6
	mov r0, r4
	bl sub_824c
	mov r1, r6
	ldr r0, [r4, #4]
	bl sub_7ed0
loc_7ff8:
	movs r6, r7
	bne loc_7fc0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_8004:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r4, [r0, #8]
	teq r4, #0
	moveq r0, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	mov r1, r4
	bl sub_824c
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_8030:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	teq r1, #0
	bne loc_807c
	ldr r1, [r4, #8]
	teq r1, #0
	streq r2, [r4, #8]
	streq r0, [r2, #4]
	beq loc_8070
	ldr r1, [r4, #0xc]
	str r2, [r1]
	ldr r1, [r4, #0xc]
	str r1, [r2, #4]
loc_8070:
	str r2, [r4, #0xc]
	str r0, [r2]
	b loc_80b4
loc_807c:
	ldr r3, [r4, #8]
	teq r3, r1
	bne loc_809c
	str r2, [r1, #4]
	str r0, [r2, #4]
	str r1, [r2]
	str r2, [r4, #8]
	b loc_80b4
loc_809c:
	str r1, [r2]
	ldr r0, [r1, #4]
	str r0, [r2, #4]
	ldr r0, [r1, #4]
	str r2, [r0]
	str r2, [r1, #4]!
loc_80b4:
	mov r1, r2
	ldr r0, [r4, #4]
	bl sub_7d94
	ldr r1, [r4, #0x22]
	mov r1, r1, lsr #16
	add r0, r0, r1
	strb r0, [r4, #0x23]
	mov r0, r0, asr #8
	strb r0, [r4, #0x22]
	ldr r0, [r4, #0x22]
	mov r0, r0, lsr #16
	ldr r1, [r4, #0x2a]
	cmp r0, r1, lsr #16
	ldmdblt fp, {r4, fp, sp, pc}
	ldr r0, [r4, #0x24]
	mov r0, r0, lsr #16
	orr r0, r0, #4
	strb r0, [r4, #0x25]
	mov r0, r0, asr #8
	strb r0, [r4, #0x24]
	ldmdb fp, {r4, fp, sp, pc}

sub_8108:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	mov r7, r2
	mov r6, r3
	mov r8, #0
	teqne r4, #1
	teqne r4, #0x83
	beq loc_814c
	mov r2, #3
	mov r1, #1
	ldr r0, [r5, #4]
	bl sub_7c44
	teq r0, #0
	bne loc_8154
loc_814c:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_8154:
	ldr r1, [r0, #0x18]
	strb r4, [r1, #9]
	teq r6, #1
	bne loc_8170
	ldr r1, [r0, #0x10]
	strb r7, [r1], #1
	str r1, [r0, #0x10]
loc_8170:
	ldr r1, [r5]
	ldr r2, [r1]
	teq r2, #0
	mov r1, r0
	mov r0, r5
	beq loc_8194
	mov lr, pc
	mov pc, r2
	b loc_8198
loc_8194:
	bl sub_81a0
loc_8198:
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_81a0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r1, #0x18]
	ldrb r0, [r0, #9]
	tst r0, #0x80
	moveq r2, r5
	moveq r0, r4
	moveq r1, #0
	beq loc_81fc
	ldr r1, [r4, #8]
	teq r1, #0
	beq loc_81f4
loc_81dc:
	ldr r0, [r1, #0x18]
	ldrb r0, [r0, #9]
	tst r0, #0x80
	ldrne r1, [r1]
	teqne r1, #0
	bne loc_81dc
loc_81f4:
	mov r2, r5
	mov r0, r4
loc_81fc:
	bl sub_8030
	ldr r0, [r4]
	ldr r0, [r0, #4]
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r5, #0x18]!
	ldrb r0, [r0, #9]
	tst r0, #0x80
	bne loc_8240
	ldr r0, [r4, #0x24]
	mov r0, r0, lsl #15
	movs r0, r0, lsr #31
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	add r1, r4, #8
	ldmia r1, {r0, r1}
	teq r0, r1
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_8240:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_84a0

sub_824c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #8]
	teq r0, r1
	ldr r0, [r1]
	bne loc_8288
	mov r2, #0
	teq r0, #0
	strne r2, [r0, #4]!
	streq r2, [r4, #0xc]
	ldr r0, [r1]
	str r0, [r4, #8]
	b loc_82a8
loc_8288:
	teq r0, #0
	ldrne r2, [r1, #4]
	strne r2, [r0, #4]!
	ldreq r0, [r1, #4]
	streq r0, [r4, #0xc]
	ldr r0, [r1, #4]
	ldr r2, [r1]
	str r2, [r0]
loc_82a8:
	ldr r0, [r4, #4]
	bl sub_7d94
	ldr r1, [r4, #0x22]
	mov r1, r1, lsr #16
	sub r0, r1, r0
	strb r0, [r4, #0x23]
	mov r0, r0, asr #8
	strb r0, [r4, #0x22]
	ldr r0, [r4, #0x24]
	mov r0, r0, lsr #16
	tst r0, #4
	ldmdbeq fp, {r4, fp, sp, pc}
	ldr r1, [r4, #0x22]
	mov r1, r1, lsr #16
	ldr r2, [r4, #0x2c]
	cmp r1, r2, lsr #16
	ldmdbgt fp, {r4, fp, sp, pc}
	bic r0, r0, #4
	strb r0, [r4, #0x25]
	mov r0, r0, asr #8
	strb r0, [r4, #0x24]
	ldr r0, [r4, #0x24]
	mov r0, r0, lsr #16
	tst r0, #8
	ldrne r4, [r4, #0x34]
	teqne r4, #0
	ldmdbeq fp, {r4, fp, sp, pc}
loc_8314:
	ldr r0, [r4]
	ldr r0, [r0, #4]
	teq r0, #0
	bne loc_8334
	ldr r4, [r4, #0x34]
	teq r4, #0
	bne loc_8314
	ldmdb fp, {r4, fp, sp, pc}
loc_8334:
	teq r4, #0
	movne r0, r4
	ldmdbne fp, {r4, fp, sp, lr}
	bne sub_84a0
	ldmdb fp, {r4, fp, sp, pc}

sub_8348:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	mov r7, #0
	mov r8, #0
	mov sb, #0
	mov sl, #1

sub_836c:
	mov r0, #0x3c
	bl sub_7b9c
	movs r6, r0
	bne loc_8390
	teq r7, #0
	movne r0, r7
	blne sub_7be0
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_8390:
	mov r0, r6
	mov r2, #0x3c
	mov r1, #0
	bl memset
	teq r8, #0
	ldrne r0, [r4, #4]
	ldreq r0, [r4]
	stmia r6, {r0, r5}
	strb sl, [r6, #0x25]
	strb sb, [r6, #0x24]
	ldr r1, [r0, #0x14]
	ldr r1, [r1, #8]
	mov r1, r1, lsr #16
	strb r1, [r6, #0x27]
	mov r1, r1, asr #8
	strb r1, [r6, #0x26]
	ldr r1, [r0, #0x14]
	ldr r1, [r1, #0xa]
	mov r1, r1, lsr #16
	strb r1, [r6, #0x29]
	mov r1, r1, asr #8
	strb r1, [r6, #0x28]
	ldr r1, [r0, #0x14]
	ldr r1, [r1, #0xc]
	mov r1, r1, lsr #16
	strb r1, [r6, #0x2b]
	mov r1, r1, asr #8
	strb r1, [r6, #0x2a]
	ldr r0, [r0, #0x14]
	ldr r0, [r0, #0xe]
	mov r0, r0, lsr #16
	strb r0, [r6, #0x2d]
	mov r0, r0, asr #8
	strb r0, [r6, #0x2c]
	teq r7, #0
	moveq r7, r6
	add r8, r8, #1
	cmp r8, #2
	blo sub_836c
	str r6, [r7, #0x30]
	str r7, [r6, #0x30]!
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_843c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr r8, [r0, #4]
	mov r0, #0x18
	bl sub_7b9c
	movs r1, r0
	mov r2, #0
	moveq r0, r2
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r0, #1
	stmib r1, {r0, r4, r7}
	str r2, [r1, #0x14]
	str r5, [r1, #0x10]
	str r6, [r1]
	ldr r2, [r8, #0x2c]
	teq r2, #0
	strne r1, [r2, #0x14]!
	streq r1, [r8, #0x28]
	str r1, [r8, #0x2c]!
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_84a0:
	ldr r1, [r0, #4]
	ldr r1, [r1, #4]
	ldr r2, [r0, #0x24]
	mov r2, r2, lsr #16
	tst r2, #2
	movne pc, lr
	orr r2, r2, #2
	strb r2, [r0, #0x25]
	mov r2, r2, asr #8
	strb r2, [r0, #0x24]
	ldr r2, [r1, #0x20]
	teq r2, #0
	ldrne r2, [r1, #0x24]
	strne r0, [r2, #0x14]!
	streq r0, [r1, #0x20]
	str r0, [r1, #0x24]!
	mov r1, #0
	str r1, [r0, #0x14]!
	mov pc, lr

sub_84ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	bl sub_8540
	mov r5, #0
	mov r6, #0

sub_8508:
	ldr r0, [r4, #0x38]
	teq r0, #0
	beq loc_851c
	bl sub_7be0
	str r6, [r4, #0x38]
loc_851c:
	ldr r4, [r4, #0x30]
	add r5, r5, #1
	cmp r5, #2
	blt sub_8508
	ldr r0, [r4, #0x30]
	bl sub_7be0
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_7be0

sub_8540:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, #0
	mov r7, #0

sub_855c:
	ldr r0, [r4, #0x24]
	mov r0, r0, lsr #16
	tst r0, #2
	beq loc_85b8
	ldr r0, [r5, #0x20]
	teq r0, r4
	bne loc_858c
	ldr r0, [r4, #0x14]
	str r0, [r5, #0x20]
	teq r0, #0
	streq r7, [r5, #0x24]
	b loc_85b8
loc_858c:
	ldr r1, [r0, #0x14]
	teq r1, r4
	beq loc_85a8
loc_8598:
	ldr r0, [r0, #0x14]
	ldr r1, [r0, #0x14]
	teq r1, r4
	bne loc_8598
loc_85a8:
	ldr r1, [r4, #0x14]
	str r1, [r0, #0x14]
	teq r1, #0
	streq r0, [r5, #0x24]
loc_85b8:
	ldr r0, [r4, #0x24]
	mov r0, r0, lsr #16
	bic r0, r0, #2
	strb r0, [r4, #0x25]
	mov r0, r0, asr #8
	strb r0, [r4, #0x24]
	ldr r0, [r4, #0x24]
	mov r0, r0, lsr #16
	bic r0, r0, #4
	strb r0, [r4, #0x25]
	mov r0, r0, asr #8
	strb r0, [r4, #0x24]
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	ldr r4, [r4, #0x30]
	add r6, r6, #1
	cmp r6, #2
	blt sub_855c
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_8608:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, r1
	bl sub_7b90
	mov r5, #0
	str r0, [r4, #0x14]
	teq r0, #0
	beq loc_8640
	mov r0, r4
	bl sub_88f4
	teq r0, #0
	bne loc_8648
loc_8640:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_8648:
	str r5, [r4, #0x20]
	str r5, [r4, #0x24]
	str r5, [r4, #0x28]
	str r5, [r4, #0x2c]
	str r5, [r4, #0x18]
	str r5, [r4, #0x1c]
	ldr r0, [r4, #0x14]!
	teq r0, #0
	movne r0, #1
	moveq r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_8674:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r4, [r0, #4]!
	ldr r5, [r4, #0x18]
	teq r5, #0
	bne loc_8698
loc_8690:
	mov r6, #0
	b loc_86bc
loc_8698:
	ldr r1, [r5, #0x14]
	teq r1, #0
	ldrne r0, [r5, #0x10]
	movne lr, pc
	movne pc, r1
	ldr r5, [r5, #8]
	teq r5, #0
	bne loc_8698
	b loc_8690
loc_86bc:
	mov r5, #0
	ldr r1, [r4, #0x20]
	teq r1, #0
	beq loc_8708
	ldr r0, [r1, #0x14]
	str r0, [r4, #0x20]
	teq r0, #0
	streq r6, [r4, #0x24]
	ldr r0, [r1, #0x24]
	mov r0, r0, lsr #16
	bic r0, r0, #2
	strb r0, [r1, #0x25]
	mov r0, r0, asr #8
	strb r0, [r1, #0x24]
	mov r0, r1
	ldr r1, [r1]
	mov lr, pc
	ldr pc, [r1, #4]
	mov r5, #1
loc_8708:
	ldr r0, [r4, #0x28]
	teq r0, #0
	movne r0, r4
	blne sub_8724
	teq r5, #0
	bne loc_86bc
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_8724:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r5, [r0, #0x28]
	ldmia r5, {r1, r2}
	bl sub_7bec
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r5, #0x14]
	str r0, [r4, #0x28]
	teq r0, #0
	moveq r0, #0
	streq r0, [r4, #0x2c]!
	ldr r0, [r5, #8]
	ldr r1, [r5, #0x10]
	mov lr, pc
	ldr pc, [r5, #0xc]
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_7be0

sub_8778:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, r2
	mov r6, r3
	ldr sb, [r0, #4]
	ldr r0, [r1]
	ldr r0, [r0, #0x14]
	ldr r1, [r0]
	mov r1, r1, lsr #16
	mov r0, sb
	bl sub_88b8
	mvn sl, #0
	teq r0, #0
	bne loc_87cc
	mov r0, #0x18
	bl sub_7b9c
	movs r8, r0
	bne loc_87d4
loc_87cc:
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_87d4:
	mov r0, #0
	str r0, [r8, #4]
	str r4, [r8]
	str r6, [r8, #0x14]
	str r0, [r8, #8]
	ldr r0, [sb, #0x1c]
	str r0, [r8, #0xc]
	ldr r0, [sb, #0x1c]
	teq r0, #0
	strne r8, [r0, #8]!
	streq r8, [sb, #0x18]
	str r8, [sb, #0x1c]
	mov r0, sb
	mov lr, pc
	mov pc, r7
	str r0, [r8, #0x10]!
	teq r0, #0
	movne r0, #1
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r0, [r4]
	ldr r0, [r0, #0x14]
	ldr r1, [r0]
	mov r1, r1, lsr #16
	mov r0, r5
	bl sub_883c
	b loc_87cc

sub_883c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r5, [r0, #4]!
	mov r0, r5
	bl sub_88b8
	movs r4, r0
	mvn r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r4, #4]
	teq r1, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0xc]
	teq r0, #0
	ldrne r1, [r4, #8]
	strne r1, [r0, #8]!
	ldreq r0, [r4, #8]
	streq r0, [r5, #0x18]
	ldr r0, [r4, #8]
	teq r0, #0
	ldrne r1, [r4, #0xc]
	strne r1, [r0, #0xc]!
	ldreq r0, [r4, #0xc]
	streq r0, [r5, #0x1c]!
	ldr r0, [r4, #0x10]
	teq r0, #0
	blne DisposPtr
	mov r0, r4
	bl sub_7be0
	mov r0, #1
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_88b8:
	ldr r0, [r0, #0x18]
	teq r0, #0
	beq loc_88ec
loc_88c4:
	ldr r2, [r0]
	ldr r2, [r2]
	ldr r2, [r2, #0x14]
	ldr r2, [r2]
	mov r2, r2, lsr #16
	teq r2, r1
	moveq pc, lr
	ldr r0, [r0, #8]
	teq r0, #0
	bne loc_88c4
loc_88ec:
	mov r0, #0
	mov pc, lr

sub_88f4:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x130]
	str r0, [r4, #0x134]
	bl GetGlobalTime
	str r0, [r4, #0x138]
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b loc_ef5c

sub_8924:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr sb, [r0, #4]
	mov r0, #0x1c
	bl sub_7b9c
	movs r8, r0
	beq loc_89fc
	mov r0, r8
	mov r2, #0x1c
	mov r1, #0
	bl memset
	stmia r8, {r4, r7}
	str r6, [r8, #8]
	ldr r0, lit_89cc
	mov r1, r5
	str r0, [r8, #0x18]
	ldr r0, [sb, #0x130]
	teq r0, #0
	beq loc_89a0
loc_8984:
	ldr r2, [r0, #0xc]
	subs r1, r1, r2
	bmi loc_89a0
	sub r5, r5, r2
	ldr r0, [r0, #0x10]
	teq r0, #0
	bne loc_8984
loc_89a0:
	teq r0, #0
	str r5, [r8, #0xc]
	bne loc_89d0
	ldr r0, [sb, #0x130]
	teq r0, #0
	ldrne r0, [sb, #0x134]
	strne r0, [r8, #0x14]
	strne r8, [r0, #0x10]!
	streq r8, [sb, #0x130]
	str r8, [sb, #0x134]!
	b loc_89fc
lit_89cc:
	.word 0xf2c6af8c
loc_89d0:
	str r0, [r8, #0x10]
	ldr r1, [r0, #0x14]
	str r1, [r8, #0x14]
	teq r1, #0
	streq r8, [sb, #0x130]!
	strne r8, [r1, #0x10]!
	str r8, [r0, #0x14]
	ldr r1, [r0, #0xc]
	ldr r2, [r8, #0xc]
	sub r1, r1, r2
	str r1, [r0, #0xc]!
loc_89fc:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_8a04:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r1
	ldr r0, [r0, #4]
	ldmdbeq fp, {r4, fp, sp, pc}
	ldr r1, [r4, #0x18]
	ldr r3, lit_8a48
	teq r1, r3
	ldmdbne fp, {r4, fp, sp, pc}
	ldr r2, [r4, #0x14]
	teq r2, #0
	bne loc_8a4c
	ldr r1, [r0, #0x130]
	teq r1, r4
	ldmdbne fp, {r4, fp, sp, pc}
	b loc_8a58
lit_8a48:
	.word 0xf2c6af8c
loc_8a4c:
	ldr r1, [r2, #0x18]
	teq r1, r3
	ldmdbne fp, {r4, fp, sp, pc}
loc_8a58:
	ldr r1, [r4, #0x10]
	teq r1, #0
	bne loc_8a74
	ldr r3, [r0, #0x134]
	teq r3, r4
	ldmdbne fp, {r4, fp, sp, pc}
	b loc_8a80
loc_8a74:
	ldr lr, [r1, #0x18]
	teq lr, r3
	ldmdbne fp, {r4, fp, sp, pc}
loc_8a80:
	mov r3, #0
	teq r2, #0
	bne loc_8aa0
	str r1, [r0, #0x130]
	ldr r1, [r0, #0x130]
	teq r1, #0
	strne r3, [r1, #0x14]!
	b loc_8aa4
loc_8aa0:
	str r1, [r2, #0x10]!
loc_8aa4:
	ldr r1, [r4, #0x10]
	teq r1, #0
	bne loc_8ac4
	ldr r1, [r4, #0x14]
	str r1, [r0, #0x134]!
	teq r1, #0
	strne r3, [r1, #0x10]!
	b loc_8ae0
loc_8ac4:
	ldr r0, [r4, #0x14]
	str r0, [r1, #0x14]!
	ldr r0, [r4, #0x10]
	ldr r1, [r4, #0xc]
	ldr r2, [r0, #0xc]!
	add r1, r1, r2
	str r1, [r0]
loc_8ae0:
	mov r0, r4
	mov r2, #0x1c
	mov r1, #0
	bl memset
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_7be0

sub_8afc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [r0, #4]
	ldr r1, [r0, #0x138]
	add r1, r1, #1
	str r1, [r0, #0x138]
	mov r8, #0
	ldr r1, [r0, #0x130]!
	ldr sb, lit_8b28
	b loc_8b6c
lit_8b28:
	.word 0xf2c6af8c
loc_8b2c:
	ldr r0, [r1, #0xc]
	sub r0, r0, #1
	str r0, [r1, #0xc]
	cmp r0, #0
	ldmdbgt fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	str r8, [r1, #0xc]
	ldmia r1, {r4, r6}
	mov r0, r4
	ldr r5, [r1, #8]
	ldr r7, [r1, #0x10]
	bl sub_8a04
	mov r1, r5
	mov r0, r4
	mov lr, pc
	mov pc, r6
	mov r1, r7
loc_8b6c:
	teq r1, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r1, #0x18]
	teq r0, sb
	beq loc_8b2c
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_8b84:
	ldr r0, [r0, #4]
	ldr r0, [r0, #0x138]
	mov pc, lr

sub_8b90:
	str r0, [r2, #0x10]
	teq r0, #0
	str r1, [r2, #0x34]
	strne r2, [r0, #0x34]
	teq r1, #0
	strne r2, [r1, #0x10]
	teq r0, #0
	ldrne r0, [r0, #0x30]
	teq r1, #0
	ldrne r1, [r1, #0x30]
	ldr r2, [r2, #0x30]
	str r0, [r2, #0x34]
	teq r0, #0
	str r1, [r2, #0x10]
	strne r2, [r0, #0x10]!
	teq r1, #0
	strne r2, [r1, #0x34]!
	mov pc, lr

sub_8bd8:
	ldr r1, [r0, #0x34]
	mov r3, r1
	ldr r2, [r0, #0x10]
	teq r2, #0
	strne r3, [r2, #0x34]
	teq r1, #0
	ldrne r3, [r0, #0x10]
	strne r3, [r1, #0x10]
	teq r2, #0
	ldrne r2, [r2, #0x30]
	teq r1, #0
	ldrne r1, [r1, #0x30]
	ldr r0, [r0, #0x30]
	teq r2, #0
	ldrne r3, [r0, #0x10]
	strne r3, [r2, #0x10]!
	teq r1, #0
	ldrne r0, [r0, #0x34]
	strne r0, [r1, #0x34]!
	mov pc, lr

sub_8c28:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r4, r1
	mov r6, r2
	mov r5, r3
	mov r2, #3
	ldr r0, [r1, #4]
	mov r1, #0x18
	bl sub_7c44
	movs r8, r0
	mov sl, #0
	bne loc_8c68
loc_8c60:
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_8c68:
	mov r2, #3
	mov r1, #0xc
	ldr r0, [r4, #4]
	bl sub_7c44
	movs sb, r0
	bne loc_8c90
	mov r1, r8
	ldr r0, [r4, #4]!
	bl sub_7ed0
	b loc_8c60
loc_8c90:
	mov r2, sb
	mov r1, r8
	ldr r0, [r4, #4]
	bl sub_7f00
	ldr r0, [r8, #0x10]
	str r7, [r0]
	strb sl, [r0, #5]
	strb sl, [r0, #4]
	strb sl, [r0, #7]
	strb sl, [r0, #6]
	mov r1, #0xc
	str sl, [r0, #8]!
	str r1, [r0, #4]
	ldr r0, [r8, #0x10]
	add r0, r0, #0x18
	mov r1, #0xe
	str r0, [r8, #0x10]
	ldr r0, [r8, #0x18]
	strb r1, [r0, #9]
	ldr r0, [sb, #0x10]
	stmia r0, {r4, r6}
	str r5, [r0, #8]
	ldr r0, [sb, #0x10]
	add r0, r0, #0xc
	str r0, [sb, #0x10]!
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_8cfc:
	ldr r2, [r0, #0x38]!
	ldr r0, [r2, #0x10]
	ldr r2, [r2, #8]
	cmn r2, #1
	teqne r0, #0
	moveq pc, lr
loc_8d14:
	ldr r2, [r0, #0x38]
	ldr r3, [r2, #4]
	teq r3, r1
	ldrne r0, [r2, #0x14]!
	teqne r0, #0
	bne loc_8d14
	mov pc, lr

sub_8d30:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r6, r1
	mov r4, r2
	ldr sb, [fp, #0x1c]
	ldr sl, [fp, #0x14]
	mov r1, r2
	ldr r5, [r0, #4]!
	mov r0, r5
	bl sub_88b8
	movs r8, r0
	beq loc_8d94
	mov r1, r6
	mov r0, r5
	bl sub_88b8
	movs r6, r0
	beq loc_8d94
	mov r0, r5
	ldr r1, [r8]
	ldr r2, [r8, #0x10]
	bl sub_8348
	movs r7, r0
	bne loc_8d9c
loc_8d94:
	mvn r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_8d9c:
	mov r0, r5
	ldr r1, [r6], #0x10
	ldr r2, [r6]
	bl sub_8348
	movs r6, r0
	moveq r1, r7
	beq loc_8dd8
	mov r0, #0x24
	bl sub_7b9c
	teq r0, #0
	bne loc_8de4
	mov r1, r7
	mov r0, r5
	bl sub_84ec
	mov r1, r6
loc_8dd8:
	mov r0, r5
	bl sub_84ec
	b loc_8d94
loc_8de4:
	mov r1, #0
	str r0, [r6, #0x38]
	strb r1, [r0, #1]
	strb r1, [r0]
	str r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0x1c]
	str r1, [r0, #0x20]
	str r1, [r0, #0xc]
	str r1, [r0, #0x14]
	str r1, [r0, #0x18]
	mov r2, r7
	str r1, [r0, #0x10]!
	mov r0, r6
	mov r1, #0
	bl sub_8b90
	ldr r3, [fp, #0x10]
	orr r4, r3, r4, lsl #16
	mov r3, sl
	mov r1, r4
	mov r0, r7
	mov r2, #0
	ldr ip, [r8]
	ldr ip, [ip]
	mov lr, pc
	ldr pc, [ip, #8]
	movs sl, r0
	mov r0, r4, lsr #16
	orr r0, sl, r0, lsl #16
	bpl loc_8e7c
	mov r1, r7
	mov r0, r5
	bl sub_84ec
	mov r1, r6
	mov r0, r5
	bl sub_84ec
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_8e7c:
	ldr r1, [r8, #4]
	add r1, r1, #1
	teq sb, #0
	str r1, [r8, #4]!
	beq loc_8ea8
	mov r2, r0, lsl #16
	mov r2, r2, lsr #16
	mov r1, r6
	ldr r0, [fp, #0x18]
	mov lr, pc
	mov pc, sb
loc_8ea8:
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_8eb0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mvn r4, #0
	ldr r3, [r0, #0x38]
	teq r3, #0
	beq loc_8f88
	ldr ip, [r3, #0xc]
	teq ip, #0
	beq loc_8ee4
	teq r2, #0
	bne loc_8f88
	b loc_8ef4
loc_8ee4:
	teq r2, #0
	addne r3, r3, #0x1c
	stmiane r3, {r1, r2}
	subne r3, r3, #0x1c
loc_8ef4:
	ldr r1, [r3]
	mov r1, r1, lsr #16
	orr r1, r1, #0x10
	strb r1, [r3, #1]
	mov r1, r1, asr #8
	strb r1, [r3]
	str r4, [r3, #8]
	ldr r1, [r0, #0x34]
	ldr r1, [r1, #0x34]
	teq r1, #0
	movne r2, #0
	movne r1, #0
	ldmdbne fp, {r4, fp, sp, lr}
	bne sub_907c
	ldr r1, [r3, #0x10]
	teq r1, #0
	beq loc_8f4c
	mov r3, #0
	mov r2, #0
	mvn r1, #0
	ldmdb fp, {r4, fp, sp, lr}
	b sub_92a8
loc_8f4c:
	ldr r1, [r3]
	mov r1, r1, lsr #16
	orr r1, r1, #1
	strb r1, [r3, #1]
	mov r1, r1, asr #8
	strb r1, [r3]
	ldr r0, [r0, #0x30]
	ldr r0, [r0, #0x10]
	mov r3, #1
	mov r2, #3
	mov r1, #0x86
	bl sub_8108
	teq r0, #1
	moveq r0, #1
	ldmdbeq fp, {r4, fp, sp, pc}
loc_8f88:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_8f90:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r7, r2
	mov r5, r3
	ldr r0, [r0, #4]
	ldr sl, [r0, #4]!
	mov r0, sl
	bl sub_88b8
	movs r8, r0
	ldrne r0, [r4, #0x38]
	teqne r0, #0
	beq loc_8ff0
	ldr r0, [r0, #0xc]
	teq r0, #0
	bne loc_8ff0
	mov r0, sl
	ldr r1, [r8]
	ldr r2, [r8, #0x10]
	bl sub_8348
	movs sb, r0
	bne loc_8ff8
loc_8ff0:
	mvn r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_8ff8:
	mov r2, sb
	ldr r1, [r4, #0x34]
	mov r0, r4
	bl sub_8b90
	mov r1, r6, lsl #16
	mov r0, sb
	mov r3, #1
	mov r2, #0
	ldr ip, [r8]
	ldr ip, [ip]
	mov lr, pc
	ldr pc, [ip, #8]
	movs r6, r0
	bpl loc_904c
	mov r0, sb
	bl sub_8bd8
	mov r1, sb
	mov r0, sl
	bl sub_84ec
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_904c:
	ldr r0, [r8, #4]
	add r0, r0, #1
	teq r5, #0
	str r0, [r8, #4]!
	beq loc_9074
	mov r1, r4
	mov r0, r7
	mov r2, #1
	mov lr, pc
	mov pc, r5
loc_9074:
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_907c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mvn r4, #0
	ldr r3, [r0, #0x38]
	teq r3, #0
	ldrne ip, [r0, #0x34]
	ldrne ip, [ip, #0x34]
	teqne ip, #0
	beq loc_911c
	ldr ip, [r3, #0xc]
	teq ip, #0
	teqne r2, #0
	bne loc_911c
	ldr ip, [r3]
	mov ip, ip, lsr #16
	orr ip, ip, #1
	strb ip, [r3, #1]
	mov ip, ip, asr #8
	strb ip, [r3]
	ldr ip, [r3]
	mov ip, ip, lsr #16
	tst ip, #0x10
	bne loc_90ec
	orr ip, ip, #0x20
	strb ip, [r3, #1]
	mov ip, ip, asr #8
	strb ip, [r3]
loc_90ec:
	teq r2, #0
	addne r3, r3, #0x18
	stmibne r3!, {r1, r2}
	ldr r0, [r0, #0x30]
	ldr r0, [r0, #0x10]
	mov r3, #1
	mov r2, #3
	mov r1, #0x86
	bl sub_8108
	teq r0, #1
	moveq r0, #1
	ldmdbeq fp, {r4, fp, sp, pc}
loc_911c:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_9124:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r0, #4]
	ldr sb, [r0, #4]!
	ldr r6, [r5, #0x38]
	teq r6, #0
	ldrne r8, [r4, #0x38]
	teqne r8, #0
	beq loc_91b4
	ldr r0, [r5, #0x34]
	ldr r0, [r0]
	ldr r0, [r0, #0x14]
	ldr r1, [r0]
	mov r1, r1, lsr #16
	mov r0, sb
	bl sub_88b8
	movs r7, r0
	ldrne r0, [r7]
	ldrne r1, [r0, #8]
	teqne r1, #0
	ldrne r0, [r0, #0xc]
	teqne r0, #0
	beq loc_91b4
	ldr r0, [r6, #0xc]
	teq r0, #0
	ldreq r0, [r8, #0xc]
	teqeq r0, #0
	bne loc_91b4
	mov r0, sb
	bl sub_9354
	mov sl, r0
	cmn r0, #1
	bne loc_91bc
loc_91b4:
	mvn r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_91bc:
	ldr r2, [r4, #0x30]
	ldr r0, [r5, #0x34]
	mov r3, sl
	ldr r1, [r0, #0x30]!
	mov r0, #0x30c
	add r0, r0, #0x5000
	bl sub_8c28
	teq r0, #0
	bne loc_91f0
	mov r1, sl
	mov r0, sb
	bl sub_93c8
	b loc_91b4
loc_91f0:
	ldr r1, [r6, #0x10]
	teq r1, #0
	beq loc_920c
	ldr r1, [r1, #0x38]
	str r4, [r1, #0x18]!
	ldr r1, [r6, #0x10]
	str r1, [r8, #0x14]
loc_920c:
	str r4, [r6, #0x10]
	mov r1, #0
	str sl, [r8, #4]!
	str r5, [r8, #8]
	str r1, [r8, #0x14]
	ldr r1, [r7]
	ldr r1, [r1, #8]
	str r1, [r4]
	ldr r1, [r7, #0x10]
	str r1, [r4, #4]
	ldr r1, [r7]
	ldr r1, [r1, #0xc]
	ldr r2, [r4, #0x30]
	str r1, [r2]
	ldr r1, [r7, #0x10]!
	ldr r2, [r4, #0x30]!
	str r1, [r2, #4]!
	ldr r1, [r6]
	mov r1, r1, lsr #16
	orr r1, r1, #0x42
	strb r1, [r6, #1]
	mov r1, r1, asr #8
	strb r1, [r6]
	ldr r3, [fp, #-0x2c]
	teq r3, #0
	beq loc_9284
	ldr r3, [fp, #-0x2c]
	str r3, [r6, #0x20]
	ldr r2, [fp, #-0x30]
	str r2, [r6, #0x1c]!
loc_9284:
	ldr r1, [r5, #0x30]!
	ldr r2, [r1, #0x10]!
	mov r1, r0
	mov r0, r2
	ldr r2, [r2]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_92a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r7, r2
	mov r4, r3
	mvn sb, #0
	ldr r8, [r0, #0x38]
	teq r8, #0
	beq loc_934c
	cmn r5, #1
	beq loc_92f0
	mov r1, r5
	mov r0, r6
	bl sub_8cfc
	teq r0, #0
	beq loc_934c
loc_92f0:
	ldr r0, [r8, #0xc]
	teq r0, #0
	teqne r4, #0
	bne loc_934c
	ldr r0, [r8]
	mov r0, r0, lsr #16
	orr r0, r0, #0x81
	strb r0, [r8, #1]
	mov r0, r0, asr #8
	strb r0, [r8]
	teq r4, #0
	strne r4, [r8, #0x20]
	strne r7, [r8, #0x1c]
	str r5, [r8, #8]!
	ldr r0, [r6, #0x30]!
	ldr r0, [r0, #0x10]
	mov r3, #1
	mov r2, #3
	mov r1, #0x86
	bl sub_8108
	teq r0, #1
	moveq r0, #1
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_934c:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_9354:
	stmdb sp!, {r4, lr}
	ldr r3, lit_93a4
	mov r2, #0

sub_9360:
	add lr, r0, r2
	ldrb ip, [lr, #0x30]
	teq ip, #0xff
	beq loc_93b4
	mov r1, #0

sub_9374:
	add r4, r3, r1
	ldrb r4, [r4, #0xc]
	tst ip, r4
	bne loc_93a8
	add r0, r0, r2
	ldrb r0, [r0, #0x30]
	add r3, r3, r1
	ldrb r3, [r3, #0xc]
	orr r0, r0, r3
	strb r0, [lr, #0x30]
	add r0, r1, r2, lsl #3
	ldmia sp!, {r4, pc}
lit_93a4:
	.rword data_11904			; relocated
loc_93a8:
	add r1, r1, #1
	cmp r1, #8
	blo sub_9374
loc_93b4:
	add r2, r2, #1
	cmp r2, #0x100
	blo sub_9360
	mvn r0, #0
	ldmia sp!, {r4, pc}

sub_93c8:
	ldr r2, lit_93ec
	add r0, r0, r1, lsr #3
	ldrb r3, [r0, #0x30]
	and r1, r1, #7
	add r1, r1, r2
	ldrb r1, [r1, #0xc]
	bic r1, r3, r1
	strb r1, [r0, #0x30]
	mov pc, lr
lit_93ec:
	.rword data_11904			; relocated

sub_93f0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r0, #4]
	ldr r6, [r0, #4]!
	ldr r1, [r5, #0x38]
	teq r1, #0
	ldrne r0, [r1]
	movne r0, r0, lsr #16
	teqne r0, #0
	beq loc_952c
	tst r0, #1
	mov r8, #0
	beq loc_9450
	ldr r2, [r4, #0x18]
	ldrb r2, [r2, #9]
	teq r2, #0x86
	bne loc_9450
	mov r1, r5
	mov r0, r6
	bl sub_9534
	b loc_9518
loc_9450:
	ldr r2, [r4, #0x18]
	ldrb r2, [r2, #9]
	teq r2, #0x81
	teqne r2, #0x82
	bne loc_952c
	ldr r2, [r4, #0xc]
	ldr r3, [r2]
	sub ip, r3, #0x5300
	teq ip, #0xc
	bne loc_9498
	tst r0, #2
	beq loc_952c
	ldr r3, [r2, #0x10]!
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_9664
	b loc_9518
loc_9498:
	sub ip, r3, #0x5300
	teq ip, #0xd
	bne loc_952c
	tst r0, #4
	beq loc_952c
	ldr r1, [r1, #8]
	mov r0, r5
	bl sub_8cfc
	mov r7, r0
	ldr r0, [r0, #0x38]
	ldr r1, [r0, #4]!
	mov r0, r6
	bl sub_93c8
	mov r1, r7
	mov r0, r6
	bl sub_8540
	ldr r0, [r5]
	str r0, [r7]
	ldr r0, [r5, #4]
	str r0, [r7, #4]
	ldr r0, [r5, #0x30]
	ldr r1, [r0]
	ldr r0, [r7, #0x30]
	str r1, [r0]
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #4]
	ldr r1, [r7, #0x30]
	str r0, [r1, #4]!
	mov r0, r7
	mov r2, #0
	mov r1, #0
	bl sub_8eb0
loc_9518:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_952c:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_9534:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r6, [r1, #0x38]
	ldr r0, [r6]
	mov r0, r0, lsr #16
	bic r0, r0, #1
	strb r0, [r6, #1]
	mov r0, r0, asr #8
	strb r0, [r6]
	ldr r0, [r6]
	mov r0, r0, lsr #16
	tst r0, #0x80
	beq loc_95e0
	bic r0, r0, #0x80
	strb r0, [r6, #1]
	mov r0, r0, asr #8
	strb r0, [r6]
	mov r0, r4
	ldr r1, [r6, #8]
	bl sub_8cfc
	mov r2, r0
	ldr r0, [r0, #0x38]
	mov r1, r4
	ldr r3, [r0, #4]!
	mov r0, #0xd
	add r0, r0, #0x5300
	bl sub_8c28
	movs r1, r0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r6]
	mov r0, r0, lsr #16
	orr r0, r0, #4
	strb r0, [r6, #1]
	mov r0, r0, asr #8
	strb r0, [r6]
	ldr r0, [r4, #0x30]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	ldr pc, [r2]
loc_95e0:
	mov r1, r4
	mov r0, r5
	bl sub_971c
	ldr r0, [r6]
	mov r0, r0, lsr #16
	tst r0, #0x20
	bne loc_9608
	ldr r0, [r6, #0xc]
	teq r0, #0
	bne loc_9654
loc_9608:
	ldr r3, [r6, #0x20]
	teq r3, #0
	beq loc_9634
	mov r1, r4
	mov r2, #1
	ldr r0, [r6, #0x1c]
	mov lr, pc
	mov pc, r3
	mov r0, #0
	str r0, [r6, #0x20]
	str r0, [r6, #0x1c]
loc_9634:
	ldr r0, [r6]
	mov r0, r0, lsr #16
	tst r0, #0x10
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
loc_9644:
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_84ec
loc_9654:
	mov r1, r4
	mov r0, r5
	bl sub_97b4
	b loc_9644

sub_9664:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r3
	ldr r6, [r1, #0x38]
	ldr r1, [r6]
	mov r1, r1, lsr #16
	bic r1, r1, #2
	strb r1, [r6, #1]
	mov r1, r1, asr #8
	strb r1, [r6]
	ldr r1, [r2, #0x18]!
	ldrb r1, [r1, #9]
	mov r7, #0
	teq r1, #0x81
	ldr r1, [r6, #0x10]
	bne loc_96d4
	ldr r0, [r1, #0x38]
	ldr r4, [r0, #4]!
	mov r0, #1
	strb r0, [r1, #0x21]
	strb r7, [r1, #0x20]
	ldr r1, [r6, #0x10]
	ldr r1, [r1, #0x30]
	strb r0, [r1, #0x21]
	strb r7, [r1, #0x20]
	b loc_96f0
loc_96d4:
	ldr r1, [r1, #0x38]
	ldr r1, [r1, #4]
	bl sub_93c8
	ldr r0, [r6, #0x10]
	bl sub_98d8
	cmp r4, #0
	mvnge r4, #0
loc_96f0:
	ldr r3, [r6, #0x20]
	teq r3, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r2, r4
	mov r1, r5
	ldr r0, [r6, #0x1c]
	mov lr, pc
	mov pc, r3
	str r7, [r6, #0x20]
	str r7, [r6, #0x1c]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_971c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	add r6, r1, #0x34
	ldmia r6, {r0, r6}
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
loc_9740:
	ldr r0, [r4, #0x34]
	ldr r1, [r0]
	mov lr, pc
	ldr pc, [r1, #0xc]
	ldr r0, [r4, #0x34]
	ldr r0, [r0]
	ldr r0, [r0, #0x14]
	ldr r1, [r0]
	mov r1, r1, lsr #16
	mov r0, r5
	bl sub_88b8
	teq r0, #0
	ldrne r1, [r0, #4]
	subne r1, r1, #1
	strne r1, [r0, #4]!
	ldr r0, [r4, #0x34]
	mov r7, r0
	bl sub_8bd8
	mov r1, r7
	mov r0, r5
	bl sub_84ec
	ldr r0, [r6]
	mov r0, r0, lsr #16
	tst r0, #0x20
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r0, [r4, #0x34]
	teq r0, #0
	bne loc_9740
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_97b4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r1, #0x38]
	ldr r6, [r0, #0xc]!
	mov r0, r1
	ldr r5, [r6, #0x38]
	bl sub_98d8
	ldr r0, [r5, #8]
	cmn r0, #1
	beq loc_9814
	ldr r3, [r5, #0x20]
	teq r3, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r6
	mov r2, #1
	ldr r0, [r5, #0x1c]
	mov lr, pc
	mov pc, r3
	mov r0, #0
	str r0, [r5, #0x20]
	str r0, [r5, #0x1c]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_9814:
	ldr r1, [r5, #0x10]
	teq r1, #0
	beq loc_9870
	ldr r4, [r1, #0x38]
	mov r2, r1
	mov r1, r6
	mov r0, #0xd
	add r0, r0, #0x5300
	ldr r3, [r4, #4]
	bl sub_8c28
	movs r1, r0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r0, [r4]
	mov r0, r0, lsr #16
	orr r0, r0, #4
	strb r0, [r4, #1]
	mov r0, r0, asr #8
	strb r0, [r4]
	ldr r0, [r6, #0x30]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	ldr pc, [r2]
loc_9870:
	ldr r0, [r5]
	mov r0, r0, lsr #16
	tst r0, #0x10
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r6
	mov r0, r4
	bl sub_971c
	ldr r0, [r5, #0xc]
	teq r0, #0
	beq loc_98a8
	mov r1, r6
	mov r0, r4
	bl sub_97b4
	b loc_98c8
loc_98a8:
	ldr r0, [r5, #0x20]
	movs r3, r0
	beq loc_98c8
	mov r1, r6
	mov r2, #1
	ldr r0, [r5, #0x1c]!
	mov lr, pc
	mov pc, r3
loc_98c8:
	mov r1, r6
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_84ec

sub_98d8:
	ldr r1, [r0, #0x38]
	ldr r2, [r1, #0xc]
	ldr ip, [r2, #0x38]
	ldr r3, [r1, #0x18]
	teq r3, #0
	ldreq r3, [r1, #0x14]
	streq r3, [ip, #0x10]!
	ldrne ip, [r1, #0x14]
	ldrne r3, [r3, #0x38]
	strne ip, [r3, #0x14]!
	ldr r3, [r1, #0x14]
	teq r3, #0
	ldrne ip, [r1, #0x18]
	ldrne r3, [r3, #0x38]
	strne ip, [r3, #0x18]!
	mov r3, #0
	str r3, [r1, #0x14]
	str r3, [r1, #0xc]
	str r3, [r1, #4]!
	ldr r1, [r2]
	str r1, [r0]
	ldr r1, [r2, #4]
	str r1, [r0, #4]
	ldr r1, [r2, #0x30]
	ldr r1, [r1]
	ldr r3, [r0, #0x30]
	str r1, [r3]
	ldr r1, [r2, #0x30]!
	ldr r1, [r1, #4]
	ldr r0, [r0, #0x30]
	str r1, [r0, #4]!
	mov pc, lr

sub_9958:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	sub sp, sp, #8
	ldr r0, [r1, #0xc]
	movs r0, r0, lsr #16
	mvnne r0, #4
	bne loc_9bc0
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	mov r2, #1
	mov r1, #0
	teq r0, #0
	beq loc_99b8
loc_999c:
	strb r2, [r0, #0x2b]
	strb r1, [r0, #0x2a]
	strb r1, [r0, #0x2d]
	strb r1, [r0, #0x2c]
	ldr r0, [r0, #0x10]
	teq r0, #0
	bne loc_999c
loc_99b8:
	ldr r0, [r5, #0xc]
	str r0, [sp]
	mvn sb, #0x20
	ldr r1, [r0, #4]
	cmp r1, #8
	bhs loc_99e0
	teq r1, #0
	beq loc_99e0
loc_99d8:
	mov r0, sb
	b loc_9bc0
loc_99e0:
	ldr r2, [r0, #8]
	add r0, r0, r2
	teq r1, #0
	moveq r8, #0
	moveq r7, #0
	beq loc_9a08
	ldr r8, [r0, #4]
	add r0, r0, #2
	bl sub_7668
	mov r7, r0
loc_9a08:
	tst r7, #0x8000
	mvnne r0, #0x23
	bne loc_9bc0
	mov r0, #0

sub_9a18:
	add r1, r6, r0, lsl #2
	ldr sl, [r1, #0x58]!
	teq sl, #0
	beq loc_9a48
	ldr r1, [sl, #0x2c]
	ldr r2, [r1, #0xc]
	teq r2, r8
	beq loc_9a54
	teq r8, #0
	ldreq r1, [r1, #0x10]
	teqeq r1, #1
	beq loc_9a54
loc_9a48:
	add r0, r0, #1
	cmp r0, #4
	blo sub_9a18
loc_9a54:
	ldr r1, [sp]
	ldr r1, [r1, #0xc]
	teq r1, #0
	bne loc_9a94
	teq r0, #4
	beq loc_99d8
	mov r1, #1
	strb r1, [r4, #0xd]
	mov r0, #0
	strb r0, [r4, #0xc]
	strb r1, [r4, #7]
	strb r0, [r4, #6]
	mov r1, #8
	strb r1, [r4, #3]
	strb r0, [r4, #2]
	b loc_9b04
loc_9a94:
	ldr sb, [r6, #0x40]
	teq sb, #0
	beq loc_9acc
loc_9aa0:
	ldr r0, [sb, #0x24]
	teq r0, r8
	bne loc_9ac0
	add r0, sb, #0x22
	bl sub_7668
	teq r0, r7
	mvneq r0, #0x22
	beq loc_9bc0
loc_9ac0:
	ldr sb, [sb, #0x78]
	teq sb, #0
	bne loc_9aa0
loc_9acc:
	mov r0, #2
	strb r0, [r4, #0xd]
	mov r1, #0
	strb r1, [r4, #0xc]
	strb r1, [r4, #7]
	strb r1, [r4, #6]
	mov r0, #7
	strb r0, [r4, #3]
	strb r1, [r4, #2]
	add r1, r6, #0x40
	mov r2, r4
	mov r0, r6
	mov r3, #5
	bl sub_ed74
loc_9b04:
	add sb, r4, #0x20
	mov r0, #2
	str sb, [sp, #4]
	strb r0, [sb, #1]
	mov r0, #0
	strb r0, [sb]
	add r0, sb, #2
	mov r1, r7
	bl sub_76a0
	add r0, r4, #0x1a
	mov r1, r7
	str r8, [sb, #4]!
	bl sub_76a0
	str sl, [r4, #0x48]
	ldr r1, [sp]
	ldr r0, [r1, #0xc]!
	strb r0, [r4, #5]
	mov r0, r0, asr #8
	strb r0, [r4, #4]
	mov r1, r5
	mov r0, r6
	mov r3, #0x83
	mov r2, #0x18
	bl sub_ec50
	mov r5, r0
	ldr r0, [r0, #0xc]
	mov r1, #0x11
	str r1, [r0]
	mov r1, #8
	str r1, [r0, #4]
	mov r1, #0x10
	str r1, [r0, #8]
	ldr r1, [r4, #4]
	mov r1, r1, lsr #16
	str r1, [r0, #0xc]!
	ldr r1, [sp, #4]
	ldr r0, [r5, #0xc]
	add r0, r0, #0x10
	mov r2, #8
	bl memcpy
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
loc_9bc0:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_9bc4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	ldr r0, [r1, #0xc]
	mov r0, r0, lsr #16
	mov r8, #1
	mov r7, #0
	teq r0, #1
	teqne r0, #2
	beq loc_9c1c
	teq r0, #0xb
	mvnne r0, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	strb r8, [r4, #0xb]
	strb r7, [r4, #0xa]
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	b loc_9cb0
loc_9c1c:
	ldr r0, [r4, #2]
	mov r0, r0, lsr #16
	teq r0, #7
	bne loc_9c44
	add r1, r5, #0x40
	mov r2, r4
	mov r0, r5
	mov r3, #5
	bl sub_edc8
	b loc_9c80
loc_9c44:
	add r0, r4, #0x22
	bl sub_7668
	tst r0, #0x8000
	beq loc_9c80
	ldr r1, [r4, #6]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_9c80
	mov r2, r0, lsl #17
	mov r2, r2, lsr #17
	add r1, r5, #0xec
	mov r0, r5
	bl sub_cbf0
	strb r7, [r4, #0x23]
	strb r7, [r4, #0x22]
loc_9c80:
	strb r7, [r4, #0xb]
	strb r7, [r4, #0xa]
	strb r7, [r4, #0xd]
	strb r7, [r4, #0xc]
	strb r7, [r4, #3]
	strb r7, [r4, #2]
	mov r2, r6
	str r7, [r4, #0x48]
	mov r1, r4
	mov r0, r5
	mov r3, #7
	bl sub_eb80
loc_9cb0:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_9cb8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov lr, r2
	mov r1, r2
	mov r3, #0x83
	mov r2, #0x28
	bl sub_ec50
	mov lr, r0
	ldr r0, [r0, #0xc]
	ldr r6, lit_9d30
	mov r5, r0
	ldmia r6!, {r1, r2, r3, ip}
	stmia r5!, {r1, r2, r3, ip}
	ldmia r6!, {r1, r2, r3, ip}
	stmia r5!, {r1, r2, r3, ip}
	ldmia r6, {r3, ip}
	stmia r5, {r3, ip}
	ldr r1, [r4, #0xc]
	mov r1, r1, lsr #16
	str r1, [r0, #0x24]!
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, lr
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_9d30:
	.rword data_11a5c			; relocated

sub_9d34:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	ldr r0, [r1, #0xc]
	mov r0, r0, lsr #16
	mov r8, #0
	teq r0, #1
	beq loc_9da0
	teq r0, #2
	mvnne r0, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, #1
	strb r0, [r4, #0xd]
	strb r8, [r4, #0xc]
	strb r0, [r4, #7]
	strb r8, [r4, #6]
	mov r0, #8
	strb r0, [r4, #3]
	strb r8, [r4, #2]
	add r1, r5, #0x40
	mov r2, r4
	mov r0, r5
	mov r3, #5
	bl sub_edc8
loc_9da0:
	mvn sb, #0x20
	ldr r7, [r4, #0x48]
	teq r7, #0
	beq sub_9e84
	ldr r0, [r4, #0x34]
	teq r0, #0
	bne loc_9ddc
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x24]
	mov r0, r0, lsl #1
	bl sub_7b9c
	str r0, [r4, #0x34]
	teq r0, #0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_9ddc:
	mov r8, #0
	strb r8, [r4, #0x3b]
	strb r8, [r4, #0x3a]
	strb r8, [r4, #0x39]
	strb r8, [r4, #0x38]
	str r8, [r4, #0x3c]
	ldr r0, [r4, #0x22]
	movs r0, r0, lsr #16
	bne loc_9e48
	add r1, r5, #0xec
	mov r0, r5
	bl sub_cabc
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	sub ip, r0, #0xff00
	teq ip, #0xff
	mvneq r0, #0x21
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	orr r8, r0, #0x8000
	add r0, r4, #0x22
	mov r1, r8
	bl sub_76a0
	add r0, r4, #0x1a
	mov r1, r8
	bl sub_76a0
loc_9e48:
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0xc]
	str r0, [r4, #0x24]
	ldr r0, [r6, #0xc]
	mov sl, r0
	ldr r1, [r0, #4]
	cmp r1, #8
	blo sub_9e84
	ldr r1, [r0, #8]
	add r8, r0, r1
	mov r1, #0
	ldr r0, [r8, #4]
	bl sub_7460
	teq r0, #0
	beq loc_9e8c

sub_9e84:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_9e8c:
	add r0, r4, #0x28
	mov r1, r8
	mov r2, #8
	bl memcpy
	ldr r0, [r8, #2]
	mov r0, r0, lsr #16
	strb r0, [r4, #0x19]
	mov r0, r0, asr #8
	strb r0, [r4, #0x18]
	ldr r0, [r8, #4]!
	str r0, [r4, #0x1c]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x18]
	strb r0, [r4, #0xa7]
	mov r0, r0, asr #8
	strb r0, [r4, #0xa6]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x1c]
	strb r0, [r4, #0xa9]
	mov r0, r0, asr #8
	strb r0, [r4, #0xa8]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x30]
	mov r0, r0, lsl #1
	strb r0, [r4, #0xab]
	mov r0, r0, asr #8
	strb r0, [r4, #0xaa]
	ldr r0, [sl, #0xc]
	teq r0, #1
	movne r8, #0
	strbne r8, [r4, #9]
	strbne r8, [r4, #8]
	bne loc_9f28
	ldr r0, [r6, #0xc]!
	ldr r1, [sl, #0x10]!
	ldrb r0, [r0, r1]
	strb r0, [r4, #9]
	mov r0, r0, asr #8
	strb r0, [r4, #8]
loc_9f28:
	mov r0, r5
	bl sub_8b84
	add ip, r0, r0, lsl #1
	rsb r0, ip, r0, lsl #7
	add r0, r0, r0, lsl #2
	add r0, r0, r0, lsl #2
	mvn r1, #0xc0000000
	and r0, r1, r0, lsl #3
	str r0, [r4, #0xb0]
	str r0, [r4, #0xb4]
	add r0, r0, #1
	str r0, [r4, #0xb8]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x38]
	strb r0, [r4, #0xdd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xdc]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x38]
	strb r0, [r4, #0xdf]
	mov r0, r0, asr #8
	strb r0, [r4, #0xde]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x3c]
	strb r0, [r4, #0xe1]
	mov r0, r0, asr #8
	strb r0, [r4, #0xe0]
	ldr r0, [r7, #0x2c]
	ldr r0, [r0, #0x40]
	strb r0, [r4, #0xe3]
	mov r0, r0, asr #8
	strb r0, [r4, #0xe2]
	mov r0, #3
	strb r0, [r4, #0xd]
	mov r8, #0
	strb r8, [r4, #0xc]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e03c
	strb r8, [r4, #0xad]
	strb r8, [r4, #0xac]
	mov r2, r4
	mov r1, r7
	mov r0, r5
	bl sub_eeec
	mov r3, #0
	mov r1, #0
	ldr r2, [r4, #0xb0]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #2
	mov r2, #0
	bl sub_dc28
	mov r0, #0x13
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_a00c:
	stmdb sp!, {r4, r5, lr}
	mov ip, r0
	ldr r5, [r1, #0x24]!
	ldr r4, [r2]
	mov r4, r4, lsr #16
	mov r0, #0
	mov r3, r0
	mov lr, r0
	ldr r1, [ip, #0x40]!
	teq r1, #0
	ldmiaeq sp!, {r4, r5, pc}
loc_a038:
	ldr ip, [r1, #0x24]
	ldr r2, [r1, #0x22]
	mov r2, r2, lsr #16
	teq ip, r5
	bne loc_a064
	teq r2, r4
	moveq r0, r1
	ldmiaeq sp!, {r4, r5, pc}
	teq r2, #0
	moveq lr, r1
	b loc_a080
loc_a064:
	teq r2, r4
	teqeq ip, #0
	moveq r3, r1
	beq loc_a080
	teq r2, #0
	teqeq ip, #0
	moveq r0, r1
loc_a080:
	ldr r1, [r1, #0x78]
	teq r1, #0
	bne loc_a038
	teq r3, #0
	movne r0, r3
	ldmiane sp!, {r4, r5, pc}
	teq lr, #0
	movne r0, lr
	ldmia sp!, {r4, r5, pc}

sub_a0a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, r2
	mov r6, r3
	ldrb r0, [r1, #0x92]
	tst r0, #4
	beq loc_a0e0
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, #0x83
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a0e0:
	tst r0, #0x10
	beq loc_a100
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_de1c
	mov r0, #0xc
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a100:
	tst r0, #2
	mov sb, #0xd
	beq loc_a11c
	mov r0, r5
	bl sub_c910
	movs r8, r0
	bne loc_a12c
loc_a11c:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	b loc_a19c
loc_a12c:
	mov r0, #0x10
	bl sub_7b9c
	movs sl, r0
	bne loc_a158
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r1, r8
	mov r0, r5
	bl sub_c960
	b loc_a19c
loc_a158:
	stmia sl, {r7, r8}
	ldr r0, [r5, #0x54]
	str r0, [sl, #0xc]
	teq r0, #0
	ldrne r0, [r5, #0x54]
	strne sl, [r0, #8]!
	streq sl, [r5, #0x50]
	mov r0, #0
	str sl, [r5, #0x54]
	str r0, [sl, #8]
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x24]
	mov r0, r0, lsl #1
	bl sub_7b9c
	str r0, [r8, #0x34]
	teq r0, #0
	bne loc_a1a4
loc_a19c:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a1a4:
	mov sb, #0
	strb sb, [r8, #0x3b]
	strb sb, [r8, #0x3a]
	strb sb, [r8, #0x39]
	strb sb, [r8, #0x38]
	str sb, [r8, #0x3c]
	strb sb, [r8, #7]
	strb sb, [r8, #6]
	mov r0, #8
	strb r0, [r8, #3]
	strb sb, [r8, #2]
	mov r0, #0xff
	strb r0, [r8, #1]
	strb r0, [r8]
	add r1, r4, #0x7c
	add r0, r8, #0x18
	mov r2, #8
	bl memcpy
	ldr r0, [r4, #0x24]
	str r0, [r8, #0x24]
	ldr r0, [r4, #0x7e]
	mov r0, r0, lsr #16
	strb r0, [r8, #0x23]
	mov r0, r0, asr #8
	strb r0, [r8, #0x22]
	ldr r0, [r4, #0x80]
	str r0, [r8, #0x2c]
	ldr r0, [r4, #0x7c]
	mov r0, r0, lsr #16
	strb r0, [r8, #0x2b]
	mov r0, r0, asr #8
	strb r0, [r8, #0x2a]
	mov r0, #2
	strb r0, [r8, #0x29]
	strb sb, [r8, #0x28]
	strb r0, [r8, #0x21]
	strb sb, [r8, #0x20]
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x18]
	strb r0, [r8, #0xa7]
	mov r0, r0, asr #8
	strb r0, [r8, #0xa6]
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x1c]
	strb r0, [r8, #0xa9]
	mov r0, r0, asr #8
	strb r0, [r8, #0xa8]
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x30]
	mov r0, r0, lsl #1
	strb r0, [r8, #0xab]
	mov r0, r0, asr #8
	strb r0, [r8, #0xaa]
	mov r0, #4
	strb r0, [r8, #0xd]
	strb sb, [r8, #0xc]
	ldr r0, [r4, #0x84]
	add r0, r0, #1
	str r0, [r8, #0xd4]
	str r0, [r8, #0xd8]
	ldr r0, [r4, #0x84]
	str r0, [r8, #0xc8]
	ldr r0, [r4, #0x84]
	str r0, [r8, #0xd0]
	ldr r0, [r4, #0x90]
	mov r0, r0, lsr #16
	strb r0, [r8, #0xc3]
	mov r0, r0, asr #8
	strb r0, [r8, #0xc2]
	ldr r0, [r8, #0xc2]
	movs r0, r0, lsr #16
	beq loc_a2d0
	ldr r1, [r4, #0x22]
	cmp r0, r1, lsr #16
	ble sub_a2e4
loc_a2d0:
	ldr r0, [r4, #0x22]
	mov r0, r0, lsr #16
	strb r0, [r8, #0xc3]
	mov r0, r0, asr #8
	strb r0, [r8, #0xc2]

sub_a2e4:
	ldr r0, [r4, #0x8e]
	mov r0, r0, lsr #16
	strb r0, [r8, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r8, #0xc4]
	mov r2, r8
	mov r1, r4
	mov r0, r5
	bl sub_eeec
	mov r1, r6
	mov r0, r5
	mov r3, #1
	mov r2, #0x20
	bl sub_ec50
	mov r6, r0
	ldr r0, [r0, #0xc]
	mov r1, #0xb
	str r1, [r0]
	mov r1, #8
	str r1, [r0, #4]
	mov r1, #0x18
	add r0, r0, #8
	stmia r0, {r1, sb}
	add r1, r8, #0x28
	add r0, r0, #8
	stmia r0, {sb, sl}
	ldr r0, [r6, #0xc]
	add r0, r0, #0x18
	mov r2, #8
	bl memcpy
	ldr r0, [r7, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, r6
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #0x81
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_a37c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	ldr sl, [r2, #0xc]
	ldr sb, [r0, #0x50]
	mvn r0, #0x17
	teq sb, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r1, [sl, #0x10]
loc_a3ac:
	teq r1, sb
	beq loc_a3c4
	ldr sb, [sb, #8]
	teq sb, #0
	bne loc_a3ac
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a3c4:
	teq sb, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r7, [sb, #4]
	ldr r1, [r7, #0x48]
	ldr r1, [r1, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	mvnne r0, #0xf
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r1, [r5, #2]
	mov r1, r1, lsr #16
	teq r1, #7
	bne loc_a440
	ldr r1, [sb]
	teq r1, r5
	mvnne r0, #7
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r8, [r4, #0x20]
	teq r8, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r1, [sl, #4]
loc_a418:
	ldr r2, [r8, #0x14]
	teq r2, r1
	beq loc_a434
	ldr r8, [r8, #0x58]
	teq r8, #0
	bne loc_a418
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a434:
	teq r8, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	b loc_a444
loc_a440:
	mov r8, r5
loc_a444:
	ldr r0, [r8, #0xc]
	mov r0, r0, lsr #16
	teq r0, #1
	mvnne r0, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r1, sb
	mov r0, r4
	bl sub_a8a4
	add r0, r8, #0x22
	bl sub_7668
	tst r0, #0x8000
	beq loc_a488
	mov r2, r0, lsl #17
	mov r2, r2, lsr #17
	add r1, r4, #0xec
	mov r0, r4
	bl sub_cbf0
loc_a488:
	ldr r0, [r8, #0x14]
	str r0, [r7, #0x14]
	ldr r1, [r8, #0x10]
	str r1, [r7, #0x10]
	str r7, [r0, #0x18]!
	ldr r0, [r7, #0x10]
	str r7, [r0, #0x18]!
	ldr r0, [r8]
	mov r0, r0, lsr #16
	strb r0, [r7, #1]
	mov r0, r0, asr #8
	strb r0, [r7]
	mov r1, r8
	mov r0, r4
	bl sub_c960
	mov r8, #0
	ldr r0, [sl, #8]
	teq r0, #1
	strbne r8, [r7, #9]
	strbne r8, [r7, #8]
	bne loc_a4f4
	ldr r0, [r6, #0xc]
	ldr r1, [sl, #0xc]!
	ldrb r0, [r0, r1]
	strb r0, [r7, #9]
	mov r0, r0, asr #8
	strb r0, [r7, #8]
loc_a4f4:
	mov r0, r4
	bl sub_8b84
	add ip, r0, r0, lsl #1
	rsb r0, ip, r0, lsl #7
	add r0, r0, r0, lsl #2
	add r0, r0, r0, lsl #2
	mov r1, #0xee0
	add r1, r1, #0x2000
	add r0, r1, r0, lsl #3
	bic r2, r0, #0x80000000
	str r2, [r7, #0xb0]
	ldr r0, [r7, #0x48]
	ldr r1, [r0, #0x2c]
	ldr r1, [r1, #0x38]
	strb r1, [r7, #0xdd]
	mov r1, r1, asr #8
	strb r1, [r7, #0xdc]
	ldr r1, [r0, #0x2c]
	ldr r1, [r1, #0x38]
	strb r1, [r7, #0xdf]
	mov r1, r1, asr #8
	strb r1, [r7, #0xde]
	ldr r1, [r0, #0x2c]
	ldr r1, [r1, #0x3c]
	strb r1, [r7, #0xe1]
	mov r1, r1, asr #8
	strb r1, [r7, #0xe0]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x40]
	strb r0, [r7, #0xe3]
	mov r0, r0, asr #8
	strb r0, [r7, #0xe2]
	mov r1, #0
	ldr r3, [r7, #0xd4]
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r7
	mov r0, r4
	mov r3, #0x12
	bl sub_dc28
	add sp, sp, #0xc
	mov r1, r7
	mov r0, r4
	mov r2, #1
	bl sub_e03c
	strb r8, [r7, #0xad]
	strb r8, [r7, #0xac]
	ldr r0, [r7, #0xb0]
	add r1, r0, #1
	add r7, r7, #0xb4
	stmia r7, {r0, r1}
	str r0, [r7, #0x18]
	sub r7, r7, #0xb4
	mov r0, #4
	strb r0, [r7, #0xd]
	strb r8, [r7, #0xc]
	ldr r0, [r5, #2]
	mov r0, r0, lsr #16
	teq r0, #7
	streq r5, [r7, #0x30]!
	streq sb, [r7, #0x14]!
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_a5f0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r5, r1
	mov r4, r2
	mov r6, r3
	ldrb r0, [r1, #0x92]
	tst r0, #0x10
	mov sl, #0xc
	ldrne r2, [r5, #0x88]
	ldrne r1, [r4, #0xb8]
	teqne r2, r1
	beq loc_a66c
	tst r0, #4
	beq loc_a640
	mov r1, r6
	mov r0, r7
	bl sub_7ed0
	b loc_a664
loc_a640:
	mov r3, #0
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r7
	mov r3, #4
	bl sub_dc28
	add sp, sp, #0xc
loc_a664:
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a66c:
	tst r0, #4
	beq loc_a690
	mov r2, r6
	mov r1, r4
	mov r0, r7
	mvn r3, #0
	bl sub_b618
	mov r0, #0x83
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a690:
	tst r0, #2
	bne loc_a6ac
	mov r1, r6
	mov r0, r7
	bl sub_7ed0
	mov r0, #0xd
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_a6ac:
	ldr r0, [r5, #0x84]
	add r0, r0, #1
	str r0, [r4, #0xd4]
	mov r3, r0
	str r0, [r4, #0xd8]
	ldr r0, [r5, #0x84]
	str r0, [r4, #0xd0]
	ldr r0, [r5, #0x84]
	str r0, [r4, #0xc8]
	ldrb r0, [r5, #0x92]
	tst r0, #0x10
	beq loc_a6ec
	ldr r0, [r5, #0x88]
	str r0, [r4, #0xb4]
	ldr r0, [r5, #0x88]
	str r0, [r4, #0xcc]
loc_a6ec:
	mov sb, #0x81
	mov r8, #0
	ldr r0, [r4, #0xb4]
	ldr r2, [r4, #0xb0]
	teq r0, r2
	bne loc_a734
	mov r0, #4
	strb r0, [r4, #0xd]
	strb r8, [r4, #0xc]
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r7
	mov r3, #0x12
	bl sub_dc28
	add sp, sp, #0xc
	b loc_a844
loc_a734:
	mov r0, #5
	strb r0, [r4, #0xd]
	strb r8, [r4, #0xc]
	mov r1, #0
	ldr r2, [r4, #0xb8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r7
	mov r3, #0x10
	bl sub_dc28
	add sp, sp, #0xc
	ldr r0, [r5, #0x2a]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r5, #0x2b]
	mov r0, r0, asr #8
	strb r0, [r5, #0x2a]
	mov r1, r4
	mov r0, r7
	mov r2, #1
	bl sub_e0a8
	ldr r0, [r5, #0x90]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xc3]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc2]
	ldr r0, [r4, #0xc2]
	movs r0, r0, lsr #16
	beq loc_a7b8
	ldr r1, [r5, #0x22]
	cmp r0, r1, lsr #16
	ble sub_a7cc
loc_a7b8:
	ldr r0, [r5, #0x22]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xc3]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc2]

sub_a7cc:
	ldr r0, [r5, #0x8e]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	mov r0, r7
	mov r3, #1
	mov r2, #0x1c
	mov r1, #0
	bl sub_ec50
	mov r6, r0
	ldr r0, [r0, #0xc]
	mov r1, #8
	str r1, [r0, #4]
	mov r1, #0x14
	add r0, r0, #8
	stmia r0, {r1, r8}
	str sl, [r0, #-8]!
	add r1, r4, #0x28
	str r8, [r0, #0x10]!
	ldr r0, [r6, #0xc]
	add r0, r0, #0x14
	mov r2, #8
	bl memcpy
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, r6
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_a844:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_a84c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	mov r6, r3
	ldr r3, [r2, #0xd4]
	ldr r2, [r2, #0xb8]
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r3, #4
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	mov r2, r6
	mov r1, r4
	mov r0, r5
	mvn r3, #4
	bl sub_b618
	mov r0, #0x81
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_a8a4:
	ldr r2, [r1, #0xc]
	teq r2, #0
	ldrne r3, [r1, #8]
	strne r3, [r2, #8]!
	ldreq r2, [r1, #8]
	streq r2, [r0, #0x50]
	ldr r2, [r1, #8]
	teq r2, #0
	ldrne r0, [r1, #0xc]
	strne r0, [r2, #0xc]!
	ldreq r2, [r1, #0xc]
	streq r2, [r0, #0x54]!
	mov r0, r1
	b sub_7be0

sub_a8dc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	ldr r0, [r1, #0xc]
	mov r0, r0, lsr #16
	teq r0, #5
	teqne r0, #8
	mvnne r0, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r5, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0
	ldrne r7, [r5, #8]
	moveq r7, r5
	mov r1, r7
	mov r0, r6
	mov r2, #0
	bl sub_7860
	mov sb, r0, lsl #16
	movs sb, sb, lsr #16
	mov r8, #1
	bne loc_a950
	mov r1, r5
	mov r0, r6
	bl sub_7ed0
	b loc_a9cc
loc_a950:
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	ldrne r0, [r4, #0xc4]
	movne r0, r0, lsr #16
	teqne r0, #0
	beq loc_a980
	ldr r0, [r4, #0xf4]
	movs r0, r0, lsr #16
	beq loc_a988
loc_a980:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_a988:
	str r7, [r4, #0xe8]
	teq r7, r5
	movne r1, r5
	movne r0, r6
	blne sub_7e90
	strb sb, [r4, #0xf5]
	mov r0, sb, asr #8
	strb r0, [r4, #0xf4]
	ldr r0, [r4, #0xec]
	teq r0, #0
	bne loc_a9c0
	mov r0, r6
	bl sub_8b84
	str r0, [r4, #0x40]
loc_a9c0:
	mov r1, r4
	mov r0, r6
	bl sub_a9d4
loc_a9cc:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_a9d4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r6, [r1, #0xf4]
	mov r6, r6, lsr #16
	ldr r7, [r1, #0xc2]
	mov r7, r7, lsr #16
	ldr r0, [r1, #0xc4]
	mov r0, r0, lsr #16
	cmp r0, r6
	cmplt r0, r7
	ldmdblt fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r4, #0xfa]
	movs r0, r0, lsr #16
	ldrne r0, [r4, #0xf8]
	movne r0, r0, lsr #16
	teqne r0, #0
	beq loc_aa34
	ldr r0, [r4, #0xc0]
	mov r0, r0, asr #16
	cmp r0, #2
	ldmdble fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_aa34:
	mov sb, #0
	cmp r6, r7
	ble sub_aab8
	mov r0, r5
	ldr r1, [r4, #0xe8]
	bl sub_7e24
	movs r8, r0
	bne loc_aa6c
	ldr r2, [r4, #0xe8]
	mov r1, r4
	mov r0, r5
	mvn r3, #0
	bl sub_eae8
	b loc_ab04
loc_aa6c:
	mov r2, r7
	mov r1, r8
	mov r0, r5
	bl sub_77f8
	mov r2, r7
	mov r0, r5
	ldr r1, [r4, #0xe8]
	bl sub_779c
	str r0, [r4, #0xe8]
	ldr r0, [r4, #0xf4]
	mov r0, r0, lsr #16
	sub r0, r0, r7
	strb r0, [r4, #0xf5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf4]
	mov r6, r7
	ldr r0, [r4, #0x10]
	bl sub_84a0
	b loc_aac8

sub_aab8:
	ldr r8, [r4, #0xe8]
	str sb, [r4, #0xe8]
	strb sb, [r4, #0xf5]
	strb sb, [r4, #0xf4]
loc_aac8:
	mov r1, r8
	mov r0, r5
	bl sub_7e24
	movs r2, r0
	bne loc_ab14
	mov r2, r8
	mov r1, r4
	mov r0, r5
	mvn r3, #0
	bl sub_eae8
	ldr r1, [r4, #0xe8]
	teq r1, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov r0, r5
	bl sub_7ed0
loc_ab04:
	str sb, [r4, #0xe8]
	strb sb, [r4, #0xf5]
	strb sb, [r4, #0xf4]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_ab14:
	ldr r1, [r4, #0xec]
	teq r1, #0
	beq loc_ab2c
	mov r0, r5
	bl sub_7f00
	b loc_ab40
loc_ab2c:
	str r2, [r4, #0xec]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e03c
loc_ab40:
	ldr r0, [r4, #0xf8]
	mov r0, r0, lsr #16
	add r0, r0, r6
	strb r0, [r4, #0xf9]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf8]
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	bne loc_ab78
	ldr r2, [r4, #0xe2]
	mov r2, r2, lsr #16
	mov r1, r4
	mov r0, r5
	bl sub_ae3c
loc_ab78:
	mov r1, r6
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r8
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	bl sub_dc28
	add sp, sp, #0xc
	ldr r0, [r4, #0xb8]
	add r0, r0, r6
	str r0, [r4, #0xb8]
	ldr r0, [r4, #0xc4]
	mov r0, r0, lsr #16
	sub r0, r0, r6
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	ldr r0, [r4, #0xf4]
	movs r0, r0, lsr #16
	ldreq r0, [r4, #0x10]
	ldreq r0, [r0, #8]
	teqeq r0, #0
	beq loc_ac18
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	bne loc_ac10
	ldr r0, [r4, #0x48]
	add r1, r0, #0x6c
	mov r2, r4
	mov r0, r5
	mov r3, #6
	bl sub_ed74
	b loc_ac18
loc_ac10:
	ldr r0, [r4, #0x10]
	bl sub_84a0
loc_ac18:
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	teq r0, #6
	teqne r0, #9
	teqne r0, #0xa
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r4, #0xf4]
	movs r0, r0, lsr #16
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r4, #0xc4]
	movs r0, r0, lsr #16
	moveq r0, #1
	strbeq r0, [r4, #0xc7]
	strbeq sb, [r4, #0xc6]
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x11
	mov r2, #0
	bl sub_dc28
	ldr r0, [r4, #0xb8]
	add r0, r0, #1
	str r0, [r4, #0xb8]
	ldr r0, [r4, #0xc4]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_aca0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	mov r6, r3
	ldr r0, [r2, #0xc]
	mov r0, r0, lsr #16
	sub r2, r0, #5
	mov r0, #0x84
	cmp r2, #6
	addls pc, pc, r2, lsl #2
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_acd4:
	b loc_ad00

sub_acd8:
	b loc_ad00

sub_acdc:
	b loc_ad00

sub_ace0:
	b loc_acec

sub_ace4:
	b loc_acec

sub_ace8:
	b loc_acec
loc_acec:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, #0xd
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_ad00:
	ldr r7, [r1, #0x8c]
	movs r7, r7, lsr #16
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r8, [r6, #8]
	ldrb r0, [r1, #0x92]
	tst r0, #8
	mov sb, #0
	movne r0, #1
	strbne r0, [r4, #0xe7]
	strbne sb, [r4, #0xe6]
	ldr r0, [r4, #0xd4]
	add r0, r0, r7
	str r0, [r4, #0xd4]
	ldr r0, [r4, #0xdc]
	mov r0, r0, lsr #16
	sub r0, r0, r7
	strb r0, [r4, #0xdd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xdc]
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	beq loc_ad7c
	add r0, r0, r7
	strb r0, [r4, #0xf7]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf6]
	mov r2, r8
	mov r0, r5
	ldr r1, [r4, #0xf0]
	bl sub_7f00
	b loc_ae00
loc_ad7c:
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_adf0
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	mov r1, r8
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	ldr r2, [r4, #0xe0]
	mov r2, r2, lsr #16
	mov r1, r4
	mov r0, r5
	bl sub_ae3c
	teq r0, #1
	bne loc_ae00
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	b loc_ae00
loc_adf0:
	strb r7, [r4, #0xf7]
	mov r0, r7, asr #8
	strb r0, [r4, #0xf6]
	str r8, [r4, #0xf0]
loc_ae00:
	ldr r1, [r4, #0xdc]
	mov r1, r1, lsr #16
	ldr r0, [r4, #0xde]
	teq r1, r0, lsr #16
	beq loc_ae30
	ldr r0, [r4, #0x94]
	teq r0, #0
	bne loc_ae30
	mov r1, r4
	mov r0, r5
	mov r2, #0
	bl sub_e03c
loc_ae30:
	mov r0, #0x80
	str sb, [r6, #8]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_ae3c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r1, #0xe6]
	mov r1, r1, lsr #16
	mov r5, #0
	teq r1, #1
	beq loc_ae70
	ldr r1, [r4, #0xdc]
	cmp r2, r1, lsr #16
	movlo r0, r5
	ldmdblo fp, {r4, r5, fp, sp, pc}
loc_ae70:
	mov r1, r4
	mov r2, #0
	bl sub_e0a8
	ldr r0, [r4, #0xde]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xdd]
	mov r0, r0, lsr #8
	strb r0, [r4, #0xdc]
	ldr r0, [r4, #0xd4]
	str r0, [r4, #0xd8]
	strb r5, [r4, #0xe7]
	strb r5, [r4, #0xe6]
	mov r0, #1
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_aea8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov sb, r3
	ldr r2, [r1, #0x88]
	ldr r0, [r4, #0xb4]
	sub r8, r2, r0
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	mov r7, #0
	teq r0, #4
	bne loc_af78
	cmp r8, #0
	ldrge r0, [r4, #0xb8]
	subge r0, r0, r2
	cmpge r0, #0
	blt sub_b038
	mov r0, #5
	strb r0, [r4, #0xd]
	strb r7, [r4, #0xc]
	ldr r0, [r4, #0x30]
	teq r0, #0
	moveq r1, r4
	beq loc_af28
	ldr r1, [r5, #0x40]
	teq r1, #0
	beq loc_af48
loc_af20:
	teq r0, r1
	bne loc_af3c
loc_af28:
	mov r0, r5
	mov r3, #1
	mov r2, #0
	bl sub_eb80
	b loc_af48
loc_af3c:
	ldr r1, [r1, #0x78]
	teq r1, #0
	bne loc_af20
loc_af48:
	str r7, [r4, #0x30]
	str r7, [r4, #0x44]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e0a8
	ldr r0, [r6, #0x2a]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r6, #0x2b]
	mov r0, r0, asr #8
	strb r0, [r6, #0x2a]
loc_af78:
	ldr r0, [r6, #0x88]
	ldr r2, [r4, #0xb8]
	sub r1, r0, r2
	mov sl, #0xd
	cmp r1, #0
	ldrgt r1, [r4, #0xbc]
	cmpgt r0, r1
	ldrgt r3, [r4, #0xd8]
	bgt loc_b1b0
	cmp r8, #0
	ble sub_b14c
	strb r7, [r4, #0xc1]
	strb r7, [r4, #0xc0]
	strb r7, [r4, #0xad]
	strb r7, [r4, #0xac]
	ldr r0, [r6, #0x88]
	str r0, [r4, #0xb4]
	ldr r0, [r6, #0x2c]
	ldr r0, [r0, #0x20]
	teq r0, #1
	moveq r1, r4
	moveq r0, r5
	bleq sub_e27c
	ldr r0, [r4, #0xf8]
	mov r0, r0, lsr #16
	cmp r0, r8
	movgt sb, r8
	movle sb, r0
	ldr r1, [r4, #0xec]
	teq r1, #0
	beq loc_b0a4
	mov r2, sb
	mov r0, r5
	bl sub_779c
	str r0, [r4, #0xec]
	teq r0, #0
	bne loc_b060
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	teq r0, #0xa
	teqne r0, #9
	teqne r0, #6
	beq loc_b060
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e0a8
	b loc_b078

sub_b038:
	mov r3, #0
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r2, sb
	mov r1, r4
	mov r0, r5
	mov r3, #4
	bl sub_dc28
	mov r0, #0xc
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_b060:
	strb r7, [r4, #0xad]
	strb r7, [r4, #0xac]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e03c
loc_b078:
	ldr r0, [r4, #0xec]
	teq r0, #0
	strbeq r7, [r4, #0xf9]
	strbeq r7, [r4, #0xf8]
	beq loc_b0a4
	ldr r1, [r4, #0xf8]
	mov r1, r1, lsr #16
	sub r0, r1, sb
	strb r0, [r4, #0xf9]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf8]
loc_b0a4:
	ldr r0, [r4, #0xfa]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_b1d4
	cmp r8, sb
	ble sub_b11c
	sub sb, r8, sb
	mov r2, sb
	mov r0, r5
	ldr r1, [r4, #0xe8]
	bl sub_779c
	str r0, [r4, #0xe8]
	ldr r1, [r4, #0xf4]
	mov r1, r1, lsr #16
	sub r0, r1, sb
	strb r0, [r4, #0xf5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf4]
	ldr r0, [r4, #0xf4]
	movs r0, r0, lsr #16
	strbmi r7, [r4, #0xf5]
	strbmi r7, [r4, #0xf4]
	ldr r0, [r4, #0xb8]
	add r0, r0, sb
	str r0, [r4, #0xb8]
	ldr r0, [r6, #0x8e]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]

sub_b11c:
	add r1, r4, #0xb8
	ldmia r1, {r0, r1}
	cmp r0, r1
	movge r0, #0
	movlt r0, #1
	strb r0, [r4, #0xfb]
	mov r0, r0, asr #8
	strb r0, [r4, #0xfa]
	ldr r0, [r4, #0xfa]
	movs r0, r0, lsr #16
	streq r7, [r4, #0xbc]
	b loc_b1d4

sub_b14c:
	bne loc_b1d4
	ldr r0, [r4, #0xf8]
	movs r0, r0, lsr #16
	beq sub_b1dc
	ldr r0, [r4, #0xc0]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0xc1]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc0]
	ldr r0, [r4, #0xc0]
	mov r0, r0, asr #16
	cmp r0, #3
	blt sub_b1dc
	strb r7, [r4, #0xc1]
	strb r7, [r4, #0xc0]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e0a8
	mov r1, r4
	mov r0, r5
	bl sub_e0f0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
loc_b1b0:
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r2, sb
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	bl sub_dc28
	mov r0, sl
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_b1d4:
	cmp r8, #0
	blt sub_b25c

sub_b1dc:
	ldr r0, [r4, #0xb8]
	ldr r1, [r6, #0x88]
	subs r0, r0, r1
	bmi sub_b25c
	ldr r2, [r6, #0x84]
	ldr r0, [r4, #0xc8]
	sub r3, r2, r0
	cmp r3, #0
	bgt loc_b214
	teq r0, r2
	bne sub_b25c
	ldr r0, [r4, #0xcc]
	subs r0, r1, r0
	bmi sub_b25c
loc_b214:
	ldr r0, [r4, #0xf8]
	mov r0, r0, lsr #16
	ldr r1, [r6, #0x8e]
	mov r1, r1, lsr #16
	cmp r0, r1
	strbgt r7, [r4, #0xc5]
	strbgt r7, [r4, #0xc4]
	bgt loc_b244
	sub r0, r1, r0
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
loc_b244:
	ldr r0, [r6, #0x84]
	str r0, [r4, #0xc8]
	ldr r0, [r6, #0x88]
	str r0, [r4, #0xcc]
	ldr r0, [r4, #0x10]
	bl sub_84a0

sub_b25c:
	ldr r0, [r4, #0xc4]
	movs r0, r0, lsr #16
	beq loc_b2cc
	ldr r0, [r4, #0xc6]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_b2cc
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x11
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	ldr r0, [r4, #0xb8]
	add r0, r0, #1
	str r0, [r4, #0xb8]
	ldr r0, [r4, #0xc4]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	strb r7, [r4, #0xc7]
	strb r7, [r4, #0xc6]
loc_b2cc:
	ldr r1, [r6, #0x88]
	ldr r0, [r4, #0xb8]
	teq r1, r0
	bne loc_b378
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	teq r0, #6
	beq loc_b380
	teq r0, #9
	beq loc_b3a0
	teq r0, #0xa
	bne loc_b378
	mov r1, r4
	mov r0, r5
	bl sub_ee20
	mov r0, #0xb
	strb r0, [r4, #0xd]
	strb r7, [r4, #0xc]
	mov r1, r4
	mov r0, r5
	mov r2, #2
	bl sub_e03c
	ldr r0, [r6, #0x2a]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r6, #0x2b]
	mov r0, r0, asr #8
	strb r0, [r6, #0x2a]
	mov r0, r5
	mov r3, #1
	mov r2, #4
	mov r1, #0
	bl sub_ec50
	mov sb, r0
	mov r0, #0x17
	ldr r1, [sb, #0xc]
	str r0, [r1]
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, sb
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_b378:
	mov r0, #0x84
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_b380:
	mov r0, #7
	strb r0, [r4, #0xd]
	strb r7, [r4, #0xc]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e0a8
	b loc_b378
loc_b3a0:
	mov r1, r4
	mov r0, r5
	bl sub_ee20
	mov r0, #1
	strb r0, [r4, #0xd]
	strb r7, [r4, #0xc]
	mov r2, r4
	mov r1, r6
	mov r0, r5
	bl sub_ef18
	ldr r0, [r6, #0x2a]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r6, #0x2b]
	mov r0, r0, asr #8
	strb r0, [r6, #0x2a]
	b loc_b378

sub_b3e4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	ldr r0, [r1, #0xc]
	mov r0, r0, lsr #16
	teq r0, #5
	mvnne r0, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r0, r5
	mov r2, #0
	ldr r1, [r6, #8]
	bl sub_7860
	mov r7, r0, lsl #16
	movs r7, r7, lsr #16
	mov r8, #1
	bne loc_b440
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	b loc_b514
loc_b440:
	teq r7, #1
	mvnne r0, #8
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	ldrne r0, [r4, #0xc4]
	movne r0, r0, lsr #16
	teqne r0, #0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r1, r7
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	mov r3, #0x30
	bl sub_dc28
	add sp, sp, #0xc
	ldr r0, [r4, #0xb8]
	add r0, r0, #1
	str r0, [r4, #0xb8]
	ldr r0, [r4, #0xc4]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	ldr r0, [r4, #0xf4]
	movs r0, r0, lsr #16
	ldreq r0, [r4, #0x10]
	ldreq r0, [r0, #8]
	teqeq r0, #0
	beq loc_b514
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	bne loc_b50c
	ldr r0, [r4, #0x48]
	add r1, r0, #0x6c
	mov r2, r4
	mov r0, r5
	mov r3, #6
	bl sub_ed74
	b loc_b514
loc_b50c:
	ldr r0, [r4, #0x10]!
	bl sub_84a0
loc_b514:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_b51c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r1, r2
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	teq r0, #5
	beq loc_b554
	mov r0, r5
	bl sub_7ed0
	mov r0, #0xd
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_b554:
	ldr r0, [r4, #0xd4]
	add r0, r0, #1
	str r0, [r4, #0xd4]
	ldr r0, [r4, #0xdc]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0xdd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xdc]
	mov r6, #0
	ldr r7, [r1, #8]
	mov r0, r5
	mov r3, #1
	mov r2, #8
	str r6, [r1, #8]
	bl sub_ec50
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0xf
	stmia r0, {r2, r6}
	str r7, [r1, #8]
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	strb r0, [r4, #0xe7]
	strb r6, [r4, #0xe6]
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	bne loc_b610
	ldr r2, [r4, #0xe0]
	mov r2, r2, lsr #16
	mov r1, r4
	mov r0, r5
	bl sub_ae3c
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
loc_b610:
	mov r0, #0x85
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_b618:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r7, r3
	bl sub_ee20
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #5
	blt sub_b66c
	teq r0, #0xb
	beq sub_b66c
	ldr r0, [r4, #0x48]
	ldr r1, [r0, #0x2a]!
	mov r1, r1, lsr #16
	sub r1, r1, #1
	strb r1, [r0, #1]
	mov r1, r1, asr #8
	strb r1, [r0]

sub_b66c:
	ldr r1, [r4, #0x48]
	mov r2, r4
	mov r0, r5
	bl sub_ef18
	ldr r0, [r4, #0x14]
	teq r0, #0
	bne loc_b708
	ldr r1, [r5, #0x50]
	teq r1, #0
	beq loc_b6bc
loc_b694:
	ldr r0, [r1, #4]
	teq r0, r4
	beq loc_b6b0
	ldr r1, [r1, #8]
	teq r1, #0
	bne loc_b694
	b loc_b6bc
loc_b6b0:
	teq r1, #0
	movne r0, r5
	blne sub_a8a4
loc_b6bc:
	add r0, r4, #0x22
	bl sub_7668
	tst r0, #0x8000
	beq loc_b6f0
	ldr r1, [r4, #6]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_b6f0
	mov r2, r0, lsl #17
	mov r2, r2, lsr #17
	add r1, r5, #0xec
	mov r0, r5
	bl sub_cbf0
loc_b6f0:
	mov r1, r4
	mov r0, r5
	bl sub_c960
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	b loc_b748
loc_b708:
	ldr r0, [r4, #0x30]
	teq r0, #0
	beq loc_b758
	ldr r4, [r5, #0x40]
	teq r4, #0
	beq loc_b740
loc_b720:
	teq r4, r0
	beq loc_b738
	ldr r4, [r4, #0x78]
	teq r4, #0
	bne loc_b720
	b loc_b740
loc_b738:
	teq r4, #0
	bne loc_b790
loc_b740:
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
loc_b748:
	mov r1, r6
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_7ed0
loc_b758:
	mov r0, r5
	mov r3, #0x86
	mov r2, #1
	mov r1, #0
	bl sub_ec50
	mov r1, r0
	mov r2, #3
	ldr r0, [r0, #0xc]
	strb r2, [r0]
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_b790:
	mov r1, r6
	mov r0, r5
	mov r3, #1
	mov r2, #0xc
	bl sub_ec50
	mov r6, r0
	ldr r0, [r0, #0xc]
	mov r1, #0xd
	stmia r0, {r1, r7}
	ldr r1, [r4, #0x44]
	str r1, [r0, #8]!
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	mov r1, r6
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	strb r0, [r4, #0xd]
	mov r0, #0
	strb r0, [r4, #0xc]
	str r0, [r4, #0x44]
	str r0, [r4, #0x30]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_b7f0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r8, [r1, #2]
	mov r8, r8, lsr #16
	mov r7, #0x13
	teq r8, #7
	bne loc_b858
	ldr r0, [r2, #0xc]!
	ldr r1, [r5, #0x50]
	teq r1, #0
	beq loc_b924
	ldr r0, [r0, #4]
loc_b82c:
	teq r0, r1
	beq loc_b844
	ldr r1, [r1, #8]
	teq r1, #0
	bne loc_b82c
	b loc_b924
loc_b844:
	teq r1, #0
	beq loc_b924
	mov r0, r5
	ldr r4, [r1, #4]
	bl sub_a8a4
loc_b858:
	mvn r0, #0xf
	ldr r6, [r4, #0x48]
	teq r6, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r1, [r6, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #3
	blt sub_b890
	teq r0, #0xb
	bne loc_b898

sub_b890:
	mvn r0, #4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_b898:
	mov r1, r4
	mov r0, r5
	bl sub_ee20
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #5
	blt sub_b8cc
	ldr r0, [r6, #0x2a]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r6, #0x2b]
	mov r0, r0, asr #8
	strb r0, [r6, #0x2a]

sub_b8cc:
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd4]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #4
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	mov r2, r4
	mov r1, r6
	mov r0, r5
	bl sub_ef18
	mov r0, #1
	strb r0, [r4, #0xd]
	mov r0, #0
	strb r0, [r4, #0xc]
	teq r8, #7
	moveq r1, r4
	moveq r0, r5
	bleq sub_c960
loc_b924:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_b92c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r0, r2
	ldr r1, [r1, #0xc]
	mov r1, r1, lsr #16
	teq r1, #5
	teqne r1, #8
	mvnne r0, #4
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	ldr r1, [r4, #0xc4]
	movs r1, r1, lsr #16
	mov r6, #0
	beq loc_b978
	ldr r1, [r4, #0xf4]
	movs r1, r1, lsr #16
	beq loc_b980
loc_b978:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_b980:
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r0
	mov r1, r4
	mov r0, r5
	mov r3, #0x11
	bl sub_dc28
	add sp, sp, #0xc
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	teq r0, #5
	movne r0, #9
	moveq r0, #6
	strb r0, [r4, #0xd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc]
	ldr r0, [r4, #0xb8]
	add r0, r0, #1
	str r0, [r4, #0xb8]
	ldr r0, [r4, #0xc4]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	ldr r0, [r4, #0x98]
	teq r0, #0
	bne loc_ba10
	strb r6, [r4, #0xad]
	strb r6, [r4, #0xac]
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e03c
loc_ba10:
	mov r0, #1
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_ba18:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	mov r6, r3
	ldr r0, [r2, #0xc]
	mov r0, r0, lsr #16
	teq r0, #0xb
	beq loc_ba58
	mov r2, r6
	mov r1, r4
	mov r0, r5
	mvn r3, #0
	bl sub_b618
	b loc_bac0
loc_ba58:
	mov r1, r4
	mov r0, r5
	bl sub_ee20
	ldr r1, [r4, #0x48]
	mov r2, r4
	mov r0, r5
	bl sub_ef18
	ldr r0, [r4, #0x14]
	teq r0, #0
	beq loc_bac8
	mov r0, #1
	strb r0, [r4, #0xd]
	mov r0, #0
	strb r0, [r4, #0xc]
	ldr r0, [r4, #0xa]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_bab4
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_9bc4
	b loc_bac0
loc_bab4:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
loc_bac0:
	mov r0, #0x83
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_bac8:
	add r0, r4, #0x22
	bl sub_7668
	tst r0, #0x8000
	beq loc_bafc
	ldr r1, [r4, #6]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_bafc
	mov r2, r0, lsl #17
	mov r2, r2, lsr #17
	add r1, r5, #0xec
	mov r0, r5
	bl sub_cbf0
loc_bafc:
	mov r1, r4
	mov r0, r5
	bl sub_c960
	b loc_bab4

sub_bb0c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	mov r6, r3
	ldr r0, [r2, #0xc]
	mov r0, r0, lsr #16
	sub r0, r0, #4
	mov r7, #0x86
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b loc_bc28
	b loc_bba4
	b loc_bbe4
	b loc_bbe4
	b loc_bbe4
	b loc_bc28
	b loc_bc28
	b loc_bc28

sub_bb5c:
	ldr r0, [r4, #0xe4]
	movs r0, r0, lsr #16
	bne loc_bc28
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	bl sub_dc28
	add sp, sp, #0xc
	mov r1, r4
	mov r0, r5
	mov r2, #2
	bl sub_e03c
	b loc_bc34
loc_bba4:
	mov r3, #0
	ldr r2, [r1, #0x88]!
	mov r1, #0
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	mov r3, #4
	bl sub_dc28
	add sp, sp, #0xc
	mov r1, r4
	mov r0, r5
	mvn r3, #0
	mov r2, #0
	bl sub_b618
	b loc_bc34
loc_bbe4:
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	bne loc_bc18
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_bc18
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_bc3c
	b loc_bc34
loc_bc18:
	mov r0, #1
	strb r0, [r4, #0xe5]
	mov r0, #0
	strb r0, [r4, #0xe4]
loc_bc28:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
loc_bc34:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_bc3c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	ldr r0, [r1, #0xd4]
	add r0, r0, #1
	str r0, [r1, #0xd4]
	mov r0, #1
	strb r0, [r1, #0xe7]
	mov r7, #0
	strb r7, [r1, #0xe6]
	mov r0, r5
	mov r2, #0
	bl sub_ae3c
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	bl sub_dc28
	add sp, sp, #0xc
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	teq r0, #6
	moveq r0, #0xa
	strbeq r0, [r4, #0xd]
	strbeq r7, [r4, #0xc]
	beq loc_bd64
	teq r0, #7
	bne loc_bd1c
	mov r0, #0xb
	strb r0, [r4, #0xd]
	strb r7, [r4, #0xc]
	mov r1, r4
	mov r0, r5
	mov r2, #2
	bl sub_e03c
	ldr r0, [r4, #0x48]
	ldr r1, [r0, #0x2a]!
	mov r1, r1, lsr #16
	sub r1, r1, #1
	strb r1, [r0, #1]
	mov r1, r1, asr #8
	strb r1, [r0]
	ldr r0, [r4, #0x48]
	add r1, r0, #0x6c
	mov r2, r4
	mov r0, r5
	mov r3, #6
	bl sub_edc8
	b loc_bd28
loc_bd1c:
	mov r0, #8
	strb r0, [r4, #0xd]
	strb r7, [r4, #0xc]
loc_bd28:
	mov r0, r5
	mov r3, #1
	mov r2, #4
	mov r1, #0
	bl sub_ec50
	mov r6, r0
	mov r0, #0x17
	ldr r1, [r6, #0xc]
	str r0, [r1]
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	mov r1, r6
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_bd64:
	strb r7, [r4, #0xe5]
	strb r7, [r4, #0xe4]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_bd70:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r3
	ldr r7, [r0, #4]
	ldr r0, [r7, #0x14]
	teq r0, #0
	bne loc_bdb8
	mov r0, r7
	bl sub_c864
	movs r8, r0
	beq loc_bdc0
	mov r0, r7
	bl sub_c8b8
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_bdb8:
	add r0, r0, #1
	str r0, [r7, #0x14]
loc_bdc0:
	teq r5, #2
	bne loc_bddc
	add r1, r7, #0x6c
	mov r0, r7
	bl sub_cb70
	mov r5, r0
	b loc_bdf0
loc_bddc:
	mov r5, r6, lsl #16
	mov r5, r5, lsr #16
	cmp r5, #2
	mvngt r0, #3
	ldmdbgt fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_bdf0:
	cmp r5, #0
	mvnlt r0, #2
	ldmdblt fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, [r4, #0x18]
	teq r0, #0
	beq loc_be1c
	add r1, r7, #0x6c
	mov r2, r5
	mov r0, r7
	bl sub_cbf0
	b loc_be88
loc_be1c:
	mov r0, r7
	bl sub_c910
	teq r0, #0
	bne loc_be44
	add r1, r7, #0x6c
	mov r2, r5
	mov r0, r7
	bl sub_cbf0
	mvn r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_be44:
	cmp r5, #2
	bgt loc_be64
	add r1, r7, r5, lsl #2
	str r0, [r1, #0x16c]!
	add r1, r5, #1
	strb r1, [r0, #3]
	mov r1, r1, lsr #8
	strb r1, [r0, #2]
loc_be64:
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x30]
	str r0, [r1, #0x18]!
	str r4, [r0, #0x14]
	ldr r1, [r4, #0x30]!
	str r1, [r0, #0x10]
	strb r5, [r0, #1]
	mov r1, r5, lsr #8
	strb r1, [r0]
loc_be88:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_be90:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r6, [r0, #4]
	beq loc_c000
	mov r1, #1
	ldr r0, [r5, #0x14]
	bl sub_7fa0
	mov r1, #1
	ldr r0, [r5, #0x10]
	bl sub_7fa0
	teq r6, #0
	beq loc_bee8
	add r1, r6, #0x6c
	ldr r2, [r5]
	mov r2, r2, lsr #16
	mov r0, r6
	bl sub_cbf0
loc_bee8:
	ldr r0, [r5, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #3
	blt sub_bf64
	teq r0, #0xb
	beq loc_bfcc
	mov r1, #0
	ldr r2, [r5, #0xb8]
	ldr r3, [r5, #0xd4]
	stmdb sp!, {r1, r2, r3}
	mov r1, r5
	mov r0, r6
	mov r3, #4
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	ldr r1, [r5, #0x48]
	mov r2, r5
	mov r0, r6
	bl sub_ef18
	ldr r0, [r5, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #5
	blt sub_bf64
	ldr r0, [r5, #0x48]
	ldr r1, [r0, #0x2a]!
	mov r1, r1, lsr #16
	sub r1, r1, #1
	strb r1, [r0, #1]
	mov r1, r1, asr #8
	strb r1, [r0]

sub_bf64:
	ldr r0, [r5, #0xc]
	mov r0, r0, lsr #16
	teq r0, #0xb
	beq loc_bfcc
	add r0, r5, #0x22
	bl sub_7668
	tst r0, #0x8000
	beq loc_bfb0
	ldr r1, [r5, #6]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_bfb0
	teq r6, #0
	beq loc_bfb0
	mov r2, r0, lsl #17
	mov r2, r2, lsr #17
	add r1, r6, #0xec
	mov r0, r6
	bl sub_cbf0
loc_bfb0:
	mov r1, r5
	mov r0, r6
	bl sub_ee20
	mov r1, r5
	mov r0, r6
	bl sub_c960
	b loc_bfd4
loc_bfcc:
	str r7, [r5, #0x10]
	str r7, [r5, #0x14]!
loc_bfd4:
	ldr r0, [r4, #0x30]
	str r7, [r0, #0x18]!
	teq r6, #0
	str r7, [r4, #0x18]!
	ldrne r0, [r6, #0x14]
	teqne r0, #0
	beq loc_c000
	subs r0, r0, #1
	str r0, [r6, #0x14]
	moveq r0, r6
	bleq sub_c8b8
loc_c000:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_c008:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, #0
	ldr r1, [r0, #0x18]
	teq r1, #0
	ldr r6, [r0, #4]
	bne loc_c040
loc_c030:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_c100
loc_c040:
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	cmp r0, #0xe
	beq loc_c0d0
	bgt loc_c064
	teq r0, #0
	teqne r0, #1
	bne loc_c0f0
	b loc_c0e0
loc_c064:
	teq r0, #0x83
	beq loc_c0e0
	teq r0, #0x86
	bne loc_c0f0
	ldr r1, [r4, #0xc]
	ldrb r0, [r1]
	tst r0, #2
	beq loc_c098
	bic r0, r0, #2
	strb r0, [r1]
	mov r0, r5
	mov r1, #1
	bl sub_7fa0
loc_c098:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_c030
	mov r1, #1
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_c100
loc_c0d0:
	mov r2, r4
	mov r0, r6
	bl sub_d0f4
	b loc_c100
loc_c0e0:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	b loc_c100
loc_c0f0:
	mov r2, r4
	mov r0, r6
	mvn r3, #1
	bl sub_eae8
loc_c100:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_c108:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r6, [r0, #4]
	ldr r0, [r1, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #1
	teqne r0, #0x83
	beq loc_c144
	teq r0, #0x86
	beq loc_c154
	teq r0, #0x8a
	bne loc_c1b8
loc_c144:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	b loc_c1c4
loc_c154:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_c180
	mov r0, r5
	mov r1, #1
	bl sub_7fa0
	ldr r0, [r4, #0xc]
	ldrb r1, [r0]
	bic r1, r1, #1
	strb r1, [r0]
loc_c180:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #2
	beq loc_c1b8
	mov r1, #1
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_c1c4
loc_c1b8:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
loc_c1c4:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_c1cc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r6, [r0, #4]
	bne loc_c200
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_c2f8
loc_c200:
	ldr r0, [r6, #0x188]
	movs r0, r0, lsr #16
	beq loc_c220
	add r1, r6, #0x18
	mov r2, r5
	mov r0, r6
	mov r3, #0
	b loc_c288
loc_c220:
	ldr r8, [r5, #0x48]
	ldr r0, [r5, #0xa0]
	movs r0, r0, lsr #16
	beq loc_c258
	teq r8, #0
	beq loc_c250
	mov r1, r5
	mov r0, r6
	bl sub_e460
	ldr r0, [r5, #0x10]!
	bl sub_84a0
	b loc_c2f8
loc_c250:
	strb r7, [r5, #0xa1]
	strb r7, [r5, #0xa0]
loc_c258:
	ldr r0, [r5, #0xf4]
	movs r0, r0, lsr #16
	beq loc_c29c
	ldr r0, [r8, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	bne loc_c290
loc_c278:
	add r1, r8, #0x6c
	mov r2, r5
	mov r0, r6
	mov r3, #6
loc_c288:
	bl sub_ed74
	b loc_c2f8
loc_c290:
	mov r1, r5
	mov r0, r6
	bl sub_a9d4
loc_c29c:
	mov r0, r4
	bl sub_8004
	movs sb, r0
	beq loc_c2e8
loc_c2ac:
	mov r2, sb
	mov r1, r5
	mov r0, r6
	bl sub_e8b4
	teq r0, #0
	bne loc_c2d8
	mov r2, sb
	ldr r1, [r4, #8]
	mov r0, r4
	bl sub_8030
	b loc_c278
loc_c2d8:
	mov r0, r4
	bl sub_8004
	movs sb, r0
	bne loc_c2ac
loc_c2e8:
	teq r8, #0
	movne r1, r8
	movne r0, r6
	blne sub_c570
loc_c2f8:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_c300:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r6, [r0, #4]
	bne loc_c334
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_c3d4
loc_c334:
	ldr r0, [r6, #0x188]
	movs r0, r0, lsr #16
	beq loc_c354
	mov r0, #1
	strb r0, [r5, #0x11]
	mov r0, r7
	strb r7, [r5, #0x10]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_c354:
	ldr r0, [r5, #0x28]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_c374
	mov r1, r5
	mov r0, r6
	bl sub_cf88
	b loc_c3d4
loc_c374:
	ldr r0, [r5, #0x30]
	movs r0, r0, lsr #16
	beq loc_c3a4
	sub r0, r0, #1
	strb r0, [r5, #0x31]
	mov r0, r0, asr #8
	strb r0, [r5, #0x30]
	mov r1, r5
	mov r0, r6
	bl sub_e7fc
	ldr r0, [r5, #0xc]
	bl sub_84a0
loc_c3a4:
	mov r0, r4
	bl sub_8004
	teq r0, #0
	beq loc_c3d4
loc_c3b4:
	mov r2, r0
	mov r1, r5
	mov r0, r6
	bl sub_d548
	mov r0, r4
	bl sub_8004
	teq r0, #0
	bne loc_c3b4
loc_c3d4:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_c3dc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, #0
	ldr r4, [r0, #0x18]
	teq r4, #0
	ldr r5, [r0, #4]
	bne loc_c408
	mov r1, #1
	bl sub_7fa0
	b loc_c4c8
loc_c408:
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_c4c8
loc_c41c:
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	beq loc_c494
	ldr r0, [r4, #0x14]
	ldr r1, [r4, #0xf0]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	str r6, [r4, #0xf0]
	strb r6, [r4, #0xf7]
	strb r6, [r4, #0xf6]
	ldr r2, [r4, #0xe0]
	mov r2, r2, lsr #16
	mov r1, r4
	mov r0, r5
	bl sub_ae3c
	teq r0, #1
	bne loc_c4b4
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	b loc_c4b4
loc_c494:
	ldr r0, [r4, #0xe4]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_c4c8
	mov r1, r4
	mov r0, r5
	mov r2, #0
	bl sub_bc3c
loc_c4b4:
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	beq loc_c41c
loc_c4c8:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_c4d0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, #0
	ldr r4, [r0, #0x18]
	teq r4, #0
	ldr r6, [r0, #4]
	bne loc_c4fc
	mov r1, #1
	bl sub_7fa0
	b loc_c558
loc_c4fc:
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_c558
loc_c510:
	ldr r1, [r4, #0x34]
	teq r1, #0
	beq loc_c560
	ldr r0, [r1]
	str r0, [r4, #0x34]
	teq r0, #0
	strne r5, [r1]
	streq r5, [r4, #0x38]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	beq loc_c510
loc_c558:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_c560:
	mov r1, r4
	mov r0, r6
	bl sub_c570
	b loc_c558

sub_c570:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r1, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	addne r1, r4, #0x6c
	ldrne r4, [r1]
	teqne r4, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r2, r4
	mov r0, r5
	mov r3, #6
	bl sub_edc8
	ldr r0, [r4, #0x10]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_84a0

sub_c5c0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x188]
	movs r0, r0, lsr #16
	add r1, r0, #1
	strb r1, [r4, #0x189]
	mov r1, r1, asr #8
	strb r1, [r4, #0x188]
	ldmdbne fp, {r4, fp, sp, pc}
	ldr r0, lit_c62c
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0
	mov r2, #0x20
	bl sub_843c
	ldr r0, lit_c630
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0x64
	mov r2, #0
	bl sub_8924
	str r0, [r4, #0x18c]!
	ldmdb fp, {r4, fp, sp, pc}
lit_c62c:
	.rword sub_c634				; relocated
lit_c630:
	.rword sub_c780				; relocated

sub_c634:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x188]
	movs r0, r0, lsr #16
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	add r5, r4, #0x178
	mov r6, #0

sub_c658:
	ldr r0, [r5]
	teq r0, #0
	bne loc_c698
	mov r0, r4
	mov r2, #1
	mov r1, #0x20
	bl sub_7c44
	str r0, [r5]
	teq r0, #0
	beq loc_c6a8
	ldr r0, [r4, #0x188]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x189]
	mov r0, r0, asr #8
	strb r0, [r4, #0x188]
loc_c698:
	add r5, r5, #4
	add r6, r6, #1
	cmp r6, #4
	blo sub_c658
loc_c6a8:
	ldr r0, [r4, #0x188]
	movs r0, r0, lsr #16
	beq loc_c6d4
	ldr r0, lit_c77c
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0
	mov r2, #0x20
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_843c
loc_c6d4:
	mov r6, #0
	ldr r1, [r4, #0x18c]
	teq r1, #0
	beq loc_c6f0
	mov r0, r4
	bl sub_8a04
	str r6, [r4, #0x18c]
loc_c6f0:
	ldr r5, [r4, #0x18]
	teq r5, #0
	beq loc_c72c
	add r7, r4, #0x18
loc_c700:
	mov r1, r7
	mov r2, r5
	mov r0, r4
	mov r3, #0
	bl sub_edc8
	ldr r0, [r5, #0x10]!
	teq r0, #0
	blne sub_84a0
	ldr r5, [r4, #0x18]
	teq r5, #0
	bne loc_c700
loc_c72c:
	add r4, r4, #0x58
	mov r5, #0

sub_c734:
	ldr r0, [r4]
	teq r0, #0
	beq loc_c768
	ldr r1, [r0, #0x10]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_c768
	strb r6, [r0, #0x11]
	strb r6, [r0, #0x10]
	ldr r0, [r4]
	ldr r0, [r0, #0xc]
	teq r0, #0
	blne sub_84a0
loc_c768:
	add r4, r4, #4
	add r5, r5, #1
	cmp r5, #4
	blo sub_c734
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_c77c:
	.rword sub_c634				; relocated

sub_c780:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	ldr r1, [r0, #0x188]
	movs r1, r1, lsr #16
	mov r0, #0
	bne loc_c7a8
loc_c7a0:
	str r0, [r5, #0x18c]!
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_c7a8:
	ldr r4, [r5, #0x20]
	teq r4, #0
	beq loc_c82c
loc_c7b4:
	ldr r1, [r4, #0xc]
	mov r1, r1, lsr #16
	teq r1, #5
	bne loc_c820
	ldr r1, [r4, #0x48]
	ldr r2, [r1, #0x2a]!
	mov r2, r2, lsr #16
	sub r2, r2, #1
	strb r2, [r1, #1]
	mov r2, r2, asr #8
	strb r2, [r1]
	mov r1, #1
	strb r1, [r4, #0xd]
	strb r0, [r4, #0xc]
	mov r1, r4
	mov r0, r5
	bl sub_ee20
	ldr r1, [r4, #0x48]
	mov r2, r4
	mov r0, r5
	bl sub_ef18
	mov r1, r4
	mov r0, r5
	mvn r3, #0
	mov r2, #0
	bl sub_eae8
	b loc_c82c
loc_c820:
	ldr r4, [r4, #0x58]
	teq r4, #0
	bne loc_c7b4
loc_c82c:
	ldr r0, lit_c84c
	bl sub_11bfc
	mov r1, r0
	mov r0, r5
	mov r3, #0x64
	mov r2, #0
	bl sub_8924
	b loc_c7a0
lit_c84c:
	.rword sub_c780				; relocated

sub_c850:
	mov r2, r0
	ldr r1, lit_c860
	mov r0, #0x190
	b sub_7bf4
lit_c860:
	.word 0x54435020			; 'TCP '

sub_c864:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #1
	str r0, [r4, #0x14]
	add r6, r4, #0x178
	mov r5, #0

sub_c884:
	mov r0, r4
	mov r2, #1
	mov r1, #0x20
	bl sub_7c44
	str r0, [r6], #4
	teq r0, #0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	add r5, r5, #1
	cmp r5, #4
	blt sub_c884
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_c8b8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r5, r0, #0x178
	mov r6, #0

sub_c8d0:
	ldr r1, [r5]
	teq r1, #0
	movne r0, r4
	blne sub_7ed0
	add r5, r5, #4
	add r6, r6, #1
	cmp r6, #4
	blt sub_c8d0
	ldr r1, [r4, #0x18c]
	teq r1, #0
	movne r0, r4
	blne sub_8a04
	mov r0, r4
	mov r1, #0x190
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_7c34

sub_c910:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0xfc
	bl sub_7b9c
	movs r5, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r5
	mov r2, #0xfc
	mov r1, #0
	bl memset
	add r1, r4, #0x20
	mov r2, r5
	mov r0, r4
	mov r3, #1
	bl sub_ed74
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_c960:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	bl sub_ee20
	mov r1, #0
	ldr r0, [r4, #0x48]
	teq r0, #0
	beq loc_c994
	ldr r2, [r0, #0x78]
	teq r2, r4
	streq r1, [r0, #0x78]!
loc_c994:
	ldr r0, [r4]
	mov r0, r0, lsr #16
	cmp r0, #2
	addle r0, r5, r0, lsl #2
	strle r1, [r0, #0x16c]!
	mov r6, #0

sub_c9ac:
	add r0, r5, r6, lsl #3
	add r1, r0, #0x18
	mov r3, r6
	mov r2, r4
	mov r0, r5
	bl sub_edc8
	add r6, r6, #1
	cmp r6, #6
	blo sub_c9ac
	ldr r0, [r4, #0x48]
	teq r0, #0
	beq loc_c9f0
	add r1, r0, #0x6c
	mov r2, r4
	mov r0, r5
	mov r3, #6
	bl sub_edc8
loc_c9f0:
	ldr r0, [r4, #0x34]
	teq r0, #0
	blne sub_7be0
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_7be0

sub_ca08:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x94
	bl sub_7b9c
	movs r4, r0
	mov r5, #0
	moveq r0, r5
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r4
	mov r2, #0x94
	mov r1, #0
	bl memset
	mov r0, #4
	strb r0, [r4, #1]
	strb r5, [r4]
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_ca50:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x34]
	teq r1, #0
	beq loc_ca8c
loc_ca70:
	ldr r0, [r1]
	str r0, [r4, #0x34]
	mov r0, r5
	bl sub_7ed0
	ldr r1, [r4, #0x34]
	teq r1, #0
	bne loc_ca70
loc_ca8c:
	ldr r0, [r4]
	mov r0, r0, lsr #16
	teq r0, #4
	movne r1, #0
	addne r0, r5, r0, lsl #2
	strne r1, [r0, #0x58]!
	ldr r0, [r4, #0x2c]
	teq r0, #0
	blne sub_7be0
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_7be0

sub_cabc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r7, lit_cb50
	mov r0, #0
	bl sub_76b0
	bl srand
	mov r8, #0

sub_cae4:
	bl rand
	cmp r0, #0
	rsblt r0, r0, #0
	and r0, r0, #0x7f
	rsblt r0, r0, #0
	mov r6, r0
	bl rand
	cmp r0, #0
	rsblt r0, r0, #0
	and r0, r0, #7
	rsblt r0, r0, #0
	teq r6, #0
	bne loc_cb20
	cmp r0, #2
	bls sub_cb54
loc_cb20:
	ldrb r1, [r4, r6]
	add r2, r7, r0
	ldrb r2, [r2, #0x80]
	tst r1, r2
	bne sub_cb54
	add r1, r7, r0
	ldrb r1, [r1, #0x80]
	ldrb r2, [r4, r6]!
	orr r1, r1, r2
	strb r1, [r4]
	add r0, r0, r6, lsl #3
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_cb50:
	.rword data_11918			; relocated

sub_cb54:
	add r8, r8, #1
	cmp r8, #0x80
	blt sub_cae4
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b sub_cb70

sub_cb70:
	stmdb sp!, {lr}
	ldr r3, lit_cbc8
	mov r2, #0

sub_cb7c:
	ldrb ip, [r1]
	teq ip, #0xff
	beq loc_cbd8
	mov r0, #0

sub_cb8c:
	teq r2, #0
	bne loc_cb9c
	cmp r0, #2
	bls sub_cbcc
loc_cb9c:
	add lr, r3, r0
	ldrb lr, [lr, #0x80]
	tst lr, ip
	bne sub_cbcc
	add r3, r3, r0
	ldrb ip, [r3, #0x80]
	ldrb r3, [r1]
	orr r3, ip, r3
	strb r3, [r1]
	add r0, r0, r2, lsl #3
	ldmia sp!, {pc}
lit_cbc8:
	.rword data_11918			; relocated

sub_cbcc:
	add r0, r0, #1
	cmp r0, #8
	blo sub_cb8c
loc_cbd8:
	add r2, r2, #1
	add r1, r1, #1
	cmp r2, #0x80
	blo sub_cb7c
	mvn r0, #0
	ldmia sp!, {pc}

sub_cbf0:
	ldr r0, lit_cc10
	ldrb ip, [r1, r2, lsr #3]
	and r3, r2, #7
	add r0, r3, r0
	ldrb r0, [r0, #0x80]
	bic r0, ip, r0
	strb r0, [r1, r2, lsr #3]
	mov pc, lr
lit_cc10:
	.rword data_11918			; relocated

sub_cc14:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	mov r3, #1
	mov r2, #0x21
	bl sub_ec50
	mov r2, r0
	ldr r0, [r0, #0xc]
	mov ip, #6
	mov r1, #4
	mov r3, #0x1c
	stmib r0, {r1, r3}
	mov r3, #0
	str r1, [r0, #0x10]
	mov r1, #1
	mov lr, #0x20
	str ip, [r0], #0xc
	str r3, [r0], #8
	stmia r0, {r1, lr}
	ldr r0, [r4, #0x24]
	ldr lr, [r2, #0xc]
	str r0, [lr, #0x1c]!
	ldr r0, [r2, #0xc]
	strb ip, [r0, #0x20]
	strb r1, [r4, #0x21]
	strb r3, [r4, #0x20]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r2
	ldr r2, [r0]
	ldmdb fp, {r4, fp, sp, lr}
	ldr pc, [r2]

sub_cc9c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	ldr r2, [r4, #0x20]
	mov r2, r2, lsr #16
	mov r5, #1
	teq r2, #1
	beq loc_cccc
	bl sub_7ed0
	b loc_cd0c
loc_cccc:
	mov r3, #0x83
	mov r2, #4
	bl sub_ec50
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #5
	str r2, [r0]
	mov r0, #2
	strb r0, [r4, #0x21]
	mov r0, #0
	strb r0, [r4, #0x20]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_cd0c:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_cd14:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r3, [r1, #0x20]
	mov r3, r3, lsr #16
	mov r4, #0
	teq r3, #2
	bne loc_cd40
	ldr ip, [r0, #0x170]
	teq ip, #0
	bne loc_cd4c
loc_cd40:
	mov r1, r2
	bl sub_7ed0
	b loc_cdc8
loc_cd4c:
	ldr r3, [r2, #0xc]
	ldr lr, [r3, #0x38]
	teq lr, #2
	ldreq lr, [r3, #0x50]
	teqeq lr, #2
	beq loc_cd80
	mvn r3, #0x1e
	stmdb sp!, {r3}
	mov r1, ip
	mov r3, #0x200
	bl sub_eb2c
	add sp, sp, #4
	b loc_cdc8
loc_cd80:
	ldr lr, [r1, #0x2c]
	ldr r5, [lr, #0x14]
	add r5, r5, #0x14
	ldr r3, [r3, #4]
	cmp r5, r3
	subhi r3, r3, #0x14
	strhi r3, [lr, #0x14]!
	ldr r3, [r1, #0x2c]
	ldr r3, [r3, #0x14]
	strb r3, [r1, #0x23]
	mov r3, r3, asr #8
	strb r3, [r1, #0x22]
	mov r3, #4
	strb r3, [r1, #0x21]
	strb r4, [r1, #0x20]
	mov r1, ip
	mov r3, #0x200
	bl sub_eb80
loc_cdc8:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_cdd0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r0, #0x170]
	ldr r3, [r4, #0x20]
	mov r3, r3, lsr #16
	mov r5, #0
	teq r3, #1
	beq loc_ce14
	teq r3, #2
	beq loc_ce44
	teq r3, #4
	bne loc_ce84
	mov r1, r4
	bl sub_ce94
	b loc_ce8c
loc_ce14:
	teq r1, #0
	bne loc_ce28
	mov r1, r2
	bl sub_7ed0
	b loc_ce3c
loc_ce28:
	mvn r3, #0x1f
	stmdb sp!, {r3}
	mov r3, #0x200
	bl sub_eb2c
	add sp, sp, #4
loc_ce3c:
	mov r0, #3
	b loc_ce78
loc_ce44:
	teq r1, #0
	bne loc_ce58
	mov r1, r2
	bl sub_7ed0
	b loc_ce74
loc_ce58:
	mov r3, #0x200
	bl sub_eb80
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x14]
	strb r0, [r4, #0x23]
	mov r0, r0, asr #8
	strb r0, [r4, #0x22]
loc_ce74:
	mov r0, #4
loc_ce78:
	strb r0, [r4, #0x21]
	strb r5, [r4, #0x20]
	b loc_ce8c
loc_ce84:
	mov r1, r2
	bl sub_7ed0
loc_ce8c:
	mov r0, #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_ce94:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	mov r7, #7
	mov r6, #0
	teq r0, #1
	teqne r0, #2
	beq loc_cef4
	teq r0, #4
	mov r1, r2
	mov r0, r4
	bne loc_cf44
	bl sub_7ed0
	mov r0, #1
	strb r0, [r5, #0x29]
	strb r6, [r5, #0x28]
	mov r1, r5
	mov r0, r4
	bl sub_cf88
	b loc_cf28
loc_cef4:
	ldr r1, [r4, #0x170]
	teq r1, #0
	bne loc_cf10
	mov r1, r2
	mov r0, r4
	bl sub_7ed0
	b loc_cf28
loc_cf10:
	mvn r3, #0x1f
	stmdb sp!, {r3}
	mov r0, r4
	mov r3, #0x200
	bl sub_eb2c
	add sp, sp, #4
loc_cf28:
	mov r0, #3
	strb r0, [r5, #0x21]
	strb r6, [r5, #0x20]
	mov r1, r5
	mov r0, r4
	bl sub_d4c0
	b loc_cf48
loc_cf44:
	bl sub_7ed0
loc_cf48:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_cf50:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, r2
	bl sub_7ed0
	mov r0, #5
	ldmdb fp, {fp, sp, pc}

sub_cf6c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, r2
	bl sub_7ed0
	mov r0, #6
	ldmdb fp, {fp, sp, pc}

sub_cf88:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x34]
	teq r1, #0
	beq loc_cfc4
loc_cfa8:
	ldr r0, [r1]
	str r0, [r4, #0x34]
	mov r0, r5
	bl sub_7ed0
	ldr r1, [r4, #0x34]
	teq r1, #0
	bne loc_cfa8
loc_cfc4:
	mov r7, #0
	str r7, [r4, #0x38]
	mov r8, #1
	ldr r6, [r4, #0x18]
	teq r6, #0
	beq loc_d008
loc_cfdc:
	ldr r0, [r6, #0x14]
	teq r0, #0
	mov r1, r6
	mov r0, r5
	bne loc_d05c
	mov r3, #0
	mov r2, #0
	bl sub_b618
	ldr r6, [r4, #0x18]
	teq r6, #0
	bne loc_cfdc
loc_d008:
	ldr r6, [r4, #0x74]
	teq r6, #0
	beq loc_d0e4
	ldr r0, [r4, #8]
	str r7, [r0, #0x18]!
	ldr r0, [r4, #0xc]
	mov r1, r4
	str r7, [r0, #0x18]!
	mov r0, r5
	bl sub_ca50
	ldr r0, [r5, #0x16c]
	teq r0, #0
	ldrne r0, [r0, #0x14]
	teqne r0, #0
	beq loc_d0d4
	ldr r0, [r0, #0x10]
	mov r1, r6
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_d0ec
loc_d05c:
	bl sub_ee20
	strb r8, [r6, #0xd]
	strb r7, [r6, #0xc]
	ldr r0, [r6, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #5
	blt sub_d09c
	teq r0, #0xb
	beq sub_d09c
	ldr r0, [r6, #0x48]
	ldr r1, [r0, #0x2a]!
	mov r1, r1, lsr #16
	sub r1, r1, #1
	strb r1, [r0, #1]
	mov r1, r1, asr #8
	strb r1, [r0]

sub_d09c:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_ef18
	str r7, [r6, #0x48]
	mov r1, r6
	mov r0, r5
	mvn r3, #0xf
	mov r2, #0
	bl sub_eae8
	ldr r0, [r4, #0xc]!
	bl sub_84a0
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_d0d4:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	b loc_d0ec
loc_d0e4:
	strb r7, [r4, #0x29]
	strb r7, [r4, #0x28]
loc_d0ec:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_d0f4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	ldr r8, [r2, #0xc]
	ldr r0, [r1]
	movs r0, r0, lsr #16
	mvnne r7, #7
	bne loc_d168
	ldr r0, [r8]
	sub ip, r0, #0x5300
	teq ip, #0xc
	beq loc_d14c
	sub ip, r0, #0x5300
	teq ip, #0xd
	bne loc_d164
	mov r1, r4
	mov r0, r5
	bl sub_d23c
	b loc_d15c
loc_d14c:
	ldr r0, [r4, #8]
	ldr r1, [r0, #0xc]!
	mov r0, r5
	bl sub_d1c0
loc_d15c:
	mov r7, r0
	b loc_d168
loc_d164:
	mvn r7, #0xb
loc_d168:
	mov sb, #0
	str sb, [r8, #0xc]
	mov r0, r5
	ldr r1, [r4, #8]
	bl sub_7ed0
	mov r0, #0x81
	teq r7, #0
	str sb, [r4, #8]
	ldreq r1, [r4, #0x18]!
	strbeq r0, [r1, #9]
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	teq r7, #1
	movne r0, #0x82
	strne r7, [r8, #0x10]!
	ldr r1, [r4, #0x18]
	strb r0, [r1, #9]
	ldr r0, [r6, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	ldr pc, [r2]

sub_d1c0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_ca08
	teq r0, #0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r5, #8]
	str r1, [r0, #4]
	ldr r1, [r5, #4]!
	str r1, [r0, #8]
	ldr r2, [r1, #0x30]
	str r2, [r0, #0xc]
	str r0, [r1, #0x18]!
	ldr r1, [r0, #0xc]
	str r0, [r1, #0x18]!
	ldr r1, [r4, #0x68]
	teq r1, #0
	beq loc_d230
loc_d214:
	ldr r2, [r1, #0x14]
	teq r2, #0
	movne r1, r2
	bne loc_d214
	str r0, [r1, #0x14]
	teq r1, #0
	bne loc_d234
loc_d230:
	str r0, [r4, #0x68]!
loc_d234:
	mov r0, #1
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_d23c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r1, #8]
	ldr r0, [r0, #0xc]
	ldr r1, [r0, #8]!
	mov sb, r1
	mov r0, r4
	bl sub_d3f4
	mov r8, #0
	mov r7, #1
	teq r0, #0
	beq loc_d290
	ldr r1, [r0, #8]
	str r8, [r1, #0x18]!
	ldr r1, [r0, #0xc]
	str r8, [r1, #0x18]!
	mov r1, r0
	b loc_d2f4
loc_d290:
	add r1, r4, #0x58
	mov r0, #0

sub_d298:
	ldr r6, [r1], #4
	teq r6, #0
	beq loc_d2b0
	ldr r2, [r6, #4]
	teq r2, sb
	beq loc_d2bc
loc_d2b0:
	add r0, r0, #1
	cmp r0, #4
	blo sub_d298
loc_d2bc:
	teq r0, #4
	bne loc_d2cc
loc_d2c4:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_d2cc:
	mov r1, r6
	mov r0, r4
	bl sub_cf88
	teq r0, #1
	bne loc_d300
	ldr r0, [r6, #8]
	str r8, [r0, #0x18]!
	ldr r0, [r6, #0xc]
	mov r1, r6
	str r8, [r0, #0x18]!
loc_d2f4:
	mov r0, r4
	bl sub_ca50
	b loc_d2c4
loc_d300:
	strb r7, [r6, #0x29]
	mov r0, r8
	strb r8, [r6, #0x28]
	mov r1, #3
	strb r1, [r6, #0x21]
	strb r8, [r6, #0x20]
	str r5, [r6, #0x74]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_d320:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	ldr r8, [r2, #0xc]
	ldr sb, [r8, #8]
	cmp sb, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	add sl, r4, sb, lsl #2
	ldr r0, [sl, #0x58]
	teq r0, #0
	mvnne r0, #0xc
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r1, #0
	ldr r0, [r8, #0xc]
	bl sub_7460
	teq r0, #0
	mvnne r0, #0x20
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, #0x4c
	bl sub_7b9c
	movs r7, r0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, r4
	ldr r1, [r8, #4]
	bl sub_d3f4
	movs r6, r0
	bne loc_d3ac
	mov r0, r7
	bl sub_7be0
	mvn r0, #0xd
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_d3ac:
	strb sb, [r6, #1]
	mov r0, sb, lsr #8
	strb r0, [r6]
	mov r2, r7
	mov r1, r5
	mov r0, r4
	mov r3, #0x4c
	str r6, [sl, #0x58]!
	bl sub_7938
	str r7, [r6, #0x2c]
	ldr r0, [r8, #0xc]!
	mov r2, r5
	str r0, [r6, #0x24]
	mov r1, r6
	mov r0, r4
	bl sub_cc14
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_d3f4:
	mov r3, #0
	ldr r2, [r0, #0x68]
	teq r2, #0
	beq loc_d438
loc_d404:
	ldr ip, [r2, #4]
	teq ip, r1
	bne loc_d428
	teq r3, #0
	ldreq r1, [r2, #0x14]
	streq r1, [r0, #0x68]!
	ldrne r0, [r2, #0x14]
	strne r0, [r3, #0x14]!
	b loc_d438
loc_d428:
	mov r3, r2
	ldr r2, [r2, #0x14]
	teq r2, #0
	bne loc_d404
loc_d438:
	mov r0, r2
	mov pc, lr

sub_d440:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r3, [r2, #0xc]
	ldr ip, [r3, #4]
	cmp ip, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {fp, sp, pc}
	add r0, r0, ip, lsl #2
	ldr r0, [r0, #0x58]
	teq r0, #0
	moveq r0, #0
	streq r0, [r3, #8]
	ldrne ip, [r0, #0x20]
	movne ip, ip, lsr #16
	strne ip, [r3, #8]
	ldrne r0, [r0, #0x2a]
	movne r0, r0, lsr #16
	str r0, [r3, #0xc]
	mov r0, #0x300
	str r0, [r3]
	mov r3, #0x83
	ldr r0, [r2, #0x18]
	strb r3, [r0, #9]
	ldr r0, [r1, #0x14]!
	ldr r0, [r0, #0x10]
	mov r1, r2
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {fp, sp, pc}

sub_d4c0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0x10
	ldr r4, [r0, #0x174]
	teq r4, #0
	beq loc_d544
	mov r2, #1
	add r2, r2, #0x300
	str r2, [sp]
	ldr r2, [r1]
	mov r2, r2, lsr #16
	str r2, [sp, #4]
	ldr r2, [r1, #0x20]
	mov r2, r2, lsr #16
	str r2, [sp, #8]
	ldr r1, [r1, #0x2a]
	mov r1, r1, lsr #16
	str r1, [sp, #0xc]
	mov r2, sp
	mov r3, #0x10
	mov r1, #0
	bl sub_7b2c
	movs r1, r0
	beq loc_d544
	mov r2, #0x83
	ldr r0, [r1, #0x18]
	strb r2, [r0, #9]
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_d544:
	ldmdb fp, {r4, fp, sp, pc}

sub_d548:
	mov r3, #0
	str r3, [r1, #0x78]
	ldr r3, [r2, #0x18]
	ldrb r3, [r3, #9]
	teq r3, #0x8a
	moveq r3, #7
	beq loc_d594
	ldr r3, [r2, #0xc]
	ldr r3, [r3]
	sub ip, r3, #0x300
	teq ip, #3
	beq loc_e1b4
	cmp r3, #0x10
	blo sub_d588
	cmp r3, #0x15
	bls sub_d590

sub_d588:
	mov r3, #6
	b loc_d594

sub_d590:
	sub r3, r3, #0x10
loc_d594:
	ldr ip, lit_d5a0
	add r3, ip, r3, lsl #2
	ldr pc, [r3, #0x88]
lit_d5a0:
	.rword data_11918			; relocated

sub_d5a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #0xc
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	teq r0, #4
	beq loc_d5e4
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, #0xd
	b loc_d8a8
loc_d5e4:
	ldr r0, [r6, #0xc]
	mov r1, r0
	ldr r0, [r0, #0x10]
	add r1, r1, r0
	add r0, r4, #0x80
	mov r7, r0
	mov r2, #4
	bl memcpy
	mov r8, #8
	ldr sl, [r6, #8]
	teq sl, #0
	beq loc_d630
	mov r1, sl
	mov r0, r5
	mov r2, #0
	bl sub_7860
	str r0, [sp]
	cmp r0, #0x14
	bhs loc_d644
loc_d630:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, r8
	b loc_d8a8
loc_d644:
	ldr r0, [r4, #0x2c]
	ldr r0, [r0, #0x48]
	teq r0, #0
	bne loc_d690
	mov r3, sl
	stmdb sp!, {r3}
	mov r2, r7
	add r1, r4, #0x24
	mov r0, r5
	ldr r3, [sp, #4]
	bl sub_d8ac
	add sp, sp, #4
	teq r0, #0
	beq loc_d690
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
	mov r0, #9
	b loc_d8a8
loc_d690:
	add r0, r4, #0x7c
	ldr r8, [sl, #0xc]
	mov r1, r8
	mov r2, #4
	str r0, [sp, #8]
	bl memcpy
	add r0, r8, #4
	bl sub_7644
	str r0, [r4, #0x84]
	add r0, r8, #8
	bl sub_7644
	str r0, [r4, #0x88]
	ldrb r0, [r8, #0xc]
	mov sb, r0, lsr #2
	ldrb r0, [r8, #0xd]
	strb r0, [r4, #0x92]
	str r0, [sp, #4]
	add r0, r8, #0xe
	bl sub_7668
	strb r0, [r4, #0x8f]
	mov r0, r0, asr #8
	strb r0, [r4, #0x8e]
	mov r0, #0
	strb r0, [r4, #0x91]
	strb r0, [r4, #0x90]
	cmp sb, #0x14
	addhi r7, r8, #0x14
	addhi r8, r8, sb
	cmphi r8, r7
	bls sub_d758
loc_d708:
	ldrb r0, [r7], #1
	teq r0, #0
	moveq r7, r8
	beq loc_d750
	teq r0, #1
	beq loc_d750
	teq r0, #2
	bne loc_d744
	add r0, r7, #1
	bl sub_7668
	strb r0, [r4, #0x91]
	mov r0, r0, asr #8
	strb r0, [r4, #0x90]
	add r7, r7, #3
	b loc_d750
loc_d744:
	ldrb r0, [r7]
	add r0, r7, r0
	add r7, r0, #1
loc_d750:
	cmp r8, r7
	bhi loc_d708

sub_d758:
	ldr r7, [r4, #0x18]
	teq r7, #0
	beq loc_d794
loc_d764:
	add r0, r7, #0x18
	mov r2, #8
	ldr r1, [sp, #8]
	bl memcmp
	teq r0, #0
	beq loc_d78c
	ldr r7, [r7, #0x8c]
	teq r7, #0
	bne loc_d764
	b loc_d794
loc_d78c:
	teq r7, #0
	bne loc_d7b4
loc_d794:
	ldr r0, [sp, #4]
	tst r0, #2
	beq loc_d7b4
	add r2, r4, #0x7e
	mov r1, r4
	mov r0, r5
	bl sub_a00c
	mov r7, r0
loc_d7b4:
	str r7, [r4, #0x78]
	teq r7, #0
	ldr r0, [sp, #4]
	bne loc_d7f4
	tst r0, #4
	bne loc_d7e0
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_de1c
	b loc_d7ec
loc_d7e0:
	mov r1, r6
	mov r0, r5
	bl sub_7ed0
loc_d7ec:
	mov r0, #0xa
	b loc_d8a8
loc_d7f4:
	tst r0, #2
	strne sb, [sp]
	ldr r0, [sp, #4]
	tst r0, #0x20
	beq sub_d86c
	ldr r0, [r7, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #3
	blt sub_d86c
	add r0, sb, #1
	ldr r3, [sp]
	teq r0, r3
	beq sub_d86c
	mov r3, #0
	mov r1, #0
	ldr r2, [r4, #0x88]!
	stmdb sp!, {r1, r2, r3}
	mov r2, r6
	mov r1, r7
	mov r0, r5
	mov r3, #4
	bl sub_dc28
	add sp, sp, #0xc
	mov r1, r7
	mov r0, r5
	mvn r3, #3
	mov r2, #0
	bl sub_b618
	mov r0, #0xe
	b loc_d8a8

sub_d86c:
	ldr r0, [sp]
	sub r0, r0, sb
	strb r0, [r4, #0x8d]
	mov r0, r0, lsr #8
	strb r0, [r4, #0x8c]
	mov r2, sb
	mov r1, sl
	mov r0, r5
	bl sub_779c
	str r0, [r6, #8]
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_d924
loc_d8a8:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_d8ac:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r1
	mov r5, r2
	mov r4, r3
	ldr r7, [fp, #4]
	sub sp, sp, #0x10
	mov r0, sp
	mov r1, #6
	bl sub_76a0
	add r0, sp, #2
	mov r1, r4
	bl sub_76a0
	add r0, sp, #4
	mov r1, r6
	mov r2, #4
	bl memcpy
	add r0, sp, #8
	mov r1, r5
	mov r2, #4
	bl memcpy
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, r4
	add r1, sp, #4
	mov r0, r7
	mov r2, #0xc
	bl sub_7560
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_d924:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r7, r1
	mov r5, r2
	mov r4, r3
	ldr r0, [r2, #0xc]
	mov r0, r0, lsr #16
	teq r0, #2
	bne loc_d968
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	b sub_a0a4
loc_d968:
	teq r0, #3
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	beq sub_a5f0
	bl sub_dac8
	teq r0, #0
	bne loc_d9dc
	ldrb r0, [r7, #0x92]
	tst r0, #4
	beq loc_d9ac
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_d9d4
loc_d9ac:
	mov r1, #0
	ldr r2, [r5, #0xb8]
	ldr r3, [r5, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r2, r4
	mov r1, r5
	mov r0, r6
	mov r3, #0x10
	bl sub_dc28
	add sp, sp, #0xc
loc_d9d4:
	mov r0, #0xb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_d9dc:
	ldrb r8, [r7, #0x92]
	tst r8, #4
	beq loc_da00
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	b sub_ba18
loc_da00:
	tst r8, #2
	beq loc_da20
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	b sub_a84c
loc_da20:
	tst r8, #0x10
	bne loc_da3c
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	mov r0, #0xd
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_da3c:
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	bl sub_aea8
	tst r0, #0x80
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	tst r8, #0x20
	beq loc_da74
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	b sub_b51c
loc_da74:
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	bl sub_aca0
	tst r0, #0x80
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov sb, r0
	tst r8, #1
	beq loc_dab4
	mov r3, r4
	mov r2, r5
	mov r1, r7
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	b sub_bb0c
loc_dab4:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_dac8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r4, r1
	mov r5, r2
	mov r6, r3
	ldr r1, [r1, #0x8c]
	mov r1, r1, lsr #16
	mov r2, r1
	ldr r0, [r5, #0x48]
	ldrb r0, [r0, #0x92]
	tst r0, #2
	addne r1, r1, #1
	movne r1, r1, lsl #16
	movne r1, r1, lsr #16
	tst r0, #1
	addne r0, r1, #1
	movne r1, r0, lsl #16
	movne r1, r1, lsr #16
	ldr r3, [r5, #0xdc]
	movs r3, r3, lsr #16
	mov r0, #0
	bne loc_db48
	teq r1, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r0, [r4, #0x84]!
	ldr r1, [r5, #0xd4]!
	teq r0, r1
	movne r0, #0
	moveq r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_db48:
	ldr r1, [r4, #0x84]
	mov r8, #1
	ldr lr, [r5, #0xd4]
	teq r1, lr
	bne loc_db70
	cmp r2, r3
	strbgt r3, [r4, #0x8d]
	movgt r0, r3, asr #8
	bgt loc_dbd8
	b loc_dbf4
loc_db70:
	sub ip, lr, r1
	mov sb, ip
	cmp ip, #0
	ble sub_dbfc
	add r3, r1, r2
	sub r3, r3, lr
	cmp r3, #0
	ldmdble fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	sub r0, r2, ip
	strb r0, [r4, #0x8d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x8c]
	add r0, r1, ip
	str r0, [r4, #0x84]
	mov r2, ip
	mov r0, r7
	ldr r1, [r6, #8]
	bl sub_779c
	str r0, [r6, #8]
	ldr r1, [r4, #0x8c]
	ldr r0, [r5, #0xdc]
	mov r0, r0, lsr #16
	cmp r0, r1, lsr #16
	bge loc_dbf4
	strb r0, [r4, #0x8d]
	mov r0, r0, asr #8
loc_dbd8:
	strb r0, [r4, #0x8c]
	ldr r2, [r5, #0xdc]
	mov r2, r2, lsr #16
	mov r0, r7
	ldr r1, [r6, #8]!
	bl sub_77f8
	b loc_dc18
loc_dbf4:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_dbfc:
	add r1, sb, r3
	cmp r1, #0
	ldmdble fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	strb r0, [r4, #0x8d]
	strb r0, [r4, #0x8c]
	ldr r0, [r5, #0xd4]!
	str r0, [r4, #0x84]
loc_dc18:
	ldrb r0, [r4, #0x92]
	bic r0, r0, #1
	strb r0, [r4, #0x92]
	b loc_dbf4

sub_dc28:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r7, r0
	mov r5, r1
	movs r4, r2
	mov r6, r3
	ldr sl, [fp, #0x14]
	sub sp, sp, #0x10
	ldr r1, [r1, #0x48]
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #4]
	beq loc_dca8
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0
	bne loc_dc88
	teq sl, #0
	strne r4, [sp, #4]
	moveq r1, r4
	mov r4, #0
	b loc_dca8
loc_dc88:
	ldr r0, [r4, #8]
	teq r0, #0
	beq loc_dca8
	teq sl, #0
	strne r0, [sp, #4]
	moveq r1, r0
	mov r0, #0
	str r0, [r4, #8]
loc_dca8:
	ands r0, r6, #2
	str r0, [sp, #0xc]
	movne r2, #0x18
	moveq r2, #0x14
	mov r0, r7
	mov r3, #0
	str r2, [sp]
	bl sub_ec50
	mov sb, r0
	ldr r8, [r0, #0xc]!
	ldr r0, [r5, #0x22]
	mov r0, r0, lsr #16
	strb r0, [r8, #1]
	mov r0, r0, asr #8
	strb r0, [r8]
	ldr r0, [r5, #0x2a]
	mov r0, r0, lsr #16
	strb r0, [r8, #3]
	mov r0, r0, asr #8
	strb r0, [r8, #2]
	add r0, r8, #4
	ldr r1, [fp, #0x18]
	bl sub_7680
	add r0, r8, #8
	ldr r1, [fp, #0x1c]
	bl sub_7680
	ldr r2, [sp]
	mov r0, r2, lsl #2
	strb r0, [r8, #0xc]
	strb r6, [r8, #0xd]
	ldr r1, [r5, #0xde]
	mov r1, r1, lsr #16
	add r0, r8, #0xe
	bl sub_76a0
	mov r0, #0
	str r0, [r8, #0x10]
	tst r6, #0x20
	addne r0, r8, #0x12
	movne r1, #1
	blne sub_76a0
	ldr r0, [sp, #0xc]
	teq r0, #0
	beq loc_dd78
	add r0, r8, #0x14
	mov r1, #2
	strb r1, [r0], #1
	mov r1, #4
	strb r1, [r0], #1
	ldr r1, [sp, #8]
	ldr r1, [r1, #0x22]
	mov r1, r1, lsr #16
	bl sub_76a0
loc_dd78:
	ldr r0, [sp, #4]
	str r0, [sb, #8]
	mov r3, sb
	stmdb sp!, {r3}
	ldr r2, [sp, #4]
	add r3, sl, r2
	add r2, r5, #0x2c
	mov r8, r2
	add r1, r5, #0x24
	mov r0, r7
	bl sub_d8ac
	mov r1, r0
	add sp, sp, #4
	ldr r0, [sb, #0xc]
	add r0, r0, #0x10
	bl sub_76a0
	teq r4, #0
	beq loc_ddd4
	mov r2, sb
	mov r1, r4
	mov r0, r7
	bl sub_7f00
	b loc_ddd8
loc_ddd4:
	mov r4, sb
loc_ddd8:
	mov r3, #0
	teq sl, #0
	beq loc_de00
	teq r6, #0x10
	bne loc_de00
	ldr r0, [r5, #8]
	mov r0, r0, lsr #16
	ldr r1, [r5, #0xac]
	cmp r0, r1, lsr #16
	movgt r3, #1
loc_de00:
	stmdb sp!, {r3}
	mov r3, r8
	mov r2, r4
	mov r0, r7
	ldr r1, [sp, #0xc]
	bl sub_df6c
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_de1c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	movs r4, r2
	mov r1, #0
	mov sb, #0
	beq loc_de68
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0
	moveq r1, r4
	moveq r4, #0
	beq loc_de68
	ldr r0, [r4, #8]
	teq r0, #0
	movne r1, r0
	strne sb, [r4, #8]
loc_de68:
	mov r0, r6
	mov r3, #0
	mov r2, #0x14
	bl sub_ec50
	mov r8, r0
	ldr r7, [r0, #0xc]!
	ldr r0, [r5, #0x7e]
	mov r0, r0, lsr #16
	strb r0, [r7, #1]
	mov r0, r0, asr #8
	strb r0, [r7]
	ldr r0, [r5, #0x7c]
	mov r0, r0, lsr #16
	strb r0, [r7, #3]
	mov r0, r0, asr #8
	strb r0, [r7, #2]
	add r0, r7, #4
	ldr r1, [r5, #0x88]
	bl sub_7680
	mov r0, #0x50
	strb r0, [r7, #0xc]
	ldrb r0, [r5, #0x92]
	tst r0, #2
	ldr r0, [r5, #0x84]
	addne r0, r0, #1
	str r0, [r7, #8]
	moveq r0, #4
	movne r0, #0x14
	strb r0, [r7, #0xd]
	ldr r0, [r5, #0x2c]
	ldr r0, [r0, #0x38]
	mov r1, r0, lsl #16
	mov r1, r1, lsr #16
	add r0, r7, #0xe
	bl sub_76a0
	mov r3, r8
	str sb, [r7, #0x10]!
	stmdb sp!, {r3}
	add r2, r5, #0x80
	mov r7, r2
	add r1, r5, #0x24
	mov r0, r6
	mov r3, #0x14
	bl sub_d8ac
	mov r1, r0
	add sp, sp, #4
	ldr r0, [r8, #0xc]
	add r0, r0, #0x10
	bl sub_76a0
	teq r4, #0
	beq loc_df48
	mov r2, r8
	mov r1, r4
	mov r0, r6
	bl sub_7f00
	b loc_df4c
loc_df48:
	mov r4, r8
loc_df4c:
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, r7
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_df6c
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_df6c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	mov r6, r3
	ldr sb, [fp, #4]
	ldr r1, [r2, #0x18]
	ldrb r1, [r1, #9]
	mov r8, #0
	teq r1, #0
	movne r1, r5
	ldrne r5, [r5, #8]
	strne r8, [r1, #8]
	mov r3, #1
	mov r2, #0x18
	bl sub_ec50
	mov r7, r0
	ldr r0, [r0, #0xc]
	mov r1, #8
	str r1, [r0]
	mov r1, #4
	str r1, [r0, #4]
	mov r1, #0x14
	add r0, r0, #4
	stmib r0!, {r1, sb}
	str r8, [r0, #4]
	ldr r0, [r6]
	ldr r1, [r7, #0xc]
	str r0, [r1, #0x14]!
	str r5, [r7, #8]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	ldreq r0, [r4, #0x34]
	teqeq r0, #0
	bne loc_e01c
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r7
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	ldr pc, [r2]
loc_e01c:
	ldr r0, [r4, #0x34]
	teq r0, #0
	ldrne r0, [r4, #0x38]
	strne r7, [r0]
	streq r7, [r4, #0x34]
	str r8, [r7]
	str r7, [r4, #0x38]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_e03c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	add r7, r1, r2, lsl #2
	ldr r1, [r7, #0x94]
	teq r1, #0
	movne r0, r6
	blne sub_8a04
	add r0, r5, r4, lsl #1
	ldr r8, [r0, #0xa6]
	movs r8, r8, lsr #16
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, lit_e0a4
	add r0, r0, r4, lsl #2
	ldr r0, [r0, #0xa8]
	bl sub_11bfc
	mov r1, r0
	mov r3, r8
	mov r2, r5
	mov r0, r6
	bl sub_8924
	str r0, [r7, #0x94]!
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_e0a4:
	.rword data_11918			; relocated

sub_e0a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	add r7, r1, r2, lsl #2
	mov r6, #0
	ldr r1, [r7, #0x94]
	teq r1, #0
	beq loc_e0d8
	bl sub_8a04
	str r6, [r7, #0x94]!
loc_e0d8:
	add r0, r5, r4
	strb r6, [r0, #0xa2]
	teq r4, #1
	strbeq r6, [r5, #0xad]
	strbeq r6, [r5, #0xac]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_e0f0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r1, #0xec]
	teq r1, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r2, [r4, #0xf8]
	mov r2, r2, lsr #16
	cmp r2, #0
	ldmdble fp, {r4, r5, fp, sp, pc}
	ldr r3, [r4, #0xfa]
	movs r3, r3, lsr #16
	mov r5, #0
	bne loc_e140
	mov r3, #1
	strb r3, [r4, #0xfb]
	strb r5, [r4, #0xfa]
	ldr r3, [r4, #0xb8]
	str r3, [r4, #0xbc]
loc_e140:
	ldr r3, [r4, #0xb8]
	sub r3, r3, r2
	str r3, [r4, #0xb8]
	ldr r3, [r4, #0xc4]
	mov r3, r3, lsr #16
	add r2, r3, r2
	strb r2, [r4, #0xc5]
	mov r2, r2, asr #8
	strb r2, [r4, #0xc4]
	ldr r2, [r4, #0xf4]
	movs r2, r2, lsr #16
	ldrne r2, [r4, #0xe8]
	blne sub_7f00
	ldr r0, [r4, #0xec]
	str r0, [r4, #0xe8]
	ldr r0, [r4, #0xf4]
	mov r0, r0, lsr #16
	ldr r1, [r4, #0xf8]
	mov r1, r1, lsr #16
	add r0, r0, r1
	strb r0, [r4, #0xf5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf4]
	str r5, [r4, #0xec]
	strb r5, [r4, #0xf9]
	strb r5, [r4, #0xf8]
	ldr r0, [r4, #0x10]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_84a0
loc_e1b4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	teq r0, #4
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r2, [r4, #0xc]
	ldr r0, [r2, #4]
	ldr r1, [r1, #0x18]
	teq r1, #0
	beq loc_e26c
loc_e1ec:
	teq r0, r1
	beq loc_e204
	ldr r1, [r1, #0x8c]
	teq r1, #0
	bne loc_e1ec
	b loc_e26c
loc_e204:
	teq r1, #0
	beq loc_e26c
	ldr r1, [r0, #0xc]
	mov r1, r1, lsr #16
	teq r1, #5
	teqne r1, #8
	bne loc_e26c
	ldr r1, [r0, #0xf8]
	movs r1, r1, lsr #16
	beq loc_e26c
	ldr r1, [r2, #0xc]!
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	ldr r2, [r0, #0xc2]
	mov r2, r2, lsr #16
	add r2, r2, #0x14
	mov r2, r2, lsl #16
	cmp r1, r2, lsr #16
	bge loc_e260
	sub r1, r1, #0x14
	strb r1, [r0, #0xc3]
	mov r1, r1, asr #8
	strb r1, [r0, #0xc2]
loc_e260:
	mov r1, r0
	mov r0, r5
	bl sub_e0f0
loc_e26c:
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_7ed0

sub_e27c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	bl sub_8b84
	mov r1, r0
	ldr r0, [r4, #0x40]
	sub r0, r1, r0
	mov r0, r0, lsl #16
	movs r0, r0, lsr #16
	moveq r0, #1
	subs ip, r0, #0x7500
	cmpge ip, #0x30
	str r1, [r4, #0x40]
	ldmdbgt fp, {r4, r5, fp, sp, pc}
	ldr r1, [r4, #0x48]
	ldr r5, [r1, #0x2c]!
	ldr r3, [r4, #0x3a]
	mov r3, r3, lsr #16
	ldr r1, [r4, #0x3c]
	ldr r2, [r5, #0x24]
	mov r2, r2, lsl #16
	mov r2, r2, lsr #16
	add r1, r1, r0
	ldr ip, [r4, #0x38]
	teq r2, ip, lsr #16
	bne loc_e304
	add ip, r3, #1
	teq ip, r2
	moveq ip, #0
	ldr lr, [r4, #0x34]
	ldr ip, [lr, ip, lsl #1]
	mov ip, ip, lsr #16
	sub r1, r1, ip
loc_e304:
	str r1, [r4, #0x3c]
	ldr ip, [r4, #0x34]
	add ip, ip, r3, lsl #1
	strb r0, [ip, #1]
	mov r0, r0, asr #8
	strb r0, [ip]
	add r0, r3, #1
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	teq r0, r2
	moveq r0, #0
	strb r0, [r4, #0x3b]
	mov r0, r0, asr #8
	strb r0, [r4, #0x3a]
	ldr r0, [r4, #0x38]
	mov r0, r0, lsr #16
	cmp r0, r2
	bge loc_e360
	add r0, r0, #1
	strb r0, [r4, #0x39]
	mov r0, r0, asr #8
	strb r0, [r4, #0x38]
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_e360:
	mov r0, r2
	bl __rt_udiv
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	add r0, r0, r0, asr #1
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	ldr r1, [r5, #0x28]
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	cmp r1, r0
	bgt loc_e3a4
	ldr r1, [r5, #0x2c]!
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	cmp r1, r0
	bge loc_e3a8
loc_e3a4:
	mov r0, r1
loc_e3a8:
	strb r0, [r4, #0xa9]
	mov r0, r0, asr #8
	strb r0, [r4, #0xa8]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_e3b8:
	mov r2, #0
	b loc_e3d0

sub_e3c0:
	mov r2, #1
	b loc_e3d0

sub_e3c8:
	mov r2, #2
	b loc_e3d0
loc_e3d0:
	mov r0, #0
	add r3, r1, r2, lsl #2
	str r0, [r3, #0x94]!
	ldr r3, [r1, #0x48]
	teq r3, #0
	moveq pc, lr
	ldr r0, [r3, #0x20]
	mov r0, r0, lsr #16
	teq r0, #4
	movne pc, lr
	mov r0, #1
	teq r2, #2
	bne loc_e42c
	ldr r2, [r3, #0x30]
	mov r2, r2, lsr #16
	add r2, r2, #1
	strb r2, [r3, #0x31]
	mov r2, r2, asr #8
	strb r2, [r3, #0x30]
	add r1, r1, #2
	strb r0, [r1, #0xa2]
	ldr r0, [r3, #0xc]!
	b loc_e45c
loc_e42c:
	ldr r3, [r1, #0x10]
	teq r3, #0
	moveq pc, lr
	ldr r3, [r1, #0xa0]
	mov r3, r3, lsr #16
	add r3, r3, #1
	strb r3, [r1, #0xa1]
	mov r3, r3, asr #8
	strb r3, [r1, #0xa0]
	add r2, r1, r2
	strb r0, [r2, #0xa2]
	ldr r0, [r1, #0x10]!
loc_e45c:
	b sub_84a0

sub_e460:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r1, #0x48]
	teq r1, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	ldr r1, [r1, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	ldmdbne fp, {r4, fp, sp, pc}
	mov r1, #0

sub_e490:
	add r2, r4, r1
	ldrb r2, [r2, #0xa2]
	teq r2, #1
	bne loc_e4c8
	mov r2, #0
	add r3, r4, r1
	strb r2, [r3, #0xa2]
	teq r1, #0
	mov r1, r4
	bne loc_e4c0
	bl sub_e4f4
	b loc_e4d4
loc_e4c0:
	bl sub_e58c
	b loc_e4d4
loc_e4c8:
	add r1, r1, #1
	cmp r1, #2
	blo sub_e490
loc_e4d4:
	ldr r0, [r4, #0xa0]
	movs r0, r0, lsr #16
	ldmdbeq fp, {r4, fp, sp, pc}
	sub r0, r0, #1
	strb r0, [r4, #0xa1]
	mov r0, r0, asr #8
	strb r0, [r4, #0xa0]
	ldmdb fp, {r4, fp, sp, pc}

sub_e4f4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r1, #0xc]
	mov r0, r0, lsr #16
	teq r0, #6
	teqne r0, #7
	teqne r0, #5
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0xdc]
	mov r0, r0, lsr #16
	ldr r1, [r4, #0xde]
	teq r0, r1, lsr #16
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, #1
	strb r0, [r4, #0xe7]
	mov r0, #0
	strb r0, [r4, #0xe6]
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r2, [r4, #0xe0]
	mov r2, r2, lsr #16
	mov r1, r4
	mov r0, r5
	bl sub_ae3c
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x10
	mov r2, #0
	bl sub_dc28
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_e58c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r1, #0xc]
	mov r0, r0, lsr #16
	sub r1, r0, #3
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_e5b8:
	b loc_e648

sub_e5bc:
	b loc_e648

sub_e5c0:
	b loc_e6dc

sub_e5c4:
	b loc_e5d4

sub_e5c8:
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_e5cc:
	b loc_e6dc

sub_e5d0:
	b loc_e5d4
loc_e5d4:
	ldr r0, [r4, #0xac]
	mov r0, r0, lsr #16
	add r0, r0, #1
	mov r1, r0, lsl #16
	mov r1, r1, lsr #16
	strb r1, [r4, #0xad]
	mov r0, r1, asr #8
	strb r0, [r4, #0xac]
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x34]
	mov r0, r0, lsl #16
	cmp r1, r0, lsr #16
	ble sub_e770
loc_e60c:
	mov r1, #0
	ldr r2, [r4, #0xb8]
	ldr r3, [r4, #0xd4]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #4
	mov r2, #0
	bl sub_dc28
	mov r1, r4
	mov r0, r5
	mvn r3, #1
	mov r2, #0
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_b618
loc_e648:
	ldr r1, [r4, #0xac]
	mov r1, r1, lsr #16
	add r1, r1, #1
	mov r2, r1, lsl #16
	mov r2, r2, lsr #16
	strb r2, [r4, #0xad]
	mov r1, r2, asr #8
	strb r1, [r4, #0xac]
	ldr r1, [r4, #0x48]
	ldr r1, [r1, #0x2c]
	ldr r1, [r1, #0x34]
	mov r1, r1, lsl #16
	cmp r2, r1, lsr #16
	bgt loc_e60c
	teq r0, #3
	bne loc_e6a8
	mov r3, #0
	mov r1, #0
	ldr r2, [r4, #0xb0]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #2
	b loc_e7ec
loc_e6a8:
	mov r1, #0
	ldr r2, [r4, #0xb0]
	ldr r3, [r4, #0xd4]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x12
	b loc_e7ec
loc_e6c8:
	mov r1, r4
	mov r0, r5
	mov r2, #1
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_e03c
loc_e6dc:
	ldr r0, [r4, #0xf8]
	movs r0, r0, lsr #16
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0xac]
	mov r0, r0, lsr #16
	add r0, r0, #1
	mov r1, r0, lsl #16
	mov r1, r1, lsr #16
	strb r1, [r4, #0xad]
	mov r0, r1, asr #8
	strb r0, [r4, #0xac]
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x34]
	mov r0, r0, lsl #16
	cmp r1, r0, lsr #16
	bgt loc_e60c
	mov r0, r5
	mov r3, #0x83
	mov r2, #0x10
	mov r1, #0
	bl sub_ec50
	mov r5, r0
	ldr r0, [r0, #0xc]
	mov r1, #0x208
	stmia r0, {r1, r4}
	add r1, r4, #0x2c
	add r0, r0, #8
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #0x48]!
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_e770:
	ldr r0, [r4, #0xf8]
	movs r0, r0, lsr #16
	beq loc_e7cc
	ldr r0, [r4, #0xc6]
	movs r0, r0, lsr #16
	bne loc_e7b0
	ldr r0, [r4, #0xb8]
	sub r0, r0, #1
	str r0, [r4, #0xb8]
	ldr r0, [r4, #0xc4]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0xc5]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc4]
	b loc_e7bc
loc_e7b0:
	mov r0, #0
	strb r0, [r4, #0xc7]
	strb r0, [r4, #0xc6]
loc_e7bc:
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_e0f0
loc_e7cc:
	ldr r0, [r4, #0xb8]
	sub r2, r0, #1
	mov r1, #0
	ldr r3, [r4, #0xd8]
	stmdb sp!, {r1, r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0x11
loc_e7ec:
	mov r2, #0
	bl sub_dc28
	add sp, sp, #0xc
	b loc_e6c8

sub_e7fc:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r1, #0x20]
	mov r0, r0, lsr #16
	teq r0, #4
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r5, [r1, #0x18]!
	teq r5, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
loc_e828:
	ldrb r0, [r5, #0xa4]
	teq r0, #1
	beq loc_e844
	ldr r5, [r5, #0x8c]
	teq r5, #0
	bne loc_e828
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_e844:
	teq r5, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r5, #0x14]
	teq r0, #0
	bne loc_e870
	mov r1, r5
	mov r0, r4
	mov r3, #0
	mov r2, #0
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_b618
loc_e870:
	ldr r1, [r5, #0x48]
	mov r2, r5
	mov r0, r4
	bl sub_ef18
	mov r0, #1
	strb r0, [r5, #0xd]
	mov r0, #0
	strb r0, [r5, #0xc]
	ldr r0, [r5, #0xa]
	mov r0, r0, lsr #16
	teq r0, #1
	ldmdbne fp, {r4, r5, fp, sp, pc}
	mov r1, r5
	mov r0, r4
	mov r2, #0
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_9bc4

sub_e8b4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	sub sp, sp, #4
	mov r3, sp
	bl sub_e95c
	teq r0, #0
	teqne r0, #1
	beq loc_e908
	mov r7, #1
	teq r0, #0x13
	bne loc_e90c
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldr r3, [sp]
	bl sub_eb80
	b loc_e954
loc_e908:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_e90c:
	ldr r1, [sp]
	teq r1, #3
	teqne r1, #0xa
	teqne r1, #4
	mov r3, r0
	bne loc_e938
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_eae8
	b loc_e954
loc_e938:
	stmdb sp!, {r3}
	mov r3, r1
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_eb2c
	add sp, sp, #4
loc_e954:
	mov r0, r7
	b loc_e908

sub_e95c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r0, #3
	str r0, [r3]
	ldr r0, [r2, #0x18]
	ldrb r0, [r0, #9]
	mvn sb, #7
	teq r0, #0
	bne loc_e9b4
	ldr r0, [r5, #2]
	mov r0, r0, lsr #16
	teq r0, #8
	bne loc_ea2c
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	b sub_a8dc
loc_e9b4:
	add r1, r4, #0xc
	ldmia r1, {r0, r1}
	sub sl, r1, r0
	mvn r8, #5
	cmp sl, #4
	blo sub_ea44
	ldr r0, [r0]
	str r0, [r3]
	cmp r0, #0xa
	bls sub_ea04
	cmp r0, #0x200
	blo sub_e9f0
	subs ip, r0, #0x204
	cmphs ip, #2
	bls sub_e9f8

sub_e9f0:
	mvn r0, #6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_e9f8:
	add r0, r0, #0xf000000b
	sub r0, r0, #0x200
	add r0, r0, #0x10000000

sub_ea04:
	ldr r1, lit_ea34
	add r0, r1, r0, lsl #3
	add r7, r0, #0xb4
	ldr r1, [r5, #2]
	mov r1, r1, lsr #16
	ldrb r2, [r7]
	mov r0, r6
	bl sub_ebc8
	teq r0, #0
	bne loc_ea38
loc_ea2c:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_ea34:
	.rword data_11918			; relocated
loc_ea38:
	ldrb r0, [r7, #1]
	cmp r0, sl
	bls sub_ea4c

sub_ea44:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_ea4c:
	bhs loc_ea60
	ldrb r0, [r7, #2]
	tst r0, #1
	mvneq r0, #8
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_ea60:
	ldr r0, [r4, #8]
	teq r0, #0
	beq loc_ea94
	ldr r0, [r0, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0
	mvnne r0, #0x1d
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldrb r0, [r7, #2]
	tst r0, #2
	mvneq r0, #0x1a
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	b loc_eaa4
loc_ea94:
	ldrb r0, [r7, #2]
	tst r0, #2
	mvnne r0, #0x1b
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_eaa4:
	ldrb r0, [r7, #2]
	tst r0, #4
	beq loc_ead0
	mvn r0, #0xf
	ldr r1, [r5, #0x48]
	teq r1, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r1, [r1, #0x20]
	mov r1, r1, lsr #16
	teq r1, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_ead0:
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldr ip, [r7, #4]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	mov pc, ip

sub_eae8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x8a
	mov r2, #1
	bl sub_ec50
	mov r1, r0
	ldr r0, [r0, #0xc]
	strb r4, [r0]
	ldr r0, [r5, #0x14]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_eb2c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x83
	mov r2, #0x10
	ldr r6, [fp, #4]
	bl sub_ec50
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0x12
	stmia r0, {r2, r4, r6}
	mov r2, #0
	str r2, [r0, #0xc]!
	ldr r0, [r5, #0x14]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	ldr pc, [r2]

sub_eb80:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x83
	mov r2, #8
	bl sub_ec50
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0x13
	stmia r0, {r2, r4}
	ldr r0, [r5, #0x14]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_ebc8:
	mov r0, #1
	cmp r2, #0x14
	beq loc_ec48
	bgt loc_ebf8
	teq r2, #4
	teqne r2, #5
	teqne r2, #6
	bne loc_ec40
	teq r1, r2
	teqne r1, #0
	moveq pc, lr
	b loc_ec48
loc_ebf8:
	teq r2, #0x15
	beq loc_ec30
	teq r2, #0x16
	beq loc_ec20
	teq r2, #0x17
	bne loc_ec40
	teq r1, #8
	teqne r1, #7
	moveq pc, lr
	b loc_ec48
loc_ec20:
	teq r1, #8
	teqne r1, #0
	moveq pc, lr
	b loc_ec48
loc_ec30:
	teq r1, #1
	teqne r1, #2
	movne pc, lr
	b loc_ec48
loc_ec40:
	teq r1, r2
	moveq pc, lr
loc_ec48:
	mov r0, #0
	mov pc, lr

sub_ec50:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	mov r7, r3
	tst r2, #3
	moveq r8, r5
	bicne r0, r5, #3
	addne r8, r0, #4
	teq r4, #0
	bne loc_ec98
loc_ec84:
	mov r1, r8
	mov r0, r6
	bl sub_ed1c
	mov r4, r0
	b loc_ece4
loc_ec98:
	ldr r0, [r4, #0x18]
	ldrb r1, [r0, #8]
	teq r1, #1
	bne loc_ecb8
	ldmia r0, {r0, r1}
	sub r0, r1, r0
	cmp r0, r8
	bhs loc_ecc8
loc_ecb8:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_ec84
loc_ecc8:
	ldr r1, [r4, #8]
	teq r1, #0
	beq loc_ece4
	mov r0, r6
	bl sub_7ed0
	mov r0, #0
	str r0, [r4, #8]
loc_ece4:
	ldr r0, [r4, #0x18]
	strb r7, [r0, #9]
	ldr r0, [r4, #0x18]
	ldr r0, [r0, #4]
	sub r0, r0, r5
	str r0, [r4, #0xc]
	ands r1, r0, #3
	subne r0, r0, r1
	strne r0, [r4, #0xc]
	ldr r0, [r4, #0xc]
	add r0, r0, r5
	str r0, [r4, #0x10]
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_ed1c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r2, #2
	bl sub_7c44
	movs r5, r0
	bne loc_ed6c
	add r0, r4, #0x178
	ldr r1, [r0]
	teq r1, #0
	bne loc_ed58
loc_ed4c:
	ldr r1, [r0, #4]!
	teq r1, #0
	beq loc_ed4c
loc_ed58:
	mov r1, #0
	ldr r5, [r0]
	str r1, [r0]
	mov r0, r4
	bl sub_c5c0
loc_ed6c:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_ed74:
	stmdb sp!, {lr}
	add ip, r2, r3
	ldrb r0, [ip, #0x84]
	teq r0, #1
	ldmiaeq sp!, {pc}
	add r0, r2, r3, lsl #3
	add r0, r0, #0x4c
	ldr lr, [r1]
	teq lr, #0
	ldrne lr, [r1, #4]
	addne r3, lr, r3, lsl #3
	strne r2, [r3, #0x50]!
	streq r2, [r1]
	ldr r3, [r1, #4]
	str r3, [r0]
	mov r3, #0
	str r3, [r0, #4]!
	mov r0, #1
	str r2, [r1, #4]!
	strb r0, [ip, #0x84]
	ldmia sp!, {pc}

sub_edc8:
	stmdb sp!, {lr}
	add ip, r2, r3
	ldrb r0, [ip, #0x84]
	teq r0, #0
	ldmiaeq sp!, {pc}
	add r0, r2, r3, lsl #3
	ldr r2, [r0, #0x4c]!
	teq r2, #0
	addne r2, r2, r3, lsl #3
	ldrne lr, [r0, #4]
	strne lr, [r2, #0x50]!
	ldreq r2, [r0, #4]
	streq r2, [r1]
	ldr r2, [r0, #4]
	teq r2, #0
	ldr r0, [r0]
	addne r1, r2, r3, lsl #3
	strne r0, [r1, #0x4c]!
	streq r0, [r1, #4]!
	mov r0, #0
	strb r0, [ip, #0x84]
	ldmia sp!, {pc}

sub_ee20:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r2, #0
	bl sub_e0a8
	mov r1, r4
	mov r0, r5
	mov r2, #1
	bl sub_e0a8
	mov r1, r4
	mov r0, r5
	mov r2, #2
	bl sub_e0a8
	mov r6, #0
	strb r6, [r4, #0xa1]
	strb r6, [r4, #0xa0]
	ldr r0, [r4, #0xf4]
	movs r0, r0, lsr #16
	beq loc_ee8c
	strb r6, [r4, #0xf5]
	strb r6, [r4, #0xf4]
	mov r0, r5
	ldr r1, [r4, #0xe8]
	bl sub_7ed0
	str r6, [r4, #0xe8]
loc_ee8c:
	ldr r0, [r4, #0xf8]
	movs r0, r0, lsr #16
	beq loc_eeb0
	strb r6, [r4, #0xf9]
	strb r6, [r4, #0xf8]
	mov r0, r5
	ldr r1, [r4, #0xec]
	bl sub_7ed0
	str r6, [r4, #0xec]
loc_eeb0:
	ldr r0, [r4, #0xf6]
	movs r0, r0, lsr #16
	beq loc_eed4
	strb r6, [r4, #0xf7]
	strb r6, [r4, #0xf6]
	mov r0, r5
	ldr r1, [r4, #0xf0]
	bl sub_7ed0
	str r6, [r4, #0xf0]
loc_eed4:
	strb r6, [r4, #0xc7]
	strb r6, [r4, #0xc6]
	strb r6, [r4, #0xe5]
	strb r6, [r4, #0xe4]
	str r6, [r4, #0xbc]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_eeec:
	ldr r0, [r1, #0x1c]
	str r0, [r2, #0x90]
	teq r0, #0
	ldrne r0, [r1, #0x1c]
	strne r2, [r0, #0x8c]!
	streq r2, [r1, #0x18]
	mov r0, #0
	str r2, [r1, #0x1c]
	str r1, [r2, #0x48]!
	str r0, [r2, #0x44]
	mov pc, lr

sub_ef18:
	teq r1, #0
	teqne r2, #0
	moveq pc, lr
	ldr r0, [r2, #0x90]
	teq r0, #0
	ldrne r3, [r2, #0x8c]
	strne r3, [r0, #0x8c]!
	ldreq r0, [r2, #0x8c]
	streq r0, [r1, #0x18]
	ldr r0, [r2, #0x8c]
	teq r0, #0
	ldrne r1, [r2, #0x90]!
	strne r1, [r0, #0x90]!
	ldreq r0, [r2, #0x90]!
	streq r0, [r1, #0x1c]!
	mov pc, lr
data_ef58:
	.word 0x74637000			; strbtvc r7, [r3], #-0
loc_ef5c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	bl sub_76b0
	str r0, [r4, #0x13c]!
	mov r0, #1
	ldmdb fp, {r4, fp, sp, pc}

sub_ef80:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	ldr r1, [r2, #0xc]
	mov r2, r1
	mvn r0, #0x20
	ldr r3, [r1, #4]
	cmp r3, #8
	bhs loc_efb8
	teq r3, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_efb8:
	ldr ip, [r1, #8]
	add r1, r1, ip
	mov sl, #0
	teq r3, #0
	ldrne r3, [r1, #4]
	strne r3, [r4, #0x10]
	streq sl, [r4, #0x10]
	mov r3, #0

sub_efd8:
	add ip, r6, r3, lsl #2
	ldr r7, [ip, #0x40]!
	teq r7, #0
	beq loc_eff8
	ldr ip, [r7, #0x28]
	ldr lr, [r1, #4]
	teq ip, lr
	beq loc_f004
loc_eff8:
	add r3, r3, #1
	cmp r3, #4
	blo sub_efd8
loc_f004:
	teq r3, #4
	bne loc_f054
	ldr r3, [r1, #4]
	teq r3, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r3, #0

sub_f01c:
	add ip, r6, r3, lsl #2
	ldr r7, [ip, #0x40]!
	teq r7, #0
	beq loc_f048
	ldr ip, [r7, #0x30]
	ldr ip, [ip, #0x10]
	teq ip, #1
	bne loc_f048
	ldr ip, [r7, #0x28]
	teq ip, #0
	bne loc_f054
loc_f048:
	add r3, r3, #1
	cmp r3, #4
	blo sub_f01c
loc_f054:
	teq r3, #4
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r0, [r7, #0x28]
	teq r0, #0
	bne loc_f078
	ldr r0, [r7, #0x1c]
	teq r0, #0
	mvnne r0, #0x25
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_f078:
	mov r0, #2
	strb r0, [r4, #0xd]
	strb sl, [r4, #0xc]
	ldr r0, [r2, #4]!
	teq r0, #0
	ldrne r0, [r1, #2]
	movne r0, r0, lsr #16
	moveq r0, #0
	strb r0, [r4, #0xf]
	mov r0, r0, asr #8
	strb r0, [r4, #0xe]
	add sb, r4, #0xc
	ldr r8, [r6, #0x20]
	teq r8, #0
	beq loc_f0ec
loc_f0b4:
	ldr r0, [r8, #2]
	mov r0, r0, lsr #16
	teq r0, #6
	bne loc_f0e0
	add r1, r8, #0xc
	mov r0, sb
	mov r2, #8
	bl memcmp
	teq r0, #0
	mvneq r0, #0x22
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_f0e0:
	ldr r8, [r8, #0x2c]
	teq r8, #0
	bne loc_f0b4
loc_f0ec:
	mov r0, #6
	strb r0, [r4, #3]
	strb sl, [r4, #2]
	ldr r0, [r7, #0x30]
	ldr r0, [r0, #0x18]
	strb r0, [r4, #0x5d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x5c]
	ldr r0, [r7, #0x26]
	mov r0, r0, lsr #16
	strb r0, [r4, #0x1d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x1c]
	mov r2, r4
	mov r1, r7
	mov r0, r6
	bl sub_115a8
	mov r1, r5
	mov r0, r6
	mov r3, #0x83
	mov r2, #0x18
	bl sub_11364
	mov r5, r0
	ldr r0, [r0, #0xc]
	mov r1, #0x11
	str r1, [r0]
	mov r1, #8
	str r1, [r0, #4]
	mov r1, #0x10
	add r0, r0, #4
	stmib r0!, {r1, sl}
	mov r1, sb
	ldr r0, [r5, #0xc]
	add r0, r0, #0x10
	mov r2, #8
	bl memcpy
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r5
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_f19c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	ldr r1, [r1, #0x18]
	teq r1, #0
	mvnne r0, #0x25
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r6, [r5, #0xc]
	ldr r1, [r6, #4]
	teq r1, #8
	bne loc_f22c
	mov r3, #0x83
	mov r2, #0x10
	mov r1, #0
	bl sub_11364
	mov r7, r0
	ldr r0, [r0, #0xc]
	mov r1, #0x208
	stmia r0, {r1, r4}
	ldr r1, [r5, #0xc]
	ldr r2, [r6, #8]!
	add r1, r1, r2
	add r0, r0, #8
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	mov r1, r7
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	str r5, [r4, #0x18]!
	b loc_f238
loc_f22c:
	mov r2, r5
	mov r1, r4
	bl sub_f3dc
loc_f238:
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_f240:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	bl sub_11534
	mov r0, r5
	mov r3, #0x86
	mov r2, #1
	mov r1, #0
	bl sub_11364
	mov r1, r0
	mov r2, #3
	ldr r0, [r0, #0xc]
	strb r2, [r0]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #0
	strb r0, [r4, #3]
	strb r0, [r4, #2]
	ldr r1, [r4, #0x14]
	mov r2, r4
	mov r0, r5
	bl sub_115d4
	mov r0, #0x13
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_f2b4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov lr, r2
	mov r1, r2
	mov r3, #0x83
	mov r2, #0x28
	bl sub_11364
	mov lr, r0
	ldr r0, [r0, #0xc]
	ldr r6, lit_f328
	mov r5, r0
	ldmia r6!, {r1, r2, r3, ip}
	stmia r5!, {r1, r2, r3, ip}
	ldmia r6!, {r1, r2, r3, ip}
	stmia r5!, {r1, r2, r3, ip}
	ldmia r6, {r3, ip}
	stmia r5, {r3, ip}
	ldr r1, [r4, #2]
	mov r1, r1, lsr #16
	teq r1, #6
	bne loc_f32c
	mov r1, #3
	str r1, [r0, #0x24]
	ldr r1, [r4, #0x1c]
	mov r1, r1, lsr #16
	str r1, [r0, #4]!
	b loc_f334
lit_f328:
	.rword data_11bc4			; relocated
loc_f32c:
	mov r1, #0
	str r1, [r0, #0x24]!
loc_f334:
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	mov r1, lr
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_f354:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	ldr r3, [r2, #0xc]
	ldr r0, [r3, #4]
	ldr r1, [r1, #0x1c]
	teq r1, #0
	beq loc_f3cc
loc_f37c:
	teq r0, r1
	bne loc_f3c0
	ldr r2, [r0, #0x18]
	teq r2, #0
	beq loc_f3cc
	ldr r1, [r3, #0xc]!
	sub ip, r1, #8
	ldr r3, [r2, #0xc]
	ldr r1, [r3, #8]
	add r1, r3, r1
	str ip, [r1, #4]!
	mov r1, #0
	str r1, [r0, #0x18]
	mov r1, r0
	mov r0, r5
	bl sub_f3dc
	b loc_f3cc
loc_f3c0:
	ldr r1, [r1, #0x50]
	teq r1, #0
	bne loc_f37c
loc_f3cc:
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_7ed0

sub_f3dc:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	mov r3, #1
	mov r2, #0x10
	mov r1, #0
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #9
	str r2, [r0]
	mov r2, #0
	str r2, [r0, #8]
	str r2, [r0, #4]
	ldr r2, [r4, #0xc]
	ldr r2, [r2, #0xc]
	str r2, [r0, #0xc]!
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r1, #0x16
	ldr r0, [r4, #0xc]
	str r1, [r0]
	ldr r0, [r5, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_f464:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	sub sp, sp, #8
	ldr r8, [r1, #0x14]
	ldr r0, [r8, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	beq loc_f600
	mov r1, r4
	mov r0, r5
	mov r2, #0
	bl sub_7860
	mov r0, r0, lsl #16
	movs r0, r0, lsr #16
	str r0, [sp, #4]
	bne loc_f4c8
	mov r1, r4
	mov r0, r5
	bl sub_7ed0
	b loc_f5fc
loc_f4c8:
	ldr r0, [r4, #0xc]
	mov sb, r0
	mvn r7, #0x20
	ldr r1, [r0, #4]
	cmp r1, #8
	bge loc_f4e8
loc_f4e0:
	mov r0, r7
	b loc_f600
loc_f4e8:
	mov r1, r0
	ldr r0, [r0, #8]
	add sl, r1, r0
	add r1, sl, #4
	mov r0, sp
	mov r2, #4
	bl memcpy
	mov r1, #0
	ldr r0, [sp]
	bl sub_7460
	teq r0, #1
	teqne r0, #2
	beq loc_f4e0
	mov r0, r5
	mov r3, #0
	mov r2, #8
	mov r1, #0
	bl sub_11364
	mov r3, r0
	ldr r7, [r0, #0xc]!
	ldr r0, [sp, #4]
	add r0, r0, #8
	ldr r1, [r6, #0xe]
	mov r1, r1, lsr #16
	strb r1, [r7, #1]
	mov r1, r1, asr #8
	strb r1, [r7]
	ldr r1, [sl, #2]
	mov r1, r1, lsr #16
	strb r1, [r7, #3]
	mov r1, r1, asr #8
	strb r1, [r7, #2]
	mov r1, r0, lsr #8
	strb r1, [r7, #4]
	strb r0, [r7, #5]
	mov r1, #0
	strb r1, [r7, #7]
	strb r1, [r7, #6]
	ldr r1, [r4, #8]
	str r1, [r3, #8]
	str r3, [r4, #8]
	stmdb sp!, {r3}
	add r1, r8, #0x28
	mov r3, r0
	add r2, sp, #4
	mov r0, r5
	bl sub_f97c
	add sp, sp, #4
	movs r1, r0
	moveq r1, #0x10000
	subeq r1, r1, #1
	add r0, r7, #6
	bl sub_76a0
	mov r3, #0
	ldr r0, [sb, #0xc]
	teq r0, #1
	bne loc_f5e0
	ldr r0, [r4, #0xc]
	ldr r1, [sb, #0x10]!
	ldrb r3, [r0, r1]
	teq r3, #1
	movne r3, #0
loc_f5e0:
	stmdb sp!, {r3}
	add r3, sp, #4
	mov r2, r4
	mov r1, r8
	mov r0, r5
	bl sub_f9f4
	add sp, sp, #4
loc_f5fc:
	mov r0, #1
loc_f600:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_f604:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	sub sp, sp, #0x24
	ldr r0, [r1, #0x24]
	mov r0, r0, lsr #16
	teq r0, #4
	ldreq r0, [r4, #0xc]
	moveq r7, r0
	ldreq r1, [r0, #0xc]
	teqeq r1, #4
	beq loc_f654
loc_f640:
	mov r1, r4
	mov r0, r5
	bl sub_7ed0
	mov r0, #0xc
	b loc_f978
loc_f654:
	ldr r1, [r0, #0x10]
	add r1, r0, r1
	add r0, sp, #0x10
	mov r2, #4
	str r0, [sp, #0x20]
	bl memcpy
	add r8, r6, #0x28
	ldr r0, [r7, #4]
	teq r0, #4
	ldreq r0, [r4, #0xc]
	ldreq r1, [r7, #8]!
	addeq r1, r0, r1
	movne r1, r8
	mov r0, sp
	mov r2, #4
	bl memcpy
	ldr r7, [r4, #8]
	teq r7, #0
	beq loc_f6bc
	mov r1, r7
	mov r0, r5
	mov r2, #0
	bl sub_7860
	mov sb, r0
	cmp r0, #8
	bhs loc_f6d0
loc_f6bc:
	mov r1, r4
	mov r0, r5
	bl sub_7ed0
	mov r0, #8
	b loc_f978
loc_f6d0:
	ldr sl, [r7, #0xc]
	add r0, sl, #4
	bl sub_7668
	teq r0, sb
	beq loc_f6f8
	mov r1, r4
	mov r0, r5
	bl sub_7ed0
	mov r0, #0xa
	b loc_f978
loc_f6f8:
	add r0, sl, #6
	str r0, [sp, #0x1c]
	bl sub_7668
	str r0, [sp, #0x14]
	teq r0, #0
	beq loc_f7b0
	mov r3, r7
	stmdb sp!, {r3}
	mov r3, sb
	ldr r2, [sp, #0x24]
	add r1, sp, #4
	mov r0, r5
	bl sub_f97c
	add sp, sp, #4
	str r0, [sp, #0x18]
	teq r0, #0
	beq loc_f7b0
	ldr r0, [sp, #0x14]
	sub ip, r0, #0xff00
	teq ip, #0xff
	bne loc_f790
	mov r2, #2
	mov r1, #0
	ldr r0, [sp, #0x1c]
	bl memset
	mov r3, r7
	stmdb sp!, {r3}
	mov r3, sb
	ldr r2, [sp, #0x24]
	add r1, sp, #4
	mov r0, r5
	bl sub_f97c
	add sp, sp, #4
	str r0, [sp, #0x18]
	mov r1, #0x10000
	sub r1, r1, #1
	ldr r0, [sp, #0x1c]
	bl sub_76a0
loc_f790:
	ldr r0, [sp, #0x18]
	teq r0, #0
	beq loc_f7b0
	mov r1, r4
	mov r0, r5
	bl sub_7ed0
	mov r0, #9
	b loc_f978
loc_f7b0:
	mov r0, #2
	strb r0, [sp, #0xd]
	mov r2, #0
	strb r2, [sp, #0xc]
	ldrb r1, [sl, #1]
	strb r1, [sp, #0xf]
	ldrb r1, [sl]
	strb r1, [sp, #0xe]
	strb r0, [sp, #5]
	strb r2, [sp, #4]
	add r1, sl, r0
	ldrb r0, [r1, #1]
	strb r0, [sp, #7]
	ldrb r0, [r1]
	strb r0, [sp, #6]
	mov r1, r8
	add r0, sp, #8
	mov sl, r0
	mov r2, #4
	bl memcpy
	add r2, sp, #4
	mov r1, r6
	mov r0, r5
	bl sub_fa84
	movs sb, r0
	bne loc_f82c
	mov r1, r4
	mov r0, r5
	bl sub_7ed0
	mov r0, #0xb
	b loc_f978
loc_f82c:
	ldr r0, [sb, #0x5c]
	movs r0, r0, lsr #16
	beq loc_f640
	mov r0, #0
	str sb, [r6, #0x18]!
	str r0, [r4, #8]
	mov r1, r4
	mov r0, r5
	mov r3, #1
	mov r2, #0x24
	bl sub_11364
	mov r4, r0
	mov r1, r7
	ldr r6, [r0, #0xc]!
	mov r0, r5
	mov r2, #8
	bl sub_779c
	str r0, [r4, #8]
	mov r0, #0x14
	mov r5, #8
	stmia r6, {r0, r5}
	str r0, [r6, #8]
	ldr r0, [r4, #0xc]
	add r0, r0, #0x14
	add r1, sp, #0xc
	mov r2, #8
	bl memcpy
	mov r0, r8
	mov r1, sp
	mov r2, #4
	bl memcmp
	teq r0, #0
	streq r0, [r6, #0xc]
	streq r0, [r6, #0x10]!
	beq loc_f8e8
	mov r0, #0x1c
	str r5, [r6, #0xc]!
	str r0, [r6, #4]
	mov r0, sl
	mov r1, sp
	mov r2, #4
	bl memcpy
	ldr r0, [r4, #0xc]
	add r0, r0, #0x1c
	add r1, sp, #4
	mov r2, #8
	bl memcpy
loc_f8e8:
	ldr r0, [sb, #0x58]
	teq r0, #0
	bne loc_f924
	ldr r0, [sb, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_f924
	ldr r0, [sb, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_f974
loc_f924:
	ldr r0, [sb, #0x58]
	teq r0, #0
	streq r4, [sb, #0x58]
	beq loc_f954
	ldr r1, [r0]
	teq r1, #0
	beq loc_f950
loc_f940:
	ldr r0, [r0]
	ldr r1, [r0]
	teq r1, #0
	bne loc_f940
loc_f950:
	str r4, [r0]
loc_f954:
	mov r0, #0
	str r0, [r4]
	ldr r0, [sb, #0x5c]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [sb, #0x5d]
	mov r0, r0, asr #8
	strb r0, [sb, #0x5c]
loc_f974:
	mov r0, #0
loc_f978:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_f97c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r1
	mov r5, r2
	mov r4, r3
	ldr r7, [fp, #4]
	sub sp, sp, #0x10
	mov r0, sp
	mov r1, #0x11
	bl sub_76a0
	add r0, sp, #2
	mov r1, r4
	bl sub_76a0
	add r0, sp, #4
	mov r1, r6
	mov r2, #4
	bl memcpy
	add r0, sp, #8
	mov r1, r5
	mov r2, #4
	bl memcpy
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, r4
	add r1, sp, #4
	mov r0, r7
	mov r2, #0xc
	bl sub_7560
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_f9f4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r1
	mov r4, r2
	mov r5, r3
	ldr r8, [fp, #4]
	ldr r1, [r2, #0x18]
	ldrb r1, [r1, #9]
	mov r7, #0
	teq r1, #0
	movne r1, r4
	ldrne r4, [r4, #8]
	strne r7, [r1, #8]
	mov r3, #1
	mov r2, #0x18
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #8
	str r2, [r0]
	mov r2, #4
	str r2, [r0, #4]
	mov r2, #0x14
	add r0, r0, #4
	stmib r0!, {r2, r8}
	str r7, [r0, #4]
	ldr r0, [r5]
	ldr r2, [r1, #0xc]
	str r0, [r2, #0x14]!
	str r4, [r1, #8]
	ldr r0, [r6, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	ldr pc, [r2]

sub_fa84:
	stmdb sp!, {r4, r5, lr}
	mov r0, #0
	mov ip, r0
	mov r3, r0
	ldr r1, [r1, #0x1c]
	teq r1, #0
	beq loc_fb1c
	ldr r4, [r2, #2]
	mov r4, r4, lsr #16
loc_faa8:
	ldr lr, [r1, #0xe]
	mov lr, lr, lsr #16
	teq lr, r4
	bne loc_fad8
	ldr r5, [r2, #4]
	ldr lr, [r1, #0x10]
	teq r5, lr
	moveq r0, r1
	ldmiaeq sp!, {r4, r5, pc}
	teq lr, #0
	moveq r0, r1
	b loc_fafc
loc_fad8:
	teq lr, #0
	bne loc_fafc
	ldr r5, [r2, #4]
	ldr lr, [r1, #0x10]
	teq r5, lr
	moveq r3, r1
	beq loc_fafc
	teq lr, #0
	moveq ip, r1
loc_fafc:
	ldr r1, [r1, #0x50]
	teq r1, #0
	bne loc_faa8
	teq r0, #0
	ldmiane sp!, {r4, r5, pc}
	teq r3, #0
	movne r0, r3
	ldmiane sp!, {r4, r5, pc}
loc_fb1c:
	mov r0, ip
	ldmia sp!, {r4, r5, pc}

sub_fb24:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r3
	ldr r7, [r0, #4]
	ldr r0, [r7, #0x14]
	teq r0, #0
	bne loc_fb6c
	mov r0, r7
	bl sub_103bc
	movs r8, r0
	beq loc_fb74
	mov r0, r7
	bl sub_10410
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_fb6c:
	add r0, r0, #1
	str r0, [r7, #0x14]
loc_fb74:
	teq r5, #2
	bne loc_fb8c
	mov r0, r7
	bl sub_105c4
	mov r5, r0
	b loc_fba0
loc_fb8c:
	mov r5, r6, lsl #16
	mov r5, r5, lsr #16
	cmp r5, #2
	mvngt r0, #3
	ldmdbgt fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_fba0:
	cmp r5, #0
	mvnlt r0, #2
	ldmdblt fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r0, [r4, #0x18]
	teq r0, #0
	beq loc_fbc8
	mov r1, r5
	mov r0, r7
	bl sub_10648
	b loc_fc30
loc_fbc8:
	mov r0, r7
	bl sub_10468
	teq r0, #0
	bne loc_fbec
	mov r1, r5
	mov r0, r7
	bl sub_10648
	mvn r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_fbec:
	cmp r5, #2
	bgt loc_fc0c
	add r1, r7, r5, lsl #2
	str r0, [r1, #0xd4]!
	add r1, r5, #1
	strb r1, [r0, #3]
	mov r1, r1, lsr #8
	strb r1, [r0, #2]
loc_fc0c:
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x30]
	str r0, [r1, #0x18]!
	str r4, [r0, #8]
	ldr r1, [r4, #0x30]!
	str r1, [r0, #4]
	strb r5, [r0, #1]
	mov r1, r5, lsr #8
	strb r1, [r0]
loc_fc30:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_fc38:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r6, [r0, #0x18]
	teq r6, #0
	ldr r5, [r0, #4]
	beq loc_fce8
	mov r1, #1
	ldr r0, [r6, #8]
	bl sub_7fa0
	mov r1, #1
	ldr r0, [r6, #4]
	bl sub_7fa0
	ldr r1, [r6]
	mov r1, r1, lsr #16
	mov r0, r5
	bl sub_10648
	mov r1, r6
	mov r0, r5
	bl sub_11534
	ldr r0, [r6, #2]
	mov r0, r0, lsr #16
	teq r0, #6
	bne loc_fcb0
	ldr r1, [r6, #0x14]
	mov r2, r6
	mov r0, r5
	bl sub_115d4
loc_fcb0:
	mov r1, r6
	mov r0, r5
	bl sub_104b8
	ldr r0, [r4, #0x30]
	str r7, [r0, #0x18]!
	teq r5, #0
	str r7, [r4, #0x18]!
	ldrne r0, [r5, #0x14]
	teqne r0, #0
	beq loc_fce8
	subs r0, r0, #1
	str r0, [r5, #0x14]
	moveq r0, r5
	bleq sub_10410
loc_fce8:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_fcf0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, #0
	ldr r1, [r0, #0x18]
	teq r1, #0
	ldr r6, [r0, #4]
	bne loc_fd28
loc_fd18:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_fddc
loc_fd28:
	ldr r0, [r4, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #1
	beq loc_fdbc
	teq r0, #0xe
	beq loc_fdac
	teq r0, #0x83
	beq loc_fdbc
	teq r0, #0x86
	bne loc_fdcc
	ldr r1, [r4, #0xc]
	ldrb r0, [r1]
	tst r0, #2
	beq loc_fd74
	bic r0, r0, #2
	strb r0, [r1]
	mov r0, r5
	mov r1, #1
	bl sub_7fa0
loc_fd74:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_fd18
	mov r1, #1
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_fddc
loc_fdac:
	mov r2, r4
	mov r0, r6
	bl sub_10b10
	b loc_fddc
loc_fdbc:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	b loc_fddc
loc_fdcc:
	mov r2, r4
	mov r0, r6
	mvn r3, #1
	bl sub_11218
loc_fddc:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_fde4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r6, [r0, #4]
	ldr r0, [r1, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #1
	teqne r0, #0x83
	beq loc_fe20
	teq r0, #0x86
	beq loc_fe30
	teq r0, #0x8a
	bne loc_fe94
loc_fe20:
	mov r1, r4
	mov r0, r5
	bl sub_81a0
	b loc_fea0
loc_fe30:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #1
	beq loc_fe5c
	mov r0, r5
	mov r1, #1
	bl sub_7fa0
	ldr r0, [r4, #0xc]
	ldrb r1, [r0]
	bic r1, r1, #1
	strb r1, [r0]
loc_fe5c:
	ldr r0, [r4, #0xc]
	ldrb r0, [r0]
	tst r0, #2
	beq loc_fe94
	mov r1, #1
	ldr r0, [r5, #0x30]
	bl sub_7fa0
	ldr r0, [r5, #0x30]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_fea0
loc_fe94:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
loc_fea0:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_fea8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r6, [r0, #0x18]
	teq r6, #0
	ldr r5, [r0, #4]
	bne loc_fedc
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_ff70
loc_fedc:
	ldr r0, [r5, #0xf0]
	movs r0, r0, lsr #16
	beq loc_fefc
	add r1, r5, #0x18
	mov r2, r6
	mov r0, r5
	mov r3, #0
	b loc_ff48
loc_fefc:
	mov r0, r4
	bl sub_8004
	movs r8, r0
	beq loc_ff60
loc_ff0c:
	mov r2, r8
	mov r1, r6
	mov r0, r5
	bl sub_11020
	teq r0, #0
	bne loc_ff50
	mov r2, r8
	ldr r1, [r4, #8]
	mov r0, r4
	bl sub_8030
	ldr r0, [r6, #0x14]
	add r1, r0, #0x54
	mov r2, r6
	mov r0, r5
	mov r3, #4
loc_ff48:
	bl sub_11488
	b loc_ff70
loc_ff50:
	mov r0, r4
	bl sub_8004
	movs r8, r0
	bne loc_ff0c
loc_ff60:
	ldr r1, [r6, #0x14]!
	teq r1, #0
	movne r0, r5
	blne sub_100f8
loc_ff70:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_ff78:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	ldr r5, [r0, #0x18]
	teq r5, #0
	ldr r7, [r0, #4]
	bne loc_ffac
	mov r0, r4
	mov r1, #1
	bl sub_7fa0
	b loc_1001c
loc_ffac:
	ldr r0, [r7, #0xf0]
	movs r0, r0, lsr #16
	beq loc_ffcc
	mov r0, #1
	strb r0, [r5, #0x11]
	mov r0, r6
	strb r6, [r5, #0x10]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_ffcc:
	ldr r0, [r5, #0x2c]
	mov r0, r0, lsr #16
	teq r0, #1
	bne loc_ffec
	mov r1, r5
	mov r0, r7
	bl sub_10a34
	b loc_1001c
loc_ffec:
	mov r0, r4
	bl sub_8004
	teq r0, #0
	beq loc_1001c
loc_fffc:
	mov r2, r0
	mov r1, r5
	mov r0, r7
	bl sub_10670
	mov r0, r4
	bl sub_8004
	teq r0, #0
	bne loc_fffc
loc_1001c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_10024:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, #0
	ldr r4, [r0, #0x18]
	teq r4, #0
	bne loc_1004c
	mov r1, #1
	bl sub_7fa0
	b loc_100b4
loc_1004c:
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	bne loc_100b4
loc_10060:
	ldr r1, [r4, #0x58]
	teq r1, #0
	beq loc_100b4
	ldr r0, [r1]
	str r0, [r4, #0x58]
	ldr r0, [r4, #0x5c]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x5d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x5c]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #1
	beq loc_10060
loc_100b4:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_100bc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, #0
	ldr r1, [r0, #0x18]
	teq r1, #0
	ldr r2, [r0, #4]
	bne loc_100e8
	mov r1, #1
	bl sub_7fa0
	b loc_100f0
loc_100e8:
	mov r0, r2
	bl sub_100f8
loc_100f0:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_100f8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r1, #8]
	ldr r0, [r0, #0x10]
	bl sub_7f30
	teq r0, #0
	addne r1, r4, #0x54
	ldrne r4, [r1]
	teqne r4, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r2, r4
	mov r0, r5
	mov r3, #4
	bl sub_114dc
	ldr r0, [r4, #4]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_84a0

sub_10148:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0xf0]
	movs r0, r0, lsr #16
	add r1, r0, #1
	strb r1, [r4, #0xf1]
	mov r1, r1, asr #8
	strb r1, [r4, #0xf0]
	ldmdbne fp, {r4, fp, sp, pc}
	ldr r0, lit_101b4
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0
	mov r2, #0x20
	bl sub_843c
	ldr r0, lit_101b8
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0x64
	mov r2, #0
	bl sub_8924
	str r0, [r4, #0xf4]!
	ldmdb fp, {r4, fp, sp, pc}
lit_101b4:
	.rword sub_101bc			; relocated
lit_101b8:
	.rword sub_10308			; relocated

sub_101bc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0xf0]
	movs r0, r0, lsr #16
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	add r5, r4, #0xe0
	mov r6, #0

sub_101e0:
	ldr r0, [r5]
	teq r0, #0
	bne loc_10220
	mov r0, r4
	mov r2, #1
	mov r1, #0x20
	bl sub_7c44
	str r0, [r5]
	teq r0, #0
	beq loc_10230
	ldr r0, [r4, #0xf0]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0xf1]
	mov r0, r0, asr #8
	strb r0, [r4, #0xf0]
loc_10220:
	add r5, r5, #4
	add r6, r6, #1
	cmp r6, #4
	blo sub_101e0
loc_10230:
	ldr r0, [r4, #0xf0]
	movs r0, r0, lsr #16
	beq loc_1025c
	ldr r0, lit_10304
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0
	mov r2, #0x20
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_843c
loc_1025c:
	mov r6, #0
	ldr r1, [r4, #0xf4]
	teq r1, #0
	beq loc_10278
	mov r0, r4
	bl sub_8a04
	str r6, [r4, #0xf4]
loc_10278:
	ldr r5, [r4, #0x18]
	teq r5, #0
	beq loc_102b4
	add r7, r4, #0x18
loc_10288:
	mov r1, r7
	mov r2, r5
	mov r0, r4
	mov r3, #0
	bl sub_114dc
	ldr r0, [r5, #4]!
	teq r0, #0
	blne sub_84a0
	ldr r5, [r4, #0x18]
	teq r5, #0
	bne loc_10288
loc_102b4:
	add r4, r4, #0x40
	mov r5, #0

sub_102bc:
	ldr r0, [r4]
	teq r0, #0
	beq loc_102f0
	ldr r1, [r0, #0x10]
	mov r1, r1, lsr #16
	teq r1, #1
	bne loc_102f0
	strb r6, [r0, #0x11]
	strb r6, [r0, #0x10]
	ldr r0, [r4]
	ldr r0, [r0, #0xc]
	teq r0, #0
	blne sub_84a0
loc_102f0:
	add r4, r4, #4
	add r5, r5, #1
	cmp r5, #4
	blo sub_102bc
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_10304:
	.rword sub_101bc			; relocated

sub_10308:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0xf0]
	movs r0, r0, lsr #16
	moveq r0, #0
	beq loc_1039c
	ldr r5, [r4, #0x20]
	teq r5, #0
	beq loc_10380
loc_10334:
	ldr r0, [r5, #0x14]
	teq r0, #0
	beq loc_10374
	mov r1, r5
	mov r0, r4
	bl sub_11534
	ldr r1, [r5, #0x14]
	mov r2, r5
	mov r0, r4
	bl sub_115d4
	mov r1, r5
	mov r0, r4
	mvn r3, #0
	mov r2, #0
	bl sub_11218
	b loc_10380
loc_10374:
	ldr r5, [r5, #0x24]
	teq r5, #0
	bne loc_10334
loc_10380:
	ldr r0, lit_103a4
	bl sub_11bfc
	mov r1, r0
	mov r0, r4
	mov r3, #0x64
	mov r2, #0
	bl sub_8924
loc_1039c:
	str r0, [r4, #0xf4]!
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_103a4:
	.rword sub_10308			; relocated

sub_103a8:
	mov r2, r0
	ldr r1, lit_103b8
	mov r0, #0xf8
	b sub_7bf4
lit_103b8:
	.word 0x55445020			; 'UDP '

sub_103bc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #1
	str r0, [r4, #0x14]
	add r6, r4, #0xe0
	mov r5, #0

sub_103dc:
	mov r0, r4
	mov r2, #1
	mov r1, #0x20
	bl sub_7c44
	str r0, [r6], #4
	teq r0, #0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	add r5, r5, #1
	cmp r5, #4
	blt sub_103dc
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_10410:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r5, r0, #0xe0
	mov r6, #0

sub_10428:
	ldr r1, [r5]
	teq r1, #0
	movne r0, r4
	blne sub_7ed0
	add r5, r5, #4
	add r6, r6, #1
	cmp r6, #4
	blt sub_10428
	ldr r1, [r4, #0xf4]
	teq r1, #0
	movne r0, r4
	blne sub_8a04
	mov r0, r4
	mov r1, #0xf8
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_7c34

sub_10468:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0x60
	bl sub_7b9c
	movs r5, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r5
	mov r2, #0x60
	mov r1, #0
	bl memset
	add r1, r4, #0x20
	mov r2, r5
	mov r0, r4
	mov r3, #1
	bl sub_11488
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_104b8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	bl sub_11534
	ldr r0, [r4]
	mov r0, r0, lsr #16
	cmp r0, #2
	movle r1, #0
	addle r0, r5, r0, lsl #2
	strle r1, [r0, #0xd4]!
	mov r6, #0

sub_104ec:
	add r0, r5, r6, lsl #3
	add r1, r0, #0x18
	mov r3, r6
	mov r2, r4
	mov r0, r5
	bl sub_114dc
	add r6, r6, #1
	cmp r6, #4
	blo sub_104ec
	ldr r0, [r4, #0x14]
	teq r0, #0
	beq loc_10530
	add r1, r0, #0x54
	mov r2, r4
	mov r0, r5
	mov r3, #4
	bl sub_114dc
loc_10530:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_7be0

sub_1053c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x60
	bl sub_7b9c
	movs r4, r0
	mov r5, #0
	moveq r0, r5
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r4
	mov r2, #0x60
	mov r1, #0
	bl memset
	mov r0, #4
	strb r0, [r4, #1]
	strb r5, [r4]
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_10584:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r1]
	mov r1, r1, lsr #16
	teq r1, #4
	movne r2, #0
	addne r0, r0, r1, lsl #2
	strne r2, [r0, #0x40]!
	ldr r0, [r4, #0x30]
	teq r0, #0
	blne sub_7be0
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_7be0

sub_105c4:
	stmdb sp!, {lr}
	ldr r3, lit_10620
	add r1, r0, #0x54
	mov r2, #0

sub_105d4:
	ldrb ip, [r1]
	teq ip, #0xff
	beq loc_10630
	mov r0, #0

sub_105e4:
	teq r2, #0
	bne loc_105f4
	cmp r0, #2
	bls sub_10624
loc_105f4:
	add lr, r3, r0
	ldrb lr, [lr, #0x80]
	tst lr, ip
	bne sub_10624
	add r3, r3, r0
	ldrb r3, [r3, #0x80]
	ldrb ip, [r1]
	orr r3, r3, ip
	strb r3, [r1]
	add r0, r0, r2, lsl #3
	ldmia sp!, {pc}
lit_10620:
	.rword data_11a94			; relocated

sub_10624:
	add r0, r0, #1
	cmp r0, #8
	blo sub_105e4
loc_10630:
	add r2, r2, #1
	add r1, r1, #1
	cmp r2, #0x80
	blo sub_105d4
	mvn r0, #0
	ldmia sp!, {pc}

sub_10648:
	ldr r2, lit_1066c
	add r0, r0, r1, lsr #3
	ldrb r3, [r0, #0x54]
	and r1, r1, #7
	add r1, r1, r2
	ldrb r1, [r1, #0x80]
	bic r1, r3, r1
	strb r1, [r0, #0x54]
	mov pc, lr
lit_1066c:
	.rword data_11a94			; relocated

sub_10670:
	mov r3, #0
	str r3, [r1, #0x18]
	ldr r3, [r2, #0x18]
	ldrb r3, [r3, #9]
	teq r3, #0x8a
	moveq r3, #7
	beq loc_106bc
	ldr r3, [r2, #0xc]
	ldr r3, [r3]
	sub ip, r3, #0x300
	teq ip, #3
	beq sub_f354
	cmp r3, #0x10
	blo sub_106b0
	cmp r3, #0x15
	bls sub_106b8

sub_106b0:
	mov r3, #6
	b loc_106bc

sub_106b8:
	sub r3, r3, #0x10
loc_106bc:
	ldr ip, lit_106c8
	add r3, ip, r3, lsl #2
	ldr pc, [r3, #0x88]
lit_106c8:
	.rword data_11a94			; relocated

sub_106cc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	mov r3, #1
	mov r2, #0x21
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #6
	str r2, [r0]
	mov r2, #4
	mov r3, #0x1c
	stmib r0, {r2, r3}
	mov r3, #0
	str r2, [r0, #0x10]
	mov r2, #1
	mov ip, #0x20
	str r3, [r0, #0xc]!
	add r0, r0, #4
	stmib r0!, {r2, ip}
	ldr r0, [r4, #0x28]
	ldr ip, [r1, #0xc]
	str r0, [ip, #0x1c]!
	mov ip, #0x11
	ldr r0, [r1, #0xc]
	strb ip, [r0, #0x20]
	strb r2, [r4, #0x25]
	strb r3, [r4, #0x24]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, fp, sp, lr}
	ldr pc, [r2]

sub_10758:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, r2
	ldr r2, [r4, #0x24]
	mov r2, r2, lsr #16
	mov r5, #1
	teq r2, #1
	beq loc_10788
	bl sub_7ed0
	b loc_107c8
loc_10788:
	mov r3, #0x83
	mov r2, #4
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #5
	str r2, [r0]
	mov r0, #2
	strb r0, [r4, #0x25]
	mov r0, #0
	strb r0, [r4, #0x24]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_107c8:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_107d0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r3, [r1, #0x24]
	mov r3, r3, lsr #16
	mov r4, #0
	teq r3, #2
	bne loc_107fc
	ldr ip, [r0, #0xd8]
	teq ip, #0
	bne loc_10808
loc_107fc:
	mov r1, r2
	bl sub_7ed0
	b loc_10888
loc_10808:
	ldr r3, [r2, #0xc]
	ldr lr, [r3, #0x38]
	teq lr, #2
	ldreq lr, [r3, #0x50]
	teqeq lr, #2
	beq loc_1083c
	mvn r3, #0x1e
	stmdb sp!, {r3}
	mov r1, ip
	mov r3, #0x200
	bl sub_1125c
	add sp, sp, #4
	b loc_10888
loc_1083c:
	ldr lr, [r1, #0x26]
	mov lr, lr, lsr #16
	add lr, lr, #8
	mov lr, lr, lsl #16
	ldr r3, [r3, #4]
	mov r3, r3, lsl #16
	mov r3, r3, lsr #16
	cmp r3, lr, lsr #16
	bge loc_10870
	sub r3, r3, #8
	strb r3, [r1, #0x27]
	mov r3, r3, asr #8
	strb r3, [r1, #0x26]
loc_10870:
	mov r3, #4
	strb r3, [r1, #0x25]
	strb r4, [r1, #0x24]
	mov r1, ip
	mov r3, #0x200
	bl sub_112b0
loc_10888:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_10890:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r1, [r0, #0xd8]
	ldr r3, [r4, #0x24]
	mov r3, r3, lsr #16
	mov r5, #0
	teq r3, #1
	beq loc_108d4
	teq r3, #2
	beq loc_10904
	teq r3, #4
	bne loc_10930
	mov r1, r4
	bl sub_10940
	b loc_10938
loc_108d4:
	teq r1, #0
	bne loc_108e8
	mov r1, r2
	bl sub_7ed0
	b loc_108fc
loc_108e8:
	mvn r3, #0x1f
	stmdb sp!, {r3}
	mov r3, #0x200
	bl sub_1125c
	add sp, sp, #4
loc_108fc:
	mov r0, #3
	b loc_10924
loc_10904:
	teq r1, #0
	bne loc_10918
	mov r1, r2
	bl sub_7ed0
	b loc_10920
loc_10918:
	mov r3, #0x200
	bl sub_112b0
loc_10920:
	mov r0, #4
loc_10924:
	strb r0, [r4, #0x25]
	strb r5, [r4, #0x24]
	b loc_10938
loc_10930:
	mov r1, r2
	bl sub_7ed0
loc_10938:
	mov r0, #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_10940:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r1, #0x24]
	mov r0, r0, lsr #16
	mov r7, #7
	mov r6, #0
	teq r0, #1
	teqne r0, #2
	beq loc_109a0
	teq r0, #4
	mov r1, r2
	mov r0, r4
	bne loc_109f0
	bl sub_7ed0
	mov r0, #1
	strb r0, [r5, #0x2d]
	strb r6, [r5, #0x2c]
	mov r1, r5
	mov r0, r4
	bl sub_10a34
	b loc_109d4
loc_109a0:
	ldr r1, [r4, #0xd8]
	teq r1, #0
	bne loc_109bc
	mov r1, r2
	mov r0, r4
	bl sub_7ed0
	b loc_109d4
loc_109bc:
	mvn r3, #0x1f
	stmdb sp!, {r3}
	mov r0, r4
	mov r3, #0x200
	bl sub_1125c
	add sp, sp, #4
loc_109d4:
	mov r0, #3
	strb r0, [r5, #0x25]
	strb r6, [r5, #0x24]
	mov r1, r5
	mov r0, r4
	bl sub_10ee0
	b loc_109f4
loc_109f0:
	bl sub_7ed0
loc_109f4:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_109fc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, r2
	bl sub_7ed0
	mov r0, #5
	ldmdb fp, {fp, sp, pc}

sub_10a18:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, r2
	bl sub_7ed0
	mov r0, #6
	ldmdb fp, {fp, sp, pc}

sub_10a34:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, #0
	ldr r7, [r1, #0x1c]
	teq r7, #0
	beq loc_10a98
	mov r1, r7
	mov r0, r5
	bl sub_11534
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_115d4
	mov r1, r7
	mov r0, r5
	mvn r3, #0xf
	mov r2, #0
	bl sub_11218
	ldr r0, [r4, #0xc]!
	bl sub_84a0
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_10a98:
	mov r8, #1
	ldr r7, [r4, #0x5c]
	teq r7, #0
	beq loc_10b00
	ldr r0, [r4, #8]
	str r6, [r0, #0x18]!
	ldr r0, [r4, #0xc]
	mov r1, r4
	str r6, [r0, #0x18]!
	mov r0, r5
	bl sub_10584
	ldr r0, [r5, #0xd4]
	teq r0, #0
	ldrne r0, [r0, #8]
	teqne r0, #0
	beq loc_10af0
	ldr r0, [r0, #0x10]
	mov r1, r7
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_10b08
loc_10af0:
	mov r1, r7
	mov r0, r5
	bl sub_7ed0
	b loc_10b08
loc_10b00:
	strb r6, [r4, #0x2d]
	strb r6, [r4, #0x2c]
loc_10b08:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_10b10:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	ldr r8, [r2, #0xc]
	ldr r0, [r1]
	movs r0, r0, lsr #16
	mvnne r7, #7
	bne loc_10b84
	ldr r0, [r8]
	sub ip, r0, #0x5300
	teq ip, #0xc
	beq loc_10b68
	sub ip, r0, #0x5300
	teq ip, #0xd
	bne loc_10b80
	mov r1, r4
	mov r0, r5
	bl sub_10c58
	b loc_10b78
loc_10b68:
	ldr r0, [r4, #8]
	ldr r1, [r0, #0xc]!
	mov r0, r5
	bl sub_10bdc
loc_10b78:
	mov r7, r0
	b loc_10b84
loc_10b80:
	mvn r7, #0xb
loc_10b84:
	mov sb, #0
	str sb, [r8, #0xc]
	mov r0, r5
	ldr r1, [r4, #8]
	bl sub_7ed0
	mov r0, #0x81
	teq r7, #0
	str sb, [r4, #8]
	ldreq r1, [r4, #0x18]!
	strbeq r0, [r1, #9]
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	teq r7, #1
	movne r0, #0x82
	strne r7, [r8, #0x10]!
	ldr r1, [r4, #0x18]
	strb r0, [r1, #9]
	ldr r0, [r6, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	ldr pc, [r2]

sub_10bdc:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_1053c
	teq r0, #0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r5, #8]
	str r1, [r0, #4]
	ldr r1, [r5, #4]!
	str r1, [r0, #8]
	ldr r2, [r1, #0x30]
	str r2, [r0, #0xc]
	str r0, [r1, #0x18]!
	ldr r1, [r0, #0xc]
	str r0, [r1, #0x18]!
	ldr r1, [r4, #0x50]
	teq r1, #0
	beq loc_10c4c
loc_10c30:
	ldr r2, [r1, #0x14]
	teq r2, #0
	movne r1, r2
	bne loc_10c30
	str r0, [r1, #0x14]
	teq r1, #0
	bne loc_10c50
loc_10c4c:
	str r0, [r4, #0x50]!
loc_10c50:
	mov r0, #1
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_10c58:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r1, #8]
	ldr r0, [r0, #0xc]
	ldr r1, [r0, #8]!
	mov sb, r1
	mov r0, r4
	bl sub_10e24
	mov r8, #0
	mov r7, #1
	teq r0, #0
	beq loc_10cac
	ldr r1, [r0, #8]
	str r8, [r1, #0x18]!
	ldr r1, [r0, #0xc]
	str r8, [r1, #0x18]!
	mov r1, r0
	b loc_10d10
loc_10cac:
	add r1, r4, #0x40
	mov r0, #0

sub_10cb4:
	ldr r6, [r1], #4
	teq r6, #0
	beq loc_10ccc
	ldr r2, [r6, #4]
	teq r2, sb
	beq loc_10cd8
loc_10ccc:
	add r0, r0, #1
	cmp r0, #4
	blo sub_10cb4
loc_10cd8:
	teq r0, #4
	bne loc_10ce8
loc_10ce0:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_10ce8:
	mov r1, r6
	mov r0, r4
	bl sub_10a34
	teq r0, #1
	bne loc_10d1c
	ldr r0, [r6, #8]
	str r8, [r0, #0x18]!
	ldr r0, [r6, #0xc]
	mov r1, r6
	str r8, [r0, #0x18]!
loc_10d10:
	mov r0, r4
	bl sub_10584
	b loc_10ce0
loc_10d1c:
	strb r7, [r6, #0x2d]
	mov r0, r8
	strb r8, [r6, #0x2c]
	mov r1, #3
	strb r1, [r6, #0x25]
	strb r8, [r6, #0x24]
	str r5, [r6, #0x5c]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_10d3c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	ldr r7, [r2, #0xc]
	ldr sb, [r7, #8]
	cmp sb, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	add sl, r4, sb, lsl #2
	ldr r0, [sl, #0x40]
	teq r0, #0
	mvnne r0, #0xc
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r1, #0
	ldr r0, [r7, #0xc]
	bl sub_7460
	teq r0, #0
	teqne r0, #1
	mvnne r0, #0x20
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, #0x1c
	bl sub_7b9c
	movs r8, r0
	mvneq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, r4
	ldr r1, [r7, #4]
	bl sub_10e24
	movs r6, r0
	bne loc_10dcc
	mov r0, r8
	bl sub_7be0
	mvn r0, #0xd
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_10dcc:
	strb sb, [r6, #1]
	mov r0, sb, lsr #8
	strb r0, [r6]
	mov r2, r8
	mov r1, r5
	mov r0, r4
	mov r3, #0x1c
	str r6, [sl, #0x40]!
	bl sub_7938
	str r8, [r6, #0x30]
	ldr r0, [r7, #0xc]
	str r0, [r6, #0x28]
	ldr r0, [r7, #0x14]!
	strb r0, [r6, #0x27]
	mov r0, r0, asr #8
	strb r0, [r6, #0x26]
	mov r2, r5
	mov r1, r6
	mov r0, r4
	bl sub_106cc
	mov r0, #1
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_10e24:
	mov r3, #0
	ldr r2, [r0, #0x50]
	teq r2, #0
	beq loc_10e68
loc_10e34:
	ldr ip, [r2, #4]
	teq ip, r1
	bne loc_10e58
	teq r3, #0
	ldreq r1, [r2, #0x14]
	streq r1, [r0, #0x50]!
	ldrne r0, [r2, #0x14]
	strne r0, [r3, #0x14]!
	b loc_10e68
loc_10e58:
	mov r3, r2
	ldr r2, [r2, #0x14]
	teq r2, #0
	bne loc_10e34
loc_10e68:
	mov r0, r2
	mov pc, lr

sub_10e70:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r3, [r2, #0xc]
	ldr ip, [r3, #4]
	cmp ip, #4
	mvnhs r0, #0xa
	ldmdbhs fp, {fp, sp, pc}
	add r0, r0, ip, lsl #2
	ldr r0, [r0, #0x40]
	teq r0, #0
	moveq r0, #0
	ldrne r0, [r0, #0x24]
	movne r0, r0, lsr #16
	str r0, [r3, #8]
	mov r0, #0x300
	str r0, [r3]
	mov r3, #0x83
	ldr r0, [r2, #0x18]
	strb r3, [r0, #9]
	ldr r0, [r1, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r2
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	mov r0, #1
	ldmdb fp, {fp, sp, pc}

sub_10ee0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0xc
	ldr r4, [r0, #0xdc]
	teq r4, #0
	beq loc_10f58
	mov r2, #1
	add r2, r2, #0x300
	str r2, [sp]
	ldr r2, [r1]
	mov r2, r2, lsr #16
	str r2, [sp, #4]
	ldr r1, [r1, #0x24]
	mov r1, r1, lsr #16
	str r1, [sp, #8]
	mov r2, sp
	mov r3, #0xc
	mov r1, #0
	bl sub_7b2c
	movs r1, r0
	beq loc_10f58
	mov r0, #0x83
	ldr r2, [r1, #0x18]
	strb r0, [r2, #9]
	ldr r0, [r4, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
loc_10f58:
	ldmdb fp, {r4, fp, sp, pc}

sub_10f5c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	sub sp, sp, #4
	ldr r7, [r1, #0x14]
	ldr r8, [r2, #0xc]
	ldr r0, [r8, #4]
	str r0, [sp]
	mov sb, #1
	ldr r1, [r7, #0x28]
	teq r1, #0
	bne loc_1100c
	ldr r1, [r8, #0x1c]
	bl sub_7460
	teq r0, #0
	bne loc_1100c
	add r0, r7, #0x28
	mov r1, sp
	mov r2, #4
	bl memcpy
	add r0, r5, #0x10
	mov r1, sp
	mov r2, #4
	bl memcpy
	ldr r0, [r8, #8]!
	teq r0, #0
	beq loc_10ff0
	sub r0, r0, #8
	strb r0, [r7, #0x27]
	mov r1, r0, asr #8
	strb r1, [r7, #0x26]
	strb r0, [r5, #0x1d]
	mov r0, r0, asr #8
	strb r0, [r5, #0x1c]
loc_10ff0:
	ldr r0, [r7, #8]!
	ldr r0, [r0, #0x10]
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	ldr pc, [r2]
	b loc_11018
loc_1100c:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
loc_11018:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_11020:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	sub sp, sp, #4
	mov r3, sp
	bl sub_110c0
	teq r0, #0
	teqne r0, #1
	beq loc_11074
	mov r7, #1
	teq r0, #0x13
	bne loc_11078
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldr r3, [sp]
	bl sub_112b0
	b loc_110b8
loc_11074:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_11078:
	ldr r1, [sp]
	teq r1, #8
	mov r3, r0
	bne loc_1109c
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_11218
	b loc_110b8
loc_1109c:
	stmdb sp!, {r3}
	mov r3, r1
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl sub_1125c
	add sp, sp, #4
loc_110b8:
	mov r0, r7
	b loc_11074

sub_110c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r0, #8
	str r0, [r3]
	add r1, r2, #0xc
	ldmia r1, {r0, r1}
	sub sb, r1, r0
	mvn r8, #5
	cmp sb, #4
	blo sub_11170
	ldr r0, [r0]
	str r0, [r3]
	cmp r0, #0xa
	bls sub_11138
	cmp r0, #0x200
	blo sub_11118
	cmp r0, #0x204
	bls sub_1112c

sub_11118:
	teq r0, #0x500
	mvnne r0, #6
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	mov r0, #5
	add r0, r0, #0x200

sub_1112c:
	add r0, r0, #0xf000000b
	sub r0, r0, #0x200
	add r0, r0, #0x10000000

sub_11138:
	ldr r1, lit_11178
	add r0, r1, r0, lsl #3
	add r7, r0, #0xa8
	ldr r1, [r5, #2]
	mov r1, r1, lsr #16
	ldrb r2, [r7]
	mov r0, r6
	bl sub_112f8
	teq r0, #0
	mvneq r0, #7
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldrb r0, [r7, #1]
	cmp r0, sb
	bls sub_1117c

sub_11170:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_11178:
	.rword data_11a94			; relocated

sub_1117c:
	bhs loc_11190
	ldrb r0, [r7, #2]
	tst r0, #1
	mvneq r0, #8
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_11190:
	ldr r0, [r4, #8]
	teq r0, #0
	beq loc_111c4
	ldr r0, [r0, #0x18]
	ldrb r0, [r0, #9]
	teq r0, #0
	mvnne r0, #0x1d
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldrb r0, [r7, #2]
	tst r0, #2
	mvneq r0, #0x1a
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	b loc_111d4
loc_111c4:
	ldrb r0, [r7, #2]
	tst r0, #2
	mvnne r0, #0x1b
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_111d4:
	ldrb r0, [r7, #2]
	tst r0, #4
	beq loc_11200
	mvn r0, #0xf
	ldr r1, [r5, #0x14]
	teq r1, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr r1, [r1, #0x24]
	mov r1, r1, lsr #16
	teq r1, #4
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_11200:
	mov r2, r4
	mov r1, r5
	mov r0, r6
	ldr ip, [r7, #4]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	mov pc, ip

sub_11218:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x8a
	mov r2, #1
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	strb r4, [r0]
	ldr r0, [r5, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_1125c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x83
	mov r2, #0x10
	ldr r6, [fp, #4]
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0x12
	stmia r0, {r2, r4, r6}
	mov r2, #0
	str r2, [r0, #0xc]!
	ldr r0, [r5, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	ldr pc, [r2]

sub_112b0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r1, r2
	mov r4, r3
	mov r3, #0x83
	mov r2, #8
	bl sub_11364
	mov r1, r0
	ldr r0, [r0, #0xc]
	mov r2, #0x13
	stmia r0, {r2, r4}
	ldr r0, [r5, #8]!
	ldr r0, [r0, #0x10]
	ldr r2, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	ldr pc, [r2]

sub_112f8:
	mov r0, #1
	cmp r2, #0x14
	beq loc_1135c
	bgt loc_11324
	teq r2, #4
	teqne r2, #5
	bne loc_11354
	teq r1, r2
	teqne r1, #0
	moveq pc, lr
	b loc_1135c
loc_11324:
	teq r2, #0x15
	beq loc_11344
	teq r2, #0x16
	bne loc_11354
	teq r1, #6
	teqne r1, #0
	moveq pc, lr
	b loc_1135c
loc_11344:
	teq r1, #1
	teqne r1, #2
	movne pc, lr
	b loc_1135c
loc_11354:
	teq r1, r2
	moveq pc, lr
loc_1135c:
	mov r0, #0
	mov pc, lr

sub_11364:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	mov r7, r3
	tst r2, #3
	moveq r8, r5
	bicne r0, r5, #3
	addne r8, r0, #4
	teq r4, #0
	bne loc_113ac
loc_11398:
	mov r1, r8
	mov r0, r6
	bl sub_11430
	mov r4, r0
	b loc_113f8
loc_113ac:
	ldr r0, [r4, #0x18]
	ldrb r1, [r0, #8]
	teq r1, #1
	bne loc_113cc
	ldmia r0, {r0, r1}
	sub r0, r1, r0
	cmp r0, r8
	bhs loc_113dc
loc_113cc:
	mov r1, r4
	mov r0, r6
	bl sub_7ed0
	b loc_11398
loc_113dc:
	ldr r1, [r4, #8]
	teq r1, #0
	beq loc_113f8
	mov r0, r6
	bl sub_7ed0
	mov r0, #0
	str r0, [r4, #8]
loc_113f8:
	ldr r0, [r4, #0x18]
	strb r7, [r0, #9]
	ldr r0, [r4, #0x18]
	ldr r0, [r0, #4]
	sub r0, r0, r5
	str r0, [r4, #0xc]
	ands r1, r0, #3
	subne r0, r0, r1
	strne r0, [r4, #0xc]
	ldr r0, [r4, #0xc]
	add r0, r0, r5
	str r0, [r4, #0x10]
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_11430:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r2, #2
	bl sub_7c44
	movs r5, r0
	bne loc_11480
	add r0, r4, #0xe0
	ldr r1, [r0]
	teq r1, #0
	bne loc_1146c
loc_11460:
	ldr r1, [r0, #4]!
	teq r1, #0
	beq loc_11460
loc_1146c:
	mov r1, #0
	ldr r5, [r0]
	str r1, [r0]
	mov r0, r4
	bl sub_10148
loc_11480:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_11488:
	stmdb sp!, {lr}
	add ip, r2, r3
	ldrb r0, [ip, #0x48]
	teq r0, #1
	ldmiaeq sp!, {pc}
	add r0, r2, r3, lsl #3
	add r0, r0, #0x20
	ldr lr, [r1]
	teq lr, #0
	ldrne lr, [r1, #4]
	addne r3, lr, r3, lsl #3
	strne r2, [r3, #0x24]!
	streq r2, [r1]
	ldr r3, [r1, #4]
	str r3, [r0]
	mov r3, #0
	str r3, [r0, #4]!
	mov r0, #1
	str r2, [r1, #4]!
	strb r0, [ip, #0x48]
	ldmia sp!, {pc}

sub_114dc:
	stmdb sp!, {lr}
	add ip, r2, r3
	ldrb r0, [ip, #0x48]
	teq r0, #0
	ldmiaeq sp!, {pc}
	add r0, r2, r3, lsl #3
	ldr r2, [r0, #0x20]!
	teq r2, #0
	addne r2, r2, r3, lsl #3
	ldrne lr, [r0, #4]
	strne lr, [r2, #0x24]!
	ldreq r2, [r0, #4]
	streq r2, [r1]
	ldr r2, [r0, #4]
	teq r2, #0
	ldr r0, [r0]
	addne r1, r2, r3, lsl #3
	strne r0, [r1, #0x20]!
	streq r0, [r1, #4]!
	mov r0, #0
	strb r0, [ip, #0x48]
	ldmia sp!, {pc}

sub_11534:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r1, #0x58]
	teq r1, #0
	beq loc_11588
loc_11554:
	ldr r0, [r4, #0x5c]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x5d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x5c]
	ldr r0, [r1]
	str r0, [r4, #0x58]
	mov r0, r5
	bl sub_7ed0
	ldr r1, [r4, #0x58]
	teq r1, #0
	bne loc_11554
loc_11588:
	ldr r1, [r4, #0x18]
	teq r1, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r5
	bl sub_7ed0
	mov r0, #0
	str r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_115a8:
	ldr r0, [r1, #0x20]
	str r0, [r2, #0x54]
	teq r0, #0
	ldrne r0, [r1, #0x20]
	strne r2, [r0, #0x50]!
	streq r2, [r1, #0x1c]
	mov r0, #0
	str r2, [r1, #0x20]
	str r1, [r2, #0x14]!
	str r0, [r2, #0x3c]
	mov pc, lr

sub_115d4:
	teq r1, #0
	teqne r2, #0
	moveq pc, lr
	ldr r0, [r2, #0x54]
	teq r0, #0
	ldrne r3, [r2, #0x50]
	strne r3, [r0, #0x50]!
	ldreq r0, [r2, #0x50]
	streq r0, [r1, #0x1c]
	ldr r0, [r2, #0x50]
	teq r0, #0
	ldrne r1, [r2, #0x54]
	strne r1, [r0, #0x54]!
	ldreq r0, [r2, #0x54]
	streq r0, [r1, #0x20]!
	mov r0, #0
	str r0, [r2, #0x14]!
	mov pc, lr
data_1161c:
	.word 0x75647000			; strbvc r7, [r4, #-0]!
data_11620:
	.word 0x00f00000			; rscseq r0, r0, r0
	.rword str_2600				; relocated
	.word 0x00017d00			; andeq r7, r1, r0, lsl #26
	.word 0x00010000			; andeq r0, r1, r0
data_11630:
	.rword sub_1be0				; relocated
	.space 16
	.rword data_11620			; relocated
	.word 0x00000000
data_1164c:
	.rword sub_81a0				; relocated
	.rword sub_1b28				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11620			; relocated
	.word 0x00000000
data_11668:
	.rword data_11630			; relocated
	.rword data_1164c			; relocated
	.word 0x00000000
	.word 0x00000000
data_11678:
	.rword data_11668			; relocated
	.rword data_11a84			; relocated
	.rword data_11bec			; relocated
	.rword data_118f4			; relocated
	.word 0x00000000
data_1168c:
	.rword sub_1ad8				; relocated
	.rword sub_c850				; relocated
	.rword sub_103a8			; relocated
	.rword sub_5608				; relocated
	.word 0x00000000
data_116a0:
	.space 20
data_116b4:
	.word 0x0000007c			; andeq r0, r0, ip, ror r0
	.rword sub_8778				; relocated
	.rword sub_883c				; relocated
	.rword sub_26c8				; relocated
	.rword sub_7c44				; relocated
	.rword sub_7dc0				; relocated
	.rword sub_7e24				; relocated
	.rword sub_7f00				; relocated
	.rword sub_7e90				; relocated
	.rword sub_7ed0				; relocated
	.rword sub_7860				; relocated
	.rword sub_843c				; relocated
	.rword sub_7b50				; relocated
	.rword sub_795c				; relocated
	.rword sub_7b2c				; relocated
	.rword sub_7998				; relocated
	.rword sub_7938				; relocated
	.rword sub_78a8				; relocated
	.rword sub_779c				; relocated
	.rword sub_77f8				; relocated
	.rword sub_8924				; relocated
	.rword sub_8a04				; relocated
	.rword sub_8b84				; relocated
	.rword sub_7f30				; relocated
	.rword sub_8108				; relocated
	.rword sub_81a0				; relocated
	.rword sub_8004				; relocated
	.rword sub_8030				; relocated
	.rword sub_824c				; relocated
	.rword sub_7fa0				; relocated
	.rword sub_84a0				; relocated
data_11730:
	.word 0x00310000			; eorseq r0, r1, r0
	.rword data_745c			; relocated
	.word 0x000055f0
	.word 0x00010000			; andeq r0, r1, r0
data_11740:
	.word 0x00000000
	.rword sub_3b58				; relocated
	.rword sub_3634				; relocated
	.rword sub_3740				; relocated
	.word 0x00000000
	.rword data_11730			; relocated
	.word 0x00000000
data_1175c:
	.rword sub_37c4				; relocated
	.rword sub_397c				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11730			; relocated
	.word 0x00000000
data_11778:
	.rword sub_38b8				; relocated
	.rword sub_3aa8				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11730			; relocated
	.word 0x00000000
data_11794:
	.word 0x00000000
	.rword sub_3bf4				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11730			; relocated
	.word 0x00000000
	.word 0x80402010			; subhi r2, r0, r0, lsl r0
	.word 0x08040201			; stmdaeq r4, {r0, sb}
	.rword sub_32f8				; relocated
	.rword sub_32c4				; relocated
	.rword sub_33a4				; relocated
	.rword sub_61b4				; relocated
	.rword sub_3508				; relocated
	.rword sub_3510				; relocated
	.rword sub_3454				; relocated
data_117d4:
	.word 0x45fa1fe6			; ldrbmi r1, [sl, #0xfe6]!
	.word 0x110007d2
	.word 0x05d403ee			; ldrbeq r0, [r4, #0x3ee]
	.word 0x01fc0128
	.word 0x00440000			; subeq r0, r4, r0
	.word 0x14180000			; ldrne r0, [r8], #-0
	.word 0x00000000
	.word 0x14200000			; strtne r0, [r0], #-0
	.word 0x00000000
	.word 0x14140000			; ldrne r0, [r4], #-0
	.word 0x00000000
	.word 0x14080000			; strne r0, [r8], #-0
	.word 0x00000000
	.word 0x14040000			; strne r0, [r4], #-0
	.word 0x00000000
	.word 0x16040000			; strne r0, [r4], -r0
	.rword sub_28e0				; relocated
	.word 0x001c0100			; andseq r0, ip, r0, lsl #2
	.rword sub_26ec				; relocated
	.word 0x07040000			; streq r0, [r4, -r0]
	.rword sub_285c				; relocated
	.word 0x07140100			; ldreq r0, [r4, -r0, lsl #2]
	.rword sub_29c8				; relocated
	.word 0x16100000			; ldrne r0, [r0], -r0
	.rword sub_4e30				; relocated
	.word 0x02500000			; subseq r0, r0, #0
	.rword sub_5c0c				; relocated
	.word 0x14500000			; ldrbne r0, [r0], #-0
	.word 0x00000000
	.word 0x150c0000			; strne r0, [ip, #-0]
	.rword sub_5db8				; relocated
	.word 0x04140000			; ldreq r0, [r4], #-0
	.rword sub_65ec				; relocated
	.word 0x04140000			; ldreq r0, [r4], #-0
	.rword sub_682c				; relocated
	.word 0x04140000			; ldreq r0, [r4], #-0
	.rword sub_6888				; relocated
	.word 0x040c0000			; streq r0, [ip], #-0
	.rword sub_50f0				; relocated
	.word 0x040c0000			; streq r0, [ip], #-0
	.rword sub_527c				; relocated
	.word 0x07100000			; ldreq r0, [r0, -r0]
	.rword sub_6390				; relocated
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x07200000			; streq r0, [r0, -r0]!
	.rword sub_5ea4				; relocated
data_118a0:
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.space 16
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x00000000
	.word 0x00000054			; andeq r0, r0, r4, asr r0
	.space 24
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x00000000
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x00000000
	.word 0x00000000
	.word 0x00000058			; andeq r0, r0, r8, asr r0
	.word 0x00000002			; andeq r0, r0, r2
data_118f4:
	.rword data_11740			; relocated
	.rword data_1175c			; relocated
	.rword data_11778			; relocated
	.rword data_11794			; relocated
data_11904:
	.word 0x000a0005			; andeq r0, sl, r5
	.word 0x00200020			; eoreq r0, r0, r0, lsr #32
	.word 0x00040000			; andeq r0, r4, r0
	.word 0x80402010			; subhi r2, r0, r0, lsl r0
	.word 0x08040201			; stmdaeq r4, {r0, sb}
data_11918:
	.word 0x00410000			; subeq r0, r1, r0
	.rword data_ef58			; relocated
	.word 0x000055f0
	.word 0x00010000			; andeq r0, r1, r0
data_11928:
	.word 0x00000000
	.rword sub_c3dc				; relocated
	.rword sub_bd70				; relocated
	.rword sub_be90				; relocated
	.word 0x00000000
	.rword data_11918			; relocated
	.word 0x00000000
data_11944:
	.rword sub_c008				; relocated
	.rword sub_c1cc				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11918			; relocated
	.word 0x00000000
data_11960:
	.rword sub_c108				; relocated
	.rword sub_c300				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11918			; relocated
	.word 0x00000000
data_1197c:
	.word 0x00000000
	.rword sub_c4d0				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11918			; relocated
	.word 0x00000000
	.word 0x80402010			; subhi r2, r0, r0, lsl r0
	.word 0x08040201			; stmdaeq r4, {r0, sb}
	.rword sub_cd14				; relocated
	.rword sub_cc9c				; relocated
	.rword sub_cdd0				; relocated
	.rword sub_cf6c				; relocated
	.rword sub_d5a4				; relocated
	.rword sub_cf50				; relocated
	.rword sub_cf6c				; relocated
	.rword sub_ce94				; relocated
	.rword sub_e3b8				; relocated
	.rword sub_e3c0				; relocated
	.rword sub_e3c8				; relocated
	.word 0x17140500			; ldrne r0, [r4, -r0, lsl #10]
	.rword sub_9d34				; relocated
	.word 0x17140100			; ldrne r0, [r4, -r0, lsl #2]
	.rword sub_a37c				; relocated
	.word 0x17080000			; strne r0, [r8, -r0]
	.rword sub_b7f0				; relocated
	.word 0x08080600			; stmdaeq r8, {sb, sl}
	.rword sub_a8dc				; relocated
	.word 0x08080600			; stmdaeq r8, {sb, sl}
	.rword sub_b3e4				; relocated
	.word 0x16040000			; strne r0, [r4], -r0
	.rword sub_9cb8				; relocated
	.word 0x00100100			; andseq r0, r0, r0, lsl #2
	.rword sub_9958				; relocated
	.word 0x08040000
	.rword sub_9bc4				; relocated
	.word 0x14140000			; ldrne r0, [r4], #-0
	.word 0x00000000
	.word 0x14100100			; ldrne r0, [r0], #-0x100
	.word 0x00000000
	.word 0x08040400			; stmdaeq r4, {sl}
	.rword sub_b92c				; relocated
	.word 0x024c0000			; subeq r0, ip, #0
	.rword sub_d320				; relocated
	.word 0x144c0000			; strbne r0, [ip], #-0
	.word 0x00000000
	.word 0x15100000			; ldrne r0, [r0, #-0]
	.rword sub_d440				; relocated
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x14000200			; strne r0, [r0], #-0x200
	.word 0x00000000
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
data_11a5c:
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0x00000000
	.word 0xfffffffe
	.word 0xfffffffe
	.word 0xfffffffe
	.word 0x00000008			; andeq r0, r0, r8
	.word 0xfffffffe
	.word 0xffffffff
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x00000000
data_11a84:
	.rword data_11928			; relocated
	.rword data_11944			; relocated
	.rword data_11960			; relocated
	.rword data_1197c			; relocated
data_11a94:
	.word 0x00420000			; subeq r0, r2, r0
	.rword data_1161c			; relocated
	.word 0x000055f0
	.word 0x00010000			; andeq r0, r1, r0
data_11aa4:
	.word 0x00000000
	.rword sub_10024			; relocated
	.rword sub_fb24				; relocated
	.rword sub_fc38				; relocated
	.word 0x00000000
	.rword data_11a94			; relocated
	.word 0x00000000
data_11ac0:
	.rword sub_fcf0				; relocated
	.rword sub_fea8				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11a94			; relocated
	.word 0x00000000
data_11adc:
	.rword sub_fde4				; relocated
	.rword sub_ff78				; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11a94			; relocated
	.word 0x00000000
data_11af8:
	.word 0x00000000
	.rword sub_100bc			; relocated
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.rword data_11a94			; relocated
	.word 0x00000000
	.word 0x80402010			; subhi r2, r0, r0, lsl r0
	.word 0x08040201			; stmdaeq r4, {r0, sb}
	.rword sub_107d0			; relocated
	.rword sub_10758			; relocated
	.rword sub_10890			; relocated
	.rword sub_10a18			; relocated
	.rword sub_f604				; relocated
	.rword sub_109fc			; relocated
	.rword sub_10a18			; relocated
	.rword sub_10940			; relocated
	.word 0x14140000			; ldrne r0, [r4], #-0
	.word 0x00000000
	.word 0x14140000			; ldrne r0, [r4], #-0
	.word 0x00000000
	.word 0x14080000			; strne r0, [r8], #-0
	.word 0x00000000
	.word 0x14080000			; strne r0, [r8], #-0
	.word 0x00000000
	.word 0x14080000			; strne r0, [r8], #-0
	.word 0x00000000
	.word 0x16040000			; strne r0, [r4], -r0
	.rword sub_f2b4				; relocated
	.word 0x00100100			; andseq r0, r0, r0, lsl #2
	.rword sub_ef80				; relocated
	.word 0x06040400			; streq r0, [r4], -r0, lsl #8
	.rword sub_f240				; relocated
	.word 0x06140700			; ldreq r0, [r4], -r0, lsl #14
	.rword sub_f464				; relocated
	.word 0x06100500			; ldreq r0, [r0], -r0, lsl #10
	.rword sub_f19c				; relocated
	.word 0x14040000			; strne r0, [r4], #-0
	.word 0x00000000
	.word 0x021c0000			; andseq r0, ip, #0
	.rword sub_10d3c			; relocated
	.word 0x150c0000			; strne r0, [ip, #-0]
	.rword sub_10e70			; relocated
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x14000200			; strne r0, [r0], #-0x200
	.word 0x00000000
	.word 0x14000000			; strne r0, [r0], #-0
	.word 0x00000000
	.word 0x06200400			; strteq r0, [r0], -r0, lsl #8
	.rword sub_10f5c			; relocated
data_11bc4:
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0x00000000
	.word 0xfffffffe
	.word 0xfffffffe
	.word 0xfffffffe
	.word 0x00000008			; andeq r0, r0, r8
	.word 0xfffffffe
	.word 0x00000000
	.word 0x00000003			; andeq r0, r0, r3
	.word 0x00000000
data_11bec:
	.rword data_11aa4			; relocated
	.rword data_11ac0			; relocated
	.rword data_11adc			; relocated
	.rword data_11af8			; relocated

sub_11bfc:
	teq r0, #0
	beq loc_11c10
	add r0, r0, pc
	ldr r1, lit_11c14
data_11c0c:
	sub r0, r0, r1
loc_11c10:
	mov pc, lr
lit_11c14:
	.rword data_11c0c			; relocated

sub_11c18:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_11c20:
	.asciz "PMuxCallBack"
	.align 4

sub_11c30:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_11c18
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_11c5c:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_11c70
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_11c70:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_11c78:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_11c84:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14
loc_11c90:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18
loc_11c9c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c
loc_11ca8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_11cb4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_11cc0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_11ccc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c
loc_11cd8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_11ce4:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_11cec:
	.asciz "PConnectionEnd"
	.align 4

sub_11cfc:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_11ce4
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8
loc_11d28:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_11d3c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_11d3c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_11d44:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_11d50:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_11d5c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_11d68:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_11d74:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_11d80:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_11d8c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_11d98:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_11da4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_11db0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_11dbc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_11dc8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

sub_11dd4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_11de0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_11dec:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48

sub_11df8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c

sub_11e04:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x50

sub_11e10:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x54

sub_11e1c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x58

sub_11e28:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x5c

sub_11e34:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x60

sub_11e40:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x64

sub_11e4c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x68

sub_11e58:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x6c

sub_11e64:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x70

sub_11e70:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x74

sub_11e7c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x78

sub_11e88:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x7c

sub_11e94:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x80

sub_11ea0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x84

sub_11eac:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x88

sub_11eb8:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_11ec0:
	.asciz "PStrLinkModule"
	.align 4

sub_11ed0:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_11eb8
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_11efc:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_11f10
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_11f10:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_11f18:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_11f24:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_11f30:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_11f3c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_11f48:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_11f54:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_11f60:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_11f6c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_11f78:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_11f84:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_11f90:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_11f9c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

sub_11fa8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_11fb4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_11fc0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48

sub_11fcc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c

sub_11fd8:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_11fe0:
	.asciz "PStrDriverModule"
	.align 4

sub_11ff4:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_11fd8
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_12020:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_12034
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_12034:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_1203c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_12048:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_12054:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_12060:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_1206c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_12078:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_12084:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_12090:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_1209c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_120a8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_120b4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_120c0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

ConvertTo__5TTimeF9TimeUnits:
	ldr pc, lit_120d0
lit_120d0:
	.word 0x01800f00			; glue 01800f00 -> ConvertTo__5TTimeF9TimeUnits

DisposPtr:
	ldr pc, lit_120d8
lit_120d8:
	.word 0x01801780			; glue 01801780 -> DisposPtr

FreeInstance__FP9TProtocol:
	ldr pc, lit_120e0
lit_120e0:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

GetGlobalTime:
	ldr pc, lit_120e8
lit_120e8:
	.word 0x018010a4			; glue 018010a4 -> GetGlobalTime

GetSize__11CBufferListCFv:
	ldr pc, lit_120f0
lit_120f0:
	.word 0x01801b24			; glue 01801b24 -> GetSize__11CBufferListCFv

Getn__11CBufferListFPUcl:
	ldr pc, lit_120f8
lit_120f8:
	.word 0x01801b0c			; glue 01801b0c -> Getn__11CBufferListFPUcl

NewByName__FPCcT1:
	ldr pc, lit_12100
lit_12100:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

NewNamedPtr:
	ldr pc, lit_12108
lit_12108:
	.word 0x01801808			; glue 01801808 -> NewNamedPtr

Seek__11CBufferListFli:
	ldr pc, lit_12110
lit_12110:
	.word 0x01801d6c			; glue 01801d6c -> Seek__11CBufferListFli

__dl__FPv:
	ldr pc, lit_12118
lit_12118:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__nw__FUi:
	ldr pc, lit_12120
lit_12120:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

__rt_udiv:
	ldr pc, lit_12128
lit_12128:
	.word 0x01800014			; glue 01800014 -> __rt_udiv

free:
	ldr pc, lit_12130
lit_12130:
	.word 0x01801024			; glue 01801024 -> free

memcmp:
	ldr pc, lit_12138
lit_12138:
	.word 0x01800118			; glue 01800118 -> memcmp

memcpy:
	ldr pc, lit_12140
lit_12140:
	.word 0x0180011c			; glue 0180011c -> memcpy

memset:
	ldr pc, lit_12148
lit_12148:
	.word 0x01800124			; glue 01800124 -> memset

rand:
	ldr pc, lit_12150
lit_12150:
	.word 0x01800134			; glue 01800134 -> rand

srand:
	ldr pc, lit_12158
lit_12158:
	.word 0x01800168			; glue 01800168 -> srand
