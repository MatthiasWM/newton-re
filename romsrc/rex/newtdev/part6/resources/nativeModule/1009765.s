; a nativeModule binary (obj_1009765)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	.origin 0x9770		; the part's offset in its package as linked (.rword values add it)


sub_0000:
	b loc_1148

sub_0004:
	b loc_1310

sub_0008:
	b loc_09a8

sub_000c:
	b loc_0ac8

sub_0010:
	b loc_0b08

sub_0014:
	b loc_0b40

sub_0018:
	b loc_0b88

glue_018019a8:
	ldr pc, lit_0020
lit_0020:
	.word 0x018019a8			; glue 018019a8

glue_018019d8:
	ldr pc, lit_0028
lit_0028:
	.word 0x018019d8			; glue 018019d8

glue_018019f8:
	ldr pc, lit_0030
lit_0030:
	.word 0x018019f8			; glue 018019f8

glue_01801748:
	ldr pc, lit_0038
lit_0038:
	.word 0x01801748			; glue 01801748

glue_01800e70:
	ldr pc, lit_0040
lit_0040:
	.word 0x01800e70			; glue 01800e70

glue_01800804:
	ldr pc, lit_0048
lit_0048:
	.word 0x01800804			; glue 01800804

glue_01800808:
	ldr pc, lit_0050
lit_0050:
	.word 0x01800808			; glue 01800808

glue_01801620:
	ldr pc, lit_0058
lit_0058:
	.word 0x01801620			; glue 01801620

sub_005c:
	b loc_0180

sub_0060:
	b glue_018019f8

sub_0064:
	b loc_0378

sub_0068:
	b glue_018019a8

sub_006c:
	b glue_01801b48

