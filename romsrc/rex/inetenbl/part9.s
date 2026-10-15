; "Newton Internet Enabler" part 9: protocol (288 bytes)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	; .origin: the address its first byte falls at, worked out where it is built

ClassInfoTable:
	.word 0x00000000			; fReserved1
	.word ImplementationName - .		; fNameDelta
	.word InterfaceName - .			; fInterfaceDelta
	.word Signature - .			; fSignatureDelta
	.word BTable - .			; fBTableDelta
	.word EntryProc - .			; fEntryProcDelta
	b EntryProc				; fSizeofBranch
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
	.asciz "TDNSService"
InterfaceName:
	.asciz "TCMService"
Signature:
	.asciz "serv"
	.asciz "dnst"
	.asciz ""
	.align 4
BTable:
	.word 0x00000000			; dispatch slot 0
	b ClassInfo				; dispatch slot 1
	b DefaultNew				; dispatch slot 2
	b DefaultDelete				; dispatch slot 3
	b Method4				; dispatch slot 4
	b Method5				; dispatch slot 5

EntryProc:
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
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	adr r1, str_00e8, #30
	adr r0, str_00f4, #30
	bl NewByName__FPCcT1
	mov r2, r0
	mov r3, #0xb8
	add r3, r3, #0x8800
	stmdb sp!, {r2, r3}
	mov r3, r7
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl StartCommToolProtocol__FP12TOptionArrayUlP12TServiceInfoP10TCMServiceP17TCommToolProtocoll
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
str_00e8:
	.asciz "TDNSTool"
	.align 4
str_00f4:
	.asciz "TCommToolProtocol"
	.align 4

Method5:
	ldr r0, [r1, #8]!
	mov pc, lr

NewByName__FPCcT1:
	ldr pc, lit_0114
lit_0114:
	.word 0x01801258			; glue 01801258 -> NewByName__FPCcT1

StartCommToolProtocol__FP12TOptionArrayUlP12TServiceInfoP10TCMServiceP17TCommToolProtocoll:
	ldr pc, lit_011c
lit_011c:
	.word 0x018026bc			; glue 018026bc -> StartCommToolProtocol__FP12TOptionArrayUlP12TServiceInfoP10TCMServiceP17TCommToolProtocoll
