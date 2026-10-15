; "ScreenDrivers" part 0: protocol (4172 bytes)
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
	mov pc, lr				; fDefaultNewBranch
	b 0x1e00014				; fDefaultDeleteBranch
	.word 0x00020100			; fVersion
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
	.asciz "TMainDisplayDriver"
InterfaceName:
	.asciz "TScreenDriver"
Signature:
	.asciz "four"
	.asciz ""
	.align 4
BTable:
	.word 0x00000000			; dispatch slot 0
	b ClassInfo				; dispatch slot 1
	b 0x1e00014				; dispatch slot 2
	b 0x1e00018				; dispatch slot 3
	b 0x1e0001c				; dispatch slot 4
	b 0x1e00020				; dispatch slot 5
	b 0x1e00024				; dispatch slot 6
	b 0x1e00028				; dispatch slot 7
	b 0x1e0002c				; dispatch slot 8
	b 0x1e00030				; dispatch slot 9
	b 0x1e00034				; dispatch slot 10
	b 0x1e00038				; dispatch slot 11
	b 0x1e0003c				; dispatch slot 12
	b 0x1e00040				; dispatch slot 13
	b 0x1e00044				; dispatch slot 14

AllocInstanceByName__FPCcT1:
	ldr pc, lit_00b4
lit_00b4:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

Base__6TUPhysFRUl:
	ldr pc, lit_00bc
lit_00bc:
	.word 0x01802538			; glue 01802538 -> Base__6TUPhysFRUl

Sizeof:
	mov r0, #0x4c
	mov pc, lr

sub_00c8:
	mov pc, lr

sub_00cc:
	mov pc, lr

