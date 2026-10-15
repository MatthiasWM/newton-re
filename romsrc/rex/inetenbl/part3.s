; "Newton Internet Enabler" part 3: protocol (13184 bytes)
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
	.asciz "PInetToolCCE"
InterfaceName:
	.asciz "PConnectionEnd"
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
	b Method26				; dispatch slot 26
	b Method27				; dispatch slot 27
	b Method28				; dispatch slot 28
	b Method29				; dispatch slot 29
	b Method30				; dispatch slot 30
	b Method31				; dispatch slot 31
	b Method32				; dispatch slot 32
	b Method33				; dispatch slot 33
	b Method34				; dispatch slot 34

AllocInstanceByName__FPCcT1:
	ldr pc, lit_00fc
lit_00fc:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

Sizeof:
	mov r0, #0x14
	mov pc, lr

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x10]
	mov pc, lr

Method11:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cac

Method12:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cb8

Method13:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cc4

Method14:
	mov pc, lr

Method15:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	b loc_2cd0

Method16:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r2, #0
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cdc

Method17:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r2, #0
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cdc

Method18:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2ce8

Method19:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r3, #0
	mov r2, #0
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cf4

Method20:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r3, #0
	mov r2, #0
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cf4

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	mov r0, r4
	mov r1, #0
	bl sub_2388
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x18]
	teq r0, #0
	movne r1, #1
	blne __dt__12TOptionArrayFv
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x14]!
	mov r0, r4
	bl sub_2198
	movs r5, r0
	beq loc_0270
	mov r1, r5
	mov r0, r4
	bl sub_28e0
	mov r1, r5
	mov r0, r4
	bl sub_1c48
	mov r1, r5
	mov r0, r4
	bl sub_1c04
	mov r1, r5
	mov r0, r4
	bl sub_1bbc
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x14]!
	mov r0, r4
	bl sub_1b88
