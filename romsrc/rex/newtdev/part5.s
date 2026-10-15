; " Newton Devices" part 5: protocol (13492 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	; .origin: the address its first byte falls at, worked out where it is built

ClassInfoTable:
	.word 0x00000000			; fReserved1
	.word ImplementationName - .		; fNameDelta
	.word InterfaceName - .			; fInterfaceDelta
	.word Signature - .			; fSignatureDelta
	.word BTable - .			; fBTableDelta
	.word AETestEvent__14TAEventHandlerFP7TAEvent - .	; fEntryProcDelta
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
	.asciz "TLanternEventWorld"
InterfaceName:
	.asciz "TEventWorldAPI"
Signature:
	.asciz ""
	.align 4
BTable:
	.word 0x00000000			; dispatch slot 0
	b ClassInfo				; dispatch slot 1
	b DefaultNew				; dispatch slot 2
	b DefaultDelete				; dispatch slot 3
	b Method4				; dispatch slot 4

AETestEvent__14TAEventHandlerFP7TAEvent:
	ldr pc, lit_0088
lit_0088:
	.word 0x018019f8			; glue 018019f8 -> AETestEvent__14TAEventHandlerFP7TAEvent

Abort__14TUAsyncMessageFv:
	ldr pc, lit_0090
lit_0090:
	.word 0x01800e18			; glue 01800e18 -> Abort__14TUAsyncMessageFv

AddExceptionHandler:
	ldr pc, lit_0098
lit_0098:
	.word 0x01801748			; glue 01801748 -> AddExceptionHandler

AllocInstanceByName__FPCcT1:
	ldr pc, lit_00a0
lit_00a0:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

sub_00a4:
	b loc_3224

sub_00a8:
	b loc_3214

sub_00ac:
	b sub_02d0

sub_00b0:
	b sub_033c

sub_00b4:
	b loc_03a4

sub_00b8:
	b loc_02cc

sub_00bc:
	b loc_0594

sub_00c0:
	b loc_05ec

sub_00c4:
	b loc_0600

sub_00c8:
	b loc_3264

sub_00cc:
	b loc_321c

sub_00d0:
	b loc_27c4

sub_00d4:
	b loc_2eac

sub_00d8:
	b loc_03a4

sub_00dc:
	b loc_1598

sub_00e0:
	b loc_0594

sub_00e4:
	b loc_05ec

sub_00e8:
	b loc_0600

sub_00ec:
	b loc_1c08

sub_00f0:
	b loc_1d08

sub_00f4:
	b loc_1e64

sub_00f8:
	b loc_1f00

sub_00fc:
	b loc_20e0

sub_0100:
	b loc_20e8

sub_0104:
	b loc_2174

sub_0108:
	b loc_21f4

sub_010c:
	b loc_22bc

sub_0110:
	b loc_22d0

sub_0114:
	b loc_2358

sub_0118:
	b loc_06b8

sub_011c:
	b loc_06e0

sub_0120:
	b loc_06e4

sub_0124:
	b loc_06b8

sub_0128:
	b loc_06e8

sub_012c:
	b loc_06e4

sub_0130:
	b loc_06b8

sub_0134:
	b loc_3070

sub_0138:
	b loc_09f4

sub_013c:
	b loc_06b8

sub_0140:
	b loc_15a0

sub_0144:
	b loc_06e4

sub_0148:
	b loc_06b8

sub_014c:
	b loc_14ac

sub_0150:
	b loc_06e4

sub_0154:
	b loc_06b8

sub_0158:
	b loc_1034

sub_015c:
	b loc_06e4

sub_0160:
	b loc_06b8

sub_0164:
	b loc_1180

sub_0168:
	b loc_06e4

sub_016c:
	b loc_32d4

sub_0170:
	b AETestEvent__14TAEventHandlerFP7TAEvent

sub_0174:
	b loc_26f4

sub_0178:
	b loc_3058

sub_017c:
	b IdleProc__14TAEventHandlerFP10TUMsgTokenPUlP7TAEvent

sub_0180:
	b loc_06b8

sub_0184:
	b loc_1910

sub_0188:
	b loc_06e4

sub_018c:
	b loc_06b8

sub_0190:
	b loc_106c

sub_0194:
	b loc_06e4

sub_0198:
	b loc_06b8

sub_019c:
	b loc_10e0

sub_01a0:
	b loc_06e4

sub_01a4:
	b loc_06b8

sub_01a8:
	b loc_1550

sub_01ac:
	b loc_06e4

sub_01b0:
	b loc_06b8

sub_01b4:
	b loc_19d0

sub_01b8:
	b loc_06e4

sub_01bc:
	b loc_06b8

sub_01c0:
	b loc_17e0

sub_01c4:
	b loc_06e4

sub_01c8:
	b loc_06b8

sub_01cc:
	b loc_0d1c

sub_01d0:
	b loc_06e4

sub_01d4:
	b loc_06b8

sub_01d8:
	b loc_0eac

sub_01dc:
	b loc_06e4

sub_01e0:
	b loc_06b8

sub_01e4:
	b loc_0a08

sub_01e8:
	b loc_06e4

sub_01ec:
	b loc_06b8

sub_01f0:
	b loc_12b8

sub_01f4:
	b loc_06e4

sub_01f8:
	b loc_06b8

sub_01fc:
	b loc_0e68

sub_0200:
	b loc_06e4

sub_0204:
	b loc_06b8

sub_0208:
	b loc_2160

sub_020c:
	b loc_06e4

sub_0210:
	b loc_06b8

sub_0214:
	b loc_13f8

sub_0218:
	b loc_06e4

sub_021c:
	b loc_06b8

sub_0220:
	b loc_139c

sub_0224:
	b loc_06e4

sub_0228:
	b loc_06b8

sub_022c:
	b loc_1450

sub_0230:
	b loc_06e4

sub_0234:
	b loc_06b8

sub_0238:
	b loc_0f18

sub_023c:
	b loc_06e4

sub_0240:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0x10
	mov r0, sp
	bl __ct__12TUNameServerFv
	add r0, r4, #0x28
	mov r1, r6
	mov r2, #0x20
	bl strncpy
	mov r0, #0
	str r0, [r4, #0x24]
	mov r0, #1
	strb r0, [r4, #0x21]
	mov r3, r5
	mov r2, #0xa
	mov r1, #0x770
	add r1, r1, #0x1000
	stmdb sp!, {r1, r2, r3}
	mov r0, r4
	mov r3, #0
	mov r2, #0
	mov r1, #1
	bl StartTask__11TUTaskWorldFUcT1UlN33
	add sp, sp, #0xc
	movs r4, r0
	movne r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__12TUNameServerFv
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_02cc:
	mov pc, lr

sub_02d0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x10
	mov r0, sp
	bl __ct__12TUNameServerFv
	add r0, r4, #0x18
	bl Init__6TUPortFv
	teq r0, #0
	bne loc_031c
	mov r3, #0
	stmdb sp!, {r3}
	ldr r3, [r4, #0x18]
	add r1, r4, #0x28
	add r0, sp, #4
	adr r2, str_0334, #30
	bl RegisterName__12TUNameServerFPcT1UlT3
	add sp, sp, #4
loc_031c:
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__12TUNameServerFv
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
str_0334:
	.asciz "TUPort"
	.align 4

sub_033c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x10
	mov r0, sp
	bl __ct__12TUNameServerFv
	add r1, r4, #0x28
	mov r0, sp
	adr r2, str_039c, #30
	bl UnRegisterName__12TUNameServerFPcT1
	ldr r0, [r4, #0x24]!
	teq r0, #0
	beq loc_038c
loc_0374:
	ldr r4, [r0, #4]
	teq r0, #0
	movne r1, #1
	blne sub_0880
	movs r0, r4
	bne loc_0374
loc_038c:
	mov r0, sp
	mov r1, #0
	bl __dt__12TUNameServerFv
	ldmdb fp, {r4, fp, sp, pc}
str_039c:
	.asciz "TUPort"
	.align 4
loc_03a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x6c
	mov r8, #0
	str r8, [sp, #0x54]
	str r8, [sp, #0x60]
	str r8, [sp, #0x58]
	str r8, [sp, #0x5c]
	mov r0, sp
	bl sub_084c
	ldr r0, lit_0494
	str r0, [sp]
	mov r0, sp
	mov r3, #2
	ldr r2, lit_0498
	ldr r1, lit_049c
	bl sub_0688
	ldrb r0, [r4, #0x21]
	teq r0, #0
	beq loc_0570
	add sl, r4, #0x18
	sub sb, sp, #0x64
	mov r7, #0xae
	sub r7, r7, #0xef00
	add r6, r7, #6
	add r5, r7, #4
loc_0414:
	mov r3, #0
	mov r2, #0
	mvn r1, #0
	mov r0, #0
	stmdb sp!, {r0, r1, r2, r3}
	add r3, sp, #0x78
	add r2, sp, #0x64
	stmdb sp!, {r2, r3}
	mov r0, sl
	add r2, sp, #0x2c
	add r1, sp, #0x7c
	mov r3, #0x40
	bl Receive__6TUPortFPUlPvUlP10TUMsgTokenT1N23UcT8
	add sp, sp, #0x18
	teq r0, #0
	bne loc_0564
	mov r0, sb
	str r8, [sp, #-0x6c]!
	bl setjmp
	teq r0, #0
	bne loc_052c
	mov r0, sp
	bl AddExceptionHandler
	ldr r0, [sp, #0xd4]
	tst r0, #0x4000000
	beq loc_04a0
	add r1, sp, #0xc0
	mov r0, r4
	ldr r2, [r4]
	mov lr, pc
	add pc, r2, #0x14
	b loc_0558
lit_0494:
	.rword sub_0124				; relocated
lit_0498:
	.word 0x6b696c6c			; 'kill'
lit_049c:
	.word 0x6c616e74			; 'lant'
loc_04a0:
	strb r8, [r4, #0x20]
	add r1, sp, #0x80
	mov r0, r4
	bl sub_05a0
	teq r0, #0
	beq loc_0508
	ldr r1, [sp, #0xd4]
	tst r1, #0x2000000
	add r2, sp, #0x80
	add r1, sp, #0xc0
	ldr r3, [r0]
	beq loc_04dc
	mov lr, pc
	add pc, r3, #8
	b loc_0558
loc_04dc:
	mov lr, pc
	add pc, r3, #4
	ldr r0, [sp, #0xc4]
	teq r0, #0
	beq loc_0558
	ldrb r0, [r4, #0x20]
	teq r0, #0
	addeq r0, sp, #0xc0
	moveq r3, r7
	beq loc_054c
	b loc_0558
loc_0508:
	ldr r0, [sp, #0xc4]
	teq r0, #0
	beq loc_0558
	ldrb r0, [r4, #0x20]
	teq r0, #0
	addeq r0, sp, #0xc0
	moveq r3, r6
	beq loc_054c
	b loc_0558
loc_052c:
	ldr r0, [sp, #0xc4]
	teq r0, #0
	beq loc_0558
	ldrb r0, [r4, #0x20]
	teq r0, #0
	bne loc_0558
	add r0, sp, #0xc0
	mov r3, r5
loc_054c:
	mov r2, #0
	mov r1, #0
	bl ReplyRPC__10TUMsgTokenFPvUll
loc_0558:
	mov r0, sp
	bl ExitHandler
	add sp, sp, #0x6c
loc_0564:
	ldrb r0, [r4, #0x21]
	teq r0, #0
	bne loc_0414
loc_0570:
	mov r1, sp
	mov r0, r4
	ldr r2, [r4]
	mov lr, pc
	add pc, r2, #0x20
	mov r0, sp
	mov r1, #0
	bl sub_0880
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_0594:
	mov r1, #0
	strb r1, [r0, #0x21]
	mov pc, lr

sub_05a0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	ldr r5, [r0, #0x24]!
	teq r5, #0
	beq loc_05e4
loc_05bc:
	mov r1, r4
	mov r0, r5
	mov lr, pc
	ldr pc, [r5]
	teq r0, #0
	movne r0, r5
	ldmdbne fp, {r4, r5, fp, sp, pc}
	ldr r5, [r5, #4]
	teq r5, #0
	bne loc_05bc
loc_05e4:
	mov r0, #0
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_05ec:
	ldr r2, [r0, #0x24]
	str r2, [r1, #4]
	str r1, [r0, #0x24]!
	mov r0, #0
	mov pc, lr
loc_0600:
	mov r3, #0
	ldr r2, [r0, #0x24]
	teq r2, #0
	beq loc_0628
loc_0610:
	teq r2, r1
	beq loc_0630
	mov r3, r2
	ldr r2, [r2, #4]
	teq r2, #0
	bne loc_0610
loc_0628:
	mvn r0, #0
	mov pc, lr
loc_0630:
	teq r3, #0
	ldreq r1, [r2, #4]!
	streq r1, [r0, #0x24]!
	ldrne r0, [r2, #4]!
	strne r0, [r3, #4]!
	mov r0, #0
	mov pc, lr

sub_064c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	movs r4, r0
	mov r5, r1
	bne loc_0674
	mov r0, #8
	bl __nw__FUi
	movs r4, r0
	beq loc_0680
loc_0674:
	mov r1, r5
	mov r0, r4
	bl __ct__6TUPortFUl
loc_0680:
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0688:
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
loc_06b8:
	ldr r2, [r1, #4]
	ldr r3, [r0, #0xc]
	teq r2, r3
	ldreq r0, [r0, #8]
	ldreq r1, [r1]
	teqeq r0, r1
	movne r0, #0
	moveq r0, #1
	and r0, r0, #0xff
	mov pc, lr
loc_06e0:
	mov pc, lr
loc_06e4:
	mov pc, lr
loc_06e8:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl GetGlobals
	ldr r1, [r0]
	ldmdb fp, {fp, sp, lr}
	add pc, r1, #0x18

sub_0704:
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
	bne loc_0754
	mov r0, r4
	bl __nw__FUi
	str r0, [sp]
	mov r1, r0
	ldr r0, [fp, #8]
	bl SetUserRefCon__14TUSharedMemMsgFUl
loc_0754:
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

sub_07a8:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #4
	mov r0, #0xc
	ldr r1, [fp, #0x18]
	add r4, r0, r1, lsl #2
	mov r1, sp
	ldr r0, [fp, #8]
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	bne loc_07f8
	mov r0, r4
	bl __nw__FUi
	str r0, [sp]
	mov r1, r0
	ldr r0, [fp, #8]
	bl SetUserRefCon__14TUSharedMemMsgFUl
loc_07f8:
	mov r2, r4
	add r1, fp, #0x10
	ldr r0, [sp]
	bl memcpy
	ldmib fp, {ip, lr}
	mov r2, #0
	ldr r5, [sp]
	mov r6, #0
	mov r1, #0
	mov r0, #1
	ldr r3, [fp, #0xc]
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

sub_084c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_0870
	mov r0, #0x14
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_0870:
	ldr r1, lit_087c
	str r1, [r0]
	ldmdb fp, {fp, sp, pc}
lit_087c:
	.rword sub_0118				; relocated

sub_0880:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, lit_08c4
	str r0, [r4]
	bl GetGlobals
	mov r1, r4
	ldr r2, [r0]
	mov lr, pc
	add pc, r2, #0x20
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_08c4:
	.rword sub_0118				; relocated

Sizeof:
	mov r0, #0x10
	mov pc, lr

DefaultNew:
	mov pc, lr

DefaultDelete:
	mov pc, lr

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	sub sp, sp, #0x138
	mov r0, sp
	bl __ct__11TUTaskWorldFv
	mov r0, #0
	strb r0, [sp, #0x1c]
	str r0, [sp, #0x18]
	ldr r0, lit_0960
	str r0, [sp]
	add r0, sp, #0x80
	bl __ct__14TUAsyncMessageFv
	add r0, sp, #0x98
	bl __ct__14TUAsyncMessageFv
	add r0, sp, #0xac
	bl __ct__14TUAsyncMessageFv
	add r0, sp, #0xc0
	bl __ct__14TUAsyncMessageFv
	ldr r0, lit_0964
	mov r2, r4
	mov r1, r5
	str r0, [sp]
	mov r0, sp
	bl sub_0240
	mov r4, r0
	mov r0, sp
	mov r1, #0
	mov lr, pc
	ldr pc, [sp]
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
lit_0960:
	.rword sub_00a4				; relocated
lit_0964:
	.rword sub_00c8				; relocated

sub_0968:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	teq r0, #0
	bne loc_098c
	mov r0, #0x98
	bl __nw__FUi
	teq r0, #0
	ldmdbeq fp, {fp, sp, pc}
loc_098c:
	mov r1, #0
	mov r2, #0

sub_0994:
	str r2, [r0, r1, lsl #2]
	add r3, r0, r1
	strb r2, [r3, #0x78]
	add r1, r1, #1
	cmp r1, #0x1e
	blt sub_0994
	ldmdb fp, {fp, sp, pc}

sub_09b0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, #0

sub_09c8:
	add r1, r4, r6, lsl #2
	mov r0, r4
	bl sub_14d8
	add r6, r6, #1
	cmp r6, #0x1e
	blt sub_09c8
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, r6, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
loc_09f4:
	ldr r3, [r2, #8]!
	add r2, r2, #4
	ldr r1, [r0, #0x14]
	ldr r0, [r0, #0x18]
	b loc_1988
loc_0a08:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	add r3, r4, #0x18
	ldmia r3, {r1, r2, r3}
	stmdb sp!, {r1, r2, r3}
	add r4, r4, #8
	ldmib r4!, {r1, r2, r3}
	bl sub_0a48
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0a48:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r5, r2
	mov r6, r3
	mov r8, #0
	ldr sb, [fp, #8]
	ldr sl, [fp, #4]
	ldr r0, [r0, #0x54]
	teq r0, #0
	blne DisposPtr
	mov r0, r5
	bl strlen
	add r0, r0, #1
	bl NewPtr
	str r0, [r4, #0x54]
	teq r0, #0
	beq loc_0ac0
	mov r1, r5
	bl strcpy
	mov r1, r6
	str r7, [r4, #0x60]
	adr r0, str_0ac8, #30
	bl NewByName__FPCcT1
	str r0, [r4, #0x5c]
	teq r0, #0
	bne loc_0adc
	ldr r8, lit_0ad8
loc_0ac0:
	mov r1, r8
	b loc_0c24
str_0ac8:
	.asciz "TLanternDriver"
	.align 4
lit_0ad8:
	.word 0xffff11b7
loc_0adc:
	adr r1, str_0b10, #30
	adr r0, str_0b1c, #30
	bl NewByName__FPCcT1
	ldr r1, [r4, #0x5c]
	str r0, [r1, #0x18]!
	teq r0, #0
	ldr r1, [r4, #0x5c]
	bne loc_0b30
	mov r5, #0xb6
	sub r5, r5, #0xef00
	mov r0, r1
	bl sub_31c8
	b loc_0c20
str_0b10:
	.asciz "TDriverAPI"
	.align 4
str_0b1c:
	.asciz "TLanternDriverAPI"
	.align 4
loc_0b30:
	mov r1, r4
	bl sub_30e8
	ldr r0, [r4, #0x5c]
	str sl, [r0, #0x10]!
	ldr r0, [r4, #0x5c]
	mov r6, #0
	str sb, [r0, #0x14]!
	str r6, [sp, #-0x6c]!
	add r0, sp, #8
	bl setjmp
	teq r0, #0
	bne loc_0b78
	mov r0, sp
	bl AddExceptionHandler
	ldr r0, [r4, #0x5c]
	bl sub_31e4
	mov r5, r0
	b loc_0b80
loc_0b78:
	mov r5, #0xb2
	sub r5, r5, #0xef00
loc_0b80:
	mov r0, sp
	bl ExitHandler
	add sp, sp, #0x6c
	teq r5, #0
	beq loc_0ba0
	mov r0, r4
	bl sub_0c30
	b loc_0c20
loc_0ba0:
	mov r3, #1
	ldr r2, [r4, #0x54]
	stmdb sp!, {r2, r3}
	mov r0, r4
	mov r3, #2
	ldr r2, lit_0c0c
	ldr r1, lit_0c10
	bl sub_23ac
	add sp, sp, #8
	ldrb r0, [r4, #0xd8]
	teq r0, #0
	beq loc_0c20
	mov r0, #0
	bl sub_0968
	str r0, [r4, #0xd4]
	movs r1, r0
	beq loc_0c1c
	mov r0, r1
	bl sub_0ee8
	teq r0, #0
	ldr r0, [r4, #0xd4]
	beq loc_0c14
	teq r0, #0
	movne r1, #1
	blne sub_09b0
	str r6, [r4, #0xd4]
	b loc_0c1c
lit_0c0c:
	.word 0x696e7374			; 'inst'
lit_0c10:
	.word 0x6c616e74			; 'lant'
loc_0c14:
	teq r0, #0
	bne loc_0c20
loc_0c1c:
	strb r6, [r4, #0xd8]
loc_0c20:
	mov r1, r5
loc_0c24:
	mov r0, r4
	bl sub_26e4
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_0c30:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, #0
	str r6, [sp, #-0x6c]!
	add r0, sp, #8
	bl setjmp
	teq r0, #0
	bne loc_0d10
	mov r0, sp
	bl AddExceptionHandler
	mov r8, #1
	sub sp, sp, #0x1c
	mov r0, sp
	ldr r1, [r4, #0x74]
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r5, r0
	beq loc_0cc0
loc_0c84:
	mov r0, sp
	bl NextItem__13CListIteratorFv
	mov r7, r0
	mov r1, r5
	ldr r0, [r4, #0x74]
	bl Remove__5CListFPv
	teq r5, #0
	beq loc_0cb8
	mov r0, r5
	mov r1, #0
	bl sub_0880
	mov r0, r5
	bl __dl__FPv
loc_0cb8:
	movs r5, r7
	bne loc_0c84
loc_0cc0:
	ldr r0, [r4, #0x5c]
	ldr r5, [r0, #0x18]
	bl sub_31c8
	mov r0, r5
	bl sub_30cc
	str r6, [r4, #0x5c]
	ldr r0, [r4, #0x64]
	teq r0, #0
	beq loc_0cec
	bl DisposPtr
	str r6, [r4, #0x64]
loc_0cec:
	ldr r0, [r4, #0xbc]
	teq r0, #2
	streq r8, [r4, #0xbc]
	moveq r0, r4
	bleq sub_193c
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
loc_0d10:
	mov r0, sp
	bl ExitHandler
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_0d1c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_0d48
loc_0d48:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r3, #0
	ldr r2, [r0, #0x54]
	stmdb sp!, {r2, r3}
	mov r3, #2
	ldr r2, lit_0e48
	ldr r4, lit_0e4c
	mov r1, r4
	bl sub_23ac
	add sp, sp, #8
	mov r3, #0
	ldr r2, [r5, #0x54]
	stmdb sp!, {r2, r3}
	mov r0, r5
	mov r3, #2
	ldr r2, lit_0e48
	ldr r1, lit_0e4c
	bl sub_2608
	add sp, sp, #8
	ldr r6, [r5, #0x68]
	teq r6, #0
	beq loc_0dc4
loc_0dac:
	mov r1, r6
	mov r0, r5
	bl sub_1134
	ldr r6, [r6, #0x30]
	teq r6, #0
	bne loc_0dac
loc_0dc4:
	mov r6, #0
	str r6, [r5, #0x60]
	mov r0, r5
	bl sub_0c30
	str r6, [r5, #0xd0]
	sub sp, sp, #0x18
	mov r0, sp
	mov r1, #0x3ec
	add r1, r1, #0x2cc00
	bl TimeFromNow
	add r1, sp, #0x10
	ldmia sp, {ip, lr}
	stmia r1, {ip, lr}
	mov r3, #1
	mov r2, #1
	ldr r1, lit_0e50
	stmdb sp!, {r1, r2, r3}
	add r0, sp, #0x14
	ldr r1, [r5, #0x18]
	bl sub_064c
	add r0, sp, #0x14
	add r1, r5, #0xc0
	add r2, sp, #0x1c
	mov r3, r4
	bl sub_07a8
	add sp, sp, #0xc
	mov r4, r0
	add r0, sp, #8
	mov r1, #0
	bl __dt__8TUObjectFv
	teq r4, #0
	bne loc_0e54
loc_0e44:
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
lit_0e48:
	.word 0x696e7374			; 'inst'
lit_0e4c:
	.word 0x6c616e74			; 'lant'
lit_0e50:
	.word 0x64696521			; 'die!'
loc_0e54:
	mov r0, r5
	ldr r1, [r5]
	mov lr, pc
	add pc, r1, #0x18
	b loc_0e44
loc_0e68:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_0e94
loc_0e94:
	mov r1, #3
	str r1, [r0, #0xbc]
	ldr r1, [r0, #0x6c]
	teq r1, #0
	bne loc_1bb0
	mov pc, lr
loc_0eac:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_0ed8
loc_0ed8:
	ldr r1, [r0, #0x6c]
	teq r1, #0
	bne sub_1b40
	mov pc, lr

sub_0ee8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r1, #0x640
	bl sub_11b4
	str r0, [r4]
	teq r0, #0
	movne r0, #0
	moveq r0, #0xe9
	subeq r0, r0, #0x2800
	ldmdb fp, {r4, fp, sp, pc}
loc_0f18:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r3, [r4, #0x18]
	stmdb sp!, {r3}
	add r4, r4, #8
	ldmib r4!, {r1, r2, r3}
	bl sub_0f54
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_0f54:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	movs r4, r1
	mov r7, r2
	mov r6, r3
	ldr r8, [fp, #4]
	bne loc_0fd0
	sub sp, sp, #0x20
	mov r0, sp
	bl __ct__14TAEventHandlerFv
	ldr r0, lit_0fcc
	str r0, [sp]
	add lr, sp, #0x20
	ldmdb lr!, {r1, r2, r3, ip}
	stmdb sp!, {r1, r2, r3, ip}
	ldmdb lr!, {r1, r2, r3, ip}
	stmdb sp!, {r1, r2, r3, ip}
	mov r0, r5
	mov r2, #9
	mov r1, #0
	ldr r3, [sp], #4
	bl sub_2720
	add sp, sp, #0x1c
	mov r0, sp
	mov r1, #0
	mov lr, pc
	ldr pc, [sp]
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_0fcc:
	.rword sub_016c				; relocated
loc_0fd0:
	sub sp, sp, #0x1c
	mov r0, sp
	bl sub_084c
	ldr r0, lit_1030
	teq r4, #2
	str r0, [sp]
	strne r6, [sp, #0xc]
	strne r8, [sp, #0x10]
	strne r7, [sp, #8]
	add lr, sp, #0x1c
	ldmdb lr!, {r1, r2, r3, ip}
	stmdb sp!, {r1, r2, r3, ip}
	ldmdb lr!, {r2, r3, ip}
	stmdb sp!, {r2, r3, ip}
	mov r0, r5
	mov r2, #8
	mov r1, #0
	ldr r3, [sp], #4
	bl sub_2720
	add sp, sp, #0x18
	mov r0, sp
	mov r1, #0
	bl sub_0880
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_1030:
	.rword sub_0130				; relocated
loc_1034:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1064
loc_1064:
	mov r1, #0
	b sub_26e4
loc_106c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_109c
loc_109c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_2750
	mov r0, #1
	strb r0, [r5, #0x34]
	ldrb r1, [r5, #0x10]
	teq r1, #0
	strbne r0, [r4, #0x70]
	mov r0, r4
	bl sub_1b40
	mov r1, r0
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_26e4
loc_10e0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1110
loc_1110:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_1134
	mov r1, r0
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_26e4

sub_1134:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	bl sub_276c
	teq r0, #0
	ldmdbne fp, {r4, r5, fp, sp, pc}
	mov r1, #0
	strb r1, [r5, #0x34]
	ldrb r2, [r5, #0x10]
	teq r2, #0
	strbne r1, [r4, #0x70]
	ldr r1, [r4, #0x6c]
	teq r1, #0
	moveq r0, r4
	ldmdbeq fp, {r4, r5, fp, sp, lr}
	beq loc_1bb0
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_1180:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	add r4, r4, #8
	ldmib r4!, {r1, r2, r3}
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_11f0

sub_11b4:
	mov r1, #0

sub_11b8:
	add r2, r0, r1
	ldrb r2, [r2, #0x78]
	teq r2, #0
	bne loc_11dc
	mov r2, #1
	add r3, r0, r1
	strb r2, [r3, #0x78]
	ldr r0, [r0, r1, lsl #2]
	mov pc, lr
loc_11dc:
	add r1, r1, #1
	cmp r1, #0x1e
	blt sub_11b8
	mov r0, #0
	mov pc, lr
loc_11f0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	sub sp, sp, #0x1c
	ldr r1, [r0, #0xdc]
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r8, r0
	beq loc_1298
loc_122c:
	ldr r0, [r8]
	teq r0, r7
	mov r0, sp
	bne loc_128c
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
	ldr r0, [r8, #0x10]
	cmp r0, r5
	movlo r5, r0
	mov r2, r5
	mov r0, r6
	ldr r1, [r8, #0xc]
	bl memcpy
	ldr r0, [r8, #0x14]
	teq r0, #0
	subne r0, r0, #1
	strne r0, [r8, #0x14]!
	mov r3, r5
	mov r0, r4
	mov r2, #1
	mov r1, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b sub_2720
loc_128c:
	bl NextItem__13CListIteratorFv
	movs r8, r0
	bne loc_122c
loc_1298:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r4
	ldr r1, lit_12b4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b sub_26e4
lit_12b4:
	.word 0xffff11b3
loc_12b8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	add r4, r4, #8
	ldmib r4!, {r1, r2}
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_12ec
loc_12ec:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0x1c
	ldr r1, [r0, #0xdc]
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r7, r0
	beq loc_1378
loc_1324:
	ldr r0, [r7]
	teq r0, r6
	mov r0, sp
	bne loc_136c
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
	mov r0, r5
	add r2, r7, #0xc
	ldmia r2, {r1, r2}
	bl Putn__11CBufferListFPCUcl
	ldr r0, [r7, #0x14]
	teq r0, #0
	subne r0, r0, #1
	strne r0, [r7, #0x14]!
	mov r0, r4
	mov r1, #0
	b loc_1390
loc_136c:
	bl NextItem__13CListIteratorFv
	movs r7, r0
	bne loc_1324
loc_1378:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
	mov r0, r4
	ldr r1, lit_1398
loc_1390:
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b sub_26e4
lit_1398:
	.word 0xffff11b3
loc_139c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_13cc
loc_13cc:
	subs ip, r1, #0x1d80
	cmphs ip, #0x12
	bls sub_13ec
	subs ip, r1, #0x7600
	cmphs ip, #0x48
	strlo r1, [r0, #0xf0]
	movlo r1, #0
	blo sub_13f4

sub_13ec:
	mov r1, #0xf0
	sub r1, r1, #0xf000

sub_13f4:
	b sub_26e4
loc_13f8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1428
loc_1428:
	cmp r1, #0x3e8
	bls sub_1444
	subs ip, r1, #0xea00
	cmphs ip, #0x60
	strlo r1, [r0, #0xe8]
	movlo r1, #0
	blo sub_144c

sub_1444:
	mov r1, #0xf0
	sub r1, r1, #0xf000

sub_144c:
	b sub_26e4
loc_1450:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_147c
loc_147c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	add r2, r0, #0xec
	ldmia r2, {r1, r2}
	ldr r3, [r0, #0xe8]
	stmdb sp!, {r1, r2, r3}
	mov r2, #4
	mov r1, #0
	ldr r3, [r0, #0xe4]
	bl sub_2720
	ldmdb fp, {fp, sp, pc}
loc_14ac:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1514

sub_14d8:
	mov r2, #0
	ldr r1, [r1]

sub_14e0:
	ldr r3, [r0, r2, lsl #2]
	teq r3, r1
	bne loc_1500
	mov r1, #0
	add r0, r0, r2
	strb r1, [r0, #0x78]
	mov r0, r1
	mov pc, lr
loc_1500:
	add r2, r2, #1
	cmp r2, #0x1e
	blt sub_14e0
	mvn r0, #0
	mov pc, lr
loc_1514:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov ip, r0
	ldr r1, [r0, #0x120]
	add r3, r0, #0x12c
	ldmia r3, {r2, r3}
	ldr r0, [r0, #0x114]
	stmdb sp!, {r0, r1, r2, r3}
	ldr r3, [ip, #0xf4]
	mov r0, ip
	mov r2, #5
	mov r1, #0
	bl sub_2720
	ldmdb fp, {fp, sp, pc}
loc_1550:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_157c
loc_157c:
	mov r1, #0
	str r1, [r0, #0x130]
	str r1, [r0, #0x12c]
	str r1, [r0, #0x120]
	str r1, [r0, #0x114]
	str r1, [r0, #0xf4]
	b sub_26e4
loc_1598:
	ldr r0, [r0, #0x5c]
	b loc_3208
loc_15a0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_15cc
loc_15cc:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x2c
	ldr r1, [r0, #0xdc]
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r5, r0
	mov r7, #0
	add r6, r4, #0x90
	beq loc_16a0
loc_1604:
	mov r0, r6
	add r1, r5, #4
	bl CompCompare
	cmp r0, #0
	ble sub_162c
	ldr r0, [r4, #0x130]
	add r0, r0, #1
	str r0, [r4, #0x130]
	str r7, [r5, #0x14]
	b loc_1638

sub_162c:
	ldr r0, [r5, #0x14]
	teq r0, #0
	bne loc_1690
loc_1638:
	ldr r0, [r4, #0xe4]
	sub r0, r0, #1
	str r0, [r4, #0xe4]
	ldr r0, [r5, #0xc]
	bl GetPtrSize
	ldr r1, [r4, #0xec]
	sub r0, r1, r0
	str r0, [r4, #0xec]
	mov r1, r5
	ldr r0, [r4, #0xdc]
	bl Remove__5CListFPv
	ldrb r0, [r4, #0xd8]
	teq r0, #0
	beq loc_1680
	add r1, r5, #0xc
	ldr r0, [r4, #0xd4]
	bl sub_14d8
	b loc_1688
loc_1680:
	ldr r0, [r5, #0xc]
	bl DisposPtr
loc_1688:
	mov r0, r5
	bl __dl__FPv
loc_1690:
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r5, r0
	bne loc_1604
loc_16a0:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, sp
	ldr r1, [r4, #0x78]
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r5, r0
	beq loc_172c
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r5
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #1
	beq loc_172c
	sub sp, sp, #4
	mov r1, sp
	mov r0, r5
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	beq loc_1728
	mov r1, r7
	mov r0, r5
	bl SetUserRefCon__14TUSharedMemMsgFUl
	ldr r0, [r4, #0x134]
	add r0, r0, #1
	str r0, [r4, #0x134]
	ldr r0, [sp]
	bl __dl__FPv
loc_1728:
	add sp, sp, #4
loc_172c:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
	mov r5, r6
	mov r7, r6
	mov r0, sp
	mov r2, #0x66
	add r2, r2, #0xe00
	mov r1, #0x64
	bl __ct__5TTimeFUl9TimeUnits
	sub sp, sp, #8
	add r0, sp, #8
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	mov r1, sp
	mov r0, r7
	bl CompAdd
	movs r0, r5
	bne loc_178c
	mov r0, #8
	bl __nw__FUi
	teq r0, #0
	beq loc_1794
loc_178c:
	ldmia sp, {r3, ip}
	stmia r0, {r3, ip}
loc_1794:
	add sp, sp, #8
	mov r3, #0
	ldr r2, lit_17d8
	stmdb sp!, {r2, r3}
	add r0, sp, #0x10
	ldr r1, [r4, #0x18]
	bl sub_064c
	add r0, sp, #0x10
	mov r2, r6
	add r1, r4, #0x80
	ldr r3, lit_17dc
	bl sub_07a8
	add sp, sp, #8
	add r0, sp, #8
	mov r1, #0
	bl __dt__8TUObjectFv
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_17d8:
	.word 0x7469636b			; 'tick'
lit_17dc:
	.word 0x6c616e74			; 'lant'
loc_17e0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1810
loc_1810:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	sub sp, sp, #0x1c
	ldr r1, [r0, #0xdc]
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov sb, #0
	strb sb, [r4, #0xa8]
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r7, r0
	beq loc_18f8
loc_184c:
	ldr r0, [r7]
	teq r0, r5
	beq loc_186c
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r7, r0
	bne loc_184c
	b loc_18f8
loc_186c:
	teq r7, #0
	beq loc_18f8
	ldr r6, lit_1908
	ldr r5, lit_190c
loc_187c:
	str sb, [r7, #0x14]
	ldr r8, [r4, #0x68]
	teq r8, #0
	beq loc_18e8
loc_188c:
	add r2, r7, #0xc
	ldmia r2, {r1, r2}
	ldr r0, [r8, #0x28]
	mov lr, pc
	ldr pc, [r8, #0x2c]
	teq r0, #0
	beq loc_18dc
	ldr r0, [r7, #0x14]
	add r0, r0, #1
	str r0, [r7, #0x14]
	mov r1, #2
	ldr r2, [r7]
	ldr r3, [r7, #0x10]
	stmdb sp!, {r1, r2, r3}
	mov r1, r8
	mov r0, r4
	mov r3, r6
	mov r2, r5
	bl sub_263c
	add sp, sp, #0xc
loc_18dc:
	ldr r8, [r8, #0x30]
	teq r8, #0
	bne loc_188c
loc_18e8:
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r7, r0
	bne loc_187c
loc_18f8:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_1908:
	.word 0x706b7420			; 'pkt '
lit_190c:
	.word 0x6c616e74			; 'lant'
loc_1910:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldmdb fp, {r4, r5, fp, sp, lr}
	b sub_193c

sub_193c:
	mov r2, r0
	mov r0, #0
	ldr r3, [r2, #0xbc]
	teq r3, #0
	moveq pc, lr
	mov r1, #0
	teq r3, #1
	beq loc_1974
	teq r3, #2
	moveq r0, r1
	moveq pc, lr
	teq r3, #3
	movne pc, lr
	b loc_1978
loc_1974:
	str r1, [r2, #0xbc]
loc_1978:
	mov r0, r2
	mov r1, #2
	ldr r2, [r2]
	add pc, r2, #0x38
loc_1988:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov lr, r1
	mov ip, r2
	add r3, r2, #0x18
	ldmia r3, {r2, r3}
	add r1, ip, #0x10
	ldmia r1, {r0, r1}
	stmdb sp!, {r0, r1, r2, r3}
	ldr r3, [ip, #0xc]
	stmdb sp!, {r3}
	mov r0, lr
	ldmia ip, {r1, r2, r3}
	mov lr, pc
	mov pc, r4
	ldmdb fp, {r4, fp, sp, pc}
loc_19d0:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r4, r2
	bl GetGlobals
	add r0, r0, #0x4c
	stmia r0, {r4, r5}
	sub r0, r0, #0x4c
	ldr r1, [r4, #0xc]!
	ldmdb fp, {r4, r5, fp, sp, lr}
	b loc_1a00
loc_1a00:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	add r5, r0, #0xc0
	teq r1, #0
	beq loc_1b20
	mov r6, #1
	ldr r1, [r4, #0xd0]
	add r0, r1, r6
	cmp r1, #0x64
	str r0, [r4, #0xd0]
	bhi loc_1b10
	sub sp, sp, #0x1c
	mov r0, sp
	ldr r1, [r4, #0x78]
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	teq r0, #0
	beq loc_1a88
loc_1a54:
	mov r3, #0
	stmdb sp!, {r3}
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #0
	movne r6, #0
	bne loc_1a88
	mov r0, sp
	bl NextItem__13CListIteratorFv
	teq r0, #0
	bne loc_1a54
loc_1a88:
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
	teq r6, #0
	bne loc_1b10
	sub sp, sp, #0x18
	mov r0, sp
	mov r1, #0x3ec
	add r1, r1, #0x2cc00
	bl TimeFromNow
	add r0, sp, #0x10
	ldmia sp, {ip, lr}
	stmia r0, {ip, lr}
	mov r3, #1
	mov r2, #1
	ldr r1, lit_1b38
	stmdb sp!, {r1, r2, r3}
	add r0, sp, #0x14
	ldr r1, [r4, #0x18]
	bl sub_064c
	add r0, sp, #0x14
	mov r1, r5
	add r2, sp, #0x1c
	ldr r3, lit_1b3c
	bl sub_07a8
	add sp, sp, #0xc
	mov r5, r0
	add r0, sp, #8
	mov r1, #0
	bl __dt__8TUObjectFv
	teq r5, #0
	add sp, sp, #0x18
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
loc_1b10:
	mov r0, r4
	ldr r1, [r4]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	add pc, r1, #0x18
loc_1b20:
	mov r0, r5
	bl Abort__14TUAsyncMessageFv
	mov r1, r0
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b sub_26e4
lit_1b38:
	.word 0x64696521			; 'die!'
lit_1b3c:
	.word 0x6c616e74			; 'lant'

sub_1b40:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	str r0, [sp, #-0x6c]!
	add r0, sp, #8
	bl setjmp
	mov r1, #1
	teq r0, #0
	bne loc_1b84
	mov r0, sp
	bl AddExceptionHandler
	ldr r0, [r4, #0x5c]!
	bl sub_31f0
	mov r4, r0
	b loc_1ba0
loc_1b84:
	ldr r0, [r4, #0xbc]
	teq r0, #2
	streq r1, [r4, #0xbc]
	moveq r0, r4
	bleq sub_193c
	mov r4, #0xb2
	sub r4, r4, #0xef00
loc_1ba0:
	mov r0, sp
	bl ExitHandler
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
loc_1bb0:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0
	str r0, [sp, #-0x6c]!
	add r0, sp, #8
	bl setjmp
	teq r0, #0
	bne loc_1bf0
	mov r0, sp
	bl AddExceptionHandler
	ldr r0, [r4, #0x5c]!
	bl sub_31fc
	mov r4, r0
	b loc_1bf8
loc_1bf0:
	mov r4, #0xb2
	sub r4, r4, #0xef00
loc_1bf8:
	mov r0, sp
	bl ExitHandler
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
loc_1c08:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	and r6, r2, #0xff
	ldr r0, [r0, #0xbc]
	teq r0, #0
	beq loc_1c48
	mov r7, #0
	teq r0, #1
	beq loc_1ce8
	teq r0, #2
	beq loc_1d00
	teq r0, #3
	bne loc_1ca0
loc_1c48:
	mov r0, r4
	mov r1, #1
	ldr r2, [r4]
	mov lr, pc
	add pc, r2, #0x38
	mov r3, #1
	str r0, [r4, #0x48]
	stmdb sp!, {r3}
	mov r0, r4
	ldr r2, lit_1ce0
	ldr r1, lit_1ce4
	bl sub_23ac
	add sp, sp, #4
	mov r3, #1
	stmdb sp!, {r3}
	mov r0, r4
	ldr r2, lit_1ce0
	ldr r1, lit_1ce4
	bl sub_2608
	add sp, sp, #4
	mov r0, #1
	strb r0, [r5]
loc_1ca0:
	ldr r0, [r4, #0x48]
	teq r0, #0
	bne loc_1cd0
	teq r6, #0
	beq loc_1cd0
	mov r0, r4
	mov r2, #1
	mov r1, #0xc
	ldr r3, [r4]
	mov lr, pc
	add pc, r3, #0x38
	str r0, [r4, #0x48]
loc_1cd0:
	mov r0, #2
	str r0, [r4, #0xbc]
	ldr r0, [r4, #0x48]!
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_1ce0:
	.word 0x63617264			; 'card'
lit_1ce4:
	.word 0x6c616e74			; 'lant'
loc_1ce8:
	add r0, r4, #0xac
	bl Abort__14TUAsyncMessageFv
	str r0, [r4, #0x48]
	add ip, r0, #0x2700
	cmn ip, #0x37
	streq r7, [r4, #0x48]
loc_1d00:
	strb r7, [r5]
	b loc_1ca0
loc_1d08:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	and r7, r2, #0xff
	mov r6, #0
	ldr r2, [r0, #0xbc]
	mov r0, #0
	teq r2, #0
	teqne r2, #1
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	ldr r4, lit_1d4c
	teq r2, #2
	beq loc_1d50
	teq r2, #3
	bne loc_1df0
	b loc_1de4
lit_1d4c:
	.word 0x6c616e74			; 'lant'
loc_1d50:
	mov r0, #1
	teq r1, #0
	str r0, [r5, #0xbc]
	beq loc_1de4
	sub sp, sp, #0x18
	mov ip, #0x66
	add ip, ip, #0xe00
	mul r1, ip, r1
	mov r0, sp
	bl TimeFromNow
	add r0, sp, #0x10
	ldmia sp, {ip, lr}
	stmia r0, {ip, lr}
	mov r3, #0
	ldr r2, lit_1de0
	stmdb sp!, {r2, r3}
	add r0, sp, #0x10
	ldr r1, [r5, #0x18]
	bl sub_064c
	add r0, sp, #0x10
	add r1, r5, #0xac
	add r2, sp, #0x18
	mov r3, r4
	bl sub_07a8
	add sp, sp, #8
	mov r6, r0
	add r0, sp, #8
	mov r1, #0
	bl __dt__8TUObjectFv
	teq r6, #0
	beq loc_1dd8
	mov r0, r5
	bl sub_193c
	mov r6, r0
loc_1dd8:
	add sp, sp, #0x18
	b loc_1df0
lit_1de0:
	.word 0x706f7772			; 'powr'
loc_1de4:
	mov r0, r5
	bl sub_193c
	mov r6, r0
loc_1df0:
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #1
	ldr r2, lit_1e60
	mov r1, r4
	bl sub_23ac
	add sp, sp, #4
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r5
	mov r3, #1
	ldr r2, lit_1e60
	ldr r1, lit_1d4c
	bl sub_2608
	add sp, sp, #4
	teq r7, #0
	beq loc_1e58
	mov r0, r5
	mov r2, #0
	mov r1, #0xc
	ldr r3, [r5]
	mov lr, pc
	add pc, r3, #0x38
	teq r0, #0
	movne r6, r0
loc_1e58:
	mov r0, r6
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_1e60:
	.word 0x63617264			; 'card'
loc_1e64:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0, #0xec]
	add r0, r0, r1
	ldr r1, [r4, #0xf0]
	cmp r0, r1
	movhi r0, #0
	ldmdbhi fp, {r4, r5, fp, sp, pc}
	ldr r0, [r4, #0x64]
	teq r0, #0
	beq loc_1eb4
	bl GetPtrSize
	ldr r1, [r4, #0xec]
	sub r0, r1, r0
	str r0, [r4, #0xec]
	ldr r0, [r4, #0x64]
	bl DisposPtr
loc_1eb4:
	ldr r0, [r4, #0xd4]
	teq r0, #0
	beq loc_1ecc
	mov r1, r5
	bl sub_11b4
	b loc_1ed4
loc_1ecc:
	mov r0, r5
	bl NewPtr
loc_1ed4:
	str r0, [r4, #0x64]
	ldr r0, [r4, #0x64]
	teq r0, #0
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	ldr r1, [r4, #0xec]
	add r1, r1, r5
	str r1, [r4, #0xec]
	ldr r3, [r4, #0xf4]
	cmp r1, r3
	strhi r1, [r4, #0xf4]!
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_1f00:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	movs r5, r2
	mov sb, #0
	str sb, [r0, #0x64]
	ldr r8, [r0, #0xe0]
	add r0, r8, #1
	str r0, [r4, #0xe0]
	bne loc_1f3c
	mov r0, r6
	bl GetPtrSize
	mov r5, r0
loc_1f3c:
	ldr r0, [r4, #0x114]
	ldr r1, [r4, #0x120]
	mla r1, r0, r1, r5
	add r0, r0, #1
	str r0, [r4, #0x114]
	bl __rt_udiv
	str r0, [r4, #0x120]
	ldr r7, [r4, #0x68]
	teq r7, #0
	beq loc_1f8c
loc_1f64:
	mov r2, r5
	mov r1, r6
	ldr r0, [r7, #0x28]
	mov lr, pc
	ldr pc, [r7, #0x2c]
	teq r0, #0
	bne loc_1f98
	ldr r7, [r7, #0x30]
	teq r7, #0
	bne loc_1f64
loc_1f8c:
	mov r5, #0
	sub sp, sp, #0x10
	b loc_1fc4
loc_1f98:
	mov r0, #0x18
	bl __nw__FUi
	cmp r0, #0
	mov r7, r0
	sub sp, sp, #0x10
	bne loc_1fe8
	mov r5, #0xe9
	sub r5, r5, #0x2800
	ldr r0, [r4, #0x12c]
	add r0, r0, #1
	str r0, [r4, #0x12c]
loc_1fc4:
	mov r0, r6
	bl GetPtrSize
	ldr r1, [r4, #0xec]
	sub r0, r1, r0
	str r0, [r4, #0xec]!
	mov r0, r6
	bl DisposPtr
	mov r0, r5
	b loc_20d4
loc_1fe8:
	str r8, [r7]
	add sl, r7, #4
	mov r0, sp
	bl GetGlobalTime
	add r0, sp, #8
	mov r2, #0x66
	add r2, r2, #0xe00
	ldr r1, [r4, #0xe8]
	bl __ct__5TTimeFUl9TimeUnits
	sub sp, sp, #8
	add r0, sp, #0x10
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	mov r1, sp
	add r0, sp, #8
	bl CompAdd
	movs r0, sl
	bne loc_2040
	mov r0, #8
	bl __nw__FUi
	teq r0, #0
	beq loc_2048
loc_2040:
	ldmia sp, {r3, ip}
	stmia r0, {r3, ip}
loc_2048:
	add sp, sp, #8
	mvn r0, #0
	str r0, [r7, #0x14]
	str r5, [r7, #0x10]
	str r6, [r7, #0xc]
	ldr r0, [r4, #0xe4]
	add r0, r0, #1
	str r0, [r4, #0xe4]
	mov r2, r7
	ldr r0, [r4, #0xdc]
	ldr r1, [r0]
	bl InsertAt__5CListFlPv
	ldrb r0, [r4, #0xa8]
	teq r0, #0
	bne loc_20d0
	sub sp, sp, #8
	mov r0, #1
	strb r0, [r4, #0xa8]
	mov r3, r8
	mov r2, #2
	stmdb sp!, {r2, r3}
	add r0, sp, #8
	ldr r1, [r4, #0x18]
	bl sub_064c
	add r0, sp, #8
	add r1, r4, #0x98
	ldr r3, lit_20d8
	ldr r2, lit_20dc
	bl sub_0704
	add sp, sp, #8
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	add sp, sp, #8
loc_20d0:
	mov r0, sb
loc_20d4:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
lit_20d8:
	.word 0x706b7420			; 'pkt '
lit_20dc:
	.word 0x6c616e74			; 'lant'
loc_20e0:
	mov r0, #0
	mov pc, lr
loc_20e8:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r0, #0
	str r0, [sp, #-0x6c]!
	add r0, sp, #8
	bl setjmp
	teq r0, #0
	bne loc_2148
	mov r0, sp
	bl AddExceptionHandler
	ldr r0, [fp, #4]
	ldr r0, [r0, #0x60]
	teq r0, #0
	moveq r4, #0x1b0
	subeq r4, r4, #0xf000
	beq loc_2150
	add r2, fp, #0x18
	mov r3, #0
	ldr r1, [fp, #8]
	bl CardSpecific__12TCardHandlerFUlPvT1
	mov r4, r0
	b loc_2150
loc_2148:
	mov r4, #0xb2
	sub r4, r4, #0xef00
loc_2150:
	mov r0, sp
	bl ExitHandler
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}
loc_2160:
	ldr r3, [r2, #8]!
	add r2, r2, #4
	ldr r1, [r0, #0x14]
	ldr r0, [r0, #0x18]
	b loc_1988
loc_2174:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	mov r0, #0x1c
	ldr sb, [fp, #4]
	bl __nw__FUi
	movs r8, r0
	beq loc_21b4
	mov r0, r8
	bl sub_084c
	ldr r0, lit_21f0
	str r0, [r8]
loc_21b4:
	ldr r0, [r4, #0x5c]
	mov r3, r5
	mov r2, r6
	mov r1, r7
	add r8, r8, #0x14
	stmia r8, {r0, sb}
	sub r8, r8, #0x14
	mov r0, r8
	bl sub_0688
	mov r2, r8
	mov r1, #0
	ldr r0, [r4, #0x74]!
	bl InsertAt__5CListFlPv
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}
lit_21f0:
	.rword sub_0204				; relocated
loc_21f4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	ldr r7, [r0, #0x68]
	teq r7, #0
	beq loc_22b0
loc_2218:
	mov r2, r4
	mov r1, r6
	mov r0, r5
	bl sub_24b0
	movs r8, r0
	beq loc_22a4
	sub sp, sp, #0xc
	add r1, sp, #8
	mov r0, r8
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	mov r0, sp
	ldr r1, [r7, #0x1c]!
	bl __ct__6TUPortFUl
	mov r2, #0
	mov r3, #0
	mov lr, #0
	mov r1, #0
	mov r0, #1
	ldr ip, [sp, #8]
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, lr
	mov r2, r4
	stmdb sp!, {r2, r3}
	mov r3, ip
	add r0, sp, #0x18
	mov r2, #0
	ldr r1, [r8]
	bl SendGoo__6TUPortFUlT1PvN31UcT1P5TTime
	add sp, sp, #0x18
	mov r4, r0
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_22a4:
	ldr r7, [r7, #0x30]
	teq r7, #0
	bne loc_2218
loc_22b0:
	mov r0, #0xb1
	sub r0, r0, #0xef00
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_22bc:
	mov r3, r2
	mov r2, r1
	mov r1, #0
	ldr ip, [r0]
	add pc, ip, #0x48
loc_22d0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r1, r2
	mov r4, r3
	mov r2, r3
	bl sub_24b0
	movs r7, r0
	moveq r0, #0xb1
	subeq r0, r0, #0xef00
	ldmdbeq fp, {r4, r5, r6, r7, fp, sp, pc}
	sub sp, sp, #4
	mov r1, sp
	mov r0, r7
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	add ip, r5, #0x18
	mov r2, #0
	mov r3, r6
	mov r5, #0
	mov r1, #0
	mov r0, #1
	ldr lr, [sp]
	stmdb sp!, {r0, r1, r2, r3}
	mov r3, r5
	mov r2, r4
	stmdb sp!, {r2, r3}
	mov r3, lr
	mov r0, ip
	mov r2, #0
	ldr r1, [r7]
	bl SendGoo__6TUPortFUlT1PvN31UcT1P5TTime
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_2358:
	stmdb sp!, {lr}
	mov ip, r3
	ldr r3, [r0, #0x50]
	ldr lr, [r3]
	teq lr, #0
	moveq r0, #0xc5
	subeq r0, r0, #0x2800
	ldmiaeq sp!, {pc}
	ldrb lr, [r0, #0x20]
	teq lr, #0
	ldrne r0, lit_23a8
	ldmiane sp!, {pc}
	mov lr, #1
	strb lr, [r0, #0x20]
	mov r0, r3
	mov r3, r1
	mov r1, r2
	mov r2, ip
	ldmia sp!, {lr}
	b ReplyRPC__10TUMsgTokenFPvUll
lit_23a8:
	.word 0xffff11af

sub_23ac:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	sub sp, sp, #0x18
	add r0, sp, #8
	bl __ct__12TUNameServerFv
	ldr r0, [fp, #4]
	ldrb r0, [r0, #0x70]
	teq r0, #0
	bne loc_2490
	add r3, sp, #4
	stmdb sp!, {r3}
	add r3, sp, #4
	add r0, sp, #0xc
	adr r2, str_24a0, #30
	adr r1, str_24a8, #30
	bl Lookup__12TUNameServerFPcT1PUlT3
	add sp, sp, #4
	teq r0, #0
	bne loc_2490
	mov r0, #0xc
	ldr r1, [fp, #0x10]
	add r2, r0, r1, lsl #2
	mov r5, r2
	add r1, fp, #8
	ldr r0, [fp, #4]
	bl sub_24b0
	movs r4, r0
	beq loc_2490
	sub sp, sp, #0xc
	add r1, sp, #8
	mov r0, r4
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r1, [sp, #0xc]
	mov r0, sp
	bl __ct__6TUPortFUl
	mov r2, #0
	mov r3, #0
	mov lr, #0
	mov r1, #0
	mov r0, #1
	ldr ip, [sp, #8]
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
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	add sp, sp, #0xc
loc_2490:
	add r0, sp, #8
	mov r1, #0
	bl __dt__12TUNameServerFv
	ldmdb fp, {r4, r5, fp, sp, pc}
str_24a0:
	.asciz "TUPort"
	.align 4
str_24a8:
	.asciz "newt"
	.align 4

sub_24b0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	sub sp, sp, #0x1c
	ldr r1, [r0, #0x78]
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r7, r0
	mov sb, #0
	beq loc_255c
loc_24ec:
	mov r3, #0
	stmdb sp!, {r3}
	mov r0, r7
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #0
	beq loc_2524
	mov r0, sp
	bl NextItem__13CListIteratorFv
	movs r7, r0
	bne loc_24ec
	b loc_255c
loc_2524:
	teq r7, #0
	beq loc_255c
	mov r1, r7
	ldr r0, [r4, #0x78]
	bl Remove__5CListFPv
	sub sp, sp, #4
	mov r1, sp
	mov r0, r7
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [sp]
	teq r0, #0
	blne __dl__FPv
	add sp, sp, #4
	b loc_25a8
loc_255c:
	mov r0, #0
	bl __ct__14TUAsyncMessageFv
	movs r7, r0
	bne loc_2584
loc_256c:
	mov r4, #0
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r4
	b loc_2604
loc_2584:
	mov r0, r7
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, r7
	mov r1, #0
	bl SetCollectorPort__14TUAsyncMessageFUl
	ldr r0, [r4, #0x7c]
	add r0, r0, #1
	str r0, [r4, #0x7c]
loc_25a8:
	mov r0, r5
	bl __nw__FUi
	movs r8, r0
	bne loc_25c8
	mov r1, sb
	mov r0, r7
	bl SetUserRefCon__14TUSharedMemMsgFUl
	b loc_256c
loc_25c8:
	mov r2, r5
	mov r1, r6
	mov r0, r8
	bl memcpy
	mov r1, r8
	mov r0, r7
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r2, r7
	ldr r0, [r4, #0x78]!
	ldr r1, [r0]
	bl InsertAt__5CListFlPv
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	mov r0, r7
loc_2604:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, fp, sp, pc}

sub_2608:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r0, #0xc
	ldr r1, [fp, #0x10]
	add r2, r0, r1, lsl #2
	add r1, fp, #8
	ldr r0, [fp, #4]
	ldr r3, [r0]
	mov lr, pc
	add pc, r3, #0x40
	ldmdb fp, {fp, sp, pc}

sub_263c:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov r5, #0xc
	ldr r0, [fp, #0x14]
	add r2, r5, r0, lsl #2
	add r1, fp, r5
	ldr r0, [fp, #4]
	bl sub_24b0
	movs r4, r0
	sub sp, sp, #0xc
	beq loc_26e0
	add r1, sp, #8
	mov r0, r4
	bl GetUserRefCon__14TUSharedMemMsgFPUl
	ldr r0, [fp, #8]
	ldr r1, [r0, #0x1c]!
	mov r0, sp
	bl __ct__6TUPortFUl
	ldr ip, [sp, #8]
	ldr r0, [fp, #0x14]
	add lr, r5, r0, lsl #2
	mov r2, #0
	mov r3, #0
	mov r5, #0
	mov r1, #0
	mov r0, #1
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
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
loc_26e0:
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_26e4:
	mov r3, #0
	mov r2, #0
	ldr ip, [r0]
	add pc, ip, #0x4c
loc_26f4:
	mov r1, r3
	ldr r2, [r3, #4]
	ldr ip, lit_271c
	teq r2, ip
	moveq pc, lr
	ldr r3, [r1, #8]
	add r2, r1, #0xc
	ldr r1, [r0, #0x18]
	ldr r0, [r0, #0x1c]
	b loc_1988
lit_271c:
	.word 0x2a2a2a2a			; '****'

sub_2720:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #0x14
	ldr r0, [fp, #0xc]
	mov r3, r0, lsl #2
	add r2, fp, #0x10
	ldmib fp, {r0, r1}
	ldr ip, [r0]
	mov lr, pc
	add pc, ip, #0x4c
	ldmdb fp, {fp, sp, pc}

sub_2750:
	ldr r2, [r0, #0x68]
	str r2, [r1, #0x30]
	str r1, [r0, #0x68]
	ldr r1, [r0, #0x6c]
	add r1, r1, #1
	str r1, [r0, #0x6c]!
	mov pc, lr

sub_276c:
	mov r3, #0
	ldr r2, [r0, #0x68]
	teq r2, #0
	beq loc_27b8
loc_277c:
	teq r2, r1
	bne loc_27a8
	teq r3, #0
	ldr r1, [r2, #0x30]!
	streq r1, [r0, #0x68]
	strne r1, [r3, #0x30]!
	ldr r1, [r0, #0x6c]
	sub r1, r1, #1
	str r1, [r0, #0x6c]!
	mov r0, #0
	mov pc, lr
loc_27a8:
	mov r3, r2
	ldr r2, [r2, #0x30]
	teq r2, #0
	bne loc_277c
loc_27b8:
	mov r0, #0x8a
	sub r0, r0, #0xf000
	mov pc, lr
loc_27c4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	bl sub_02d0
	mov r8, #0
	str r8, [r5, #0x134]
	str r8, [r5, #0x130]
	str r8, [r5, #0x12c]
	str r8, [r5, #0x128]
	str r8, [r5, #0x124]
	str r8, [r5, #0x120]
	str r8, [r5, #0x11c]
	str r8, [r5, #0x118]
	str r8, [r5, #0x114]
	str r8, [r5, #0x110]
	str r8, [r5, #0x10c]
	str r8, [r5, #0x108]
	str r8, [r5, #0x104]
	str r8, [r5, #0x100]
	str r8, [r5, #0xfc]
	str r8, [r5, #0xf8]
	str r8, [r5, #0xf4]
	str r8, [r5, #0xec]
	str r8, [r5, #0xe4]
	str r8, [r5, #0xe0]
	str r8, [r5, #0x6c]
	mov r0, #0x324
	add r0, r0, #0x3800
	str r0, [r5, #0xf0]
	str r8, [r5, #0x7c]
	add r0, r5, #0x80
	mov r7, r0
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, r7
	mov r1, r8
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, r7
	mov r1, #0
	bl SetCollectorPort__14TUAsyncMessageFUl
	strb r8, [r5, #0xa8]
	add r0, r5, #0x98
	mov r4, r0
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, r4
	mov r1, r8
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, r4
	mov r1, #0
	bl SetCollectorPort__14TUAsyncMessageFUl
	add r0, r5, #0xac
	mov r4, r0
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, r4
	mov r1, r8
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, r4
	mov r1, #0
	bl SetCollectorPort__14TUAsyncMessageFUl
	str r8, [r5, #0xbc]
	add r0, r5, #0xc0
	mov r4, r0
	mov r1, #0
	bl Init__14TUAsyncMessageFUc
	mov r0, r4
	mov r1, r8
	bl SetUserRefCon__14TUSharedMemMsgFUl
	mov r0, r4
	mov r1, #0
	bl SetCollectorPort__14TUAsyncMessageFUl
	str r8, [r5, #0x5c]
	mov r0, #0x530
	add r0, r0, #0x7000
	str r0, [r5, #0xe8]
	str r8, [r5, #0x64]
	str r8, [r5, #0x68]
	strb r8, [r5, #0x70]
	mov r0, #0
	str r8, [r5, #0x54]
	bl __ct__5CListFv
	str r0, [r5, #0xdc]
	teq r0, #0
	subeq sp, sp, #0x18
	beq loc_2ea0
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r5, #0x78]
	teq r0, #0
	subeq sp, sp, #0x18
	beq loc_2e90
	mov r0, #0
	bl __ct__5CListFv
	str r0, [r5, #0x74]
	sub sp, sp, #0x18
	teq r0, #0
	beq loc_2e80
	strb r8, [r5, #0xd8]
	mov r0, #0x14
	str r8, [r5, #0xd4]
	bl __nw__FUi
	movs r4, r0
	beq loc_2978
	mov r0, r4
	bl sub_084c
	ldr r0, lit_2de4
	str r0, [r4]
loc_2978:
	mov r0, r4
	mov r3, #6
	ldr r2, lit_2de8
	ldr r4, lit_2dec
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_29b0
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2df0
	str r0, [r6]
loc_29b0:
	mov r0, r6
	mov r3, #0xa
	ldr r2, lit_2df4
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_29e4
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2df8
	str r0, [r6]
loc_29e4:
	mov r0, r6
	mov r3, #0
	ldr r2, lit_2dfc
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2a18
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e00
	str r0, [r6]
loc_2a18:
	mov r0, r6
	mov r3, #0
	ldr r2, lit_2e04
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2a4c
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e08
	str r0, [r6]
loc_2a4c:
	mov r0, r6
	mov r3, #1
	ldr r2, lit_2e0c
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2a80
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e10
	str r0, [r6]
loc_2a80:
	mov r0, r6
	mov r3, #1
	ldr r2, lit_2e14
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2ab4
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e18
	str r0, [r6]
loc_2ab4:
	mov r0, r6
	mov r3, #1
	ldr r2, lit_2e1c
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2ae8
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e20
	str r0, [r6]
loc_2ae8:
	mov r0, r6
	mov r3, #1
	ldr r2, lit_2e24
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2b1c
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e28
	str r0, [r6]
loc_2b1c:
	mov r0, r6
	mov r3, #3
	ldr r2, lit_2e2c
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2b50
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e30
	str r0, [r6]
loc_2b50:
	mov r0, r6
	mov r3, #2
	ldr r2, lit_2e34
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs r6, r0
	beq loc_2b84
	mov r0, r6
	bl sub_084c
	ldr r0, lit_2e38
	str r0, [r6]
loc_2b84:
	mov r0, r6
	mov r3, #0
	ldr r6, lit_2e3c
	mov r2, r6
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2bbc
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e40
	str r0, [sb]
loc_2bbc:
	mov r0, sb
	mov r3, #2
	ldr r2, lit_2e44
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2bf0
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e48
	str r0, [sb]
loc_2bf0:
	mov r0, sb
	mov r3, #0
	ldr r2, lit_2e4c
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2c24
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e50
	str r0, [sb]
loc_2c24:
	mov r0, sb
	mov r3, #1
	ldr r2, lit_2e54
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2c58
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e58
	str r0, [sb]
loc_2c58:
	mov r0, sb
	mov r3, #1
	ldr r2, lit_2e5c
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2c8c
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e60
	str r0, [sb]
loc_2c8c:
	mov r0, sb
	mov r3, #1
	ldr r2, lit_2e64
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2cc0
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e68
	str r0, [sb]
loc_2cc0:
	mov r0, sb
	mov r3, #0
	ldr r2, lit_2e6c
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2cf4
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e70
	str r0, [sb]
loc_2cf4:
	mov r0, sb
	mov r3, #0
	ldr r2, lit_2e74
	mov r1, r4
	bl sub_0688
	mov r0, #0x14
	bl __nw__FUi
	movs sb, r0
	beq loc_2d28
	mov r0, sb
	bl sub_084c
	ldr r0, lit_2e78
	str r0, [sb]
loc_2d28:
	mov r0, sb
	mov r3, #0
	ldr r2, lit_2e7c
	mov r1, r4
	bl sub_0688
	add sb, r5, #0x90
	mov sl, sb
	mov r0, sp
	bl GetGlobalTime
	add r0, sp, #8
	mov r2, #0x66
	add r2, r2, #0xe00
	mov r1, #0x64
	bl __ct__5TTimeFUl9TimeUnits
	sub sp, sp, #8
	add r0, sp, #0x10
	ldmia r0, {ip, lr}
	stmia sp, {ip, lr}
	mov r1, sp
	add r0, sp, #8
	bl CompAdd
	movs r0, sb
	bne loc_2d94
	mov r0, #8
	bl __nw__FUi
	teq r0, #0
	beq loc_2d9c
loc_2d94:
	ldmia sp, {r3, ip}
	stmia r0, {r3, ip}
loc_2d9c:
	add sp, sp, #8
	mov r3, #0
	mov r2, r6
	stmdb sp!, {r2, r3}
	add r0, sp, #0x18
	ldr r1, [r5, #0x18]!
	bl sub_064c
	add r0, sp, #0x18
	mov r2, sl
	mov r1, r7
	mov r3, r4
	bl sub_07a8
	add sp, sp, #8
	add r0, sp, #0x10
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r8
	b loc_2ea8
lit_2de4:
	.rword sub_01e0				; relocated
lit_2de8:
	.word 0x6e657743			; 'newC'
lit_2dec:
	.word 0x6c616e74			; 'lant'
lit_2df0:
	.rword sub_01c8				; relocated
lit_2df4:
	.word 0x64656c43			; 'delC'
lit_2df8:
	.rword sub_01f8				; relocated
lit_2dfc:
	.word 0x73757370			; 'susp'
lit_2e00:
	.rword sub_01d4				; relocated
lit_2e04:
	.word 0x7265736d			; 'resm'
lit_2e08:
	.rword sub_0234				; relocated
lit_2e0c:
	.word 0x63657668			; 'cevh'
lit_2e10:
	.rword sub_0154				; relocated
lit_2e14:
	.word 0x696e6974			; 'init'
lit_2e18:
	.rword sub_018c				; relocated
lit_2e1c:
	.word 0x62696e64			; 'bind'
lit_2e20:
	.rword sub_0198				; relocated
lit_2e24:
	.word 0x646e6962			; 'dnib'
lit_2e28:
	.rword sub_0160				; relocated
lit_2e2c:
	.word 0x72656342			; 'recB'
lit_2e30:
	.rword sub_01ec				; relocated
lit_2e34:
	.word 0x72656343			; 'recC'
lit_2e38:
	.rword sub_013c				; relocated
lit_2e3c:
	.word 0x7469636b			; 'tick'
lit_2e40:
	.rword sub_01bc				; relocated
lit_2e44:
	.word 0x706b7420			; 'pkt '
lit_2e48:
	.rword sub_0180				; relocated
lit_2e4c:
	.word 0x706f7772			; 'powr'
lit_2e50:
	.rword sub_01b0				; relocated
lit_2e54:
	.word 0x64696521			; 'die!'
lit_2e58:
	.rword sub_0210				; relocated
lit_2e5c:
	.word 0x73707674			; 'spvt'
lit_2e60:
	.rword sub_021c				; relocated
lit_2e64:
	.word 0x73706273			; 'spbs'
lit_2e68:
	.rword sub_0228				; relocated
lit_2e6c:
	.word 0x67706273			; 'gpbs'
lit_2e70:
	.rword sub_0148				; relocated
lit_2e74:
	.word 0x67647273			; 'gdrs'
lit_2e78:
	.rword sub_01a4				; relocated
lit_2e7c:
	.word 0x72647273			; 'rdrs'
loc_2e80:
	ldr r0, [r5, #0x78]
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
loc_2e90:
	ldr r0, [r5, #0xdc]!
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
loc_2ea0:
	mov r0, #0x1b8
	sub r0, r0, #0xf000
loc_2ea8:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}
loc_2eac:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #4
	ldr r0, [r0, #0x78]
	mov r1, r0
	ldr r0, [r0]
	teq r0, #0
	beq loc_2f7c
	sub sp, sp, #0x1c
	mov r0, sp
	bl __ct__13CListIteratorFP13CDynamicArray
	mov r0, sp
	bl FirstItem__13CListIteratorFv
	movs r5, r0
	beq loc_2f58
loc_2ef0:
	mov r1, r5
	ldr r0, [r4, #0x78]
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
	bne loc_2ef0
loc_2f58:
	ldr r0, [r4, #0x78]
	teq r0, #0
	movne r1, #1
	blne __dt__5CListFv
	mov r0, sp
	mov r1, #0
	bl __dt__14CArrayIteratorFv
	add sp, sp, #0x1c
	b loc_2f90
loc_2f7c:
	teq r1, #0
	beq loc_2f90
	mov r0, r1
	mov r1, #1
	bl __dt__5CListFv
loc_2f90:
	mov r3, #0
	stmdb sp!, {r3}
	add r0, r4, #0x80
	mov r5, r0
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #1
	moveq r0, r5
	bleq Abort__14TUAsyncMessageFv
	mov r3, #0
	stmdb sp!, {r3}
	add r0, r4, #0xac
	mov r5, r0
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #1
	moveq r0, r5
	bleq Abort__14TUAsyncMessageFv
	mov r3, #0
	stmdb sp!, {r3}
	add r0, r4, #0x98
	mov r5, r0
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #1
	moveq r0, r5
	bleq Abort__14TUAsyncMessageFv
	mov r3, #0
	stmdb sp!, {r3}
	add r0, r4, #0xc0
	mov r5, r0
	mov r2, #0
	mov r1, #0
	bl GetResult__14TUAsyncMessageFPUlN31
	add sp, sp, #4
	teq r0, #1
	moveq r0, r5
	bleq Abort__14TUAsyncMessageFv
	ldr r0, [r4, #0x54]
	teq r0, #0
	blne __dl__FPv
	mov r0, r4
	bl sub_033c
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_3058:
	mov r1, r3
	ldr r3, [r3, #8]
	add r2, r1, #0xc
	ldr r1, [r0, #0x18]
	ldr r0, [r0, #0x1c]
	b loc_1988
loc_3070:
	ldr r3, [r2, #8]!
	add r2, r2, #4
	ldr r1, [r0, #0x14]
	ldr r0, [r0, #0x18]
	b loc_1988

sub_3084:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_308c:
	.asciz "TLanternDriverAPI"
	.align 4

sub_30a0:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_3084
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_30cc:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_30e0
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_30e0:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_30e8:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_30f4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_3100:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18

sub_310c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c

sub_3118:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x20

sub_3124:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x24

sub_3130:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x28

sub_313c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x2c

sub_3148:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x30

sub_3154:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x34

sub_3160:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x38

sub_316c:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x3c

sub_3178:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x40

sub_3184:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_318c:
	.asciz "TLanternDriver"
	.align 4

sub_319c:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_3184
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_31c8:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_31dc
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_31dc:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_31e4:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_31f0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

sub_31fc:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x18
loc_3208:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x1c
loc_3214:
	mov r0, #0x48
	mov pc, lr
loc_321c:
	mov r0, #0x138
	mov pc, lr
loc_3224:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	add r0, r0, #0x18
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	mov r1, #0
	bl __dt__11TUTaskWorldFv
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_3264:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	add r0, r0, #0xc0
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r4, #0xac
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r4, #0x98
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r4, #0x80
	mov r1, #0
	bl __dt__14TUAsyncMessageFv
	add r0, r4, #0x18
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	mov r1, #0
	bl __dt__11TUTaskWorldFv
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}
loc_32d4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r1, #0
	bl __dt__14TAEventHandlerFv
	tst r5, #1
	movne r0, r4
	ldmdbne fp, {r4, r5, fp, sp, lr}
	bne __dl__FPv
	ldmdb fp, {r4, r5, fp, sp, pc}

CardSpecific__12TCardHandlerFUlPvT1:
	ldr pc, lit_3308
lit_3308:
	.word 0x01800eb0			; glue 01800eb0 -> CardSpecific__12TCardHandlerFUlPvT1

CompAdd:
	ldr pc, lit_3310
lit_3310:
	.word 0x01801750			; glue 01801750 -> CompAdd

CompCompare:
	ldr pc, lit_3318
lit_3318:
	.word 0x01801754			; glue 01801754 -> CompCompare

DisposPtr:
	ldr pc, lit_3320
lit_3320:
	.word 0x01801780			; glue 01801780 -> DisposPtr

ExitHandler:
	ldr pc, lit_3328
lit_3328:
	.word 0x01801784			; glue 01801784 -> ExitHandler

FirstItem__13CListIteratorFv:
	ldr pc, lit_3330
lit_3330:
	.word 0x01801ac4			; glue 01801ac4 -> FirstItem__13CListIteratorFv

FreeInstance__FP9TProtocol:
	ldr pc, lit_3338
lit_3338:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

GetGlobalTime:
	ldr pc, lit_3340
lit_3340:
	.word 0x018010a4			; glue 018010a4 -> GetGlobalTime

GetGlobals:
	ldr pc, lit_3348
lit_3348:
	.word 0x018010a0			; glue 018010a0 -> GetGlobals

GetPtrSize:
	ldr pc, lit_3350
lit_3350:
	.word 0x018017c4			; glue 018017c4 -> GetPtrSize

GetResult__14TUAsyncMessageFPUlN31:
	ldr pc, lit_3358
lit_3358:
	.word 0x018010f8			; glue 018010f8 -> GetResult__14TUAsyncMessageFPUlN31

GetUserRefCon__14TUSharedMemMsgFPUl:
	ldr pc, lit_3360
lit_3360:
	.word 0x01801120			; glue 01801120 -> GetUserRefCon__14TUSharedMemMsgFPUl

IdleProc__14TAEventHandlerFP10TUMsgTokenPUlP7TAEvent:
	ldr pc, lit_3368
lit_3368:
	.word 0x01801b48			; glue 01801b48 -> IdleProc__14TAEventHandlerFP10TUMsgTokenPUlP7TAEvent

Init__14TUAsyncMessageFUc:
	ldr pc, lit_3370
lit_3370:
	.word 0x01801160			; glue 01801160 -> Init__14TUAsyncMessageFUc

Init__6TUPortFv:
	ldr pc, lit_3378
lit_3378:
	.word 0x0180118c			; glue 0180118c -> Init__6TUPortFv

InsertAt__5CListFlPv:
	ldr pc, lit_3380
lit_3380:
	.word 0x01801bb8			; glue 01801bb8 -> InsertAt__5CListFlPv

Lookup__12TUNameServerFPcT1PUlT3:
	ldr pc, lit_3388
lit_3388:
	.word 0x01801228			; glue 01801228 -> Lookup__12TUNameServerFPcT1PUlT3

NewByName__FPCcT1:
	ldr pc, lit_3390
lit_3390:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

NewPtr:
	ldr pc, lit_3398
lit_3398:
	.word 0x0180180c			; glue 0180180c -> NewPtr

NextItem__13CListIteratorFv:
	ldr pc, lit_33a0
lit_33a0:
	.word 0x01801c6c			; glue 01801c6c -> NextItem__13CListIteratorFv

Putn__11CBufferListFPCUcl:
	ldr pc, lit_33a8
lit_33a8:
	.word 0x01801cc4			; glue 01801cc4 -> Putn__11CBufferListFPCUcl

Receive__6TUPortFPUlPvUlP10TUMsgTokenT1N23UcT8:
	ldr pc, lit_33b0
lit_33b0:
	.word 0x01801304			; glue 01801304 -> Receive__6TUPortFPUlPvUlP10TUMsgTokenT1N23UcT8

RegisterName__12TUNameServerFPcT1UlT3:
	ldr pc, lit_33b8
lit_33b8:
	.word 0x0180133c			; glue 0180133c -> RegisterName__12TUNameServerFPcT1UlT3

Remove__5CListFPv:
	ldr pc, lit_33c0
lit_33c0:
	.word 0x01801cf4			; glue 01801cf4 -> Remove__5CListFPv

ReplyRPC__10TUMsgTokenFPvUll:
	ldr pc, lit_33c8
lit_33c8:
	.word 0x018013b8			; glue 018013b8 -> ReplyRPC__10TUMsgTokenFPvUll

SendGoo__6TUPortFUlT1PvN31UcT1P5TTime:
	ldr pc, lit_33d0
lit_33d0:
	.word 0x01801414			; glue 01801414 -> SendGoo__6TUPortFUlT1PvN31UcT1P5TTime

SetCollectorPort__14TUAsyncMessageFUl:
	ldr pc, lit_33d8
lit_33d8:
	.word 0x0180145c			; glue 0180145c -> SetCollectorPort__14TUAsyncMessageFUl

SetUserRefCon__14TUSharedMemMsgFUl:
	ldr pc, lit_33e0
lit_33e0:
	.word 0x018014dc			; glue 018014dc -> SetUserRefCon__14TUSharedMemMsgFUl

StartTask__11TUTaskWorldFUcT1UlN33:
	ldr pc, lit_33e8
lit_33e8:
	.word 0x01801518			; glue 01801518 -> StartTask__11TUTaskWorldFUcT1UlN33

TimeFromNow:
	ldr pc, lit_33f0
lit_33f0:
	.word 0x0180155c			; glue 0180155c -> TimeFromNow

UnRegisterName__12TUNameServerFPcT1:
	ldr pc, lit_33f8
lit_33f8:
	.word 0x0180157c			; glue 0180157c -> UnRegisterName__12TUNameServerFPcT1

__ct__11TUTaskWorldFv:
	ldr pc, lit_3400
lit_3400:
	.word 0x01800d3c			; glue 01800d3c -> __ct__11TUTaskWorldFv

__ct__12TUNameServerFv:
	ldr pc, lit_3408
lit_3408:
	.word 0x01800d54			; glue 01800d54 -> __ct__12TUNameServerFv

__ct__13CListIteratorFP13CDynamicArray:
	ldr pc, lit_3410
lit_3410:
	.word 0x018018b0			; glue 018018b0 -> __ct__13CListIteratorFP13CDynamicArray

__ct__14TAEventHandlerFv:
	ldr pc, lit_3418
lit_3418:
	.word 0x018018d4			; glue 018018d4 -> __ct__14TAEventHandlerFv

__ct__14TUAsyncMessageFv:
	ldr pc, lit_3420
lit_3420:
	.word 0x01800d78			; glue 01800d78 -> __ct__14TUAsyncMessageFv

__ct__5CListFv:
	ldr pc, lit_3428
lit_3428:
	.word 0x018018f8			; glue 018018f8 -> __ct__5CListFv

__ct__5TTimeFUl9TimeUnits:
	ldr pc, lit_3430
lit_3430:
	.word 0x01800d94			; glue 01800d94 -> __ct__5TTimeFUl9TimeUnits

__ct__6TUPortFUl:
	ldr pc, lit_3438
lit_3438:
	.word 0x01800d98			; glue 01800d98 -> __ct__6TUPortFUl

__dl__FPv:
	ldr pc, lit_3440
lit_3440:
	.word 0x01800dac			; glue 01800dac -> __dl__FPv

__dt__11TUTaskWorldFv:
	ldr pc, lit_3448
lit_3448:
	.word 0x01800dc0			; glue 01800dc0 -> __dt__11TUTaskWorldFv

__dt__12TUNameServerFv:
	ldr pc, lit_3450
lit_3450:
	.word 0x01800dd0			; glue 01800dd0 -> __dt__12TUNameServerFv

__dt__14CArrayIteratorFv:
	ldr pc, lit_3458
lit_3458:
	.word 0x01801934			; glue 01801934 -> __dt__14CArrayIteratorFv

__dt__14TAEventHandlerFv:
	ldr pc, lit_3460
lit_3460:
	.word 0x0180193c			; glue 0180193c -> __dt__14TAEventHandlerFv

__dt__14TUAsyncMessageFv:
	ldr pc, lit_3468
lit_3468:
	.word 0x01800ddc			; glue 01800ddc -> __dt__14TUAsyncMessageFv

__dt__5CListFv:
	ldr pc, lit_3470
lit_3470:
	.word 0x01801950			; glue 01801950 -> __dt__5CListFv

__dt__8TUObjectFv:
	ldr pc, lit_3478
lit_3478:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_3480
lit_3480:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

__rt_udiv:
	ldr pc, lit_3488
lit_3488:
	.word 0x01800014			; glue 01800014 -> __rt_udiv

memcpy:
	ldr pc, lit_3490
lit_3490:
	.word 0x0180011c			; glue 0180011c -> memcpy

setjmp:
	ldr pc, lit_3498
lit_3498:
	.word 0x01800040			; glue 01800040 -> setjmp

strcpy:
	ldr pc, lit_34a0
lit_34a0:
	.word 0x01800178			; glue 01800178 -> strcpy

strlen:
	ldr pc, lit_34a8
lit_34a8:
	.word 0x0180017c			; glue 0180017c -> strlen

strncpy:
	ldr pc, lit_34b0
lit_34b0:
	.word 0x01800188			; glue 01800188 -> strncpy