sub_0070:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r1
	mov r5, r2
	mov r4, r3
	teq r0, #0
	bne loc_00a0
	mov r0, #0xc
	bl glue_01800e04
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
loc_00a0:
	str r4, [r0, #8]
	str r5, [r0, #4]
	str r6, [r0]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
str_00b0:
	.asciz "evt.ex.outofmem"

sub_00c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r7, r3
	teq r4, #0
	bne loc_00f4
	mov r0, #0x2c
	bl glue_01800e04
	movs r4, r0
	beq loc_0108
loc_00f4:
	mov r3, r7
	mov r2, r5
	mov r1, r6
	mov r0, r4
	bl sub_0070
loc_0108:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_0110:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	teq r4, #0
	bne loc_0138
	mov r0, #0x24
	bl glue_01800e04
	movs r4, r0
	beq loc_0148
loc_0138:
	mov r0, r4
	bl glue_018018d4
	ldr r0, lit_0150
	str r0, [r4]
loc_0148:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_0150:
	.rword sub_005c				; relocated

sub_0154:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r4, #0x14]
	teq r0, #0
	blne glue_01800dac
	bl glue_018010a0
	mov r1, r4
	bl glue_018019d8
	ldmdb fp, {r4, fp, sp, pc}
loc_0180:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, lit_01d0
	str r0, [r4]
	mov r0, r4
	mov r1, #0
	bl sub_005c
	ldr r0, [r4, #0x14]
	teq r0, #0
	blne glue_01800dac
	mov r0, r4
	mov r1, #0
	bl glue_0180193c
	tst r5, #1
	movne r0, r4
	blne glue_01800dac
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_01d0:
	.rword sub_005c				; relocated

sub_01d4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, r4
	bl glue_01800850
	mov r1, #1
	bl glue_01802b58
	mov r6, r0
	add r0, r0, #1
	bl glue_01801810
	movs r5, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r0, r4
	bl glue_01800850
	mov r3, r6
	mov r1, r5
	mov r2, #1
	bl glue_01802b74
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_022c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r7, #0
	mov r0, r5
	bl glue_018029b8
	str r0, [r4, #0x18]
	mov r0, r6
	bl sub_01d4
	str r0, [r4, #0x1c]
	mov r0, #0
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	mov r0, r0, lsl #4
	bl glue_01800e04
	str r0, [r4, #0x14]
	teq r0, #0
	moveq r0, #0x11
	subeq r0, r0, #0xf000
	ldmdbeq fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
	mov r6, #0
	ldr r0, [r4, #0x18]
	cmp r0, #0
	bls sub_035c
	mov sl, #2
	mov sb, #0x11
loc_02a0:
	sub sp, sp, #4
	mov r1, r6
	mov r0, r5
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029d8
	teq r0, #2
	movne r8, #0
	moveq r8, #1
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	teq r8, #0
	ldrne r0, [r4, #0x14]
	strne sl, [r0, r6, lsl #2]
	bne loc_0348
	sub sp, sp, #4
	mov r1, r6
	mov r0, r5
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029d8
	teq r0, #0x11
	movne r8, #0
	moveq r8, #1
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	teq r8, #0
	ldrne r0, [r4, #0x14]
	strne sb, [r0, r6, lsl #2]
	bne loc_0344
	mov r0, #0x10
	sub r0, r0, #0xf000
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_0344:
	add sp, sp, #4
loc_0348:
	add sp, sp, #4
	add r6, r6, #1
	ldr r0, [r4, #0x18]
	cmp r0, r6
	bhi loc_02a0

sub_035c:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
str_0364:
	.asciz "evt.ex.EventHandler"
loc_0378:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r3
	mov r0, #0
	str r0, [sp, #-0x6c]!
	add r0, sp, #8
	bl glue_01800040
	teq r0, #0
	bne loc_0898
	mov r0, sp
	bl glue_01801748
	sub sp, sp, #0x30
	adr r0, str_057c
	bl glue_018029cc
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r5, sp
	adr r0, str_0594
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	mov r1, r5
	bl glue_018026ec
	mov r1, r0
	add r0, sp, #0x2c
	bl glue_01802b80
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	adr r0, str_05a4, #30
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0xc
	bl glue_01802b80
	add r5, sp, #0xc
	adr r0, str_0594
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0x10
	bl glue_01802b80
	add r0, sp, #0x10
	mov r1, r5
	bl glue_018026ec
	mov r1, r0
	add r0, sp, #8
	bl glue_01802b80
	add r0, sp, #8
	bl glue_018029d8
	mov sl, r0
	add r0, sp, #8
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0xc
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x10
	mov r1, #0
	bl glue_01802054
	ldr r0, [r4, #0x1c]
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0x28
	bl glue_01802b80
	add r1, sp, #0x28
	add r0, sp, #0x2c
	bl glue_01802988
	mov r1, r0
	add r0, sp, #0x24
	bl glue_01802b80
	adr r0, str_05b8
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0x14
	bl glue_01802b80
	add r1, sp, #0x14
	add r0, sp, #0x24
	bl glue_01802988
	mov r1, r0
	add r0, sp, #0x20
	bl glue_01802b80
	add r0, sp, #0x14
	mov r1, #0
	bl glue_01802054
	adr r0, str_05c8, #30
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0x18
	bl glue_01802b80
	add r1, sp, #0x18
	add r0, sp, #0x24
	bl glue_01802988
	mov r1, r0
	add r0, sp, #0x1c
	bl glue_01802b80
	add r0, sp, #0x18
	mov r1, #0
	bl glue_01802054
	mov r5, #0
	add r6, r6, #0xc
	ldr r0, [r4, #0x18]
	cmp r0, #0
	bls sub_06e8
	sub sb, sp, #0x70
loc_0534:
	sub sp, sp, #4
	ldr r0, [r4, #0x14]
	ldr r0, [r0, r5, lsl #2]
	teq r0, #2
	bne loc_05d0
	ldr r0, [r6]
	bl glue_018029c8
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r2, sp
	mov r1, r5
	add r0, sp, #0x20
	bl glue_018029e4
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	b loc_06d0
str_057c:
	.asciz "LanternEventRegistry"
	.align 4
str_0594:
	.asciz "GetGlobalVar"
	.align 4
str_05a4:
	.asciz "LanternClientCount"
	.align 4
str_05b8:
	.asciz "HandlerProcs"
	.align 4
str_05c8:
	.asciz "Args"
	.align 4
loc_05d0:
	teq r0, #0x11
	bne loc_06d0
	sub sp, sp, #8
	ldr r0, [r6]
	bl glue_018017c4
	mov r7, r0
	adr r0, str_0644, #30
	bl glue_018029cc
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	mov r1, r7
	bl glue_01800808
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	bl glue_01802c84
	teq r0, #0
	bne loc_064c
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add sp, sp, #0xc
	b loc_0830
str_0644:
	.asciz "Binary"
	.align 4
loc_064c:
	mov r0, #0
	mov r8, #0
	str r0, [sp, #-0x6c]!
	mov r0, sb
	bl glue_01800040
	teq r0, #0
	bne loc_06a4
	mov r0, sp
	bl glue_01801748
	add r0, sp, #0x70
	bl glue_018029bc
	mov r1, r0
	mov r2, r7
	ldr r0, [r6]
	bl glue_01801620
	add r2, sp, #0x70
	mov r1, r5
	add r0, sp, #0x94
	bl glue_018029e4
	mov r0, sp
	bl glue_01801784
	b loc_06a8
loc_06a4:
	mov r8, #1
loc_06a8:
	add r0, sp, #0x70
	bl glue_01802b54
	teq r8, #0
	movne r0, sp
	blne glue_01801820
	add sp, sp, #0x6c
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add sp, sp, #8
loc_06d0:
	add sp, sp, #4
	add r6, r6, #4
	add r5, r5, #1
	ldr r0, [r4, #0x18]
	cmp r0, r5
	bhi loc_0534

sub_06e8:
	sub sp, sp, #4
	add r0, sp, #0x24
	bl glue_018029b8
	mov r8, r0
	mov r0, sp
	bl glue_01802b84
	ldr r0, [r4, #0x20]
	add r0, r0, #1
	str r0, [r4, #0x20]
	teq r0, #1
	bne sub_0810
	mov r7, #0
	cmp r8, #0
	bls sub_0810

sub_0720:
	sub sp, sp, #0x14
	mov r1, r7
	add r0, sp, #0x38
	bl glue_01802984
	mov r1, r0
	add r0, sp, #0x14
	bl glue_01802b90
	adr r0, str_0874, #30
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0xc
	bl glue_01802b80
	add r1, sp, #0xc
	add r0, sp, #0x14
	bl glue_01802988
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r6, sp
	adr r0, str_087c
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #0x10
	bl glue_01802b80
	add r1, sp, #0x10
	add r0, sp, #0x14
	bl glue_01802988
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r5, sp, #4
	adr r0, str_0888, #30
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #8
	bl glue_01802b80
	add r0, sp, #8
	add r3, sp, #0x34
	mov r1, r5
	mov r2, r6
	bl glue_018026f4
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add r0, sp, #8
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0xc
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x10
	mov r1, #0
	bl glue_01802054
	add sp, sp, #0x14
	add r7, r7, #1
	cmp r7, r8
	blo sub_0720

sub_0810:
	ldr r0, [r4, #0x20]
	cmp r0, sl
	movhs r0, #0
	strhs r0, [r4, #0x20]!
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add sp, sp, #4
loc_0830:
	add r0, sp, #0x1c
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x20
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x24
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x28
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x2c
	mov r1, #0
	bl glue_01802054
	add sp, sp, #0x30
	b loc_08b4
str_0874:
	.asciz "Message"
str_087c:
	.asciz "Receiver"
	.align 4
str_0888:
	.asciz "AddDeferredSend"
loc_0898:
	ldr r0, [sp, #0x60]
	ldr r1, lit_08c0
	ldr r1, [r1, #4]
	bl glue_01801860
	teq r0, #0
	moveq r0, sp
	bleq glue_01801820
loc_08b4:
	mov r0, sp
	bl glue_01801784
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_08c0:
	.rword data_13a8			; relocated

sub_08c4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #4
	adr r0, str_0968, #30
	bl glue_018029cc
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r1, sp
	mov r0, r4
	bl glue_01802988
	mov r5, r0
	sub sp, sp, #8
	mov r0, sp
	mov r1, #2
	bl glue_01802b80
	mov r4, sp
	mov r1, r5
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	mov r1, r4
	bl glue_0180297c
	movs r4, r0
	movne r4, #1
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	teq r4, #0
	movne r4, #0
	moveq r4, r5
	add r0, sp, #8
	mov r1, #0
	bl glue_01802054
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
str_0968:
	.asciz "_ClientAPI"
	.align 4

sub_0974:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #8
	bl glue_01800850
	mov r1, sp
	mov r3, #4
	mov r2, #1
	bl glue_01802b74
	ldr r0, [sp], #8
	ldmdb fp, {fp, sp, pc}

sub_09a0:
	mov r0, #1
	mov pc, lr
loc_09a8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	adr r1, str_09e0, #30
	adr r0, str_09ec, #30
	bl glue_01801258
	movs r5, r0
	bne loc_0a00
	mov r0, #0x24
	sub r0, r0, #0xf000
	bl glue_018029c8
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
str_09e0:
	.asciz "TClientAPI"
	.align 4
str_09ec:
	.asciz "TLanternClientAPI"
	.align 4
loc_0a00:
	mov r0, #1
	strb r0, [r5, #0x10]
	mov r0, r6
	bl sub_01d4
	movs r6, r0
	subeq sp, sp, #8
	beq loc_0a90
	mov r3, r6
	mov r2, r5
	mov r0, r5
	mov r1, #0
	bl sub_1430
	movs r7, r0
	sub sp, sp, #8
	bne loc_0aa4
	mov r1, r5
	mov r0, sp
	bl glue_01802b80
	mov r5, sp
	adr r0, str_0a98, #30
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r1, sp, #4
	mov r0, r4
	mov r2, r5
	bl glue_01800a34
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	mov r0, r6
	bl glue_01801780
loc_0a90:
	mov r0, #2
	b loc_0ac4
str_0a98:
	.asciz "_ClientAPI"
	.align 4
loc_0aa4:
	mov r0, r5
	bl sub_13fc
	mov r0, r6
	bl glue_01801780
	teq r7, #0
	beq loc_0a90
	mov r0, r7
	bl glue_018029c8
loc_0ac4:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0ac8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl sub_08c4
	teq r0, #0
	moveq r0, #0x8a
	subeq r0, r0, #0xf000
	beq loc_0afc
	ldr r1, lit_0b04
	bl sub_1448
	teq r0, #0
	moveq r0, #2
	ldmdbeq fp, {fp, sp, pc}
loc_0afc:
	bl glue_018029c8
	ldmdb fp, {fp, sp, pc}
lit_0b04:
	.rword sub_09a0				; relocated
loc_0b08:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl sub_08c4
	teq r0, #0
	moveq r0, #0x8a
	subeq r0, r0, #0xf000
	beq loc_0b38
	bl sub_1460
	teq r0, #0
	moveq r0, #2
	ldmdbeq fp, {fp, sp, pc}
loc_0b38:
	bl glue_018029c8
	ldmdb fp, {fp, sp, pc}
loc_0b40:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl sub_08c4
	teq r0, #0
	bne loc_0b68
	mov r0, #0x8a
	sub r0, r0, #0xf000
	bl glue_018029c8
	ldmdb fp, {fp, sp, pc}
loc_0b68:
	bl sub_13fc
	mov r0, #2
	ldmdb fp, {fp, sp, pc}
str_0b74:
	.asciz "evt.ex.Cpostdriver"
	.align 4
loc_0b88:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2
	sub sp, sp, #4
	mov r6, #0
	bl sub_08c4
	str r0, [sp]
	teq r0, #0
	bne loc_0bc4
	mov r0, #0x8a
	sub r0, r0, #0xf000
	bl glue_018029c8
	b loc_1140
loc_0bc4:
	sub sp, sp, #0x68
	mov r0, r4
	mov r1, #3
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029b8
	mov r8, r0
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	mov r0, r4
	mov r1, #2
	bl glue_01802984
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	bl glue_018029b8
	mov r7, r0
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	mov r0, r4
	mov r1, #1
	bl glue_01802984
	mov r1, r0
	add r0, sp, #0x40
	bl glue_01802b80
	add r0, sp, #0x40
	mov r1, #0
	bl glue_01802984
	mov r1, r0
	add r0, sp, #8
	bl glue_01802b80
	add r0, sp, #8
	bl sub_0974
	mov sb, r0
	add r0, sp, #8
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x40
	mov r1, #1
	bl glue_01802984
	mov r1, r0
	add r0, sp, #0xc
	bl glue_01802b80
	add r0, sp, #0xc
	bl sub_0974
	mov sl, r0
	add r0, sp, #0xc
	mov r1, #0
	bl glue_01802054
	mov r3, r7
	mov r2, sl
	mov r1, sb
	add r0, sp, #0x14
	bl sub_00c0
	mov r0, r4
	mov r1, #2
	bl glue_01802984
	mov r1, r0
	add r0, sp, #0x10
	bl glue_01802b80
	mov sb, #0
	mov r0, #0
	sub sp, sp, #0x68
	stmdb sp!, {r0, sb}
	add r0, sp, #0xc
	bl glue_01800040
	teq r0, #0
	bne loc_0e18
	add r0, sp, #4
	bl glue_01801748
	mov r6, #0
	cmp r7, #0
	bls sub_0dcc

sub_0d00:
	sub sp, sp, #4
	mov r1, r6
	add r0, sp, #0x84
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029d8
	mov sb, r0
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	teq sb, #2
	beq loc_0d7c
	teq sb, #0x11
	bne loc_0dbc
	sub sp, sp, #8
	mov r1, r6
	mov r0, r5
	bl glue_01802984
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	bl glue_018029bc
	add r1, sp, #0x90
	add r1, r1, r6, lsl #2
	str r0, [r1, #0xc]!
	add r0, sp, #4
	b loc_0db0
loc_0d7c:
	sub sp, sp, #8
	mov r1, r6
	mov r0, r5
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029d8
	add r1, sp, #0x90
	add r1, r1, r6, lsl #2
	str r0, [r1, #0xc]!
	mov r0, sp
loc_0db0:
	mov r1, #0
	bl glue_01802054
	add sp, sp, #8
loc_0dbc:
	add sp, sp, #4
	add r6, r6, #1
	cmp r6, r7
	blo sub_0d00

sub_0dcc:
	mov r3, #0
	mov r2, #0
	mov r1, #0
	mov r0, #0x20
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0xc8
	stmdb sp!, {r3}
	ldr r0, [sp, #0xec]
	bl sub_1514
	mov r1, #0xc
	add r3, r1, r7, lsl #2
	add r2, sp, #0x98
	add r1, sp, #0xc8
	bl sub_1344
	add sp, sp, #0x14
	mov r6, r0
	add r0, sp, #4
	bl glue_01801784
	b loc_0e20
loc_0e18:
	mov r0, #1
	str r0, [sp]
loc_0e20:
	mov sb, #0
	cmp r7, #0
	bls sub_0eac

sub_0e2c:
	sub sp, sp, #8
	mov r1, sb
	add r0, sp, #0x88
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029d8
	teq r0, #0x11
	movne sl, #0
	moveq sl, #1
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	teq sl, #0
	beq loc_0e9c
	mov r1, sb
	mov r0, r5
	bl glue_01802984
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r0, sp, #4
	bl glue_01802b54
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
loc_0e9c:
	add sp, sp, #8
	add sb, sb, #1
	cmp sb, r7
	blo sub_0e2c

sub_0eac:
	ldr r0, [sp]
	teq r0, #0
	addne r0, sp, #4
	blne glue_01801820
	add sp, sp, #0x70
	teq r6, #0
	bne loc_1110
	teq r8, #0
	beq loc_10f0
	sub sp, sp, #0xc
	mov r0, r4
	mov r1, #3
	bl glue_01802984
	mov r1, r0
	add r0, sp, #8
	bl glue_01802b80
	mov r0, sp
	mov r1, #2
	bl glue_01802b80
	mov r0, sp
	mov r1, r8
	bl glue_01800804
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	mov r4, #0
	cmp r8, #0
	bls sub_10ac
	mov sb, #0
	sub r7, sp, #0x74

sub_0f30:
	sub sp, sp, #4
	mov r1, r4
	add r0, sp, #0xc
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl glue_018029d8
	mov r5, r0
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	teq r5, #2
	beq loc_1030
	teq r5, #0x11
	bne loc_109c
	sub sp, sp, #0xc
	add r0, sp, #0x64
	add r0, r0, r4, lsl #2
	mov r6, r0
	mov r5, r0
	bl glue_018017c4
	mov sl, r0
	mov r0, r5
	bl glue_018017c4
	mov r5, r0
	adr r0, str_1028, #30
	bl glue_018029cc
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	mov r1, r5
	bl glue_01800808
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	mov r5, #0
	mov r0, r7
	str sb, [sp, #-0x6c]!
	bl glue_01800040
	teq r0, #0
	bne loc_1070
	mov r0, sp
	bl glue_01801748
	add r0, sp, #0x70
	bl glue_018029bc
	mov r1, r0
	mov r0, r6
	mov r2, sl
	bl glue_01801620
	add r2, sp, #0x70
	mov r1, r4
	add r0, sp, #0x80
	bl glue_018029e4
	mov r0, sp
	bl glue_01801784
	b loc_1074
str_1028:
	.asciz "Binary"
	.align 4
loc_1030:
	sub sp, sp, #4
	add r0, sp, #0x5c
	ldr r0, [r0, r4, lsl #2]
	bl glue_018029c8
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r2, sp
	mov r1, r4
	add r0, sp, #0xc
	bl glue_018029e4
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add sp, sp, #4
	b loc_109c
loc_1070:
	mov r5, #1
loc_1074:
	add r0, sp, #0x70
	bl glue_01802b54
	teq r5, #0
	movne r0, sp
	blne glue_01801820
	add sp, sp, #0x6c
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add sp, sp, #0xc
loc_109c:
	add sp, sp, #4
	add r4, r4, #1
	cmp r4, r8
	blo sub_0f30

sub_10ac:
	add r0, sp, #4
	bl glue_01802c84
	mov r4, r0
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add r0, sp, #8
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x1c
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x4c
	mov r1, #0
	bl glue_01802054
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_10f0:
	add r0, sp, #0x10
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x40
	mov r1, #0
	bl glue_01802054
	mov r0, #2
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_1110:
	mov r1, r6
	ldr r0, lit_1144
	ldr r0, [r0, #8]
	mov r2, #0
	bl glue_01801868
	add r0, sp, #0x10
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0x40
	mov r1, #0
	bl glue_01802054
	add sp, sp, #0x68
loc_1140:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_1144:
	.rword data_13a8			; relocated
loc_1148:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r6, r2
	mov r5, r3
	ldr sl, [fp, #4]
	mov r0, #0x24
	bl glue_0180180c
	mov r7, r0
	mov r1, r0
	mov r0, #0x24
	bl sub_133c
	teq r0, #0
	blne sub_0110
	teq r7, #0
	bne loc_119c
	mov r0, #0x12
	sub r0, r0, #0xf000
	bl glue_018029c8
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_119c:
	sub sp, sp, #0x10
	mov r0, r4
	mov r1, #1
	bl glue_01802984
	mov r1, r0
	add r0, sp, #0xc
	bl glue_01802b80
	add r0, sp, #0xc
	mov r1, #0
	bl glue_01802984
	mov r1, r0
	mov r0, sp
	bl glue_01802b80
	mov r0, sp
	bl sub_0974
	mov sb, r0
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0xc
	mov r1, #1
	bl glue_01802984
	mov r1, r0
	add r0, sp, #8
	bl glue_01802b80
	add r0, sp, #8
	bl sub_0974
	mov r8, r0
	mov r0, r4
	mov r1, #2
	bl glue_01802984
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	mov r3, r5
	stmdb sp!, {r3}
	mov r3, r6
	add r2, sp, #8
	add r1, sp, #0xc
	mov r0, r7
	bl sub_022c
	add sp, sp, #4
	movs r4, r0
	bne loc_12b8
	mov r2, sb
	mov r1, r8
	mov r0, r7
	bl glue_01801b7c
	movs r4, r0
	bne loc_12b8
	sub sp, sp, #8
	mov r1, r7
	mov r0, sp
	bl glue_01802b80
	mov r5, sp
	adr r0, str_12cc, #30
	bl glue_018029cc
	mov r1, r0
	add r0, sp, #4
	bl glue_01802b80
	add r1, sp, #4
	mov r0, sl
	mov r2, r5
	bl glue_01800a34
	mov r0, sp
	mov r1, #0
	bl glue_01802054
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add sp, sp, #8
loc_12b8:
	teq r4, #0
	beq loc_12dc
	mov r0, r4
	bl glue_018029c8
	b loc_12e0
str_12cc:
	.asciz "EventHandler"
	.align 4
loc_12dc:
	mov r0, #2
loc_12e0:
	mov r4, r0
	add r0, sp, #4
	mov r1, #0
	bl glue_01802054
	add r0, sp, #8
	mov r1, #0
	bl glue_01802054
	add r0, sp, #0xc
	mov r1, #0
	bl glue_01802054
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_1310:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, r1
	bl glue_01802c84
	mov r4, r0
	bl sub_0154
	mov r0, r4
	bl glue_01801780
	mov r0, #2
	ldmdb fp, {r4, fp, sp, pc}

sub_133c:
	mov r0, r1
	mov pc, lr

sub_1344:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov lr, r2
	mov ip, r3
	ldr r3, [fp, #0x14]
	and r6, r3, #0xff
	ldmib fp, {r0, r1, r2, r7}
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	mov r2, #0
	mov r1, r7
	mov r0, ip
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, lr
	stmdb sp!, {r3}
	mov r3, r4
	mov r0, r5
	mov r2, #2
	mov r1, #1
	bl glue_01801418
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
data_13a8:
	.rword str_00b0				; relocated
	.rword str_0364				; relocated
	.rword str_0b74				; relocated

sub_13b4:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_13bc:
	.asciz "TLanternClientAPI"
	.align 4

sub_13d0:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_13b4
	bl glue_01800e70
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_13fc:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_1410
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_1410:
	ldmia sp!, {r0, lr}
	b glue_01801028

sub_1418:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_1424:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_1430:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_143c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_1448:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_1454:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_1460:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_146c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_1478:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_1484:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_1490:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_149c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

sub_14a8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_14b4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x44

sub_14c0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x48

sub_14cc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x4c

sub_14d8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x50

sub_14e4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x54

sub_14f0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x58

sub_14fc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x5c

sub_1508:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x60

sub_1514:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x64

glue_01802b74:
	ldr pc, lit_1524
lit_1524:
	.word 0x01802b74			; glue 01802b74

glue_01801780:
	ldr pc, lit_152c
lit_152c:
	.word 0x01801780			; glue 01801780

glue_0180297c:
	ldr pc, lit_1534
lit_1534:
	.word 0x0180297c			; glue 0180297c

glue_01801784:
	ldr pc, lit_153c
lit_153c:
	.word 0x01801784			; glue 01801784

glue_01801028:
	ldr pc, lit_1544
lit_1544:
	.word 0x01801028			; glue 01801028

glue_01802984:
	ldr pc, lit_154c
lit_154c:
	.word 0x01802984			; glue 01802984

glue_01800850:
	ldr pc, lit_1554
lit_1554:
	.word 0x01800850			; glue 01800850

glue_01802988:
	ldr pc, lit_155c
lit_155c:
	.word 0x01802988			; glue 01802988

glue_018010a0:
	ldr pc, lit_1564
lit_1564:
	.word 0x018010a0			; glue 018010a0

glue_018017c4:
	ldr pc, lit_156c
lit_156c:
	.word 0x018017c4			; glue 018017c4

glue_01801b48:
	ldr pc, lit_1574
lit_1574:
	.word 0x01801b48			; glue 01801b48

glue_01801b7c:
	ldr pc, lit_157c
lit_157c:
	.word 0x01801b7c			; glue 01801b7c

glue_018029b8:
	ldr pc, lit_1584
lit_1584:
	.word 0x018029b8			; glue 018029b8

glue_018029bc:
	ldr pc, lit_158c
lit_158c:
	.word 0x018029bc			; glue 018029bc

glue_018029c8:
	ldr pc, lit_1594
lit_1594:
	.word 0x018029c8			; glue 018029c8

glue_018029cc:
	ldr pc, lit_159c
lit_159c:
	.word 0x018029cc			; glue 018029cc

glue_018026f4:
	ldr pc, lit_15a4
lit_15a4:
	.word 0x018026f4			; glue 018026f4

glue_018026ec:
	ldr pc, lit_15ac
lit_15ac:
	.word 0x018026ec			; glue 018026ec

glue_01801258:
	ldr pc, lit_15b4
lit_15b4:
	.word 0x01801258			; glue 01801258

glue_0180180c:
	ldr pc, lit_15bc
lit_15bc:
	.word 0x0180180c			; glue 0180180c

glue_01801810:
	ldr pc, lit_15c4
lit_15c4:
	.word 0x01801810			; glue 01801810

glue_01801820:
	ldr pc, lit_15cc
lit_15cc:
	.word 0x01801820			; glue 01801820

glue_018029d8:
	ldr pc, lit_15d4
lit_15d4:
	.word 0x018029d8			; glue 018029d8

glue_01801418:
	ldr pc, lit_15dc
lit_15dc:
	.word 0x01801418			; glue 01801418

glue_018029e4:
	ldr pc, lit_15e4
lit_15e4:
	.word 0x018029e4			; glue 018029e4

glue_01800a34:
	ldr pc, lit_15ec
lit_15ec:
	.word 0x01800a34			; glue 01800a34

glue_01801860:
	ldr pc, lit_15f4
lit_15f4:
	.word 0x01801860			; glue 01801860

glue_01801868:
	ldr pc, lit_15fc
lit_15fc:
	.word 0x01801868			; glue 01801868

glue_01802b58:
	ldr pc, lit_1604
lit_1604:
	.word 0x01802b58			; glue 01802b58

glue_01802b54:
	ldr pc, lit_160c
lit_160c:
	.word 0x01802b54			; glue 01802b54

glue_01802b90:
	ldr pc, lit_1614
lit_1614:
	.word 0x01802b90			; glue 01802b90

glue_018018d4:
	ldr pc, lit_161c
lit_161c:
	.word 0x018018d4			; glue 018018d4

glue_01802b80:
	ldr pc, lit_1624
lit_1624:
	.word 0x01802b80			; glue 01802b80

glue_01802b84:
	ldr pc, lit_162c
lit_162c:
	.word 0x01802b84			; glue 01802b84

glue_01800dac:
	ldr pc, lit_1634
lit_1634:
	.word 0x01800dac			; glue 01800dac

glue_0180193c:
	ldr pc, lit_163c
lit_163c:
	.word 0x0180193c			; glue 0180193c

glue_01802054:
	ldr pc, lit_1644
lit_1644:
	.word 0x01802054			; glue 01802054

glue_01800e04:
	ldr pc, lit_164c
lit_164c:
	.word 0x01800e04			; glue 01800e04

glue_01802c84:
	ldr pc, lit_1654
lit_1654:
	.word 0x01802c84			; glue 01802c84

glue_01800040:
	ldr pc, lit_165c
lit_165c:
	.word 0x01800040			; glue 01800040
