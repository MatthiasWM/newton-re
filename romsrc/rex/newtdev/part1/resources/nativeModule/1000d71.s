; a nativeModule binary (obj_1000d71)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	.origin 0xd7c		; the part's offset in its package as linked (.rword values add it)


sub_0000:
	b loc_037c

sub_0004:
	b loc_03cc

sub_0008:
	b loc_01c8

glue_01800804:
	ldr pc, lit_0010
lit_0010:
	.word 0x01800804			; glue 01800804

sub_0014:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r0, lit_003c
	ldr r0, [r0]
	mov r2, #0
	mov r1, #0xe9
	sub r1, r1, #0x2800
	bl glue_01801868
	ldmdb fp, {fp, sp, pc}
lit_003c:
	.rword data_05e0			; relocated
str_0040:
	.asciz "evt.ex.outofmem"
str_0050:
	.asciz "evt.ex"
	.align 4

sub_0058:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	teq r4, #0
	bne loc_008c
	mov r0, r6
	bl glue_01800850
	mov r1, #1
	bl glue_01802b58
	mov r4, r0
loc_008c:
	mov r0, r6
	bl glue_01800850
	mov r3, r4
	mov r1, r5
	mov r2, #1
	bl glue_01802b74
	mov r0, #0
	strb r0, [r5, r4]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_00b0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, r4
	bl glue_01800850
	mov r1, #1
	bl glue_01802b58
	add r6, r0, #1
	mov r0, r6
	bl glue_01801810
	mov r5, r0
	sub r2, r6, #1
	mov r1, r0
	mov r0, r4
	bl sub_0058
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_00f8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #0x18
	add r0, sp, #8
	bl glue_01800d54
	mov r3, sp
	stmdb sp!, {r3}
	add r3, sp, #8
	mov r2, r4
	mov r1, r5
	add r0, sp, #0xc
	bl glue_01801228
	add sp, sp, #4
	ldr r6, lit_0190
	teq r0, #0
	bne loc_0194
	mov r2, r4
	mov r1, r5
	add r0, sp, #8
	bl glue_0180157c
	mov r4, r0
	ldr r0, [sp, #4]
	teq r0, #0
	blne glue_01801780
	ldr r0, [sp]
	teq r0, #0
	blne glue_01801780
	teq r4, #0
	beq loc_0188
	mov r1, r4
	mov r2, #0
	ldr r0, [r6, #4]!
	bl glue_01801868
loc_0188:
	mov r4, #1
	b loc_01b4
lit_0190:
	.rword data_05e0			; relocated
loc_0194:
	add ip, r0, #0x2740
	cmn ip, #0x13
	beq loc_01b0
	mov r1, r0
	mov r2, #0
	ldr r0, [r6, #4]!
	bl glue_01801868
loc_01b0:
	mov r4, #0
loc_01b4:
	add r0, sp, #8
	mov r1, #0
	bl glue_01800dd0
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_01c8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, r1
	mov r4, r2
	sub sp, sp, #0x50
	add r1, sp, #0x2c
	mov r2, #0
	bl sub_0058
	add r1, sp, #8
	mov r0, r4
	mov r2, #0
	bl sub_0058
	sub sp, sp, #0x10
	mov r0, sp
	bl glue_01800d54
	add r3, sp, #0x10
	stmdb sp!, {r3}
	add r3, sp, #0x18
	add r2, sp, #0x1c
	add r1, sp, #0x40
	add r0, sp, #4
	bl glue_01801228
	add sp, sp, #4
	teq r0, #0
	bne loc_0334
	sub sp, sp, #4
	adr r0, str_0328, #30
	bl glue_018029cc
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	mov r1, #2
	bl glue_01800804
	mov r5, r0
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	sub sp, sp, #8
	ldr r0, [sp, #0x20]
	teq r0, #0
	beq loc_02bc
	bl glue_0180099c
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r4, sp
	mov r1, r5
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	mov r1, #0
	mov r2, r4
	bl glue_018029e4
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
loc_02bc:
	sub sp, sp, #8
	ldr r0, [sp, #0x24]
	teq r0, #0
	beq loc_0314
	bl glue_0180099c
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r4, sp
	mov r1, r5
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	mov r1, #1
	mov r2, r4
	bl glue_018029e4
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
loc_0314:
	add r0, sp, #0x14
	mov r1, #0
	bl glue_01800dd0
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
str_0328:
	.asciz "NameServer"
	.align 4
loc_0334:
	add ip, r0, #0x2740
	cmn ip, #0x13
	beq loc_0368
	mov r1, r0
	ldr r0, lit_0364
	ldr r0, [r0, #4]
	mov r2, #0
	bl glue_01801868
	mov r0, sp
	mov r1, #0
	bl glue_01800dd0
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_0364:
	.rword data_05e0			; relocated
loc_0368:
	mov r0, sp
	mov r1, #0
	bl glue_01800dd0
	mov r0, #2
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_037c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, r1
	mov r4, r2
	sub sp, sp, #0x48
	add r1, sp, #0x24
	mov r2, #0
	bl sub_0058
	mov r1, sp
	mov r0, r4
	mov r2, #0
	bl sub_0058
	mov r1, sp
	add r0, sp, #0x24
	bl sub_00f8
	teq r0, #0
	moveq r0, #2
	movne r0, #0x1a
	ldmdb fp, {r4, fp, sp, pc}
loc_03cc:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, r1
	mov r4, r3
	ldr sb, [fp, #0x14]
	sub sp, sp, #0x58
	add r0, sp, #0x48
	bl glue_01800d54
	mov r6, #0
	mov r7, #0
	sub sp, sp, #4
	mov r0, sp
	mov r1, #2
	bl glue_01802b80
	mov r1, sp
	mov r0, r4
	bl glue_0180297c
	teq r0, #0
	movne r8, #0
	moveq r8, #1
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	movs r0, r8
	ldr r8, lit_059c
	beq loc_046c
	mov r0, r4
	bl glue_01800968
	teq r0, #0
	moveq r1, r4
	moveq r0, #0xee
	subeq r0, r0, #0xbe00
	bleq glue_01802b28
	mov r0, r4
	bl sub_00b0
	movs r6, r0
	subeq sp, sp, #4
	beq loc_05ac
loc_046c:
	sub sp, sp, #4
	mov r0, sp
	mov r1, #2
	bl glue_01802b80
	mov r1, sp
	mov r0, sb
	bl glue_0180297c
	teq r0, #0
	movne r4, #0
	moveq r4, #1
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	teq r4, #0
	beq loc_04d4
	mov r0, sb
	bl glue_01800968
	teq r0, #0
	moveq r1, sb
	moveq r0, #0xee
	subeq r0, r0, #0xbe00
	bleq glue_01802b28
	mov r0, sb
	bl sub_00b0
	movs r7, r0
	beq loc_05a0
loc_04d4:
	mov r0, r5
	bl glue_01800850
	mov r1, #1
	bl glue_01802b58
	add sb, r0, #1
	mov r4, #0xad
	sub r4, r4, #0xbd00
	cmp sb, #0x20
	bls sub_0508
	mov r2, #0
	mov r1, r4
	ldr r0, [r8, #4]
	bl glue_01801868

sub_0508:
	mov r2, sb
	add r1, sp, #0x2c
	mov r0, r5
	bl sub_0058
	ldr r0, [fp, #0xc]
	bl glue_01800850
	mov r1, #1
	bl glue_01802b58
	add r5, r0, #1
	cmp r5, #0x20
	bls sub_0544
	mov r2, #0
	mov r1, r4
	ldr r0, [r8, #4]
	bl glue_01801868

sub_0544:
	mov r2, r5
	add r1, sp, #8
	ldr r0, [fp, #0xc]
	bl sub_0058
	add r1, sp, #8
	add r0, sp, #0x2c
	bl sub_00f8
	mov r3, r7
	stmdb sp!, {r3}
	mov r3, r6
	add r2, sp, #0xc
	add r1, sp, #0x30
	add r0, sp, #0x54
	bl glue_0180133c
	add sp, sp, #4
	movs sl, r0
	bne loc_05b4
	add r0, sp, #0x50
	mov r1, #0
	bl glue_01800dd0
	mov r0, #2
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_059c:
	.rword data_05e0			; relocated
loc_05a0:
	teq r6, #0
	movne r0, r6
	blne glue_01800dac
loc_05ac:
	mov r0, #0
	bl sub_0014
loc_05b4:
	mov r1, sl
	mov r2, #0
	ldr r0, [r8, #4]!
	bl glue_01801868
	add sp, sp, #8
	add r0, sp, #0x48
	mov r1, #0
	bl glue_01800dd0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_05d8:
	mov r0, #0x2a
	mov pc, lr
data_05e0:
	.rword str_0040				; relocated
	.rword str_0050				; relocated
	.rword sub_05d8				; relocated

glue_01802b74:
	ldr pc, lit_05f0
lit_05f0:
	.word 0x01802b74			; glue 01802b74

glue_01801780:
	ldr pc, lit_05f8
lit_05f8:
	.word 0x01801780			; glue 01801780

glue_0180297c:
	ldr pc, lit_0600
lit_0600:
	.word 0x0180297c			; glue 0180297c

glue_01800850:
	ldr pc, lit_0608
lit_0608:
	.word 0x01800850			; glue 01800850

glue_01800968:
	ldr pc, lit_0610
lit_0610:
	.word 0x01800968			; glue 01800968

glue_01801228:
	ldr pc, lit_0618
lit_0618:
	.word 0x01801228			; glue 01801228

glue_0180099c:
	ldr pc, lit_0620
lit_0620:
	.word 0x0180099c			; glue 0180099c

glue_018029cc:
	ldr pc, lit_0628
lit_0628:
	.word 0x018029cc			; glue 018029cc

glue_01801810:
	ldr pc, lit_0630
lit_0630:
	.word 0x01801810			; glue 01801810

glue_0180133c:
	ldr pc, lit_0638
lit_0638:
	.word 0x0180133c			; glue 0180133c

glue_018029e4:
	ldr pc, lit_0640
lit_0640:
	.word 0x018029e4			; glue 018029e4

glue_01801868:
	ldr pc, lit_0648
lit_0648:
	.word 0x01801868			; glue 01801868

glue_01802b28:
	ldr pc, lit_0650
lit_0650:
	.word 0x01802b28			; glue 01802b28

glue_01802b58:
	ldr pc, lit_0658
lit_0658:
	.word 0x01802b58			; glue 01802b58

glue_0180157c:
	ldr pc, lit_0660
lit_0660:
	.word 0x0180157c			; glue 0180157c

glue_01800d54:
	ldr pc, lit_0668
lit_0668:
	.word 0x01800d54			; glue 01800d54

glue_01802b80:
	ldr pc, lit_0670
lit_0670:
	.word 0x01802b80			; glue 01802b80

glue_01800dac:
	ldr pc, lit_0678
lit_0678:
	.word 0x01800dac			; glue 01800dac

glue_01800dd0:
	ldr pc, lit_0680
lit_0680:
	.word 0x01800dd0			; glue 01800dd0

glue_01802054:
	ldr pc, lit_0688
lit_0688:
	.word 0x01802054			; glue 01802054
