; "Newton Internet Enabler" part 6: protocol (580 bytes)
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
	.asciz "TInetService"
InterfaceName:
	.asciz "TCMService"
Signature:
	.asciz "serv"
	.asciz "inet"
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
	ldr pc, lit_008c
lit_008c:
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
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
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
	adr r2, str_0158, #30
	adr r1, str_0160, #30
	bl Lookup__12TUNameServerFPcT1PUlT3
	add sp, sp, #4
	teq r0, #0
	ldrne r0, lit_0168
	bne loc_0134
	adr r1, str_016c, #30
	adr r0, str_0180, #30
	bl NewByName__FPCcT1
	teq r0, #0
	ldreq r0, lit_018c
	beq loc_0134
	mov r3, #0x350
	add r3, r3, #0xc000
	mov r2, r4
	stmdb sp!, {r2, r3}
	mov r1, r5
	adr r3, str_0190, #30
	ldr r2, lit_01a0
	bl sub_0208
	add sp, sp, #8
loc_0134:
	mov r4, r0
	add r0, sp, #4
	mov r1, #0
	bl __dt__12TUNameServerFv
	add r0, sp, #0x14
	mov r1, #0
	bl __dt__8TUObjectFv
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
str_0158:
	.asciz "mux "
	.align 4
str_0160:
	.asciz "ictl"
	.align 4
lit_0168:
	.word 0xffffc177
str_016c:
	.asciz "PMuxServiceStarter"
	.align 4
str_0180:
	.asciz "PMuxService"
lit_018c:
	.word 0xffff9a6b
str_0190:
	.asciz "PInetToolMux"
	.align 4
lit_01a0:
	.word 0x696e6574			; 'inet'

Method5:
	ldr r0, [r1, #8]!
	mov pc, lr

sub_01ac:
	mov r0, pc				; pc-relative: the address 8 bytes on
	mov pc, lr
str_01b4:
	.asciz "PMuxService"

sub_01c0:
	stmdb sp!, {r0, r1, r2, r3, lr}
	mov r1, r0
	bl sub_01ac
	bl AllocInstanceByName__FPCcT1
	tst r0, r0
	add sp, sp, #4
	ldmia sp!, {r1, r2, r3, lr}
	moveq pc, lr
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #8

sub_01ec:
	ldr r0, [r0, #4]
	stmdb sp!, {r0, lr}
	adr lr, sub_0200
	ldr ip, [r0, #8]
	add pc, ip, #0xc

sub_0200:
	ldmia sp!, {r0, lr}
	b FreeInstance__FP9TProtocol

sub_0208:
	ldr r0, [r0, #4]
	ldr ip, [r0, #8]
	add pc, ip, #0x10

FreeInstance__FP9TProtocol:
	ldr pc, lit_0218
lit_0218:
	.word 0x01801028			; glue 01801028 -> FreeInstance__FP9TProtocol

Lookup__12TUNameServerFPcT1PUlT3:
	ldr pc, lit_0220
lit_0220:
	.word 0x01801228			; glue 01801228 -> Lookup__12TUNameServerFPcT1PUlT3

NewByName__FPCcT1:
	ldr pc, lit_0228
lit_0228:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

__ct__12TUNameServerFv:
	ldr pc, lit_0230
lit_0230:
	.word 0x01800d54			; glue 01800d54 -> __ct__12TUNameServerFv

__dt__12TUNameServerFv:
	ldr pc, lit_0238
lit_0238:
	.word 0x01800dd0			; glue 01800dd0 -> __dt__12TUNameServerFv

__dt__8TUObjectFv:
	ldr pc, lit_0240
lit_0240:
	.word 0x01800df0			; glue 01800df0 -> __dt__8TUObjectFv
