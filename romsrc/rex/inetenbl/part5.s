; "Newton Internet Enabler" part 5: protocol (648 bytes)
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
	.asciz "TInetCCEService"
InterfaceName:
	.asciz "TCMService"
Signature:
	.asciz "serv"
	.asciz "ictl"
	.asciz ""
	.align 4
BTable:
	.word 0x00000000			; dispatch slot 0
	b ClassInfo				; dispatch slot 1
	b DefaultNew				; dispatch slot 2
	b DefaultDelete				; dispatch slot 3
	b Method4				; dispatch slot 4
	b Method5				; dispatch slot 5

AllocInstanceByName__FPCcT1:
	ldr pc, lit_0090
lit_0090:
	.word 0x01800e70			; glue 01800e70 -> AllocInstanceByName__FPCcT1

Sizeof:
	mov r0, #0x10
	mov pc, lr

DefaultNew:
	mov pc, lr

DefaultDelete:
	mov pc, lr

Method4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r3
	sub sp, sp, #0x1c
	mov r0, #0
	strb r0, [sp, #0x18]
	str r0, [sp, #0x14]
	add r0, sp, #4
	bl __ct__12TUNameServerFv
	mov r3, sp
	stmdb sp!, {r3}
	add r3, sp, #0x18
	add r0, sp, #8
	adr r2, str_014c, #30
	adr r1, str_0154, #30
	bl Lookup__12TUNameServerFPcT1PUlT3
	add sp, sp, #4
	movs r7, r0
	beq loc_0194
	adr r1, str_015c, #30
	adr r0, str_0170, #30
	bl NewByName__FPCcT1
	movs r4, r0
	ldreq r7, lit_017c
	beq loc_01ac
	bl SystemRAMSize
	cmp r0, #0x200000
	movle r3, #0x11800
	movgt r3, #0x2bc00
	mov r2, r6
	stmdb sp!, {r2, r3}
	mov r1, r5
	mov r0, r4
	adr r3, str_0180, #30
	ldr r2, lit_0190
	bl sub_0234
	add sp, sp, #8
	mov r7, r0
	b loc_01ac
str_014c:
	.asciz "mux "
	.align 4
str_0154:
	.asciz "ictl"
	.align 4
str_015c:
	.asciz "PMuxServiceStarter"
	.align 4
str_0170:
	.asciz "PMuxService"
lit_017c:
	.word 0xffff9a6b
str_0180:
	.asciz "PInetToolMux"
	.align 4
lit_0190:
	.word 0x696e6574			; 'inet'
loc_0194:
	mov r0, r4
	ldr r1, [sp, #0x14]
	bl SetPortId__12TServiceInfoFUl
	mov r0, r4
	ldr r1, lit_01cc
	bl SetServiceId__12TServiceInfoFUl
loc_01ac:
	add r0, sp, #4
	mov r1, #0
	bl __dt__12TUNameServerFv
	add r0, sp, #0x14
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r7
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
lit_01cc:
	.word 0x6963746c			; 'ictl'

Method5:
	ldr r0, [r1, #8]!
	mov pc, lr

sub_01d8:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_01e0:
	.asciz "PMuxService"

sub_01ec:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_01d8
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_0218:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_022c
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_022c:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_0234:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

FreeInstance__FP9TProtocol:
	ldr pc, lit_0244
lit_0244:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

Lookup__12TUNameServerFPcT1PUlT3:
	ldr pc, lit_024c
lit_024c:
	.word 0x01801228			; glue 01801228 -> Lookup__12TUNameServerFPcT1PUlT3

NewByName__FPCcT1:
	ldr pc, lit_0254
lit_0254:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

SetPortId__12TServiceInfoFUl:
	ldr pc, lit_025c
lit_025c:
	.word 0x01800408			; glue 01800408 -> SetPortId__12TServiceInfoFUl

SetServiceId__12TServiceInfoFUl:
	ldr pc, lit_0264
lit_0264:
	.word 0x0180040c			; glue 0180040c -> SetServiceId__12TServiceInfoFUl

SystemRAMSize:
	ldr pc, lit_026c
lit_026c:
	.word 0x01801864			; glue 01801864 -> SystemRAMSize

__ct__12TUNameServerFv:
	ldr pc, lit_0274
lit_0274:
	.word 0x01800d54			; glue 01800d54 -> __ct__12TUNameServerFv

__dt__12TUNameServerFv:
	ldr pc, lit_027c
lit_027c:
	.word 0x01800dd0			; glue 01800dd0 -> __dt__12TUNameServerFv

__dt__8TUObjectFv:
	ldr pc, lit_0284
lit_0284:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv
