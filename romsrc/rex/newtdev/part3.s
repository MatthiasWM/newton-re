; " Newton Devices" part 3: protocol (4604 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	.origin 0x186c		; the part's offset in its package as linked (.rword values add it)

ClassInfoTable:
	.word 0x00000000			; fReserved1
	.word ImplementationName - .		; fNameDelta
	.word InterfaceName - .			; fInterfaceDelta
	.word Signature - .			; fSignatureDelta
	.word BTable - .			; fBTableDelta
	.word Abort__14TUAsyncMessageFv - .	; fEntryProcDelta
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
	.asciz "TClientAPI"
InterfaceName:
	.asciz "TLanternClientAPI"
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
	b Method17				; dispatch slot 17
	b Method18				; dispatch slot 18
	b Method19				; dispatch slot 19
	b Method20				; dispatch slot 20
	b Method21				; dispatch slot 21
	b Method22				; dispatch slot 22
	b Method23				; dispatch slot 23
	b Method24				; dispatch slot 24
	b Method25				; dispatch slot 25

Abort__14TUAsyncMessageFv:
	ldr pc, lit_00d8
lit_00d8:
	.word 0x01800e18			; glue 01800e18 -> Abort__14TUAsyncMessageFv

sub_00dc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r0, r0, #8
	stmia r0, {r1, r2, r3}
	sub r0, r0, #8
	bl GetGlobals
	mov r1, r4
	ldr r2, [r0]
	ldmdb fp, {r4, fp, sp, lr}
	add pc, r2, #0x1c

sub_010c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	mov r5, r1
	bne loc_013c
	mov r0, #8
	bl __nw__FUi
	movs r4, r0
	bne loc_013c
loc_0134:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_013c:
	mov r0, #0
	strb r0, [r4, #4]
	str r0, [r4]
	sub sp, sp, #0x18
	add r0, sp, #8
	bl __ct__12TUNameServerFv
	sub sp, sp, #8
	add r3, sp, #8
	stmdb sp!, {r3}
	add r3, sp, #0x10
	mov r1, r5
	add r0, sp, #0x14
	adr r2, str_01c0, #30
	bl Lookup__12TUNameServerFPcT1PUlT3
	add sp, sp, #4
	teq r0, #0
	movne r0, #0
	strne r0, [sp, #0xc]
	ldr r1, [sp, #0xc]
	mov r0, sp
	bl __ct__6TUPortFUl
	mov r0, r4
	ldr r1, [sp]
	bl CopyObject__8TUObjectFCUl
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	add sp, sp, #8
	add r0, sp, #8
	mov r1, #0
	bl __dt__12TUNameServerFv
	add sp, sp, #0x18
	b loc_0134
str_01c0:
	.asciz "TUPort"
	.align 4

sub_01c8:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #4
	mov r1, #0xc
	ldr r0, [fp, #0x10]
	add r4, r1, r0, lsl #2
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov lr, #0
	mov r5, #0
	mov r3, #0
	ldr ip, [fp, #4]
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, lr
	mov r0, r4
	stmdb sp!, {r0, r1, r2, r3}
	add r3, fp, #8
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, fp, sp, pc}

Sizeof:
	mov r0, #0x4c
	mov pc, lr

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r0, #0x40]
	strb r1, [r0, #0x34]
	str r1, [r0, #0x38]
	str r1, [r0, #0x30]
	str r1, [r0, #0x20]
	strb r1, [r0, #0x10]
	mov pc, lr

Method11:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldrb r0, [r0, #0x34]
	teq r0, #0
	moveq r0, #0x8a
	subeq r0, r0, #0xf000
	ldmdbeq fp, {r4, fp, sp, pc}
	teq r1, #0
	bne loc_02d8
	ldr r0, [r4, #0x24]
	teq r0, #0
	beq loc_02b8
	teq r0, #1
	beq loc_02cc
	teq r0, #2
	bne loc_02cc
	bl GetGlobals
	ldr r0, [r0, #0x18]
	b loc_02c4
loc_02b8:
	bl GetGlobals
	bl GetMyPort__9TAppWorldFv
	ldr r0, [r0]
loc_02c4:
	str r0, [r4, #0x1c]!
	b loc_02dc
loc_02cc:
	ldr r0, lit_02d4
	ldmdb fp, {r4, fp, sp, pc}
lit_02d4:
	.word 0xffff1087
loc_02d8:
	str r1, [r4, #0x1c]!
loc_02dc:
	mov r0, #0
	ldmdb fp, {r4, fp, sp, pc}

Method10:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	ldrb r0, [r0, #0x34]
	teq r0, #0
	beq loc_0328
	mov r3, r4
	stmdb sp!, {r3}
	mov r3, #1
	ldr r0, [r4, #0x14]
	ldr r2, lit_03a0
	ldr r1, lit_03a4
	bl sub_01c8
	add sp, sp, #4
	mov r6, r0
loc_0328:
	ldr r0, [r4, #0x24]
	teq r0, #0
	teqne r0, #2
	ldrne r0, lit_03a8
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	sub sp, sp, #0x1c
	mov r0, sp
	ldr r1, [r4, #0x3c]
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r5, r0
	beq loc_038c
loc_035c:
	mov r1, r5
	ldr r0, [r4, #0x3c]
	bl Remove__5CListFPv
	movs r0, r5
	beq loc_037c
	mov r1, #1
	mov lr, pc
	ldr pc, [r0]
loc_037c:
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r5, r0
	bne loc_035c
loc_038c:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_03a0:
	.word 0x646e6962			; 'dnib'
lit_03a4:
	.word 0x6c616e74			; 'lant'
lit_03a8:
	.word 0xffff1087

Method12:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr sl, [fp, #4]
	ldr r0, [r0, #0x24]
	ldr r4, lit_0464
	teq r0, #0
	beq loc_0470
	teq r0, #1
	teqne r0, #2
	ldrne r0, lit_0468
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, #0x1c
	bl __nw__FUi
	mov sb, r0
	mov r3, r6
	mov r2, r7
	mov r1, r8
	ldr r0, [r5, #0x24]
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, #1
	mov r2, r4
	stmdb sp!, {r2, r3}
	mov r1, sb
	mov r0, r5
	ldr r3, lit_046c
	mov r2, #0x1c
	bl Method18
	add sp, sp, #0x18
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	ldr r0, [r5, #0x24]
	teq r0, #2
	bne loc_04ec
	mov r3, r6
	mov r2, r8
	mov r1, r7
	mov r0, sb
	bl sub_00dc
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	b loc_04f8
lit_0464:
	.word 0x63657668			; 'cevh'
lit_0468:
	.word 0xffff1087
lit_046c:
	.word 0x6c616e74			; 'lant'
loc_0470:
	mov r0, #0x20
	bl __nw__FUi
	mov sb, r0
	mov r3, #0
	mov r2, #1
	mov r1, r4
	stmdb sp!, {r1, r2, r3}
	mov r1, r0
	mov r0, r5
	ldr r3, lit_046c
	mov r2, #0x20
	bl Method18
	add sp, sp, #0xc
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	str r6, [sb, #0x14]
	ldr r0, [r5, #0x28]
	mov r2, r8
	mov r1, r7
	add sb, sb, #0x18
	stmia sb, {r0, sl}
	sub sb, sb, #0x18
	mov r0, sb
	bl Init__14TAEventHandlerFUlT1
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_04d8:
	mov r2, sb
	ldr r0, [r5, #0x3c]!
	ldr r1, [r0]
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	b InsertAt__5CListFlPv
loc_04ec:
	str r6, [sb, #0x10]
	str r7, [sb, #0xc]
	str r8, [sb, #8]
loc_04f8:
	ldr r0, [r5, #0x28]
	add sb, sb, #0x14
	stmia sb, {r0, sl}
	sub sb, sb, #0x14
	b loc_04d8

Method14:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	ldmia r1, {r6, r7}
	sub sp, sp, #0x1c
	ldr r1, [r0, #0x3c]!
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	teq r0, #0
	beq loc_0594
loc_0544:
	ldr r1, [r0, #8]
	teq r1, r6
	ldreq r1, [r0, #0xc]
	teqeq r1, r7
	bne loc_0584
	mov r2, r4
	mov r1, r5
	ldr r3, [r0]
	mov lr, pc
	add pc, r3, #4
	mov r4, #0
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0584:
	mov r0, sp
	bl NextItem__13CListIteratorFv
	teq r0, #0
	bne loc_0544
loc_0594:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, #0x1b4
	sub r0, r0, #0xf000
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

Method13:
	ldrb r1, [r0, #0x34]
	teq r1, #0
	moveq r0, #0x8a
	subeq r0, r0, #0xf000
	moveq pc, lr
	ldr r1, [r0, #0x24]
	teq r1, #0
	ldreq r1, [r0, #0x1c]
	beq loc_0610
	teq r1, #1
	beq loc_05e4
	teq r1, #2
	ldreq r1, [r0, #0x1c]
	beq loc_0678
loc_05e4:
	mov r0, #0x8c
	sub r0, r0, #0xf000
	mov pc, lr

Method15:
	ldr r1, [r0, #0x24]
	teq r1, #0
	beq loc_0668
	teq r1, #1
	moveq pc, lr
	teq r1, #2
	beq loc_0684
	mov pc, lr
loc_0610:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0x134
	mov r0, sp
	bl __ct__14TAppWorldStateFv
	mov r0, sp
	mov r1, r5
	str sp, [r4, #0x38]
	bl Init__14TAppWorldStateFUl
	ldr r0, [r4, #0x38]
	bl NestedEventLoop__14TAppWorldStateFv
	mov r0, #0
	str r0, [r4, #0x38]!
	mov r4, #0
	mov r0, sp
	mov r1, #0
	bl sub_0e38
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_0668:
	ldr r0, [r0, #0x38]
	teq r0, #0
	bne TerminateNestedEventLoop__14TAppWorldStateFv
	mov pc, lr
loc_0678:
	mov r0, #0x8c
	sub r0, r0, #0xf000
	mov pc, lr
loc_0684:
	mov pc, lr

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldrb r0, [r0, #0x34]
	teq r0, #0
	movne r0, r4
	blne Method10
	mov r6, #0
	ldr r1, [r4, #0x40]
	teq r1, #0
	beq loc_0788
	ldr r0, [r1]
	teq r0, #0
	beq loc_0770
	sub sp, sp, #0x20
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r5, r0
	beq loc_0748
loc_06e0:
	mov r1, r5
	ldr r0, [r4, #0x40]
	bl Remove__5CListFPv
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r5
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #1
	moveq r0, r5
	bleq Abort__14TUAsyncMessageFv
	add r1, sp, #0x1c
	mov r0, r5
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp, #0x1c]
	teq r0, #0
	blne __dl__FPv
	movs r0, r5
	movne r1, #1
	blne __dt__14TUAsyncMessageFv
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r5, r0
	bne loc_06e0
loc_0748:
	ldr r0, [r4, #0x40]
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
	mov r0, sp
	mov r1, #0
	str r6, [r4, #0x40]
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x20
	b loc_0788
loc_0770:
	teq r1, #0
	beq loc_0788
	mov r0, r1
	mov r1, #1
	bl __dt__5CListFv
	str r6, [r4, #0x40]
loc_0788:
	ldr r5, [r4, #0x14]
	teq r5, #0
	beq loc_07a8
	mov r0, r5
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r5
	bl __dl__FPv
loc_07a8:
	str r6, [r4, #0x14]
	ldr r0, [r4, #0x20]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	bl DisposPtr
	str r6, [r4, #0x20]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method16:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, #0xc
	ldr r0, [fp, #0x14]
	add r2, r5, r0, lsl #2
	add r1, fp, r5
	ldr r0, [fp, #4]
	bl sub_0cd8
	movs r4, r0
	moveq r0, #0x88
	subeq r0, r0, #0xf000
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	sub sp, sp, #4
	mov r1, sp
	mov r0, r4
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [fp, #4]
	ldr r6, [r0, #0x14]!
	ldr ip, [sp]
	ldr r0, [fp, #0x14]
	add lr, r5, r0, lsl #2
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov r3, #0
	mov r5, #0
	mov r7, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r7
	mov r2, #1
	mov r1, r5
	mov r0, lr
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, ip
	stmdb sp!, {r3}
	mov r0, r6
	mov r3, #0
	ldr r1, [r4], #8
	ldr r2, [r4]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

Method17:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #4
	ldr r0, [fp, #4]
	ldr ip, [r0, #0x14]!
	mov r1, #0xc
	ldr r0, [fp, #0x10]
	add r4, r1, r0, lsl #2
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov lr, #0
	mov r5, #0
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, lr
	mov r0, r4
	stmdb sp!, {r0, r1, r2, r3}
	add r3, fp, #8
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, fp, sp, pc}

Method18:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #4
	ldr r0, [fp, #4]
	ldr ip, [r0, #0x14]!
	mov r0, #0xc
	ldr r1, [fp, #0x18]
	add lr, r0, r1, lsl #2
	mov r2, #0
	mov r4, #0
	mov r5, #0
	mov r3, #0
	add r1, fp, #8
	ldmia r1, {r0, r1}
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, r4
	mov r0, lr
	stmdb sp!, {r0, r1, r2, r3}
	add r3, fp, #0x10
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	ldmdb fp, {r4, r5, fp, sp, pc}

Method19:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, #0xc
	ldr r0, [fp, #0x14]
	add r2, r5, r0, lsl #2
	add r1, fp, r5
	ldr r0, [fp, #4]
	bl sub_0cd8
	movs r4, r0
	moveq r0, #0x88
	subeq r0, r0, #0xf000
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	sub sp, sp, #0xc
	add r1, sp, #8
	mov r0, r4
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	mov r0, sp
	ldr r1, [fp, #8]
	bl __ct__6TUPortFUl
	ldr ip, [sp, #8]
	ldr r0, [fp, #0x14]
	add r5, r5, r0, lsl #2
	mov r2, #0
	mov r3, #0
	mov lr, #0
	mov r1, #0
	mov r0, #1
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, lr
	mov r2, r5
	stmdb sp!, {r2, r3}
	mov r3, ip
	add r0, sp, #0x18
	mov r2, #0
	ldr r1, [r4]
	bl SendGoo__6TUPortFUlT1PvN31UcT1P5TTime
	add sp, sp, #0x18
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

Method20:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, #0xc
	ldr r0, [fp, #0x18]
	add r2, r5, r0, lsl #2
	add r1, fp, #0x10
	ldr r0, [fp, #4]
	bl sub_0cd8
	movs r4, r0
	moveq r0, #0x88
	subeq r0, r0, #0xf000
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	sub sp, sp, #0xc
	add r1, sp, #8
	mov r0, r4
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	mov r0, sp
	ldr r1, [fp, #8]
	bl __ct__6TUPortFUl
	ldr ip, [sp, #8]
	ldr r0, [fp, #0x18]
	add lr, r5, r0, lsl #2
	mov r2, #0
	mov r5, #0
	mov r1, #0
	mov r0, #1
	ldr r3, [fp, #0xc]
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r2, lr
	stmdb sp!, {r2, r3}
	mov r3, ip
	add r0, sp, #0x18
	mov r2, #0
	ldr r1, [r4]
	bl SendGoo__6TUPortFUlT1PvN31UcT1P5TTime
	add sp, sp, #0x18
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

Method21:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, #0xc
	ldr r0, [fp, #0x18]
	add r2, r5, r0, lsl #2
	add r1, fp, #0x10
	ldr r0, [fp, #4]
	bl sub_0cd8
	movs r4, r0
	moveq r0, #0x88
	subeq r0, r0, #0xf000
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	sub sp, sp, #0xc
	add r1, sp, #8
	mov r0, r4
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	mov r0, sp
	ldr r1, [fp, #8]
	bl __ct__6TUPortFUl
	ldr ip, [sp, #8]
	ldr r0, [fp, #0x18]
	add r5, r5, r0, lsl #2
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov r3, #0
	mov lr, #0
	mov r6, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	mov r2, #1
	mov r1, lr
	mov r0, r5
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, ip
	stmdb sp!, {r3}
	add r0, sp, #0x24
	mov r3, #0
	ldr r1, [r4], #8
	ldr r2, [r4]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method22:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #0xc
	mov r0, sp
	ldr r1, [fp, #8]
	bl __ct__6TUPortFUl
	mov r0, #0xc
	ldr r1, [fp, #0x14]
	add ip, r0, r1, lsl #2
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov lr, #0
	mov r4, #0
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r4
	mov r1, lr
	mov r0, ip
	stmdb sp!, {r0, r1, r2, r3}
	add r3, fp, #0xc
	stmdb sp!, {r3}
	add r3, sp, #0x2c
	add r0, sp, #0x24
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

Method23:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #0xc
	mov r0, sp
	ldr r1, [fp, #8]
	bl __ct__6TUPortFUl
	mov r0, #0xc
	ldr r1, [fp, #0x1c]
	add ip, r0, r1, lsl #2
	mov r2, #0
	mov lr, #0
	mov r4, #0
	mov r3, #0
	add r1, fp, #0xc
	ldmia r1, {r0, r1}
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r4
	mov r1, lr
	mov r0, ip
	stmdb sp!, {r0, r1, r2, r3}
	add r3, fp, #0x14
	stmdb sp!, {r3}
	add r3, sp, #0x2c
	add r0, sp, #0x24
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

Method24:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #0xc]
	mov r2, r0, lsl #2
	add r1, fp, #0x10
	ldr r0, [fp, #4]
	ldr r0, [r0, #0x48]
	ldr r3, [fp, #8]
	bl ReplyRPC__10TUMsgTokenFPvUll
	ldmdb fp, {fp, sp, pc}

sub_0cd8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0x1c
	ldr r1, [r0, #0x40]
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r7, r0
	mov sb, #0
	beq loc_0d84
loc_0d14:
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r7
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #0
	beq loc_0d4c
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r7, r0
	bne loc_0d14
	b loc_0d84
loc_0d4c:
	teq r7, #0
	beq loc_0d84
	mov r1, r7
	ldr r0, [r4, #0x40]
	bl Remove__5CListFPv
	sub sp, sp, #4
	mov r1, sp
	mov r0, r7
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	blne __dl__FPv
	add sp, sp, #4
	b loc_0dd0
loc_0d84:
	mov r0, #0
	bl __ct__14TUAsyncMessageFv
	movs r7, r0
	bne loc_0dac
loc_0d94:
	mov r4, #0
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r4
	b loc_0e2c
loc_0dac:
	mov r0, r7
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, r7
	mov r1, #0
	bl SetCollectorPort__14TUAsyncMessageFUl
	ldr r0, [r4, #0x44]
	add r0, r0, #1
	str r0, [r4, #0x44]
loc_0dd0:
	mov r0, r5
	bl __nw__FUi
	movs r8, r0
	bne loc_0df0
	mov r1, sb
	mov r0, r7
	bl SetUserRefCon__14TUSharedMemMsgFUl
	b loc_0d94
loc_0df0:
	mov r2, r5
	mov r1, r6
	mov r0, r8
	bl memcpy
	mov r1, r8
	mov r0, r7
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r2, r7
	ldr r0, [r4, #0x40]!
	ldr r1, [r0]
	bl InsertAt__5CListFlPv
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r7
loc_0e2c:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

Method25:
	ldr r0, [r0, #0x14]
	mov pc, lr

sub_0e38:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r6, [r0, #4]
	teq r6, #0
	beq loc_0e6c
	mov r0, r6
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r6
	bl __dl__FPv
loc_0e6c:
	mov r0, #0
	str r0, [r4, #4]
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method4:
	str r1, [r0, #0x18]!
	mov pc, lr

Method5:
	ldr r0, [r0, #0x18]
	mov pc, lr

Method7:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	ldr r8, [fp, #4]
	sub sp, sp, #0x18
	add r0, sp, #8
	bl __ct__12TUNameServerFv
	mov r3, sp
	stmdb sp!, {r3}
	add r3, sp, #8
	mov r2, r8
	mov r1, r4
	add r0, sp, #0xc
	bl Lookup__12TUNameServerFPcT1PUlT3
	add sp, sp, #4
	teq r0, #0
	bne loc_0f00
	mov r2, r5
	mov r1, r6
	mov r0, r7
	ldr r3, [sp, #4]
	bl Method6
loc_0f00:
	mov r4, r0
	add r0, sp, #8
	mov r1, #0
	bl __dt__12TUNameServerFv
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

Method6:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r4, #0x40]
	teq r0, #0
	beq loc_100c
	mov r0, #0
	bl __ct__5CListFv
	mov r8, #0
	str r0, [r4, #0x3c]
	teq r0, #0
	beq loc_0ff8
	mov r0, r5
	bl strlen
	add r0, r0, #1
	bl NewPtr
	str r0, [r4, #0x20]
	teq r0, #0
	beq loc_0fe4
	mov r1, r5
	bl strcpy
	mov r1, r5
	mov r0, #0
	str r6, [r4, #0x28]
	str r7, [r4, #0x24]
	bl sub_010c
	str r0, [r4, #0x14]
	teq r0, #0
	beq loc_0fdc
	mov r3, r4
	stmdb sp!, {r3}
	mov r3, #1
	ldr r2, lit_0fd0
	ldr r1, lit_0fd4
	bl sub_01c8
	add sp, sp, #4
	add ip, r0, #0x2700
	cmn ip, #0x1f
	ldreq r0, lit_0fd8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_0fd0:
	.word 0x696e6974			; 'init'
lit_0fd4:
	.word 0x6c616e74			; 'lant'
lit_0fd8:
	.word 0xffff11b7
loc_0fdc:
	ldr r0, [r4, #0x20]
	bl DisposPtr
loc_0fe4:
	ldr r0, [r4, #0x3c]
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
	str r8, [r4, #0x3c]
loc_0ff8:
	ldr r0, [r4, #0x40]
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
	str r8, [r4, #0x40]!
loc_100c:
	mov r0, #0x89
	sub r0, r0, #0xf000
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

Method8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x24]
	teq r0, #0
	beq loc_1054
	teq r0, #1
	beq loc_1070
	teq r0, #2
	bne loc_1070
	bl GetGlobals
	ldr r2, [r0, #0x18]!
	b loc_1060
loc_1054:
	bl GetGlobals
	bl GetMyPort__9TAppWorldFv
	ldr r2, [r0]
loc_1060:
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b Method9
loc_1070:
	ldr r0, lit_1078
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_1078:
	.word 0xffff1087

Method9:
	ldrb r3, [r0, #0x34]
	teq r3, #0
	ldrne r0, lit_10c0
	movne pc, lr
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	str r1, [r0, #0x2c]
	str r2, [r0, #0x1c]
	mov r3, r0
	stmdb sp!, {r3}
	ldr r0, [r0, #0x14]
	mov r3, #1
	ldr r2, lit_10c4
	ldr r1, lit_10c8
	bl sub_01c8
	ldmdb fp, {fp, sp, pc}
lit_10c0:
	.word 0xffff108b
lit_10c4:
	.word 0x62696e64			; 'bind'
lit_10c8:
	.word 0x6c616e74			; 'lant'

CopyObject__8TUObjectFCUl:
	ldr pc, lit_10d0
lit_10d0:
	.word 0x01800f14			; glue 01800f14 -> CopyObject__8TUObjectFCUl

DisposPtr:
	ldr pc, lit_10d8
lit_10d8:
	.word 0x01801780			; glue 01801780 -> DisposPtr

FirstItem__13CListIteratorFv:
	ldr pc, lit_10e0
lit_10e0:
	.word 0x01801ac4			; glue 01801ac4 -> FirstItem__13CListIteratorFv

GetGlobals:
	ldr pc, lit_10e8
lit_10e8:
	.word 0x018010a0			; glue 018010a0 -> GetGlobals

GetMyPort__9TAppWorldFv:
	ldr pc, lit_10f0
lit_10f0:
	.word 0x01801b08			; glue 01801b08 -> GetMyPort__9TAppWorldFv

GetResult__14TUAsyncMessageFPUlN31:
	ldr pc, lit_10f8
lit_10f8:
	.word 0x018010f8			; glue 018010f8 -> GetResult__14TUAsyncMessageFPUlN31

GetUserRefCon__14TUSharedMemMsgFPUl:
	ldr pc, lit_1100
lit_1100:
	.word 0x01801120			; glue 01801120 -> GetUserRefCon__14TUSharedMemMsgFPUl

Init__14TAEventHandlerFUlT1:
	ldr pc, lit_1108
lit_1108:
	.word 0x01801b7c			; glue 01801b7c -> Init__14TAEventHandlerFUlT1

Init__14TAppWorldStateFUl:
	ldr pc, lit_1110
lit_1110:
	.word 0x01801b80			; glue 01801b80 -> Init__14TAppWorldStateFUl

Init__14TUAsyncMessageFUc:
	ldr pc, lit_1118
lit_1118:
	.word 0x01801160			; glue 01801160 -> Init__14TUAsyncMessageFUc

InsertAt__5CListFlPv:
	ldr pc, lit_1120
lit_1120:
	.word 0x01801bb8			; glue 01801bb8 -> InsertAt__5CListFlPv

Lookup__12TUNameServerFPcT1PUlT3:
	ldr pc, lit_1128
lit_1128:
	.word 0x01801228			; glue 01801228 -> Lookup__12TUNameServerFPcT1PUlT3

NestedEventLoop__14TAppWorldStateFv:
	ldr pc, lit_1130
lit_1130:
	.word 0x01801ef8			; glue 01801ef8 -> NestedEventLoop__14TAppWorldStateFv

NewPtr:
	ldr pc, lit_1138
lit_1138:
	.word 0x0180180c			; glue 0180180c -> NewPtr

NextItem__13CListIteratorFv:
	ldr pc, lit_1140
lit_1140:
	.word 0x01801c6c			; glue 01801c6c -> NextItem__13CListIteratorFv

Remove__5CListFPv:
	ldr pc, lit_1148
lit_1148:
	.word 0x01801cf4			; glue 01801cf4 -> Remove__5CListFPv

ReplyRPC__10TUMsgTokenFPvUll:
	ldr pc, lit_1150
lit_1150:
	.word 0x018013b8			; glue 018013b8 -> ReplyRPC__10TUMsgTokenFPvUll

SendGoo__6TUPortFUlT1PvN31UcT1P5TTime:
	ldr pc, lit_1158
lit_1158:
	.word 0x01801414			; glue 01801414 -> SendGoo__6TUPortFUlT1PvN31UcT1P5TTime

SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime:
	ldr pc, lit_1160
lit_1160:
	.word 0x01801418			; glue 01801418 -> SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime

SetCollectorPort__14TUAsyncMessageFUl:
	ldr pc, lit_1168
lit_1168:
	.word 0x0180145c			; glue 0180145c -> SetCollectorPort__14TUAsyncMessageFUl

SetUserRefCon__14TUSharedMemMsgFUl:
	ldr pc, lit_1170
lit_1170:
	.word 0x018014dc			; glue 018014dc -> SetUserRefCon__14TUSharedMemMsgFUl

TerminateNestedEventLoop__14TAppWorldStateFv:
	ldr pc, lit_1178
lit_1178:
	.word 0x01801efc			; glue 01801efc -> TerminateNestedEventLoop__14TAppWorldStateFv

__ct__12TUNameServerFv:
	ldr pc, lit_1180
lit_1180:
	.word 0x01800d54			; glue 01800d54 -> __ct__12TUNameServerFv

__ct__13CListIteratorFP13CDynamicArray:
	ldr pc, lit_1188
lit_1188:
	.word 0x018018b0			; glue 018018b0 -> __ct__13CListIteratorFP13CDynamicArray

__ct__14TAppWorldStateFv:
	ldr pc, lit_1190
lit_1190:
	.word 0x018018d8			; glue 018018d8 -> __ct__14TAppWorldStateFv

__ct__14TUAsyncMessageFv:
	ldr pc, lit_1198
lit_1198:
	.word 0x01800d78			; glue 01800d78 -> __ct__14TUAsyncMessageFv

__ct__5CListFv:
	ldr pc, lit_11a0
lit_11a0:
	.word 0x018018f8			; glue 018018f8 -> __ct__5CListFv

__ct__6TUPortFUl:
	ldr pc, lit_11a8
lit_11a8:
	.word 0x01800d98			; glue 01800d98 -> __ct__6TUPortFUl

__dl__FPv:
	ldr pc, lit_11b0
lit_11b0:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__12TUNameServerFv:
	ldr pc, lit_11b8
lit_11b8:
	.word 0x01800dd0			; glue 01800dd0 -> __dt__12TUNameServerFv

__dt__14CArrayIteratorFv:
	ldr pc, lit_11c0
lit_11c0:
	.word 0x01801934			; glue 01801934 -> __dt__14CArrayIteratorFv

__dt__14TUAsyncMessageFv:
	ldr pc, lit_11c8
lit_11c8:
	.word 0x01800ddc			; glue 01800ddc -> __dt__14TUAsyncMessageFv

__dt__5CListFv:
	ldr pc, lit_11d0
lit_11d0:
	.word 0x01801950			; glue 01801950 -> __dt__5CListFv

__dt__8TUObjectFv:
	ldr pc, lit_11d8
lit_11d8:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_11e0
lit_11e0:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

memcpy:
	ldr pc, lit_11e8
lit_11e8:
	.word 0x0180011c			; glue 0180011c -> memcpy

strcpy:
	ldr pc, lit_11f0
lit_11f0:
	.word 0x01800178			; glue 01800178 -> strcpy

strlen:
	ldr pc, lit_11f8
lit_11f8:
	.word 0x0180017c			; glue 0180017c -> strlen
