; " Newton Devices" part 4: protocol (3372 bytes)
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
	.asciz "TLanternCardHandler"
InterfaceName:
	.asciz "TCardHandler"
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

AllocInstanceByName__FPCcT1:
	ldr pc, lit_00c4
lit_00c4:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

AttributeMemBaseAddr__11TCardSocketFv:
	ldr pc, lit_00cc
lit_00cc:
	.word 0x01800e7c			; glue 01800e7c -> AttributeMemBaseAddr__11TCardSocketFv

BlockTillDone__14TUAsyncMessageFPUlN31:
	ldr pc, lit_00d4
lit_00d4:
	.word 0x01800e9c			; glue 01800e9c -> BlockTillDone__14TUAsyncMessageFPUlN31

sub_00d8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	mov r5, r1
	bne loc_0108
	mov r0, #8
	bl __nw__FUi
	movs r4, r0
	bne loc_0108
loc_0100:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_0108:
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
	adr r2, str_018c, #30
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
	b loc_0100
str_018c:
	.asciz "TUPort"
	.align 4

sub_0194:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #4
	mov r0, #0xc
	ldr r1, [fp, #0x14]
	add r4, r0, r1, lsl #2
	mov r1, sp
	ldr r0, [fp, #8]
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	bne loc_01e4
	mov r0, r4
	bl __nw__FUi
	str r0, [sp]
	mov r1, r0
	ldr r0, [fp, #8]
	bl SetUserRefCon__14TUSharedMemMsgFUl
loc_01e4:
	mov r2, r4
	add r1, fp, #0xc
	ldr r0, [sp]
	bl memcpy
	ldmib fp, {ip, lr}
	mov r2, #0
	mov r3, #0
	mov r6, #0
	mov r1, #0
	mov r0, #1
	ldr r5, [sp]
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	mov r2, r4
	stmdb sp!, {r2, r3}
	mov r3, r5
	mov r0, ip
	mov r2, #0
	ldr r1, [lr]
	bl SendGoo__6TUPortFUlT1PvN31UcT1P5TTime
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0238:
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
	mov r0, #0x48
	mov pc, lr

DefaultNew:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	strb r5, [r0, #0x14]
	str r5, [r0, #0x38]
	str r5, [r0, #0x18]
	str r5, [r0, #0x34]
	str r5, [r0, #0x3c]
	str r5, [r0, #0x40]
	str r5, [r0, #0x44]
	mov r0, #0
	bl __ct__14TUAsyncMessageFv
	str r0, [r4, #0x34]
	teq r0, #0
	beq loc_037c
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, #0
	bl __ct__14TUAsyncMessageFv
	str r0, [r4, #0x3c]
	teq r0, #0
	beq loc_037c
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r1, r5
	ldr r0, [r4, #0x3c]
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, #0
	bl __ct__14TUAsyncMessageFv
	str r0, [r4, #0x40]
	teq r0, #0
	beq loc_037c
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r1, r5
	ldr r0, [r4, #0x40]
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, #0
	bl __ct__14TUAsyncMessageFv
	str r0, [r4, #0x44]
	teq r0, #0
	beq loc_037c
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r1, r5
	ldr r0, [r4, #0x44]
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_037c:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

Method13:
	mov r0, #3
	mov pc, lr

Method12:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	teq r1, #0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x18]
	teq r0, #0
	bne loc_03d8
	mov r0, r1
	bl GetCardProduct__11TCardPCMCIACFv
	mov r5, r0
	bl strlen
	add r0, r0, #1
	bl NewPtr
	mov r1, r5
	str r0, [r4, #0x18]
	bl strcpy
loc_03d8:
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, pc}

Method14:
	mov r0, #1
	mov pc, lr

Method15:
	teq r1, #0
	movne pc, lr
	stmdb sp!, {r4, lr}
	add lr, sp, #8
	ldmia lr, {r4, lr}
	ldr ip, [sp, #0x10]
	ldr r0, [r0, #0x20]
	str r0, [r2]
	mov r0, #0
	str r0, [r3]
	str r0, [r4]
	str r0, [lr]
	str r0, [ip]
	ldmia sp!, {r4, pc}

Method18:
	ldrb r0, [r0, #0x24]
	mov pc, lr

Method16:
	str r1, [r0, #0x28]!
	mov pc, lr

Method17:
	strb r1, [r0, #0x24]
	mov pc, lr

Method5:
	mvn r0, #0x104
	sub r0, r0, #0x2800
	mov pc, lr

Method11:
	mov r0, #0
	mov pc, lr

sub_044c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r0, r1
	bl PCMCIAReset__11TCardSocketFv
	mov r7, #0
	ldr r6, lit_0474
	b loc_0484
lit_0474:
	.word 0x00059fd8
loc_0478:
	mov r0, r6
	bl Sleep__FUl
	add r7, r7, #1
loc_0484:
	ldr r0, [r4, #0x2c]
	bl IsReady__11TCardSocketFv
	teq r0, #0
	bne loc_04a0
	ldr r0, [r4, #0x10]
	cmp r0, r7
	bhi loc_0478
loc_04a0:
	mov r0, r5
	bl IsReady__11TCardSocketFv
	teq r0, #0
	mvneq r0, #5
	subeq r0, r0, #0x2900
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	mov r0, r4
	bl sub_05d8
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #4
	mov r6, #0
	strb r6, [r0, #0x14]
	ldr r5, [r0, #0x38]
	teq r5, #0
	beq loc_0504
	mov r0, r5
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r5
	bl __dl__FPv
loc_0504:
	ldr r0, [r4, #0x34]
	teq r0, #0
	movne r1, #1
	blne __dt__14TUAsyncMessageFv
	ldr r0, [r4, #0x3c]
	teq r0, #0
	beq loc_0544
	mov r1, sp
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	blne __dl__FPv
	ldr r0, [r4, #0x3c]
	teq r0, #0
	movne r1, #1
	blne __dt__14TUAsyncMessageFv
loc_0544:
	ldr r0, [r4, #0x44]
	teq r0, #0
	beq loc_0574
	mov r1, sp
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	blne __dl__FPv
	ldr r0, [r4, #0x44]
	teq r0, #0
	movne r1, #1
	blne __dt__14TUAsyncMessageFv
loc_0574:
	ldr r0, [r4, #0x40]
	teq r0, #0
	beq loc_05c0
	mov r3, #0
	stmdb sp!, {r3}
	mov r2, #0
	mov r1, #0
	bl BlockTillDone__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	mov r1, sp
	ldr r0, [r4, #0x40]
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	blne __dl__FPv
	ldr r0, [r4, #0x40]
	teq r0, #0
	movne r1, #1
	blne __dt__14TUAsyncMessageFv
loc_05c0:
	ldr r0, [r4, #0x18]
	teq r0, #0
	beq loc_05d4
	bl DisposPtr
	str r6, [r4, #0x18]!
loc_05d4:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_05d8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x2c]
	bl GetControl__11TCardSocketFv
	orr r1, r0, #0x10
	ldr r0, [r4, #0x2c]
	bl SetControl__11TCardSocketFUl
	ldr r0, [r4, #0x2c]!
	ldmdb fp, {r4, fp, sp, lr}
	b SelectIOInterface__11TCardSocketFv

sub_0608:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, [r0, #0x30]
	mov r1, #0
	bl GetCardConfiguration__11TCardPCMCIAFCUl
	ldr r1, [r0, #0x14c]!
	mov r0, #0x240
	add r0, r0, #0xf4000
	bl __rt_udiv
	add r1, r0, #0x1f4
	mov r0, #0x388
	add r0, r0, #0x1000
	cmp r1, r0
	movlo r1, r0
	mov r0, #0x64
	ldmdb fp, {fp, sp, lr}
	b __rt_udiv

sub_0650:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov ip, r0
	mov r3, #1
	mov r2, #0
	mov r1, #0
	mov r0, #0x4000000
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, #0
	stmdb sp!, {r3}
	ldr r0, [ip, #0x34]
	ldr r1, [r0]
	ldr r0, [ip, #0x38]!
	ldr r0, [r0]
	bl SendForInterrupt__FUlN21PvN31P5TTimeUc
	ldmdb fp, {fp, sp, pc}

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	sub sp, sp, #0x14
	mov r0, sp
	bl __ct__12TUNameServerFv
	mov r1, r5
	mov r0, r4
	bl Method12
	ldr r1, [r4, #0x18]
	adr r0, str_073c, #30
	bl printf
	add r3, sp, #0x10
	stmdb sp!, {r3}
	add r3, r4, #0x1c
	add r0, sp, #4
	ldr r1, [r4, #0x18]
	adr r2, str_0754, #30
	bl Lookup__12TUNameServerFPcT1PUlT3
	add sp, sp, #4
	teq r0, #0
	mvnne r4, #0x104
	subne r4, r4, #0x2800
	bne loc_0728
	ldr r0, [sp, #0x10]
	ldrb r1, [r0]
	mov r2, r1, lsl #24
	ldrb r1, [r0, #1]
	add r2, r2, r1, lsl #16
	ldrb r1, [r0, #2]
	add r1, r2, r1, lsl #8
	ldrb r0, [r0, #3]
	add r0, r1, r0
	str r0, [r4, #0x20]!
	mov r4, #0
loc_0728:
	mov r0, sp
	mov r1, #0
	bl __dt__12TUNameServerFv
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
str_073c:
	.asciz "Recognize CardID: [%s]\r"
str_0754:
	.asciz "Lantern"

Method6:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r7, r3
	mov sb, #0
	mov r1, r2
	bl Method12
	mov r0, #1
	strb r0, [r4, #0x14]
	str r5, [r4, #0x30]
	str r6, [r4, #0x2c]
	mov r0, r4
	bl sub_0608
	str r0, [r4, #0x10]
	mov r0, r4
	bl sub_05d8
	mov r0, #0
	ldr r1, [r4, #0x18]
	bl sub_00d8
	str r0, [r4, #0x38]
	teq r0, #0
	beq loc_0910
	ldr r1, [r0]
	ldr r8, lit_0918
	teq r1, #0
	beq loc_0804
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, #1
	ldr r2, lit_091c
	mov r1, r8
	bl sub_0238
	add sp, sp, #4
	ldr r1, [r4, #0x38]
	ldr r1, [r1]
	teq r1, #0
	beq loc_0804
	teq r0, #0
	beq loc_0884
loc_0804:
	adr r1, str_0920
	adr r0, str_0934
	bl NewByName__FPCcT1
	movs sl, r0
	ldreq sb, lit_0944
	beq loc_0910
	mov r0, sl
	ldr r1, [r4, #0x18]
	ldr r2, [r4, #0x20]
	bl sub_0bcc
	mov sb, r0
	mov r0, sl
	bl sub_0bb0
	teq sb, #0
	bne loc_0910
	mov sl, #0

sub_0844:
	ldr r0, [r4, #0x38]
	teq r0, #0
	ldrne r1, [r4, #0x18]
	blne sub_00d8
	ldr r0, [r4, #0x38]
	ldr r0, [r0]
	teq r0, #0
	bne loc_087c
	mov r0, #0x3ec
	add r0, r0, #0x2cc00
	bl Sleep__FUl
	add sl, sl, #1
	cmp sl, #4
	blo sub_0844
loc_087c:
	cmp sl, #4
	bhs loc_0910
loc_0884:
	ldr r1, [r4, #0x2c]
	mov r0, r4
	bl sub_044c
	movs sb, r0
	bne loc_0910
	bl sub_0c10
	mov r2, r0
	mov r3, r4
	mov r0, r4
	mov r1, #0xa
	bl Method19
	movs sb, r0
	bne loc_0910
	mov r3, r7
	mov r2, r5
	mov r1, r6
	ldr r0, [r4, #0x1c]
	stmdb sp!, {r0, r1, r2, r3}
	ldr r3, [r4, #0x18]
	mov r2, r4
	stmdb sp!, {r2, r3}
	mov r3, #6
	ldr r0, [r4, #0x38]
	ldr r2, lit_0948
	mov r1, r8
	bl sub_0238
	add sp, sp, #0x18
	movs sb, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r0, r4
	mov r3, #0
	mov r2, #0
	mov r1, #0xb
	bl Method19
loc_0910:
	mov r0, sb
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_0918:
	.word 0x6c616e74			; 'lant'
lit_091c:
	.word 0x64696521			; 'die!'
str_0920:
	.asciz "TLanternEventWorld"
	.align 4
str_0934:
	.asciz "TEventWorldAPI"
	.align 4
lit_0944:
	.word 0xffff11b7
lit_0948:
	.word 0x6e657743			; 'newC'

Method10:
	mov r1, #0
	strb r1, [r0, #0x14]
	mov r0, r1
	mov pc, lr

Method7:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r3, #0
	mov r2, #0
	mov r1, #0xb
	bl Method19
	mov r2, #0xa
	ldr r3, [r4, #0x18]
	stmdb sp!, {r2, r3}
	ldr r0, [r4, #0x38]!
	ldr r1, [r4, #8]!
	ldr r3, lit_09a0
	ldr r2, lit_09a4
	bl sub_0194
	ldmdb fp, {r4, fp, sp, pc}
lit_09a0:
	.word 0x64656c43			; 'delC'
lit_09a4:
	.word 0x6c616e74			; 'lant'

Method19:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	mov r6, #0
	mov r7, #0
	teq r1, #9
	bne loc_09ec
	ldr r0, [r4, #0x2c]!
	bl SocketNumber__11TCardSocketFv
	add r0, r0, #0x40000031
	sub r0, r0, #0x38c00
	sub r0, r0, #0xc900000
	add r0, r0, #0x40000000
	str r0, [r5]
	b loc_09fc
loc_09ec:
	teq r1, #0x80
	bne loc_0a04
	ldrb r0, [r4, #0x14]
	strb r0, [r5]
loc_09fc:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0a04:
	cmp r1, #0xa
	beq loc_0ab0
	bgt loc_0a24
	teq r1, #1
	beq loc_0a78
	teq r1, #2
	bne loc_0aec
	b loc_0a9c
loc_0a24:
	teq r1, #0xb
	beq loc_0ac8
	teq r1, #0xc
	bne loc_0aec
	teq r5, #0
	mov r1, #4
	ldr r0, [r4, #0x2c]
	beq loc_0ad8
	bl EnableSocketInterrupt__11TCardSocketF10TSocketInt
	mov r0, r4
	bl sub_05d8
	ldr r0, [r4, #0x2c]
	bl AttributeMemBaseAddr__11TCardSocketFv
	ldr r1, [r4, #0x30]!
	ldr r1, [r1, #0x10]
	add r0, r0, r1
	eor r0, r0, #3
	ldrb r1, [r0]
	orr r1, r1, #0x41
	strb r1, [r0]
	b loc_0af0
loc_0a78:
	ldr r0, [r4, #0x2c]
	bl SocketNumber__11TCardSocketFv
	mov r1, #0
	bl VccOn__FiUc
	ldr r1, [r4, #0x2c]
	mov r0, r4
	bl sub_044c
	movs r6, r0
	beq loc_0af0
loc_0a9c:
	ldr r0, [r4, #0x2c]!
	bl SocketNumber__11TCardSocketFv
	mov r1, #0
	bl VccOff__FiUl
	b loc_0af0
loc_0ab0:
	mov r2, r5
	mov r1, #4
	ldr r0, [r4, #0x2c]!
	bl RegisterSocketInterrupt__11TCardSocketF10TSocketIntPFPvP11TCardSocket_lPv
	mov r6, r0
	b loc_0af0
loc_0ac8:
	mov r1, #4
	ldr r0, [r4, #0x2c]!
	bl DeregisterSocketInterrupt__11TCardSocketF10TSocketInt
	b loc_0af0
loc_0ad8:
	bl DisableSocketInterrupt__11TCardSocketF10TSocketInt
	mov r1, #4
	ldr r0, [r4, #0x2c]!
	bl ClearSocketInterrupt__11TCardSocketF10TSocketInt
	b loc_0af0
loc_0aec:
	ldr r6, lit_0af8
loc_0af0:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_0af8:
	.word 0xffffd8eb

Method8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0
	stmdb sp!, {r3}
	add r1, r0, #0x38
	ldmia r1, {r0, r1}
	ldr r3, lit_0b28
	ldr r2, lit_0b2c
	bl sub_0194
	ldmdb fp, {fp, sp, pc}
lit_0b28:
	.word 0x73757370			; 'susp'
lit_0b2c:
	.word 0x6c616e74			; 'lant'

Method9:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_05d8
	mov r3, #0
	stmdb sp!, {r3}
	ldr r0, [r4, #0x38]!
	ldr r1, [r4, #0xc]!
	ldr r3, lit_0b64
	ldr r2, lit_0b68
	bl sub_0194
	ldmdb fp, {r4, fp, sp, pc}
lit_0b64:
	.word 0x7265736d			; 'resm'
lit_0b68:
	.word 0x6c616e74			; 'lant'

sub_0b6c:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_0b74:
	.asciz "TEventWorldAPI"
	.align 4

sub_0b84:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_0b6c
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_0bb0:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_0bc4
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_0bc4:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_0bcc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

ClearSocketInterrupt__11TCardSocketF10TSocketInt:
	ldr pc, lit_0bdc
lit_0bdc:
	.word 0x01800ef4			; glue 01800ef4 -> ClearSocketInterrupt__11TCardSocketF10TSocketInt

CopyObject__8TUObjectFCUl:
	ldr pc, lit_0be4
lit_0be4:
	.word 0x01800f14			; glue 01800f14 -> CopyObject__8TUObjectFCUl

DeregisterSocketInterrupt__11TCardSocketF10TSocketInt:
	ldr pc, lit_0bec
lit_0bec:
	.word 0x01800f58			; glue 01800f58 -> DeregisterSocketInterrupt__11TCardSocketF10TSocketInt

DisableSocketInterrupt__11TCardSocketF10TSocketInt:
	ldr pc, lit_0bf4
lit_0bf4:
	.word 0x01800f88			; glue 01800f88 -> DisableSocketInterrupt__11TCardSocketF10TSocketInt

DisposPtr:
	ldr pc, lit_0bfc
lit_0bfc:
	.word 0x01801780			; glue 01801780 -> DisposPtr

EnableSocketInterrupt__11TCardSocketF10TSocketInt:
	ldr pc, lit_0c04
lit_0c04:
	.word 0x01800fa4			; glue 01800fa4 -> EnableSocketInterrupt__11TCardSocketF10TSocketInt

FreeInstance__FP9TProtocol:
	ldr pc, lit_0c0c
lit_0c0c:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

sub_0c10:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr

sub_0c18:
	b sub_0650

GetCardConfiguration__11TCardPCMCIAFCUl:
	ldr pc, lit_0c20
lit_0c20:
	.word 0x01801050			; glue 01801050 -> GetCardConfiguration__11TCardPCMCIAFCUl

GetCardProduct__11TCardPCMCIACFv:
	ldr pc, lit_0c28
lit_0c28:
	.word 0x01801060			; glue 01801060 -> GetCardProduct__11TCardPCMCIACFv

GetControl__11TCardSocketFv:
	ldr pc, lit_0c30
lit_0c30:
	.word 0x01801078			; glue 01801078 -> GetControl__11TCardSocketFv

GetUserRefCon__14TUSharedMemMsgFPUl:
	ldr pc, lit_0c38
lit_0c38:
	.word 0x01801120			; glue 01801120 -> GetUserRefCon__14TUSharedMemMsgFPUl

Init__14TUAsyncMessageFUc:
	ldr pc, lit_0c40
lit_0c40:
	.word 0x01801160			; glue 01801160 -> Init__14TUAsyncMessageFUc

IsReady__11TCardSocketFv:
	ldr pc, lit_0c48
lit_0c48:
	.word 0x018011ec			; glue 018011ec -> IsReady__11TCardSocketFv

Lookup__12TUNameServerFPcT1PUlT3:
	ldr pc, lit_0c50
lit_0c50:
	.word 0x01801228			; glue 01801228 -> Lookup__12TUNameServerFPcT1PUlT3

NewByName__FPCcT1:
	ldr pc, lit_0c58
lit_0c58:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

NewPtr:
	ldr pc, lit_0c60
lit_0c60:
	.word 0x0180180c			; glue 0180180c -> NewPtr

PCMCIAReset__11TCardSocketFv:
	ldr pc, lit_0c68
lit_0c68:
	.word 0x018012b8			; glue 018012b8 -> PCMCIAReset__11TCardSocketFv

RegisterSocketInterrupt__11TCardSocketF10TSocketIntPFPvP11TCardSocket_lPv:
	ldr pc, lit_0c70
lit_0c70:
	.word 0x01801350			; glue 01801350 -> RegisterSocketInterrupt__11TCardSocketF10TSocketIntPFPvP11TCardSocket_lPv

SelectIOInterface__11TCardSocketFv:
	ldr pc, lit_0c78
lit_0c78:
	.word 0x018013f0			; glue 018013f0 -> SelectIOInterface__11TCardSocketFv

SendForInterrupt__FUlN21PvN31P5TTimeUc:
	ldr pc, lit_0c80
lit_0c80:
	.word 0x01801410			; glue 01801410 -> SendForInterrupt__FUlN21PvN31P5TTimeUc

SendGoo__6TUPortFUlT1PvN31UcT1P5TTime:
	ldr pc, lit_0c88
lit_0c88:
	.word 0x01801414			; glue 01801414 -> SendGoo__6TUPortFUlT1PvN31UcT1P5TTime

SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime:
	ldr pc, lit_0c90
lit_0c90:
	.word 0x01801418			; glue 01801418 -> SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime

SetControl__11TCardSocketFUl:
	ldr pc, lit_0c98
lit_0c98:
	.word 0x01801464			; glue 01801464 -> SetControl__11TCardSocketFUl

SetUserRefCon__14TUSharedMemMsgFUl:
	ldr pc, lit_0ca0
lit_0ca0:
	.word 0x018014dc			; glue 018014dc -> SetUserRefCon__14TUSharedMemMsgFUl

Sleep__FUl:
	ldr pc, lit_0ca8
lit_0ca8:
	.word 0x018014f8			; glue 018014f8 -> Sleep__FUl

SocketNumber__11TCardSocketFv:
	ldr pc, lit_0cb0
lit_0cb0:
	.word 0x01801508			; glue 01801508 -> SocketNumber__11TCardSocketFv

VccOff__FiUl:
	ldr pc, lit_0cb8
lit_0cb8:
	.word 0x0180159c			; glue 0180159c -> VccOff__FiUl

VccOn__FiUc:
	ldr pc, lit_0cc0
lit_0cc0:
	.word 0x018015a4			; glue 018015a4 -> VccOn__FiUc

__ct__12TUNameServerFv:
	ldr pc, lit_0cc8
lit_0cc8:
	.word 0x01800d54			; glue 01800d54 -> __ct__12TUNameServerFv

__ct__14TUAsyncMessageFv:
	ldr pc, lit_0cd0
lit_0cd0:
	.word 0x01800d78			; glue 01800d78 -> __ct__14TUAsyncMessageFv

__ct__6TUPortFUl:
	ldr pc, lit_0cd8
lit_0cd8:
	.word 0x01800d98			; glue 01800d98 -> __ct__6TUPortFUl

__dl__FPv:
	ldr pc, lit_0ce0
lit_0ce0:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__12TUNameServerFv:
	ldr pc, lit_0ce8
lit_0ce8:
	.word 0x01800dd0			; glue 01800dd0 -> __dt__12TUNameServerFv

__dt__14TUAsyncMessageFv:
	ldr pc, lit_0cf0
lit_0cf0:
	.word 0x01800ddc			; glue 01800ddc -> __dt__14TUAsyncMessageFv

__dt__8TUObjectFv:
	ldr pc, lit_0cf8
lit_0cf8:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_0d00
lit_0d00:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

__rt_udiv:
	ldr pc, lit_0d08
lit_0d08:
	.word 0x01800014			; glue 01800014 -> __rt_udiv

memcpy:
	ldr pc, lit_0d10
lit_0d10:
	.word 0x0180011c			; glue 0180011c -> memcpy

printf:
	ldr pc, lit_0d18
lit_0d18:
	.word 0x01801f4c			; glue 01801f4c -> printf

strcpy:
	ldr pc, lit_0d20
lit_0d20:
	.word 0x01800178			; glue 01800178 -> strcpy

strlen:
	ldr pc, lit_0d28
lit_0d28:
	.word 0x0180017c			; glue 0180017c -> strlen
