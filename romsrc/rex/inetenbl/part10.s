; "Newton Internet Enabler" part 10: protocol (18340 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	; .origin: the address its first byte falls at, worked out where it is built

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
	.word 0x00020000			; fVersion
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
	.asciz "TDNSTool"
InterfaceName:
	.asciz "TCommToolProtocol"
Signature:
	.asciz "ctiv"
	.asciz "2"
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
	b Method35				; dispatch slot 35
	b Method36				; dispatch slot 36
	b Method37				; dispatch slot 37
	b Method38				; dispatch slot 38
	b Method39				; dispatch slot 39
	b Method40				; dispatch slot 40
	b Method41				; dispatch slot 41
	b Method42				; dispatch slot 42
	b Method43				; dispatch slot 43
	b Method44				; dispatch slot 44
	b Method45				; dispatch slot 45
	b Method46				; dispatch slot 46
	b Method47				; dispatch slot 47
	b Method48				; dispatch slot 48
	b Method49				; dispatch slot 49
	b Method50				; dispatch slot 50
	b Method51				; dispatch slot 51
	b Method52				; dispatch slot 52
	b Method53				; dispatch slot 53
	b Method54				; dispatch slot 54
	b Method55				; dispatch slot 55
	b Method56				; dispatch slot 56
	b Method57				; dispatch slot 57
	b Method58				; dispatch slot 58
	b Method59				; dispatch slot 59
	b Method60				; dispatch slot 60
	b Method61				; dispatch slot 61
	b Method62				; dispatch slot 62
	b Method63				; dispatch slot 63

Abort__14TUAsyncMessageFv:
	ldr pc, lit_0174
lit_0174:
	.word 0x01800e18			; glue 01800e18 -> Abort__14TUAsyncMessageFv

AtEOF__11CBufferListCFv:
	ldr pc, lit_017c
lit_017c:
	.word 0x01801a14			; glue 01801a14 -> AtEOF__11CBufferListCFv

At__5CListFl:
	ldr pc, lit_0184
lit_0184:
	.word 0x01801a10			; glue 01801a10 -> At__5CListFl

BlockMove:
	ldr pc, lit_018c
lit_018c:
	.word 0x01801620			; glue 01801620 -> BlockMove

sub_0190:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_01b4
	mov r0, #0x38
	bl __nw__FUi
	movs r4, r0
	beq loc_0244
loc_01b4:
	mov r5, #0
	strb r5, [r4, #0x17]
	strb r5, [r4, #0x16]
	ldr r0, [r4, #0x16]
	mov r0, r0, lsr #16
	orr r0, r0, #0x100
	strb r0, [r4, #0x17]
	mov r0, r0, asr #8
	strb r0, [r4, #0x16]
	mov r0, #1
	strb r0, [r4, #0xe]
	str r5, [r4, #0x28]
	str r5, [r4, #0x30]
	str r5, [r4, #0x34]
	strb r5, [r4, #0x1d]
	strb r5, [r4, #0x1c]
	strb r5, [r4, #0x1f]
	strb r5, [r4, #0x1e]
	strb r5, [r4, #0x2d]
	strb r5, [r4, #0x2c]
	strb r5, [r4, #0x2f]
	strb r5, [r4, #0x2e]
	strb r5, [r4, #0x21]
	strb r5, [r4, #0x20]
	strb r5, [r4, #0x23]
	strb r5, [r4, #0x22]
	mov r0, #0x2a
	strb r0, [r4, #0x15]
	strb r5, [r4, #0x14]
	add r0, r4, #1
	mov r1, #0xa
	bl ZeroBytes
	strb r5, [r4, #0xd]
	strb r5, [r4, #0xc]
	str r5, [r4, #0x24]
	strb r5, [r4]
loc_0244:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_024c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x28]
	teq r0, #0
	beq loc_027c
	mov r1, #1
	bl sub_0e74
	mov r0, #0
	str r0, [r4, #0x28]
loc_027c:
	mov r0, r4
	bl sub_08cc
	ldrb r0, [r4]
	teq r0, #0
	ldrne r0, [r4, #0x24]
	teqne r0, #0
	movne r1, #1
	blne sub_25bc
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_02b0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2, lsl #16
	mov r5, r5, lsr #16
	mov r6, r3, lsl #16
	mov r6, r6, lsr #16
	mov r1, r5
	mov r0, r4
	bl At__5CListFl
	mov r7, r0
	mov r1, r6
	mov r0, r4
	bl At__5CListFl
	mov r2, r0
	mov r1, r5
	mov r0, r4
	bl ReplaceAt__5CListFlPv
	mov r2, r7
	mov r1, r6
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b ReplaceAt__5CListFlPv

sub_0310:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, r2, lsl #16
	mov r7, r7, lsr #16
	mov r6, r3, lsl #16
	mov r6, r6, lsr #16
	ldr r0, [fp, #4]
	mov r3, r0, lsl #16
	mov r3, r3, lsr #16
	teq r3, r7
	beq loc_0358
	mov r2, r7
	mov r1, r4
	mov r0, r5
	bl sub_02b0
loc_0358:
	mov r8, r7
	add r0, r7, #1
	mov r7, r0, lsl #16
	mov r7, r7, lsr #16
	cmp r7, r6
	bgt loc_03f0

sub_0370:
	mov r1, r7
	mov r0, r4
	bl At__5CListFl
	ldr sl, [r0, #0xa]
	mov sl, sl, lsr #16
	mov r1, r8
	mov r0, r4
	bl At__5CListFl
	ldr sb, [r0, #0xa]
	mov sb, sb, lsr #16
	mov r1, r6
	mov r0, r4
	bl At__5CListFl
	ldr r0, [r0, #0xa]
	mov r0, r0, lsr #16
	cmp sl, sb
	addle r0, r7, #1
	movle r7, r0, lsl #16
	movle r7, r7, lsr #16
	ble sub_03e8
	cmp r0, sb
	subgt r0, r6, #1
	movgt r6, r0, lsl #16
	movgt r6, r6, lsr #16
	bgt sub_03e8
	mov r3, r6
	mov r2, r8
	mov r1, r4
	mov r0, r5
	bl sub_02b0

sub_03e8:
	cmp r7, r6
	ble sub_0370
loc_03f0:
	teq r6, r8
	beq loc_040c
	mov r3, r6
	mov r2, r8
	mov r1, r4
	mov r0, r5
	bl sub_02b0
loc_040c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_0414:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2, lsl #16
	mov r6, r6, lsr #16
	mov r7, r3, lsl #16
	mov r7, r7, lsr #16
	cmp r6, r7
	ldmdbge fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	add r0, r6, r7
	add r0, r0, r0, lsr #31
	mov r0, r0, asr #1
	mov r3, r0, lsl #16
	mov r3, r3, lsr #16
	stmdb sp!, {r3}
	mov r3, r7
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_0310
	add sp, sp, #4
	mov r8, r0
	cmp r6, r0
	bge loc_0490
	sub r3, r8, #1
	mov r2, r6
	mov r1, r4
	mov r0, r5
	bl sub_0414
loc_0490:
	cmp r8, r7
	ldmdbge fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	add r2, r8, #1
	mov r3, r7
	mov r1, r4
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b sub_0414

sub_04b0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	mov r7, r1, lsl #16
	mov r7, r7, lsr #16
	mov r6, #0
	mov r0, #0
	teq r7, #1
	bne loc_05b8
	ldr r1, [r4, #0x30]
	teq r1, #0
	beq loc_0690
	ldr r3, [r4, #0x2c]
	mov r3, r3, lsr #16
	stmdb sp!, {r3}
	mov r3, r0
	mov r2, r7
	mov r0, r4
	bl sub_06a0
	add sp, sp, #4
	mov r8, r0
	ldr r1, [r4, #0x2c]
	cmp r0, r1, lsr #16
	bge loc_0690

sub_0518:
	mov r1, r8
	ldr r0, [r4, #0x30]
	bl At__5CListFl
	mov r6, r0
	teq r5, #0
	beq loc_0544
	mov r0, r5
	ldr r1, [r6, #0x1c]
	bl strcmp
	teq r0, #0
	bne loc_0578
loc_0544:
	mov r1, r8
	mov r2, #1
	ldr r0, [r4, #0x30]
	bl RemoveElementsAt__13CDynamicArrayFlT1
	teq r0, #0
	bne loc_0698
	ldr r0, [r4, #0x2c]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x2d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x2c]
	b loc_0690
loc_0578:
	mov r6, #0
	add r0, r8, #1
	ldr r3, [r4, #0x2c]
	mov r3, r3, lsr #16
	stmdb sp!, {r3}
	mov r3, r0
	mov r2, r7
	ldr r1, [r4, #0x30]
	mov r0, r4
	bl sub_06a0
	add sp, sp, #4
	mov r8, r0
	ldr r1, [r4, #0x2c]
	cmp r0, r1, lsr #16
	blt sub_0518
	b loc_0690
loc_05b8:
	ldr r1, [r4, #0x34]
	teq r1, #0
	beq loc_0690
	ldr r3, [r4, #0x1e]
	mov r3, r3, lsr #16
	stmdb sp!, {r3}
	mov r3, r0
	mov r2, r7
	mov r0, r4
	bl sub_06a0
	add sp, sp, #4
	mov r8, r0
	ldr r1, [r4, #0x2e]
	cmp r0, r1, lsr #16
	bge loc_0690

sub_05f4:
	mov r1, r8
	ldr r0, [r4, #0x34]
	bl At__5CListFl
	mov r6, r0
	teq r5, #0
	beq loc_0620
	mov r0, r5
	ldr r1, [r6, #0x1c]
	bl strcmp
	teq r0, #0
	bne loc_0654
loc_0620:
	mov r1, r8
	mov r2, #1
	ldr r0, [r4, #0x34]
	bl RemoveElementsAt__13CDynamicArrayFlT1
	teq r0, #0
	bne loc_0698
	ldr r0, [r4, #0x2e]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x2f]
	mov r0, r0, asr #8
	strb r0, [r4, #0x2e]
	b loc_0690
loc_0654:
	mov r6, #0
	add r0, r8, #1
	ldr r3, [r4, #0x1e]
	mov r3, r3, lsr #16
	stmdb sp!, {r3}
	mov r3, r0
	mov r2, r7
	ldr r1, [r4, #0x34]
	mov r0, r4
	bl sub_06a0
	add sp, sp, #4
	mov r8, r0
	ldr r1, [r4, #0x2e]
	cmp r0, r1, lsr #16
	blt sub_05f4
loc_0690:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_0698:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_06a0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r7, r2, lsl #16
	mov r7, r7, lsr #16
	ldr r0, [fp, #4]
	mov r6, r0, lsl #16
	mov r6, r6, lsr #16
	mov r5, r3
	cmp r3, r6
	bge loc_06fc

sub_06d0:
	mov r1, r5
	mov r0, r4
	bl At__5CListFl
	teq r0, #0
	ldrne r0, [r0, #4]
	movne r0, r0, lsr #16
	teqne r0, r7
	beq loc_06fc
	add r5, r5, #1
	cmp r5, r6
	blt sub_06d0
loc_06fc:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_0704:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1, lsl #16
	mov r6, r6, lsr #16
	mov r5, #0
	ldr r0, [r0, #0x28]
	teq r0, #0
	beq loc_0744
	mov r1, #1
	bl sub_0e74
	mov r0, #0
	str r0, [r4, #0x28]
	strb r0, [r4, #0x1d]
	strb r0, [r4, #0x1c]
loc_0744:
	mov r2, r6
	mov r0, #0
	ldr r1, [r4, #0x24]
	bl sub_0dcc
	str r0, [r4, #0x28]
	teq r0, #0
	moveq r5, #0xa8
	subeq r5, r5, #0x1c00
	beq loc_0780
	ldr r0, [r4, #0x1c]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x1d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x1c]
loc_0780:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0788:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	mov r0, r1
	bl AtEOF__11CBufferListCFv
	mov r7, #0x2b0
	sub r7, r7, #0xf000
	teq r0, #0
	bne loc_087c
	add r1, r4, #0x14
	mov r0, r5
	mov r2, #2
	bl Putn__11CBufferListFPCUcl
	teq r0, #2
	bne loc_086c
	ldrb r0, [r4, #0xe]
	teq r0, #0
	bne loc_07f4
	ldr r0, [r4, #0x16]
	mov r0, r0, lsr #16
	orr r0, r0, #0x8000
	strb r0, [r4, #0x17]
	mov r0, r0, asr #8
	strb r0, [r4, #0x16]
loc_07f4:
	add r1, r4, #0x16
	mov r0, r5
	mov r2, #2
	bl Putn__11CBufferListFPCUcl
	teq r0, #2
	bne loc_086c
	add r1, r4, #0x1c
	mov r0, r5
	mov r2, #2
	bl Putn__11CBufferListFPCUcl
	teq r0, #2
	bne loc_086c
	sub sp, sp, #8
	mov r0, sp
	mov r1, #6
	bl ZeroBytes
	mov r1, sp
	mov r0, r5
	mov r2, #6
	bl Putn__11CBufferListFPCUcl
	teq r0, #6
	bne loc_0868
	ldr r0, [r4, #0x28]!
	teq r0, #0
	beq loc_0874
	mov r1, r5
	bl sub_0ed0
	movs r6, r0
	beq loc_0874
loc_0868:
	add sp, sp, #8
loc_086c:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0874:
	add sp, sp, #8
	b loc_0880
loc_087c:
	mov r6, r7
loc_0880:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_0888:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2, lsl #16
	mov r5, r5, lsr #16
	cmp r5, #0xa
	movge r2, #0xa
	movlt r2, r5
	add r3, r4, #1
	mov r0, r1
	mov r1, r3
	bl BlockMove
	strb r5, [r4, #0xd]
	mov r0, r5, lsr #8
	strb r0, [r4, #0xc]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_08cc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x30]
	teq r0, #0
	beq loc_0930
	ldr r6, [r0]
	cmp r6, #0
	movgt r5, #0
	ble sub_0920

sub_08f8:
	mov r1, r5
	ldr r0, [r4, #0x30]
	bl At__5CListFl
	teq r0, #0
	beq sub_0920
	mov r1, #1
	bl sub_1cf0
	add r5, r5, #1
	cmp r5, r6
	blt sub_08f8

sub_0920:
	ldr r0, [r4, #0x30]
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
loc_0930:
	ldr r0, [r4, #0x34]
	teq r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	ldr r6, [r0]
	cmp r6, #0
	movgt r5, #0
	ble sub_0974

sub_094c:
	mov r1, r5
	ldr r0, [r4, #0x34]
	bl At__5CListFl
	teq r0, #0
	beq sub_0974
	mov r1, #1
	bl sub_1cf0
	add r5, r5, #1
	cmp r5, r6
	blt sub_094c

sub_0974:
	ldr r0, [r4, #0x34]!
	teq r0, #0
	movne r1, #1
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne __dt__5CListFv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_098c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r5, r1
	ldr r7, lit_0a1c
	moveq r0, r7
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	add r1, r4, #0x14
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_0b04
	add r1, r4, #0x16
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_0b04
	ldr r0, [r4, #0x16]
	mov r0, r0, lsr #16
	ands r1, r0, #0xf
	strb r1, [r4, #0x18]
	ldr r6, lit_0a20
	beq loc_0a58
	cmp r1, #5
	addls pc, pc, r1, lsl #2
	b loc_0a4c
	b loc_0a4c
	b loc_0a28
	b loc_0a34
	b loc_0b70
	b loc_0a40

sub_0a14:
	ldr r0, lit_0a24
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_0a1c:
	.word 0xffffc94b
lit_0a20:
	.word 0xffff1283
lit_0a24:
	.word 0xffff127b
loc_0a28:
	mvn r0, #0x81
	sub r0, r0, #0xed00
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0a34:
	mvn r0, #0x82
	sub r0, r0, #0xed00
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0a40:
	mvn r0, #0x83
	sub r0, r0, #0xed00
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0a4c:
	mov r0, #0x7a
	sub r0, r0, #0xee00
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0a58:
	tst r0, #0x8000
	movne r1, #0
	moveq r1, #1
	strb r1, [r4, #0xe]
	and r1, r0, #0x7800
	mov r1, r1, lsr #11
	strb r1, [r4, #0x19]
	and r1, r0, #0x400
	mov r1, r1, lsr #10
	strb r1, [r4, #0xf]
	and r1, r0, #0x200
	mov r1, r1, lsr #9
	strb r1, [r4, #0x12]
	and r1, r0, #0x100
	mov r1, r1, lsr #8
	strb r1, [r4, #0x10]
	and r0, r0, #0x80
	mov r0, r0, lsr #7
	strb r0, [r4, #0x11]
	add r1, r4, #0x1c
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_0b04
	add r1, r4, #0x1e
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_0b04
	add r1, r4, #0x20
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_0b04
	add r1, r4, #0x22
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	beq loc_0b0c
loc_0b04:
	mov r6, r7
	b loc_0c0c
loc_0b0c:
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #1
	ble sub_0b48
	ldr r0, [r4, #0x20]
	mov r0, r0, lsr #16
	ldr r1, [r4, #0x22]
	mov r1, r1, lsr #16
	add r0, r0, r1
	ldr r1, [r4, #0x1e]
	mov r1, r1, lsr #16
	add r0, r0, r1
	strb r0, [r4, #0x1f]
	mov r0, r0, asr #8
	strb r0, [r4, #0x1e]

sub_0b48:
	ldr r0, [r4, #0x1e]
	mov r0, r0, lsr #16
	mov r7, #0
	cmp r0, #0x10
	movgt r0, #0x10
	strbgt r0, [r4, #0x1f]
	strbgt r7, [r4, #0x1e]
	ldr r0, [r4, #0x1e]
	movs r0, r0, lsr #16
	bne loc_0b78
loc_0b70:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_0b78:
	ldr r0, [r4, #0x28]
	teq r0, #0
	beq loc_0b90
	mov r1, #1
	bl sub_0e74
	str r7, [r4, #0x28]
loc_0b90:
	mov r0, #0
	bl sub_0e28
	str r0, [r4, #0x28]
	teq r0, #0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	beq loc_0c0c
	mov r1, r5
	bl sub_0f60
	movs r6, r0
	bne loc_0c0c
	ldr r0, [r4, #0x28]
	ldr r1, [r0, #2]
	mov r1, r1, lsr #16
	strb r1, [r4, #0x1b]
	mov r1, r1, asr #8
	strb r1, [r4, #0x1a]
	teq r0, #0
	movne r1, #1
	blne sub_0e74
	mov r1, r5
	str r7, [r4, #0x28]
	mov r0, r4
	bl sub_0c14
	mov r6, r0
	ldr r0, [r4, #0x1a]
	mov r0, r0, lsr #16
	teq r0, #0xf
	ldreq r1, [r4, #0x34]
	moveq r0, r4
	bleq sub_0dac
loc_0c0c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_0c14:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r8, #0
	mov r6, #0
	bl sub_08cc
	mov r0, #0
	bl __ct__5CListFv
	mov sb, #0xa8
	sub sb, sb, #0x1c00
	str r0, [r4, #0x30]
	teq r0, #0
	beq loc_0c84
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r4, #0x34]
	teq r0, #0
	beq loc_0c84
	ldr r0, [r4, #0x1e]
	mov r0, r0, lsr #16
	cmp r0, #0
	ble sub_0da4

sub_0c74:
	mov r0, #0
	bl sub_1c70
	movs r7, r0
	bne loc_0c8c
loc_0c84:
	mov r6, sb
	b sub_0da4
loc_0c8c:
	mov r1, r5
	mov r0, r7
	bl sub_1eb4
	movs r6, r0
	bne sub_0da4
	ldr r1, [r7, #4]
	mov r1, r1, lsr #16
	mov r2, #0
	mov r0, #0
	ldr r3, [r4, #0xc]
	mov r3, r3, lsr #16
	cmp r3, #0
	ble sub_0cec
loc_0cc0:
	add ip, r4, r0
	ldrb ip, [ip, #1]
	teq ip, r1
	beq loc_0d20
	add r0, r0, #1
	mov r0, r0, lsl #16
	mov r0, r0, lsr #16
	cmp r3, r0
	bgt loc_0cc0
	teq r2, #0
	bne loc_0d20

sub_0cec:
	movs r0, r7
	movne r1, #1
	blne sub_1cf0
	ldr r0, [r4, #0x1e]
	mov r0, r0, lsr #16
	sub r0, r0, #1
	strb r0, [r4, #0x1f]
	mov r0, r0, asr #8
	strb r0, [r4, #0x1e]
	sub r0, r8, #1
	mov r8, r0, lsl #16
	mov r8, r8, lsr #16
	b loc_0d8c
loc_0d20:
	teq r1, #1
	bne loc_0d5c
	mov r2, r7
	ldr r0, [r4, #0x30]
	ldr r1, [r0]
	bl InsertAt__5CListFlPv
	movs r6, r0
	bne sub_0da4
	ldr r0, [r4, #0x2c]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x2d]
	mov r0, r0, asr #8
	strb r0, [r4, #0x2c]
	b loc_0d8c
loc_0d5c:
	mov r2, r7
	ldr r0, [r4, #0x34]
	ldr r1, [r0]
	bl InsertAt__5CListFlPv
	movs r6, r0
	ldr r0, [r4, #0x2e]
	mov r0, r0, lsr #16
	add r0, r0, #1
	strb r0, [r4, #0x2f]
	mov r0, r0, asr #8
	strb r0, [r4, #0x2e]
	bne sub_0da4
loc_0d8c:
	add r0, r8, #1
	mov r8, r0, lsl #16
	mov r8, r8, lsr #16
	ldr r0, [r4, #0x1e]
	cmp r8, r0, lsr #16
	blt sub_0c74

sub_0da4:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_0dac:
	ldr r2, [r1]
	cmp r2, #0
	movle pc, lr
	sub r2, r2, #1
	mov r3, r2, lsl #16
	mov r3, r3, lsr #16
	mov r2, #0
	b sub_0414

sub_0dcc:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r5, r2, lsl #16
	mov r5, r5, lsr #16
	teq r0, #0
	bne loc_0dfc
	mov r0, #0x10
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
loc_0dfc:
	mov r1, #1
	strb r1, [r0, #5]
	mov r1, #0
	strb r1, [r0, #4]
	strb r5, [r0, #3]
	mov r2, r5, lsr #8
	strb r2, [r0, #2]
	str r1, [r0, #0xc]
	str r4, [r0, #8]
	strb r1, [r0]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0e28:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_0e4c
	mov r0, #0x10
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_0e4c:
	mov r1, #0
	strb r1, [r0]
	mov r2, #1
	strb r2, [r0, #5]
	strb r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	strb r2, [r0, #3]
	strb r1, [r0, #2]
	ldmdb fp, {fp, sp, pc}

sub_0e74:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldrb r0, [r0]
	teq r0, #0
	ldrne r0, [r4, #8]
	teqne r0, #0
	movne r1, #1
	blne sub_25bc
	mov r6, #0
	str r6, [r4, #8]
	ldr r0, [r4, #0xc]
	teq r0, #0
	beq loc_0ebc
	bl __dl__FPv
	str r6, [r4, #0xc]
loc_0ebc:
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_0ed0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, #0
	ldr r0, [r0, #8]
	mov r8, #0xa8
	sub r8, r8, #0x1c00
	ldr r7, [r0, #0x14]!
	teq r7, #0
	beq loc_0f54
	mov r0, r7
	bl strlen
	add r2, r0, #1
	mov sb, r2
	mov r1, r7
	mov r0, r4
	bl Putn__11CBufferListFPCUcl
	teq r0, sb
	bne loc_0f54
	add r1, r5, #2
	mov r0, r4
	mov r2, #2
	bl Putn__11CBufferListFPCUcl
	teq r0, #2
	bne loc_0f54
	add r1, r5, #4
	mov r0, r4
	mov r2, #2
	bl Putn__11CBufferListFPCUcl
	teq r0, #2
	beq loc_0f58
loc_0f54:
	mov r6, r8
loc_0f58:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_0f60:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	ldr r0, [r0, #0xc]
	teq r0, #0
	beq loc_0f90
	bl __dl__FPv
	mov r0, #0
	str r0, [r4, #0xc]
loc_0f90:
	mov r0, r5
	bl sub_42fc
	str r0, [r4, #0xc]
	teq r0, #0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	beq loc_0fe4
	add r1, r4, #2
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	ldr r7, lit_0fec
	teq r0, #2
	bne loc_0fe0
	add r1, r4, #4
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	beq loc_0fe4
loc_0fe0:
	mov r6, r7
loc_0fe4:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_0fec:
	.word 0xffffc94b

sub_0ff0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_1014
	mov r0, #0x3c
	bl __nw__FUi
	movs r4, r0
	beq loc_1064
loc_1014:
	mov r0, #0
	str r0, [r4]
	str r0, [r4, #4]
	str r0, [r4, #0x1c]
	str r0, [r4, #0x20]
	str r0, [r4, #0x24]
	str r0, [r4, #0x28]
	strb r0, [r4, #0x33]
	strb r0, [r4, #0x32]
	strb r0, [r4, #0x31]
	strb r0, [r4, #0x30]
	str r0, [r4, #0x34]
	str r0, [r4, #0x38]
	str r0, [r4, #0x18]
	str r0, [r4, #0x14]
	str r0, [r4, #0xc]
	str r0, [r4, #0x10]
	mov r0, #0
	bl sub_21a0
	str r0, [r4, #8]
loc_1064:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_106c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_166c
	mov r6, #0
	ldr r0, [r4, #8]
	teq r0, #0
	beq loc_10a0
	mov r1, #1
	bl sub_25bc
	str r6, [r4, #8]
loc_10a0:
	ldr r0, [r4, #0x10]
	teq r0, #0
	beq loc_10bc
	mov r1, #1
	bl __dt__5CListFv
	str r6, [r4, #0x10]
	str r6, [r4, #0xc]
loc_10bc:
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_10d0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x38]
	teq r0, #0
	bne loc_1100
	mov r0, r4
	mov r1, #0x200
	bl sub_1ba0
	str r0, [r4, #0x38]
	b loc_1104
loc_1100:
	bl Reset__11CBufferListFv
loc_1104:
	ldr r0, [r4, #0x38]!
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	movne r0, #0
	ldmdb fp, {r4, fp, sp, pc}

sub_111c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	bl sub_0190
	str r0, [r4, #0x14]
	teq r0, #0
	moveq r5, #0xa8
	subeq r5, r5, #0x1c00
	beq loc_1214
	ldr r1, [r4, #0x20]
	ldr r1, [r1, #0x14]
	mov r1, r1, lsl #16
	mov r1, r1, lsr #16
	strb r1, [r0, #0x15]
	mov r1, r1, asr #8
	strb r1, [r0, #0x14]
	mov r2, #0
	ldr r0, [r4, #0x14]
	ldr r1, [r4, #8]
	str r1, [r0, #0x24]!
	ldr r0, [r4, #0x32]
	mov r0, r0, lsr #16
	teq r0, #0x40
	strbne r0, [r4, #0x31]
	movne r0, r0, lsr #8
	strbne r0, [r4, #0x30]
	moveq r0, #0xf
	strbeq r0, [r4, #0x31]
	strbeq r2, [r4, #0x30]
	ldr r1, [r4, #0x30]
	mov r1, r1, lsr #16
	ldr r0, [r4, #0x14]
	bl sub_0704
	mov r0, r4
	bl sub_1c24
	movs r5, r0
	bne loc_1214
	mov r0, r4
	bl sub_10d0
	movs r5, r0
	bne loc_1214
	ldr r0, [r4, #0x14]
	ldr r1, [r4, #0x34]
	bl sub_0788
	movs r5, r0
	bne loc_1214
	ldr r0, [r4, #0x34]
	bl Position__11CBufferListCFv
	mov r6, r0
	ldr r0, [r4, #0x34]
	bl GetSize__11CBufferListCFv
	sub r1, r0, r6
	mov r2, #1
	ldr r0, [r4, #0x34]
	bl Hide__11CBufferListFli
	ldr r0, [r4, #0x34]
	bl ResetMark__11CBufferListFv
	ldr r0, [r4]
	orr r0, r0, #1
	str r0, [r4]
loc_1214:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_121c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x14]
	teq r0, #0
	beq loc_1254
	mov r5, #0
	strb r5, [r0]
	ldr r0, [r4, #0x14]
	teq r0, #0
	movne r1, #1
	blne sub_024c
	str r5, [r4, #0x14]
loc_1254:
	ldr r0, [r4]
	bic r0, r0, #1
	str r0, [r4]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1264:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldmia r0, {r0, r5}
	tst r0, #2
	bne loc_12fc
	teq r5, #0
	beq loc_12a8
	mov r0, r4
	bl sub_19a0
	teq r0, #0
	movne r0, #0
	strne r0, [r4, #4]
	bne loc_12a8
	teq r5, #0
	bne loc_12fc
loc_12a8:
	ldr r0, [r4]
	tst r0, #1
	bne loc_12c4
	mov r0, r4
	bl sub_111c
	movs r5, r0
	bne loc_12fc
loc_12c4:
	mov r0, r4
	bl sub_17e4
	movs r5, r0
	bne loc_12fc
	ldr r0, [r4, #0x1c]
	ldr r1, [r4, #0x38]
	bl sub_3684
	movs r5, r0
	bne loc_12fc
	ldr r0, [r4, #0x1c]
	ldr r1, [r4, #0x34]
	bl sub_33a4
	movs r5, r0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
loc_12fc:
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_16e0
loc_130c:
	ldr r3, [r0, #0x38]
	teq r3, #0
	moveq pc, lr
	teq r1, #0
	bne loc_132c
	cmp r2, #0
	movhi r1, r2
	bhi loc_133c
loc_132c:
	ldr r2, [r0, #4]
	teq r2, #0
	streq r1, [r0, #4]
	b sub_1264
loc_133c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0xc
	mov r8, #0
	ldr r0, [r0, #0x38]
	bl ResetMark__11CBufferListFv
	ldr r0, [r4, #0x18]
	teq r0, #0
	movne r1, #1
	blne sub_024c
	mov r0, #0
	bl sub_0190
	mov sl, #0xa8
	sub sl, sl, #0x1c00
	str r0, [r4, #0x18]
	teq r0, #0
	beq loc_1460
	mov r6, #0
	strb r6, [r0, #0xe]
	ldr r2, [r4, #0x32]
	mov r2, r2, lsr #16
	mov r0, #1
	teq r2, #0xc
	beq loc_13cc
	mov r1, #0xf
	teq r2, #0xf
	strbeq r1, [sp]
	beq loc_13d4
	teq r2, #0x40
	strbeq r1, [sp]
	strbeq r0, [sp, #1]
	moveq r2, #2
	beq loc_13d8
	b loc_13d0
loc_13cc:
	mov r0, #0xc
loc_13d0:
	strb r0, [sp]
loc_13d4:
	mov r2, #1
loc_13d8:
	mov r1, sp
	ldr r0, [r4, #0x18]
	bl sub_0888
	ldr r0, [r4, #0x18]
	ldr r1, [r4, #0x38]
	bl sub_098c
	movs r5, r0
	beq loc_1430
	ldr r6, lit_142c
	teq r5, r6
	addne ip, r5, #0x3680
	cmnne ip, #0x35
	bne loc_152c
	mov r0, r4
	bl sub_1998
	teq r0, #0
	movne r5, r6
	bne loc_1534
	mov r0, r4
	bl sub_121c
	b loc_1540
lit_142c:
	.word 0xffff1283
loc_1430:
	ldr r1, [r4, #0x32]
	movs r1, r1, lsr #16
	beq loc_1540
	mov r0, r4
	bl sub_154c
	movs r7, r0
	beq loc_1504
loc_144c:
	mov r1, r7
	mov r0, #0
	bl sub_29cc
	movs r6, r0
	bne loc_1468
loc_1460:
	mov r5, sl
	b loc_1534
loc_1468:
	mov r0, r7
	bl sub_1fd8
	mov r5, r0
	mov r0, r7
	bl sub_2000
	mov sb, r0
	ldr r0, [r6, #8]
	bic r0, r0, #0xff
	orr r0, r0, #0x80000000
	mov r3, r5
	mov r2, sb
	str r0, [r6, #8]
	mov r1, r6
	mov r0, r4
	bl sub_15c4
	mov r5, r0
	movs r0, r7
	movne r1, #1
	blne sub_1cf0
	mov r0, r6
	bl __dl__FPv
	mov r0, sb
	bl __dl__FPv
	teq r5, #0
	beq loc_14d8
	teq r5, #2
	moveq r5, #0
	b loc_14fc
loc_14d8:
	add r0, r8, #1
	mov r8, r0, lsl #16
	mov r8, r8, lsr #16
	ldr r1, [r4, #0x32]
	mov r1, r1, lsr #16
	mov r0, r4
	bl sub_154c
	movs r7, r0
	bne loc_144c
loc_14fc:
	teq r8, #0
	bne loc_1514
loc_1504:
	mov r0, r4
	bl sub_1998
	mov r5, r0
	b loc_152c
loc_1514:
	ldr r0, [r4]
	orr r0, r0, #2
	mov r6, #0
	str r0, [r4]
	strb r6, [r4, #0x33]
	strb r6, [r4, #0x32]
loc_152c:
	teq r5, #0
	beq loc_1540
loc_1534:
	ldr r0, [r4, #4]
	teq r0, #0
	streq r5, [r4, #4]
loc_1540:
	mov r0, r4
	bl sub_1264
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_154c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, r1, lsl #16
	mov r0, r0, lsr #16
	ldr r1, [r4, #0x32]
	mov r1, r1, lsr #16
	teq r0, #0x40
	moveq r1, #0xf
	mov r2, #0
	ldr r0, [r4, #0x18]
	bl sub_04b0
	movs r5, r0
	beq loc_15bc
	ldr r0, [r4, #0x32]
	mov r0, r0, lsr #16
	teq r0, #0x40
	bne loc_15bc
	mov r6, r5
	ldr r2, [r5, #0x20]
	mov r1, #1
	ldr r0, [r4, #0x18]!
	bl sub_04b0
	mov r5, r0
	mov r0, r6
	mov r1, #1
	bl sub_1cf0
loc_15bc:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_15c4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr r0, [r0, #0x28]
	ldr r8, [r0, #0xc]!
	ldr r0, [r4, #0x24]
	bl CurrentIndex__15TOptionIteratorFv
	mov r1, r0
	mov r0, r8
	ldr r2, lit_1660
	bl sub_4390
	str r0, [r4, #0x2c]
	sub ip, r0, #0x3e4
	teq ip, #3
	beq loc_1664
	mov r1, r0
	mov r0, r8
	bl OptionAt__12TOptionArrayFl
	teq r0, #0
	beq loc_1664
	add r1, r4, #0x28
	ldmia r1, {r0, r1}
	ldr r0, [r0, #0xc]
	bl RemoveOptionAt__12TOptionArrayFl
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	mov r3, r5
	stmdb sp!, {r3}
	add r4, r4, #0x24
	ldmib r4!, {r0, r1}
	ldr r0, [r0, #0xc]
	mov r3, r6
	mov r2, r7
	bl InsertVarOptionAt__12TOptionArrayFlP7TOptionPvUl
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_1660:
	.word 0x72726364			; 'rrcd'
loc_1664:
	mov r0, #2
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_166c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_121c
	mov r5, #0
	ldr r0, [r4, #0x18]
	teq r0, #0
	beq loc_169c
	mov r1, #1
	bl sub_024c
	str r5, [r4, #0x18]
loc_169c:
	str r5, [r4, #0x20]
	str r5, [r4, #0x24]
	str r5, [r4, #0x28]
	ldr r0, [r4, #0x34]
	teq r0, #0
	beq loc_16c0
	mov r1, #1
	bl __dt__11CBufferListFv
	str r5, [r4, #0x34]
loc_16c0:
	ldr r0, [r4, #0x38]
	teq r0, #0
	beq loc_16d8
	mov r1, #1
	bl __dt__11CBufferListFv
	str r5, [r4, #0x38]
loc_16d8:
	str r5, [r4, #4]!
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_16e0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0]
	tst r0, #4
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	orr r0, r0, #4
	str r0, [r4]
	mov r0, r4
	bl sub_1878
	mov r0, r4
	mov r1, #0
	bl sub_18c0
	ldr r0, [r4, #0x24]
	bl NextOption__15TOptionIteratorFv
	teq r0, #0
	beq loc_1780
	ldr r1, [r0]
	ldr r6, lit_1738
	b loc_1770
lit_1738:
	.word 0x72726364			; 'rrcd'
loc_173c:
	ldr r1, [r0, #8]
	and r2, r1, #0x80000000
	teq r2, #0x80000000
	beq loc_175c
	bic r1, r1, #0xff
	orr r1, r1, #0x80000000
	orr r1, r1, #0xfe
	str r1, [r0, #8]!
loc_175c:
	ldr r0, [r4, #0x24]
	bl NextOption__15TOptionIteratorFv
	teq r0, #0
	beq loc_1780
	ldr r1, [r0]
loc_1770:
	teq r0, #0
	beq loc_1780
	teq r1, r6
	beq loc_173c
loc_1780:
	mov r1, r5
	ldr r0, [r4, #0x1c]
	bl sub_3ac8
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_166c

sub_1798:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, #0
	teq r1, #0
	beq loc_17bc
	ldr r0, [r0, #8]
	bl sub_2780
	mov r2, r0
loc_17bc:
	mov r0, r2
	ldmdb fp, {fp, sp, pc}
loc_17c4:
	ldr r2, [r0, #0x34]
	teq r2, #0
	teqne r1, #0
	moveq pc, lr
	ldr r2, [r0, #4]
	teq r2, #0
	streq r1, [r0, #4]
	b sub_1264

sub_17e4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	mov r6, #0
loc_17fc:
	ldr r0, [r4, #0x1c]
	bl sub_2d3c
	bics r0, r0, #0xf0
	beq loc_1834
	teq r0, #2
	beq loc_1848
	teq r0, #6
	beq loc_1854
	teq r0, #0xe
	moveq r6, #1
	beq loc_1864
	ldr r5, lit_1830
	b loc_1870
lit_1830:
	.word 0xffffc17b
loc_1834:
	mov r2, #0
	mov r1, #2
	ldr r0, [r4, #0x1c]
	bl sub_2d48
	b loc_1860
loc_1848:
	ldr r0, [r4, #0x1c]
	bl sub_2f04
	b loc_1860
loc_1854:
	mov r1, #0
	ldr r0, [r4, #0x1c]
	bl sub_3010
loc_1860:
	mov r5, r0
loc_1864:
	teq r5, #0
	teqeq r6, #0
	beq loc_17fc
loc_1870:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1878:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, lit_18bc
	str r0, [r4, #4]
	ldr r0, [r4, #0x1c]
	bl sub_2d3c
	mov r5, r0
	tst r0, #0x10
	ldrne r0, [r4, #0x1c]
	blne sub_35d8
	tst r5, #0x40
	ldrne r0, [r4, #0x1c]!
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne sub_380c
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_18bc:
	.word 0xffffc17b

sub_18c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	mov r8, #1
	b loc_197c
loc_18e0:
	bl sub_2d3c
	mov r7, r0
	tst r0, #0x10
	beq loc_18fc
	tst r7, #0x20
	ldreq r0, [r4, #0x1c]
	bleq sub_35d8
loc_18fc:
	tst r7, #0x40
	beq loc_1910
	tst r7, #0x80
	ldreq r0, [r4, #0x1c]
	bleq sub_380c
loc_1910:
	bic r7, r7, #0xf0
	cmp r5, r7
	bhs loc_1988
	teq r7, #0
	moveq r8, #0
	beq loc_196c
	teq r7, #2
	beq loc_1954
	teq r7, #6
	beq loc_1960
	teq r7, #0xe
	ldrne r6, lit_1950
	bne loc_1988
	ldr r0, [r4, #0x1c]
	bl sub_3188
	b loc_1968
lit_1950:
	.word 0xffffc17b
loc_1954:
	ldr r0, [r4, #0x1c]
	bl sub_32c0
	b loc_1968
loc_1960:
	ldr r0, [r4, #0x1c]
	bl sub_3224
loc_1968:
	mov r6, r0
loc_196c:
	teq r6, #0
	bne loc_1988
	teq r8, #0
	beq loc_1988
loc_197c:
	ldr r0, [r4, #0x1c]
	teq r0, #0
	bne loc_18e0
loc_1988:
	teq r7, r5
	moveq r6, #0
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_1998:
	ldr r0, [r0, #8]
	b loc_2730

sub_19a0:
	ldr r1, [r0, #4]
	add r1, r1, #0x8f
	add r1, r1, #0xed00
	cmp r1, #0x15
	addls pc, pc, r1, lsl #2
	b loc_1a10
	b loc_1a0c
	b loc_1a0c
	b loc_1a10
	b loc_1a10
	b loc_1a10
	b loc_1a10
	b loc_1a10
	b loc_1a10
	b loc_1a10
	b loc_1a0c
	b loc_1a0c
	b loc_1a0c
	b loc_1a0c
	b loc_1a10
	b loc_1a0c
	b loc_1a0c
	b loc_1a10
	b loc_1a10
	b loc_1a0c
	b loc_1a0c
	b loc_1a10
loc_1a0c:
	b loc_1ac4
loc_1a10:
	mov r0, #0
	mov pc, lr

sub_1a18:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	movs r5, r1
	mov r6, #0
	moveq r6, #0x7a
	subeq r6, r6, #0x3f00
	beq loc_1a70
	ldr r0, [r4, #0x10]
	teq r0, #0
	bne loc_1a64
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r4, #0x10]
	teq r0, #0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	beq loc_1a70
loc_1a64:
	mov r1, r5
	ldr r0, [r4, #0x10]!
	bl InsertUnique__5CListFPv
loc_1a70:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1a78:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r1, #0
	str r1, [r4]
	ldr r2, [r0, #0x10]
	teq r2, #0
	beq loc_1ab8
	ldr r1, [r0, #0xc]!
	mov r0, r2
	bl At__5CListFl
	str r0, [r4]
	teq r0, #0
	movne r0, #0
	ldmdbne fp, {r4, fp, sp, pc}
loc_1ab8:
	mov r0, #0x86
	sub r0, r0, #0xee00
	ldmdb fp, {r4, fp, sp, pc}
loc_1ac4:
	ldr r2, [r0, #0x10]
	teq r2, #0
	moveq r0, #0
	moveq pc, lr
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]!
	mov r0, r2
	bl At__5CListFl
	movs r0, r0
	movne r0, #1
	and r0, r0, #0xff
	ldmdb fp, {fp, sp, pc}

sub_1b04:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0x7a
	sub r5, r5, #0x3f00
	mov r0, #0
	ldr ip, [fp, #4]
	str r0, [r4, #4]
	str r1, [r4, #0x1c]
	teq r1, #0
	str r0, [r4]
	beq loc_1b70
	str r2, [r4, #0x28]
	teq r2, #0
	beq loc_1b70
	str r3, [r4, #0x24]
	teq r3, #0
	beq loc_1b70
	str ip, [r4, #0x20]
	teq ip, #0
	beq loc_1b70
	mov r0, r4
	bl sub_1b78
	mov r5, r0
	mov r0, r4
	bl sub_1264
loc_1b70:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1b78:
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r1, [r0, #0x20]
	ldr r2, [r1, #0x1c]
	strb r2, [r0, #0x33]
	mov r2, r2, asr #8
	strb r2, [r0, #0x32]
	add r1, r1, #0x24
	ldr r0, [r0, #8]
	b loc_2820

sub_1ba0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	bl sub_440c
	movs r5, r0
	beq loc_1c1c
	mov r0, r5
	mov r1, #1
	bl Init__11CBufferListFUc
	teq r0, #0
	bne loc_1c08
	bl sub_4414
	movs r6, r0
	beq loc_1c08
	mov r1, r4
	mov r0, r6
	bl Init__14CBufferSegmentFl
	teq r0, #0
	bne loc_1c08
	mov r1, r6
	mov r0, r5
	bl InsertLast__11CBufferListFP7CBuffer
	teq r0, #0
	moveq r0, r5
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
loc_1c08:
	teq r5, #0
	beq loc_1c1c
	mov r0, r5
	mov r1, #1
	bl __dt__11CBufferListFv
loc_1c1c:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1c24:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x34]
	teq r0, #0
	bne loc_1c54
	mov r0, r4
	mov r1, #0x100
	bl sub_1ba0
	str r0, [r4, #0x34]
	b loc_1c58
loc_1c54:
	bl Reset__11CBufferListFv
loc_1c58:
	ldr r0, [r4, #0x34]!
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	movne r0, #0
	ldmdb fp, {r4, fp, sp, pc}

sub_1c70:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_1c94
	mov r0, #0x2c
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_1c94:
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #0x1c]
	str r1, [r0, #0x20]
	str r1, [r0, #0x24]
	mov r2, #0xe8
	str r1, [r0, #0x28]
	strb r2, [r0, #0xb]
	mov r2, #3
	strb r2, [r0, #0xa]
	str r1, [r0, #0x14]
	mov r2, #1
	str r1, [r0, #0x18]
	strb r2, [r0, #5]
	strb r1, [r0, #4]
	strb r2, [r0, #7]
	strb r1, [r0, #6]
	strb r1, [r0, #9]
	strb r1, [r0, #8]
	str r1, [r0, #0x10]
	strb r1, [r0, #0xd]
	strb r1, [r0, #0xc]
	ldmdb fp, {fp, sp, pc}

sub_1cf0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0x10]
	mov r6, #0
	teq r0, #0
	beq loc_1d24
	bl __dl__FPv
	str r6, [r4, #0x10]
	strb r6, [r4, #0xd]
	strb r6, [r4, #0xc]
loc_1d24:
	ldr r0, [r4, #0x1c]
	teq r0, #0
	beq loc_1d3c
	bl __dl__FPv
	str r6, [r4, #0x1c]
	str r6, [r4, #0x24]
loc_1d3c:
	ldr r0, [r4, #0x20]
	teq r0, #0
	beq loc_1d54
	bl __dl__FPv
	str r6, [r4, #0x20]
	str r6, [r4, #0x28]
loc_1d54:
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1d68:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r4, #0
	ldr r1, [r0, #0xc]
	mov r1, r1, lsr #16
	cmp r1, #0
	ble sub_1da4
	add r1, r0, #0xa
	mov r0, r2
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	ldrne r4, lit_1dac

sub_1da4:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_1dac:
	.word 0xffffc94b

sub_1db0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	add r1, r0, #4
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	ldr r7, lit_1e44
	teq r0, #2
	bne loc_1e38
	add r1, r4, #6
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_1e38
	add r1, r4, #8
	mov r0, r5
	mov r2, #4
	bl Getn__11CBufferListFPUcl
	teq r0, #4
	bne loc_1e38
	mov r0, #0
	strb r0, [r4, #0xd]
	strb r0, [r4, #0xc]
	add r1, r4, #0xc
	mov r0, r5
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	beq loc_1e3c
loc_1e38:
	mov r6, r7
loc_1e3c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_1e44:
	.word 0xffffc94b
loc_1e48:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	str r6, [r0, #0x10]
	ldr r0, [r0, #0xc]
	mov r0, r0, lsr #16
	cmp r0, #0
	ble sub_1eac
	bl __nw__FUi
	str r0, [r4, #0x10]
	movs r1, r0
	mov r7, #0xa8
	sub r7, r7, #0x1c00
	beq loc_1ea8
	ldr r2, [r4, #0xc]
	mov r2, r2, lsr #16
	mov r0, r5
	bl Getn__11CBufferListFPUcl
	ldr r1, [r4, #0xc]
	teq r0, r1, lsr #16
	beq sub_1eac
loc_1ea8:
	mov r6, r7

sub_1eac:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_1eb4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_2080
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	mov r1, r5
	mov r0, r4
	bl sub_1db0
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #4]
	mov r0, r0, lsr #16
	cmp r0, #5
	beq loc_1f38
	bgt loc_1f1c
	teq r0, #1
	moveq r1, r5
	moveq r0, r4
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq loc_2120
	teq r0, #2
	bne loc_1f48
	b loc_1f38
loc_1f1c:
	teq r0, #0xc
	beq loc_1f38
	teq r0, #0xf
	bne loc_1f48
	mov r1, r5
	mov r0, r4
	bl sub_1d68
loc_1f38:
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_20d0
loc_1f48:
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1e48

sub_1f58:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x1c]
	teq r0, #0
	moveq r0, #1
	beq loc_1f80
	bl strlen
	add r0, r0, #1
loc_1f80:
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x24]
	add r0, r0, #3
	bic r0, r0, #3
	str r0, [r4, #0x24]!
	ldmdb fp, {r4, fp, sp, pc}

sub_1f98:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x20]
	teq r0, #0
	moveq r0, #1
	beq loc_1fc0
	bl strlen
	add r0, r0, #1
loc_1fc0:
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x28]
	add r0, r0, #3
	bic r0, r0, #3
	str r0, [r4, #0x28]!
	ldmdb fp, {r4, fp, sp, pc}

sub_1fd8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_1f58
	mov r5, r0
	mov r0, r4
	bl sub_1f98
	add r0, r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_2000:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_1fd8
	bl __nw__FUi
	movs r5, r0
	moveq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x1c]
	teq r0, #0
	beq loc_2040
	mov r1, r5
	ldr r2, [r4, #0x24]
	bl BlockMove
	b loc_204c
loc_2040:
	mov r0, r5
	ldr r1, [r4, #0x24]
	bl ZeroBytes
loc_204c:
	ldr r0, [r4, #0x24]
	add r1, r0, r5
	ldr r0, [r4, #0x20]
	teq r0, #0
	ldr r2, [r4, #0x28]!
	beq loc_206c
	bl BlockMove
	b loc_2078
loc_206c:
	mov r0, r1
	mov r1, r2
	bl ZeroBytes
loc_2078:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_2080:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	ldr r0, [r0, #0x1c]
	teq r0, #0
	beq loc_20b0
	bl __dl__FPv
	mov r0, #0
	str r0, [r4, #0x1c]
loc_20b0:
	mov r0, r5
	bl sub_42fc
	str r0, [r4, #0x1c]!
	teq r0, #0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_20d0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	ldr r0, [r0, #0x20]
	teq r0, #0
	beq loc_2100
	bl __dl__FPv
	mov r0, #0
	str r0, [r4, #0x20]
loc_2100:
	mov r0, r5
	bl sub_42fc
	str r0, [r4, #0x20]!
	teq r0, #0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_2120:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0
	mov r0, #0
	str r0, [r4, #0x10]
	str r0, [r4, #0x18]
	ldr r0, [r4, #0xc]
	mov r0, r0, lsr #16
	bl __nw__FUi
	str r0, [r4, #0x10]
	movs r1, r0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	beq loc_2194
	ldr r2, [r4, #0xc]
	mov r2, r2, lsr #16
	mov r0, r5
	bl Getn__11CBufferListFPUcl
	ldr r1, [r4, #0xc]
	teq r0, r1, lsr #16
	ldrne r6, lit_219c
	bne loc_2194
	add r1, r4, #0x18
	mov r2, #4
	ldr r0, [r4, #0x10]!
	bl BlockMove
loc_2194:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_219c:
	.word 0xffffc94b

sub_21a0:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_21c4
	mov r0, #0x24
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_21c4:
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r0, #0x18]
	str r1, [r0, #0x1c]
	str r1, [r0, #0x20]
	str r1, [r0]
	str r1, [r0, #4]
	str r1, [r0, #8]
	ldmdb fp, {fp, sp, pc}

sub_21e8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	ldr r0, [r0, #0x18]
	teq r0, #0
	blne __dl__FPv
	ldr r5, [r4, #4]
	teq r5, #0
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r7, [r5]
	cmp r7, #0
	ble sub_2240

sub_2220:
	mov r1, r6
	mov r0, r5
	bl At__5CListFl
	teq r0, #0
	blne __dl__FPv
	add r6, r6, #1
	cmp r6, r7
	blt sub_2220

sub_2240:
	movs r0, r5
	movne r1, #1
	blne __dt__5CListFv
	mov r0, #0
	str r0, [r4, #4]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_2258:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r7, #0
	mov r6, #0
	mov r2, r1
	mov r1, #0
	bl sub_2494
	mov sb, r0
	ldr r8, [r4]
	bl __nw__FUi
	mov sl, #0xa8
	sub sl, sl, #0x1c00
	str r0, [r5, #0x20]
	teq r0, #0
	beq loc_22c4
	mov r1, sb
	bl ZeroBytes
	cmp r8, #0
	ble sub_22e0

sub_22b0:
	mov r1, r6
	mov r0, r4
	bl At__5CListFl
	movs r1, r0
	bne loc_22cc
loc_22c4:
	mov r7, sl
	b sub_22e0
loc_22cc:
	ldr r0, [r5, #0x20]
	bl strcat
	add r6, r6, #1
	cmp r6, r8
	blt sub_22b0

sub_22e0:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_22e8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r0, r1
	bl strlen
	mov r1, #0x3f
	cmp r0, #0x3f
	movge r0, r1
	mov r6, r0
	add r0, r0, #2
	bl __nw__FUi
	movs r5, r0
	mov r7, #0
	moveq r0, r7
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	strb r6, [r5]
	add r0, r5, #1
	mov r2, r6
	mov r1, r4
	bl memcpy
	add r0, r5, r6
	strb r7, [r0, #1]
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_234c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r2
	mov r5, #0
	mov r0, r1
	adr r1, data_23a8, #30
	bl strtok
	movs r1, r0
	beq loc_23a0
loc_2374:
	mov r2, r1
	ldr r1, [r4]
	mov r0, r4
	bl InsertAt__5CListFlPv
	movs r5, r0
	bne loc_23a0
	adr r1, data_23a8, #30
	mov r0, #0
	bl strtok
	movs r1, r0
	bne loc_2374
loc_23a0:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
data_23a8:
	.word 0x2e000000			; cdphs p0, #0, c0, c0, c0, #0

sub_23ac:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__5CListFv
	mov r8, #0
	mov r0, r6
	bl strlen
	add r0, r0, #1
	bl __nw__FUi
	movs r7, r0
	mov sb, #0xa8
	sub sb, sb, #0x1c00
	beq loc_244c
	mov r1, r6
	mov r0, r7
	bl strcpy
	mov r2, sp
	mov r1, r7
	mov r0, r5
	bl sub_234c
	movs r6, r0
	bne loc_2480
	ldr sl, [sp]
	cmp sl, #0
	ble sub_2478

sub_2424:
	mov r1, r8
	mov r0, sp
	bl At__5CListFl
	teq r0, #0
	beq loc_244c
	mov r1, r0
	mov r0, r5
	bl sub_22e8
	teq r0, #0
	bne loc_2454
loc_244c:
	mov r6, sb
	b loc_2480
loc_2454:
	mov r2, r0
	ldr r1, [r4]
	mov r0, r4
	bl InsertAt__5CListFlPv
	movs r6, r0
	bne loc_2480
	add r8, r8, #1
	cmp r8, sl
	blt sub_2424

sub_2478:
	mov r0, r7
	bl __dl__FPv
loc_2480:
	mov r0, sp
	mov r1, #0
	bl __dt__5CListFv
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_2494:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r2
	mov r6, #0
	mov r5, r1
	ldr r7, [r2]
	cmp r1, r7
	bge loc_24dc

sub_24b8:
	mov r1, r5
	mov r0, r4
	bl At__5CListFl
	ldrb r0, [r0]
	add r0, r6, r0
	add r6, r0, #1
	add r5, r5, #1
	cmp r5, r7
	blt sub_24b8
loc_24dc:
	add r0, r6, #1
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_24e4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0x1c]
	teq r0, #0
	blne __dl__FPv
	mov r7, #0
	ldr r6, [r4, #8]
	teq r6, #0
	beq loc_2554
	ldr r8, [r6]
	cmp r8, #0
	ble sub_2544

sub_2520:
	mov r1, r5
	mov r0, r6
	bl At__5CListFl
	teq r0, #0
	beq sub_2544
	bl __dl__FPv
	add r5, r5, #1
	cmp r5, r8
	blt sub_2520

sub_2544:
	movs r0, r6
	movne r1, #1
	blne __dt__5CListFv
	str r7, [r4, #8]
loc_2554:
	ldr r0, [r4, #0x14]
	teq r0, #0
	strne r7, [r4, #0x14]
	ldr r0, [r4, #0x20]
	teq r0, #0
	strne r7, [r4, #0x20]
	ldr r5, [r4]
	teq r5, #0
	ldmdbeq fp, {r4, r5, r6, r7, r8, fp, sp, pc}
	ldr r8, [r5]
	cmp r8, #0
	movgt r6, #0
	ble sub_25a8

sub_2588:
	mov r1, r6
	mov r0, r5
	bl At__5CListFl
	teq r0, #0
	blne __dl__FPv
	add r6, r6, #1
	cmp r6, r8
	blt sub_2588

sub_25a8:
	movs r0, r5
	movne r1, #1
	blne __dt__5CListFv
	str r7, [r4]
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_25bc:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_21e8
	mov r0, r4
	bl sub_24e4
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_25f0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	mov r8, #0
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r4]
	teq r0, #0
	beq loc_268c
	ldr r0, [r4, #0x20]
	teq r0, #0
	beq sub_270c
	bl strlen
	mov sl, r0
	mov r1, #0
	ldr r0, [r4]
	ldr r2, [r4, #0x20]
	bl InsertAt__5CListFlPv
	movs r5, r0
	bne loc_2728
	ldr r0, [r4, #0x20]
	teq r0, #0
	ldrne r0, [r4, #4]
	teqne r0, #0
	beq sub_270c
	ldr r7, [r0]
	cmp r7, #0
	ble sub_270c

sub_2668:
	mov r1, r8
	ldr r2, [r4, #4]
	mov r0, r4
	bl sub_2494
	add r0, r0, sl
	mov sb, r0
	bl __nw__FUi
	movs r6, r0
	bne loc_2698
loc_268c:
	mov r5, #0xa8
	sub r5, r5, #0x1c00
	b loc_2728
loc_2698:
	mov r1, sb
	mov r0, r6
	bl ZeroBytes
	mov r0, r6
	ldr r1, [r4, #0x20]
	bl strcat
	mov sb, r8
	cmp r8, r7
	bge loc_26e8

sub_26bc:
	mov r1, sb
	ldr r0, [r4, #4]
	bl At__5CListFl
	teq r0, #0
	beq loc_2728
	mov r1, r0
	mov r0, r6
	bl strcat
	add sb, sb, #1
	cmp sb, r7
	blt sub_26bc
loc_26e8:
	mov r2, r6
	ldr r0, [r4]
	ldr r1, [r0]
	bl InsertAt__5CListFlPv
	movs r5, r0
	bne loc_2728
	add r8, r8, #1
	cmp r8, r7
	blt sub_2668

sub_270c:
	mov r1, #0
	str r1, [r4, #0xc]
	ldr r0, [r4]
	ldr r2, [r0]
	str r2, [r4, #0x10]
	bl At__5CListFl
	str r0, [r4, #0x14]!
loc_2728:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_2730:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0xc]
	ldr r1, [r4, #0x10]
	sub r1, r1, #1
	cmp r0, r1
	bge loc_2770
	add r1, r0, #1
	str r1, [r4, #0xc]
	ldr r0, [r4]
	bl At__5CListFl
	str r0, [r4, #0x14]!
	b loc_2774
loc_2770:
	ldr r5, lit_277c
loc_2774:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_277c:
	.word 0xffff1283

sub_2780:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	mov r0, #0
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r0, r4
	bl strlen
	mov r6, r0
	mov r0, r5
	bl sub_21e8
	add r0, r6, #1
	bl __nw__FUi
	str r0, [r5, #0x18]
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r4
	bl strcpy
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b loc_27e0
loc_27e0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r4, #4]
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	ldmdbeq fp, {r4, fp, sp, pc}
	mov r2, r0
	ldr r1, [r4, #0x18]
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_23ac
loc_2820:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__5CListFv
	mov r7, #0
	mov r6, #0
	mov r0, r4
	bl sub_24e4
	teq r5, #0
	beq loc_28c8
	mov r0, r5
	bl strlen
	add r0, r0, #1
	bl __nw__FUi
	str r0, [r4, #0x1c]
	teq r0, #0
	moveq r6, #0xa8
	subeq r6, r6, #0x1c00
	beq sub_28f8
	mov r1, #0
	strb r1, [r0]
	mov r1, r5
	ldr r0, [r4, #0x1c]
	bl strcpy
	mov r2, sp
	ldr r1, [r4, #0x1c]
	mov r0, r4
	bl sub_23ac
	movs r6, r0
	bne loc_28c8
	mov r1, sp
	mov r0, r4
	bl sub_2258
	movs r6, r0
	bne loc_28c8
	mov r0, r4
	bl sub_25f0
	mov r6, r0
loc_28c8:
	ldr r4, [sp]
	cmp r4, #0
	ble sub_28f8

sub_28d4:
	mov r1, r7
	mov r0, sp
	bl At__5CListFl
	teq r0, #0
	beq sub_28f8
	bl __dl__FPv
	add r7, r7, #1
	cmp r7, r4
	blt sub_28d4

sub_28f8:
	mov r0, sp
	mov r1, #0
	bl __dt__5CListFv
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

Sizeof:
	mov r0, #0x18
	mov pc, lr

sub_2914:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2938
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_2964
loc_2938:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_296c
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
	strb r0, [r4, #0x11]
	strb r0, [r4, #0x10]
loc_2964:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_296c:
	.word 0x69757373			; 'iuss'

sub_2970:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2994
	mov r0, #0x14
	bl __nw__FUi
	movs r4, r0
	beq loc_29c0
loc_2994:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_29c8
	str r0, [r4]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
	strb r0, [r4, #0x11]
	strb r0, [r4, #0x10]
loc_29c0:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_29c8:
	.word 0x69756473			; 'iuds'

sub_29cc:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	mov r5, r1
	bne loc_29f4
	mov r0, #0x20
	bl __nw__FUi
	movs r4, r0
	beq loc_2a68
loc_29f4:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, [r5, #4]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xd]
	mov r0, r0, asr #8
	strb r0, [r4, #0xc]
	ldr r0, [r5, #8]
	mov r0, r0, lsr #16
	strb r0, [r4, #0xf]
	mov r0, r0, asr #8
	strb r0, [r4, #0xe]
	ldr r0, [r5, #0x18]
	str r0, [r4, #0x14]
	ldr r0, [r5, #0x14]
	str r0, [r4, #0x10]
	mov r0, r5
	bl sub_1f58
	str r0, [r4, #0x18]
	mov r0, r5
	bl sub_1f98
	str r0, [r4, #0x1c]
	mov r0, r5
	bl sub_1fd8
	add r0, r0, #0x14
	str r0, [r4, #4]
	ldr r0, lit_2a70
	str r0, [r4]
loc_2a68:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_2a70:
	.word 0x72726364			; 'rrcd'

sub_2a74:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2a98
	mov r0, #0x10
	bl __nw__FUi
	movs r4, r0
	beq loc_2abc
loc_2a98:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_2ac4
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0xc]
loc_2abc:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_2ac4:
	.word 0x69747376			; 'itsv'

sub_2ac8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2aec
	mov r0, #0x10
	bl __nw__FUi
	movs r4, r0
	beq loc_2b10
loc_2aec:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_2b18
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mvn r0, #0
	str r0, [r4, #0xc]
loc_2b10:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_2b18:
	.word 0x696c6964			; 'ilid'

sub_2b1c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	bne loc_2b40
	mov r0, #0x10
	bl __nw__FUi
	movs r4, r0
	beq loc_2b70
loc_2b40:
	mov r0, r4
	mov r1, #0xc000000
	bl __ct__7TOptionFUl
	ldr r0, lit_2b78
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0
	strb r0, [r4, #0xd]
	strb r0, [r4, #0xc]
	mov r0, #1
	strb r0, [r4, #0xe]
loc_2b70:
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
lit_2b78:
	.word 0x696c7074			; 'ilpt'

DefaultNew:
	mov r1, #0
	str r1, [r0, #0x14]
	mov pc, lr

Method52:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr ip, lit_2bf8
	teq r2, ip
	beq loc_2c28
	ldr ip, lit_2bfc
	teq r2, ip
	beq loc_2c08
	ldr ip, lit_2c00
	teq r2, ip
	beq loc_2c58
	ldr ip, lit_2c04
	teq r2, ip
	bne loc_2ce0
	teq r3, #0x200
	teqne r3, #0x100
	ldreq r0, [r1, #0xc]!
	ldreq r1, [r4, #0x14]!
	streq r0, [r1, #0x13c]!
	beq loc_2cec
	teq r3, #0x400
	ldreq r0, [r4, #0x14]!
	ldreq r0, [r0, #0x13c]
	streq r0, [r1, #0xc]!
	b loc_2cec
lit_2bf8:
	.word 0x64646f6d			; 'ddom'
lit_2bfc:
	.word 0x646e6963			; 'dnic'
lit_2c00:
	.word 0x646e7371			; 'dnsq'
lit_2c04:
	.word 0x696c6964			; 'ilid'
loc_2c08:
	teq r3, #0x200
	teqne r3, #0x100
	bne loc_2c50
	ldr r1, [r1, #0xc]
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x138]
	bl sub_1a18
	b loc_2cd4
loc_2c28:
	teq r3, #0x200
	teqne r3, #0x100
	bne loc_2c48
	add r1, r1, #0xc
	ldr r0, [r4, #0x14]!
	ldr r0, [r0, #0x138]
	bl sub_1798
	b loc_2cd4
loc_2c48:
	teq r3, #0x400
	bne loc_2cec
loc_2c50:
	mvn r5, #4
	b loc_2cec
loc_2c58:
	ldr r0, [r4, #0x14]
	str r1, [r0, #0x14c]!
	mov r0, r4
	bl CTGetControlOptionsInfo__17TCommToolProtocolFv
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x144]!
	mov r1, #0xa8
	sub r1, r1, #0x1c00
	teq r0, #0
	ldr r2, [r4, #0x14]
	beq loc_2c94
	ldr r0, [r0, #0x14]
	str r0, [r2, #0x148]!
	teq r0, #0
	bne loc_2c9c
loc_2c94:
	mov r0, r1
	b loc_2cc8
loc_2c9c:
	mov r0, r4
	bl sub_3c1c
	mov r0, r4
	mov r3, #0x66
	add r3, r3, #0xe00
	mov r2, #5
	mov r1, #1
	bl sub_3b20
	teq r0, #0
	moveq r5, #1
	beq loc_2cec
loc_2cc8:
	ldr r1, [r4, #0x14]!
	ldr r1, [r1, #0x14c]
	str r0, [r1, #0x10]!
loc_2cd4:
	teq r0, #0
	mvnne r5, #0
	b loc_2cec
loc_2ce0:
	mov r0, r4
	bl CTProcessOption__17TCommToolProtocolFP7TOptionUlT2
	mov r5, r0
loc_2cec:
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}

Method53:
	b CTProcessOptionComplete__17TCommToolProtocolFUl

Method7:
	ldr r3, [r1]
	ldr ip, [r0, #0x14]
	ldr ip, [ip, #0x100]
	teq r3, ip
	bne CTHandleRequest__17TCommToolProtocolFR10TUMsgTokenUl
	beq loc_3c54

Method8:
	teq r1, #2
	beq loc_35b8
	teq r1, #3
	beq loc_37b4
	teq r1, #4
	beq loc_3670
	teq r1, #5
	beq loc_3ab4
	bne CTHandleReply__17TCommToolProtocolFUlT1

Method31:
	b CTAddDefaultOptions__17TCommToolProtocolFP12TOptionArray

Method32:
	b CTAddDefaultOptions__17TCommToolProtocolFP12TOptionArray

sub_2d3c:
	ldr r0, [r0, #0x14]
	ldr r0, [r0, #0x10]
	mov pc, lr

sub_2d48:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0xc
	ldr r0, [r0, #0x14]
	ldr r0, [r0, #0x140]
	mov r8, #0
	teq r0, #0
	beq loc_2d80
	bl Reset__12TOptionArrayFv
	b loc_2e58
loc_2d80:
	sub sp, sp, #0x34
	add r0, sp, #0x20
	bl __ct__21TCMOServiceIdentifierFv
	add r0, sp, #0x10
	bl sub_2a74
	mov r0, sp
	bl sub_2ac8
	mov r0, #0
	bl __ct__12TOptionArrayFv
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x140]!
	teq r0, #0
	moveq r7, #0xa8
	subeq r7, r7, #0x1c00
	addeq sp, sp, #0x34
	beq loc_2efc
	bl Init__12TOptionArrayFv
	movs r7, r0
	bne loc_2e48
	ldr r0, lit_2e50
	str r0, [sp, #0x2c]
	str r8, [sp, #0x30]
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x140]
	add r2, sp, #0x20
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	movs r7, r0
	bne loc_2e48
	str r6, [sp, #0x1c]
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x140]
	add r2, sp, #0x10
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	movs r7, r0
	bne loc_2e48
	teq r5, #0
	ldrne r0, [r4, #0x14]
	strne r5, [r0, #0x13c]!
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x13c]
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x140]
	mov r2, sp
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	movs r7, r0
	beq loc_2e54
loc_2e48:
	add sp, sp, #0x34
	b loc_2eb0
lit_2e50:
	.word 0x696e6574			; 'inet'
loc_2e54:
	add sp, sp, #0x34
loc_2e58:
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x140]
	mov r1, sp
	bl CMStartServiceInternal__FP12TOptionArrayP12TServiceInfo
	movs r7, r0
	bne loc_2eb0
	sub sp, sp, #0x1c
	ldr r0, [r4, #0x14]
	ldr r1, [r0, #0x140]!
	mov r0, sp
	bl __ct__15TOptionIteratorFP12TOptionArray
	mov r0, sp
	ldr r1, lit_2edc
	bl FindOption__15TOptionIteratorFUl
	teq r0, #0
	ldrne r0, [r0, #8]
	movne r7, r0, lsl #24
	movne r7, r7, asr #24
	mov r0, sp
	mov r1, #0
	bl __dt__15TOptionIteratorFv
	add sp, sp, #0x1c
loc_2eb0:
	teq r7, #0
	beq loc_2ee0
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x140]
	teq r0, #0
	beq loc_2efc
	mov r1, #1
	bl __dt__12TOptionArrayFv
	ldr r0, [r4, #0x14]!
	str r8, [r0, #0x140]!
	b loc_2efc
lit_2edc:
	.word 0x73696420			; 'sid '
loc_2ee0:
	mov r1, #2
	ldr r0, [r4, #0x14]
	str r1, [r0, #0x10]!
	ldr r0, [r4, #0x14]!
	add r0, r0, #8
	ldr r1, [sp, #4]
	bl CopyObject__8TUObjectFCUl
loc_2efc:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_2f04:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x5c
	add r0, sp, #0x44
	bl __ct__12TOptionArrayFv
	add r0, sp, #0x34
	bl sub_2b1c
	add r0, sp, #0x14
	bl __ct__20TCommToolBindRequestFv
	add r0, sp, #4
	bl __ct__14TCommToolReplyFv
	mov r6, #1
	strb r6, [sp, #0x42]
	mov r5, #0
	strb r5, [sp, #0x41]
	strb r5, [sp, #0x40]
	strb r5, [sp, #0x28]
	add r0, sp, #0x44
	str r0, [sp, #0x2c]
	bl Init__12TOptionArrayFv
	teq r0, #0
	bne loc_2ff8
	ldr r0, [sp, #0x2c]
	add r2, sp, #0x34
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	teq r0, #0
	bne loc_2ff8
	mov r0, #8
	str r0, [sp, #0x1c]
	str r6, [sp, #0x30]
	ldr r0, [r4, #0x14]
	add lr, r0, #8
	add r0, sp, #4
	mov r1, #0x10
	mov r2, #0
	mov ip, #4
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, ip
	mov r0, #0x20
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0x34
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, lr
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldreq r0, [sp, #0xc]
	teq r0, #0
	bne loc_2ff8
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	orr r2, r2, #4
	str r2, [r1]
loc_2ff8:
	mov r4, r0
	add r0, sp, #0x44
	mov r1, #0
	bl __dt__12TOptionArrayFv
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_3010:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0x58
	add r0, sp, #0x40
	bl __ct__12TOptionArrayFv
	add r0, sp, #0x18
	bl __ct__23TCommToolConnectRequestFv
	add r0, sp, #4
	bl __ct__21TCommToolConnectReplyFv
	add r0, sp, #0x40
	str r0, [sp, #0x2c]
	bl Init__12TOptionArrayFv
	teq r0, #0
	bne loc_30f8
	teq r5, #0
	beq loc_307c
	mov r2, r5
	ldr r0, [sp, #0x2c]
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	teq r0, #0
	bne loc_30f8
	mov r0, #1
	str r0, [sp, #0x30]
loc_307c:
	mov r0, #3
	str r0, [sp, #0x20]
	ldr r0, [r4, #0x14]
	add ip, r0, #8
	add r0, sp, #4
	mov r1, #0x14
	mov r2, #0
	mov lr, #4
	mov r5, #0
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, lr
	mov r0, #0x28
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0x38
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldreq r0, [sp, #0xc]
	teq r0, #0
	bne loc_30f8
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	orr r2, r2, #8
	str r2, [r1]
loc_30f8:
	mov r4, r0
	add r0, sp, #0x40
	mov r1, #0
	bl __dt__12TOptionArrayFv
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

DefaultDelete:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	ldr r5, [r0, #0x14]
	teq r5, #0
	beq loc_3180
	add r0, r5, #0x104
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0xd0
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0xa4
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0x70
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0x30
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #8
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r5
	bl __dl__FPv
loc_3180:
	str r6, [r4, #0x14]!
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_3188:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x30
	add r0, sp, #0x14
	bl __ct__26TCommToolDisconnectRequestFv
	add r0, sp, #4
	bl __ct__14TCommToolReplyFv
	mov r0, #6
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x14]
	add ip, r0, #8
	add r0, sp, #4
	mov r1, #0x10
	mov r2, #0
	mov lr, #4
	mov r5, #0
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, lr
	mov r0, #0x1c
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0x34
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldreq r0, [sp, #0xc]
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	bic r2, r2, #8
	str r2, [r1]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_3224:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x20
	add r0, sp, #0x14
	bl __ct__23TCommToolControlRequestFv
	add r0, sp, #4
	bl __ct__14TCommToolReplyFv
	mov r0, #9
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x14]
	add ip, r0, #8
	add r0, sp, #4
	mov r1, #0x10
	mov r2, #0
	mov lr, #4
	mov r5, #0
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, lr
	mov r0, #0xc
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0x34
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldreq r0, [sp, #0xc]
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	bic r2, r2, #4
	str r2, [r1]
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_32c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x20
	add r0, sp, #0x14
	bl __ct__23TCommToolControlRequestFv
	add r0, sp, #4
	bl __ct__14TCommToolReplyFv
	mov r6, #0
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #8]
	mov r5, #0
	teq r0, #0
	beq loc_337c
	mov r0, #2
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x14]
	add ip, r0, #8
	add r0, sp, #4
	mov r1, #0x10
	mov r2, #0
	mov lr, #4
	mov r3, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r1, lr
	mov r0, #0xc
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0x34
	stmdb sp!, {r3}
	add r3, sp, #0x24
	mov r0, ip
	mov r2, #2
	mov r1, #1
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	movs r6, r0
	ldreq r6, [sp, #0xc]
	ldr r0, [r4, #0x14]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #2
	str r1, [r0]
	ldr r0, [r4, #0x14]
	add r0, r0, #8
	mov r1, r5
	bl CopyObject__8TUObjectFCUl
loc_337c:
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x140]
	teq r0, #0
	beq loc_339c
	mov r1, #1
	bl __dt__12TOptionArrayFv
	ldr r0, [r4, #0x14]!
	str r5, [r0, #0x140]!
loc_339c:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_33a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x14]
	str r1, [r0, #0x1c]!
	mvn r1, #0
	ldr r0, [r4, #0x14]
	mov r5, #0
	str r1, [r0, #0x20]!
	ldr r0, [r4, #0x14]
	strb r5, [r0, #0x24]
	mov r6, #1
	ldr r0, [r4, #0x14]
	strb r6, [r0, #0x25]
	ldr r0, [r4, #0x14]
	strb r6, [r0, #0x26]
	ldr r0, [r4, #0x14]
	ldrb r1, [r0, #0x160]
	teq r1, #0
	bne loc_346c
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_2970
	mov r0, #0
	bl __ct__12TOptionArrayFv
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x28]!
	teq r0, #0
	moveq r7, #0xa8
	subeq r7, r7, #0x1c00
	beq loc_344c
	bl Init__12TOptionArrayFv
	movs r7, r0
	bne loc_344c
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x28]
	mov r2, sp
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	movs r7, r0
	beq loc_3454
loc_344c:
	add sp, sp, #0x14
	b loc_35ac
loc_3454:
	ldr r0, [r4, #0x14]
	str r6, [r0, #0x2c]!
	ldr r0, [r4, #0x14]
	strb r6, [r0, #0x160]
	add sp, sp, #0x14
	b loc_3474
loc_346c:
	ldr r0, [r0, #0x28]
	bl Reset__12TOptionArrayFv
loc_3474:
	sub sp, sp, #0x20
	mov r0, #0
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x14]
	ldr r1, [r0, #0x28]!
	mov r0, sp
	bl __ct__15TOptionIteratorFP12TOptionArray
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x138]
	add r1, sp, #0x1c
	bl sub_1a78
	movs r7, r0
	bne loc_34b4
	ldr r0, [sp, #0x1c]
	teq r0, #0
	bne loc_34c8
loc_34b4:
	mov r0, sp
	mov r1, #0
	bl __dt__15TOptionIteratorFv
	add sp, sp, #0x20
	b loc_35ac
loc_34c8:
	mov r0, sp
	ldr r1, lit_35b4
	bl FindOption__15TOptionIteratorFUl
	ldr r1, [sp, #0x1c]
	str r1, [r0, #0xc]
	mov r1, #0x35
	strb r1, [r0, #0x11]
	strb r5, [r0, #0x10]
	mov r0, sp
	mov r1, #0
	bl __dt__15TOptionIteratorFv
	add sp, sp, #0x20
	ldr r0, [r4, #0x14]
	add lr, r0, #8
	add ip, r0, #0x30
	add r7, r0, #0x14
	add r0, r0, #0x40
	mov r1, #0x14
	mov r2, #0
	mov r3, #0
	mov r8, #2
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r2, #1
	mov r1, r8
	mov r0, #0x1c
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r7
	stmdb sp!, {r3}
	mov r0, lr
	mov r3, #0
	ldr r1, [ip], #8
	ldr r2, [ip]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	movs r7, r0
	beq loc_3570
	add ip, r7, #0x2700
	cmn ip, #0x21
	bne loc_35ac
	mov r0, r4
	bl sub_3c1c
loc_3570:
	mov r0, r4
	mov r3, #0x66
	add r3, r3, #0xe00
	mov r2, #0x388
	add r2, r2, #0x1000
	mov r1, #2
	bl sub_3b20
	movs r7, r0
	bne loc_35ac
	ldr r0, [r4, #0x14]
	str r6, [r0, #0x15c]!
	ldr r0, [r4, #0x14]!
	ldr r1, [r0, #0x10]!
	orr r1, r1, #0x10
	str r1, [r0]
loc_35ac:
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_35b4:
	.word 0x69756473			; 'iuds'
loc_35b8:
	ldr r1, [r0, #0x14]
	ldr r2, [r1, #0x10]!
	bic r2, r2, #0x10
	str r2, [r1]
	ldr r0, [r0, #0x14]
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x138]
	b loc_17c4

sub_35d8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #2
	ldr r1, [r4, #0x14]
	str r0, [r1, #0xa0]!
	ldr r0, [r4, #0x14]
	add lr, r0, #8
	add ip, r0, #0xa4
	add r6, r0, #0x98
	add r0, r0, #0xb4
	mov r1, #0x10
	mov r2, #0
	mov r3, #0
	mov r5, #0x10
	mov r7, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r7
	mov r2, #1
	mov r1, r5
	mov r0, #0xc
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	stmdb sp!, {r3}
	mov r0, lr
	mov r3, #0
	ldr r1, [ip], #8
	ldr r2, [ip]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	orr r2, r2, #0x20
	str r2, [r1]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_3670:
	ldr r0, [r0, #0x14]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x20
	str r1, [r0]
	mov pc, lr

sub_3684:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	ldr r0, [r0, #0x14]
	ldrb r1, [r0, #0x161]
	mov r5, #1
	teq r1, #0
	bne loc_3710
	sub sp, sp, #0x14
	mov r0, sp
	bl sub_2914
	mov r0, #0
	bl __ct__12TOptionArrayFv
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x68]!
	teq r0, #0
	moveq r0, #0xa8
	subeq r0, r0, #0x1c00
	beq loc_370c
	bl Init__12TOptionArrayFv
	teq r0, #0
	bne loc_370c
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x68]
	mov r2, sp
	ldr r1, [r0]
	bl InsertOptionAt__12TOptionArrayFlP7TOption
	teq r0, #0
	ldreq r0, [r4, #0x14]
	strbeq r5, [r0, #0x161]
	addeq sp, sp, #0x14
	beq loc_3718
loc_370c:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_3710:
	ldr r0, [r0, #0x28]
	bl Reset__12TOptionArrayFv
loc_3718:
	ldr r0, [r4, #0x14]
	mov ip, #0
	str r6, [r0, #0x5c]!
	ldr r0, [r4, #0x14]
	strb ip, [r0, #0x64]
	ldr r0, [r4, #0x14]
	strb r5, [r0, #0x65]
	ldr r0, [r4, #0x14]
	strb ip, [r0, #0x66]
	ldr r0, [r4, #0x14]
	add r5, r0, #8
	add lr, r0, #0x70
	add r6, r0, #0x54
	add r0, r0, #0x80
	mov r1, #0x18
	mov r2, #0
	mov r3, #0
	mov r7, #1
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, ip
	mov r2, #1
	mov r1, r7
	mov r0, #0x1c
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #0
	ldr r1, [lr], #8
	ldr r2, [lr]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	orr r2, r2, #0x40
	str r2, [r1]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_37b4:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x14]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x40
	str r1, [r0]
	mov r0, r4
	bl sub_3c1c
	ldr r0, [r4, #0x14]
	ldr r2, [r0, #0x150]
	teq r2, #0
	ldr r1, [r0, #0x88]
	movne r1, r2
	movne r2, #0
	strne r2, [r0, #0x150]!
	ldr r0, [r4, #0x14]!
	ldr r2, [r0, #0x94]
	ldr r0, [r0, #0x138]
	ldmdb fp, {r4, fp, sp, lr}
	b loc_130c

sub_380c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #1
	ldr r1, [r4, #0x14]
	str r0, [r1, #0xcc]!
	ldr r0, [r4, #0x14]
	add lr, r0, #8
	add ip, r0, #0xd0
	add r6, r0, #0xc4
	add r0, r0, #0xe0
	mov r1, #0x10
	mov r2, #0
	mov r3, #0
	mov r5, #0x10
	mov r7, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r7
	mov r2, #1
	mov r1, r5
	mov r0, #0xc
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	stmdb sp!, {r3}
	mov r0, lr
	mov r3, #0
	ldr r1, [ip], #8
	ldr r2, [ip]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	teq r0, #0
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r1, [r4, #0x14]!
	ldr r2, [r1, #0x10]!
	orr r2, r2, #0x80
	str r2, [r1]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x2c
	mov r6, #0xe9
	sub r6, r6, #0x2800
	mov r0, sp
	bl __ct__17TCMOTransportInfoFv
	mov r0, #0x164
	bl __nw__FUi
	movs r5, r0
	mov r7, #0
	beq loc_394c
	strb r7, [r5, #0xc]
	str r7, [r5, #8]
	add r0, r5, #0x14
	bl __ct__19TCommToolPutRequestFv
	add r0, r5, #0x30
	bl __ct__14TUAsyncMessageFv
	add r0, r5, #0x40
	bl __ct__17TCommToolPutReplyFv
	add r0, r5, #0x54
	bl __ct__19TCommToolGetRequestFv
	add r0, r5, #0x70
	bl __ct__14TUAsyncMessageFv
	add r0, r5, #0x80
	bl __ct__17TCommToolGetReplyFv
	add r0, r5, #0x98
	bl __ct__20TCommToolKillRequestFv
	add r0, r5, #0xa4
	bl __ct__14TUAsyncMessageFv
	add r0, r5, #0xb4
	bl __ct__14TCommToolReplyFv
	add r0, r5, #0xc4
	bl __ct__20TCommToolKillRequestFv
	add r0, r5, #0xd0
	bl __ct__14TUAsyncMessageFv
	add r0, r5, #0xe0
	bl __ct__14TCommToolReplyFv
	add r0, r5, #0x104
	bl __ct__14TUAsyncMessageFv
loc_394c:
	str r5, [r4, #0x14]
	teq r5, #0
	beq loc_3aa4
	mov r0, #0
	bl sub_0ff0
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x138]!
	movs r1, r0
	ldr r0, [r4, #0x14]
	beq loc_3aa4
	str r7, [r0]
	ldr r0, [r4, #0x14]
	str r7, [r0, #0x15c]!
	ldr r0, [r4, #0x14]
	str r7, [r0, #0x10]!
	ldr r0, [r4, #0x14]
	add r0, r0, #8
	mov r1, r7
	bl CopyObject__8TUObjectFCUl
	ldr r0, [r4, #0x14]
	str r7, [r0, #0x140]!
	ldr r0, [r4, #0x14]
	strb r7, [r0, #0x160]
	ldr r0, [r4, #0x14]
	strb r7, [r0, #0x161]
	ldr r0, [r4, #0x14]
	strb r7, [r0, #0x154]
	ldr r0, [r4, #0x14]
	str r7, [r0, #0x150]!
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0x1f
	mvn r1, #0
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mvn r0, #1
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r0, [sp, #0x24]
	str r1, [sp, #0x28]
	mov r1, sp
	mov r0, r4
	bl CTSetCMOTransportInfo__17TCommToolProtocolFR17TCMOTransportInfo
	mov r0, r4
	bl CTTaskConstructor__17TCommToolProtocolFv
	movs r6, r0
	bne loc_3aa4
	ldr r0, [r4, #0x14]
	add r1, r0, #0x30
	mov r0, r4
	mov r2, #2
	bl CTInitAsyncRPCMsg__17TCommToolProtocolFR14TUAsyncMessageUl
	movs r6, r0
	bne loc_3aa4
	ldr r0, [r4, #0x14]
	add r1, r0, #0x70
	mov r0, r4
	mov r2, #3
	bl CTInitAsyncRPCMsg__17TCommToolProtocolFR14TUAsyncMessageUl
	movs r6, r0
	bne loc_3aa4
	ldr r0, [r4, #0x14]
	add r1, r0, #0xa4
	mov r0, r4
	mov r2, #4
	bl CTInitAsyncRPCMsg__17TCommToolProtocolFR14TUAsyncMessageUl
	movs r6, r0
	bne loc_3aa4
	ldr r0, [r4, #0x14]
	add r1, r0, #0xd0
	mov r0, r4
	mov r2, #5
	bl CTInitAsyncRPCMsg__17TCommToolProtocolFR14TUAsyncMessageUl
	movs r6, r0
	bne loc_3aa4
	ldr r0, [r4, #0x14]
	add r0, r0, #0x104
	mov r1, #1
	bl Init__14TUAsyncMessageFUc
	movs r6, r0
	bne loc_3aa4
	ldr r0, [r4, #0x14]!
	ldr r1, [r0, #0x104]
	str r1, [r0, #0x100]!
	b loc_3aac
loc_3aa4:
	mov r0, r4
	bl Method5
loc_3aac:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_3ab4:
	ldr r0, [r0, #0x14]
	ldr r1, [r0, #0x10]!
	bic r1, r1, #0x80
	str r1, [r0]
	mov pc, lr

sub_3ac8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	teq r1, #0
	beq loc_3af4
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x14c]
	str r1, [r0, #0x10]!
	mvn r0, #0
loc_3af4:
	mov r1, r0
	mov r0, r4
	bl Method53
	mov r0, #0
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x144]!
	ldr r1, [r4, #0x14]
	str r0, [r1, #0x148]!
	ldr r1, [r4, #0x14]!
	str r0, [r1, #0x14c]!
	ldmdb fp, {r4, fp, sp, pc}

sub_3b20:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	ldr ip, [r4, #0x14]
	ldr lr, [ip]
	tst lr, #1
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	sub sp, sp, #0x10
	str r1, [ip, #0xfc]!
	ldr r0, [r4, #0x14]
	add r5, r0, #0x114
	mov r1, r2
	add r0, sp, #8
	mov r2, r3
	bl __ct__5TTimeFUl9TimeUnits
	mov r0, sp
	bl GetGlobalTime
	sub sp, sp, #8
	add r0, sp, #8
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	mov r1, sp
	add r0, sp, #0x10
	bl CompAdd
	movs r0, r5
	bne loc_3ba0
	mov r0, #8
	bl __nw__FUi
	teq r0, #0
	beq loc_3ba8
loc_3ba0:
	ldmia sp, {r3, ip}
	stmia r0, {r3, ip}
loc_3ba8:
	add sp, sp, #8
	mov r0, r4
	bl CTGetToolPort__17TCommToolProtocolFv
	mov ip, r0
	ldr r0, [r4, #0x14]
	add lr, r0, #0x104
	add r5, r0, #0xfc
	mov r2, #0
	add r3, r0, #0x114
	mov r6, #0
	mov r1, #0
	mov r0, #1
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	mov r2, #4
	stmdb sp!, {r2, r3}
	mov r3, r5
	mov r0, ip
	mov r2, #0
	ldr r1, [lr]
	bl SendGoo__6TUPortFUlT1PvN31UcT1P5TTime
	add sp, sp, #0x18
	teq r0, #0
	bne loc_3c18
	ldr r1, [r4, #0x14]!
	ldr r2, [r1]
	orr r2, r2, #1
	str r2, [r1]
loc_3c18:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_3c1c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0x14]
	add r0, r0, #0x104
	bl Abort__14TUAsyncMessageFv
	ldr r0, [r4, #0x14]!
	ldr r1, [r0]
	bic r1, r1, #1
	str r1, [r0]
	mov r0, r5
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_3c54:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x14]
	ldr r1, [r0]
	bic r1, r1, #1
	str r1, [r0]
	ldr r0, [r4, #0x14]
	ldr r1, [r0, #0xfc]
	teq r1, #1
	beq loc_3c98
	teq r1, #2
	moveq r0, r4
	ldmdbeq fp, {r4, fp, sp, lr}
	beq loc_3cd0
	ldmdb fp, {r4, fp, sp, pc}
loc_3c98:
	ldr r3, [r0, #0x14c]
	stmdb sp!, {r3}
	add r3, r0, #0x144
	ldmia r3, {r2, r3}
	ldr r0, [r0, #0x138]
	mov r1, r4
	bl sub_1b04
	add sp, sp, #4
	teq r0, #0
	movne r1, r0
	movne r0, r4
	ldmdbne fp, {r4, fp, sp, lr}
	bne sub_3ac8
	ldmdb fp, {r4, fp, sp, pc}
loc_3cd0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, #0
	ldr r0, [r0, #0x14]
	ldr r1, [r0, #0x10]
	tst r1, #0x40
	beq loc_3dc4
	ldr r1, [r0, #0x15c]
	cmp r1, #3
	bls sub_3d18
	mov r5, #0x72
	sub r5, r5, #0xee00
	str r5, [r0, #0x150]!
	mov r0, r4
	bl sub_380c
	b loc_3dc4

sub_3d18:
	add lr, r0, #8
	add ip, r0, #0x30
	add r6, r0, #0x14
	add r0, r0, #0x40
	mov r1, #0x14
	mov r2, #0
	mov r3, #0
	mov r5, #2
	mov r7, #0
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r7
	mov r2, #1
	mov r1, r5
	mov r0, #0x1c
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r6
	stmdb sp!, {r3}
	mov r0, lr
	mov r3, #0
	ldr r1, [ip], #8
	ldr r2, [ip]
	bl SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime
	add sp, sp, #0x24
	movs r5, r0
	beq loc_3d90
	add ip, r5, #0x2700
	cmn ip, #0x21
	bne loc_3dc4
	mov r0, r4
	bl sub_3c1c
loc_3d90:
	mov r0, r4
	mov r3, #0x66
	add r3, r3, #0xe00
	mov r2, #0x388
	add r2, r2, #0x1000
	mov r1, #2
	bl sub_3b20
	movs r5, r0
	bne loc_3dc4
	ldr r0, [r4, #0x14]!
	ldr r1, [r0, #0x15c]!
	add r1, r1, #1
	str r1, [r0]
loc_3dc4:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

Method10:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	teq r1, #0x10
	ldreq r0, [r4, #0x14]
	ldreq r0, [r0, #0x138]
	bleq sub_1878
	mov r1, r5
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b CTDoKillControl__17TCommToolProtocolFUl

Method16:
	b CTClose__17TCommToolProtocolFv

Method17:
	b CTCloseComplete__17TCommToolProtocolFl

Method63:
	mov pc, lr

Method5:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r0, [r0, #0x14]
	teq r0, #0
	beq loc_3f04
	ldr r0, [r0, #0x138]
	teq r0, #0
	movne r1, #1
	blne sub_106c
	mov r0, r4
	bl sub_32c0
	ldr r0, [r4, #0x14]
	ldrb r1, [r0, #0x161]
	teq r1, #0
	ldrne r0, [r0, #0x68]
	teqne r0, #0
	beq loc_3e70
	bl RemoveAllOptions__12TOptionArrayFv
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x68]
	teq r0, #0
	movne r1, #1
	blne __dt__12TOptionArrayFv
loc_3e70:
	ldr r0, [r4, #0x14]
	ldrb r1, [r0, #0x160]
	teq r1, #0
	ldrne r0, [r0, #0x28]
	teqne r0, #0
	beq loc_3ea0
	bl RemoveAllOptions__12TOptionArrayFv
	ldr r0, [r4, #0x14]
	ldr r0, [r0, #0x28]
	teq r0, #0
	movne r1, #1
	blne __dt__12TOptionArrayFv
loc_3ea0:
	mov r6, #0
	ldr r5, [r4, #0x14]
	teq r5, #0
	beq loc_3f00
	add r0, r5, #0x104
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0xd0
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0xa4
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0x70
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #0x30
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r5, #8
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r5
	bl __dl__FPv
loc_3f00:
	str r6, [r4, #0x14]
loc_3f04:
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b CTTaskDestructor__17TCommToolProtocolFv

Method6:
	adr r0, str_3f18, #30
	mov pc, lr
str_3f18:
	.asciz "DNST"
	.align 4

Method9:
	b CTDoControl__17TCommToolProtocolFUlT1

Method36:
	mov r1, #0
	b Method37

Method37:
	b CTKillPutComplete__17TCommToolProtocolFl

Method42:
	mov r1, #0
	b Method43

Method43:
	b CTKillGetComplete__17TCommToolProtocolFl

Method35:
	b CTPutComplete__17TCommToolProtocolFlUl

Method40:
	and r2, r2, #0xff
	b CTGetComplete__17TCommToolProtocolFlUcUl

Method18:
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
	mov r0, r4
	bl CTSetConnectInfo__17TCommToolProtocolFR17TCMOCTConnectInfo
	mov r0, r4
	mov r1, #0
	bl Method19
	ldr r0, [r4, #0x14]!
	ldr r1, [r0, #0x11c]
	str r1, [r0, #0x128]!
	ldmdb fp, {r4, fp, sp, pc}

Method19:
	b CTConnectComplete__17TCommToolProtocolFl

Method11:
	b CTGetCommEvent__17TCommToolProtocolFv

Method24:
	b CTDisconnectComplete__17TCommToolProtocolFl

Method25:
	b CTReleaseStart__17TCommToolProtocolFv

Method26:
	b CTReleaseComplete__17TCommToolProtocolFl

Method48:
	mov r1, #0
	b Method49

Method49:
	b CTBindComplete__17TCommToolProtocolFl

Method27:
	mov pc, lr

Method50:
	mov r1, #0
	b Method51

Method51:
	b CTUnbindComplete__17TCommToolProtocolFl

Method28:
	mov pc, lr

Method29:
	b CTGetProtAddr__17TCommToolProtocolFv

Method12:
	b CTDoKillGetCommEvent__17TCommToolProtocolFv

Method30:
	mov r0, #0
	mov pc, lr

Method33:
	mov pc, lr

Method34:
	mov pc, lr

Method54:
	b CTProcessPutBytesOptionStart__17TCommToolProtocolFP7TOptionUlT2

Method55:
	b CTProcessPutBytesOptionComplete__17TCommToolProtocolFUl

Method38:
	mov pc, lr

Method39:
	mov pc, lr

Method41:
	mov pc, lr

Method56:
	b CTProcessGetBytesOptionStart__17TCommToolProtocolFP7TOptionUlT2

Method57:
	b CTProcessGetBytesOptionComplete__17TCommToolProtocolFUl

Method13:
	b CTPostCommEvent__17TCommToolProtocolFR22TCommToolGetEventReplyl

Method44:
	mov pc, lr

Method45:
	b CTTerminateComplete__17TCommToolProtocolFv

Method58:
	b CTResArbReleaseStart__17TCommToolProtocolFPUcT1

Method59:
	b CTResArbReleaseStart__17TCommToolProtocolFPUcT1

Method60:
	b CTResArbReleaseComplete__17TCommToolProtocolFl

Method61:
	b CTResArbClaimNotification__17TCommToolProtocolFPUcT1

Method62:
	ldr r0, [r0, #0x14]
	teq r0, #0
	moveq r0, #0
	addne r0, r0, #8
	mov pc, lr

Method46:
	mov r0, #0
	str r0, [r2]
	mov pc, lr

Method47:
	and r2, r2, #0xff
	b CTSetChannelFilter__17TCommToolProtocolF19CommToolRequestTypeUc

Method20:
	mov r1, #0
	b Method21

Method14:
	b CTOpenStart__17TCommToolProtocolFP12TOptionArray

Method21:
	b CTListenComplete__17TCommToolProtocolFl

Method22:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__17TCMOCTConnectInfoFv
	mov r5, #0
	strb r5, [sp, #0xc]
	strb r5, [sp, #0xd]
	strb r5, [sp, #0xe]
	mov r0, #0x2580
	str r0, [sp, #0x14]
	mov r1, sp
	mov r0, r4
	bl CTSetConnectInfo__17TCommToolProtocolFR17TCMOCTConnectInfo
	ldr r0, [r4, #0x14]
	str r5, [r0, #0x12c]!
	mov r0, r4
	mov r1, #0
	bl Method23
	ldmdb fp, {r4, r5, fp, sp, pc}

Method23:
	b CTAcceptComplete__17TCommToolProtocolFl

Method15:
	b CTOpenComplete__17TCommToolProtocolFv

sub_40c0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	mov r6, #0
	mov r5, r0
	ldr r7, [r1]
	cmp r0, r7
	bge loc_410c

sub_40e4:
	mov r1, r5
	mov r0, r4
	bl At__5CListFl
	bl strlen
	and r0, r0, #0xff
	add r0, r6, r0
	add r6, r0, #1
	add r5, r5, #1
	cmp r5, r7
	blt sub_40e4
loc_410c:
	add r0, r6, #1
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_4114:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, #0
	ldr r8, [r0]
	mov r1, r0
	mov r0, #0
	bl sub_40c0
	mov r6, r0
	cmp r0, #0x200
	movgt r6, #0x40
	mov r0, r6
	bl __nw__FUi
	movs r5, r0
	beq loc_41ac
	mov r1, r6
	mov r0, r5
	bl ZeroBytes
	cmp r8, #0
	ble sub_41a0

sub_4168:
	mov r1, r7
	mov r0, r4
	bl At__5CListFl
	teq r0, #0
	beq loc_41ac
	mov r1, r0
	mov r0, r5
	bl strcat
	mov r0, r5
	adr r1, data_41a8, #30
	bl strcat
	add r7, r7, #1
	cmp r7, r8
	blt sub_4168

sub_41a0:
	mov r0, r5
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
data_41a8:
	.word 0x2e000000			; cdphs p0, #0, c0, c0, c0, #0
loc_41ac:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_41b4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #4
	mov r7, #0
	mov r8, #0
	strb r8, [sp, #1]
	strb r8, [sp]
	bl Position__11CBufferListCFv
	sub r1, r6, r0
	mov r0, r4
	mov r2, #0
	bl Seek__11CBufferListFli
	mov r0, r4
	bl Get__11CBufferListFv
	and r6, r0, #0xff
	cmp r6, #0
	ble sub_4268
loc_4208:
	cmp r6, #0xc0
	bge loc_4270
	add r0, r6, #1
	bl __nw__FUi
	movs r7, r0
	beq loc_42f0
	strb r8, [r7, r6]
	mov r2, r6
	mov r1, r7
	mov r0, r4
	bl Getn__11CBufferListFPUcl
	teq r0, r6
	bne loc_42f0
	mov r2, r7
	ldr r1, [r5]
	mov r0, r5
	bl InsertAt__5CListFlPv
	movs r7, r0
	bne sub_4268
	mov r0, r4
	bl Get__11CBufferListFv
	and r6, r0, #0xff
	cmp r6, #0
	bgt loc_4208

sub_4268:
	mov r0, r7
	b loc_42f8
loc_4270:
	mov r0, r4
	mov r2, #0
	mvn r1, #0
	bl Seek__11CBufferListFli
	mov r1, sp
	mov r0, r4
	mov r2, #2
	bl Getn__11CBufferListFPUcl
	teq r0, #2
	bne loc_42f0
	ldr r0, [sp, #2]
	bic r0, r0, #0xc000
	strb r0, [sp, #1]
	mov r0, r0, asr #8
	strb r0, [sp]
	mov r0, r4
	bl Position__11CBufferListCFv
	mov r6, r0
	mov r2, r5
	ldr r1, [sp]
	mov r1, r1, lsr #16
	mov r0, r4
	bl sub_41b4
	movs r7, r0
	bne sub_4268
	mov r0, r4
	bl Position__11CBufferListCFv
	sub r1, r6, r0
	mov r0, r4
	mov r2, #0
	bl Seek__11CBufferListFli
	b sub_4268
loc_42f0:
	mov r0, #0xa8
	sub r0, r0, #0x1c00
loc_42f8:
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_42fc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x18
	mov r0, sp
	bl __ct__5CListFv
	mov r5, #0
	mov r0, r4
	bl Position__11CBufferListCFv
	mov r1, r0
	mov r2, sp
	mov r0, r4
	bl sub_41b4
	teq r0, #0
	bne loc_4348
	mov r0, sp
	bl sub_4114
	mov r5, r0
loc_4348:
	ldr r6, [sp]
	cmp r6, #0
	movgt r4, #0
	ble sub_437c

sub_4358:
	mov r1, r4
	mov r0, sp
	bl At__5CListFl
	teq r0, #0
	beq sub_437c
	bl __dl__FPv
	add r4, r4, #1
	cmp r4, r6
	blt sub_4358

sub_437c:
	mov r0, sp
	mov r1, #0
	bl __dt__5CListFv
	mov r0, r5
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_4390:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r2
	mov r6, r1
	ldr r7, [r0]
	cmp r1, r7
	bge loc_4400

sub_43b4:
	mov r1, r6
	mov r0, r4
	bl OptionAt__12TOptionArrayFl
	teq r0, #0
	beq loc_43e4
	ldr r1, [r0]
	teq r1, r5
	bne loc_43e4
	ldr r1, [r0, #8]
	and r1, r1, #0x80000000
	teq r1, #0x80000000
	bne loc_43f4
loc_43e4:
	add r6, r6, #1
	cmp r6, r7
	blt sub_43b4
	b loc_4400
loc_43f4:
	teq r0, #0
	movne r0, r6
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, pc}
loc_4400:
	mov r0, #0xe7
	add r0, r0, #0x300
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_440c:
	mov r0, #0
	b __ct__11CBufferListFv

sub_4414:
	mov r0, #0
	b __ct__14CBufferSegmentFv

CMStartServiceInternal__FP12TOptionArrayP12TServiceInfo:
	ldr pc, lit_4420
lit_4420:
	.word 0x01800290			; glue 01800290 -> CMStartServiceInternal__FP12TOptionArrayP12TServiceInfo

CTAcceptComplete__17TCommToolProtocolFl:
	ldr pc, lit_4428
lit_4428:
	.word 0x01800568			; glue 01800568 -> CTAcceptComplete__17TCommToolProtocolFl

CTAddDefaultOptions__17TCommToolProtocolFP12TOptionArray:
	ldr pc, lit_4430
lit_4430:
	.word 0x01800574			; glue 01800574 -> CTAddDefaultOptions__17TCommToolProtocolFP12TOptionArray

CTBindComplete__17TCommToolProtocolFl:
	ldr pc, lit_4438
lit_4438:
	.word 0x018024ac			; glue 018024ac -> CTBindComplete__17TCommToolProtocolFl

CTCloseComplete__17TCommToolProtocolFl:
	ldr pc, lit_4440
lit_4440:
	.word 0x01800588			; glue 01800588 -> CTCloseComplete__17TCommToolProtocolFl

CTClose__17TCommToolProtocolFv:
	ldr pc, lit_4448
lit_4448:
	.word 0x01800584			; glue 01800584 -> CTClose__17TCommToolProtocolFv

CTConnectComplete__17TCommToolProtocolFl:
	ldr pc, lit_4450
lit_4450:
	.word 0x0180059c			; glue 0180059c -> CTConnectComplete__17TCommToolProtocolFl

CTDisconnectComplete__17TCommToolProtocolFl:
	ldr pc, lit_4458
lit_4458:
	.word 0x018005a4			; glue 018005a4 -> CTDisconnectComplete__17TCommToolProtocolFl

CTDoControl__17TCommToolProtocolFUlT1:
	ldr pc, lit_4460
lit_4460:
	.word 0x018005a8			; glue 018005a8 -> CTDoControl__17TCommToolProtocolFUlT1

CTDoKillControl__17TCommToolProtocolFUl:
	ldr pc, lit_4468
lit_4468:
	.word 0x018005ac			; glue 018005ac -> CTDoKillControl__17TCommToolProtocolFUl

CTDoKillGetCommEvent__17TCommToolProtocolFv:
	ldr pc, lit_4470
lit_4470:
	.word 0x018005b0			; glue 018005b0 -> CTDoKillGetCommEvent__17TCommToolProtocolFv

CTGetCommEvent__17TCommToolProtocolFv:
	ldr pc, lit_4478
lit_4478:
	.word 0x018005c0			; glue 018005c0 -> CTGetCommEvent__17TCommToolProtocolFv

CTGetComplete__17TCommToolProtocolFlUcUl:
	ldr pc, lit_4480
lit_4480:
	.word 0x018005c4			; glue 018005c4 -> CTGetComplete__17TCommToolProtocolFlUcUl

CTGetControlOptionsInfo__17TCommToolProtocolFv:
	ldr pc, lit_4488
lit_4488:
	.word 0x01802674			; glue 01802674 -> CTGetControlOptionsInfo__17TCommToolProtocolFv

CTGetProtAddr__17TCommToolProtocolFv:
	ldr pc, lit_4490
lit_4490:
	.word 0x018005d0			; glue 018005d0 -> CTGetProtAddr__17TCommToolProtocolFv

CTGetToolPort__17TCommToolProtocolFv:
	ldr pc, lit_4498
lit_4498:
	.word 0x01802670			; glue 01802670 -> CTGetToolPort__17TCommToolProtocolFv

CTHandleReply__17TCommToolProtocolFUlT1:
	ldr pc, lit_44a0
lit_44a0:
	.word 0x018005f4			; glue 018005f4 -> CTHandleReply__17TCommToolProtocolFUlT1

CTHandleRequest__17TCommToolProtocolFR10TUMsgTokenUl:
	ldr pc, lit_44a8
lit_44a8:
	.word 0x018005f8			; glue 018005f8 -> CTHandleRequest__17TCommToolProtocolFR10TUMsgTokenUl

CTInitAsyncRPCMsg__17TCommToolProtocolFR14TUAsyncMessageUl:
	ldr pc, lit_44b0
lit_44b0:
	.word 0x01800600			; glue 01800600 -> CTInitAsyncRPCMsg__17TCommToolProtocolFR14TUAsyncMessageUl

CTKillGetComplete__17TCommToolProtocolFl:
	ldr pc, lit_44b8
lit_44b8:
	.word 0x01800604			; glue 01800604 -> CTKillGetComplete__17TCommToolProtocolFl

CTKillPutComplete__17TCommToolProtocolFl:
	ldr pc, lit_44c0
lit_44c0:
	.word 0x01800608			; glue 01800608 -> CTKillPutComplete__17TCommToolProtocolFl

CTListenComplete__17TCommToolProtocolFl:
	ldr pc, lit_44c8
lit_44c8:
	.word 0x01800610			; glue 01800610 -> CTListenComplete__17TCommToolProtocolFl

CTOpenComplete__17TCommToolProtocolFv:
	ldr pc, lit_44d0
lit_44d0:
	.word 0x01800618			; glue 01800618 -> CTOpenComplete__17TCommToolProtocolFv

CTOpenStart__17TCommToolProtocolFP12TOptionArray:
	ldr pc, lit_44d8
lit_44d8:
	.word 0x01800620			; glue 01800620 -> CTOpenStart__17TCommToolProtocolFP12TOptionArray

CTPostCommEvent__17TCommToolProtocolFR22TCommToolGetEventReplyl:
	ldr pc, lit_44e0
lit_44e0:
	.word 0x01800624			; glue 01800624 -> CTPostCommEvent__17TCommToolProtocolFR22TCommToolGetEventReplyl

CTProcessGetBytesOptionComplete__17TCommToolProtocolFUl:
	ldr pc, lit_44e8
lit_44e8:
	.word 0x018024c8			; glue 018024c8 -> CTProcessGetBytesOptionComplete__17TCommToolProtocolFUl

CTProcessGetBytesOptionStart__17TCommToolProtocolFP7TOptionUlT2:
	ldr pc, lit_44f0
lit_44f0:
	.word 0x018024c0			; glue 018024c0 -> CTProcessGetBytesOptionStart__17TCommToolProtocolFP7TOptionUlT2

CTProcessOptionComplete__17TCommToolProtocolFUl:
	ldr pc, lit_44f8
lit_44f8:
	.word 0x018024e4			; glue 018024e4 -> CTProcessOptionComplete__17TCommToolProtocolFUl

CTProcessOption__17TCommToolProtocolFP7TOptionUlT2:
	ldr pc, lit_4500
lit_4500:
	.word 0x01800628			; glue 01800628 -> CTProcessOption__17TCommToolProtocolFP7TOptionUlT2

CTProcessPutBytesOptionComplete__17TCommToolProtocolFUl:
	ldr pc, lit_4508
lit_4508:
	.word 0x018024c4			; glue 018024c4 -> CTProcessPutBytesOptionComplete__17TCommToolProtocolFUl

CTProcessPutBytesOptionStart__17TCommToolProtocolFP7TOptionUlT2:
	ldr pc, lit_4510
lit_4510:
	.word 0x018024bc			; glue 018024bc -> CTProcessPutBytesOptionStart__17TCommToolProtocolFP7TOptionUlT2

CTPutComplete__17TCommToolProtocolFlUl:
	ldr pc, lit_4518
lit_4518:
	.word 0x0180062c			; glue 0180062c -> CTPutComplete__17TCommToolProtocolFlUl

CTReleaseComplete__17TCommToolProtocolFl:
	ldr pc, lit_4520
lit_4520:
	.word 0x01800630			; glue 01800630 -> CTReleaseComplete__17TCommToolProtocolFl

CTReleaseStart__17TCommToolProtocolFv:
	ldr pc, lit_4528
lit_4528:
	.word 0x01800634			; glue 01800634 -> CTReleaseStart__17TCommToolProtocolFv

CTResArbClaimNotification__17TCommToolProtocolFPUcT1:
	ldr pc, lit_4530
lit_4530:
	.word 0x018024e0			; glue 018024e0 -> CTResArbClaimNotification__17TCommToolProtocolFPUcT1

CTResArbReleaseComplete__17TCommToolProtocolFl:
	ldr pc, lit_4538
lit_4538:
	.word 0x018024dc			; glue 018024dc -> CTResArbReleaseComplete__17TCommToolProtocolFl

CTResArbReleaseStart__17TCommToolProtocolFPUcT1:
	ldr pc, lit_4540
lit_4540:
	.word 0x018024d8			; glue 018024d8 -> CTResArbReleaseStart__17TCommToolProtocolFPUcT1

CTSetCMOTransportInfo__17TCommToolProtocolFR17TCMOTransportInfo:
	ldr pc, lit_4548
lit_4548:
	.word 0x01800644			; glue 01800644 -> CTSetCMOTransportInfo__17TCommToolProtocolFR17TCMOTransportInfo

CTSetChannelFilter__17TCommToolProtocolF19CommToolRequestTypeUc:
	ldr pc, lit_4550
lit_4550:
	.word 0x01800640			; glue 01800640 -> CTSetChannelFilter__17TCommToolProtocolF19CommToolRequestTypeUc

CTSetConnectInfo__17TCommToolProtocolFR17TCMOCTConnectInfo:
	ldr pc, lit_4558
lit_4558:
	.word 0x01800648			; glue 01800648 -> CTSetConnectInfo__17TCommToolProtocolFR17TCMOCTConnectInfo

CTTaskConstructor__17TCommToolProtocolFv:
	ldr pc, lit_4560
lit_4560:
	.word 0x01800660			; glue 01800660 -> CTTaskConstructor__17TCommToolProtocolFv

CTTaskDestructor__17TCommToolProtocolFv:
	ldr pc, lit_4568
lit_4568:
	.word 0x01800664			; glue 01800664 -> CTTaskDestructor__17TCommToolProtocolFv

CTTerminateComplete__17TCommToolProtocolFv:
	ldr pc, lit_4570
lit_4570:
	.word 0x01800668			; glue 01800668 -> CTTerminateComplete__17TCommToolProtocolFv

CTUnbindComplete__17TCommToolProtocolFl:
	ldr pc, lit_4578
lit_4578:
	.word 0x018024b0			; glue 018024b0 -> CTUnbindComplete__17TCommToolProtocolFl

CompAdd:
	ldr pc, lit_4580
lit_4580:
	.word 0x01801750			; glue 01801750 -> CompAdd

CopyObject__8TUObjectFCUl:
	ldr pc, lit_4588
lit_4588:
	.word 0x01800f14			; glue 01800f14 -> CopyObject__8TUObjectFCUl

CurrentIndex__15TOptionIteratorFv:
	ldr pc, lit_4590
lit_4590:
	.word 0x018002ac			; glue 018002ac -> CurrentIndex__15TOptionIteratorFv

FindOption__15TOptionIteratorFUl:
	ldr pc, lit_4598
lit_4598:
	.word 0x018002e0			; glue 018002e0 -> FindOption__15TOptionIteratorFUl

GetGlobalTime:
	ldr pc, lit_45a0
lit_45a0:
	.word 0x018010a4			; glue 018010a4 -> GetGlobalTime

GetSize__11CBufferListCFv:
	ldr pc, lit_45a8
lit_45a8:
	.word 0x01801b24			; glue 01801b24 -> GetSize__11CBufferListCFv

Get__11CBufferListFv:
	ldr pc, lit_45b0
lit_45b0:
	.word 0x01801ad8			; glue 01801ad8 -> Get__11CBufferListFv

Getn__11CBufferListFPUcl:
	ldr pc, lit_45b8
lit_45b8:
	.word 0x01801b0c			; glue 01801b0c -> Getn__11CBufferListFPUcl

Hide__11CBufferListFli:
	ldr pc, lit_45c0
lit_45c0:
	.word 0x01801b3c			; glue 01801b3c -> Hide__11CBufferListFli

Init__11CBufferListFUc:
	ldr pc, lit_45c8
lit_45c8:
	.word 0x01801b58			; glue 01801b58 -> Init__11CBufferListFUc

Init__12TOptionArrayFv:
	ldr pc, lit_45d0
lit_45d0:
	.word 0x01800348			; glue 01800348 -> Init__12TOptionArrayFv

Init__14CBufferSegmentFl:
	ldr pc, lit_45d8
lit_45d8:
	.word 0x01801b74			; glue 01801b74 -> Init__14CBufferSegmentFl

Init__14TUAsyncMessageFUc:
	ldr pc, lit_45e0
lit_45e0:
	.word 0x01801160			; glue 01801160 -> Init__14TUAsyncMessageFUc

InsertAt__5CListFlPv:
	ldr pc, lit_45e8
lit_45e8:
	.word 0x01801bb8			; glue 01801bb8 -> InsertAt__5CListFlPv

InsertLast__11CBufferListFP7CBuffer:
	ldr pc, lit_45f0
lit_45f0:
	.word 0x01801bd0			; glue 01801bd0 -> InsertLast__11CBufferListFP7CBuffer

InsertOptionAt__12TOptionArrayFlP7TOption:
	ldr pc, lit_45f8
lit_45f8:
	.word 0x01800370			; glue 01800370 -> InsertOptionAt__12TOptionArrayFlP7TOption

InsertUnique__5CListFPv:
	ldr pc, lit_4600
lit_4600:
	.word 0x01801bd8			; glue 01801bd8 -> InsertUnique__5CListFPv

InsertVarOptionAt__12TOptionArrayFlP7TOptionPvUl:
	ldr pc, lit_4608
lit_4608:
	.word 0x01800378			; glue 01800378 -> InsertVarOptionAt__12TOptionArrayFlP7TOptionPvUl

NextOption__15TOptionIteratorFv:
	ldr pc, lit_4610
lit_4610:
	.word 0x01800398			; glue 01800398 -> NextOption__15TOptionIteratorFv

OptionAt__12TOptionArrayFl:
	ldr pc, lit_4618
lit_4618:
	.word 0x018003a0			; glue 018003a0 -> OptionAt__12TOptionArrayFl

Position__11CBufferListCFv:
	ldr pc, lit_4620
lit_4620:
	.word 0x01801c98			; glue 01801c98 -> Position__11CBufferListCFv

Putn__11CBufferListFPCUcl:
	ldr pc, lit_4628
lit_4628:
	.word 0x01801cc4			; glue 01801cc4 -> Putn__11CBufferListFPCUcl

RemoveAllOptions__12TOptionArrayFv:
	ldr pc, lit_4630
lit_4630:
	.word 0x018003c8			; glue 018003c8 -> RemoveAllOptions__12TOptionArrayFv

RemoveElementsAt__13CDynamicArrayFlT1:
	ldr pc, lit_4638
lit_4638:
	.word 0x01801d00			; glue 01801d00 -> RemoveElementsAt__13CDynamicArrayFlT1

RemoveOptionAt__12TOptionArrayFl:
	ldr pc, lit_4640
lit_4640:
	.word 0x018003d8			; glue 018003d8 -> RemoveOptionAt__12TOptionArrayFl

ReplaceAt__5CListFlPv:
	ldr pc, lit_4648
lit_4648:
	.word 0x01801d14			; glue 01801d14 -> ReplaceAt__5CListFlPv

ResetMark__11CBufferListFv:
	ldr pc, lit_4650
lit_4650:
	.word 0x01801d5c			; glue 01801d5c -> ResetMark__11CBufferListFv

Reset__11CBufferListFv:
	ldr pc, lit_4658
lit_4658:
	.word 0x01801d28			; glue 01801d28 -> Reset__11CBufferListFv

Reset__12TOptionArrayFv:
	ldr pc, lit_4660
lit_4660:
	.word 0x018003e0			; glue 018003e0 -> Reset__12TOptionArrayFv

Seek__11CBufferListFli:
	ldr pc, lit_4668
lit_4668:
	.word 0x01801d6c			; glue 01801d6c -> Seek__11CBufferListFli

SendGoo__6TUPortFUlT1PvN31UcT1P5TTime:
	ldr pc, lit_4670
lit_4670:
	.word 0x01801414			; glue 01801414 -> SendGoo__6TUPortFUlT1PvN31UcT1P5TTime

SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime:
	ldr pc, lit_4678
lit_4678:
	.word 0x01801418			; glue 01801418 -> SendRPCGoo__6TUPortFUlT1PUlPvN31UcT4N21P5TTime

ZeroBytes:
	ldr pc, lit_4680
lit_4680:
	.word 0x018016e8			; glue 018016e8 -> ZeroBytes

__ct__11CBufferListFv:
	ldr pc, lit_4688
lit_4688:
	.word 0x0180188c			; glue 0180188c -> __ct__11CBufferListFv

__ct__12TOptionArrayFv:
	ldr pc, lit_4690
lit_4690:
	.word 0x018001b0			; glue 018001b0 -> __ct__12TOptionArrayFv

__ct__14CBufferSegmentFv:
	ldr pc, lit_4698
lit_4698:
	.word 0x018018d0			; glue 018018d0 -> __ct__14CBufferSegmentFv

__ct__14TCommToolReplyFv:
	ldr pc, lit_46a0
lit_46a0:
	.word 0x01801e80			; glue 01801e80 -> __ct__14TCommToolReplyFv

__ct__14TUAsyncMessageFv:
	ldr pc, lit_46a8
lit_46a8:
	.word 0x01800d78			; glue 01800d78 -> __ct__14TUAsyncMessageFv

__ct__15TOptionIteratorFP12TOptionArray:
	ldr pc, lit_46b0
lit_46b0:
	.word 0x018001c4			; glue 018001c4 -> __ct__15TOptionIteratorFP12TOptionArray

__ct__17TCMOCTConnectInfoFv:
	ldr pc, lit_46b8
lit_46b8:
	.word 0x018004a8			; glue 018004a8 -> __ct__17TCMOCTConnectInfoFv

__ct__17TCMOTransportInfoFv:
	ldr pc, lit_46c0
lit_46c0:
	.word 0x018001dc			; glue 018001dc -> __ct__17TCMOTransportInfoFv

__ct__17TCommToolGetReplyFv:
	ldr pc, lit_46c8
lit_46c8:
	.word 0x01801e88			; glue 01801e88 -> __ct__17TCommToolGetReplyFv

__ct__17TCommToolPutReplyFv:
	ldr pc, lit_46d0
lit_46d0:
	.word 0x01801e84			; glue 01801e84 -> __ct__17TCommToolPutReplyFv

__ct__19TCommToolGetRequestFv:
	ldr pc, lit_46d8
lit_46d8:
	.word 0x01801ea4			; glue 01801ea4 -> __ct__19TCommToolGetRequestFv

__ct__19TCommToolPutRequestFv:
	ldr pc, lit_46e0
lit_46e0:
	.word 0x01801ea0			; glue 01801ea0 -> __ct__19TCommToolPutRequestFv

__ct__20TCommToolBindRequestFv:
	ldr pc, lit_46e8
lit_46e8:
	.word 0x01801eb4			; glue 01801eb4 -> __ct__20TCommToolBindRequestFv

__ct__20TCommToolKillRequestFv:
	ldr pc, lit_46f0
lit_46f0:
	.word 0x01801ec0			; glue 01801ec0 -> __ct__20TCommToolKillRequestFv

__ct__21TCMOServiceIdentifierFv:
	ldr pc, lit_46f8
lit_46f8:
	.word 0x01802b18			; glue 01802b18 -> __ct__21TCMOServiceIdentifierFv

__ct__21TCommToolConnectReplyFv:
	ldr pc, lit_4700
lit_4700:
	.word 0x01801e8c			; glue 01801e8c -> __ct__21TCommToolConnectReplyFv

__ct__23TCommToolConnectRequestFv:
	ldr pc, lit_4708
lit_4708:
	.word 0x01801eac			; glue 01801eac -> __ct__23TCommToolConnectRequestFv

__ct__23TCommToolControlRequestFv:
	ldr pc, lit_4710
lit_4710:
	.word 0x01801e9c			; glue 01801e9c -> __ct__23TCommToolControlRequestFv

__ct__26TCommToolDisconnectRequestFv:
	ldr pc, lit_4718
lit_4718:
	.word 0x01801eb0			; glue 01801eb0 -> __ct__26TCommToolDisconnectRequestFv

__ct__5CListFv:
	ldr pc, lit_4720
lit_4720:
	.word 0x018018f8			; glue 018018f8 -> __ct__5CListFv

__ct__5TTimeFUl9TimeUnits:
	ldr pc, lit_4728
lit_4728:
	.word 0x01800d94			; glue 01800d94 -> __ct__5TTimeFUl9TimeUnits

__ct__7TOptionFUl:
	ldr pc, lit_4730
lit_4730:
	.word 0x018001f4			; glue 018001f4 -> __ct__7TOptionFUl

__dl__FPv:
	ldr pc, lit_4738
lit_4738:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__11CBufferListFv:
	ldr pc, lit_4740
lit_4740:
	.word 0x0180191c			; glue 0180191c -> __dt__11CBufferListFv

__dt__12TOptionArrayFv:
	ldr pc, lit_4748
lit_4748:
	.word 0x018001f8			; glue 018001f8 -> __dt__12TOptionArrayFv

__dt__14TUAsyncMessageFv:
	ldr pc, lit_4750
lit_4750:
	.word 0x01800ddc			; glue 01800ddc -> __dt__14TUAsyncMessageFv

__dt__15TOptionIteratorFv:
	ldr pc, lit_4758
lit_4758:
	.word 0x01800208			; glue 01800208 -> __dt__15TOptionIteratorFv

__dt__5CListFv:
	ldr pc, lit_4760
lit_4760:
	.word 0x01801950			; glue 01801950 -> __dt__5CListFv

__dt__8TUObjectFv:
	ldr pc, lit_4768
lit_4768:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_4770
lit_4770:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

memcpy:
	ldr pc, lit_4778
lit_4778:
	.word 0x0180011c			; glue 0180011c -> memcpy

strcat:
	ldr pc, lit_4780
lit_4780:
	.word 0x01800170			; glue 01800170 -> strcat

strcmp:
	ldr pc, lit_4788
lit_4788:
	.word 0x01800174			; glue 01800174 -> strcmp

strcpy:
	ldr pc, lit_4790
lit_4790:
	.word 0x01800178			; glue 01800178 -> strcpy

strlen:
	ldr pc, lit_4798
lit_4798:
	.word 0x0180017c			; glue 0180017c -> strlen

strtok:
	ldr pc, lit_47a0
lit_47a0:
	.word 0x018028f8			; glue 018028f8 -> strtok