loc_0270:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #4]
	mov r5, #0
	teq r0, #0
	beq loc_0290
	bl sub_2c54
	ldr r0, [r4, #0x10]
	str r5, [r0, #4]!
loc_0290:
	ldr r0, [r4, #0x10]
	bl __dl__FPv
	str r5, [r4, #0x10]!
	ldmdb fp, {r4, r5, fp, sp, pc}

Method21:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r3, #0
	mov r2, #0
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2cf4

Method22:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2d00

Method23:
	mov pc, lr

Method24:
	mov pc, lr

Method25:
	mov pc, lr

Method26:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x24
	ldr r1, [r0, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #0x8000
	movne r5, #0x7d
	subne r5, r5, #0x3f00
	bne loc_0358
	tst r0, #0x80
	beq loc_0324
	mov r0, #0x9f
	str r0, [r1, #0x2c]!
	mov r0, #1
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x31]
loc_0324:
	mov r0, #0x12
	str r0, [sp]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x14]
	str r0, [sp, #4]
	ldr r0, [r4, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r5, [sp, #0x1c]
	add ip, r5, #0x3e80
	cmn ip, #1
	beq loc_0384
loc_0358:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #4]
	mov r1, r5
	bl sub_2d24
	teq r5, #0
	bne loc_0384
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x14]!
	mov r0, r4
	ldr r2, lit_0388
	bl sub_0d2c
loc_0384:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_0388:
	.word 0xffffc17b

Method27:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2d30

Method28:
	ldr r1, [r0, #0x10]
	ldrb r1, [r1, #0x28]
	teq r1, #0
	bne loc_2558
	mov pc, lr

Method29:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r0, r2
	mov r6, r3
	mov r8, #0
	ldr r7, lit_04a8
	ldr ip, lit_04ac
	cmp r2, ip
	beq loc_09a0
	add r2, r4, #0x18
	bgt loc_0510
	ldr ip, lit_04b0
	cmp r0, ip
	beq loc_0414
	bgt loc_04bc
	ldr ip, lit_04b4
	teq r0, ip
	beq loc_0598
	ldr ip, lit_04b8
	teq r0, ip
	bne loc_0c1c
loc_0414:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x24]
	teq r0, #0
	beq loc_0444
	ldr r1, [r4, #8]
	and r3, r1, #0xff00
	ldr r2, [r4]
	mov r1, r4
	bl sub_3054
	mov r8, r0
	cmn r0, #4
	bne loc_0c48
loc_0444:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x20]
	teq r0, #0
	beq loc_0474
	ldr r1, [r4, #8]
	and r3, r1, #0xff00
	ldr r2, [r4]
	mov r1, r4
	bl sub_312c
	mov r8, r0
	cmn r0, #4
	bne loc_0c48
loc_0474:
	ldr r0, [r5, #0x10]!
	ldr r0, [r0, #0x1c]
	teq r0, #0
	beq loc_0c3c
	ldr r1, [r4, #8]
	and r3, r1, #0xff00
	ldr r2, [r4]
	mov r1, r4
	bl sub_3274
	mov r8, r0
	cmn r0, #4
	bne loc_0c48
	b loc_0c3c
lit_04a8:
	.word 0x43434520			; 'CCE '
lit_04ac:
	.word 0x69697078			; 'iipx'
lit_04b0:
	.word 0x69646f6d			; 'idom'
lit_04b4:
	.word 0x69636c63			; 'iclc'
lit_04b8:
	.word 0x69646e73			; 'idns'
loc_04bc:
	ldr ip, lit_0508
	teq r0, ip
	beq loc_0bbc
	ldr ip, lit_050c
	teq r0, ip
	bne loc_0c1c
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0c44
	mov r0, r5
	ldr r1, [r4, #0x14]
	bl sub_2720
	teq r0, #0
	mvnne r8, #0
	moveq r8, #0
	cmn r8, #1
	bne loc_0c48
loc_0500:
	str r0, [r4, #0x10]!
	b loc_0c48
lit_0508:
	.word 0x69647276			; 'idrv'
lit_050c:
	.word 0x6964796e			; 'idyn'
loc_0510:
	ldr ip, lit_0588
	teq r0, ip
	beq loc_0bec
	ldr ip, lit_058c
	teq r0, ip
	beq loc_06b8
	ldr ip, lit_0590
	teq r0, ip
	beq loc_0754
	ldr ip, lit_0594
	teq r0, ip
	bne loc_0c1c
	ldr r0, [r5, #0x10]
	ldr r1, [r0, #0x14]!
	cmn r1, #1
	beq loc_0c3c
	mov r0, r5
	bl sub_2198
	movs r5, r0
	beq loc_0c3c
	teq r6, #0x300
	bne loc_0938
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_2b00
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x14
	b loc_0c48
lit_0588:
	.word 0x696c6e6b			; 'ilnk'
lit_058c:
	.word 0x69707266			; 'iprf'
lit_0590:
	.word 0x69746378			; 'itcx'
lit_0594:
	.word 0x69756478			; 'iudx'
loc_0598:
	mov r0, #1
	ldr r1, [r5, #0x10]
	strb r0, [r1, #0x30]
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x10]
	str r1, [r0, #0x14]!
	mov r7, r1
	mov r0, r5
	bl sub_0cfc
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_065c
	mvn r6, #0x3e80
	ldr r2, [r4, #0x1c]
	teq r2, #2
	beq loc_05f4
	teq r2, #4
	beq loc_061c
	teq r2, #6
	beq loc_0688
	b loc_067c
loc_05f4:
	teq r0, #0
	beq loc_0698
	mov r1, r7
	mov r0, r5
	bl sub_0cec
	teq r0, r6
	beq loc_0630
	teq r0, #0
	bne loc_0648
	b loc_0640
loc_061c:
	mov r1, r7
	mov r0, r5
	bl sub_0cdc
	teq r0, r6
	bne loc_0638
loc_0630:
	mov r8, #1
	b loc_064c
loc_0638:
	teq r0, #0
	bne loc_0648
loc_0640:
	mov r8, #0
	b loc_064c
loc_0648:
	mvn r8, #0
loc_064c:
	cmn r8, #1
	bne loc_0690
loc_0654:
	str r0, [r4, #0x10]
	b loc_0698
loc_065c:
	teq r6, #0x400
	bne loc_0688
	ldr r0, [r4, #0x1c]
	teq r0, #2
	teqne r0, #4
	beq loc_0688
	teq r0, #6
	beq loc_0698
loc_067c:
	mov r0, r1
	mvn r8, #0
	b loc_0654
loc_0688:
	mvn r8, #4
	b loc_06a8
loc_0690:
	cmn r8, #5
	beq loc_06a8
loc_0698:
	mov r1, r7
	mov r0, r5
	bl sub_0cfc
	str r0, [r4, #0x18]!
loc_06a8:
	mov r0, #0
	ldr r1, [r5, #0x10]!
	strb r0, [r1, #0x30]
	b loc_0c48
loc_06b8:
	teq r6, #0x300
	teqne r6, #0x400
	bne loc_06f4
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #8]
	str r0, [r4, #0xc]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0xc]
	str r0, [r4, #0x10]
	ldr r0, [r4, #4]
	cmp r0, #8
	ldrgt r0, [r5, #0x10]!
	ldrgt r0, [r0, #0x10]
	strgt r0, [r4, #0x14]!
	b loc_0c48
loc_06f4:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0c44
	ldr r0, [r4, #0xc]
	teq r0, #0
	ldrne r1, [r5, #0x10]
	strne r0, [r1, #8]!
	ldr r0, [r4, #0x10]
	teq r0, #0
	ldrne r1, [r5, #0x10]
	strne r0, [r1, #0xc]!
	ldr r0, [r4, #4]
	cmp r0, #8
	ble sub_073c
	ldr r0, [r4, #0x14]
	teq r0, #0
	ldrne r1, [r5, #0x10]
	strne r0, [r1, #0x10]!

sub_073c:
	mov r1, r4
	mov r0, r5
	bl sub_2924
	teq r0, #0
	beq loc_0c48
	b loc_0c3c
loc_0754:
	ldr r0, [r5, #0x10]
	ldr r1, [r0, #0x14]!
	cmn r1, #1
	beq loc_0c3c
	mov r0, r5
	bl sub_2198
	movs r5, r0
	beq loc_0c3c
	teq r6, #0x300
	bne loc_079c
	sub sp, sp, #0x40
	mov r0, sp
	bl sub_2b60
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x40
	b loc_0c48
loc_079c:
	teq r6, #0x100
	teqne r6, #0x200
	ldr r0, [r5, #0x18]
	bne loc_087c
	teq r0, #0
	bne loc_07c4
	mov r1, r7
	mov r0, #0x4c
	bl NewNamedPtr
	str r0, [r5, #0x18]
loc_07c4:
	ldr r0, [r5, #0x18]
	teq r0, #0
	beq loc_0c3c
	ldr r1, [r4, #0xc]
	str r1, [r0, #0x14]!
	ldr r1, [r4, #0x10]
	ldr r0, [r5, #0x18]
	str r1, [r0, #0x18]!
	ldr r0, [r4, #0x14]
	ldr r1, [r5, #0x18]
	str r0, [r1, #0x1c]!
	ldrb r0, [r4, #0x18]
	teq r0, #0
	movne r0, #1
	ldr r1, [r5, #0x18]
	str r0, [r1, #0x20]!
	ldr r0, [r4, #0x1c]
	ldr r1, [r5, #0x18]
	str r0, [r1, #0x24]!
	ldr r0, [r4, #0x20]
	ldr r1, [r5, #0x18]
	str r0, [r1, #0x28]!
	ldr r1, [r4, #0x24]
	ldr r0, [r5, #0x18]
	str r1, [r0, #0x2c]!
	ldr r1, [r4, #0x28]
	ldr r0, [r5, #0x18]
	str r1, [r0, #0x30]!
	ldr r0, [r4, #0x2c]
	ldr r1, [r5, #0x18]
	str r0, [r1, #0x34]!
	ldr r1, [r4, #0x30]
	ldr r0, [r5, #0x18]
	str r1, [r0, #0x38]!
	ldr r0, [r4, #0x34]
	ldr r1, [r5, #0x18]
	str r0, [r1, #0x3c]!
	ldr r1, [r4, #0x38]
	ldr r0, [r5, #0x18]
	str r1, [r0, #0x40]!
	ldrb r0, [r4, #0x3c]
	teq r0, #0
	movne r0, #1
	ldr r1, [r5, #0x18]!
	str r0, [r1, #0x48]!
	b loc_0c48
loc_087c:
	teq r0, #0
	beq loc_0c3c
	ldr r0, [r0, #0x14]
	str r0, [r4, #0xc]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x18]
	str r0, [r4, #0x10]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x1c]
	str r0, [r4, #0x14]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x20]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x18]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x24]
	str r0, [r4, #0x1c]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x28]
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x2c]
	str r0, [r4, #0x24]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x30]
	str r0, [r4, #0x28]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x34]
	str r0, [r4, #0x2c]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x38]
	str r0, [r4, #0x30]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x3c]
	str r0, [r4, #0x34]
	ldr r0, [r5, #0x18]
	ldr r0, [r0, #0x40]
	str r0, [r4, #0x38]
	ldr r0, [r5, #0x18]!
	ldr r0, [r0, #0x48]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x3c]
	b loc_0c48
loc_0938:
	teq r6, #0x100
	teqne r6, #0x200
	ldr r0, [r5, #0x1c]
	bne loc_0984
	teq r0, #0
	bne loc_0960
	mov r1, r7
	mov r0, #0x1c
	bl NewNamedPtr
	str r0, [r5, #0x1c]
loc_0960:
	ldr r0, [r5, #0x1c]
	teq r0, #0
	beq loc_0c3c
	ldr r1, [r4, #0xc]
	str r1, [r0, #0x14]!
	ldr r0, [r4, #0x10]!
	ldr r1, [r5, #0x1c]!
	str r0, [r1, #0x18]!
	b loc_0c48
loc_0984:
	teq r0, #0
	beq loc_0c3c
	ldr r0, [r0, #0x14]
	str r0, [r4, #0xc]
	ldr r0, [r5, #0x1c]!
	ldr r0, [r0, #0x18]
	b loc_0500
loc_09a0:
	ldr r0, [r5, #0x10]
	ldr r1, [r0, #0x14]!
	cmn r1, #1
	beq loc_0c3c
	mov r0, r5
	bl sub_2198
	movs r5, r0
	beq loc_0c3c
	teq r6, #0x300
	bne loc_09e8
	sub sp, sp, #0x2c
	mov r0, sp
	bl sub_2a64
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x2c
	b loc_0c48
loc_09e8:
	teq r6, #0x100
	teqne r6, #0x200
	ldr r0, [r5, #0x14]
	bne loc_0adc
	teq r0, #0
	bne loc_0a10
	mov r1, r7
	mov r0, #0x50
	bl NewNamedPtr
	str r0, [r5, #0x14]
loc_0a10:
	ldr r0, [r5, #0x14]
	teq r0, #0
	beq loc_0c3c
	ldr r1, [r4, #0xc]
	str r1, [r0, #0x14]!
	ldr r1, [r4, #0x10]
	ldr r0, [r5, #0x14]
	str r1, [r0, #0x18]!
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x14]
	str r1, [r0, #0x1c]!
	ldr r1, [r4, #0x18]
	ldr r0, [r5, #0x14]
	str r1, [r0, #0x20]!
	ldr r0, [r4, #0x1c]
	ldr r1, [r5, #0x14]
	str r0, [r1, #0x24]!
	ldr r1, [r4, #0x20]
	ldr r0, [r5, #0x14]
	str r1, [r0, #0x3c]!
	ldrb r0, [r4, #0x24]
	teq r0, #0
	movne r0, #1
	ldr r1, [r5, #0x14]
	str r0, [r1, #0x28]!
	ldrb r0, [r4, #0x25]
	movs r1, r0
	movne r1, #1
	ldr r0, [r5, #0x14]
	str r1, [r0, #0x2c]!
	ldrb r0, [r4, #0x26]
	teq r0, #0
	movne r0, #1
	ldr r1, [r5, #0x14]
	str r0, [r1, #0x30]!
	ldrb r0, [r4, #0x27]
	teq r0, #0
	movne r0, #1
	ldr r1, [r5, #0x14]
	str r0, [r1, #0x34]!
	ldrb r0, [r4, #0x28]
	movs r1, r0
	movne r1, #1
	ldr r0, [r5, #0x14]
	str r1, [r0, #0x38]!
	ldrb r0, [r4, #0x29]
	teq r0, #0
	movne r0, #1
	ldr r1, [r5, #0x14]!
	str r0, [r1, #0x44]!
	b loc_0c48
loc_0adc:
	teq r0, #0
	beq loc_0c3c
	ldr r0, [r0, #0x14]
	str r0, [r4, #0xc]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x18]
	str r0, [r4, #0x10]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x1c]
	str r0, [r4, #0x14]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x20]
	str r0, [r4, #0x18]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x24]
	str r0, [r4, #0x1c]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x3c]
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x28]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x24]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x2c]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x25]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x30]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x26]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x34]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x27]
	ldr r0, [r5, #0x14]
	ldr r0, [r0, #0x38]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x28]
	ldr r0, [r5, #0x14]!
	ldr r0, [r0, #0x44]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x29]
	b loc_0c48
loc_0bbc:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0c44
	mov r0, r5
	ldr r1, [r4, #0x14]
	bl sub_26b8
	teq r0, #0
	mvnne r8, #0
	moveq r8, #0
	cmn r8, #1
	beq loc_0500
	b loc_0c48
loc_0bec:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0c44
	mov r0, r5
	ldr r1, [r4, #0x14]
	bl sub_26ec
	teq r0, #0
	mvnne r8, #0
	moveq r8, #0
	cmn r8, #1
	beq loc_0500
	b loc_0c48
loc_0c1c:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0c44
	mov r1, r4
	mov r0, r5
	bl sub_2924
	teq r0, #0
	beq loc_0c48
loc_0c3c:
	mvn r8, #0
	b loc_0c48
loc_0c44:
	mvn r8, #4
loc_0c48:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

Method30:
	mvn r0, #5
	mov pc, lr

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r0, #0x34
	bl __nw__FUi
	str r0, [r4, #0x10]
	teq r0, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r2, #0x34
	mov r1, #0
	bl memset
	ldr r0, [r4, #0x10]
	str r6, [r0]
	ldr r0, [r4, #0x10]
	str r5, [r0, #4]!
	mov r0, r4
	mov r1, #1
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_2388

Method31:
	mvn r0, #5
	mov pc, lr

Method32:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0
	b loc_2d78

Method33:
	mov pc, lr

Method34:
	mov r0, #0
	mov pc, lr

sub_0cdc:
	mov r3, #0x80
	ldr r2, [r0, #0x10]
	str r3, [r2, #0x2c]!
	b loc_0f2c

sub_0cec:
	mov r3, #0x8000
	ldr r2, [r0, #0x10]
	str r3, [r2, #0x2c]!
	b loc_1a20

sub_0cfc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x1b
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_0d2c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__19TCommToolOptionInfoFv
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x2c]
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	bic r1, r1, #0x7f00
	bics r1, r1, #0x7f
	beq loc_0df8
	ldrb r1, [r0, #0x30]
	teq r1, #0
	bne loc_0df8
	mov r7, sp
	ldr r0, [r0, #4]
	bl sub_2e2c
	ldmia r0, {r0, r1, r2, r3, ip, lr}
	stmia r7, {r0, r1, r2, r3, ip, lr}
	ldr r0, [sp, #0x14]
	teq r0, #0
	beq loc_0de4
	ldr r0, [sp, #0x14]
	ldr r1, lit_0dfc
	bl FindOption__15TOptionIteratorFUl
	movs r7, r0
	ldrne r0, [r7, #8]
	andne r0, r0, #0x80000000
	teqne r0, #0x80000000
	beq loc_0de4
	mov r1, r6
	mov r0, r4
	bl sub_0cfc
	str r5, [r7, #0x10]!
	str r0, [r7, #8]
	teq r5, #0
	mvnne r1, #0
	moveq r1, #0
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #4]
	bl sub_2d54
loc_0de4:
	ldr r0, [r4, #0x10]!
	ldr r1, [r0, #0x2c]
	bic r1, r1, #0x8000
	bic r1, r1, #0x80
	str r1, [r0, #0x2c]!
loc_0df8:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_0dfc:
	.word 0x69636c63			; 'iclc'

sub_0e00:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r3
	ldr sb, [fp, #4]
	sub sp, sp, #0x60
	mov r7, #0
	mov sl, #0x54
	mov r8, #0xe9
	sub r8, r8, #0x2800
	cmp sb, #0
	ble sub_0e78
	ldr r1, lit_0f04
	mov r0, #0xc
	bl NewNamedPtr
	movs r7, r0
	beq loc_0ecc
	mov r0, sb
	ldr r1, lit_0f04
	bl NewNamedPtr
	str r0, [r7, #8]
	teq r0, #0
	beq loc_0ecc
	mov r2, sb
	mov r1, #0
	bl memset
	str sb, [r7]
	str sb, [r7, #4]

sub_0e78:
	str sl, [sp, #0x54]
	str sl, [sp, #0x58]
	str sp, [sp, #0x5c]
	mov r3, #0
	stmdb sp!, {r3}
	mov r3, r7
	add r2, sp, #0x58
	mov r1, r4
	mov r0, r5
	bl sub_2234
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	beq loc_0f08
	teq r0, #0
	moveq r8, #0
	beq loc_0ecc
	mov r8, r0
	add ip, r0, #0x3e80
	cmn ip, #1
	beq loc_0ef4
loc_0ecc:
	mov r3, r8
	mov r2, #0
	mov r1, r7
	stmdb sp!, {r1, r2, r3}
	add r3, sp, #0x60
	mov r2, r4
	mov r1, r6
	mov r0, r5
	bl sub_25cc
	add sp, sp, #0xc
loc_0ef4:
	teq r7, #0
	movne r0, r7
	blne free
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_0f04:
	.word 0x43434567			; 'CCEg'
loc_0f08:
	mov r1, r4
	mov r0, r5
	bl sub_2168
	teq r0, #0
	ldreq r8, lit_0f28
	beq loc_0ecc
	str r6, [r0, #0x2c]!
	b loc_0ef4
lit_0f28:
	.word 0xffff1587
loc_0f2c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_2198
	movs r7, r0
	moveq r6, #0x79
	subeq r6, r6, #0x3f00
	beq loc_1084
	mov r0, r4
	mov r1, #2
	bl sub_235c
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #1
	bne loc_0f8c
	orr r0, r0, #1
	str r0, [r1, #0x2c]!
	mov r1, r5
	mov r0, r4
	bl sub_1350
	movs r6, r0
	bne loc_1074
loc_0f8c:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #2
	bne loc_0fb8
	orr r0, r0, #2
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_13bc
	movs r6, r0
	bne loc_1074
loc_0fb8:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #4
	bne loc_0fe4
	orr r0, r0, #4
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_13d0
	movs r6, r0
	bne loc_1074
loc_0fe4:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #8
	bne loc_1040
	orr r0, r0, #8
	str r0, [r1, #0x2c]!
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x20]
	bl sub_3180
	ldr r1, [r4, #0x10]
	str r0, [r1, #8]!
	str r0, [r7, #0xc]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x20]
	bl sub_318c
	ldr r1, [r4, #0x10]
	str r0, [r1, #0xc]!
	str r0, [r7, #0x10]
	mov r1, r7
	mov r0, r4
	bl sub_1574
	movs r6, r0
	bne loc_1074
loc_1040:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #0x10
	bne loc_106c
	orr r0, r0, #0x10
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_2800
	movs r6, r0
	bne loc_1074
loc_106c:
	mov r6, #0
	b loc_1084
loc_1074:
	teq r6, #0
	addne ip, r6, #0x3e80
	cmnne ip, #1
	beq loc_10d8
loc_1084:
	ldr r0, [r4, #0x10]
	ldrb r1, [r0, #0x31]
	mov r7, #0
	teq r1, #0
	strbne r7, [r0, #0x31]
	ldrne r6, lit_10e0
	mov r2, r6
	mov r1, r5
	mov r0, r4
	bl sub_0d2c
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x18]
	teq r0, #0
	beq loc_10cc
	mov r1, #1
	bl __dt__12TOptionArrayFv
	ldr r0, [r4, #0x10]
	str r7, [r0, #0x18]!
loc_10cc:
	mov r0, r4
	mov r1, #0
	bl sub_235c
loc_10d8:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_10e0:
	.word 0xffffc17b

Method5:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r1, [r1, #4]
	mov r7, r1
	ldr r0, [r0, #0x10]
	ldr r6, [r0, #0x14]
	ldr r2, [r5]
	sub r3, r2, #0xe
	cmp r3, #0x1e
	addls pc, pc, r3, lsl #2
	b loc_1340
	b loc_1318
	b loc_11bc
	b loc_1340
	b loc_1194
	b loc_1340
	b loc_11d4
	b loc_1340
	b loc_1340
	b loc_11fc
	b loc_120c
	b loc_121c
	b loc_1340
	b loc_1340
	b loc_1340
	b loc_1340
	b loc_1340
	b loc_1340
	b loc_1340
	b loc_1240
	b loc_1250
	b loc_1260
	b loc_126c
	b loc_1278
	b loc_1288
	b loc_1298
	b loc_1318
	b loc_1194
	b loc_1318
	b loc_1194
	b loc_12b4
loc_1194:
	mov r1, #0
	teq r2, #0x2a
	streq r1, [r0, #0x20]!
	beq loc_11ac
	teq r2, #0x28
	streq r1, [r0, #0x1c]!
loc_11ac:
	mov r1, r6
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b loc_1a20
loc_11bc:
	mov r1, r6
	mov r0, r4
	ldr r2, lit_11d0
	bl sub_0d2c
	b loc_1234
lit_11d0:
	.word 0xffffc173
loc_11d4:
	ldr r0, [r0, #4]
	mov r1, r7
	bl sub_2d24
	teq r7, #0
	moveq r1, r6
	moveq r0, r4
	ldreq r2, lit_11f8
	beq loc_1338
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_11f8:
	.word 0xffffc17b
loc_11fc:
	mov r0, r4
	ldr r2, [r5, #0x10]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b loc_2418
loc_120c:
	mov r0, r4
	ldr r2, [r5, #0x10]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b loc_24ac
loc_121c:
	ldr r0, [r0, #0x20]
	teq r0, #0
	beq loc_1234
	bl sub_315c
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
loc_1234:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b loc_2558
loc_1240:
	mov r0, r4
	ldr r2, [r5, #8]
	bl sub_1d2c
	b loc_1348
loc_1250:
	mov r0, r4
	ldr r2, [r5, #8]
	bl sub_1da8
	b loc_1348
loc_1260:
	mov r0, r4
	bl sub_1e24
	b loc_1348
loc_126c:
	mov r0, r4
	bl sub_1d6c
	b loc_1348
loc_1278:
	mov r0, r4
	ldr r1, [r5, #0x10]
	bl sub_2064
	b loc_1348
loc_1288:
	mov r0, r4
	ldr r2, [r5, #8]
	bl sub_1e60
	b loc_1348
loc_1298:
	ldr r3, [r5, #0x10]
	stmdb sp!, {r3}
	mov r0, r4
	add r5, r5, #4
	ldmib r5!, {r2, r3}
	bl sub_0e00
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_12b4:
	ldr r0, [r0, #0x24]
	bl sub_3084
	ldr r1, [r4, #0x10]
	str r0, [r1, #8]!
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x24]
	bl sub_3090
	teq r0, #0
	ldrne r1, [r4, #0x10]
	strne r0, [r1, #0xc]!
	mov r1, r6
	mov r0, r4
	bl sub_2198
	teq r0, #0
	beq loc_1318
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #8]
	str r1, [r0, #0xc]
	ldr r1, [r4, #0x10]
	ldr r2, [r1, #0xc]!
	str r2, [r0, #0x10]!
	mov r0, r4
	mov r3, #0
	mov r1, #0
	bl sub_1940
loc_1318:
	teq r7, #0
	moveq r1, r6
	moveq r0, r4
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, lr}
	beq loc_0f2c
	mov r2, r7
	mov r1, r6
	mov r0, r4
loc_1338:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_0d2c
loc_1340:
	mov r0, #0x7e
	sub r0, r0, #0x3f00
loc_1348:
	str r0, [r5, #0x1c]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_1350:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0xd
	sub sp, sp, #0x1c
	stmdb sp!, {r0, r1}
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x18]
	str r0, [sp, #0x10]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #8]
	str r0, [sp, #8]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0xc]
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	mov r0, #0
	ldr r1, [r4, #0x10]
	str r0, [r1, #0xc]!
	ldr r1, [r4, #0x10]!
	str r0, [r1, #8]!
	ldr r0, [sp, #0x1c]
	ldmdb fp, {r4, fp, sp, pc}

sub_13bc:
	ldr r2, [r1, #0x24]
	ldr r0, [r0, #0x10]
	str r2, [r0, #0x1c]!
	ldr r0, [r1, #0x24]!
	b loc_325c

sub_13d0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	sub sp, sp, #0xc
	moveq r6, #0x5a0
	subeq r6, r6, #0xf000
	beq loc_1490
	ldr r0, [r4, #0x24]
	teq r0, #0
	moveq r6, #0x8d
	subeq r6, r6, #0xeb00
	beq loc_1490
	ldr r0, [r4, #0x20]
	teq r0, #0
	moveq r6, #0x8e
	subeq r6, r6, #0xeb00
	beq loc_1490
	ldr r1, [r5, #0x10]
	str r0, [r1, #0x20]!
	ldr r1, [r4, #0xc]
	bl sub_3168
	ldr r1, [r4, #0x10]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x20]
	bl sub_3174
	mov r0, r5
	mov r1, #2
	bl sub_298c
	mov r1, sp
	ldr r0, [r4, #0x24]
	bl sub_32a4
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x20]
	mov r1, sp
	bl sub_31a4
	ldr r0, [r4, #0x24]
	bl sub_3298
	mov r1, r0
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x20]
	bl sub_3114
	mov r6, r0
	add r1, r4, #0x28
	ldr r0, [r5, #0x10]!
	ldr r0, [r0, #0x20]
	bl sub_31b0
loc_1490:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1498:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, #0
	ldr r0, [r1, #0x14]
	teq r0, #0
	bne loc_1534
	ldr r1, lit_1530
	mov r0, #0x50
	bl NewNamedPtr
	teq r0, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r4, #0x28]
	str r1, [r0, #0x14]
	mov r1, #0x40
	str r1, [r0, #0x18]
	mov r1, #0x96
	str r1, [r0, #0x1c]
	mov r1, #0xa
	str r1, [r0, #0x20]
	str r1, [r0, #0x24]
	mov r1, #0x3e8
	str r1, [r0, #0x3c]
	mov r1, #1
	str r1, [r0, #0x28]
	str r1, [r0, #0x2c]
	str r1, [r0, #0x30]
	add r0, r0, #0x34
	stmia r0, {r1, r5}
	sub r0, r0, #0x34
	ldrb r1, [r4, #0x2c]
	teq r1, #0
	movne r1, #1
	str r1, [r0, #0x44]
	b loc_1544
lit_1530:
	.word 0x43434520			; 'CCE '
loc_1534:
	ldr r2, [r0, #0x14]
	ldr r1, [r4, #0x28]
	cmp r2, r1
	strhi r1, [r0, #0x14]
loc_1544:
	ldr r1, [r4, #0xc]
	str r1, [r0, #0xc]
	ldr r1, [r0, #0x14]
	sub r1, r1, #0x14
	str r1, [r0, #0x10]
	mvn r1, #0
	str r1, [r0, #0x4c]
	str r5, [r0, #0x40]
	str r5, [r0, #0x48]
	str r0, [r4, #0x14]!
	mov r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1574:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	ldr r0, [r0, #0x10]
	add r0, r0, #0x38
	str r0, [r1, #8]
	mov r0, r5
	bl sub_1498
	movs r6, r0
	bne loc_1704
	ldr r0, [r4, #8]
	ldr r1, [r0, #0xc]
	cmn r1, #1
	bne loc_170c
	mov r6, #0x18c
	sub r6, r6, #0xec00
	mov r3, r5
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #0
	mov r2, #0
	mov r1, #0x31
	bl sub_21c8
	add sp, sp, #4
	ldr r1, [r4, #8]
	str r0, [r1, #0xc]!
	cmp r0, #0
	blt sub_16ec
	mov r3, r5
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #0
	mov r2, #1
	mov r1, #0x31
	bl sub_21c8
	add sp, sp, #4
	ldr r1, [r4, #8]
	str r0, [r1, #0x10]!
	cmp r0, #0
	blt sub_16ec
	mov r3, r5
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #0
	mov r2, #2
	mov r1, #0x31
	bl sub_21c8
	add sp, sp, #4
	ldr r1, [r4, #8]
	str r0, [r1, #0x14]!
	cmp r0, #0
	blt sub_16ec
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x20]
	bl sub_3198
	mov r2, r0
	ldr r0, [r4, #8]
	ldr r1, [r0, #0xc]!
	mov r0, r5
	bl sub_22f4
	ldr r1, [r4, #8]
	str r0, [r1, #8]!
	movs r6, r0
	ldr r1, [r4, #8]
	bmi sub_16ec
	ldr r1, [r1, #0x10]
	mov r2, r4
	mov r0, r5
	bl sub_1720
	movs r6, r0
	bne sub_16ec
	ldr r0, [r4, #8]
	ldr r1, [r0, #0x10]!
	mov r0, r5
	mov r2, #2
	bl sub_1e60
	movs r6, r0
	bne sub_16ec
	mov r6, #0x590
	sub r6, r6, #0xf000
	mov r0, r5
	mov r3, #0
	mov r1, #0
	ldr r2, [r4, #0x10]
	bl sub_1940
	teq r0, #0
	moveq r0, #1
	ldreq r1, [r4, #8]!
	streq r0, [r1]
	beq loc_1718

sub_16ec:
	ldr r0, [r4, #0x14]
	teq r0, #0
	beq loc_1704
	bl free
	mov r0, #0
	str r0, [r4, #0x14]!
loc_1704:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_170c:
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
loc_1718:
	mov r6, #0
	b loc_1704

sub_1720:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r2
	sub sp, sp, #0xc
	mov r0, #0x200
	ldr r2, [r2, #0x14]
	str r0, [r2]
	ldr r0, [r4, #8]
	ldr r2, [r0, #8]!
	ldr r0, [r4, #0x14]
	mov r6, #0
	str r2, [r0, #4]!
	ldr r0, [r4, #0x14]
	str r6, [r0, #8]!
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x10]
	teq r0, #0
	ldrne r0, [r4, #0x14]
	strne r6, [r0, #0xc]!
	mov r0, #0x50
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x14]
	mov r3, #0
	str r0, [sp, #8]
	stmdb sp!, {r3}
	add r2, sp, #4
	mov r0, r5
	bl sub_2270
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_17e0
	teq r0, #0
	bne loc_17e0
	mov r0, #0
	ldr r1, [r5, #0x10]
	ldr r2, [r1, #0x10]!
	teq r2, #0
	beq loc_17dc
	mov r0, r5
	ldr r1, [r4, #0xc]!
	bl sub_17ec
	ldr r1, [r5, #0x10]!
	str r6, [r1, #0x10]!
loc_17dc:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_17e0:
	mov r0, #0x9a
	sub r0, r0, #0xeb00
	b loc_17dc

sub_17ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0x50
	mov r3, r0
	stmdb sp!, {r3}
	mov r3, #2
	mov r2, #0
	mov r1, #0x31
	bl sub_21c8
	add sp, sp, #4
	movs r7, r0
	movmi r8, #0x18c
	submi r8, r8, #0xec00
	bmi loc_1920
	mov r0, #6
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	mov r0, #0x1c
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x21
	str r0, [sp, #0x18]
	mov r0, #0
	mov r1, #0x11
	str r0, [sp, #0x1c]
	strb r1, [sp, #0x21]
	strb r0, [sp, #0x20]
	mov r0, #0x24
	str r0, [sp, #0x24]
	str r0, [sp, #0x28]
	str sp, [sp, #0x2c]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x28
	mov r1, r7
	mov r0, r4
	bl sub_2270
	add sp, sp, #4
	teq r0, #0
	movne r8, #0x194
	subne r8, r8, #0xec00
	bne loc_1920
	mov r1, r7
	mov r0, r4
	mov r2, #2
	bl sub_1e60
	movs r8, r0
	bne loc_1920
	add r0, sp, #0x30
	mov r2, #0x20
	mov r1, #0
	bl memset
	mov r0, #0x500
	str r0, [sp, #0x30]
	str r6, [sp, #0x34]
	mov r0, #0x20
	str r0, [sp, #0x24]
	str r5, [sp, #0x4c]
	str r0, [sp, #0x28]
	add r0, sp, #0x30
	mov r3, #0
	str r0, [sp, #0x2c]
	stmdb sp!, {r3}
	add r2, sp, #0x28
	mov r1, r7
	mov r0, r4
	bl sub_2270
	add sp, sp, #4
	teq r0, #0
	movne r8, #0x9a
	subne r8, r8, #0xeb00
loc_1920:
	cmn r7, #1
	ble sub_1938
	mov r2, r7
	mov r0, r4
	mov r1, #0x31
	bl sub_2200

sub_1938:
	mov r0, r8
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_1940:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	sub sp, sp, #0x20
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	ldr r8, [r0, #0x10]!
	ldr r0, [r8, #0x50]
	cmn r0, #1
	bne loc_19a4
	mov r3, r4
	stmdb sp!, {r3}
	mov r0, r4
	mov r3, #0
	mov r2, #3
	mov r1, #0x31
	bl sub_21c8
	add sp, sp, #4
	cmp r0, #0
	blt sub_1a1c
	str r0, [r8, #0x50]
loc_19a4:
	mov r0, #3
	add r0, r0, #0x200
	stmia sp, {r0, r7}
	mov r0, #0
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	mov r0, #0x14
	str r0, [sp, #0x14]
	str r6, [sp, #8]
	str r0, [sp, #0x18]
	str sp, [sp, #0x1c]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x18
	mov r0, r4
	ldr r1, [r8, #0x50]
	bl sub_2270
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_1a00
	teq r0, #0
	beq loc_1a0c
loc_1a00:
	mov r0, #0x590
	sub r0, r0, #0xf000
	b sub_1a1c
loc_1a0c:
	mov r0, r4
	mov r2, #2
	ldr r1, [r8, #0x50]!
	bl sub_1e60

sub_1a1c:
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_1a20:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x2c]
	teq r0, #0x9f00
	beq loc_1a60
	mov r1, r5
	mov r0, r4
	bl sub_2198
	movs r7, r0
	moveq r6, #0x79
	subeq r6, r6, #0x3f00
	beq loc_1b64
loc_1a60:
	mov r0, r4
	mov r1, #2
	bl sub_235c
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #0x1000
	mvn r8, #0x3e80
	bne loc_1aa0
	orr r0, r0, #0x1000
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_28e0
	mov r6, r0
	teq r0, r8
	beq loc_1b80
loc_1aa0:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #0x800
	bne loc_1ad0
	orr r0, r0, #0x800
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_1c48
	mov r6, r0
	teq r0, r8
	beq loc_1b80
loc_1ad0:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #0x400
	bne loc_1b00
	orr r0, r0, #0x400
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_1c04
	mov r6, r0
	teq r0, r8
	beq loc_1b80
loc_1b00:
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x2c]
	tst r0, #0x200
	bne loc_1b30
	orr r0, r0, #0x200
	str r0, [r1, #0x2c]!
	mov r1, r7
	mov r0, r4
	bl sub_1bbc
	mov r6, r0
	teq r0, r8
	beq loc_1b80
loc_1b30:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x2c]
	tst r1, #0x100
	bne loc_1b60
	orr r1, r1, #0x100
	str r1, [r0, #0x2c]!
	mov r1, r5
	mov r0, r4
	bl sub_1b88
	mov r6, r0
	teq r0, r8
	beq loc_1b80
loc_1b60:
	mov r6, #0
loc_1b64:
	mov r2, r6
	mov r1, r5
	mov r0, r4
	bl sub_0d2c
	mov r0, r4
	mov r1, #0
	bl sub_235c
loc_1b80:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_1b88:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x10
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

Method6:
	mov pc, lr

sub_1bbc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0x8e
	sub r0, r0, #0xeb00
	teq r1, #0
	ldrne r1, [r1, #0x24]
	teqne r1, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	mov r0, r1
	bl sub_3268
	add ip, r0, #0x3e80
	cmn ip, #1
	movne r1, #0
	ldrne r2, [r4, #0x10]!
	strne r1, [r2, #0x1c]!
	ldmdb fp, {r4, fp, sp, pc}

sub_1c04:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x20]
	teq r1, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	mov r0, r1
	bl sub_3120
	add ip, r0, #0x3e80
	cmn ip, #1
	movne r1, #0
	ldrne r2, [r4, #0x10]!
	strne r1, [r2, #0x20]!
	ldmdb fp, {r4, fp, sp, pc}

sub_1c48:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	mov r0, #0
	ldrne r2, [r4, #8]
	teqne r2, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r1, [r2, #0xc]
	cmn r1, #1
	ldrne r2, [r2, #8]
	movne r0, r5
	blne sub_2328
	ldr r0, [r5, #0x10]
	ldr r0, [r0]
	ldr r0, [r0, #0x10]
	ldr r2, [r0, #0x50]!
	ldr r0, [r4, #8]
	ldr r1, [r0, #4]!
	mov r0, r5
	bl sub_2200
	mvn r6, #0
	ldr r0, [r5, #0x10]
	ldr r0, [r0]
	ldr r0, [r0, #0x10]
	str r6, [r0, #0x50]!
	ldr r0, [r4, #8]
	ldr r1, [r0, #4]!
	ldr r2, [r0, #8]!
	mov r0, r5
	bl sub_2200
	ldr r0, [r4, #8]
	str r6, [r0, #0xc]!
	ldr r0, [r4, #8]
	ldr r1, [r0, #4]!
	ldr r2, [r0, #0xc]!
	mov r0, r5
	bl sub_2200
	ldr r0, [r4, #8]
	str r6, [r0, #0x10]!
	ldr r0, [r4, #8]
	ldr r1, [r0, #4]!
	ldr r2, [r0, #0x10]!
	mov r0, r5
	bl sub_2200
	ldr r0, [r4, #8]
	str r6, [r0, #0x14]!
	mov r5, #0
	ldr r0, [r4, #0x14]
	teq r0, #0
	beq loc_1d20
	bl free
	str r5, [r4, #0x14]
loc_1d20:
	mov r0, #0
	str r5, [r4, #8]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1d2c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0x14
	mov r3, #8
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str sp, [sp, #0x10]
	mov r3, #0xb
	str r3, [sp]
	mov r3, #0
	str r2, [sp, #4]
	stmdb sp!, {r3}
	add r2, sp, #0xc
	bl sub_2270
	ldmdb fp, {fp, sp, pc}

sub_1d6c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0x10
	mov r2, #4
	str r2, [sp, #4]
	str r2, [sp, #8]
	str sp, [sp, #0xc]
	mov r2, #0xc
	mov r3, #0
	str r2, [sp]
	stmdb sp!, {r3}
	add r2, sp, #8
	bl sub_2270
	ldmdb fp, {fp, sp, pc}

sub_1da8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #1
	str r2, [sp, #-0x1c]!
	str r3, [sp, #-4]!
	mov r2, #2
	strb r2, [sp, #0xd]
	mov r2, #0
	strb r2, [sp, #0xc]
	str r2, [sp, #8]
	strb r2, [sp, #0xf]
	strb r2, [sp, #0xe]
	str r2, [sp, #0x10]
	mov r2, #0x14
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	str sp, [sp, #0x1c]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x18
	bl sub_2270
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_1e18
	teq r0, #0
	beq loc_1e1c
loc_1e18:
	ldr r0, lit_1e20
loc_1e1c:
	ldmdb fp, {fp, sp, pc}
lit_1e20:
	.word 0xffff158b

sub_1e24:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0x10
	mov r2, #4
	str r2, [sp, #4]
	str r2, [sp, #8]
	str sp, [sp, #0xc]
	mov r2, #2
	mov r3, #0
	str r2, [sp]
	stmdb sp!, {r3}
	add r2, sp, #8
	bl sub_2270
	ldmdb fp, {fp, sp, pc}

sub_1e60:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	sub sp, sp, #0x68
	mov r7, #0x174
	sub r7, r7, #0x4000
	mov r0, #0xb
	str r1, [sp, #0x60]
	strb r0, [sp, #0x65]
	mov r0, #0
	strb r0, [sp, #0x64]
	strb r0, [sp, #0x67]
	strb r0, [sp, #0x66]
	add r1, sp, #0x60
	mov r0, r4
	mov r3, #0x78
	mov r2, #1
	bl sub_22bc
	ldr r0, [sp, #0x64]
	tst r0, #0xb
	beq loc_1f84
	str sp, [sp, #0x5c]
	mov r0, #0x54
	str r0, [sp, #0x54]
	mov r3, #0
	str r0, [sp, #0x58]
	stmdb sp!, {r3}
	add r2, sp, #0x58
	mov r1, r5
	mov r0, r4
	bl sub_2234
	add sp, sp, #4
	teq r0, #0
	bne loc_1f84
	teq r6, #0
	beq loc_1f1c
	teq r6, #1
	beq loc_1f2c
	teq r6, #2
	bne loc_1f54
	add r1, sp, #0x54
	mov r0, r4
	bl sub_1f8c
	b loc_1f74
loc_1f1c:
	add r1, sp, #0x54
	mov r0, r4
	bl sub_2064
	b loc_1f74
loc_1f2c:
	ldr r0, [r4, #0x10]!
	ldr r0, [r0, #0x24]
	teq r0, #0
	moveq r7, #0x6a
	subeq r7, r7, #0xeb00
	beq loc_1f84
	add r2, sp, #0x54
	mov r1, r5
	bl sub_3060
	b loc_1f74
loc_1f54:
	ldr r0, [r4, #0x10]!
	ldr r0, [r0, #0x20]
	teq r0, #0
	beq loc_1f7c
	add r3, sp, #0x54
	mov r2, r6
	mov r1, r5
	bl sub_3144
loc_1f74:
	mov r7, r0
	b loc_1f84
loc_1f7c:
	mov r7, #0x5a0
	sub r7, r7, #0xf000
loc_1f84:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_1f8c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0
	ldr r1, [r1, #8]
	ldr r3, [r1]
	teq r3, #0x11
	beq loc_1fd0
	teq r3, #0x12
	beq loc_1fc4
	teq r3, #0x13
	movne r2, #0x69
	subne r2, r2, #0xeb00
	b loc_1fd0
loc_1fc4:
	ldr r1, [r1, #8]
	bl sub_1fd8
	mov r2, r0
loc_1fd0:
	mov r0, r2
	ldmdb fp, {fp, sp, pc}

sub_1fd8:
	mov r0, #0x4d
	sub r0, r0, #0xeb00
	cmp r1, #0x17
	addls pc, pc, r1, lsl #2
	b loc_204c
	b loc_204c

sub_1ff0:
	mov pc, lr

sub_1ff4:
	mov pc, lr

sub_1ff8:
	mov pc, lr

sub_1ffc:
	b loc_204c

sub_2000:
	mov pc, lr

sub_2004:
	mov pc, lr

sub_2008:
	mov pc, lr

sub_200c:
	mov pc, lr

sub_2010:
	b loc_204c

sub_2014:
	mov pc, lr

sub_2018:
	b loc_204c

sub_201c:
	b loc_204c

sub_2020:
	b loc_204c

sub_2024:
	b loc_204c

sub_2028:
	b loc_204c

sub_202c:
	mov pc, lr

sub_2030:
	b loc_204c

sub_2034:
	mov pc, lr

sub_2038:
	mov pc, lr

sub_203c:
	mov pc, lr

sub_2040:
	mov pc, lr

sub_2044:
	mov pc, lr

sub_2048:
	mov pc, lr
loc_204c:
	mov r0, r1
	mov pc, lr

Method7:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0
	b loc_2c7c

sub_2064:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0
	ldr r1, [r1, #8]
	ldr r3, [r1]
	teq r3, #4
	beq loc_20a8
	teq r3, #5
	beq loc_209c
	teq r3, #6
	ldrne r2, lit_2098
	b loc_20a8
lit_2098:
	.word 0xffff156b
loc_209c:
	ldr r1, [r1, #8]
	bl sub_20b0
	mov r2, r0
loc_20a8:
	mov r0, r2
	ldmdb fp, {fp, sp, pc}

sub_20b0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x550
	sub r2, r2, #0xf000
	cmp r1, #0x1b
	addls pc, pc, r1, lsl #2
	b loc_2140
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2140
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
	b loc_2160
loc_2140:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x20]
	teq r0, #0
	beq loc_215c
	bl sub_3150
	mov r2, r0
	b loc_2160
loc_215c:
	mov r2, r1
loc_2160:
	mov r0, r2
	ldmdb fp, {fp, sp, pc}

sub_2168:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0xa
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x20]
	ldmdb fp, {fp, sp, pc}

sub_2198:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x19
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x20]
	ldmdb fp, {fp, sp, pc}

sub_21c8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #7
	ldr ip, [fp, #4]
	sub sp, sp, #0x14
	stmda sp!, {r1, r2, r3, ip}
	str lr, [sp]
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_2200:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #8
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_2234:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #6
	ldr ip, [fp, #4]
	sub sp, sp, #0xc
	stmda sp!, {r2, r3, ip}
	str r1, [sp, #-8]!
	str lr, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_2270:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #1
	ldr ip, [fp, #4]
	sub sp, sp, #0x10
	stmda sp!, {r2, r3}
	stmdb sp!, {r1, ip}
	str lr, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

Method8:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0
	b loc_2c88

sub_22bc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov ip, #9
	str r1, [sp, #-0x14]!
	sub sp, sp, #8
	stmda sp!, {r2, r3}
	str ip, [sp]
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_22f4:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #2
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_2328:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #3
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_235c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x1f
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldmdb fp, {fp, sp, pc}

sub_2388:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	and r5, r1, #0xff
	sub sp, sp, #0x10
	mov r0, sp
	bl __ct__12TUNameServerFv
	teq r5, #0
	beq loc_23f0
	ldr r0, [r4, #0x10]!
	ldr r0, [r0, #4]
	bl sub_2e20
	mov r3, #0
	stmdb sp!, {r3}
	ldr r3, [r0]
	add r0, sp, #4
	adr r2, str_23e0, #30
	adr r1, str_23e8, #30
	bl RegisterName__12TUNameServerFPcT1UlT3
	add sp, sp, #4
	b loc_2400
str_23e0:
	.asciz "mux "
	.align 4
str_23e8:
	.asciz "ictl"
	.align 4
loc_23f0:
	mov r0, sp
	adr r2, str_23e0, #30
	adr r1, str_23e8, #30
	bl UnRegisterName__12TUNameServerFPcT1
loc_2400:
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__12TUNameServerFv
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_2418:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r1, r2
	ldr r0, [r2, #0x10]
	movs r2, r0
	addne r2, r1, #8
	ldr r0, [r1, #0x20]
	movs r0, r0
	addne r0, r1, #0x18
	ldr r3, [r1, #4]!
	stmdb sp!, {r3}
	mov r3, r0
	mov r1, r4
	mov r0, r5
	bl sub_2270
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	bne loc_2498
	mov r1, r4
	mov r0, r5
	bl sub_2168
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	orr r1, r1, #1
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_2498:
	mov r2, r0
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_25c8
loc_24ac:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	ldr r0, [r2, #0x10]
	movs r7, r0
	addne r7, r4, #8
	ldr r0, [r4, #0x20]
	movs r8, r0
	addne r8, r4, #0x18
	add r3, r4, #4
	stmdb sp!, {r3}
	mov r3, r8
	mov r2, r7
	mov r1, r5
	mov r0, r6
	bl sub_2234
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	bne loc_2530
	mov r1, r5
	mov r0, r6
	bl sub_2168
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	orr r1, r1, #0x10
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_2530:
	mov r3, r0
	mov r1, r8
	ldr r2, [r4, #4]!
	stmdb sp!, {r1, r2, r3}
	mov r3, r7
	mov r2, r5
	mov r0, r6
	mov r1, #0
	bl sub_25cc
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_2558:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x24
	mov r0, sp
	bl __ct__22TCommToolGetEventReplyFv
	mov r0, #1
	str r0, [sp, #0x10]
	add r0, sp, #0x14
	bl GetGlobalTime
	ldr r0, lit_25c0
	str r0, [sp, #0x1c]
	ldr r0, lit_25c4
	str r0, [sp, #0x20]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #4]
	mov r1, sp
	mov r2, #0
	bl sub_2d48
	teq r0, #0
	movne r1, #1
	moveq r1, #0
	ldr r2, [r4, #0x10]!
	strb r1, [r2, #0x28]
	ldmdb fp, {r4, fp, sp, pc}
lit_25c0:
	.word 0xffff1567
lit_25c4:
	.word 0x6963746c			; 'ictl'
loc_25c8:
	b sub_2168

sub_25cc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r4, r1
	mov r5, r2
	mov r7, r3
	mov r1, r2
	ldmib fp, {r8, sl}
	ldr sb, [fp, #0xc]
	bl sub_2168
	teq r0, #0
	beq loc_2608
	teq r4, #0
	ldreq r4, [r0, #0x2c]!
loc_2608:
	cmp r4, #0x64
	blt sub_2644
	cmp r4, #0xc7
	bgt sub_2644
	mov r3, sb
	mov r2, sl
	mov r1, r8
	stmdb sp!, {r1, r2, r3}
	ldr r0, [r6, #0x10]!
	ldr r0, [r0, #0x20]
	mov r3, r7
	mov r2, r5
	mov r1, r4
	bl sub_3138
	b loc_2680

sub_2644:
	cmp r4, #0x12c
	blt sub_2684
	subs ip, r4, #0x18c
	cmpge ip, #3
	bgt sub_2684
	mov r3, sb
	mov r2, sl
	mov r1, r8
	stmdb sp!, {r1, r2, r3}
	ldr r0, [r6, #0x10]!
	ldr r0, [r0, #0x24]
	mov r3, r7
	mov r2, r5
	mov r1, r4
	bl sub_306c
loc_2680:
	add sp, sp, #0xc

sub_2684:
	teq r8, #0
	ldrne r0, [r8, #8]
	teqne r0, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	bl free
	mov r0, #0
	str r0, [r8, #8]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

Method9:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2c94

sub_26b8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0xc
	str r2, [sp, #-0x14]!
	str r1, [sp, #-0xc]!
	str r3, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_26ec:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #0x15
	str r2, [sp, #-0x14]!
	str r1, [sp, #-0xc]!
	str r3, [sp, #-4]!
	ldr r0, [r0, #0x10]
	ldr r0, [r0]
	mov r1, sp
	bl sub_2fa8
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_2720:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r1, r2
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x24]
	teq r0, #0
	movne r6, #0x16c
	subne r6, r6, #0xec00
	bne loc_27b0
	cmp r5, #0
	blt sub_2760
	teq r1, #0
	bne loc_276c

sub_2760:
	mov r6, #0x7a
	sub r6, r6, #0x3f00
	b loc_27b0
loc_276c:
	adr r0, str_27b8, #30
	bl NewByName__FPCcT1
	ldr r1, [r4, #0x10]
	str r0, [r1, #0x24]!
	teq r0, #0
	ldr r1, [r4, #0x10]
	moveq r6, #0x6a
	subeq r6, r6, #0x3f00
	beq loc_27b0
	ldr r1, [r1]
	mov r2, r4
	ldr r3, [r1, #0x1c]
	bl sub_3030
	movs r6, r0
	movne r1, r5
	movne r0, r4
	blne sub_27cc
loc_27b0:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
str_27b8:
	.asciz "PStrDynAddrModule"
	.align 4

sub_27cc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x24]
	teq r0, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	bl sub_3008
	mov r0, #0
	ldr r1, [r4, #0x10]!
	str r0, [r1, #0x24]!
	ldmdb fp, {r4, fp, sp, pc}

sub_2800:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0xc
	mov r6, #0
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x24]
	teq r0, #0
	beq loc_28d8
	ldr r0, [r5, #0xc]
	teq r0, #0
	beq loc_2848
	mov r0, r4
	ldr r1, [r5, #0x34]!
	bl sub_27cc
	b loc_28d8
loc_2848:
	mov r0, r4
	mov r1, #1
	bl sub_298c
	mov r1, sp
	ldr r0, [r5, #0x24]
	bl sub_32a4
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x24]
	mov r1, sp
	bl sub_3078
	ldr r0, [r5, #8]
	ldr r1, [r0, #0xc]!
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x24]
	bl sub_303c
	movs r6, r0
	bne loc_28d8
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x24]
	bl sub_3084
	ldr r1, [r4, #0x10]
	str r0, [r1, #8]!
	str r0, [r5, #0xc]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x24]
	bl sub_3090
	teq r0, #0
	beq loc_28d8
	mov r2, r0
	ldr r0, [r4, #0x10]
	str r2, [r0, #0xc]!
	mov r0, r4
	mov r3, #0
	mov r1, #0
	str r2, [r5, #0x10]!
	bl sub_1940
loc_28d8:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_28e0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x24]
	teq r0, #0
	beq loc_291c
	bl sub_3048
	mov r6, r0
	mov r0, r4
	ldr r1, [r5, #0x34]!
	bl sub_27cc
loc_291c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2924:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x18]
	teq r0, #0
	bne loc_2974
	mov r0, #0
	bl __ct__12TOptionArrayFv
	ldr r1, [r4, #0x10]
	str r0, [r1, #0x18]!
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	bl Init__12TOptionArrayFv
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
loc_2974:
	ldr r0, [r4, #0x10]!
	ldr r0, [r0, #0x18]
	mov r2, r5
	ldr r1, [r0]
	ldmdb fp, {r4, r5, fp, sp, lr}
	b InsertOptionAt__12TOptionArrayFlP7TOption

sub_298c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x18]!
	teq r1, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	sub sp, sp, #0x1c
	mov r0, sp
	bl __ct__15TOptionIteratorFP12TOptionArray
	mov r0, sp
	bl FirstOption__15TOptionIteratorFv
	mov r6, r0
	mov r0, sp
	bl More__15TOptionIteratorFv
	teq r0, #0
	beq loc_2a40
loc_29d8:
	teq r5, #1
	bne loc_2a00
	ldr r0, [r6, #8]
	and r3, r0, #0xff00
	ldr r2, [r6]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x24]
	mov r1, r6
	bl sub_3054
	b loc_2a24
loc_2a00:
	teq r5, #2
	bne loc_2a24
	ldr r0, [r6, #8]
	and r3, r0, #0xff00
	ldr r2, [r6]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x20]
	mov r1, r6
	bl sub_312c
loc_2a24:
	mov r0, sp
	bl NextOption__15TOptionIteratorFv
	mov r6, r0
	mov r0, sp
	bl More__15TOptionIteratorFv
	teq r0, #0
	bne loc_29d8
loc_2a40:
	mov r0, sp
	mov r1, #0
	bl __dt__15TOptionIteratorFv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method10:
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #4]
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	b loc_2ca0

sub_2a64:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2a88
	mov r0, #0x2c
	bl __nw__FUi
	movs r4, r0
	beq loc_2af4
loc_2a88:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_2afc
	str r0, [r4]
	mov r0, #0x20
	str r0, [r4, #4]
	mov r0, #0x4a
	add r0, r0, #0x200
	str r0, [r4, #0xc]
	mov r0, #0x40
	str r0, [r4, #0x10]
	mov r0, #0x96
	str r0, [r4, #0x14]
	mov r0, #0xa
	str r0, [r4, #0x18]
	str r0, [r4, #0x1c]
	mov r0, #0x3e8
	str r0, [r4, #0x20]
	mov r0, #1
	strb r0, [r4, #0x24]
	strb r0, [r4, #0x25]
	strb r0, [r4, #0x26]
	strb r0, [r4, #0x27]
	mov r1, #0
	strb r1, [r4, #0x28]
	strb r0, [r4, #0x29]
loc_2af4:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_2afc:
	.word 0x69697078			; 'iipx'

sub_2b00:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2b24
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_2b54
loc_2b24:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_2b5c
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0x2e
	add r0, r0, #0x200
	str r0, [r4, #0xc]
	mov r0, #0xa
	str r0, [r4, #0x10]
loc_2b54:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_2b5c:
	.word 0x69756478			; 'iudx'

sub_2b60:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2b84
	mov r0, #0x40
	bl __nw__FUi
	movs r4, r0
	beq loc_2c08
loc_2b84:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_2c10
	str r0, [r4]
	mov r0, #0x34
	str r0, [r4, #4]
	mov r0, #0x22
	add r0, r0, #0x200
	str r0, [r4, #0xc]
	mov r0, #3
	str r0, [r4, #0x10]
	mov r0, #0x1e
	mov r1, #1
	str r0, [r4, #0x14]
	strb r1, [r4, #0x18]
	mov r0, #0x10
	str r0, [r4, #0x1c]
	mov r0, #5
	mov r2, #0x64
	add r4, r4, #0x20
	stmia r4, {r0, r2}
	str r0, [r4, #0xc]
	str r2, [r4, #8]
	sub r4, r4, #0x20
	mov r0, #0x800
	str r0, [r4, #0x30]
	mov r0, #0x4b0
	str r0, [r4, #0x34]
	mov r0, #0x178
	add r0, r0, #0x400
	str r0, [r4, #0x38]
	strb r1, [r4, #0x3c]
loc_2c08:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_2c10:
	.word 0x69746378			; 'itcx'

sub_2c14:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_2c1c:
	.asciz "PCECallBack"

sub_2c28:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_2c14
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_2c54:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_2c68
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_2c68:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_2c70:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10
loc_2c7c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14
loc_2c88:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18
loc_2c94:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c
loc_2ca0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20
loc_2cac:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24
loc_2cb8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28
loc_2cc4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c
loc_2cd0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30
loc_2cdc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34
loc_2ce8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38
loc_2cf4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c
loc_2d00:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_2d0c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_2d18:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48

sub_2d24:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c
loc_2d30:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x50

sub_2d3c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x54

sub_2d48:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x58

sub_2d54:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x5c

sub_2d60:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x60

sub_2d6c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x64
loc_2d78:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x68

sub_2d84:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x6c

sub_2d90:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x70

sub_2d9c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x74

sub_2da8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x78

sub_2db4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x7c

sub_2dc0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x80

sub_2dcc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x84

sub_2dd8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x88

sub_2de4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x8c

sub_2df0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x90

sub_2dfc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x94

sub_2e08:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x98

sub_2e14:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x9c

sub_2e20:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xa0

sub_2e2c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xa4

sub_2e38:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xa8

sub_2e44:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xac

sub_2e50:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xb0

sub_2e5c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xb4

sub_2e68:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xb8

sub_2e74:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xbc

sub_2e80:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xc0

sub_2e8c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xc4

sub_2e98:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xc8

sub_2ea4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xcc

sub_2eb0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xd0

sub_2ebc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xd4

sub_2ec8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xd8

sub_2ed4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xdc

sub_2ee0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xe0

sub_2eec:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xe4

sub_2ef8:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_2f00:
	.asciz "PMuxTool"
	.align 4

sub_2f0c:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_2ef8
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_2f38:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_2f4c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_2f4c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_2f54:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_2f60:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_2f6c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_2f78:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_2f84:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_2f90:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_2f9c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_2fa8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_2fb4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_2fc0:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_2fc8:
	.asciz "PStrDynAddrModule"
	.align 4

sub_2fdc:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_2fc0
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_3008:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_301c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_301c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_3024:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_3030:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_303c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_3048:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_3054:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_3060:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_306c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_3078:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_3084:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_3090:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_309c:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_30a4:
	.asciz "PStrLinkModule"
	.align 4

sub_30b4:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_309c
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_30e0:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_30f4
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_30f4:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_30fc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_3108:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_3114:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_3120:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_312c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_3138:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_3144:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_3150:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_315c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_3168:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_3174:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_3180:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

sub_318c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_3198:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_31a4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48

sub_31b0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c

sub_31bc:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_31c4:
	.asciz "PStrDriverModule"
	.align 4

sub_31d8:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_31bc
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_3204:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_3218
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_3218:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_3220:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_322c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_3238:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_3244:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_3250:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20
loc_325c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_3268:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_3274:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_3280:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_328c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_3298:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_32a4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

CopyDataFrom__7TOptionFP7TOption:
	ldr pc, lit_32b4
lit_32b4:
	.word 0x0180029c			; glue 0180029c -> CopyDataFrom__7TOptionFP7TOption

FindOption__15TOptionIteratorFUl:
	ldr pc, lit_32bc
lit_32bc:
	.word 0x018002e0			; glue 018002e0 -> FindOption__15TOptionIteratorFUl

FirstOption__15TOptionIteratorFv:
	ldr pc, lit_32c4
lit_32c4:
	.word 0x018002e8			; glue 018002e8 -> FirstOption__15TOptionIteratorFv

FreeInstance__FP9TProtocol:
	ldr pc, lit_32cc
lit_32cc:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

GetGlobalTime:
	ldr pc, lit_32d4
lit_32d4:
	.word 0x018010a4			; glue 018010a4 -> GetGlobalTime

Init__12TOptionArrayFv:
	ldr pc, lit_32dc
lit_32dc:
	.word 0x01800348			; glue 01800348 -> Init__12TOptionArrayFv

InsertOptionAt__12TOptionArrayFlP7TOption:
	ldr pc, lit_32e4
lit_32e4:
	.word 0x01800370			; glue 01800370 -> InsertOptionAt__12TOptionArrayFlP7TOption

More__15TOptionIteratorFv:
	ldr pc, lit_32ec
lit_32ec:
	.word 0x0180038c			; glue 0180038c -> More__15TOptionIteratorFv

NewByName__FPCcT1:
	ldr pc, lit_32f4
lit_32f4:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

NewNamedPtr:
	ldr pc, lit_32fc
lit_32fc:
	.word 0x01801808			; glue 01801808 -> NewNamedPtr

NextOption__15TOptionIteratorFv:
	ldr pc, lit_3304
lit_3304:
	.word 0x01800398			; glue 01800398 -> NextOption__15TOptionIteratorFv

RegisterName__12TUNameServerFPcT1UlT3:
	ldr pc, lit_330c
lit_330c:
	.word 0x0180133c			; glue 0180133c -> RegisterName__12TUNameServerFPcT1UlT3

UnRegisterName__12TUNameServerFPcT1:
	ldr pc, lit_3314
lit_3314:
	.word 0x0180157c			; glue 0180157c -> UnRegisterName__12TUNameServerFPcT1

__ct__12TOptionArrayFv:
	ldr pc, lit_331c
lit_331c:
	.word 0x018001b0			; glue 018001b0 -> __ct__12TOptionArrayFv

__ct__12TUNameServerFv:
	ldr pc, lit_3324
lit_3324:
	.word 0x01800d54			; glue 01800d54 -> __ct__12TUNameServerFv

__ct__15TOptionIteratorFP12TOptionArray:
	ldr pc, lit_332c
lit_332c:
	.word 0x018001c4			; glue 018001c4 -> __ct__15TOptionIteratorFP12TOptionArray

__ct__19TCommToolOptionInfoFv:
	ldr pc, lit_3334
lit_3334:
	.word 0x018026c0			; glue 018026c0 -> __ct__19TCommToolOptionInfoFv

__ct__22TCommToolGetEventReplyFv:
	ldr pc, lit_333c
lit_333c:
	.word 0x01801e94			; glue 01801e94 -> __ct__22TCommToolGetEventReplyFv

__ct__7TOptionFUl:
	ldr pc, lit_3344
lit_3344:
	.word 0x018001f4			; glue 018001f4 -> __ct__7TOptionFUl

__dl__FPv:
	ldr pc, lit_334c
lit_334c:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__12TOptionArrayFv:
	ldr pc, lit_3354
lit_3354:
	.word 0x018001f8			; glue 018001f8 -> __dt__12TOptionArrayFv

__dt__12TUNameServerFv:
	ldr pc, lit_335c
lit_335c:
	.word 0x01800dd0			; glue 01800dd0 -> __dt__12TUNameServerFv

__dt__15TOptionIteratorFv:
	ldr pc, lit_3364
lit_3364:
	.word 0x01800208			; glue 01800208 -> __dt__15TOptionIteratorFv

__nw__FUi:
	ldr pc, lit_336c
lit_336c:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

free:
	ldr pc, lit_3374
lit_3374:
	.word 0x01801024			; glue 01801024 -> free

memset:
	ldr pc, lit_337c
lit_337c:
	.word 0x01800124			; glue 01800124 -> memset
