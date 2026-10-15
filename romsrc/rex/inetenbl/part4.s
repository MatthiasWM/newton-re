; "Newton Internet Enabler" part 4: protocol (22568 bytes)
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
	.asciz "PInetToolCE"
InterfaceName:
	.asciz "PConnectionEnd"
Signature:
	.asciz ""
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
	ldr pc, lit_00f8
lit_00f8:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

sub_00fc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_0120
	mov r0, #0x5c
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_0120:
	mvn r1, #0
	str r1, [r0]
	str r1, [r0, #8]
	str r1, [r0, #4]
	mov r1, #0
	str r1, [r0, #0x10]
	str r1, [r0, #0x14]
	strb r1, [r0, #0x23]
	strb r1, [r0, #0x24]
	strb r1, [r0, #0x25]
	str r1, [r0, #0x50]
	str r1, [r0, #0x2c]
	str r1, [r0, #0x4c]
	ldmdb fp, {fp, sp, pc}

Sizeof:
	mov r0, #0x70
	mov pc, lr

Method25:
	mov pc, lr

sub_0164:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #6
	ldr ip, [fp, #4]
	sub sp, sp, #0xc
	stmda sp!, {r2, r3, ip}
	str r1, [sp, #-8]!
	str lr, [sp, #-4]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_019c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #7
	ldr ip, [fp, #4]
	sub sp, sp, #0x14
	stmda sp!, {r1, r2, r3, ip}
	str lr, [sp]
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}
loc_01d0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #8
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_0200:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov ip, #9
	str r1, [sp, #-0x14]!
	sub sp, sp, #8
	stmda sp!, {r2, r3}
	str ip, [sp]
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_0234:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0xa
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x20]
	ldmdb fp, {fp, sp, pc}

sub_0260:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x19
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x20]
	ldmdb fp, {fp, sp, pc}

sub_028c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, #0xb
	str r1, [sp, #-0x24]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x20]
	ldmdb fp, {fp, sp, pc}

sub_02b4:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x1a
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_02e0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r1, #0x1e
	str r1, [sp, #-0x24]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	ldmdb fp, {fp, sp, pc}

sub_0310:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0x1f
	str r1, [sp, #-0x20]!
	str r2, [sp, #-4]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldmdb fp, {fp, sp, pc}

Method26:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x10]
	tst r1, #0x20000
	movne r5, #0x7d
	subne r5, r5, #0x3f00
	bne loc_044c
	mov r5, #0
	tst r1, #2
	mvn r6, #0
	beq loc_03ac
	ldr r2, [r0]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	str r6, [r0]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #2
	str r1, [r0]
	ldr r0, [r4, #0x18]
	ldr r1, [r4, #0x6c]
	bl sub_5454
	b loc_044c
loc_03ac:
	tst r1, #8
	beq loc_03f0
	ldr r2, [r0, #8]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	str r6, [r0, #8]!
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	ldr r0, [r4, #0x18]
	ldr r1, [r4, #0x6c]
	bl sub_5478
	b loc_044c
loc_03f0:
	tst r1, #0x10
	beq loc_0444
	ldr r2, [r0]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	mov r2, #0xff
	bl sub_4ef0
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x10
	str r1, [r0]
	ldr r0, [r4, #0x18]
	ldr r1, [r4, #0x6c]
	bl sub_546c
	b loc_044c
loc_0444:
	mov r5, #0x71
	sub r5, r5, #0x3f00
loc_044c:
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b loc_54e4

sub_045c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x80
	mov r5, sp
	add r1, r0, #0x2c
	ldmia r1, {r0, r1}
	sub r1, r1, r0
	ldr r0, [r4, #0x3c]
	cmp r0, #0x80
	movle r2, r0
	movgt r2, #0x80
	cmp r1, r2
	ble sub_04a4
	cmp r0, #0x80
	movgt r0, #0x80
	b loc_04a8

sub_04a4:
	mov r0, r1
loc_04a8:
	cmp r0, #0
	ble sub_05d8
	mov sb, #0xa
	mov r8, #1
	mov r7, #0
loc_04bc:
	ldrb r1, [r4, #0x69]
	teq r1, #0
	sub r2, r0, #1
	beq loc_0548
	cmp r0, #0
	ble sub_0574
loc_04d4:
	ldrb r0, [r4, #0x6a]
	teq r0, #1
	bne loc_0500
	strb r7, [r4, #0x6a]
	ldr r0, [r4, #0x2c]
	ldrb r0, [r0]
	teq r0, #0xd
	strbne r7, [r5], #1
	strbne sb, [r5]
	bne loc_0530
	b loc_0518
loc_0500:
	ldr r0, [r4, #0x2c]
	ldrb r0, [r0]
	teq r0, #0xa
	strbeq r8, [r4, #0x6a]
	addeq r2, r2, #1
	beq loc_0534
loc_0518:
	strb r7, [r4, #0x6a]
	strb r7, [r5], #1
	ldr r1, [r4, #0x2c]
	ldrb r0, [r1], #1
	str r1, [r4, #0x2c]
	strb r0, [r5]
loc_0530:
	add r5, r5, #1
loc_0534:
	mov r0, r2
	sub r2, r2, #1
	cmp r0, #0
	bgt loc_04d4
	b sub_0574
loc_0548:
	cmp r0, #0
	ble sub_0574
loc_0550:
	strb r7, [r5], #1
	ldr r1, [r4, #0x2c]
	ldrb r0, [r1], #1
	str r1, [r4, #0x2c]
	strb r0, [r5], #1
	mov r0, r2
	sub r2, r2, #1
	cmp r0, #0
	bgt loc_0550

sub_0574:
	sub r6, r5, sp
	ldr r0, [r4, #0x20]
	teq r0, #0
	movne r1, sp
	blne Putn__11CBufferListFPCUcl
	ldr r0, [r4, #0x38]
	add r0, r0, r6
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x3c]
	sub r0, r0, r6
	str r0, [r4, #0x3c]
	ldr r2, [r4, #0x30]
	ldr r3, [r4, #0x2c]
	sub r2, r2, r3
	cmp r0, #0x80
	movle r1, r0
	movgt r1, #0x80
	cmp r2, r1
	ble sub_05cc
	cmp r0, #0x80
	movgt r0, #0x80
	b loc_05d0

sub_05cc:
	mov r0, r2
loc_05d0:
	cmp r0, #0
	bgt loc_04bc

sub_05d8:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_05dc:
	b sub_045c

Method28:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_3de4
	mov r1, #0x170
	sub r1, r1, #0x4000
	teq r0, r1
	moveq r0, r4
	ldmdbeq fp, {r4, fp, sp, lr}
	beq sub_3e90
	ldmdb fp, {r4, fp, sp, pc}

sub_0610:
	ldr r0, [r0, #0x18]
	b loc_5508

Method27:
	ldr r1, [r0, #0x6c]
	ldr r0, [r0, #0x18]
	b loc_54f0

Method5:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, r1
	ldr r1, [r1]
	cmp r1, #0x16
	beq loc_06a0
	bgt loc_067c
	teq r1, #0xf
	beq loc_06d0
	teq r1, #0x14
	bne loc_0700
	sub sp, sp, #8
	ldr r1, [r4, #0x10]
	ldr r2, [r1, #0x10]!
	orr r2, r2, #0x80000000
	str r2, [r1]
	ldr r1, [r0, #4]!
	ldr r0, [r4, #0x18]!
	bl sub_5550
	b loc_0710
loc_067c:
	teq r1, #0x17
	beq loc_06b8
	teq r1, #0x18
	bne loc_0700
	sub sp, sp, #8
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_0714
	b loc_0710
loc_06a0:
	sub sp, sp, #8
	ldr r1, [r0, #4]!
	ldr r2, [r0, #0xc]!
	mov r0, r4
	bl sub_4988
	b loc_0710
loc_06b8:
	sub sp, sp, #8
	ldr r1, [r0, #4]!
	ldr r2, [r0, #0xc]!
	mov r0, r4
	bl sub_4a1c
	b loc_0710
loc_06d0:
	sub sp, sp, #8
	mov r1, #1
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x25]
	mov r0, sp
	bl GetGlobalTime
	ldr r0, [sp, #4]
	ldr r1, [r4, #0x10]
	str r0, [r1, #0x18]!
	mov r0, r4
	bl sub_3e90
	b loc_0710
loc_0700:
	sub sp, sp, #8
	mov r1, #0x7e
	sub r1, r1, #0x3f00
	str r1, [r0, #0x1c]!
loc_0710:
	ldmdb fp, {r4, fp, sp, pc}

sub_0714:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r2, #1
	bl sub_1934
	mov r1, r0
	str r0, [r4, #0x6c]
	ldr r0, [r4, #0x10]
	ldr r2, [r0, #0x10]!
	orr r2, r2, #0x80000000
	str r2, [r0]
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b sub_5550

Method29:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r3
	mov r7, #0
	ldr ip, lit_07e8
	cmp r2, ip
	beq loc_0b74
	mov r8, #1
	bgt loc_085c
	ldr ip, lit_07ec
	cmp r2, ip
	beq loc_09e0
	bgt loc_07fc
	ldr ip, lit_07f0
	teq r2, ip
	beq loc_0f48
	ldr ip, lit_07f4
	teq r2, ip
	beq loc_0e9c
	ldr ip, lit_07f8
	teq r2, ip
	bne loc_0f58
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0e84
	ldr r0, [r5, #0x10]!
	ldr r1, [r0, #4]
	cmn r1, #1
	ldrne r1, [r0, #0x50]
	ldrne r1, [r1, #4]
	teqne r1, #0x42
	ldreq r1, [r4, #0xc]!
	streq r1, [r0, #4]!
	beq loc_0f5c
	b loc_0f48
lit_07e8:
	.word 0x69746378			; 'itcx'
lit_07ec:
	.word 0x696c7074			; 'ilpt'
lit_07f0:
	.word 0x69636c63			; 'iclc'
lit_07f4:
	.word 0x69637674			; 'icvt'
lit_07f8:
	.word 0x696c6964			; 'ilid'
loc_07fc:
	ldr ip, lit_0850
	teq r2, ip
	ldrne ip, lit_0854
	teqne r2, ip
	beq loc_0f5c
	ldr ip, lit_0858
	teq r2, ip
	bne loc_0f58
	teq r6, #0x100
	teqne r6, #0x200
	beq loc_0f50
	teq r6, #0x300
	bne loc_09c0
	sub sp, sp, #0x18
	mov r0, sp
	bl sub_5204
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x18
	b loc_0f5c
lit_0850:
	.word 0x696e6370			; 'incp'
lit_0854:
	.word 0x69707070			; 'ippp'
lit_0858:
	.word 0x69707266			; 'iprf'
loc_085c:
	ldr ip, lit_08e0
	cmp r2, ip
	beq loc_0dc4
	bgt loc_08f0
	ldr ip, lit_08e4
	teq r2, ip
	beq loc_0a6c
	ldr ip, lit_08e8
	teq r2, ip
	beq loc_0934
	ldr ip, lit_08ec
	teq r2, ip
	bne loc_0f58
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0af8
	ldrb r3, [r4, #0xe]
	ldrb r2, [r4, #0xd]
	ldrb r1, [r4, #0xc]
	mov r0, r5
	bl sub_4738
	teq r0, #0
	bne loc_0f48
	ldrb r0, [r4, #0xc]
	ldr r1, [r5, #0x10]
	strb r0, [r1, #0x26]
	ldrb r1, [r4, #0xd]
	ldr r0, [r5, #0x10]
	strb r1, [r0, #0x27]
	ldrb r0, [r4, #0xe]
	ldr r1, [r5, #0x10]!
	strb r0, [r1, #0x28]
	b loc_0f5c
lit_08e0:
	.word 0x69756478			; 'iudx'
lit_08e4:
	.word 0x69747273			; 'itrs'
lit_08e8:
	.word 0x69747376			; 'itsv'
lit_08ec:
	.word 0x69756263			; 'iubc'
loc_08f0:
	ldr ip, lit_092c
	teq r2, ip
	beq loc_0b48
	ldr ip, lit_0930
	teq r2, ip
	bne loc_0f58
	teq r6, #0x400
	bne loc_0f50
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x10]
	tst r0, #0x20
	beq loc_0f48
	mov r0, r5
	bl sub_4d04
	b loc_0e94
lit_092c:
	.word 0x69756d63			; 'iumc'
lit_0930:
	.word 0x73626176			; 'sbav'
loc_0934:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_097c
	ldr r0, [r4, #0xc]!
	teq r0, #1
	bne loc_095c
	mov r0, r5
	bl sub_028c
	add r0, r0, #8
	b loc_0970
loc_095c:
	teq r0, #2
	bne loc_0f48
	mov r0, r5
	bl sub_028c
	add r0, r0, #0x20
loc_0970:
	ldr r1, [r5, #0x10]!
	str r0, [r1, #0x50]!
	b loc_0f5c
loc_097c:
	teq r6, #0x300
	bne loc_0998
	sub sp, sp, #0x10
	mov r0, sp
	bl sub_51b0
	mov r1, sp
	b loc_0b10
loc_0998:
	ldr r0, [r5, #0x10]!
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	teq r0, #0x41
	streq r8, [r4, #0xc]!
	beq loc_0f5c
	teq r0, #0x42
	moveq r0, #2
	beq loc_0e94
	b loc_0f5c
loc_09c0:
	ldr r0, [r5, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r5
	bl sub_0260
	ldr r1, [r0, #0x10]
	str r1, [r4, #0x10]
	ldr r0, [r0, #0xc]
	b loc_0e94
loc_09e0:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0a14
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	ldr r1, [r5, #0x10]
	strb r0, [r1, #0x49]
	mov r0, r0, asr #8
	strb r0, [r1, #0x48]
	ldrb r0, [r4, #0xe]
	ldr r1, [r5, #0x10]
	strb r0, [r1, #0x58]
	b loc_0a60
loc_0a14:
	teq r6, #0x300
	bne loc_0a3c
	sub sp, sp, #0x10
	mov r0, sp
	bl sub_5260
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x10
	b loc_0a60
loc_0a3c:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x48]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc]
	ldr r0, [r5, #0x10]
	ldrb r0, [r0, #0x58]
	strb r0, [r4, #0xe]
loc_0a60:
	ldr r0, [r5, #0x10]!
	strb r8, [r0, #0x57]
	b loc_0f5c
loc_0a6c:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0aa0
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x10]
	str r0, [r1, #0x34]!
	ldr r0, [r4, #0x10]
	mov r0, r0, lsr #16
	ldr r1, [r5, #0x10]
	strb r0, [r1, #0x33]
	mov r0, r0, asr #8
	strb r0, [r1, #0x32]
	b loc_0aec
loc_0aa0:
	teq r6, #0x300
	bne loc_0ac8
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_52c0
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x14
	b loc_0aec
loc_0ac8:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x32]
	mov r0, r0, lsr #16
	strb r0, [r4, #0x11]
	mov r0, r0, asr #8
	strb r0, [r4, #0x10]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x34]
	str r0, [r4, #0xc]!
loc_0aec:
	ldr r0, [r5, #0x10]!
	strb r8, [r0, #0x56]
	b loc_0f5c
loc_0af8:
	teq r6, #0x300
	bne loc_0b20
	sub sp, sp, #0x10
	mov r0, sp
	bl sub_4fd4
	mov r1, sp
loc_0b10:
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x10
	b loc_0f5c
loc_0b20:
	ldr r0, [r5, #0x10]
	ldrb r0, [r0, #0x26]
	strb r0, [r4, #0xc]
	ldr r0, [r5, #0x10]
	ldrb r0, [r0, #0x27]
	strb r0, [r4, #0xd]
	ldr r0, [r5, #0x10]!
	ldrb r0, [r0, #0x28]
	strb r0, [r4, #0xe]
	b loc_0f5c
loc_0b48:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0f48
	mov r0, r5
	add r2, r4, #0x14
	ldmia r2, {r1, r2}
	bl sub_4588
	teq r0, #0
	mvnne r7, #0
	bne loc_0e7c
	b loc_0f5c
loc_0b74:
	teq r6, #0x300
	bne loc_0b9c
	sub sp, sp, #0x40
	mov r0, sp
	bl sub_50fc
	mov r1, sp
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x40
	b loc_0f5c
loc_0b9c:
	mov r0, r5
	bl sub_3f7c
	teq r0, #0
	bne loc_0f48
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0cd8
	ldr r1, [r4, #0xc]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x14]!
	ldr r1, [r4, #0x10]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x18]!
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x1c]!
	ldrb r0, [r4, #0x18]
	teq r0, #1
	movne r1, #0
	moveq r1, #1
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x20]!
	ldr r0, [r4, #0x1c]
	ldr r1, [r5, #0x10]
	ldr r1, [r1, #0x2c]
	str r0, [r1, #0x24]!
	ldr r1, [r4, #0x20]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x28]!
	ldr r1, [r4, #0x24]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x2c]!
	ldr r0, [r4, #0x28]
	ldr r1, [r5, #0x10]
	ldr r1, [r1, #0x2c]
	str r0, [r1, #0x30]!
	ldr r0, [r4, #0x2c]
	ldr r1, [r5, #0x10]
	ldr r1, [r1, #0x2c]
	str r0, [r1, #0x34]!
	ldr r0, [r4, #0x30]
	ldr r1, [r5, #0x10]
	ldr r1, [r1, #0x2c]
	str r0, [r1, #0x38]!
	ldr r1, [r4, #0x34]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x3c]!
	ldr r1, [r4, #0x38]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x40]!
	ldrb r0, [r4, #0x3c]
	teq r0, #1
	movne r1, #0
	moveq r1, #1
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	str r1, [r0, #0x48]!
	ldr r0, [r5, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r5
	bl sub_0260
	ldr r0, [r0, #0x14]
	ldr r0, [r0, #0x10]
	sub r0, r0, #0x14
	ldr r1, [r5, #0x10]!
	ldr r1, [r1, #0x2c]
	ldr r2, [r1, #0x14]
	cmp r2, r0
	strhi r0, [r1, #0x14]!
	bhi loc_0e94
	b loc_0f5c
loc_0cd8:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x14]
	str r0, [r4, #0xc]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x18]
	str r0, [r4, #0x10]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x1c]
	str r0, [r4, #0x14]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x20]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x18]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x24]
	str r0, [r4, #0x1c]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x28]
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x2c]
	str r0, [r4, #0x24]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x30]
	str r0, [r4, #0x28]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x34]
	str r0, [r4, #0x2c]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x38]
	str r0, [r4, #0x30]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x3c]
	str r0, [r4, #0x34]
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x40]
	str r0, [r4, #0x38]
	ldr r0, [r5, #0x10]!
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x48]
	teq r0, #1
	movne r0, #0
	moveq r0, #1
	strb r0, [r4, #0x3c]
	b loc_0f5c
loc_0dc4:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	teq r0, #0x42
	bne loc_0f48
	teq r6, #0x300
	bne loc_0df4
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_509c
	mov r1, sp
	b loc_0efc
loc_0df4:
	mov r0, r5
	bl sub_48cc
	teq r0, #0
	bne loc_0f48
	teq r6, #0x100
	teqne r6, #0x200
	ldr r0, [r5, #0x10]
	bne loc_0e64
	ldr r1, [r0, #4]!
	mov r0, r5
	bl sub_0260
	ldr r0, [r0, #0x14]
	ldr r0, [r0, #0x10]
	sub r0, r0, #8
	ldr r1, [r4, #0xc]
	ldr r2, [r5, #0x10]
	ldr r2, [r2, #0x4c]
	str r1, [r2, #0x14]!
	ldr r2, [r5, #0x10]
	ldr r2, [r2, #0x4c]
	cmp r1, r0
	strhi r0, [r2, #0x14]!
	strhi r0, [r4, #0xc]
	ldr r0, [r4, #0x10]!
	ldr r1, [r5, #0x10]!
	ldr r1, [r1, #0x4c]
	str r0, [r1, #0x18]!
	b loc_0f5c
loc_0e64:
	ldr r0, [r0, #0x4c]
	ldr r0, [r0, #0x14]
	str r0, [r4, #0xc]
	ldr r0, [r5, #0x10]!
	ldr r0, [r0, #0x4c]
	ldr r0, [r0, #0x18]
loc_0e7c:
	str r0, [r4, #0x10]!
	b loc_0f5c
loc_0e84:
	teq r6, #0x300
	beq loc_0f48
	ldr r0, [r5, #0x10]!
	ldr r0, [r0, #4]
loc_0e94:
	str r0, [r4, #0xc]!
	b loc_0f5c
loc_0e9c:
	teq r6, #0x100
	teqne r6, #0x200
	bne loc_0ee4
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	strb r0, [r5, #0x65]
	mov r0, r0, asr #8
	strb r0, [r5, #0x64]
	ldr r0, [r4, #0xe]
	mov r0, r0, lsr #16
	strb r0, [r5, #0x67]
	mov r0, r0, asr #8
	strb r0, [r5, #0x66]
	ldrb r0, [r4, #0x10]
	strb r0, [r5, #0x68]
	ldrb r0, [r4, #0x11]
	strb r0, [r5, #0x69]
	b loc_0f5c
loc_0ee4:
	teq r6, #0x300
	bne loc_0f0c
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_5034
	mov r1, sp
loc_0efc:
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x14
	b loc_0f5c
loc_0f0c:
	ldr r0, [r5, #0x64]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc]
	ldr r0, [r5, #0x66]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xf]
	mov r0, r0, asr #8
	strb r0, [r4, #0xe]
	ldrb r0, [r5, #0x68]
	strb r0, [r4, #0x10]
	ldrb r0, [r5, #0x69]
	strb r0, [r4, #0x11]
	b loc_0f5c
loc_0f48:
	mvn r7, #0
	b loc_0f5c
loc_0f50:
	mvn r7, #4
	b loc_0f5c
loc_0f58:
	mvn r7, #3
loc_0f5c:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

Method30:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, #0
	ldr ip, lit_1008
	teq r2, ip
	beq loc_10bc
	ldr lr, lit_100c
	mov r1, #1
	teq r2, lr
	ldrne ip, lit_1010
	teqne r2, ip
	beq loc_1058
	ldr ip, lit_1014
	teq r2, ip
	bne loc_1168
	ldr r2, [r0, #0x10]
	ldr ip, [r2, #0x50]
	ldr ip, [ip, #4]
	teq ip, #0x42
	bne loc_10b4
	teq r3, #0x100
	teqne r3, #0x200
	bne loc_1018
	ldr r3, [r4, #0xc]
	teq r3, #0
	ldrne ip, [r4, #0x10]
	movne ip, ip, asr #16
	teqne ip, #0
	beq loc_10b4
	str r3, [r2, #0x34]!
	ldr r2, [r4, #0x10]
	mov r2, r2, lsr #16
	ldr r3, [r0, #0x10]
	strb r2, [r3, #0x33]
	mov r2, r2, asr #8
	strb r2, [r3, #0x32]
	ldr r0, [r0, #0x10]
	strb r1, [r0, #0x56]
	b loc_116c
lit_1008:
	.word 0x69637674			; 'icvt'
lit_100c:
	.word 0x6965786e			; 'iexn'
lit_1010:
	.word 0x69657870			; 'iexp'
lit_1014:
	.word 0x69756473			; 'iuds'
loc_1018:
	teq r3, #0x300
	bne loc_1034
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_5378
	mov r1, sp
	b loc_111c
loc_1034:
	ldr r1, [r2, #0x32]
	mov r1, r1, lsr #16
	strb r1, [r4, #0x11]
	mov r1, r1, asr #8
	strb r1, [r4, #0x10]
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x34]
	str r0, [r4, #0xc]!
	b loc_116c
loc_1058:
	ldr ip, [r0, #0x10]
	ldr r6, [ip, #0x50]
	ldr r6, [r6, #4]
	teq r6, #0x41
	bne loc_10b4
	teq r3, #0x100
	teqne r3, #0x200
	bne loc_10b4
	ldrb r3, [ip, #0x20]
	teq r3, #1
	beq loc_10b4
	strb r1, [ip, #0x20]
	teq r2, lr
	movne r1, #0
	moveq r1, #1
	ldr r2, [r0, #0x10]
	strb r1, [r2, #0x21]
	ldr r0, [r0, #0x10]
	ldrb r1, [r0, #0x21]
	teq r1, #0
	ldrbeq r1, [r4, #0xc]
	strbeq r1, [r0, #0x22]
	b loc_116c
loc_10b4:
	mvn r5, #0
	b loc_116c
loc_10bc:
	teq r3, #0x100
	teqne r3, #0x200
	bne loc_1104
	ldr r1, [r4, #0xc]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x65]
	mov r1, r1, asr #8
	strb r1, [r0, #0x64]
	ldr r1, [r4, #0xe]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x67]
	mov r1, r1, asr #8
	strb r1, [r0, #0x66]
	ldrb r1, [r4, #0x10]
	strb r1, [r0, #0x68]
	ldrb r1, [r4, #0x11]
	strb r1, [r0, #0x69]
	b loc_116c
loc_1104:
	teq r3, #0x300
	bne loc_112c
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_5034
	mov r1, sp
loc_111c:
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x14
	b loc_116c
loc_112c:
	ldr r1, [r0, #0x64]
	mov r1, r1, lsr #16
	strb r1, [r4, #0xd]
	mov r1, r1, asr #8
	strb r1, [r4, #0xc]
	ldr r1, [r0, #0x66]
	mov r1, r1, lsr #16
	strb r1, [r4, #0xf]
	mov r1, r1, asr #8
	strb r1, [r4, #0xe]
	ldrb r1, [r0, #0x68]
	strb r1, [r4, #0x10]
	ldrb r0, [r0, #0x69]
	strb r0, [r4, #0x11]
	b loc_116c
loc_1168:
	mvn r5, #5
loc_116c:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

Method31:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, #0
	ldr ip, lit_11ec
	teq r2, ip
	beq loc_1260
	mov r1, #1
	ldr ip, lit_11f0
	teq r2, ip
	beq loc_1218
	ldr ip, lit_11f4
	teq r2, ip
	bne loc_130c
	ldr r2, [r0, #0x10]
	ldr ip, [r2, #0x50]
	ldr ip, [ip, #4]
	teq ip, #0x42
	bne loc_1238
	teq r3, #0x100
	teqne r3, #0x200
	beq loc_1238
	teq r3, #0x300
	bne loc_11f8
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_531c
	mov r1, sp
	b loc_12c0
lit_11ec:
	.word 0x69637674			; 'icvt'
lit_11f0:
	.word 0x69756473			; 'iuds'
lit_11f4:
	.word 0x69757373			; 'iuss'
loc_11f8:
	ldr r2, [r2, #0x48]
	mov r2, r2, lsr #16
	strb r2, [r4, #0x11]
	mov r2, r2, asr #8
	strb r2, [r4, #0x10]
	ldr r0, [r0, #0x10]
	strb r1, [r0, #0x54]
	b loc_1310
loc_1218:
	ldr r0, [r0, #0x10]
	ldr r2, [r0, #0x50]
	ldr r2, [r2, #4]
	teq r2, #0x42
	bne loc_1238
	teq r3, #0x100
	teqne r3, #0x200
	bne loc_1240
loc_1238:
	mvn r5, #0
	b loc_1310
loc_1240:
	teq r3, #0x300
	strbne r1, [r0, #0x55]
	bne loc_1310
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_5378
	mov r1, sp
	b loc_12c0
loc_1260:
	teq r3, #0x100
	teqne r3, #0x200
	bne loc_12a8
	ldr r1, [r4, #0xc]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x65]
	mov r1, r1, asr #8
	strb r1, [r0, #0x64]
	ldr r1, [r4, #0xe]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x67]
	mov r1, r1, asr #8
	strb r1, [r0, #0x66]
	ldrb r1, [r4, #0x10]
	strb r1, [r0, #0x68]
	ldrb r1, [r4, #0x11]
	strb r1, [r0, #0x69]
	b loc_1310
loc_12a8:
	teq r3, #0x300
	bne loc_12d0
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_5034
	mov r1, sp
loc_12c0:
	mov r0, r4
	bl CopyDataFrom__7TOptionFP7TOption
	add sp, sp, #0x14
	b loc_1310
loc_12d0:
	ldr r1, [r0, #0x64]
	mov r1, r1, lsr #16
	strb r1, [r4, #0xd]
	mov r1, r1, asr #8
	strb r1, [r4, #0xc]
	ldr r1, [r0, #0x66]
	mov r1, r1, lsr #16
	strb r1, [r4, #0xf]
	mov r1, r1, asr #8
	strb r1, [r4, #0xe]
	ldrb r1, [r0, #0x68]
	strb r1, [r4, #0x10]
	ldrb r0, [r0, #0x69]
	strb r0, [r4, #0x11]
	b loc_1310
loc_130c:
	mvn r5, #5
loc_1310:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x10]
	str r1, [r0, #0x18]
	str r1, [r0, #0x20]
	str r1, [r0, #0x24]
	str r1, [r0, #0x28]
	str r1, [r0, #0x2c]
	str r1, [r0, #0x30]
	str r1, [r0, #0x38]
	strb r1, [r0, #0x6a]
	str r1, [r0, #0x44]
	str r1, [r0, #0x4c]
	str r1, [r0, #0x50]
	ldr r1, lit_1358
	str r1, [r0, #0x6c]
	mov pc, lr
lit_1358:
	.word 0xffffc17b

Method34:
	mov r0, #0
	mov pc, lr

Method7:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	mov r7, #0x8e
	sub r7, r7, #0xeb00
	ldr r1, [r0, #4]!
	cmn r1, #1
	beq loc_13f0
	mov r0, r4
	bl sub_02b4
	cmn r0, #1
	beq loc_13f0
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_0260
	mov r5, r0
	ldr r0, [r0, #0x24]
	teq r0, #0
	moveq r6, #0x8d
	subeq r6, r6, #0xeb00
	beq loc_17ac
	ldr r0, [r5, #0x20]
	teq r0, #0
	beq loc_13f0
	mov r0, r4
	bl sub_359c
	movs r6, r0
	bne loc_17ac
	ldr r0, [r5, #8]
	ldr r0, [r0, #0xc]
	cmn r0, #1
	bne loc_13f8
loc_13f0:
	mov r6, r7
	b loc_17ac
loc_13f8:
	mov sb, #0x6a
	sub sb, sb, #0x3f00
	mov r6, sb
	mov r0, r4
	mov r2, #0xff
	mov r1, #0x31
	bl sub_4ef0
	movs r8, r0
	beq loc_17ac
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	mov r7, #0
	teq r0, #0x41
	bne loc_1458
	mov r0, r4
	bl sub_3f7c
	movs r6, r0
	bne loc_179c
	ldr r0, [r5, #0xc]!
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x2c]
	str r0, [r1, #0xc]!
	b loc_152c
loc_1458:
	teq r0, #0x42
	bne loc_152c
	mov r0, r4
	bl sub_48cc
	movs r6, r0
	bne loc_1780
	ldr r0, [r5, #0xc]!
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x4c]
	str r0, [r1, #0xc]!
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x4c]
	ldr r0, [r0, #0x14]
	ldr r5, lit_1614
	mov r1, r5
	bl NewNamedPtr
	str r0, [r4, #0x44]
	teq r0, #0
	beq loc_1764
	mov r1, r5
	mov r0, #0xc
	bl NewNamedPtr
	str r0, [r4, #0x4c]
	teq r0, #0
	beq loc_1750
	mov sl, #0x1c
	str sl, [r0]
	ldr r0, [r4, #0x4c]
	str sl, [r0, #4]!
	ldr r0, [r4, #0x4c]
	ldr r0, [r0]
	mov r1, r5
	bl NewNamedPtr
	ldr r1, [r4, #0x4c]
	str r0, [r1, #8]!
	teq r0, #0
	beq loc_173c
	mov r1, #8
	str r1, [r0]
	ldr r0, [r4, #0x4c]
	ldr r0, [r0, #8]
	str r1, [r0, #4]!
	mov r1, #0x14
	ldr r0, [r4, #0x4c]
	ldr r0, [r0, #8]
	str r1, [r0, #8]!
	ldr r0, [r4, #0x4c]
	ldr r0, [r0, #8]
	str r7, [r0, #0xc]!
	ldr r0, [r4, #0x4c]
	ldr r0, [r0, #8]
	str sl, [r0, #0x10]!
	str r7, [r4, #0x48]
loc_152c:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #0xc]
	cmn r1, #1
	bne loc_16b8
	mov r6, sb
	ldr r1, [r0, #4]!
	mov r0, r4
	mov r2, #0
	bl sub_4ef0
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x50]
	str r0, [r1, #0xc]!
	movs r1, r0
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	bmi loc_1724
	ldr r1, [r0, #4]!
	mov r0, r4
	mov r2, #1
	bl sub_4ef0
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x50]
	str r0, [r1, #0x10]!
	movs r1, r0
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	bmi loc_170c
	ldr r1, [r0, #4]!
	mov r0, r4
	mov r2, #2
	bl sub_4ef0
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x50]
	str r0, [r1, #0x14]!
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x50]
	cmp r0, #0
	blt sub_16f4
	ldr r1, [r1, #0xc]
	mov r2, r8
	mov r0, r4
	bl sub_4f38
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x50]
	str r0, [r1, #8]!
	mov r6, r0
	movs r1, r0
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	bmi loc_16dc
	ldr r1, [r0, #4]
	teq r1, #0x41
	bne loc_1618
	ldr r1, [r0, #0x10]!
	mov r0, r4
	bl sub_17bc
	b loc_1634
lit_1614:
	.word 0x43452020			; 'CE  '
loc_1618:
	teq r1, #0x42
	movne r6, #0x69
	subne r6, r6, #0x3f00
	bne loc_16dc
	ldr r1, [r0, #0x10]!
	mov r0, r4
	bl sub_184c
loc_1634:
	movs r6, r0
	bne loc_16dc
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #0x10]!
	mov r0, r4
	mov r2, #1
	bl sub_1934
	movs r6, r0
	bne loc_16dc
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #0xc]!
	mov r0, r4
	bl sub_0234
	str r7, [r0, #0x54]!
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #0x10]!
	mov r0, r4
	bl sub_0234
	str r7, [r0, #0x54]!
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #0x14]!
	mov r0, r4
	bl sub_0234
	str r7, [r0, #0x54]!
	mov r0, #1
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x50]
	str r0, [r1]
	b loc_16c4
loc_16b8:
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
loc_16c4:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x10000
	mov r6, #0
	str r1, [r0]
	b loc_179c
loc_16dc:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	ldr r2, [r0, #0x10]!
	mov r0, r4
	bl sub_4f24

sub_16f4:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	ldr r2, [r0, #0xc]!
	mov r0, r4
	bl sub_4f24
loc_170c:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	ldr r2, [r0, #8]!
	mov r0, r4
	bl sub_4f24
loc_1724:
	ldr r0, [r4, #0x4c]
	teq r0, #0
	beq loc_1750
	ldr r0, [r0, #8]
	teq r0, #0
	blne free
loc_173c:
	ldr r0, [r4, #0x4c]
	teq r0, #0
	beq loc_1750
	bl free
	str r7, [r4, #0x4c]
loc_1750:
	ldr r0, [r4, #0x44]
	teq r0, #0
	beq loc_1764
	bl free
	str r7, [r4, #0x44]
loc_1764:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x4c]
	teq r0, #0
	beq loc_1780
	bl free
	ldr r0, [r4, #0x10]
	str r7, [r0, #0x4c]!
loc_1780:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x2c]
	teq r0, #0
	beq loc_179c
	bl free
	ldr r0, [r4, #0x10]
	str r7, [r0, #0x2c]!
loc_179c:
	mov r2, r8
	mov r0, r4
	mov r1, #0x31
	bl sub_4f24
loc_17ac:
	mov r1, r6
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, lr}
	b loc_543c

sub_17bc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0xc
	mov r2, #0x200
	ldr r3, [r0, #0x10]
	ldr r3, [r3, #0x2c]
	str r2, [r3]
	ldr r2, [r0, #0x10]
	ldr r3, [r2, #0x50]
	ldr r3, [r3, #8]
	ldr r2, [r2, #0x2c]
	str r3, [r2, #4]!
	mov r2, #0
	ldr r3, [r0, #0x10]
	ldr r3, [r3, #0x2c]
	str r2, [r3, #8]!
	mov r2, #0x4c
	str r2, [sp]
	str r2, [sp, #4]
	ldr r2, [r0, #0x10]
	ldr r2, [r2, #0x2c]
	mov r3, #0
	str r2, [sp, #8]
	stmdb sp!, {r3}
	add r2, sp, #4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_1840
	teq r0, #0
	beq loc_1848
loc_1840:
	mov r0, #0x9a
	sub r0, r0, #0xeb00
loc_1848:
	ldmdb fp, {fp, sp, pc}

sub_184c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #0xc
	mov r3, #0x200
	ldr r2, [r0, #0x10]
	ldr r2, [r2, #0x4c]
	str r3, [r2]
	ldr r2, [r0, #0x10]
	ldr r3, [r2, #0x50]
	ldr r3, [r3, #8]
	ldr r2, [r2, #0x4c]
	str r3, [r2, #4]!
	mov r2, #0x1c
	str r2, [sp]
	str r2, [sp, #4]
	ldr r2, [r0, #0x10]
	ldr r2, [r2, #0x4c]
	mov r3, #0
	str r2, [sp, #8]
	stmdb sp!, {r3}
	add r2, sp, #4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_18c0
	teq r0, #0
	beq loc_18c8
loc_18c0:
	mov r0, #0x9a
	sub r0, r0, #0xeb00
loc_18c8:
	ldmdb fp, {fp, sp, pc}

Method8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r1, #0x79
	sub r1, r1, #0x3f00
	ldr r0, [r0, #0x10]
	teq r0, #0
	ldrne r2, [r0, #0x10]
	andne r2, r2, #0x10000
	teqne r2, #0
	beq loc_1928
	ldr r2, [r0]
	cmn r2, #1
	beq loc_1924
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	mvn r0, #0
	ldr r1, [r4, #0x10]
	str r0, [r1]
loc_1924:
	mov r1, #0
loc_1928:
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b loc_5448

sub_1934:
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
	bl sub_0200
	ldr r0, [sp, #0x64]
	tst r0, #0xb
	beq loc_1a00
	str sp, [sp, #0x5c]
	mov r0, #0x54
	str r0, [sp, #0x54]
	mov r3, #0
	str r0, [sp, #0x58]
	stmdb sp!, {r3}
	add r2, sp, #0x58
	mov r1, r5
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	teq r0, #0
	bne loc_1a00
	teq r6, #0
	beq loc_1a00
	teq r6, #1
	beq loc_19f0
	teq r6, #2
	bne loc_1a00
	add r1, sp, #0x54
	mov r0, r4
	bl sub_1a08
	b loc_19fc
loc_19f0:
	add r1, sp, #0x54
	mov r0, r4
	bl sub_1a34
loc_19fc:
	mov r7, r0
loc_1a00:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_1a08:
	mov r0, #0
	ldr r1, [r1, #8]
	ldr r1, [r1]
	teq r1, #0x12
	moveq r0, #0x4d
	subeq r0, r0, #0xeb00
	moveq pc, lr
	teq r1, #0x13
	movne r0, #0x69
	subne r0, r0, #0xeb00
	mov pc, lr

sub_1a34:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0
	ldr r1, [r1, #8]
	ldr r3, [r1]
	sub r3, r3, #0xb
	cmp r3, #0xc
	addls pc, pc, r3, lsl #2
	b loc_1aa0
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1a90
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
	b loc_1aa8
loc_1a90:
	ldr r1, [r1, #8]
	bl sub_1ab0
	mov r2, r0
	b loc_1aa8
loc_1aa0:
	mov r2, #0x6a
	sub r2, r2, #0xeb00
loc_1aa8:
	mov r0, r2
	ldmdb fp, {fp, sp, pc}

sub_1ab0:
	add r0, r1, #0x26
	cmp r0, #0x25
	addls pc, pc, r0, lsl #2
	b loc_1cc8
	b loc_1ca4
	b loc_1cbc
	b loc_1cb0
	b loc_1c98
	b loc_1c8c
	b loc_1c80
	b loc_1c74
	b loc_1c68
	b loc_1c5c
	b loc_1cc8
	b loc_1c50
	b loc_1c44
	b loc_1cc8
	b loc_1cc8
	b loc_1c38
	b loc_1cc8
	b loc_1c2c
	b loc_1c20
	b loc_1c14
	b loc_1cc8
	b loc_1c08
	b loc_1cc8
	b loc_1bfc
	b loc_1cc8
	b loc_1bf0
	b loc_1be4
	b loc_1bd8
	b loc_1bcc
	b loc_1bc0
	b loc_1bb4
	b loc_1ba8
	b loc_1b9c
	b loc_1b90
	b loc_1b84
	b loc_1b78
	b loc_1b6c
	b loc_1b60

sub_1b54:
	mov r0, #0x89
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1b60:
	mov r0, #0x188
	sub r0, r0, #0xec00
	mov pc, lr
loc_1b6c:
	ldr r0, lit_1b74
	mov pc, lr
lit_1b74:
	.word 0xffff1587
loc_1b78:
	mov r0, #0x86
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1b84:
	mov r0, #0x85
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1b90:
	mov r0, #0x184
	sub r0, r0, #0xec00
	mov pc, lr
loc_1b9c:
	ldr r0, lit_1ba4
	mov pc, lr
lit_1ba4:
	.word 0xffff1583
loc_1ba8:
	mov r0, #0x82
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1bb4:
	mov r0, #0x81
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1bc0:
	mov r0, #0x1580
	sub r0, r0, #0x10000
	mov pc, lr
loc_1bcc:
	ldr r0, lit_1bd4
	mov pc, lr
lit_1bd4:
	.word 0xffff157f
loc_1bd8:
	mvn r0, #0x81
	sub r0, r0, #0xea00
	mov pc, lr
loc_1be4:
	mvn r0, #0x82
	sub r0, r0, #0xea00
	mov pc, lr
loc_1bf0:
	mvn r0, #0x83
	sub r0, r0, #0xea00
	mov pc, lr
loc_1bfc:
	ldr r0, lit_1c04
	mov pc, lr
lit_1c04:
	.word 0xffff157b
loc_1c08:
	mov r0, #0x7a
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1c14:
	mov r0, #0x79
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1c20:
	mov r0, #0x178
	sub r0, r0, #0xec00
	mov pc, lr
loc_1c2c:
	ldr r0, lit_1c34
	mov pc, lr
lit_1c34:
	.word 0xffff1577
loc_1c38:
	mov r0, #0x76
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1c44:
	mov r0, #0x75
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1c50:
	mov r0, #0x174
	sub r0, r0, #0xec00
	mov pc, lr
loc_1c5c:
	ldr r0, lit_1c64
	mov pc, lr
lit_1c64:
	.word 0xffff1573
loc_1c68:
	mov r0, #0x72
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1c74:
	ldr r0, lit_1c7c
	mov pc, lr
lit_1c7c:
	.word 0xffff159f
loc_1c80:
	mov r0, #0x71
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1c8c:
	mov r0, #0x570
	sub r0, r0, #0xf000
	mov pc, lr
loc_1c98:
	ldr r0, lit_1ca0
	mov pc, lr
lit_1ca0:
	.word 0xffff156f
loc_1ca4:
	mov r0, #0x16c
	sub r0, r0, #0xec00
	mov pc, lr
loc_1cb0:
	mov r0, #0x6e
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1cbc:
	mov r0, #0x6d
	sub r0, r0, #0xeb00
	mov pc, lr
loc_1cc8:
	mov r0, #0x168
	sub r0, r0, #0xec00
	mov pc, lr

Method9:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x10]
	tst r1, #4
	movne r1, #0x6e
	subne r1, r1, #0x3f00
	bne loc_1d84
	ldr r1, [r0, #0x10]!
	orr r1, r1, #2
	str r1, [r0]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	mov r2, #0xff
	bl sub_4ef0
	ldr r1, [r4, #0x10]
	str r0, [r1]
	mov r1, r0
	movs r2, r0
	ldr r0, [r4, #0x10]
	movmi r1, #0x6a
	submi r1, r1, #0x3f00
	bmi loc_1d78
	ldr r2, [r0, #0x50]
	ldr r2, [r2, #4]
	teq r2, #0x41
	moveq r0, r4
	moveq r2, #0
	ldmdbeq fp, {r4, fp, sp, lr}
	beq loc_1f18
	teq r2, #0x42
	moveq r0, r4
	moveq r1, #0
	ldmdbeq fp, {r4, fp, sp, lr}
	beq loc_22f4
	mov r1, #0x69
	sub r1, r1, #0x3f00
loc_1d78:
	ldr r2, [r0, #0x10]!
	bic r2, r2, #2
	str r2, [r0]
loc_1d84:
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b sub_5454

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	teq r0, #0
	beq loc_1ec4
	mvn r5, #0
	ldr r2, [r0]
	cmn r2, #1
	beq loc_1dd4
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	str r5, [r0]
loc_1dd4:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	teq r0, #0
	beq loc_1e9c
	ldr r1, [r0]
	sub r1, r1, #1
	str r1, [r0]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	cmp r1, #0
	bgt loc_1e9c
	ldr r1, [r0, #0xc]
	cmn r1, #1
	beq loc_1e44
	ldr r2, [r0, #8]!
	mov r0, r4
	bl sub_4f34
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r2, [r0, #0xc]
	cmn r2, #1
	beq loc_1e44
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	str r5, [r0, #0xc]!
loc_1e44:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r2, [r0, #0x10]
	cmn r2, #1
	beq loc_1e70
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	str r5, [r0, #0x10]!
loc_1e70:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r2, [r0, #0x14]
	cmn r2, #1
	beq loc_1e9c
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	str r5, [r0, #0x14]!
loc_1e9c:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x2c]
	teq r0, #0
	blne free
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x4c]
	teq r0, #0
	blne free
	ldr r0, [r4, #0x10]
	bl __dl__FPv
loc_1ec4:
	ldr r0, [r4, #0x28]
	teq r0, #0
	blne free
	ldr r0, [r4, #0x44]
	teq r0, #0
	blne free
	ldr r0, [r4, #0x4c]
	teq r0, #0
	beq loc_1efc
	ldr r0, [r0, #8]
	teq r0, #0
	blne free
	ldr r0, [r4, #0x4c]
	bl free
loc_1efc:
	ldr r0, [r4, #0x18]
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	bl sub_5414
	mov r0, #0
	str r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_1f18:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r0, #6
	str r0, [sp, #-0x24]!
	mov r0, #8
	str r0, [sp, #4]
	mov r0, #0x10
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_0260
	mov r1, #2
	strb r1, [sp, #0x11]
	mov r1, #0
	strb r1, [sp, #0x10]
	ldr r0, [r0, #0xc]
	str r0, [sp, #0x14]
	ldr r0, [r4, #0x10]
	ldrb r2, [r0, #0x57]
	teq r2, #1
	bne loc_1fa4
	teq r6, #0
	beq loc_1fa4
	ldr r0, [r0, #0x48]
	mov r0, r0, lsr #16
	strb r0, [sp, #0x13]
	mov r0, r0, asr #8
	strb r0, [sp, #0x12]
	b loc_1fac
loc_1fa4:
	strb r1, [sp, #0x13]
	strb r1, [sp, #0x12]
loc_1fac:
	str sp, [sp, #0x20]
	mov r0, #0x18
	str r0, [sp, #0x18]
	mov r3, #0
	str r0, [sp, #0x1c]
	stmdb sp!, {r3}
	add r2, sp, #0x1c
	mov r1, r5
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_2000
	teq r0, #0
	bne loc_201c
	mov r1, r5
	mov r0, r4
	mov r2, #0
	bl sub_2044
	b loc_2040
loc_2000:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #3
	str r1, [r0, #4]!
	b loc_2040
loc_201c:
	mov r3, #0x194
	sub r3, r3, #0xec00
	mov r2, #0
	stmdb sp!, {r2, r3}
	mov r1, r5
	mov r0, r4
	mov r3, #0
	bl sub_2108
	add sp, sp, #8
loc_2040:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2044:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #0x34
	teq r2, #0
	bne loc_20e4
	mov r0, #0x28
	str r0, [sp, #0x28]
	str r0, [sp, #0x2c]
	str sp, [sp, #0x30]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x2c
	mov r1, r4
	mov r0, r5
	bl sub_0164
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	beq loc_20c8
	teq r0, #0
	ldrne r6, lit_20c4
	bne loc_20e4
	mov r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	add r2, sp, #0x30
	mov r1, r4
	mov r0, r5
	b loc_20fc
lit_20c4:
	.word 0xffff158b
loc_20c8:
	mov r1, r4
	mov r0, r5
	bl sub_0234
	teq r0, #0
	movne r1, #4
	strne r1, [r0, #0x2c]!
	bne loc_2104
loc_20e4:
	mov r3, r6
	mov r2, #0
	stmdb sp!, {r2, r3}
	mov r1, r4
	mov r0, r5
	mov r3, #0
loc_20fc:
	bl sub_2108
	add sp, sp, #8
loc_2104:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2108:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r1, [fp, #8]
	teq r1, #0
	bne loc_2178
	mov r0, #0x194
	sub r0, r0, #0xec00
	ldr r1, [r2, #8]
	teq r1, #0
	beq loc_2174
	ldr r3, [r1]
	teq r3, #0x11
	bne loc_2164
	ldr r0, [r4, #0x10]
	ldr r0, [r0]
	teq r0, r5
	moveq r0, r4
	bleq sub_21c4
	mov r1, #0
	b loc_2178
loc_2164:
	teq r3, #0x12
	moveq r1, r2
	moveq r0, r4
	bleq sub_1a34
loc_2174:
	mov r1, r0
loc_2178:
	ldr r0, [r4, #0x10]
	add r2, r0, #0x10
	ldr r0, [r2]
	bic r0, r0, #2
	teq r1, #0
	str r0, [r2]
	bne loc_21a0
	orr r0, r0, #4
	ldr r2, [r4, #0x10]
	str r0, [r2, #0x10]!
loc_21a0:
	ldr r0, [r4, #0x10]
	ldr r0, [r0]
	teq r0, r5
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne loc_2a5c
	ldreq r0, [r4, #0x18]!
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq sub_5454

sub_21c4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__19TCommToolOptionInfoFv
	mov r6, sp
	ldr r0, [r5, #0x18]
	bl sub_55ec
	ldmia r0, {r0, r1, r2, r3, ip, lr}
	stmia r6, {r0, r1, r2, r3, ip, lr}
	ldr r0, [sp, #0xc]
	teq r0, #0
	ldrne r0, [sp, #0x14]
	teqne r0, #0
	beq loc_2258
	ldr r0, [r5, #0x10]!
	ldrb r0, [r0, #0x57]
	teq r0, #1
	bne loc_2258
	ldr r0, [sp, #0x14]
	ldr r1, lit_225c
	bl FindOption__15TOptionIteratorFUl
	movs r1, r0
	ldrne r0, [r4, #8]
	teqne r0, #0
	ldrne r2, [r4, #4]
	teqne r2, #0
	beq loc_2258
	add r0, r0, r4
	ldr r0, [r0, #2]
	mov r0, r0, lsr #16
	strb r0, [r1, #0xd]
	mov r0, r0, asr #8
	strb r0, [r1, #0xc]
loc_2258:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_225c:
	.word 0x696c7074			; 'ilpt'

sub_2260:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__19TCommToolOptionInfoFv
	mov r5, sp
	ldr r0, [r4, #0x18]
	bl sub_55ec
	ldmia r0, {r0, r1, r2, r3, ip, lr}
	stmia r5, {r0, r1, r2, r3, ip, lr}
	ldr r0, [sp, #0xc]
	teq r0, #0
	ldrne r0, [sp, #0x14]
	teqne r0, #0
	beq loc_22ec
	ldr r0, [r4, #0x10]
	ldrb r0, [r0, #0x56]
	teq r0, #1
	bne loc_22ec
	ldr r0, [sp, #0x14]
	ldr r1, lit_22f0
	bl FindOption__15TOptionIteratorFUl
	teq r0, #0
	beq loc_22ec
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x32]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x11]
	mov r1, r1, asr #8
	strb r1, [r0, #0x10]
	ldr r1, [r4, #0x10]!
	ldr r1, [r1, #0x34]
	str r1, [r0, #0xc]!
loc_22ec:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_22f0:
	.word 0x69747273			; 'itrs'
loc_22f4:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #6
	str r0, [sp, #-0x24]!
	mov r0, #8
	str r0, [sp, #4]
	mov r0, #0x10
	str r0, [sp, #8]
	mov r0, #0
	mov r1, #2
	str r0, [sp, #0xc]
	strb r1, [sp, #0x11]
	strb r0, [sp, #0x10]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x4c]
	ldr r0, [r0, #0xc]
	str r0, [sp, #0x14]
	ldr r0, [r4, #0x10]
	ldrb r1, [r0, #0x57]
	teq r1, #0
	beq loc_235c
	ldrb r0, [r0, #0x58]
	teq r0, #0
	beq loc_2374
loc_235c:
	mov r0, r4
	bl sub_02e0
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x49]
	mov r0, r0, asr #8
	strb r0, [r1, #0x48]
loc_2374:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x48]
	mov r0, r0, lsr #16
	strb r0, [sp, #0x13]
	mov r0, r0, asr #8
	strb r0, [sp, #0x12]
	str sp, [sp, #0x20]
	mov r0, #0x18
	str r0, [sp, #0x18]
	mov r3, #0
	str r0, [sp, #0x1c]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #0x1c
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_23e8
	teq r0, #0
	bne loc_2404
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0
	bl sub_2044
	b loc_2414
loc_23e8:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #3
	str r1, [r0, #4]!
	b loc_2414
loc_2404:
	mov r1, #0x194
	sub r1, r1, #0xec00
	ldr r0, [r4, #0x18]!
	bl sub_5454
loc_2414:
	ldmdb fp, {r4, fp, sp, pc}

Method10:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x10]
	tst r1, #4
	moveq r1, #0x6d
	subeq r1, r1, #0x3f00
	beq loc_2474
	ldr r2, [r0]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	mvn r1, #0
	ldr r0, [r4, #0x10]
	str r1, [r0]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #4
	str r1, [r0]
	mov r1, #0
loc_2474:
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b loc_5460

Method11:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__17TCMOCTConnectInfoFv
	mov r0, r4
	mov r1, #2
	bl sub_0310
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x10]
	tst r0, #4
	moveq r5, #0x6d
	subeq r5, r5, #0x3f00
	beq loc_2560
	tst r0, #0x10
	mvnne r5, #0x3e80
	bne loc_2560
	tst r0, #0x20
	movne r5, #0x178
	subne r5, r5, #0x4000
	bne loc_2560
	add r0, r1, #0x10
	ldr r1, [r0]
	orr r1, r1, #0x10
	str r1, [r0]
	mov r0, #1
	strb r0, [sp, #0xc]
	mov r0, #0
	strb r0, [sp, #0xd]
	strb r0, [sp, #0xe]
	mov r0, #0x2580
	str r0, [sp, #0x14]
	mov r1, sp
	ldr r0, [r4, #0x18]
	bl sub_55b0
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x50]
	ldr r1, [r1, #4]
	teq r1, #0x41
	bne loc_253c
	add r2, r0, #0x30
	mov r0, r4
	ldmia r2, {r1, r2}
	bl sub_258c
	b loc_2588
loc_253c:
	teq r1, #0x42
	bne loc_2558
	add r2, r0, #0x30
	mov r0, r4
	ldmia r2, {r1, r2}
	bl sub_28f0
	b loc_2588
loc_2558:
	mov r5, #0x69
	sub r5, r5, #0x3f00
loc_2560:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x10
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	bl sub_546c
loc_2588:
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_258c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x28
	ldr r0, [r0, #0x10]
	ldrb r0, [r0, #0x56]
	teq r0, #0
	moveq r5, #0x7a
	subeq r5, r5, #0x3f00
	beq loc_265c
	mov r0, #0
	mov r3, #8
	stmia sp, {r0, r3}
	mov r3, #0x14
	str r0, [sp, #0xc]
	mov r0, #0x1c
	str r0, [sp, #0x10]
	str r3, [sp, #8]
	add r3, sp, r3
	stmia r3, {r1, r2}
	str sp, [sp, #0x24]
	str r0, [sp, #0x1c]
	mov r3, #0
	str r0, [sp, #0x20]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #0x20
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_2638
	teq r0, #0
	bne loc_2654
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0
	bl sub_2688
	b loc_2684
loc_2638:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #5
	str r1, [r0, #4]!
	b loc_2684
loc_2654:
	mov r5, #0x96
	sub r5, r5, #0xeb00
loc_265c:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x10
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	bl sub_546c
loc_2684:
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_2688:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0x34
	mov r6, #0x96
	sub r6, r6, #0xeb00
	teq r2, #0
	bne loc_272c
	mov r0, #0x28
	str r0, [sp, #0x28]
	str r0, [sp, #0x2c]
	str sp, [sp, #0x30]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x2c
	mov r1, r5
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	beq loc_2714
	teq r0, #0
	bne loc_272c
	mov r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	add r2, sp, #0x30
	mov r1, r5
	mov r0, r4
	bl sub_2768
	add sp, sp, #8
	b loc_2764
loc_2714:
	mov r1, r5
	mov r0, r4
	bl sub_0234
	teq r0, #0
	bne loc_275c
	ldr r6, lit_2758
loc_272c:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x10
	str r1, [r0]
	mov r1, r6
	ldr r0, [r4, #0x18]!
	bl sub_546c
	b loc_2764
lit_2758:
	.word 0xffffc177
loc_275c:
	mov r1, #6
	str r1, [r0, #0x2c]!
loc_2764:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2768:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	movs r5, r2
	mov r7, #0x96
	sub r7, r7, #0xeb00
	ldr r1, [fp, #8]
	ldrne r0, [r5, #8]
	teqne r0, #0
	beq loc_2830
	ldr r0, [r0]
	teq r0, #0x12
	bne loc_27b8
	mov r1, r5
	mov r0, r4
	bl sub_1a34
	mov r7, r0
	b loc_2830
loc_27b8:
	teq r0, #0x13
	teqeq r1, #0
	bne loc_2830
	mov r3, #0
	stmdb sp!, {r3}
	mov r2, r5
	mov r1, r6
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	beq loc_2814
	teq r0, #0
	bne loc_2830
	mov r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	mov r2, r5
	mov r1, r6
	mov r0, r4
	bl sub_285c
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_2814:
	mov r1, r6
	mov r0, r4
	bl sub_0234
	teq r0, #0
	movne r1, #7
	strne r1, [r0, #0x2c]!
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
loc_2830:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x10
	str r1, [r0]
	mov r1, r7
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_546c

sub_285c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0x96
	sub r5, r5, #0xeb00
	teq r2, #0
	ldr r0, [fp, #8]
	ldrne r1, [r2, #8]!
	teqne r1, #0
	beq loc_28c0
	ldr r1, [r1]
	cmp r0, #0
	bne loc_28b4
	teq r1, #0xc
	bne loc_28b8
	mov r5, #0
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x20
	str r1, [r0]
	b loc_28cc
loc_28b4:
	bne loc_28c0
loc_28b8:
	teq r1, #0xd
	ldreq r5, lit_28ec
loc_28c0:
	mov r0, r4
	mov r1, #0
	bl sub_0310
loc_28cc:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x10
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_546c
lit_28ec:
	.word 0xffffc173

sub_28f0:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r1, [r0, #0x10]
	ldr r2, [r1, #0x10]!
	bic r2, r2, #0x10
	str r2, [r1]
	orr r2, r2, #0x20
	ldr r1, [r0, #0x10]
	str r2, [r1, #0x10]!
	ldr r0, [r0, #0x18]
	mov r1, #0
	ldmdb fp, {fp, sp, lr}
	b sub_546c

Method12:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r1, #2
	bl sub_0310
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x10]
	tst r0, #4
	moveq r5, #0x6d
	subeq r5, r5, #0x3f00
	beq loc_29b8
	tst r0, #8
	mvnne r5, #0x3e80
	bne loc_29b8
	tst r0, #0x20
	movne r5, #0x178
	subne r5, r5, #0x4000
	bne loc_29b8
	add r0, r1, #0x10
	ldr r1, [r0]
	orr r1, r1, #8
	str r1, [r0]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	teq r0, #0x41
	moveq r0, r4
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq loc_29e4
	teq r0, #0x42
	moveq r0, r4
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq loc_2e58
	mov r5, #0x69
	sub r5, r5, #0x3f00
loc_29b8:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_5478
loc_29e4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	mov r2, #0xff
	bl sub_4ef0
	ldr r1, [r4, #0x10]
	str r0, [r1, #8]!
	movs r1, r0
	movpl r0, r4
	movpl r2, #1
	ldmdbpl fp, {r4, r5, fp, sp, lr}
	bpl loc_1f18
	mov r5, #0x6a
	sub r5, r5, #0x3f00
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_5478
loc_2a5c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r5, r1
	sub sp, sp, #0x34
	bne loc_2b10
	mov r0, #0x28
	str r0, [sp, #0x28]
	str r0, [sp, #0x2c]
	str sp, [sp, #0x30]
	mov r3, #0
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #0x2c
	ldr r1, [r0, #8]!
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	beq loc_2aec
	teq r0, #0
	ldrne r5, lit_2ae8
	bne loc_2b10
	mov r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #0x30
	ldr r1, [r0, #8]!
	mov r0, r4
	bl sub_2b64
	add sp, sp, #8
	b loc_2b5c
lit_2ae8:
	.word 0xffff158f
loc_2aec:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #8]!
	mov r0, r4
	bl sub_0234
	teq r0, #0
	movne r1, #0xd
	strne r1, [r0, #0x2c]!
	bne loc_2b5c
	ldr r5, lit_2b60
loc_2b10:
	ldr r0, [r4, #0x10]
	ldr r2, [r0, #8]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	mvn r1, #0
	ldr r0, [r4, #0x10]
	str r1, [r0, #8]!
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	bl sub_5478
loc_2b5c:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2b60:
	.word 0xffffc177

sub_2b64:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r0, r2
	ldr r2, [fp, #8]
	sub sp, sp, #0xc
	ldrne r0, [r0, #8]
	teqne r0, #0
	moveq r5, #0x96
	subeq r5, r5, #0xeb00
	beq loc_2c7c
	ldr r1, [r0]
	ldr r5, lit_2c50
	cmp r2, #0
	bne loc_2c70
	teq r1, #0xb
	bne loc_2c74
	ldr r1, [r0, #0x14]
	ldr r2, [r4, #0x10]
	str r1, [r2, #0xc]!
	ldr r1, [r4, #0x10]
	add r1, r1, #0x30
	add r0, r0, #0x18
	ldmia r0, {r3, ip}
	stmia r1, {r3, ip}
	mov r0, #1
	str r0, [sp, #-0x14]!
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0xc]
	str r0, [sp, #0x10]
	str sp, [sp, #0x1c]
	mov r0, #0x14
	str r0, [sp, #0x14]
	mov r3, #0
	str r0, [sp, #0x18]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #0x18
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_2c54
	teq r0, #0
	addne sp, sp, #0x14
	bne loc_2c7c
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0
	bl sub_2cac
	b loc_2c6c
lit_2c50:
	.word 0xffff158f
loc_2c54:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #0xe
	str r1, [r0, #4]!
loc_2c6c:
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_2c70:
	bne loc_2c7c
loc_2c74:
	teq r1, #0xd
	ldreq r5, lit_2ca8
loc_2c7c:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	bl sub_5478
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2ca8:
	.word 0xffffc173

sub_2cac:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	movs r5, r2
	sub sp, sp, #0x34
	bne loc_2d58
	mov r0, #0x28
	str r0, [sp, #0x28]
	str r0, [sp, #0x2c]
	str sp, [sp, #0x30]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x2c
	mov r1, r6
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	mov r5, r0
	cmn r0, #6
	cmnne r0, #1
	beq loc_2d3c
	teq r0, #0
	movne r5, #0x8a
	subne r5, r5, #0xeb00
	bne loc_2d58
	mov r3, #0
	mov r2, #0
	stmdb sp!, {r2, r3}
	add r2, sp, #0x30
	mov r1, r6
	mov r0, r4
	bl sub_2d84
	add sp, sp, #8
	b loc_2d80
loc_2d3c:
	mov r1, r6
	mov r0, r4
	bl sub_0234
	teq r0, #0
	movne r1, #0xf
	strne r1, [r0, #0x2c]!
	bne loc_2d80
loc_2d58:
	mov r0, r4
	mov r1, #0
	bl sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	bl sub_5478
loc_2d80:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2d84:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r1, [fp, #8]
	ldr r0, [r2, #8]
	ldr r0, [r0]
	cmp r1, #0
	bne loc_2dd0
	teq r0, #0x13
	bne loc_2dd4
	mov r5, #0
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x20
	str r1, [r0]
	mov r0, r4
	bl sub_2260
	b loc_2e00
loc_2dd0:
	bne loc_2de0
loc_2dd4:
	teq r0, #0x12
	beq loc_2df0
	b loc_2de4
loc_2de0:
	bne loc_2df0
loc_2de4:
	teq r0, #0xd
	ldreq r5, lit_2e54
	beq loc_2e00
loc_2df0:
	mov r1, r2
	mov r0, r4
	bl sub_1a34
	mov r5, r0
loc_2e00:
	ldr r0, [r4, #0x10]
	ldr r2, [r0, #8]
	ldr r0, [r0, #0x50]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_4f24
	mvn r0, #0
	ldr r1, [r4, #0x10]
	teq r5, #0
	str r0, [r1, #8]!
	movne r0, r4
	movne r1, #0
	blne sub_0310
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #8
	str r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_5478
lit_2e54:
	.word 0xffffc173
loc_2e58:
	ldr r1, [r0, #0x10]
	ldr r2, [r1, #0x10]!
	orr r2, r2, #0x20
	str r2, [r1]
	bic r2, r2, #8
	ldr r1, [r0, #0x10]
	str r2, [r1, #0x10]!
	ldr r0, [r0, #0x18]
	mov r1, #0
	b sub_5478

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0xe9
	sub r5, r5, #0x2800
	add r0, r0, #0x14
	stmia r0, {r1, r2, r3}
	sub r0, r0, #0x14
	mov r0, #0
	bl sub_00fc
	str r0, [r4, #0x10]
	teq r0, #0
	beq loc_2fc0
	mov r1, #0
	strb r1, [r0, #0x56]
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x57]
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x55]
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x54]
	ldr r0, [r4, #0x10]
	str r1, [r0, #0x18]!
	sub sp, sp, #0x40
	add r0, sp, #0x38
	bl __ct__9TUGestaltFv
	mov r2, sp
	add r0, sp, #0x38
	mov r3, #0x38
	mov r1, #0x1000000
	add r1, r1, #3
	bl Gestalt__9TUGestaltFUlPvT1
	teq r0, #0
	bne loc_2fac
	mov lr, #2
	add lr, lr, #0x20000
	mov r3, #0x3000
	add r3, r3, #0x10000000
	ldmib sp, {r0, r2}
	teq r2, lr
	ldr r1, [sp, #0xc]
	bne loc_2f40
	teq r1, #0x8000
	bne loc_2f50
	teq r0, r3
	beq loc_2f98
	b loc_2f74
loc_2f40:
	mov lr, #2
	add lr, lr, #0x20000
	teq r2, lr
	bne loc_2f64
loc_2f50:
	teq r1, #0x18000
	bne loc_2f6c
	teq r0, r3
	bne loc_2fac
	b loc_2f98
loc_2f64:
	teq r2, lr
	bne loc_2f84
loc_2f6c:
	teq r1, #0x8000
	bne loc_2fac
loc_2f74:
	add ip, r0, #0xf0000000
	teq ip, #0x4000
	bne loc_2fac
	b loc_2f98
loc_2f84:
	sub ip, r2, #0x20000
	teq ip, #3
	teqeq r1, #0x38000
	teqeq r0, r3
	bne loc_2fac
loc_2f98:
	ldr r0, [r4, #0x18]!
	bl sub_55e0
	sub r0, r0, #8
	ldr r1, lit_2fc8
	str r1, [r0, #0x1b4]!
loc_2fac:
	add r0, sp, #0x38
	mov r1, #0
	bl __dt__8TUObjectFv
	add sp, sp, #0x40
	mov r5, #0
loc_2fc0:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2fc8:
	.word 0x696e6574			; 'inet'

Method13:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__17TCMOCTConnectInfoFv
	mov r0, #0
	strb r0, [sp, #0xc]
	strb r0, [sp, #0xd]
	strb r0, [sp, #0xe]
	mov r0, #0x2580
	str r0, [sp, #0x14]
	mov r1, sp
	ldr r0, [r4, #0x18]
	bl sub_55b0
	mov r1, #0
	ldr r0, [r4, #0x18]!
	bl sub_5484
	ldmdb fp, {r4, fp, sp, pc}

Method15:
	b loc_3020
loc_3020:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x25]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x400
	str r1, [r0]
	mov r0, r4
	bl Method26
	mov r0, r4
	bl Method22
	mov r0, r4
	bl Method18
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	teq r0, #0x41
	bne loc_3084
	mov r0, r4
	bl sub_3134
	b sub_30b0
loc_3084:
	ldr r5, [r4, #0x50]
	cmp r5, #0
	bls sub_30b0
loc_3090:
	add r0, r4, r5, lsl #2
	ldr r2, [r0, #0x50]!
	mov r0, r4
	mov r1, #2
	bl sub_4588
	sub r5, r5, #1
	cmp r5, #0
	bhi loc_3090

sub_30b0:
	sub sp, sp, #8
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x10]
	tst r0, #0x400
	beq loc_30dc
	mov r0, sp
	bl GetGlobalTime
	ldr r0, [sp, #4]
	ldr r1, [r4, #0x10]!
	str r0, [r1, #0x1c]!
	b loc_30e4
loc_30dc:
	mov r0, r4
	bl sub_30e8
loc_30e4:
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_30e8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl Method22
	mov r0, r4
	mov r1, #0
	bl sub_0310
	mov r1, #0
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x25]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x80000000
	bic r1, r1, #0x420
	str r1, [r0]
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b loc_5490

sub_3134:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r0, [r0, #0x10]
	tst r0, #0x20
	ldmdbeq fp, {r4, fp, sp, pc}
	sub sp, sp, #0x18
	tst r0, #0x80000000
	bne loc_3178
	mov r0, #0xa
	str r0, [sp, #8]
	add r0, sp, #8
	str r0, [sp, #0x14]
	mov r0, #4
	b loc_3190
loc_3178:
	mov r0, #2
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str sp, [sp, #0x14]
	mov r0, #8
loc_3190:
	str r0, [sp, #0xc]
	mov r3, #0
	str r0, [sp, #0x10]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #0x10
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	teq r0, #0
	ldreq r0, [r4, #0x10]
	ldreq r1, [r0, #0x10]
	andeq r1, r1, #0x80000000
	teqeq r1, #0
	bne loc_3210
	ldr r1, [r4, #0x28]
	teq r1, #0
	bne loc_31f8
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x38]
	str r0, [r4, #0x34]
	mov r0, r4
	bl sub_3af0
	teq r0, #0
	bne loc_3210
loc_31f8:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x400
	str r1, [r0]
	mov r0, r4
	bl sub_3b28
loc_3210:
	ldmdb fp, {r4, fp, sp, pc}

Method14:
	b loc_3020

Method16:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0xc
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x10]
	tst r1, #0x20
	ldreq r6, lit_32a4
	beq loc_3380
	tst r1, #0x80
	mvnne r6, #0x3e80
	bne loc_3380
	ldr r1, [r0, #0x50]
	ldr r1, [r1, #4]
	teq r1, #0x41
	movne r6, #0x7e
	subne r6, r6, #0x3f00
	bne loc_3380
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x80
	str r1, [r0]
	str r5, [r4, #0x24]
	ldr r0, [r4, #0x10]
	ldrb r1, [r0, #0x20]
	teq r1, #1
	bne loc_32cc
	ldrb r1, [r0, #0x21]
	teq r1, #0
	beq loc_32a8
	mov r0, r5
	bl Get__11CBufferListFv
	and r0, r0, #0xff
	b loc_32ac
lit_32a4:
	.word 0xffffc177
loc_32a8:
	ldrb r0, [r0, #0x22]
loc_32ac:
	and r1, r0, #0xff
	mov r2, #0
	ldr r0, [r4, #0x10]
	strb r2, [r0, #0x20]
	mov r0, r4
	bl sub_3470
	teq r0, #0
	bne loc_33b8
loc_32cc:
	mvn r0, #0
	str r0, [sp]
	str r5, [sp, #8]
	mov r3, #0
	str r0, [sp, #4]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #4
	ldr r1, [r0]
	mov r0, r4
	mov r2, #0
	bl sub_4f3c
	add sp, sp, #4
	mov r6, r0
	cmn r0, #2
	beq loc_3324
	cmn r0, #1
	beq loc_3340
	teq r0, #0
	ldrne r6, lit_3320
	b loc_3370
lit_3320:
	.word 0xffff1597
loc_3324:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #1
	str r1, [r0, #4]!
	b loc_33b8
loc_3340:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	bic r1, r1, #1
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	mov r6, #0xe9
	sub r6, r6, #0x2800
loc_3370:
	ldr r0, [sp, #4]
	cmn r0, #1
	ldrne r0, [sp, #8]
	blne free
loc_3380:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x80
	teq r6, #0
	str r1, [r0]
	bne loc_33a8
	mov r0, r5
	bl GetSize__11CBufferListCFv
	mov r2, r0
	b loc_33ac
loc_33a8:
	mov r2, #0
loc_33ac:
	mov r1, r6
	ldr r0, [r4, #0x18]!
	bl sub_549c
loc_33b8:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_33bc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	bl sub_0234
	movs r6, r0
	ldreq r5, lit_3408
	beq loc_3434
	ldr r0, lit_340c
	teq r5, r0
	beq loc_3410
	cmn r5, #2
	cmnne r5, #1
	moveq r0, #1
	streq r0, [r6, #4]!
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	teq r5, #0
	b loc_3414
lit_3408:
	.word 0xffffc177
lit_340c:
	.word 0xffffc17b
loc_3410:
	mov r5, r0
loc_3414:
	ldr r0, [r6, #0x28]
	teq r0, #0
	beq loc_3434
	ldr r1, [r6, #0x20]
	cmn r1, #1
	blne free
	mov r0, #0
	str r0, [r6, #0x28]!
loc_3434:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x80
	teq r5, #0
	str r1, [r0]
	bne loc_345c
	ldr r0, [r4, #0x24]
	bl GetSize__11CBufferListCFv
	mov r2, r0
	b loc_3460
loc_345c:
	mov r2, #0
loc_3460:
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_549c

sub_3470:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	and r5, r1, #0xff
	sub sp, sp, #0x20
	mov r0, #8
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, sp, #0xc
	str r0, [sp, #0x1c]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, lit_351c
	bl NewNamedPtr
	teq r0, #0
	moveq r5, #0xe9
	subeq r5, r5, #0x2800
	beq loc_3514
	str r0, [sp, #8]
	strb r5, [r0]
	mov r3, #1
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #4
	add r2, sp, #0x18
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	mov r5, r0
	cmn r0, #2
	cmnne r0, #1
	beq loc_3520
	teq r0, #0
	movne r5, #0
	ldr r0, [sp, #8]
	bl free
loc_3514:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_351c:
	.word 0x43452020			; 'CE  '
loc_3520:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #0xb
	str r1, [r0, #4]!
	b loc_3514
loc_353c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	bl sub_0234
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r0, #0x28]
	teq r0, #0
	blne free
	teq r5, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	teq r0, #0x42
	ldr r1, [r4, #0x24]
	mov r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne Method16
	moveq r2, #1
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq Method17

sub_359c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0x10]
	strb r5, [r0, #0x30]
	mov r1, #2
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x31]
	mov r0, #7
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x32]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x33]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x34]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x35]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x36]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x37]
	ldr r0, [r4, #0x10]
	strb r5, [r0, #0x20]
	ldr r0, [r4, #0x10]
	strb r5, [r0, #0x22]
	ldr r0, [r4, #0x10]
	strb r5, [r0, #0x26]
	ldr r0, [r4, #0x10]
	strb r5, [r0, #0x27]
	mov r1, #1
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x28]
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_5034
	ldr r0, [sp, #0xe]
	strb r0, [r4, #0x65]
	mov r0, r0, asr #8
	strb r0, [r4, #0x64]
	ldr r0, [sp, #0xc]
	strb r0, [r4, #0x67]
	mov r0, r0, asr #8
	strb r0, [r4, #0x66]
	ldrb r0, [sp, #0x10]
	strb r0, [r4, #0x68]
	ldrb r0, [sp, #0x11]
	strb r0, [r4, #0x69]
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

Method17:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	and r7, r2, #0xff
	sub sp, sp, #0xc
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x10]
	tst r1, #0x20
	ldreq r6, lit_3724
	beq loc_3848
	tst r1, #0x80
	mvnne r6, #0x3e80
	bne loc_3848
	ldr r1, [r0, #0x50]
	ldr r1, [r1, #4]
	teq r1, #0x42
	movne r6, #0x7e
	subne r6, r6, #0x3f00
	bne loc_3848
	ldr r1, [r0, #0x4c]
	ldr r1, [r1, #0x14]
	teq r1, #0
	moveq r6, #0x7a
	subeq r6, r6, #0x3f00
	beq loc_3848
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x80
	str r1, [r0]
	str r5, [r4, #0x24]
	mov r0, r5
	bl GetSize__11CBufferListCFv
	ldr r1, [r4, #0x10]
	ldr r2, [r1, #0x4c]
	ldr r3, [r2, #0x14]!
	ldr r2, [r4, #0x48]
	sub r2, r3, r2
	cmp r0, r2
	bls sub_3728
	mov r6, #0x17c
	sub r6, r6, #0x4000
	add r0, r1, #0x10
	ldr r1, [r0]
	bic r1, r1, #0x80
	str r1, [r0]
	b loc_3848
lit_3724:
	.word 0xffffc177

sub_3728:
	mov r0, r5
	bl GetSize__11CBufferListCFv
	str r0, [sp]
	mov r0, r5
	mvn r2, #0
	mov r1, #0
	bl Seek__11CBufferListFli
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	add r1, r1, r0
	mov r0, r5
	ldr r2, [sp]
	bl Getn__11CBufferListFPUcl
	str r0, [sp, #4]
	ldr r1, [r4, #0x48]
	add r0, r1, r0
	teq r7, #0
	str r0, [r4, #0x48]
	moveq r6, #0
	beq loc_3848
	ldr r0, [r4, #0x44]
	str r0, [sp, #8]
	ldr r0, [r4, #0x48]
	str r0, [sp, #4]
	ldr r0, [r4, #0x10]
	ldrb r1, [r0, #0x56]
	teq r1, #0
	beq loc_3848
	ldr r1, [r4, #0x4c]
	ldr r1, [r1, #8]
	add r1, r1, #0x14
	add r0, r0, #0x30
	ldmia r0, {ip, lr}
	stmia r1, {ip, lr}
	mov r3, #0
	str r3, [r4, #0x48]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	ldr r2, [r4, #0x4c]
	add r3, sp, #4
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	mov r6, r0
	cmn r0, #2
	beq loc_37fc
	cmn r0, #1
	beq loc_3818
	teq r0, #0
	ldrne r6, lit_37f8
	b loc_3848
lit_37f8:
	.word 0xffff1597
loc_37fc:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #1
	str r1, [r0, #4]!
	b loc_3880
loc_3818:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	bic r1, r1, #1
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	mov r6, #0xe9
	sub r6, r6, #0x2800
loc_3848:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x80
	teq r6, #0
	str r1, [r0]
	bne loc_3870
	mov r0, r5
	bl GetSize__11CBufferListCFv
	mov r2, r0
	b loc_3874
loc_3870:
	mov r2, #0
loc_3874:
	mov r1, r6
	ldr r0, [r4, #0x18]!
	bl sub_549c
loc_3880:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

Method18:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	teq r0, #0
	ldreq r1, lit_3918
	beq loc_3924
	ldr r1, [r0]
	movs r1, r1, asr #16
	moveq r1, #0x18c
	subeq r1, r1, #0xec00
	beq loc_3924
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x10]
	tst r1, #0x20000
	movne r1, #0x7d
	subne r1, r1, #0x3f00
	bne loc_3924
	tst r1, #0x80
	beq loc_391c
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	bic r1, r1, #3
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	ldr r0, [r4, #0x10]
	ldr r2, [r4, #0x6c]
	ldr r1, [r0]
	mov r0, r4
	bl sub_33bc
	mov r1, #0
	b loc_3924
lit_3918:
	.word 0xffffc177
loc_391c:
	mov r1, #0x71
	sub r1, r1, #0x3f00
loc_3924:
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b loc_54a8

Method19:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r0, r1
	bl GetSize__11CBufferListCFv
	mov r2, r0
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b Method21

Method21:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	ldr r0, [r0, #0x10]
	ldr r2, [r0, #0x10]
	tst r2, #0x20
	mov r7, #0
	ldreq r6, lit_3a84
	beq loc_3ac4
	tst r2, #0x40
	mvnne r6, #0x3e80
	bne loc_3ac4
	ldr r2, [r0, #0x50]
	ldr r2, [r2, #4]
	teq r2, #0x41
	movne r6, #0x7e
	subne r6, r6, #0x3f00
	bne loc_3ac4
	ldr r2, [r0, #0x10]!
	orr r2, r2, #0x40
	str r2, [r0]
	str r1, [r4, #0x20]
	mov r0, r1
	bl GetSize__11CBufferListCFv
	add r4, r4, #0x3c
	stmia r4, {r0, r5}
	str r7, [r4, #-4]!
	sub r4, r4, #0x38
	ldr r0, [r4, #0x28]
	teq r0, #0
	bne loc_3a10
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x38]
	str r0, [r4, #0x34]
	mov r0, r4
	bl sub_3af0
	teq r0, #0
	bne loc_3ac4
	ldr r0, [r4, #0x28]
	str r0, [r4, #0x2c]
	str r0, [r4, #0x30]
loc_3a10:
	ldr r0, [r4, #0x30]
	ldr r1, [r4, #0x2c]
	cmp r1, r0
	bhs loc_3aa8
	ldrb r2, [r4, #0x69]
	teq r2, #0
	ldreq r2, [r4, #0x66]
	moveq r2, r2, asr #16
	teqeq r2, #0
	bne loc_3a88
	sub r2, r0, r1
	ldr r0, [r4, #0x3c]
	cmp r2, r0
	movle r5, r2
	movgt r5, r0
	ldr r0, [r4, #0x20]
	teq r0, #0
	movne r2, r5
	blne Putn__11CBufferListFPCUcl
	ldr r0, [r4, #0x2c]
	add r0, r0, r5
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x38]
	add r0, r0, r5
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x3c]
	sub r0, r0, r5
	str r0, [r4, #0x3c]
	b loc_3aa8
lit_3a84:
	.word 0xffffc177
loc_3a88:
	ldr r0, [r4, #0x66]
	mov r0, r0, asr #16
	teq r0, #1
	mov r0, r4
	bne loc_3aa4
	bl sub_045c
	b loc_3aa8
loc_3aa4:
	bl sub_05dc
loc_3aa8:
	ldr r0, [r4, #0x40]
	ldr r1, [r4, #0x38]
	cmp r1, r0
	movlt r0, r4
	ldmdblt fp, {r4, r5, r6, r7, fp, sp, lr}
	blt sub_3b28
	mov r6, #0
loc_3ac4:
	str r7, [r4, #0x20]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x40
	str r1, [r0]
	mov r1, r6
	mov r2, #0
	ldr r0, [r4, #0x18]!
	ldr r3, [r4, #0x20]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_54b4

sub_3af0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x34]
	ldr r1, lit_3b24
	bl NewNamedPtr
	str r0, [r4, #0x28]!
	teq r0, #0
	movne r0, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdb fp, {r4, fp, sp, pc}
lit_3b24:
	.word 0x43452020			; 'CE  '

sub_3b28:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x44
	mov r0, #0
	mov r1, #0x28
	str r0, [sp, #0x3c]
	str r1, [sp, #0x38]
	str sp, [sp, #0x40]
	str r0, [sp, #0x30]
	ldr r0, [r4, #0x34]
	str r0, [sp, #0x2c]
	ldr r0, [r4, #0x28]
	str r0, [sp, #0x34]
	add r3, sp, r1
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #0x30
	add r2, sp, #0x3c
	ldr r1, [r0]
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	mov r3, r0
	ldr r2, [sp, #0x28]
	stmdb sp!, {r2, r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #0x34
	add r2, sp, #0x40
	ldr r1, [r0]
	mov r0, r4
	bl sub_3bb0
	ldmdb fp, {r4, fp, sp, pc}

sub_3bb0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	mov r8, #0
	mov r6, #0
	ldr r2, [fp, #8]
	ldr r0, [r0, #0x10]
	ldr ip, [r0, #0x10]
	tst ip, #0x440
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	ldr lr, lit_3c50
	mov sb, #1
	teq r2, lr
	moveq r6, lr
	beq loc_3d80
	cmn r2, #6
	cmnne r2, #1
	beq loc_3d58
	teq r2, #0
	bne loc_3d7c
	ldr r2, [r5, #4]
	cmp r2, #0
	ldr r1, [r5, #8]
	ble sub_3c54
	ldr ip, [r1]
	teq ip, #0xf
	bne sub_3c54
	ldr r1, [r3, #4]
	teq r1, #1
	bne loc_3d2c
	strb sb, [r0, #0x23]
	ldr r0, [r3, #8]!
	ldrb r0, [r0]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x24]
	mov r0, r4
	bl sub_3de4
	b loc_3d2c
lit_3c50:
	.word 0xffffc17b

sub_3c54:
	cmp r2, #0
	ble sub_3c6c
	ldr r0, [r1]
	teq r0, #0xd
	teqne r0, #0x17
	moveq r8, #1

sub_3c6c:
	ldr r0, [r4, #0x28]
	str r0, [r4, #0x2c]
	mov r1, r0
	ldr r2, [r3, #4]
	add r0, r0, r2
	str r0, [r4, #0x30]
	ldrb r0, [r4, #0x69]
	teq r0, #0
	ldreq r0, [r4, #0x66]
	moveq r0, r0, asr #16
	teqeq r0, #0
	bne loc_3ce8
	ldr r0, [r4, #0x3c]
	ldr r2, [r3, #4]!
	cmp r0, r2
	movge r7, r2
	movlt r7, r0
	ldr r0, [r4, #0x20]
	teq r0, #0
	movne r2, r7
	blne Putn__11CBufferListFPCUcl
	ldr r0, [r4, #0x2c]
	add r0, r0, r7
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x38]
	add r0, r0, r7
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x3c]
	sub r0, r0, r7
	str r0, [r4, #0x3c]
	b loc_3d08
loc_3ce8:
	ldr r0, [r4, #0x66]
	mov r0, r0, asr #16
	teq r0, #1
	mov r0, r4
	bne loc_3d04
	bl sub_045c
	b loc_3d08
loc_3d04:
	bl sub_05dc
loc_3d08:
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x50]
	ldr r0, [r0, #4]
	teq r0, #0x42
	moveq r0, r4
	ldreq r1, [r5, #8]!
	bleq sub_3ed8
	teq r8, #0
	bne loc_3d80
loc_3d2c:
	ldr r0, [r4, #0x38]
	ldr r1, [r4, #0x40]
	cmp r0, r1
	blt sub_3d4c
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x10]
	tst r0, #0x400
	beq loc_3d80

sub_3d4c:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, lr}
	b sub_3b28
loc_3d58:
	mov r0, r4
	bl sub_0234
	teq r0, #0
	ldreq r6, lit_3d78
	beq loc_3d80
	mov r1, #2
	str r1, [r0, #0x2c]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_3d78:
	.word 0xffffc177
loc_3d7c:
	mov r6, r2
loc_3d80:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]
	tst r1, #0x40
	beq loc_3db8
	mov r1, #0
	str r1, [r4, #0x20]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x40
	str r1, [r0]
	mov r1, r6
	mov r2, #0
	ldr r0, [r4, #0x18]
	ldr r3, [r4, #0x38]
	bl sub_54b4
loc_3db8:
	teq r8, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
	sub sp, sp, #8
	ldr r0, [r4, #0x10]
	strb sb, [r0, #0x25]
	mov r0, sp
	bl GetGlobalTime
	ldr r0, [sp, #4]
	ldr r1, [r4, #0x10]!
	str r0, [r1, #0x18]!
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_3de4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x24
	mov r0, sp
	bl __ct__22TCommToolGetEventReplyFv
	mov r0, #0x170
	sub r0, r0, #0x4000
	ldr r1, [r4, #0x10]
	ldrb r1, [r1, #0x23]
	teq r1, #1
	bne loc_3e84
	mov r0, #1
	str r0, [sp, #0x10]
	add r0, sp, #0x14
	mov r5, r0
	bl GetGlobalTime
	ldr r0, [r4, #0x10]
	ldrb r0, [r0, #0x24]
	str r0, [sp, #0x1c]
	ldr r0, lit_3e88
	str r0, [sp, #0x20]
	mov r1, sp
	mov r0, r4
	mov r2, #0
	bl sub_0610
	teq r0, #0
	ldrne r0, lit_3e8c
	bne loc_3e84
	sub sp, sp, #8
	mov r0, #0
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x23]
	ldr r1, [r4, #0x10]!
	strb r0, [r1, #0x24]
	str r0, [sp, #4]
	str r0, [sp]
	ldmia sp!, {r3, ip}
	stmia r5, {r3, ip}
loc_3e84:
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_3e88:
	.word 0x696e6574			; 'inet'
lit_3e8c:
	.word 0xffffc17b

sub_3e90:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r1, [r0, #0x10]
	ldrb r2, [r1, #0x25]
	teq r2, #1
	bne loc_3ec8
	mov r2, #0
	strb r2, [r1, #0x25]
	ldr r1, lit_3ed4
	str r1, [r0, #0x6c]
	ldr r0, [r0, #0x18]
	sub r1, r1, #4
	bl sub_5550
loc_3ec8:
	mov r0, #0x170
	sub r0, r0, #0x4000
	ldmdb fp, {fp, sp, pc}
lit_3ed4:
	.word 0xffffc177

sub_3ed8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	mov r5, r1
	ldr r0, [r1]
	teq r0, #0x14
	bne loc_3f6c
	ldr r0, [r5, #8]
	add r0, r0, r0, lsl #2
	ldr r2, [r5, #4]
	add r1, r5, r0, lsl #2
	ldr r0, [r4, #0x10]
	add r0, r0, #0x38
	bl memcpy
	ldr r2, [r5, #0xc]
	teq r2, #0
	beq loc_3f40
	ldr r0, [r5, #0x10]
	add r0, r0, r0, lsl #2
	add r1, r5, r0, lsl #2
	ldr r0, [r4, #0x10]!
	add r0, r0, #0x40
	bl memcpy
	b loc_3f74
loc_3f40:
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_0260
	mov r1, r0
	ldr r0, [r4, #0x10]!
	add r0, r0, #0x40
	add r1, r1, #0x10
	ldmia r1, {ip, lr}
	stmia r0, {ip, lr}
	b loc_3f74
loc_3f6c:
	mov r6, #0x7a
	sub r6, r6, #0x3f00
loc_3f74:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_3f7c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_0260
	mov r5, r0
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x2c]
	teq r0, #0
	bne loc_40bc
	ldr r1, lit_4018
	mov r0, #0x4c
	bl NewNamedPtr
	teq r0, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r1, [r5, #0x14]
	ldr r1, [r1, #0x10]
	sub lr, r1, #0x14
	mov r6, #1
	ldr r7, [r5, #0x18]
	teq r7, #0
	beq loc_401c
	mov r5, r0
	mov ip, #6
loc_3ff0:
	ldmia r7!, {r1, r2, r3}
	stmia r5!, {r1, r2, r3}
	subs ip, ip, #1
	bne loc_3ff0
	ldmia r7, {r3}
	stmia r5, {r3}
	ldr r1, [r0, #0x14]
	cmp r1, lr
	strhi lr, [r0, #0x14]
	b loc_40a8
lit_4018:
	.word 0x43452020			; 'CE  '
loc_401c:
	mov r1, #3
	str r1, [r0, #0x18]
	mov r1, #0x1e
	add r0, r0, #0x1c
	stmia r0, {r1, r6}
	mov r1, #0x10
	str r1, [r0, #8]
	str lr, [r0, #-8]!
	sub r0, r0, #0x14
	mov r1, #5
	mov r2, #0x64
	add r0, r0, #0x28
	stmia r0, {r1, r2}
	str r1, [r0, #0xc]
	str r2, [r0, #8]
	sub r0, r0, #0x28
	mov r1, #0x178
	add r1, r1, #0x400
	ldr r2, [r5, #0x28]
	cmp r2, #0x400
	bls sub_4084
	mov r2, #0x1000
	str r1, [r0, #0x3c]
	mov r1, #0xaf0
	str r2, [r0, #0x38]
	b loc_4094

sub_4084:
	mov r2, #0x800
	str r2, [r0, #0x38]
	mov r2, #0x4b0
	str r2, [r0, #0x3c]
loc_4094:
	str r1, [r0, #0x40]
	ldrb r1, [r5, #0x2c]
	teq r1, #0
	movne r1, #1
	str r1, [r0, #0x48]
loc_40a8:
	mov r1, #0
	str r1, [r0, #0x44]
	str r6, [r0, #0x10]
	ldr r1, [r4, #0x10]!
	str r0, [r1, #0x2c]!
loc_40bc:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_40c4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x18
	mov r6, #0
	mov r0, sp
	bl __ct__19TCommToolOptionInfoFv
	mov r5, sp
	ldr r0, [r4, #0x18]
	bl sub_55f8
	ldmia r0, {r0, r1, r2, r3, ip, lr}
	stmia r5, {r0, r1, r2, r3, ip, lr}
	mov r5, #0
	ldr r0, [sp, #0xc]
	teq r0, #0
	ldrne r0, [sp, #0x14]
	teqne r0, #0
	moveq r0, r5
	beq loc_41b8
	ldr r0, [r4, #0x10]
	ldrb r0, [r0, #0x55]
	teq r0, #1
	bne loc_4164
	ldr r0, [sp, #0x14]
	ldr r1, lit_41bc
	bl FindOption__15TOptionIteratorFUl
	teq r0, #0
	beq loc_4164
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x42]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x11]
	mov r1, r1, asr #8
	strb r1, [r0, #0x10]
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x44]
	str r1, [r0, #0xc]!
	ldr r0, [r4, #0x10]
	strb r5, [r0, #0x55]
loc_4164:
	ldr r0, [r4, #0x10]
	ldrb r0, [r0, #0x54]
	teq r0, #1
	bne loc_41b4
	ldr r0, [sp, #0x14]
	ldr r1, lit_41c0
	bl FindOption__15TOptionIteratorFUl
	teq r0, #0
	beq loc_41b4
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x3a]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x11]
	mov r1, r1, asr #8
	strb r1, [r0, #0x10]
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x3c]
	str r1, [r0, #0xc]!
	ldr r0, [r4, #0x10]!
	strb r5, [r0, #0x54]
loc_41b4:
	mov r0, r6
loc_41b8:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_41bc:
	.word 0x69756473			; 'iuds'
lit_41c0:
	.word 0x69757373			; 'iuss'

Method20:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r2, [r0, #0x10]
	tst r2, #0x20
	ldreq r1, lit_42dc
	beq loc_42e4
	tst r2, #0x40
	mvnne r1, #0x3e80
	bne loc_42e4
	ldr r2, [r0, #0x50]
	ldr r2, [r2, #4]
	teq r2, #0x42
	movne r1, #0x7e
	subne r1, r1, #0x3f00
	bne loc_42e4
	ldr r2, [r0, #0x10]!
	orr r2, r2, #0x40
	str r2, [r0]
	str r1, [r4, #0x20]
	mov r0, r1
	bl GetSize__11CBufferListCFv
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x28]
	teq r0, #0
	bne loc_4258
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x4c]
	ldr r0, [r0, #0x14]
	str r0, [r4, #0x34]
	mov r0, r4
	bl sub_3af0
	teq r0, #0
	subne sp, sp, #0x44
	bne loc_42b4
loc_4258:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	bgt loc_42e0
	sub sp, sp, #0x44
	mov r0, #0
	mov r1, #0x28
	str r0, [sp, #0x3c]
	str r1, [sp, #0x38]
	str sp, [sp, #0x40]
	str r0, [sp, #0x30]
	ldr r0, [r4, #0x34]
	str r0, [sp, #0x2c]
	ldr r0, [r4, #0x28]
	str r0, [sp, #0x34]
	add r3, sp, r1
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #0x30
	add r2, sp, #0x3c
	ldr r1, [r0]
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
loc_42b4:
	mov r3, r0
	ldr r2, [sp, #0x28]
	stmdb sp!, {r2, r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #0x34
	add r2, sp, #0x40
	ldr r1, [r0]
	mov r0, r4
	bl sub_42f0
	ldmdb fp, {r4, fp, sp, pc}
lit_42dc:
	.word 0xffffc177
loc_42e0:
	mov r1, #0
loc_42e4:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b loc_4404

sub_42f0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r5, [fp, #8]
	cmn r5, #6
	cmnne r5, #1
	beq loc_4338
	teq r5, #0
	bne loc_4354
	ldr r0, [r4, #0x28]
	str r0, [r4, #0x2c]
	ldr r0, [r3, #4]!
	str r0, [r4, #0x38]
	mov r0, r4
	ldr r1, [r2, #8]!
	bl sub_4374
	b loc_4364
loc_4338:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	mov r1, #0xc
	str r1, [r0, #0x2c]!
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_4354:
	add ip, r5, #0x3e80
	cmn ip, #5
	movne r5, #0x198
	subne r5, r5, #0xec00
loc_4364:
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_4404

sub_4374:
	stmdb sp!, {lr}
	ldr r2, [r1]
	teq r2, #0x14
	ldmiane sp!, {pc}
	ldr r2, [r1, #4]
	teq r2, #0
	ldrne r2, [r1, #8]
	teqne r2, #0
	beq loc_43ac
	add r2, r2, r1
	ldr r3, [r0, #0x10]
	add lr, r3, #0x38
	ldmia r2, {r3, ip}
	stmia lr, {r3, ip}
loc_43ac:
	ldr r2, [r1, #0xc]
	teq r2, #0
	ldrne r2, [r1, #0x10]
	teqne r2, #0
	beq loc_43d8
	add r2, r2, r1
	ldr r0, [r0, #0x10]
	add r1, r0, #0x40
	ldmia r2, {ip, lr}
	stmia r1, {ip, lr}
	ldmia sp!, {pc}
loc_43d8:
	ldr r1, [r0, #0x10]
	ldr r2, [r1, #0x4c]
	ldr r2, [r2, #0xc]
	str r2, [r1, #0x44]!
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #0x48]
	mov r1, r1, lsr #16
	strb r1, [r0, #0x43]
	mov r1, r1, asr #8
	strb r1, [r0, #0x42]
	ldmia sp!, {pc}
loc_4404:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r5, r1
	mov r6, #0
	mov r7, #0
	bne loc_4474
	ldr r0, [r4, #0x3c]
	ldr r1, [r4, #0x38]
	cmp r0, r1
	movge r6, r1
	movlt r6, r0
	ldr r0, [r4, #0x20]
	teq r0, #0
	movne r2, r6
	ldrne r1, [r4, #0x2c]
	blne Putn__11CBufferListFPCUcl
	ldr r0, [r4, #0x2c]
	add r0, r0, r6
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x38]
	sub r0, r0, r6
	str r0, [r4, #0x38]
	cmp r0, #0
	movle r7, #1
	mov r0, r4
	bl sub_40c4
loc_4474:
	mov r0, #0
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x10]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x40
	str r1, [r0]
	mov r3, r6
	mov r2, r7
	mov r1, r5
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_54b4

Method22:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0]
	mov r0, r4
	bl sub_0234
	movs r2, r0
	ldreq r1, lit_4570
	beq loc_457c
	ldr r0, [r2]
	movs r0, r0, asr #16
	moveq r1, #0x18c
	subeq r1, r1, #0xec00
	beq loc_457c
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x10]
	tst r0, #0x20000
	movne r1, #0x7d
	subne r1, r1, #0x3f00
	bne loc_457c
	tst r0, #0x440
	beq loc_4574
	ldr r0, [r2, #2]
	mov r0, r0, lsr #16
	bic r0, r0, #0x30
	strb r0, [r2, #3]
	mov r0, r0, asr #8
	strb r0, [r2, #2]
	ldr r1, [r4, #0x10]
	ldr r0, [r1, #0x10]
	tst r0, #0x40
	beq loc_4568
	ldr r0, [r2, #0x3c]
	movs r0, r0
	addne r0, r2, #0x34
	ldr r3, [r2, #0x4c]
	movs ip, r3
	addne ip, r2, #0x44
	ldr r3, [r4, #0x6c]
	ldr r2, [r2, #0x30]
	stmdb sp!, {r2, r3}
	ldr r1, [r1]
	mov r3, ip
	mov r2, r0
	mov r0, r4
	bl sub_3bb0
	add sp, sp, #8
loc_4568:
	mov r1, #0
	b loc_457c
lit_4570:
	.word 0xffffc177
loc_4574:
	mov r1, #0x71
	sub r1, r1, #0x3f00
loc_457c:
	ldr r0, [r4, #0x18]!
	ldmdb fp, {r4, fp, sp, lr}
	b loc_54c0

sub_4588:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r0, #0
	ldr r2, [r4, #0x10]
	ldr r1, [r2, #0x10]
	tst r1, #0x20
	ldreq r0, lit_4638
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r2, [r2, #0x50]
	ldr r2, [r2, #4]
	teq r2, #0x42
	movne r0, #0x7e
	subne r0, r0, #0x3f00
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	tst r1, #0x40
	mvnne r0, #0x3e80
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r1, #0
	mvn r7, #0
	ldr r2, [r4, #0x50]
	cmp r2, #0
	bls sub_4610
loc_45f0:
	add r3, r4, r1, lsl #2
	ldr r3, [r3, #0x54]
	teq r3, r6
	moveq r7, r1
	beq sub_4610
	add r1, r1, #1
	cmp r2, r1
	bhi loc_45f0

sub_4610:
	teq r5, #1
	bne loc_463c
	mov r1, #0x4a
	sub r1, r1, #0xeb00
	cmn r7, #1
	bne loc_4630
	teq r2, #4
	bne loc_465c
loc_4630:
	mov r0, r1
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_4638:
	.word 0xffffc177
loc_463c:
	teq r5, #2
	movne r0, #0x7a
	subne r0, r0, #0x3f00
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	cmn r7, #1
	moveq r0, #0x49
	subeq r0, r0, #0xeb00
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_465c:
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	sub sp, sp, #0x18
	mov r0, r4
	bl sub_028c
	mov r8, r0
	teq r5, #1
	movne r0, #7
	addne r0, r0, #0x200
	moveq r0, #6
	addeq r0, r0, #0x200
	stmia sp, {r0, r6}
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #0xc
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str sp, [sp, #0x14]
	mov r3, #0
	stmdb sp!, {r3}
	add r2, sp, #0x10
	mov r0, r4
	ldr r1, [r8, #0x50]
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_46d4
	teq r0, #0
	beq loc_46e0
loc_46d4:
	mov r0, #0xe9
	sub r0, r0, #0x2800
	b loc_4734
loc_46e0:
	mov r0, r4
	mov r2, #2
	ldr r1, [r8, #0x50]!
	bl sub_1934
	teq r0, #0
	bne loc_4734
	teq r5, #1
	bne loc_4718
	ldr r2, [r4, #0x50]
	add r1, r2, #1
	str r1, [r4, #0x50]
	add r1, r4, r2, lsl #2
	str r6, [r1, #0x54]!
	b loc_4734
loc_4718:
	ldr r1, [r4, #0x50]
	sub r1, r1, #1
	str r1, [r4, #0x50]
	add r1, r4, r1, lsl #2
	ldr r1, [r1, #0x54]
	add r2, r4, r7, lsl #2
	str r1, [r2, #0x54]!
loc_4734:
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_4738:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	and r1, r1, #0xff
	and ip, r2, #0xff
	and lr, r3, #0xff
	sub sp, sp, #0x1c
	mov r0, #0
	ldr r3, [r4, #0x10]
	ldr r2, [r3, #0x10]
	tst r2, #0x20
	ldreq r0, lit_4818
	beq loc_4830
	ldr r3, [r3, #0x50]
	ldr r3, [r3, #4]
	teq r3, #0x42
	movne r0, #0x7e
	subne r0, r0, #0x3f00
	bne loc_4830
	tst r2, #0x40
	mvnne r0, #0x3e80
	bne loc_4830
	teq r1, #0
	movne r0, #0x100
	teq ip, #0
	orrne r0, r0, #0x200
	teq lr, #0
	orrne r0, r0, #0x400
	mov r1, #9
	str r1, [sp, #0xc]
	mov r1, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x18]
	mov r0, #0x10
	str r0, [sp]
	str r1, [sp, #0x14]
	str r0, [sp, #4]
	add r0, sp, #0xc
	mov r3, #0
	str r0, [sp, #8]
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r2, sp, #4
	ldr r1, [r0]
	mov r0, r4
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	beq loc_480c
	teq r0, #0
	beq loc_481c
loc_480c:
	mov r0, #0xe9
	sub r0, r0, #0x2800
	b loc_4830
lit_4818:
	.word 0xffffc177
loc_481c:
	ldr r0, [r4, #0x10]
	ldr r1, [r0]
	mov r0, r4
	mov r2, #1
	bl sub_1934
loc_4830:
	ldmdb fp, {r4, r5, fp, sp, pc}

Method23:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldrb r1, [r0, #0x25]
	teq r1, #0
	ldreq r0, [r0, #0x10]
	andeq r0, r0, #0x400
	teqeq r0, #0
	ldmdbeq fp, {r4, fp, sp, pc}
	sub sp, sp, #8
	mov r0, sp
	bl GetGlobalTime
	ldr r1, [sp, #4]
	ldr r0, [r4, #0x10]
	ldr r2, [r0, #0x10]
	tst r2, #0x400
	beq loc_48ac
	ldrb r2, [r0, #0x25]
	teq r2, #0
	bne loc_48a0
	ldr r0, [r0, #0x1c]
	sub r0, r1, r0
	subs ip, r0, #0x1500000
	cmphs ip, #0x18000
	bls sub_48c4
loc_48a0:
	mov r0, r4
	bl sub_30e8
	b sub_48c4
loc_48ac:
	ldr r0, [r0, #0x18]
	sub r0, r1, r0
	subs ip, r0, #0xa80000
	cmphs ip, #0xc000
	movhi r0, r4
	blhi sub_3e90

sub_48c4:
	ldmdb fp, {r4, fp, sp, pc}

Method6:
	mov pc, lr

sub_48cc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x10]
	ldr r1, [r0, #4]!
	mov r0, r4
	bl sub_0260
	mov r5, r0
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x4c]
	teq r0, #0
	bne loc_4980
	ldr r1, lit_4958
	mov r0, #0x1c
	bl NewNamedPtr
	teq r0, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r1, [r5, #0x14]
	ldr r1, [r1, #0x10]
	sub lr, r1, #8
	ldr r5, [r5, #0x1c]
	teq r5, #0
	beq loc_495c
	mov r6, r0
	ldmia r5!, {r1, r2, r3, ip}
	stmia r6!, {r1, r2, r3, ip}
	ldmia r5, {r2, r3, ip}
	stmia r6, {r2, r3, ip}
	ldr r1, [r0, #0x14]
	cmp r1, lr
	strhi lr, [r0, #0x14]
	b loc_4968
lit_4958:
	.word 0x43452020			; 'CE  '
loc_495c:
	mov r1, #0xa
	str r1, [r0, #0x18]
	str lr, [r0, #0x14]
loc_4968:
	mov r1, #0
	str r1, [r0, #8]
	mov r1, #1
	str r1, [r0, #0x10]
	ldr r1, [r4, #0x10]!
	str r0, [r1, #0x4c]!
loc_4980:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_4988:
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
	bl sub_4f3c
	add sp, sp, #4
	cmn r0, #2
	cmnne r0, #1
	bne loc_4a08
	mov r1, r4
	mov r0, r5
	bl sub_0234
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	orr r1, r1, #1
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_4a08:
	mov r2, r0
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_4ac4

sub_4a1c:
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
	bl sub_0164
	add sp, sp, #4
	cmn r0, #6
	cmnne r0, #1
	bne loc_4aa0
	mov r1, r5
	mov r0, r6
	bl sub_0234
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	orr r1, r1, #0x10
	strb r1, [r0, #3]
	mov r1, r1, asr #8
	strb r1, [r0, #2]
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_4aa0:
	mov r3, r0
	ldr r2, [r4, #4]!
	stmdb sp!, {r2, r3}
	mov r3, r8
	mov r2, r7
	mov r1, r5
	mov r0, r6
	bl sub_4b74
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_4ac4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	bl sub_0234
	ldr r0, [r0, #4]
	cmp r0, #5
	beq loc_4b4c
	bgt loc_4b14
	teq r0, #1
	beq loc_4b38
	teq r0, #3
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_2044
loc_4b14:
	teq r0, #0xb
	beq loc_4b60
	teq r0, #0xe
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_2cac
loc_4b38:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_33bc
loc_4b4c:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_2688
loc_4b60:
	mov r2, r6
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b loc_353c

sub_4b74:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, r2
	mov r6, r3
	ldr r8, [fp, #8]
	ldr sb, [fp, #4]
	bl sub_0234
	ldr r0, [r0, #0x2c]
	sub r0, r0, #2
	cmp r0, #0xe
	addls pc, pc, r0, lsl #2
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bb0:
	b loc_4c2c

sub_4bb4:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bb8:
	b loc_4c08

sub_4bbc:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bc0:
	b loc_4c50

sub_4bc4:
	b loc_4c74

sub_4bc8:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bcc:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bd0:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bd4:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4bd8:
	b loc_4c98

sub_4bdc:
	b loc_4cbc

sub_4be0:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4be4:
	b loc_4ce0

sub_4be8:
	mov r3, r8
	stmdb sp!, {r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_4de4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
loc_4c08:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_2108
	b loc_4d00
loc_4c2c:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_3bb0
	b loc_4d00
loc_4c50:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_2768
	b loc_4d00
loc_4c74:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_285c
	b loc_4d00
loc_4c98:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_42f0
	b loc_4d00
loc_4cbc:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_2b64
	b loc_4d00
loc_4ce0:
	mov r3, r8
	mov r2, sb
	stmdb sp!, {r2, r3}
	mov r3, r6
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_2d84
loc_4d00:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_4d04:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x44
	ldr r0, [r0, #0x30]
	ldr r1, [r4, #0x2c]
	subs r5, r0, r1
	ldreq r0, [r4, #0x10]
	ldreq r1, [r0, #0x10]
	andeq r1, r1, #0x140
	teqeq r1, #0
	bne loc_4ddc
	ldr r1, [r4, #0x28]
	teq r1, #0
	bne loc_4d60
	ldr r0, [r0, #0x2c]
	ldr r0, [r0, #0x38]
	str r0, [r4, #0x34]
	mov r0, r4
	bl sub_3af0
	teq r0, #0
	bne loc_4ddc
loc_4d60:
	ldr r0, [r4, #0x28]
	str r0, [r4, #0x30]
	str r0, [r4, #0x2c]
	str r0, [sp, #0x34]
	ldr r0, [r4, #0x34]
	str r0, [sp, #0x2c]
	mov r0, #0
	str r0, [sp, #0x30]
	str r0, [sp, #0x3c]
	mov r0, #0x28
	str r0, [sp, #0x38]
	str sp, [sp, #0x40]
	add r3, sp, r0
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #0x30
	add r2, sp, #0x3c
	ldr r1, [r0]
	mov r0, r4
	bl sub_0164
	add sp, sp, #4
	mov r3, r0
	stmdb sp!, {r3}
	ldr r0, [r4, #0x10]
	add r3, sp, #0x30
	add r2, sp, #0x3c
	ldr r1, [r0]
	mov r0, r4
	bl sub_4de4
	add sp, sp, #4
	ldr r5, [sp, #0x30]
loc_4ddc:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_4de4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r3
	ldr ip, [fp, #4]
	ldr r0, [r0, #0x10]
	ldr r3, [r0, #0x10]!
	bic r3, r3, #0x100
	cmn ip, #6
	str r3, [r0]
	cmnne ip, #1
	beq loc_4ebc
	teq ip, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r2, #4]
	cmp r0, #0
	ble sub_4ea8
	ldr r0, [r2, #8]!
	ldr r0, [r0]
	mov r1, #1
	teq r0, #0xf
	bne loc_4e78
	ldr r0, [r5, #4]
	teq r0, #1
	bne sub_4ea8
	mov r0, #0
	str r0, [r5, #4]
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x23]
	ldr r0, [r5, #8]
	ldrb r0, [r0]
	ldr r1, [r4, #0x10]
	strb r0, [r1, #0x24]
	mov r0, r4
	bl sub_3de4
	b sub_4ea8
loc_4e78:
	teq r0, #0xd
	teqne r0, #0x17
	bne sub_4ea8
	sub sp, sp, #8
	ldr r0, [r4, #0x10]
	strb r1, [r0, #0x25]
	mov r0, sp
	bl GetGlobalTime
	ldr r0, [sp, #4]
	ldr r1, [r4, #0x10]
	str r0, [r1, #0x18]!
	add sp, sp, #8

sub_4ea8:
	ldr r0, [r4, #0x30]
	ldr r1, [r5, #4]!
	add r0, r0, r1
	str r0, [r4, #0x30]!
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_4ebc:
	orr r2, r3, #0x100
	ldr r0, [r4, #0x10]
	str r2, [r0, #0x10]!
	mov r0, r4
	bl sub_0234
	teq r0, #0
	movne r1, #0x10
	strne r1, [r0, #0x2c]!
	ldmdb fp, {r4, r5, fp, sp, pc}

Method32:
	ldr r0, [r0, #0x18]
	mov r1, #0
	b loc_5538

Method33:
	mov pc, lr

sub_4ef0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r2, #0xff
	mvnne ip, #0
	moveq ip, #2
	moveq r2, #0
	mov r3, r0
	stmdb sp!, {r3}
	mov r3, ip
	bl sub_019c
	ldmdb fp, {fp, sp, pc}

Method24:
	mov pc, lr

sub_4f24:
	cmn r2, #1
	bne loc_01d0
	moveq r0, #0
	mov pc, lr

sub_4f34:
	b loc_4fa4

sub_4f38:
	b loc_4f74

sub_4f3c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov lr, #1
	ldr ip, [fp, #4]
	sub sp, sp, #0x10
	stmda sp!, {r2, r3}
	stmdb sp!, {r1, ip}
	str lr, [sp, #-4]!
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}
loc_4f74:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #2
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}
loc_4fa4:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r3, #3
	sub sp, sp, #0x1c
	stmda sp!, {r1, r2}
	str r3, [sp]
	ldr r0, [r0, #0x14]
	mov r1, sp
	bl sub_5768
	ldr r0, [sp, #0x1c]
	ldmdb fp, {fp, sp, pc}

sub_4fd4:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_4ff8
	mov r0, #0x10
	bl __nw__FUi
	movs r4, r0
	beq loc_5028
loc_4ff8:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_5030
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0
	strb r0, [r4, #0xc]
	strb r0, [r4, #0xd]
	mov r0, #1
	strb r0, [r4, #0xe]
loc_5028:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_5030:
	.word 0x69756263			; 'iubc'

sub_5034:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_5058
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_5090
loc_5058:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_5098
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0
	strb r0, [r4, #0xd]
	strb r0, [r4, #0xc]
	strb r0, [r4, #0xf]
	strb r0, [r4, #0xe]
	strb r0, [r4, #0x10]
	strb r0, [r4, #0x11]
loc_5090:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_5098:
	.word 0x69637674			; 'icvt'

sub_509c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_50c0
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_50f0
loc_50c0:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_50f8
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0x2e
	add r0, r0, #0x200
	str r0, [r4, #0xc]
	mov r0, #0xa
	str r0, [r4, #0x10]
loc_50f0:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_50f8:
	.word 0x69756478			; 'iudx'

sub_50fc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_5120
	mov r0, #0x40
	bl __nw__FUi
	movs r4, r0
	beq loc_51a4
loc_5120:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_51ac
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
loc_51a4:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_51ac:
	.word 0x69746378			; 'itcx'

sub_51b0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_51d4
	mov r0, #0x10
	bl __nw__FUi
	movs r4, r0
	beq loc_51f8
loc_51d4:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_5200
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
loc_51f8:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_5200:
	.word 0x69747376			; 'itsv'

sub_5204:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_5228
	mov r0, #0x18
	bl __nw__FUi
	movs r4, r0
	beq loc_5254
loc_5228:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_525c
	str r0, [r4]
	mov r0, #0xc
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x10]
	str r0, [r4, #0x14]
loc_5254:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_525c:
	.word 0x69707266			; 'iprf'

sub_5260:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_5284
	mov r0, #0x10
	bl __nw__FUi
	movs r4, r0
	beq loc_52b4
loc_5284:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_52bc
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0
	strb r0, [r4, #0xd]
	strb r0, [r4, #0xc]
	mov r0, #1
	strb r0, [r4, #0xe]
loc_52b4:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_52bc:
	.word 0x696c7074			; 'ilpt'

sub_52c0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_52e4
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_5310
loc_52e4:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_5318
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
	strb r0, [r4, #0x11]
	strb r0, [r4, #0x10]
loc_5310:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_5318:
	.word 0x69747273			; 'itrs'

sub_531c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_5340
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_536c
loc_5340:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_5374
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
	strb r0, [r4, #0x11]
	strb r0, [r4, #0x10]
loc_536c:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_5374:
	.word 0x69757373			; 'iuss'

sub_5378:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_539c
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_53c8
loc_539c:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_53d0
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
	strb r0, [r4, #0x11]
	strb r0, [r4, #0x10]
loc_53c8:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_53d0:
	.word 0x69756473			; 'iuds'

sub_53d4:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_53dc:
	.asciz "PCECallBack"

sub_53e8:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_53d4
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_5414:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_5428
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_5428:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_5430:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10
loc_543c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14
loc_5448:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_5454:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c
loc_5460:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_546c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_5478:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_5484:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c
loc_5490:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_549c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34
loc_54a8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_54b4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c
loc_54c0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_54cc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_54d8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48
loc_54e4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c
loc_54f0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x50

sub_54fc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x54
loc_5508:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x58

sub_5514:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x5c

sub_5520:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x60

sub_552c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x64
loc_5538:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x68

sub_5544:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x6c

sub_5550:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x70

sub_555c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x74

sub_5568:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x78

sub_5574:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x7c

sub_5580:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x80

sub_558c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x84

sub_5598:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x88

sub_55a4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x8c

sub_55b0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x90

sub_55bc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x94

sub_55c8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x98

sub_55d4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x9c

sub_55e0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xa0

sub_55ec:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xa4

sub_55f8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xa8

sub_5604:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xac

sub_5610:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xb0

sub_561c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xb4

sub_5628:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xb8

sub_5634:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xbc

sub_5640:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xc0

sub_564c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xc4

sub_5658:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xc8

sub_5664:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xcc

sub_5670:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xd0

sub_567c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xd4

sub_5688:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xd8

sub_5694:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xdc

sub_56a0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xe0

sub_56ac:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0xe4

sub_56b8:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_56c0:
	.asciz "PMuxTool"
	.align 4

sub_56cc:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_56b8
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_56f8:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_570c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_570c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_5714:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_5720:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_572c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_5738:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_5744:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_5750:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_575c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_5768:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_5774:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

CopyDataFrom__7TOptionFP7TOption:
	ldr pc, lit_5784
lit_5784:
	.word 0x0180029c			; glue 0180029c -> CopyDataFrom__7TOptionFP7TOption

FindOption__15TOptionIteratorFUl:
	ldr pc, lit_578c
lit_578c:
	.word 0x018002e0			; glue 018002e0 -> FindOption__15TOptionIteratorFUl

FreeInstance__FP9TProtocol:
	ldr pc, lit_5794
lit_5794:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

Gestalt__9TUGestaltFUlPvT1:
	ldr pc, lit_579c
lit_579c:
	.word 0x01801038			; glue 01801038 -> Gestalt__9TUGestaltFUlPvT1

GetGlobalTime:
	ldr pc, lit_57a4
lit_57a4:
	.word 0x018010a4			; glue 018010a4 -> GetGlobalTime

GetSize__11CBufferListCFv:
	ldr pc, lit_57ac
lit_57ac:
	.word 0x01801b24			; glue 01801b24 -> GetSize__11CBufferListCFv

Get__11CBufferListFv:
	ldr pc, lit_57b4
lit_57b4:
	.word 0x01801ad8			; glue 01801ad8 -> Get__11CBufferListFv

Getn__11CBufferListFPUcl:
	ldr pc, lit_57bc
lit_57bc:
	.word 0x01801b0c			; glue 01801b0c -> Getn__11CBufferListFPUcl

NewNamedPtr:
	ldr pc, lit_57c4
lit_57c4:
	.word 0x01801808			; glue 01801808 -> NewNamedPtr

Putn__11CBufferListFPCUcl:
	ldr pc, lit_57cc
lit_57cc:
	.word 0x01801cc4			; glue 01801cc4 -> Putn__11CBufferListFPCUcl

Seek__11CBufferListFli:
	ldr pc, lit_57d4
lit_57d4:
	.word 0x01801d6c			; glue 01801d6c -> Seek__11CBufferListFli

__ct__17TCMOCTConnectInfoFv:
	ldr pc, lit_57dc
lit_57dc:
	.word 0x018004a8			; glue 018004a8 -> __ct__17TCMOCTConnectInfoFv

__ct__19TCommToolOptionInfoFv:
	ldr pc, lit_57e4
lit_57e4:
	.word 0x018026c0			; glue 018026c0 -> __ct__19TCommToolOptionInfoFv

__ct__22TCommToolGetEventReplyFv:
	ldr pc, lit_57ec
lit_57ec:
	.word 0x01801e94			; glue 01801e94 -> __ct__22TCommToolGetEventReplyFv

__ct__7TOptionFUl:
	ldr pc, lit_57f4
lit_57f4:
	.word 0x018001f4			; glue 018001f4 -> __ct__7TOptionFUl

__ct__9TUGestaltFv:
	ldr pc, lit_57fc
lit_57fc:
	.word 0x01800da4			; glue 01800da4 -> __ct__9TUGestaltFv

__dl__FPv:
	ldr pc, lit_5804
lit_5804:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__8TUObjectFv:
	ldr pc, lit_580c
lit_580c:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_5814
lit_5814:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

free:
	ldr pc, lit_581c
lit_581c:
	.word 0x01801024			; glue 01801024 -> free

memcpy:
	ldr pc, lit_5824
lit_5824:
	.word 0x0180011c			; glue 0180011c -> memcpy