sub_00d0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r0, #0x21
	bl IOPowerOn__FUl
	mov r1, #0x800
	mov r0, #0x41000
	add r0, r0, #0xf100000
	str r1, [r0]
	ldr r1, lit_022c
	mov r0, #0x3140000
	add r0, r0, #0xc000000
	str r1, [r0]
	mov r5, #0
	ldr r0, lit_0230
	str r5, [r0]
	mov r0, #0x3b
	ldr r1, lit_0234
	str r0, [r1]
	mov r1, #0x8a
	add r1, r1, #0x100
	ldr r0, lit_0238
	str r1, [r0]
	mov r0, #1
	ldr r1, lit_023c
	str r0, [r1]
	mov r2, #0xd
	ldr r1, lit_0240
	str r2, [r1]
	ldr r1, lit_0244
	str r0, [r1]
	mov r1, #3
	ldr r0, lit_0248
	str r1, [r0]
	sub sp, sp, #4
	mov r1, sp
	ldr r0, [r4, #0x44]
	bl Base__6TUPhysFRUl
	ldr r0, [sp]
	ldr r1, lit_024c
	str r0, [r1]
	mov r1, #0x43000
	add r1, r1, #0xf100000
	ldr r0, [sp]
	str r0, [r1]
	mov r1, #2
	mov r0, #0x42000
	add r0, r0, #0xf100000
	str r1, [r0]
	mov r7, #0x20000000
	str r5, [r7]
	mov r1, #0xc
	ldr r0, lit_0250
	str r1, [r0]
	mov r0, #0x3e8
	add r0, r0, #0x35c00
	bl Sleep__FUl
	add r4, r4, #0x2c
	ldmib r4!, {r0, r1}
	add r0, r0, r1
	add r1, r0, #0x66
	mov r5, r1
	mov r0, #0x32
	bl __rt_sdiv
	mov r8, r0
	mov r6, #0
	cmp r5, #0
	ble sub_0204
	mov r4, #0xcc
	add r4, r4, #0x1c00

sub_01ec:
	str r6, [r7]
	mov r0, r4
	bl Sleep__FUl
	add r6, r6, r8
	cmp r6, r5
	blt sub_01ec

sub_0204:
	str r5, [r7]
	sub sp, sp, #4
	bl GetGPIOInterfaceObject__Fv
	mov r3, sp
	mov r2, #0
	mov r1, #0xc
	bl WriteGPIOData__14TGPIOInterfaceFUcT1PUc
	mov r0, #9
	bl IOPowerOff__FUl
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
lit_022c:
	.word 0x0004fddf
lit_0230:
	.word 0x0f140400
lit_0234:
	.word 0x0f140c00
lit_0238:
	.word 0x0f142400
lit_023c:
	.word 0x0f142800
lit_0240:
	.word 0x0f141800
lit_0244:
	.word 0x0f140800
lit_0248:
	.word 0x0f141c00
lit_024c:
	.word 0x0f142c00
lit_0250:
	.word 0x0f141400

sub_0254:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, #0
	ldr r1, [r0, #0x38]
	teq r1, #0
	beq loc_0298
	sub sp, sp, #4
	str r4, [r0, #0x38]!
	bl GetGPIOInterfaceObject__Fv
	mov r3, sp
	mov r2, #0
	mov r1, #0xc
	bl WriteGPIOData__14TGPIOInterfaceFUcT1PUc
	mov r0, #9
	bl IOPowerOff__FUl
	add sp, sp, #4
loc_0298:
	mov r0, #0x800
	mov r1, #0x41000
	add r1, r1, #0xf100000
	str r0, [r1]
	ldr r0, lit_02c8
	str r4, [r0]
	mov r0, #0x3e8
	add r0, r0, #0x35c00
	bl Sleep__FUl
	mov r0, #0x21
	ldmdb fp, {r4, fp, sp, lr}
	b IOPowerOff__FUl
lit_02c8:
	.word 0x0f141400

sub_02cc:
	mov pc, lr

sub_02d0:
	mov pc, lr

sub_02d4:
	cmp r1, #5
	addls pc, pc, r1, lsl #2
	b loc_0324
	b loc_02fc
	b loc_0304
	b loc_030c
	b loc_0314
	b loc_031c

sub_02f4:
	mov r0, #0xa
	mov pc, lr
loc_02fc:
	ldr r0, [r0, #0x30]
	mov pc, lr
loc_0304:
	mov r0, #1
	mov pc, lr
loc_030c:
	ldr r0, [r0, #0x38]
	mov pc, lr
loc_0314:
	mov r0, #0
	mov pc, lr
loc_031c:
	ldr r0, [r0, #0x2c]
	mov pc, lr
loc_0324:
	mvn r0, #0
	mov pc, lr

sub_032c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	teq r1, #0
	beq loc_0360
	teq r1, #1
	beq loc_039c
	teq r1, #2
	beq loc_03f0
	teq r1, #4
	streq r2, [r4, #0x2c]!
	ldmdb fp, {r4, fp, sp, pc}
loc_0360:
	str r2, [r4, #0x30]
	cmp r2, #0x10
	movgt r0, #0x10
	bgt loc_037c
	cmn r2, #0x10
	bge loc_0380
	mvn r0, #0xf
loc_037c:
	str r0, [r4, #0x30]
loc_0380:
	add r4, r4, #0x2c
	ldmib r4!, {r0, r1}
	add r0, r0, r1
	add r0, r0, #0x66
	mov r1, #0x20000000
	str r0, [r1]
	ldmdb fp, {r4, fp, sp, pc}
loc_039c:
	cmn r2, #0x140000
	movlt r2, #0x3ec0000
	addlt r2, r2, #0xfc000000
	blt sub_03b4
	cmp r2, #0x4b0000
	movgt r2, #0x4b0000

sub_03b4:
	mov r1, r2
	mov r0, #0xc1
	add r0, r0, #0x1600
	bl FixedMultiply
	rsb r0, r0, #0x99
	add r0, r0, #0x1900
	add r0, r0, #0x20000
	mov r1, #0x33
	add r1, r1, #0xb00
	bl FixedDivide
	mov r0, r0, asr #16
	mov r0, r0, lsl #16
	mov r0, r0, asr #16
	str r0, [r4, #0x34]!
	ldmdb fp, {r4, fp, sp, pc}
loc_03f0:
	teq r2, #1
	teqne r2, #0
	ldmdbne fp, {r4, fp, sp, pc}
	ldr r0, [r4, #0x38]
	teq r0, r2
	ldmdbeq fp, {r4, fp, sp, pc}
	sub sp, sp, #4
	str r2, [r4, #0x38]
	teq r2, #0
	mov r0, #9
	beq loc_0424
	bl IOPowerOn__FUl
	b loc_0428
loc_0424:
	bl IOPowerOff__FUl
loc_0428:
	bl GetGPIOInterfaceObject__Fv
	ldr r1, [r4, #0x38]!
	and r2, r1, #0xff
	mov r3, sp
	mov r1, #0xc
	bl WriteGPIOData__14TGPIOInterfaceFUcT1PUc
	ldmdb fp, {r4, fp, sp, pc}

sub_0444:
	mov r0, #0
	mov pc, lr

sub_044c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #0x1c
	mov r0, #0x1e0
	str r0, [r4, #0x3c]
	mov r0, #0x140
	str r0, [r4, #0x40]
	mov r0, #2
	mov r5, #0
	add r4, r4, #0x2c
	stmia r4, {r0, r5}
	str r5, [r4, #8]
	mov r1, sp
	str r5, [r4, #0xc]
	sub r4, r4, #0x2c
	mov r0, r4
	bl 0x1e0001c
	ldr r0, [r4, #0x3c]
	add r0, r0, #7
	bics r0, r0, #7
	addmi r0, r0, #7
	mov r0, r0, asr #3
	mov r6, r0, lsl #2
	adr r1, str_0668, #30
	adr r0, str_0678
	bl NewByName__FPCcT1
	mov r7, r0
	mov r0, #8
	bl __nw__FUi
	teq r0, #0
	strbne r5, [r0, #4]
	strne r5, [r0]
	str r0, [r4, #0x44]
	mov r1, r0
	mov r0, r7
	bl sub_0fa0
	mov r1, #0
	mov r0, #0
	bl __ct__17TLicenseeVAddressFUl
	str r0, [r4, #0x48]
	sub sp, sp, #4
	mov r1, sp
	ldr r0, [r4, #0x44]
	bl Base__6TUPhysFRUl
	sub sp, sp, #4
	mov r1, sp
	ldr r0, [r4, #0x44]
	bl Size__6TUPhysFRUl
	mov r3, #0
	stmdb sp!, {r3}
	ldr r0, [r4, #0x48]
	ldr r1, [sp, #8]
	ldr r2, [sp, #4]
	bl Init__6TUPhysFUlT1UcT3
	add sp, sp, #4
	mov r2, #3
	mov r1, #0
	ldr r0, [r4, #0x48]
	bl Map__17TLicenseeVAddressFUc4Perm
	ldr r0, [r4, #0x48]
	ldr r0, [r0, #0x10]
	str r0, [r4, #0x10]
	strb r6, [r4, #0x15]
	mov r1, r6, asr #8
	strb r1, [r4, #0x14]
	strb r5, [r4, #0x19]
	strb r5, [r4, #0x18]
	strb r5, [r4, #0x1b]
	strb r5, [r4, #0x1a]
	ldr r1, [r4, #0x40]
	mov r2, r1
	strb r1, [r4, #0x1d]
	mov r1, r1, asr #8
	strb r1, [r4, #0x1c]
	ldr r1, [r4, #0x3c]
	strb r1, [r4, #0x1f]
	mov r3, r1, asr #8
	strb r3, [r4, #0x1e]
	mov r3, #0x40000004
	str r3, [r4, #0x20]
	ldr r3, [sp, #0x18]
	strb r3, [r4, #0x27]
	mov r3, r3, asr #8
	strb r3, [r4, #0x26]
	ldr r3, [sp, #0x1a]
	strb r3, [r4, #0x25]
	mov r3, r3, asr #8
	strb r3, [r4, #0x24]
	mul r2, r1, r2
	movs r1, r2, lsl #2
	str r5, [r4, #0x28]!
	addmi r1, r1, #7
	mov r1, r1, asr #3
	ldr r2, lit_0694
	bl FillLongs
	sub sp, sp, #8
	mov r0, sp
	bl __ct__9TUGestaltFv
	mov r0, #0xc
	bl __nw__FUi
	movs r2, r0
	mov r4, #1
	beq loc_0618
	strb r4, [r2]
	mvn r0, #0xf
	str r0, [r2, #4]
	mov r0, #0x10
	str r0, [r2, #8]
	mov r0, sp
	mov r3, #0xc
	mov r1, #0x2000000
	add r1, r1, #3
	bl RegisterGestalt__9TUGestaltFUlPvT1
loc_0618:
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, sp
	bl __ct__9TUGestaltFv
	mov r0, #4
	bl __nw__FUi
	teq r0, #0
	beq loc_0658
	strb r4, [r0]
	mov r2, r0
	mov r0, sp
	mov r3, #4
	mov r1, #0x2000000
	add r1, r1, #7
	bl RegisterGestalt__9TUGestaltFUlPvT1
loc_0658:
	mov r0, sp
	mov r1, #0
	bl __dt__8TUObjectFv
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
str_0668:
	.asciz "TScreenMemory"
	.align 4
str_0678:
	.asciz "TReservedContiguousMemory"
	.align 4
lit_0694:
	.word 0xa5a5a5a5

sub_0698:
	mov r2, #0x140
	ldr r3, [r0, #0x2c]!
	mov r0, #0x1e0
	teq r3, #1
	teqne r3, #3
	streq r0, [r1, #4]
	streq r2, [r1]
	stmiane r1, {r0, r2}
	mov r0, #4
	str r0, [r1, #8]
	mov r0, #0x37
	str r0, [r1, #0xc]
	mov r0, #0x20
	str r0, [r1, #0x14]
	mov r2, #0x64
	str r0, [r1, #0x18]
	strb r2, [r1, #0x13]
	mov r0, #0
	strb r0, [r1, #0x12]
	strb r2, [r1, #0x11]
	strb r0, [r1, #0x10]
	mov pc, lr

sub_06f0:
	mov pc, lr

sub_06f4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r7, r2
	mov r6, r3
	ldr sl, [fp, #4]
	sub sp, sp, #0x20
	ldr r1, [r0, #0x30]
	ldr r0, [r0, #0x34]
	add r0, r1, r0
	add r0, r0, #0x66
	mov r1, #0x20000000
	str r0, [r1]
	ldr r0, [r4, #0x2c]
	teq r0, #1
	teqne r0, #3
	bne loc_083c
	sub sp, sp, #0xc
	ldr r1, [r7, #2]
	ldr r0, [r5, #0xa]
	mov r0, r0, asr #16
	rsb r1, r0, r1, asr #16
	bic r1, r1, #7
	ldr r2, [r7, #6]
	rsb r0, r0, r2, asr #16
	add r0, r0, #7
	bic r2, r0, #7
	ldr r0, [r6]
	mov r0, r0, asr #16
	ldr r3, [r6, #4]
	rsb r3, r0, r3, asr #16
	sub r2, r2, r1
	mov r2, r2, lsl #2
	mov r8, r2, asr #3
	mov r1, r1, lsl #2
	mov r2, r1, asr #3
	str r3, [sp, #8]
	ldr r1, [r6, #2]
	mov r1, r1, asr #16
	bic r1, r1, #7
	mov r1, r1, lsl #2
	mov r1, r1, asr #3
	ldr r3, [r5, #8]
	ldr ip, [r7]
	mov ip, ip, asr #16
	sub ip, ip, r3, asr #16
	ldr r3, [r5, #4]
	mov r3, r3, asr #16
	mla r2, r3, ip, r2
	str r2, [sp, #4]
	ldr r2, [r4, #0x14]
	mov r2, r2, asr #16
	mla sb, r0, r2, r1
	mov r0, r5
	bl GetPixelMapBits__FP8PixelMap
	ldr r1, [sp, #4]
	add r1, r0, r1
	add r0, r4, #0x10
	str r1, [sp]
	bl GetPixelMapBits__FP8PixelMap
	ldr r1, [r4, #0x2c]
	teq r1, #1
	rsbne r1, sb, #0x3fc
	addne r1, r1, #0x12800
	addne r0, r1, r0
	addeq r0, r0, sb
	ldr r1, [r5, #4]
	rsb r1, r8, r1, asr #16
	ldr r2, [r4, #0x14]
	rsb r2, r8, r2, asr #16
	str r1, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r1, [sp]
	str r0, [sp, #0x1c]
	str sl, [sp, #0x20]
	str r1, [sp, #0x18]
	ldr r3, [sp, #8]
	str r3, [sp, #0x24]
	str r8, [sp, #0x28]
	add sp, sp, #0xc
loc_083c:
	ldr r0, [r4, #0x2c]
	teq r0, #0
	beq loc_086c
	teq r0, #1
	beq loc_08b0
	teq r0, #2
	beq loc_088c
	teq r0, #3
	moveq r1, sp
	moveq r0, r4
	bleq sub_0938
	b loc_08bc
loc_086c:
	mov r3, sl
	stmdb sp!, {r3}
	mov r3, r6
	mov r2, r7
	mov r1, r5
	mov r0, r4
	bl sub_0a5c
	b loc_08a8
loc_088c:
	mov r3, sl
	stmdb sp!, {r3}
	mov r3, r6
	mov r2, r7
	mov r1, r5
	mov r0, r4
	bl sub_0cbc
loc_08a8:
	add sp, sp, #4
	b loc_08bc
loc_08b0:
	mov r1, sp
	mov r0, r4
	bl sub_08c0
loc_08bc:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_08c0:
	stmdb sp!, {r4, r5, lr}
	add lr, r1, #0x10
	ldmia lr, {r0, lr}
	ldr r2, [r1, #0xc]
	ldr ip, [r1, #0x18]
loc_08d4:
	ldr r3, [r1, #0x1c]
	mov r3, r3, asr #2
	teq lr, #0
	bne loc_08fc
loc_08e4:
	ldr r4, [r2], #4
	sub r3, r3, #1
	cmp r3, #0
	str r4, [r0], #4
	bgt loc_08e4
	b loc_0918
loc_08fc:
	ldr r4, [r2], #4
	ldr r5, [r0]
	orr r4, r4, r5
	sub r3, r3, #1
	cmp r3, #0
	str r4, [r0], #4
	bgt loc_08fc
loc_0918:
	ldr r3, [r1]
	add r2, r2, r3
	ldr r3, [r1, #4]
	add r0, r3, r0
	sub ip, ip, #1
	cmp ip, #0
	bgt loc_08d4
	ldmia sp!, {r4, r5, pc}

sub_0938:
	stmdb sp!, {r4, r5, r6, lr}
	add ip, r1, #0x10
	ldmia ip, {r0, r5, ip}
	ldr r2, [r1, #0xc]
loc_0948:
	ldr r3, [r1, #0x1c]
	mov r3, r3, asr #2
	teq r5, #0
	bne loc_09c8
loc_0958:
	ldr r4, [r2], #4
	mov lr, r4, lsl #28
	mov r4, r4, lsr #4
	and r6, r4, #0xf
	orr lr, lr, r6, lsl #24
	mov r4, r4, lsr #4
	and r6, r4, #0xf
	orr lr, lr, r6, lsl #20
	mov r4, r4, lsr #4
	and r6, r4, #0xf
	orr lr, lr, r6, lsl #16
	mov r4, r4, lsr #4
	and r6, r4, #0xf
	orr lr, lr, r6, lsl #12
	mov r4, r4, lsr #4
	and r6, r4, #0xf
	orr lr, lr, r6, lsl #8
	mov r4, r4, lsr #4
	and r6, r4, #0xf
	orr lr, lr, r6, lsl #4
	mov r4, r4, lsr #4
	and r4, r4, #0xf
	orr lr, r4, lr
	sub r3, r3, #1
	cmp r3, #0
	str lr, [r0], #-4
	bgt loc_0958
	b loc_0a3c
loc_09c8:
	ldr lr, [r2], #4
	mov r4, lr, lsl #28
	mov lr, lr, lsr #4
	and r6, lr, #0xf
	orr r4, r4, r6, lsl #24
	mov lr, lr, lsr #4
	and r6, lr, #0xf
	orr r4, r4, r6, lsl #20
	mov lr, lr, lsr #4
	and r6, lr, #0xf
	orr r4, r4, r6, lsl #16
	mov lr, lr, lsr #4
	and r6, lr, #0xf
	orr r4, r4, r6, lsl #12
	mov lr, lr, lsr #4
	and r6, lr, #0xf
	orr r4, r4, r6, lsl #8
	mov lr, lr, lsr #4
	and r6, lr, #0xf
	orr r4, r4, r6, lsl #4
	mov lr, lr, lsr #4
	and lr, lr, #0xf
	orr lr, lr, r4
	ldr r4, [r0]
	orr lr, r4, lr
	sub r3, r3, #1
	cmp r3, #0
	str lr, [r0], #-4
	bgt loc_09c8
loc_0a3c:
	ldr r3, [r1]
	add r2, r2, r3
	ldr r3, [r1, #4]
	sub r0, r0, r3
	sub ip, ip, #1
	cmp ip, #0
	bgt loc_0948
	ldmia sp!, {r4, r5, r6, pc}

sub_0a5c:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov sb, r0
	mov r4, r1
	sub sp, sp, #0x24
	ldr r0, [r0, #0x3c]
	movs r0, r0, lsl #2
	addmi r0, r0, #7
	movs r0, r0, asr #3
	str r0, [sp, #4]
	addmi r0, r0, #3
	mov r0, r0, asr #2
	str r0, [sp]
	ldr r1, [r2, #2]
	ldr r0, [r4, #0xa]
	mov r0, r0, asr #16
	rsb r1, r0, r1, asr #16
	bic r6, r1, #7
	ldr r1, [r2, #6]
	rsb r0, r0, r1, asr #16
	add r0, r0, #7
	bic r7, r0, #7
	ldr r0, [r4, #8]
	mov r0, r0, asr #16
	ldr r1, [r2]
	rsb r1, r0, r1, asr #16
	bic r5, r1, #7
	ldr r1, [r2, #4]
	rsb r0, r0, r1, asr #16
	add r0, r0, #7
	bic r8, r0, #7
	ldr r0, [r3, #2]
	mov r0, r0, asr #16
	bic sl, r0, #7
	ldr r0, [r3]
	mov r0, r0, asr #16
	bic r2, r0, #7
	str r2, [sp, #0x20]
	sub sp, sp, #4
	ldr r0, [r4, #4]
	mov r0, r0, asr #16
	mul r1, r5, r0
	movs r0, r6
	addmi r0, r0, #7
	mov r0, r0, asr #3
	add r1, r1, r0, lsl #2
	mov r0, r4
	str r1, [sp]
	bl GetPixelMapBits__FP8PixelMap
	ldr r1, [sp]
	add r0, r0, r1
	str r0, [sp, #0x10]
	ldr r0, [r4, #4]
	mov r0, r0, asr #16
	mov r4, r0, asr #2
	ldr r0, [sp, #8]
	mul r1, r0, sl
	ldr r0, [sb, #0x3c]
	ldr r2, [sp, #0x24]
	sub r0, r0, r2
	subs r0, r0, #1
	addmi r0, r0, #7
	mov r0, r0, asr #3
	add sl, r1, r0, lsl #2
	add r0, sb, #0x10
	bl GetPixelMapBits__FP8PixelMap
	add r0, r0, sl
	sub r1, r8, r5
	subs r2, r7, r6
	mov r1, r1, asr #3
	str r0, [sp, #0xc]
	addmi r2, r2, #7
	mov r2, r2, asr #3
	str r2, [sp, #0x20]
	rsb r2, r2, r4, lsl #3
	str r1, [sp, #0x18]
	str r2, [sp, #0x1c]
	teq r1, #0
	beq loc_0cb8
loc_0ba0:
	ldr r1, [sp, #0x20]
	str r1, [sp, #0x14]
	teq r1, #0
	beq loc_0c8c
loc_0bb0:
	ldr r1, [sp, #0x10]
	add r2, r1, #4
	str r2, [sp, #0x10]
	ldr r7, [r1]
	add r1, r1, r4, lsl #2
	ldr r6, [r1]
	add r1, r1, r4, lsl #2
	ldr r5, [r1]
	add r1, r1, r4, lsl #2
	ldr lr, [r1]
	add r1, r1, r4, lsl #2
	ldr ip, [r1]
	add r1, r1, r4, lsl #2
	ldr r3, [r1]
	add r1, r1, r4, lsl #2
	ldr r2, [r1]
	add r1, r1, r4, lsl #2
	ldr r1, [r1]
	mov r8, #8
loc_0bfc:
	mov sb, r7, lsr #28
	mov r7, r7, lsl #4
	and sl, r6, #0xf0000000
	orr sb, sb, sl, lsr #24
	mov r6, r6, lsl #4
	and sl, r5, #0xf0000000
	orr sb, sb, sl, lsr #20
	mov r5, r5, lsl #4
	and sl, lr, #0xf0000000
	orr sb, sb, sl, lsr #16
	mov lr, lr, lsl #4
	and sl, ip, #0xf0000000
	orr sb, sb, sl, lsr #12
	mov ip, ip, lsl #4
	and sl, r3, #0xf0000000
	orr sb, sb, sl, lsr #8
	mov r3, r3, lsl #4
	and sl, r2, #0xf0000000
	orr sb, sb, sl, lsr #4
	mov r2, r2, lsl #4
	and sl, r1, #0xf0000000
	orr sb, sl, sb
	mov r1, r1, lsl #4
	ldr sl, [fp, #0x14]
	teq sl, #0
	ldrne sl, [r0]
	orrne sb, sl, sb
	str sb, [r0]
	ldr sb, [sp, #4]
	add r0, r0, sb, lsl #2
	subs r8, r8, #1
	bne loc_0bfc
	ldr r1, [sp, #0x14]
	subs r1, r1, #1
	str r1, [sp, #0x14]
	bne loc_0bb0
loc_0c8c:
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #0x1c]
	add r0, r0, r2, lsl #2
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	sub r0, r0, #4
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x18]
	subs r1, r1, #1
	str r1, [sp, #0x18]
	bne loc_0ba0
loc_0cb8:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_0cbc:
	mov ip, sp
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, ip, lr, pc}
	sub fp, ip, #0x14
	mov sb, r0
	mov r4, r1
	sub sp, sp, #0x24
	ldr r0, [r0, #0x3c]
	movs r1, r0, lsl #2
	addmi r1, r1, #7
	movs r1, r1, asr #3
	str r1, [sp, #4]
	addmi r1, r1, #3
	mov r1, r1, asr #2
	str r1, [sp]
	ldr r1, [r2, #2]
	ldr r0, [r4, #0xa]
	mov r0, r0, asr #16
	rsb r1, r0, r1, asr #16
	bic r6, r1, #7
	ldr r1, [r2, #6]
	rsb r0, r0, r1, asr #16
	add r0, r0, #7
	bic r7, r0, #7
	ldr r0, [r4, #8]
	mov r0, r0, asr #16
	ldr r1, [r2]
	rsb r1, r0, r1, asr #16
	bic r5, r1, #7
	ldr r1, [r2, #4]
	rsb r0, r0, r1, asr #16
	add r0, r0, #7
	bic r8, r0, #7
	ldr r0, [r3, #2]
	mov r0, r0, asr #16
	bic sl, r0, #7
	ldr r0, [r3]
	mov r0, r0, asr #16
	bic r1, r0, #7
	str r1, [sp, #0x20]
	sub sp, sp, #4
	ldr r0, [r4, #4]
	mov r0, r0, asr #16
	mul r1, r5, r0
	movs r0, r6
	addmi r0, r0, #7
	mov r0, r0, asr #3
	add r1, r1, r0, lsl #2
	mov r0, r4
	str r1, [sp]
	bl GetPixelMapBits__FP8PixelMap
	ldr r1, [sp]
	add r0, r0, r1
	str r0, [sp, #0x10]
	ldr r0, [r4, #4]
	mov r0, r0, asr #16
	mov r4, r0, asr #2
	ldr r0, [sb, #0x3c]
	ldr r1, [sp, #0x24]
	sub r0, r0, r1
	subs r1, r0, #1
	addmi r1, r1, #7
	mov r1, r1, asr #3
	mov r0, #0x3fc
	add r0, r0, #0x12800
	sub r0, r0, r1, lsl #2
	ldr r1, [sp, #8]
	mul r2, r1, sl
	sub sl, r0, r2
	add r0, sb, #0x10
	bl GetPixelMapBits__FP8PixelMap
	add r0, r0, sl
	sub r1, r8, r5
	subs r2, r7, r6
	mov r1, r1, asr #3
	str r0, [sp, #0xc]
	addmi r2, r2, #7
	mov r2, r2, asr #3
	str r2, [sp, #0x20]
	rsb r2, r2, r4, lsl #3
	str r1, [sp, #0x18]
	str r2, [sp, #0x1c]
	teq r1, #0
	beq loc_0f24
loc_0e0c:
	ldr r1, [sp, #0x20]
	str r1, [sp, #0x14]
	teq r1, #0
	beq loc_0ef8
loc_0e1c:
	ldr r1, [sp, #0x10]
	add r2, r1, #4
	str r2, [sp, #0x10]
	ldr r6, [r1]
	add r1, r1, r4, lsl #2
	ldr r7, [r1]
	add r1, r1, r4, lsl #2
	ldr r5, [r1]
	add r1, r1, r4, lsl #2
	ldr lr, [r1]
	add r1, r1, r4, lsl #2
	ldr ip, [r1]
	add r1, r1, r4, lsl #2
	ldr r3, [r1]
	add r1, r1, r4, lsl #2
	ldr r2, [r1]
	add r1, r1, r4, lsl #2
	ldr r1, [r1]
	mov r8, #8
loc_0e68:
	and sb, r6, #0xf0000000
	mov r6, r6, lsl #4
	and sl, r7, #0xf0000000
	orr sb, sb, sl, lsr #4
	mov r7, r7, lsl #4
	and sl, r5, #0xf0000000
	orr sb, sb, sl, lsr #8
	mov r5, r5, lsl #4
	and sl, lr, #0xf0000000
	orr sb, sb, sl, lsr #12
	mov lr, lr, lsl #4
	and sl, ip, #0xf0000000
	orr sb, sb, sl, lsr #16
	mov ip, ip, lsl #4
	and sl, r3, #0xf0000000
	orr sb, sb, sl, lsr #20
	mov r3, r3, lsl #4
	and sl, r2, #0xf0000000
	orr sb, sb, sl, lsr #24
	mov r2, r2, lsl #4
	and sl, r1, #0xf0000000
	orr sb, sb, sl, lsr #28
	mov r1, r1, lsl #4
	ldr sl, [fp, #0x14]
	teq sl, #0
	ldrne sl, [r0]
	orrne sb, sl, sb
	str sb, [r0]
	ldr sb, [sp, #4]
	sub r0, r0, sb, lsl #2
	subs r8, r8, #1
	bne loc_0e68
	ldr r1, [sp, #0x14]
	subs r1, r1, #1
	str r1, [sp, #0x14]
	bne loc_0e1c
loc_0ef8:
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #0x1c]
	add r0, r0, r2, lsl #2
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	add r0, r0, #4
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x18]
	subs r1, r1, #1
	str r1, [sp, #0x18]
	bne loc_0e0c
loc_0f24:
	ldmdb fp, {r4, r5, r6, r7, r8, sb, sl, fp, sp, pc}

sub_0f28:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_0f30:
	.asciz "TReservedContiguousMemory"
	.align 4

sub_0f4c:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_0f28
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_0f78:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_0f8c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_0f8c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_0f94:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

sub_0fa0:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x14

FillLongs:
	ldr pc, lit_0fb0
lit_0fb0:
	.word 0x0180163c			; glue 0180163c -> FillLongs

FixedDivide:
	ldr pc, lit_0fb8
lit_0fb8:
	.word 0x0180178c			; glue 0180178c -> FixedDivide

FixedMultiply:
	ldr pc, lit_0fc0
lit_0fc0:
	.word 0x01801790			; glue 01801790 -> FixedMultiply

FreeInstance__FP9TProtocol:
	ldr pc, lit_0fc8
lit_0fc8:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

GetGPIOInterfaceObject__Fv:
	ldr pc, lit_0fd0
lit_0fd0:
	.word 0x01802cd8			; glue 01802cd8 -> GetGPIOInterfaceObject__Fv

GetPixelMapBits__FP8PixelMap:
	ldr pc, lit_0fd8
lit_0fd8:
	.word 0x01802cd4			; glue 01802cd4 -> GetPixelMapBits__FP8PixelMap

IOPowerOff__FUl:
	ldr pc, lit_0fe0
lit_0fe0:
	.word 0x01802cb8			; glue 01802cb8 -> IOPowerOff__FUl

IOPowerOn__FUl:
	ldr pc, lit_0fe8
lit_0fe8:
	.word 0x01802cbc			; glue 01802cbc -> IOPowerOn__FUl

Init__6TUPhysFUlT1UcT3:
	ldr pc, lit_0ff0
lit_0ff0:
	.word 0x01801188			; glue 01801188 -> Init__6TUPhysFUlT1UcT3

Map__17TLicenseeVAddressFUc4Perm:
	ldr pc, lit_0ff8
lit_0ff8:
	.word 0x01802aa8			; glue 01802aa8 -> Map__17TLicenseeVAddressFUc4Perm

NewByName__FPCcT1:
	ldr pc, lit_1000
lit_1000:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

RegisterGestalt__9TUGestaltFUlPvT1:
	ldr pc, lit_1008
lit_1008:
	.word 0x01802548			; glue 01802548 -> RegisterGestalt__9TUGestaltFUlPvT1

Size__6TUPhysFRUl:
	ldr pc, lit_1010
lit_1010:
	.word 0x018014ec			; glue 018014ec -> Size__6TUPhysFRUl

Sleep__FUl:
	ldr pc, lit_1018
lit_1018:
	.word 0x018014f8			; glue 018014f8 -> Sleep__FUl

WriteGPIOData__14TGPIOInterfaceFUcT1PUc:
	ldr pc, lit_1020
lit_1020:
	.word 0x01802cdc			; glue 01802cdc -> WriteGPIOData__14TGPIOInterfaceFUcT1PUc

__ct__17TLicenseeVAddressFUl:
	ldr pc, lit_1028
lit_1028:
	.word 0x01802554			; glue 01802554 -> __ct__17TLicenseeVAddressFUl

__ct__9TUGestaltFv:
	ldr pc, lit_1030
lit_1030:
	.word 0x01800da4			; glue 01800da4 -> __ct__9TUGestaltFv

__dt__8TUObjectFv:
	ldr pc, lit_1038
lit_1038:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv

__nw__FUi:
	ldr pc, lit_1040
lit_1040:
	.word 0x01800e04			; glue 01800e04 -> __nw__FUi

__rt_sdiv:
	ldr pc, lit_1048
lit_1048:
	.word 0x0180000c			; glue 0180000c -> __rt_sdiv
