; a code binary (obj_1002f89)
; ARMv4 assembly: python tools/armpart/newtonarm.py pack THIS_FILE OUT.bin

	.origin 0x2f94		; the part's offset in its package as linked (.rword values add it)


sub_0000:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bgt glue_01801ee8
	ldrlt r0, lit_0d20
	ldrlt r0, [r0]
	movlt pc, lr
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq r0, lit_0d20
	ldrgt r0, lit_0d24
	ldr r0, [r0]
	mov pc, lr

glue_01801ee8:
	ldr pc, lit_0044
lit_0044:
	.word 0x01801ee8			; glue 01801ee8

sub_0048:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bgt glue_01801eec
	ldrlt r0, lit_0d28
	ldrlt r0, [r0]
	movlt pc, lr
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq r0, lit_0d28
	ldrgt r0, lit_0d2c
	ldr r0, [r0]
	mov pc, lr

glue_01801eec:
	ldr pc, lit_008c
lit_008c:
	.word 0x01801eec			; glue 01801eec

glue_018009bc:
	ldr pc, lit_0094
lit_0094:
	.word 0x018009bc			; glue 018009bc

glue_01801a50:
	ldr pc, lit_009c
lit_009c:
	.word 0x01801a50			; glue 01801a50

glue_01801a4c:
	ldr pc, lit_00a4
lit_00a4:
	.word 0x01801a4c			; glue 01801a4c

glue_0180011c:
	ldr pc, lit_00ac
lit_00ac:
	.word 0x0180011c			; glue 0180011c

glue_01800980:
	ldr pc, lit_00b4
lit_00b4:
	.word 0x01800980			; glue 01800980

glue_01800b3c:
	ldr pc, lit_00bc
lit_00bc:
	.word 0x01800b3c			; glue 01800b3c

glue_01800808:
	ldr pc, lit_00c4
lit_00c4:
	.word 0x01800808			; glue 01800808

glue_0180017c:
	ldr pc, lit_00cc
lit_00cc:
	.word 0x0180017c			; glue 0180017c

glue_018007f4:
	ldr pc, lit_00d4
lit_00d4:
	.word 0x018007f4			; glue 018007f4

glue_01801748:
	ldr pc, lit_00dc
lit_00dc:
	.word 0x01801748			; glue 01801748

glue_01800804:
	ldr pc, lit_00e4
lit_00e4:
	.word 0x01800804			; glue 01800804

glue_0180080c:
	ldr pc, lit_00ec
lit_00ec:
	.word 0x0180080c			; glue 0180080c

glue_01800810:
	ldr pc, lit_00f4
lit_00f4:
	.word 0x01800810			; glue 01800810

glue_01800818:
	ldr pc, lit_00fc
lit_00fc:
	.word 0x01800818			; glue 01800818

glue_0180081c:
	ldr pc, lit_0104
lit_0104:
	.word 0x0180081c			; glue 0180081c

glue_01800820:
	ldr pc, lit_010c
lit_010c:
	.word 0x01800820			; glue 01800820

glue_01800828:
	ldr pc, lit_0114
lit_0114:
	.word 0x01800828			; glue 01800828

glue_0180082c:
	ldr pc, lit_011c
lit_011c:
	.word 0x0180082c			; glue 0180082c

glue_01800834:
	ldr pc, lit_0124
lit_0124:
	.word 0x01800834			; glue 01800834

glue_01800838:
	ldr pc, lit_012c
lit_012c:
	.word 0x01800838			; glue 01800838

glue_0180083c:
	ldr pc, lit_0134
lit_0134:
	.word 0x0180083c			; glue 0180083c

glue_01801a2c:
	ldr pc, lit_013c
lit_013c:
	.word 0x01801a2c			; glue 01801a2c

glue_01800024:
	ldr pc, lit_0144
lit_0144:
	.word 0x01800024			; glue 01800024

glue_01800874:
	ldr pc, lit_014c
lit_014c:
	.word 0x01800874			; glue 01800874

glue_01800888:
	ldr pc, lit_0154
lit_0154:
	.word 0x01800888			; glue 01800888

glue_018020e4:
	ldr pc, lit_015c
lit_015c:
	.word 0x018020e4			; glue 018020e4

glue_018008b8:
	ldr pc, lit_0164
lit_0164:
	.word 0x018008b8			; glue 018008b8

glue_018008fc:
	ldr pc, lit_016c
lit_016c:
	.word 0x018008fc			; glue 018008fc

glue_01801784:
	ldr pc, lit_0174
lit_0174:
	.word 0x01801784			; glue 01801784

glue_01800910:
	ldr pc, lit_017c
lit_017c:
	.word 0x01800910			; glue 01800910

glue_01800914:
	ldr pc, lit_0184
lit_0184:
	.word 0x01800914			; glue 01800914

glue_01801024:
	ldr pc, lit_018c
lit_018c:
	.word 0x01801024			; glue 01801024

glue_01800920:
	ldr pc, lit_0194
lit_0194:
	.word 0x01800920			; glue 01800920

glue_01800928:
	ldr pc, lit_019c
lit_019c:
	.word 0x01800928			; glue 01800928

glue_0180092c:
	ldr pc, lit_01a4
lit_01a4:
	.word 0x0180092c			; glue 0180092c

glue_018010a0:
	ldr pc, lit_01ac
lit_01ac:
	.word 0x018010a0			; glue 018010a0

glue_01800934:
	ldr pc, lit_01b4
lit_01b4:
	.word 0x01800934			; glue 01800934

glue_01800940:
	ldr pc, lit_01bc
lit_01bc:
	.word 0x01800940			; glue 01800940

glue_0180094c:
	ldr pc, lit_01c4
lit_01c4:
	.word 0x0180094c			; glue 0180094c

glue_0180095c:
	ldr pc, lit_01cc
lit_01cc:
	.word 0x0180095c			; glue 0180095c

glue_01800960:
	ldr pc, lit_01d4
lit_01d4:
	.word 0x01800960			; glue 01800960

glue_01800968:
	ldr pc, lit_01dc
lit_01dc:
	.word 0x01800968			; glue 01800968

glue_0180096c:
	ldr pc, lit_01e4
lit_01e4:
	.word 0x0180096c			; glue 0180096c

glue_01800970:
	ldr pc, lit_01ec
lit_01ec:
	.word 0x01800970			; glue 01800970

glue_01800978:
	ldr pc, lit_01f4
lit_01f4:
	.word 0x01800978			; glue 01800978

glue_0180003c:
	ldr pc, lit_01fc
lit_01fc:
	.word 0x0180003c			; glue 0180003c

glue_01801234:
	ldr pc, lit_0204
lit_0204:
	.word 0x01801234			; glue 01801234

glue_01800984:
	ldr pc, lit_020c
lit_020c:
	.word 0x01800984			; glue 01800984

glue_0180099c:
	ldr pc, lit_0214
lit_0214:
	.word 0x0180099c			; glue 0180099c

glue_01801820:
	ldr pc, lit_021c
lit_021c:
	.word 0x01801820			; glue 01801820

glue_018009d4:
	ldr pc, lit_0224
lit_0224:
	.word 0x018009d4			; glue 018009d4

glue_0180013c:
	ldr pc, lit_022c
lit_022c:
	.word 0x0180013c			; glue 0180013c

glue_018009f0:
	ldr pc, lit_0234
lit_0234:
	.word 0x018009f0			; glue 018009f0

glue_01800a0c:
	ldr pc, lit_023c
lit_023c:
	.word 0x01800a0c			; glue 01800a0c

glue_01800a24:
	ldr pc, lit_0244
lit_0244:
	.word 0x01800a24			; glue 01800a24

glue_01800a28:
	ldr pc, lit_024c
lit_024c:
	.word 0x01800a28			; glue 01800a28

glue_01800a2c:
	ldr pc, lit_0254
lit_0254:
	.word 0x01800a2c			; glue 01800a2c

glue_01800a34:
	ldr pc, lit_025c
lit_025c:
	.word 0x01800a34			; glue 01800a34

glue_01800040:
	ldr pc, lit_0264
lit_0264:
	.word 0x01800040			; glue 01800040

glue_01800a38:
	ldr pc, lit_026c
lit_026c:
	.word 0x01800a38			; glue 01800a38

glue_01800a44:
	ldr pc, lit_0274
lit_0274:
	.word 0x01800a44			; glue 01800a44

glue_01800a48:
	ldr pc, lit_027c
lit_027c:
	.word 0x01800a48			; glue 01800a48

glue_01800af4:
	ldr pc, lit_0284
lit_0284:
	.word 0x01800af4			; glue 01800af4

glue_01800af8:
	ldr pc, lit_028c
lit_028c:
	.word 0x01800af8			; glue 01800af8

glue_01800afc:
	ldr pc, lit_0294
lit_0294:
	.word 0x01800afc			; glue 01800afc

glue_01800b00:
	ldr pc, lit_029c
lit_029c:
	.word 0x01800b00			; glue 01800b00

glue_01800b04:
	ldr pc, lit_02a4
lit_02a4:
	.word 0x01800b04			; glue 01800b04

glue_01800b08:
	ldr pc, lit_02ac
lit_02ac:
	.word 0x01800b08			; glue 01800b08

glue_01800b0c:
	ldr pc, lit_02b4
lit_02b4:
	.word 0x01800b0c			; glue 01800b0c

glue_01800b10:
	ldr pc, lit_02bc
lit_02bc:
	.word 0x01800b10			; glue 01800b10

glue_01800b14:
	ldr pc, lit_02c4
lit_02c4:
	.word 0x01800b14			; glue 01800b14

glue_01801860:
	ldr pc, lit_02cc
lit_02cc:
	.word 0x01801860			; glue 01801860

glue_01800b18:
	ldr pc, lit_02d4
lit_02d4:
	.word 0x01800b18			; glue 01800b18

glue_01801868:
	ldr pc, lit_02dc
lit_02dc:
	.word 0x01801868			; glue 01801868

glue_01800b28:
	ldr pc, lit_02e4
lit_02e4:
	.word 0x01800b28			; glue 01800b28

glue_01800b2c:
	ldr pc, lit_02ec
lit_02ec:
	.word 0x01800b2c			; glue 01800b2c

glue_01800b38:
	ldr pc, lit_02f4
lit_02f4:
	.word 0x01800b38			; glue 01800b38

glue_018007e8:
	ldr pc, lit_02fc
lit_02fc:
	.word 0x018007e8			; glue 018007e8

glue_018007e4:
	ldr pc, lit_0304
lit_0304:
	.word 0x018007e4			; glue 018007e4

glue_0180000c:
	ldr pc, lit_030c
lit_030c:
	.word 0x0180000c			; glue 0180000c

glue_01800010:
	ldr pc, lit_0314
lit_0314:
	.word 0x01800010			; glue 01800010

glue_01801e18:
	ldr pc, lit_031c
lit_031c:
	.word 0x01801e18			; glue 01801e18

glue_01801c20:
	ldr pc, lit_0324
lit_0324:
	.word 0x01801c20			; glue 01801c20

sub_0328:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0354
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d30
	ldrgt pc, lit_0d34
loc_0354:
	ldrlt pc, lit_0d34

glue_01801ed8:
	ldr pc, lit_035c
lit_035c:
	.word 0x01801ed8			; glue 01801ed8

sub_0360:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_038c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d38
	ldrgt pc, lit_0d3c
loc_038c:
	ldrlt pc, lit_0d3c

glue_01801edc:
	ldr pc, lit_0394
lit_0394:
	.word 0x01801edc			; glue 01801edc

sub_0398:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_03c4
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d40
	ldrgt pc, lit_0d44
loc_03c4:
	ldrlt pc, lit_0d44

glue_01801ec8:
	ldr pc, lit_03cc
lit_03cc:
	.word 0x01801ec8			; glue 01801ec8

sub_03d0:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_03fc
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d48
	ldrgt pc, lit_0d4c
loc_03fc:
	ldrlt pc, lit_0d50

glue_01801ecc:
	ldr pc, lit_0404
lit_0404:
	.word 0x01801ecc			; glue 01801ecc

sub_0408:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0434
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d4c
	ldrgt pc, lit_0d54
loc_0434:
	ldrlt pc, lit_0d58

glue_01801ee0:
	ldr pc, lit_043c
lit_043c:
	.word 0x01801ee0			; glue 01801ee0

sub_0440:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_046c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d5c
	ldrgt pc, lit_0d60
loc_046c:
	ldrlt pc, lit_0d60

glue_01801ed0:
	ldr pc, lit_0474
lit_0474:
	.word 0x01801ed0			; glue 01801ed0

sub_0478:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_04a4
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d64
	ldrgt pc, lit_0d68
loc_04a4:
	ldrlt pc, lit_0d68

glue_01801ed4:
	ldr pc, lit_04ac
lit_04ac:
	.word 0x01801ed4			; glue 01801ed4

sub_04b0:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_04dc
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d6c
	ldrgt pc, lit_0d70
loc_04dc:
	ldrlt pc, lit_0d74

glue_01801ee4:
	ldr pc, lit_04e4
lit_04e4:
	.word 0x01801ee4			; glue 01801ee4

sub_04e8:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0514
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d78
	ldrgt pc, lit_0d7c
loc_0514:
	ldrlt pc, lit_0d80
	cmp ip, #3
	bne loc_0538
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d84
	ldrgt pc, lit_0d88
loc_0538:
	ldrlt pc, lit_0d8c

glue_01801fdc:
	ldr pc, lit_0540
lit_0540:
	.word 0x01801fdc			; glue 01801fdc

sub_0544:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0570
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d90
	ldrgt pc, lit_0d94
loc_0570:
	ldrlt pc, lit_0d98
	cmp ip, #3
	bne loc_0594
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0d9c
	ldrgt pc, lit_0da0
loc_0594:
	ldrlt pc, lit_0da4

glue_01801fe4:
	ldr pc, lit_059c
lit_059c:
	.word 0x01801fe4			; glue 01801fe4

sub_05a0:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_05cc
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0da8
	ldrgt pc, lit_0dac
loc_05cc:
	ldrlt pc, lit_0db0
	cmp ip, #3
	bne loc_05f0
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0db4
	ldrgt pc, lit_0db8
loc_05f0:
	ldrlt pc, lit_0dbc

glue_01801fe0:
	ldr pc, lit_05f8
lit_05f8:
	.word 0x01801fe0			; glue 01801fe0

sub_05fc:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0628
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0dc0
	ldrgt pc, lit_0dc4
loc_0628:
	ldrlt pc, lit_0dc8
	cmp ip, #3
	bne loc_064c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0dcc
	ldrgt pc, lit_0dd0
loc_064c:
	ldrlt pc, lit_0dd4

glue_01801fe8:
	ldr pc, lit_0654
lit_0654:
	.word 0x01801fe8			; glue 01801fe8

sub_0658:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0684
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0dc8
	ldrgt pc, lit_0dd8
loc_0684:
	ldrlt pc, lit_0ddc
	cmp ip, #3
	bne loc_06a8
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0de0
	ldrgt pc, lit_0de4
loc_06a8:
	ldrlt pc, lit_0de8

glue_01801fd4:
	ldr pc, lit_06b0
lit_06b0:
	.word 0x01801fd4			; glue 01801fd4

sub_06b4:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_06e0
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0dec
	ldrgt pc, lit_0df0
loc_06e0:
	ldrlt pc, lit_0df4
	cmp ip, #3
	bne loc_0704
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0df8
	ldrgt pc, lit_0dfc
loc_0704:
	ldrlt pc, lit_0e00

glue_01801fd8:
	ldr pc, lit_070c
lit_070c:
	.word 0x01801fd8			; glue 01801fd8

sub_0710:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_073c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e04
	ldrgt pc, lit_0e08
loc_073c:
	ldrlt pc, lit_0e0c
	cmp ip, #3
	bne loc_0760
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e10
	ldrgt pc, lit_0e14
loc_0760:
	ldrlt pc, lit_0e18

glue_01802024:
	ldr pc, lit_0768
lit_0768:
	.word 0x01802024			; glue 01802024

sub_076c:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0798
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e1c
	ldrgt pc, lit_0e20
loc_0798:
	ldrlt pc, lit_0e24
	cmp ip, #3
	bne loc_07bc
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e28
	ldrgt pc, lit_0e2c
loc_07bc:
	ldrlt pc, lit_0e30

glue_01802028:
	ldr pc, lit_07c4
lit_07c4:
	.word 0x01802028			; glue 01802028

sub_07c8:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_07f4
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e34
	ldrgt pc, lit_0e38
loc_07f4:
	ldrlt pc, lit_0e3c
	cmp ip, #3
	bne loc_0818
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e40
	ldrgt pc, lit_0e44
loc_0818:
	ldrlt pc, lit_0e48

glue_0180202c:
	ldr pc, lit_0820
lit_0820:
	.word 0x0180202c			; glue 0180202c

sub_0824:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0850
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e4c
	ldrgt pc, lit_0e50
loc_0850:
	ldrlt pc, lit_0e54
	cmp ip, #3
	bne loc_0874
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e58
	ldrgt pc, lit_0e5c
loc_0874:
	ldrlt pc, lit_0e60

glue_01802030:
	ldr pc, lit_087c
lit_087c:
	.word 0x01802030			; glue 01802030

sub_0880:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_08ac
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e64
	ldrgt pc, lit_0e68
loc_08ac:
	ldrlt pc, lit_0e6c
	cmp ip, #3
	bne loc_08d0
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e70
	ldrgt pc, lit_0e74
loc_08d0:
	ldrlt pc, lit_0e78

glue_01802034:
	ldr pc, lit_08d8
lit_08d8:
	.word 0x01802034			; glue 01802034

sub_08dc:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0908
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e7c
	ldrgt pc, lit_0e80
loc_0908:
	ldrlt pc, lit_0e84
	cmp ip, #3
	bne loc_092c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e88
	ldrgt pc, lit_0e8c
loc_092c:
	ldrlt pc, lit_0e90

glue_01802038:
	ldr pc, lit_0934
lit_0934:
	.word 0x01802038			; glue 01802038

sub_0938:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0964
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0e94
	ldrgt pc, lit_0e98
loc_0964:
	ldrlt pc, lit_0e9c
	cmp ip, #3
	bne loc_0988
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ea0
	ldrgt pc, lit_0ea4
loc_0988:
	ldrlt pc, lit_0ea8

glue_0180203c:
	ldr pc, lit_0990
lit_0990:
	.word 0x0180203c			; glue 0180203c

sub_0994:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_09c0
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0eac
	ldrgt pc, lit_0eb0
loc_09c0:
	ldrlt pc, lit_0eb0
	cmp ip, #3
	bne loc_09e4
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0eb4
	ldrgt pc, lit_0eb4
loc_09e4:
	ldrlt pc, lit_0eb4

glue_01802040:
	ldr pc, lit_09ec
lit_09ec:
	.word 0x01802040			; glue 01802040

sub_09f0:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0a1c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0eb8
	ldrgt pc, lit_0ebc
loc_0a1c:
	ldrlt pc, lit_0ebc
	cmp ip, #3
	bne loc_0a40
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ec0
	ldrgt pc, lit_0ec0
loc_0a40:
	ldrlt pc, lit_0ec0

glue_01802044:
	ldr pc, lit_0a48
lit_0a48:
	.word 0x01802044			; glue 01802044

sub_0a4c:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0a78
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ec4
	ldrgt pc, lit_0ec8
loc_0a78:
	ldrlt pc, lit_0ec8
	cmp ip, #3
	bne loc_0a9c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ecc
	ldrgt pc, lit_0ecc
loc_0a9c:
	ldrlt pc, lit_0ecc

glue_01802048:
	ldr pc, lit_0aa4
lit_0aa4:
	.word 0x01802048			; glue 01802048

sub_0aa8:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0ad4
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ed0
	ldrgt pc, lit_0ed4
loc_0ad4:
	ldrlt pc, lit_0ed8
	cmp ip, #3
	bne loc_0af8
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0edc
	ldrgt pc, lit_0ee0
loc_0af8:
	ldrlt pc, lit_0ee4

glue_0180204c:
	ldr pc, lit_0b00
lit_0b00:
	.word 0x0180204c			; glue 0180204c

sub_0b04:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0b30
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ee8
	ldrgt pc, lit_0eec
loc_0b30:
	ldrlt pc, lit_0eec
	cmp ip, #3
	bne loc_0b54
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ef0
	ldrgt pc, lit_0ef0
loc_0b54:
	ldrlt pc, lit_0ef0

glue_01802050:
	ldr pc, lit_0b5c
lit_0b5c:
	.word 0x01802050			; glue 01802050

sub_0b60:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0b8c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0ef4
	ldrgt pc, lit_0ef8
loc_0b8c:
	ldrlt pc, lit_0efc
	cmp ip, #3
	bne loc_0bb0
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0f00
	ldrgt pc, lit_0f00
loc_0bb0:
	ldrlt pc, lit_0f00

glue_018020dc:
	ldr pc, lit_0bb8
lit_0bb8:
	.word 0x018020dc			; glue 018020dc

sub_0bbc:
	mov ip, #0x1300
	ldr ip, [ip, #0xdc]
	sub ip, ip, #0x10000
	cmp ip, #1
	bne loc_0be8
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0f04
	ldrgt pc, lit_0f08
loc_0be8:
	ldrlt pc, lit_0f08
	cmp ip, #3
	bne loc_0c0c
	mov ip, #0x1300
	ldr ip, [ip, #0xe0]
	mov ip, ip, asr #16
	cmp ip, #0
	ldreq pc, lit_0f0c
	ldrgt pc, lit_0f0c
loc_0c0c:
	ldrlt pc, lit_0f0c

glue_018020e0:
	ldr pc, lit_0c14
lit_0c14:
	.word 0x018020e0			; glue 018020e0

glue_01802490:
	ldr pc, lit_0c1c
lit_0c1c:
	.word 0x01802490			; glue 01802490

glue_01802494:
	ldr pc, lit_0c24
lit_0c24:
	.word 0x01802494			; glue 01802494

glue_01802498:
	ldr pc, lit_0c2c
lit_0c2c:
	.word 0x01802498			; glue 01802498

glue_01802728:
	ldr pc, lit_0c34
lit_0c34:
	.word 0x01802728			; glue 01802728

glue_0180272c:
	ldr pc, lit_0c3c
lit_0c3c:
	.word 0x0180272c			; glue 0180272c

glue_01802730:
	ldr pc, lit_0c44
lit_0c44:
	.word 0x01802730			; glue 01802730

glue_01802734:
	ldr pc, lit_0c4c
lit_0c4c:
	.word 0x01802734			; glue 01802734

glue_01802738:
	ldr pc, lit_0c54
lit_0c54:
	.word 0x01802738			; glue 01802738

glue_0180273c:
	ldr pc, lit_0c5c
lit_0c5c:
	.word 0x0180273c			; glue 0180273c

glue_01802740:
	ldr pc, lit_0c64
lit_0c64:
	.word 0x01802740			; glue 01802740

glue_01802744:
	ldr pc, lit_0c6c
lit_0c6c:
	.word 0x01802744			; glue 01802744

glue_01802748:
	ldr pc, lit_0c74
lit_0c74:
	.word 0x01802748			; glue 01802748

glue_0180274c:
	ldr pc, lit_0c7c
lit_0c7c:
	.word 0x0180274c			; glue 0180274c

glue_01802750:
	ldr pc, lit_0c84
lit_0c84:
	.word 0x01802750			; glue 01802750

glue_01802754:
	ldr pc, lit_0c8c
lit_0c8c:
	.word 0x01802754			; glue 01802754

sub_0c90:
	adr r0, data_0c99
	mov pc, lr
	.byte 0x00
data_0c99:
	.byte 0x00, 0x17, 0x40
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x6622439b
	.asciz "_proto"
	.byte 0xba

sub_0cb0:
	adr r0, data_0cb9
	mov pc, lr
	.byte 0x00
data_0cb9:
	.byte 0x00, 0x1a, 0x40
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xe192cd21			; orrs ip, r2, r1, lsr #26
	.asciz "CFunction"
	.byte 0xba, 0xba
	.word 0xbabababa			; blt -0x115083c

sub_0cd8:
	adr r0, data_0ce1
	mov pc, lr
	.byte 0x00
data_0ce1:
	.byte 0x00, 0x1d, 0x40
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xfe98faf2
	.asciz "bincfunction"
	.byte 0xba, 0xba, 0xba

sub_0d00:
	adr r0, data_0d09
	mov pc, lr
	.byte 0x00
data_0d09:
	.byte 0x00, 0x17, 0x40
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x1810f35f			; ldmdane r0, {r0, r1, r2, r3, r4, r6, r8, sb, ip, sp, lr, pc}
	.asciz "string"
	.byte 0xba
lit_0d20:
	.word 0x04102a0c
lit_0d24:
	.word 0x04102b70
lit_0d28:
	.word 0x04102a04
lit_0d2c:
	.word 0x04102b68
lit_0d30:
	.word 0x01a6db74
lit_0d34:
	.word 0x01a6db4c
lit_0d38:
	.word 0x01a6db44
lit_0d3c:
	.word 0x01a6cb1c
lit_0d40:
	.word 0x01a5f7d4
lit_0d44:
	.word 0x01a5e7a8
lit_0d48:
	.word 0x01a70c3c
lit_0d4c:
	.word 0x01a70c14
lit_0d50:
	.word 0x01a70c18
lit_0d54:
	.word 0x01a6fbec
lit_0d58:
	.word 0x01a6fbf0
lit_0d5c:
	.word 0x01a638e4
lit_0d60:
	.word 0x01a628b8
lit_0d64:
	.word 0x01a64914
lit_0d68:
	.word 0x01a638e8
lit_0d6c:
	.word 0x01a71c6c
lit_0d70:
	.word 0x01a71c44
lit_0d74:
	.word 0x01a71c48
lit_0d78:
	.word 0x0018e174
lit_0d7c:
	.word 0x0019219c
lit_0d80:
	.word 0x0018d910
lit_0d84:
	.word 0x01c6ebb8
lit_0d88:
	.word 0x01c68a10
lit_0d8c:
	.word 0x00197964
lit_0d90:
	.word 0x0018e338
lit_0d94:
	.word 0x00192360
lit_0d98:
	.word 0x0018dad4
lit_0d9c:
	.word 0x01c6fbc0
lit_0da0:
	.word 0x01c68a18
lit_0da4:
	.word 0x00197b28
lit_0da8:
	.word 0x0018e500
lit_0dac:
	.word 0x00192528
lit_0db0:
	.word 0x0018dc9c
lit_0db4:
	.word 0x01c6ebbc
lit_0db8:
	.word 0x01c68a14
lit_0dbc:
	.word 0x00197cf0
lit_0dc0:
	.word 0x0018e6c4
lit_0dc4:
	.word 0x001926ec
lit_0dc8:
	.word 0x0018de60
lit_0dcc:
	.word 0x01c6fbc4
lit_0dd0:
	.word 0x01c68a1c
lit_0dd4:
	.word 0x00197eb4
lit_0dd8:
	.word 0x00191e88
lit_0ddc:
	.word 0x0018d5fc
lit_0de0:
	.word 0x01c6ebb0
lit_0de4:
	.word 0x01c68a08
lit_0de8:
	.word 0x00197650
lit_0dec:
	.word 0x0018e010
lit_0df0:
	.word 0x00192038
lit_0df4:
	.word 0x0018d7ac
lit_0df8:
	.word 0x01c6ebb4
lit_0dfc:
	.word 0x01c68a0c
lit_0e00:
	.word 0x00197800
lit_0e04:
	.word 0x00189d04
lit_0e08:
	.word 0x0018dd2c
lit_0e0c:
	.word 0x001894a0
lit_0e10:
	.word 0x00197128
lit_0e14:
	.word 0x00194694
lit_0e18:
	.word 0x00193374
lit_0e1c:
	.word 0x00187eac
lit_0e20:
	.word 0x0018bed4
lit_0e24:
	.word 0x00187648
lit_0e28:
	.word 0x001952a8
lit_0e2c:
	.word 0x00192814
lit_0e30:
	.word 0x001914f4
lit_0e34:
	.word 0x0018d00c
lit_0e38:
	.word 0x00191034
lit_0e3c:
	.word 0x0018c7a8
lit_0e40:
	.word 0x0019a5b0
lit_0e44:
	.word 0x00197b38
lit_0e48:
	.word 0x001967fc
lit_0e4c:
	.word 0x0018dbbc
lit_0e50:
	.word 0x00191be4
lit_0e54:
	.word 0x0018d358
lit_0e58:
	.word 0x0019b160
lit_0e5c:
	.word 0x001986e8
lit_0e60:
	.word 0x001973ac
lit_0e64:
	.word 0x0018d4f8
lit_0e68:
	.word 0x00191520
lit_0e6c:
	.word 0x0018cc94
lit_0e70:
	.word 0x0019aa9c
lit_0e74:
	.word 0x00198024
lit_0e78:
	.word 0x00196ce8
lit_0e7c:
	.word 0x001875d8
lit_0e80:
	.word 0x0018b600
lit_0e84:
	.word 0x00186d74
lit_0e88:
	.word 0x001949d4
lit_0e8c:
	.word 0x00191f40
lit_0e90:
	.word 0x00190c20
lit_0e94:
	.word 0x00188074
lit_0e98:
	.word 0x0018c09c
lit_0e9c:
	.word 0x00187810
lit_0ea0:
	.word 0x00195470
lit_0ea4:
	.word 0x001929dc
lit_0ea8:
	.word 0x001916bc
lit_0eac:
	.word 0x01a65948
lit_0eb0:
	.word 0x01a6491c
lit_0eb4:
	.word 0x01a64900
lit_0eb8:
	.word 0x01a6594c
lit_0ebc:
	.word 0x01a64920
lit_0ec0:
	.word 0x01a64904
lit_0ec4:
	.word 0x01a65950
lit_0ec8:
	.word 0x01a64924
lit_0ecc:
	.word 0x01a64908
lit_0ed0:
	.word 0x0018c45c
lit_0ed4:
	.word 0x00190484
lit_0ed8:
	.word 0x0018bbf8
lit_0edc:
	.word 0x00199a00
lit_0ee0:
	.word 0x00196f6c
lit_0ee4:
	.word 0x00195c4c
lit_0ee8:
	.word 0x01a6db58
lit_0eec:
	.word 0x01a6cb30
lit_0ef0:
	.word 0x01a6cb04
lit_0ef4:
	.word 0x01a73cfc
lit_0ef8:
	.word 0x01a73cd4
lit_0efc:
	.word 0x01a73cd8
lit_0f00:
	.word 0x01a72c94
lit_0f04:
	.word 0x01a60818
lit_0f08:
	.word 0x01a5f7ec
lit_0f0c:
	.word 0x01a5f7d8

sub_0f10:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x1000
	ldr r0, [r0, #0x3dc]
	cmp r0, #0x20000
	ldmdbge fp, {r4, r5, fp, sp, lr}
	bge glue_01802728
	mov r0, #0x10
	bl glue_01801234
	movs r4, r0
	bne loc_0f54
	adr r0, str_0f94, #30
	mov r2, #0
	mov r1, #0xe9
	sub r1, r1, #0x2800
	bl glue_01801868
loc_0f54:
	bl sub_0000
	mov r5, r0
	ldr r0, [r0, #8]
	str r0, [r4]
	ldr r0, [r5, #0x14]
	str r0, [r4, #4]
	ldr r0, [r5, #0x18]
	ldr r0, [r0]
	bl glue_01800818
	mov r1, #0
	str r0, [r4, #8]
	str r1, [r0, #4]!
	ldr r0, [r5, #0x44]!
	str r0, [r4, #0xc]
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}
str_0f94:
	.asciz "evt.ex.outofmem"

sub_0fa4:
	mov r1, #0x1000
	ldr r1, [r1, #0x3dc]
	cmp r1, #0x20000
	bge glue_0180273c
	ldr r0, [r0, #0x2c]
	cmn r0, #2
	moveq r0, #0
	movne r0, #1
	mov pc, lr

sub_0fc8:
	mov r1, #0x1000
	ldr r1, [r1, #0x3dc]
	cmp r1, #0x20000
	mvnlt r1, #1
	strlt r1, [r0, #0x2c]!
	bge glue_01802740
	mov pc, lr

sub_0fe4:
	mov r3, #0x1000
	ldr r3, [r3, #0x3dc]
	cmp r3, #0x20000
	bge glue_01802744
	mvn r3, #0
	str r3, [r0, #0x2c]
	ldr r1, [r1]
	ldr r1, [r1]
	ldr r3, [r0, #0x38]
	str r1, [r3]
	ldr r1, [r2]
	ldr r1, [r1]
	ldr r0, [r0, #0x3c]
	str r1, [r0]
	mov pc, lr

sub_1020:
	mov r3, #0x1000
	ldr r3, [r3, #0x3dc]
	cmp r3, #0x20000
	movge pc, lr
	ldr r1, [r1]
	ldr r1, [r1]
	ldr r3, [r0, #0x38]
	str r1, [r3]
	ldr r1, [r2]
	ldr r1, [r1]
	ldr r0, [r0, #0x3c]
	str r1, [r0]
	mov pc, lr

sub_1054:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #8
	bl glue_0180080c
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, r5, lsl #2
	bl glue_01800818
	str r0, [sp], #-4
	adr r0, str_10f8, #30
	bl glue_0180094c
	bl glue_01800818
	str r0, [sp]
	mov r1, sp
	add r2, sp, #4
	add r0, sp, #8
	bl glue_01800a34
	sub sp, sp, #4
	adr r0, str_1104, #30
	bl glue_0180094c
	bl glue_01800818
	str r0, [sp]
	mov r1, sp
	mov r2, r4
	add r0, sp, #0xc
	bl glue_01800a34
	add r1, sp, #0xc
	adr r0, str_110c, #30
	bl glue_01800b28
	ldr r0, [sp]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldmdb fp, {r4, r5, fp, sp, pc}
str_10f8:
	.asciz "errorcode"
	.align 4
str_1104:
	.asciz "symbol"
	.align 4
str_110c:
	.asciz "evt.ex.fr.intrp;type.ref.frame"
	.align 4

sub_112c:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #8
	bl glue_0180080c
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, r5, lsl #2
	bl glue_01800818
	str r0, [sp], #-4
	adr r0, str_11d0, #30
	bl glue_0180094c
	bl glue_01800818
	str r0, [sp]
	mov r1, sp
	add r2, sp, #4
	add r0, sp, #8
	bl glue_01800a34
	sub sp, sp, #4
	adr r0, str_11dc, #30
	bl glue_0180094c
	bl glue_01800818
	str r0, [sp]
	mov r1, sp
	mov r2, r4
	add r0, sp, #0xc
	bl glue_01800a34
	add r1, sp, #0xc
	adr r0, str_11e4, #30
	bl glue_01800b28
	ldr r0, [sp]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldmdb fp, {r4, r5, fp, sp, pc}
str_11d0:
	.asciz "errorcode"
	.align 4
str_11dc:
	.asciz "value"
	.align 4
str_11e4:
	.asciz "evt.ex.fr;type.ref.frame"
	.align 4

sub_1200:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #8
	bl glue_0180080c
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, r5, lsl #2
	bl glue_01800818
	str r0, [sp], #-4
	adr r0, str_12a4, #30
	bl glue_0180094c
	bl glue_01800818
	str r0, [sp]
	mov r1, sp
	add r2, sp, #4
	add r0, sp, #8
	bl glue_01800a34
	sub sp, sp, #4
	adr r0, str_12b0, #30
	bl glue_0180094c
	bl glue_01800818
	str r0, [sp]
	mov r1, sp
	mov r2, r4
	add r0, sp, #0xc
	bl glue_01800a34
	add r1, sp, #0xc
	adr r0, str_12b8, #30
	bl glue_01800b28
	ldr r0, [sp]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldmdb fp, {r4, r5, fp, sp, pc}
str_12a4:
	.asciz "errorcode"
	.align 4
str_12b0:
	.asciz "value"
	.align 4
str_12b8:
	.asciz "evt.ex.fr.type;type.ref.frame"
	.align 4

sub_12d8:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	add r4, r0, #0x64
	bl sub_0000
	mov r1, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_0b60

sub_12f8:
	b sub_0328

sub_12fc:
	b sub_0360

sub_1300:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r1, #0x1000
	ldr r1, [r1, #0x3dc]
	cmp r1, #0x20000
	ldmdbge fp, {r4, fp, sp, lr}
	bge glue_0180272c
	bl sub_0000
	ldr r1, [r4]
	str r1, [r0, #8]
	ldr r1, [r4, #4]
	str r1, [r0, #0x14]
	ldr r2, [r4, #8]
	ldr r2, [r2]
	ldr r1, [r0, #0x18]
	str r2, [r1]
	ldr r1, [r4, #0xc]!
	str r1, [r0, #0x44]!
	ldmdb fp, {r4, fp, sp, pc}

sub_1354:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #4
	bl sub_0048
	ldr r1, [r4]
	ldr r1, [r1]
	bl glue_0180092c
	bl glue_01800818
	str r0, [sp]
	ldr r0, [r0]
	teq r0, #2
	moveq r1, r4
	moveq r0, #0x158
	subeq r0, r0, #0xc000
	bleq sub_1054
	ldr r0, [sp]
	ldr r4, [r0]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_13ac:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	bl sub_0398
	teq r0, #0
	moveq r0, r4
	bleq sub_0408
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_0360

sub_13d8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r1
	mov r6, r2
	mov r4, r3
	mov ip, #0x1000
	ldr ip, [ip, #0x3dc]
	cmp ip, #0x20000
	ldmdbge fp, {r4, r5, r6, fp, sp, lr}
	bge glue_01802748
	bl sub_0440
	ldr r1, [r4]
	str r0, [r1]
	teq r0, #2
	bne loc_1430
	teq r6, #0
	movne r0, #2
	ldmdbne fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r5
	ldr r0, lit_1448
	bl sub_1054
loc_1430:
	ldr r0, [r4]
	ldr r0, [r0]
	ldr r1, [r5]
	ldr r1, [r1]
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b glue_0180092c
lit_1448:
	.word 0xffff4157

sub_144c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r3, #0x1000
	ldr r3, [r3, #0x3dc]
	cmp r3, #0x20000
	ldmdbge fp, {r4, r5, r6, r7, fp, sp, lr}
	bge glue_0180274c
	ldr r0, [r4]
	ldr r7, [r0]
	bl sub_0c90
	mov r1, r0
	mov r0, r7
	bl glue_0180092c
	ldr r1, [r4]
	str r0, [r1]
	teq r0, #2
	bne loc_14b8
	teq r6, #0
	bne loc_14dc
	mov r1, r5
	mov r0, #0x56
	sub r0, r0, #0xbf00
	bl sub_1054
loc_14b8:
	mov r1, r5
	mov r0, r4
	bl sub_0478
	ldr r1, [r4]
	str r0, [r1]
	teq r0, #2
	bne loc_14f0
	teq r6, #0
	beq loc_14e4
loc_14dc:
	mov r0, #2
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
loc_14e4:
	mov r1, r5
	ldr r0, lit_1508
	bl sub_1054
loc_14f0:
	ldr r0, [r4]
	ldr r0, [r0]
	ldr r1, [r5]
	ldr r1, [r1]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b glue_0180092c
lit_1508:
	.word 0xffff4157

sub_150c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov ip, r3
	ldr r3, [fp, #4]
	stmdb sp!, {r3}
	mov r3, ip
	bl sub_03d0
	add sp, sp, #4
	teq r0, #0
	moveq r0, r4
	bleq sub_0408
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b sub_0360

sub_154c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r3, #0x1000
	ldr r3, [r3, #0x3dc]
	cmp r3, #0x20000
	ldmdbge fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	bge glue_01802750
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800920
	mov r7, r0
	bl sub_0cb0
	mov r1, r0
	mov r0, r7
	bl glue_018008fc
	mov r8, #2
	teq r0, #0
	beq loc_164c
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800920
	mov r1, r0
	tst r0, #3
	moveq r0, r1, asr #2
	beq loc_15cc
	bl glue_018007e8
loc_15cc:
	teq r0, r6
	beq loc_15f0
	cmn r0, #1
	beq loc_1714
	adr r0, str_1620, #30
	mov r2, #0
	mov r1, #0x5d
	sub r1, r1, #0xbf00
	bl glue_01801868
loc_15f0:
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800978
	cmp r0, #3
	ble sub_1630
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	ldr r1, [r5]
	str r0, [r1]
	b loc_1638
str_1620:
	.asciz "evt.ex.fr.intrp"

sub_1630:
	ldr r0, [r5]
	str r8, [r0]
loc_1638:
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #1
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	b glue_01800920
loc_164c:
	bl sub_0cd8
	mov r1, r0
	mov r0, r7
	bl glue_018008fc
	teq r0, #0
	beq loc_1714
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800920
	mov r1, r0
	tst r0, #3
	moveq r0, r1, asr #2
	beq loc_1688
	bl glue_018007e8
loc_1688:
	teq r0, r6
	beq loc_16ac
	cmn r0, #1
	beq loc_1714
	adr r0, str_1620, #30
	mov r2, #0
	mov r1, #0x5d
	sub r1, r1, #0xbf00
	bl glue_01801868
loc_16ac:
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800978
	cmp r0, #4
	ble sub_16dc
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	ldr r1, [r5]
	str r0, [r1]
	b loc_16e4

sub_16dc:
	ldr r0, [r5]
	str r8, [r0]
loc_16e4:
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	bl glue_01800828
	mov r5, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #4
	bl glue_01800920
	add r0, r5, r0, asr #2
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}
loc_1714:
	mov r0, #0
	ldmdb fp, {r4, r5, r6, r7, r8, fp, sp, pc}

sub_171c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r1
	sub sp, sp, #4
	mov r2, sp
	mov r3, #1
	bl glue_01800940
	ldr r1, [sp]
	teq r1, #0
	bne loc_1790
	mov r0, #7
	add r0, r0, #0x4000
	ldr r1, [r4]
	ldr r1, [r1]
	bl glue_01800914
	teq r0, #0
	beq loc_177c
	mov r0, #7
	add r0, r0, #0x4000
	ldr r1, [r4]
	ldr r1, [r1]
	bl glue_0180092c
	b loc_1790
loc_177c:
	mov r1, r4
	mov r0, #0x59
	sub r0, r0, #0xbf00
	bl sub_1054
	mov r0, #0
loc_1790:
	ldmdb fp, {r4, fp, sp, pc}

sub_1794:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r2
	mov r3, #1
	stmdb sp!, {r3}
	bl sub_04b0
	ldr r0, [r4]
	ldr r0, [r0]
	ldmdb fp, {r4, fp, sp, pc}

sub_17bc:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	sub sp, sp, #8
	add r2, sp, #4
	mov r3, #0
	bl glue_01800940
	bl glue_01800818
	str r0, [sp]
	ldr r1, [sp, #4]
	teq r1, #0
	moveq r4, #2
	movne r4, #0x1a
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_17fc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	bl glue_01800910
	teq r0, #0
	moveq r0, #2
	movne r0, #0x1a
	ldmdb fp, {fp, sp, pc}

sub_181c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r1, #0x1000
	ldr r1, [r1, #0x3dc]
	cmp r1, #0x20000
	ldmdbge fp, {r4, fp, sp, lr}
	bge glue_01802730
	ldr r0, [r4, #8]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, fp, sp, lr}
	b glue_01801024

sub_1854:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r1
	mov r5, r2
	mov r4, r3
	mov ip, #0x1000
	ldr ip, [ip, #0x3dc]
	cmp ip, #0x20000
	ldmdbge fp, {r4, r5, r6, fp, sp, lr}
	bge glue_01802754
	sub sp, sp, #8
	bl glue_01800838
	bl glue_01800818
	str r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800818
	str r0, [sp]
	mov r0, sp
	bl glue_01800838
	ldr r1, [sp]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0]
	ldr r1, [r6]
	ldr r2, [r1]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0]
	ldr r1, [r5]
	ldr r2, [r1]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0]
	ldr r1, [r4]
	ldr r2, [r1]
	mov r1, #2
	bl glue_01800a24
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #3
	ldr r2, [sp]
	ldr r2, [r2]
	bl glue_01800a24
	ldr r0, [sp, #4]
	ldr r4, [r0]
	ldr r0, [sp]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1934:
	teq r0, #2
	mvneq r0, #0
	moveq pc, lr
	tst r0, #3
	bne glue_018007e8
	moveq r0, r0, asr #2
	mov pc, lr

sub_1950:
	adr r0, str_1964, #30
	mov r2, #0
	mov r1, #0x15c
	sub r1, r1, #0xc000
	b glue_01801868
str_1964:
	.asciz "evt.ex.fr.intrp"

sub_1974:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0
	bl glue_018020e4
	mov r4, r0
	bl glue_018020e4
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_1998:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #4
	teq r1, #0
	moveq r0, #2
	movne r0, #0x1a
	bl glue_01800818
	str r0, [sp], #-4
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, sp
	add r2, sp, #4
	mov r1, r4
	bl sub_0aa8
	mov r4, r0
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, fp, sp, pc}

sub_19f8:
	b sub_0994

sub_19fc:
	b sub_09f0

sub_1a00:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bl sub_04e8
	teq r0, #2
	moveq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1a2c:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	bne sub_1a00
	cmp r3, r2
	movge r0, #0
	movlt r0, #1
	mov pc, lr

sub_1a58:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bl sub_0544
	teq r0, #2
	moveq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1a84:
	mov r0, #0x1000
	ldr r0, [r0, #0x3dc]
	cmp r0, #0x20000
	bge glue_01802490
	mov pc, lr

sub_1a98:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	bne sub_1a58
	cmp r3, r2
	movgt r0, #0
	movle r0, #1
	mov pc, lr

sub_1ac4:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bl sub_05a0
	teq r0, #2
	moveq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1af0:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	bne sub_1ac4
	cmp r3, r2
	movle r0, #0
	movgt r0, #1
	mov pc, lr

sub_1b1c:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bl sub_05fc
	teq r0, #2
	moveq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1b48:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	bne sub_1b1c
	cmp r3, r2
	movlt r0, #0
	movge r0, #1
	mov pc, lr

sub_1b74:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bl sub_0658
	teq r0, #2
	moveq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1ba0:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	bne sub_1b74
	teq r3, r2
	movne r0, #0
	moveq r0, #1
	mov pc, lr

sub_1bcc:
	mov ip, sp
	stmdb sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	mov r2, r1
	mov r1, r0
	mov r0, #0
	bl sub_06b4
	teq r0, #2
	moveq r0, #0
	movne r0, #1
	ldmdb fp, {fp, sp, pc}

sub_1bf8:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	bne sub_1bcc
	teq r3, r2
	moveq r0, #0
	movne r0, #1
	mov pc, lr

sub_1c24:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	addeq r0, r3, r2
	moveq pc, lr
	mov r2, r1
	mov r1, r0
	mov r0, #0
	b sub_0710

sub_1c54:
	mov r0, #0x1000
	ldr r0, [r0, #0x3dc]
	cmp r0, #0x20000
	bge glue_01802494
	mov pc, lr

sub_1c68:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	subeq r0, r3, r2
	moveq pc, lr
	mov r2, r1
	mov r1, r0
	mov r0, #0
	b sub_07c8

sub_1c98:
	ldr r2, [r0]
	ldr r3, [r2]
	ldr r2, [r1]
	ldr r2, [r2]
	orr ip, r3, r2
	tst ip, #3
	moveq r0, r2, asr #2
	muleq r0, r3, r0
	moveq pc, lr
	mov r2, r1
	mov r1, r0
	mov r0, #0
	b sub_0880

sub_1ccc:
	mov r2, r1
	mov r1, r0
	mov r0, #0
	b sub_0824

sub_1cdc:
	mov r2, r1
	mov r1, r0
	mov r0, #0
	b sub_076c

sub_1cec:
	mov r3, r2
	mov r2, r1
	mov r1, r0
	mov r0, #0
	b sub_0938

sub_1d00:
	ldr r1, [r0]
	ldr r1, [r1]
	tst r1, #3
	movne r1, r0
	movne r0, #0
	bne sub_08dc
	rsbeq r0, r1, #0
	mov pc, lr

sub_1d20:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	ldr r0, [r0]
	ldr r0, [r0]
	tst r0, #1
	beq sub_1d74
	bl glue_018009bc
	tst r0, #1
	bne sub_1d74
	cmp r4, #0
	blt sub_1d74
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800978
	add r1, r4, r6
	cmp r0, r1
	ldmdbge fp, {r4, r5, r6, fp, sp, pc}

sub_1d74:
	adr r0, str_1d8c, #30
	mov r2, #0
	mov r1, #0xae
	sub r1, r1, #0xbd00
	ldmdb fp, {r4, r5, r6, fp, sp, lr}
	b glue_01801868
str_1d8c:
	.asciz "evt.ex.frames"
	.align 4

sub_1d9c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	ldr r0, [r0]
	ldr r0, [r0]
	bl glue_018009bc
	mov r7, r0
	ldr r0, [r4]
	ldr r0, [r0]
	tst r0, #1
	beq sub_1df4
	tst r7, #1
	bne sub_1df4
	cmp r5, #0
	blt sub_1df4
	bl glue_01800978
	add r1, r5, r6
	cmp r0, r1
	bge loc_1e08

sub_1df4:
	adr r0, str_1e24, #30
	mov r2, #0
	mov r1, #0xae
	sub r1, r1, #0xbd00
	bl glue_01801868
loc_1e08:
	tst r7, #0x40
	movne r1, r4
	movne r0, #0xaa
	subne r0, r0, #0xbd00
	ldmdbne fp, {r4, r5, r6, r7, fp, sp, lr}
	bne sub_112c
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
str_1e24:
	.asciz "evt.ex.frames"
	.align 4

sub_1e34:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r2, #1
	bl sub_1d20
	sub sp, sp, #8
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	ldrb r0, [r0, r5]
	strb r0, [sp, #4]
	mov r0, #0
	strb r0, [sp, #5]
	mov r1, sp
	add r0, sp, #4
	mvn r3, #0x80000000
	mov r2, #1
	bl glue_01801a50
	ldr r0, [sp]
	mov r0, r0, lsr #16
	mov r1, #1
	orr r0, r1, r0, lsl #2
	mov r1, #2
	orr r0, r1, r0, lsl #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1ea0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r2, #1
	bl sub_1d9c
	sub sp, sp, #4
	ldr r0, [r6]
	ldr r0, [r0]
	ands r1, r0, #3
	bne loc_1ee4
	moveq r0, r0, asr #2
	beq loc_1f0c
	bl glue_018007e8
	b loc_1f0c
loc_1ee4:
	teq r1, #2
	moveq r1, #3
	andeq r1, r1, r0, asr #2
	teqeq r1, #1
	moveq r0, r0, asr #2
	moveq r0, r0, asr #2
	moveq r0, r0, lsl #16
	moveq r0, r0, lsr #16
	beq loc_1f0c
	bl glue_018007e4
loc_1f0c:
	strb r0, [sp, #1]
	mov r0, r0, asr #8
	strb r0, [sp], #-4
	mov r0, #0
	strb r0, [sp, #7]
	strb r0, [sp, #6]
	mov r1, sp
	add r0, sp, #4
	mvn r3, #0x80000000
	mov r2, #1
	bl glue_01801a4c
	ldrb r6, [sp]
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	strb r6, [r0, r4]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_1f50:
	mov ip, sp
	stmdb sp!, {r0, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r0, #0x1000
	ldr r0, [r0, #0x3dc]
	subs ip, r0, #0x10000
	cmpge ip, #3
	sub r0, fp, #0x10
	sublt r0, r0, #0x14
	subge r0, r0, #4
	bl sub_0bbc
	ldmdb fp, {fp, sp, pc}

sub_1f80:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	sub sp, sp, #4
	mov r2, #2
	bl sub_1d20
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r1, r0, r4
	mov r0, sp
	mov r2, #2
	bl glue_0180011c
	ldr r0, [sp]
	mov r0, r0, lsr #16
	mov r1, #1
	orr r0, r1, r0, lsl #2
	mov r1, #2
	orr r0, r1, r0, lsl #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_1fd8:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r6, r2
	sub sp, sp, #4
	mov r2, #2
	bl sub_1d9c
	ldr r0, [r6]
	ldr r0, [r0]
	ands r1, r0, #3
	bne loc_201c
	moveq r0, r0, asr #2
	beq loc_2044
	bl glue_018007e8
	b loc_2044
loc_201c:
	teq r1, #2
	moveq r1, #3
	andeq r1, r1, r0, asr #2
	teqeq r1, #1
	moveq r0, r0, asr #2
	moveq r0, r0, asr #2
	moveq r0, r0, lsl #16
	moveq r0, r0, lsr #16
	beq loc_2044
	bl glue_018007e4
loc_2044:
	strb r0, [sp, #1]
	mov r0, r0, asr #8
	strb r0, [sp]
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r0, r0, r4
	mov r1, sp
	mov r2, #2
	bl glue_0180011c
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2070:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r2, #1
	bl sub_1d20
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	ldrb r0, [r0, r4]
	mov r0, r0, lsl #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_20a4:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r2, #1
	bl sub_1d9c
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_018009bc
	tst r0, #0x40
	movne r1, r4
	movne r0, #0xaa
	subne r0, r0, #0xbd00
	blne sub_112c
	ldr r0, [r6]
	ldr r0, [r0]
	tst r0, #3
	moveq r0, r0, asr #2
	beq loc_20fc
	bl glue_018007e8
loc_20fc:
	and r6, r0, #0xff
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	strb r6, [r0, r5]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_2114:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r4, r1
	mov r2, #2
	bl sub_1d20
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r0, r0, r4
	tst r0, #1
	ldreq r0, [r0]
	moveq r0, r0, asr #16
	beq loc_2164
	ldrb r1, [r0, #1]
	ldrb r0, [r0]
	mov r0, r0, lsl #24
	mov r0, r0, asr #24
	add r0, r1, r0, lsl #8
loc_2164:
	mov r0, r0, lsl #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_216c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r2, #2
	bl sub_1d9c
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r5, r0, r6
	ldr r0, [r4]
	ldr r0, [r0]
	tst r0, #3
	moveq r0, r0, asr #2
	beq loc_21b4
	bl glue_018007e8
loc_21b4:
	mov r0, r0, lsl #16
	mov r0, r0, asr #16
	tst r5, #1
	strbeq r0, [r5, #1]
	moveq r0, r0, asr #8
	beq loc_21dc
	mov r1, r0
	strb r1, [r5, #1]
	mov r1, #0xff
	and r0, r1, r0, asr #8
loc_21dc:
	strb r0, [r5]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_21e4:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r2, #4
	bl sub_1d20
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	add r0, r0, r5
	tst r0, #3
	beq loc_223c
	ldrb r1, [r0]
	mov r2, r1, lsl #24
	ldrb r1, [r0, #1]
	add r1, r2, r1, lsl #16
	ldrb r2, [r0, #2]
	add r1, r1, r2, lsl #8
	ldrb r0, [r0, #3]
	add r0, r1, r0
	b loc_2240
loc_223c:
	ldr r0, [r0]
loc_2240:
	ands r1, r0, #0xc0000000
	teqne r1, #0xc0000000
	moveq r0, r0, lsl #2
	ldmdbeq fp, {r4, r5, fp, sp, pc}
	adr r0, str_226c, #30
	mov r2, #0
	mov r1, #0xb1
	sub r1, r1, #0xbd00
	bl glue_01801868
	mov r0, #2
	ldmdb fp, {r4, r5, fp, sp, pc}
str_226c:
	.asciz "evt.ex.frames"
	.align 4

sub_227c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r2, #4
	bl sub_1d20
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r5, r0, r6
	ldr r0, [r4]
	ldr r0, [r0]
	tst r0, #3
	moveq r0, r0, asr #2
	beq loc_22c4
	bl glue_018007e8
loc_22c4:
	tst r5, #3
	streq r0, [r5]
	ldmdbeq fp, {r4, r5, r6, fp, sp, pc}
	mov r1, r0
	strb r1, [r5, #3]
	mov r1, #0xff
	and r2, r1, r0, asr #8
	strb r2, [r5, #2]
	and r1, r1, r0, asr #16
	strb r1, [r5, #1]
	mov r0, r0, lsr #24
	strb r0, [r5]
	ldmdb fp, {r4, r5, r6, fp, sp, pc}

sub_22f8:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r2, #4
	bl sub_1d20
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	add r0, r0, r5
	tst r0, #3
	beq loc_2350
	ldrb r1, [r0]
	mov r1, r1, lsl #24
	ldrb r2, [r0, #1]
	add r2, r1, r2, lsl #16
	ldrb r1, [r0, #2]
	add r1, r2, r1, lsl #8
	ldrb r0, [r0, #3]
	add r0, r1, r0
	b loc_2354
loc_2350:
	ldr r0, [r0]
loc_2354:
	mov r0, r0, lsr #3
	mov r0, r0, lsl #2
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_2360:
	mov ip, sp
	stmdb sp!, {r4, r5, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	sub sp, sp, #4
	mov r0, #2
	bl glue_01800818
	str r0, [sp], #-4
	mov r0, r4
	bl glue_0180017c
	mov r1, #2
	add r5, r1, r0, lsl #1
	bl sub_0d00
	bl glue_01800818
	str r0, [sp]
	mov r0, sp
	mov r1, r5
	bl glue_01800808
	ldr r1, [sp, #4]
	str r0, [r1]
	ldr r0, [sp, #4]
	ldr r0, [r0]
	bl glue_01800828
	mov r1, r0
	mov r0, r4
	mvn r3, #0x80000000
	mov r2, #1
	bl glue_01801a50
	ldr r0, [sp]
	bl glue_01800888
	ldr r0, [sp, #4]
	ldr r4, [r0]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, r5, fp, sp, pc}

sub_23ec:
	mov r0, #0x1000
	ldr r0, [r0, #0x3dc]
	cmp r0, #0x20000
	movlt r0, #0
	blt sub_1f50
	bge glue_01802498
	mov ip, sp
	stmdb sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	mov r2, #1
	bl sub_1d20
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800980
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	mov r6, r0
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800978
	add r0, r0, r6
	add r1, r6, r5
	mov r5, r1
	b loc_245c

sub_2458:
	add r1, r1, #1
loc_245c:
	ldrb r2, [r1]
	teq r2, #0
	beq loc_2470
	cmp r1, r0
	blo sub_2458
loc_2470:
	cmp r1, r0
	blo sub_248c
	adr r0, str_24c0, #30
	mov r2, #0
	mov r1, #0xae
	sub r1, r1, #0xbd00
	bl glue_01801868

sub_248c:
	sub sp, sp, #4
	mov r0, r5
	bl sub_2360
	bl glue_01800818
	str r0, [sp]
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800b3c
	ldr r0, [sp]
	ldr r4, [r0]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, r5, r6, fp, sp, pc}
str_24c0:
	.asciz "evt.ex.frames"
	.align 4

sub_24d0:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r0, r2
	bl glue_01800968
	teq r0, #0
	moveq r1, r4
	moveq r0, #0xee
	subeq r0, r0, #0xbe00
	bleq sub_1200
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800978
	sub r7, r0, #2
	add r7, r7, r7, lsr #31
	mov r7, r7, asr #1
	add r2, r7, #1
	mov r1, r6
	mov r0, r5
	bl sub_1d9c
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800980
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800980
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r6, r0, r6
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	mov r3, r7
	mov r2, #1
	mov r1, r6
	bl glue_01801a4c
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800b3c
	ldr r0, [r4]
	ldr r0, [r0]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, lr}
	b glue_01800b3c

sub_258c:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	mov r5, r1
	ldr r0, [r0]
	ldr r0, [r0]
	bl glue_01800828
	add r0, r0, r5
	ldrb r6, [r0]
	add r2, r6, #1
	mov r7, r2
	mov r1, r5
	mov r0, r4
	bl sub_1d20
	sub sp, sp, #4
	mov r0, #2
	bl glue_01800818
	str r0, [sp], #-4
	bl sub_0d00
	bl glue_01800818
	str r0, [sp]
	mov r0, sp
	mov r1, r7, lsl #1
	bl glue_01800808
	ldr r1, [sp, #4]
	str r0, [r1]
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800980
	ldr r0, [sp, #4]
	ldr r0, [r0]
	bl glue_01800980
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	add r5, r0, r5
	ldr r0, [sp, #4]
	ldr r0, [r0]
	bl glue_01800828
	mov r1, r0
	add r0, r5, #1
	mov r3, r6
	mov r2, #1
	bl glue_01801a50
	ldr r0, [sp, #4]
	ldr r0, [r0]
	bl glue_01800b3c
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800b3c
	ldr r0, [sp]
	bl glue_01800888
	ldr r0, [sp, #4]
	ldr r4, [r0]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}

sub_2674:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r0, r2
	bl glue_01800968
	teq r0, #0
	moveq r1, r4
	moveq r0, #0xee
	subeq r0, r0, #0xbe00
	bleq sub_1200
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800978
	sub r0, r0, #2
	mov r7, r0, lsr #1
	cmp r7, #0xff
	ble sub_26d8
	adr r0, str_2758, #30
	mov r2, #0
	mov r1, #0xad
	sub r1, r1, #0xbd00
	bl glue_01801868

sub_26d8:
	add r2, r7, #1
	mov r1, r5
	mov r0, r6
	bl sub_1d9c
	sub sp, sp, #0x100
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800980
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800828
	mov r1, sp
	mov r3, #0xff
	mov r2, #1
	bl glue_01801a4c
	ldr r0, [r4]
	ldr r0, [r0]
	bl glue_01800b3c
	ldr r0, [r6]
	ldr r0, [r0]
	bl glue_01800828
	add r0, r0, r5
	add r0, r0, #1
	mov r2, r7
	mov r1, sp
	bl glue_0180011c
	and r4, r7, #0xff
	ldr r0, [r6]
	ldr r0, [r0]
	bl glue_01800828
	strb r4, [r0, r5]
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
str_2758:
	.asciz "evt.ex.frames"
	.align 4

sub_2768:
	mov ip, sp
	stmdb sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r5, r0
	mov r6, r1
	mov r4, r2
	mov r7, r3
	cmn r2, #1
	bne loc_279c
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800978
	sub r4, r0, r6
loc_279c:
	ldr r0, [r5]
	ldr r0, [r0]
	tst r0, #1
	beq sub_2804
	bl glue_018009bc
	tst r0, #1
	bne sub_2804
	cmp r6, #0
	blt sub_2804
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800978
	add r1, r6, r4
	cmp r0, r1
	cmpge r4, #0
	blt sub_2804
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800978
	cmp r0, r4
	blt sub_2804
	ldr r0, [r7]
	ldr r0, [r0]
	bl glue_01800970
	teq r0, #0
	bne loc_2818

sub_2804:
	adr r0, str_286c, #30
	mov r2, #0
	mov r1, #0xae
	sub r1, r1, #0xbd00
	bl glue_01801868
loc_2818:
	sub sp, sp, #4
	mov r1, r4
	mov r0, r7
	bl glue_01800808
	bl glue_01800818
	str r0, [sp]
	ldr r0, [r5]
	ldr r0, [r0]
	bl glue_01800828
	add r5, r0, r6
	ldr r0, [sp]
	ldr r0, [r0]
	bl glue_01800828
	mov r2, r4
	mov r1, r5
	bl glue_0180011c
	ldr r0, [sp]
	ldr r4, [r0]
	bl glue_01800888
	mov r0, r4
	ldmdb fp, {r4, r5, r6, r7, fp, sp, pc}
str_286c:
	.asciz "evt.ex.frames"
	.align 4

sub_287c:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r1, [r0]
	ldr r1, [r1]
	and r2, r1, #3
	teq r2, #2
	moveq r3, #3
	andeq r3, r3, r1, asr #2
	teqeq r3, #1
	bne loc_2908
	sub sp, sp, #4
	mov r0, r1
	teq r2, #2
	teqeq r3, #1
	moveq r0, r0, asr #2
	moveq r0, r0, asr #2
	moveq r0, r0, lsl #16
	moveq r0, r0, lsr #16
	beq loc_28d4
	bl glue_018007e4
loc_28d4:
	strb r0, [sp, #1]
	mov r0, r0, asr #8
	strb r0, [sp]
	mov r0, sp
	mov r1, #1
	bl glue_01801e18
	ldr r0, [sp]
	mov r0, r0, lsr #16
	mov r1, #1
	orr r1, r1, r0, lsl #2
	mov r0, #2
	orr r0, r0, r1, lsl #2
	ldmdb fp, {r4, fp, sp, pc}
loc_2908:
	bl glue_01800b14
	ldr r0, [r4]
	ldr r0, [r0]
	ldmdb fp, {r4, fp, sp, pc}

sub_2918:
	mov ip, sp
	stmdb sp!, {r4, fp, ip, lr, pc}
	sub fp, ip, #4
	mov r4, r0
	ldr r1, [r0]
	ldr r1, [r1]
	and r2, r1, #3
	teq r2, #2
	moveq r3, #3
	andeq r3, r3, r1, asr #2
	teqeq r3, #1
	bne loc_29a4
	sub sp, sp, #4
	mov r0, r1
	teq r2, #2
	teqeq r3, #1
	moveq r0, r0, asr #2
	moveq r0, r0, asr #2
	moveq r0, r0, lsl #16
	moveq r0, r0, lsr #16
	beq loc_2970
	bl glue_018007e4
loc_2970:
	strb r0, [sp, #1]
	mov r0, r0, asr #8
	strb r0, [sp]
	mov r0, sp
	mov r1, #1
	bl glue_01801c20
	ldr r0, [sp]
	mov r0, r0, lsr #16
	mov r1, #1
	orr r1, r1, r0, lsl #2
	mov r0, #2
	orr r0, r0, r1, lsl #2
	ldmdb fp, {r4, fp, sp, pc}
loc_29a4:
	bl glue_01800b00
	ldr r0, [r4]
	ldr r0, [r0]
	ldmdb fp, {r4, fp, sp, pc}

sub_29b4:
	mov r1, #0x1000
	ldr r1, [r1, #0x3dc]
	cmp r1, #0x20000
	ldrlt r0, [r0, #0x38]
	ldrlt r0, [r0]
	bge glue_01802734
	mov pc, lr

sub_29d0:
	mov r1, #0x1000
	ldr r1, [r1, #0x3dc]
	cmp r1, #0x20000
	ldrlt r0, [r0, #0x3c]
	ldrlt r0, [r0]
	bge glue_01802738
	mov pc, lr

sub_29ec:
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	mov r5, r1
	mov r4, r2
	mov r7, r3
	sub sp, sp, #0x44
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x40]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x3c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x38]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x34]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x30]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x2c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x28]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x24]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r4]
	str r0, [sp, #4]
	ldr r0, [r5]
	str r0, [sp]
	ldr r0, [r7]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r5, r0
	bl sub_0000
	mov r4, r0
	bl sub_29b4
	ldr r1, [sp, #0x20]
	str r0, [r1]
	mov r0, r4
	bl sub_29d0
	ldr r1, [sp, #0x24]
	str r0, [r1]
	mov r0, r4
	bl sub_0fa4
	movs r8, r0
	mov r0, r7
	beq loc_2b70
	bl glue_01800838
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r0, r4
	bl sub_29b4
	ldr r1, [sp, #0xc]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r4
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_2b8c
loc_2b70:
	bl glue_01800838
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0xc]
	str r0, [r1]
loc_2b8c:
	ldr r1, [r5, #4]
	ldr r0, [sp, #0x10]
	add r3, sp, #0x14
	str r1, [r0]
	add r1, sp, #0x10
	add r0, sp, #0xc
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x10]
	mov r7, #2
	str r0, [r1]
	teq r0, #2
	ldreq r0, [sp, #8]
	streq r7, [r0]
	beq loc_2f4c
	ldr r0, [r5]
	ldr r1, [sp, #0x18]
	add r2, sp, #0x1c
	str r0, [r1]
	add r0, sp, #0x10
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_2c14
	add r2, sp, #0x14
	add r1, sp, #0xc
	mov r0, r4
	bl sub_0fe4
	add r2, sp, #0x1c
	add r1, sp, #0x18
	add r0, sp, #0xc
	mov lr, pc
	mov pc, sb
	b loc_2c40
loc_2c14:
	add r1, sp, #0x18
	mov r0, r4
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x14
	add r2, sp, #0x18
	add r1, sp, #0x10
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_2c40:
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r0, [sp, #8]
	ldr r0, [r0]
	teq r0, #2
	beq loc_2f4c
	ldr r1, [r5, #8]
	ldr r0, [sp, #0x18]
	str r1, [r0]
	add r1, sp, #0x18
	add r0, sp, #8
	bl glue_01800928
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r1, [r5, #0xc]
	ldr r0, [sp, #0x18]
	add r3, sp, #0x1c
	str r1, [r0]
	add r1, sp, #0x18
	add r0, sp, #0x10
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x18]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x18
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_2ce0
	add r2, sp, #0x1c
	add r1, sp, #0x10
	mov r0, r4
	bl sub_0fe4
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x10
	mov lr, pc
	mov pc, sb
	b loc_2d0c
loc_2ce0:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x1c
	add r2, sp, #0x20
	add r1, sp, #0x14
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_2d0c:
	ldr r0, [r5, #0x10]
	ldr r1, [sp, #0x18]
	str r0, [r1]
	add r1, sp, #0x18
	add r0, sp, #8
	bl glue_01800928
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [r5, #0xc]
	ldr r1, [sp, #0x18]
	add r3, sp, #0x28
	str r0, [r1]
	add r1, sp, #0x18
	add r0, sp, #0x10
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x18]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x18
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_2d94
	add r2, sp, #0x28
	add r1, sp, #0x10
	mov r0, r4
	bl sub_0fe4
	add r2, sp, #0x2c
	add r1, sp, #4
	add r0, sp, #0x10
	mov lr, pc
	mov pc, sb
	b loc_2dc0
loc_2d94:
	add r1, sp, #4
	mov r0, r4
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x1c
	add r2, sp, #0x2c
	add r1, sp, #0x14
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_2dc0:
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x18]
	str r0, [r1]
	add r1, sp, #0x18
	add r0, sp, #8
	bl glue_01800928
	ldr r1, [sp, #0x10]
	str r0, [r1]
	mov r1, r0
	teq r1, #2
	ldr r0, [sp, #0x10]
	bne loc_2f4c
	mov r1, #0x1a
	str r1, [r0]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x18]
	add r2, sp, #0x10
	str r0, [r1]
	add r1, sp, #0x18
	add r0, sp, #8
	bl glue_01800a34
	ldr r0, [r5, #0x28]
	ldr r1, [sp, #0x10]
	str r0, [r1]
	add r0, sp, #0x10
	bl sub_1354
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [r5, #0x18]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	add r1, sp, #0x2c
	add r0, sp, #8
	bl glue_01800928
	ldr r1, [sp, #0x18]
	str r0, [r1]
	ldr r0, [r5, #0x1c]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0x24]
	ldr r0, [sp, #0x34]
	str r1, [r0]
	add r0, sp, #0x34
	mov r1, #1
	bl glue_01800804
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r1, [r5, #0x20]!
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	add r1, sp, #0x3c
	add r0, sp, #8
	bl glue_01800928
	ldr r1, [sp, #0x38]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	mov r1, #4
	ldr r0, [sp, #0x34]
	add r2, sp, #0x38
	str r1, [r0]
	add r0, sp, #0x10
	bl sub_154c
	movs r5, r0
	beq loc_2f0c
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x38
	add r2, sp, #0x34
	stmdb sp!, {r2, r3}
	add r3, sp, #0x38
	add r2, sp, #0x34
	add r1, sp, #0x20
	add r0, sp, #0x48
	mov lr, pc
	mov pc, r5
	add sp, sp, #8
	b loc_2f4c
loc_2f0c:
	add r1, sp, #0x18
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x30
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x34
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x10
	mov r0, r4
	mov r2, #4
	bl sub_13ac
loc_2f4c:
	teq r8, #0
	str r7, [r6]
	beq loc_2f68
	add r2, sp, #0x24
	add r1, sp, #0x20
	mov r0, r4
	bl sub_1020
loc_2f68:
	ldr r4, [r6]
	ldr r0, [sp, #0x40]
	bl glue_01800888
	ldr r0, [sp, #0x3c]
	bl glue_01800888
	ldr r0, [sp, #0x38]
	bl glue_01800888
	ldr r0, [sp, #0x34]
	bl glue_01800888
	ldr r0, [sp, #0x30]
	bl glue_01800888
	ldr r0, [sp, #0x2c]
	bl glue_01800888
	ldr r0, [sp, #0x28]
	bl glue_01800888
	ldr r0, [sp, #0x24]
	bl glue_01800888
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}

sub_2ff8:
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov r4, r1
	sub sp, sp, #0x1ac
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1a8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1a4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1a0]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x19c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x198]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x194]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x190]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x188]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xa4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xa0]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x9c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x98]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x94]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x90]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x8c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x88]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x84]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x80]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x7c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x78]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x74]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x70]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x6c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x68]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x64]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x60]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x5c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x58]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x54]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x50]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x4c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x48]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x44]
	mov r0, #0
	str r0, [sp, #0x40]
	str r0, [sp, #0x3c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x38]
	mov r0, #0
	str r0, [sp, #0x34]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x30]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x2c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x28]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x24]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	str r0, [sp]
	bl sub_0000
	str r0, [sp, #0x3c]
	bl sub_29b4
	ldr r1, [sp, #0x44]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	bl sub_29d0
	ldr r1, [sp, #0x48]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	bl sub_0fa4
	str r0, [sp, #0x40]
	teq r0, #0
	mov r0, r4
	beq loc_3320
	bl glue_01800838
	ldr r1, [sp, #0x94]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	bl sub_29b4
	ldr r1, [sp, #0x24]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x94]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp, #0x3c]
	bl sub_29d0
	ldr r1, [sp, #0x1a4]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x94]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
loc_32f4:
	add r0, sp, #0xa8
	add fp, r0, #0xc
	mov r8, #0
	add r1, sp, #0x118
	add sl, r1, #0xc
	add r7, r1, #4
	add r6, r0, #4
	mov sb, #4
	mov r4, #2
	mov r5, #0x1a
	b loc_3358
loc_3320:
	bl glue_01800838
	ldr r1, [sp, #0x94]
	str r0, [r1]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x94]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800920
	ldr r1, [sp, #0x1a4]
	str r0, [r1]
	b loc_32f4
loc_3358:
	ldr r0, [sp]
	ldr r0, [r0, #4]
	ldr r1, [sp, #0x28]
	add r3, sp, #0x2c
	str r0, [r1]
	add r1, sp, #0x28
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x28]
	str r0, [r1]
	teq r0, #2
	ldreq r0, [sp, #0x14]
	streq r4, [r0]
	beq loc_5a6c
	ldr r0, [sp]
	ldr r0, [r0]
	ldr r1, [sp, #0x30]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_33e8
	add r2, sp, #0x2c
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r2, sp, #0x38
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3414
loc_33e8:
	add r1, sp, #0x30
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x2c
	add r2, sp, #0x30
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3414:
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0x14]
	ldr r0, [r0]
	teq r0, #2
	beq loc_5a6c
	ldr r0, [sp, #8]
	str r4, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x28]
	str r0, [r1]
	teq r0, #2
	ldr r1, [sp, #0x28]
	beq loc_3da8
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	teq r0, #2
	ldr r0, [sp]
	beq loc_349c
	ldr r0, [r0, #0xc]
	add r2, sp, #0xc
	str r0, [r1]
	add r1, sp, #0x28
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp, #0xc]
	str r4, [r0]
	b loc_35e0
loc_349c:
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x28]
	str r0, [r1]
	teq r0, #2
	beq loc_35e0
	ldr r0, [sp]
	ldr r0, [r0, #0x18]
	ldr r1, [sp, #0x30]
	add r3, sp, #0x38
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x14]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x4c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x54]
	str r0, [r1]
	add r1, sp, #0x54
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x50]
	add r2, sp, #0x54
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #2
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3580
	add r2, sp, #0x38
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x54
	add r2, sp, #0x50
	add r1, sp, #0x4c
	add r0, sp, #0x24
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_35b8
loc_3580:
	add r1, sp, #0x4c
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x50
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #2
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x3c
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_35b8:
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	ldr r1, [sp, #0x30]
	add r2, sp, #0x28
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x14
	bl glue_01800a34
loc_35e0:
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x28]
	str r0, [r1]
	teq r0, #2
	ldr r0, [sp]
	beq loc_3b48
	ldr r0, [r0, #0x28]
	ldr r1, [sp, #0x50]
	add r3, sp, #0x4c
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x24
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x14]
	ldr r1, [sp, #0x58]
	str r0, [r1]
	add r1, sp, #0x58
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x54]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x5c]
	str r0, [r1]
	add r1, sp, #0x5c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x58]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x64]
	str r0, [r1]
	add r1, sp, #0x64
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x60]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x64]
	add r3, sp, #0x68
	str r0, [r1]
	add r1, sp, #0x64
	add r0, sp, #0x60
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x64]
	add r2, sp, #0x6c
	str r0, [r1]
	add r0, sp, #0x64
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3710
	add r2, sp, #0x68
	add r1, sp, #0x60
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x6c
	add r0, sp, #0x60
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3730
loc_3710:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x68
	add r2, sp, #0x6c
	add r1, sp, #0x64
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3730:
	ldr r1, [sp, #0x5c]
	add r2, sp, #0x60
	str r0, [r1]
	add r0, sp, #0x50
	mov r1, #3
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3788
	add r2, sp, #0x4c
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x60
	stmdb sp!, {r3}
	add r3, sp, #0x60
	add r2, sp, #0x5c
	add r1, sp, #0x58
	add r0, sp, #0x28
	mov lr, pc
	ldr pc, [sp, #0x38]
	b loc_37c8
loc_3788:
	add r1, sp, #0x54
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x58
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x5c
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #3
	stmdb sp!, {r3}
	add r3, sp, #0x54
	add r2, sp, #0x50
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
loc_37c8:
	add sp, sp, #4
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x1c]
	ldr r1, [sp, #0x50]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp, #0x30]
	ldr r0, [r0]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	teq r0, #2
	ldrne r0, [sp, #8]
	strne r5, [r0]
	bne loc_4208
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x50]
	add r3, sp, #0x5c
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x30
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x50]
	add r2, sp, #0x58
	str r0, [r1]
	add r0, sp, #0x50
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_38a4
	add r2, sp, #0x5c
	add r1, sp, #0x30
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x58
	add r0, sp, #0x30
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_38c4
loc_38a4:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x54
	add r2, sp, #0x60
	add r1, sp, #0x34
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_38c4:
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x2c]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x28
	bl sub_1bf8
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4028
	ldr r0, [sp]
	ldr r0, [r0, #0x38]
	ldr r1, [sp, #0x30]
	add r3, sp, #0x28
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_4028
	ldr r0, [sp]
	ldr r0, [r0, #0x30]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x54]
	str r0, [r1]
	add r1, sp, #0x54
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x58]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x64]
	str r0, [r1]
	add r1, sp, #0x64
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x60]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x64]
	add r3, sp, #0x6c
	str r0, [r1]
	add r1, sp, #0x64
	add r0, sp, #0x60
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x64]
	add r2, sp, #0x70
	str r0, [r1]
	add r0, sp, #0x64
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_39ec
	add r2, sp, #0x6c
	add r1, sp, #0x60
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x70
	add r0, sp, #0x60
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3a0c
loc_39ec:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x68
	add r2, sp, #0x70
	add r1, sp, #0x64
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3a0c:
	ldr r1, [sp, #0x54]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x64]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x70]
	add r3, sp, #0x74
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x64
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x70]
	add r2, sp, #0x78
	str r0, [r1]
	add r0, sp, #0x70
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3aa4
	add r2, sp, #0x74
	add r1, sp, #0x64
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x78
	add r0, sp, #0x64
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3ac4
loc_3aa4:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x74
	add r2, sp, #0x78
	add r1, sp, #0x68
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3ac4:
	ldr r1, [sp, #0x60]
	add r2, sp, #0x64
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #4
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3b04
	add r2, sp, #0x28
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x64
	add r2, sp, #0x60
	b loc_3fb4
loc_3b04:
	add r1, sp, #0x50
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x58
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x54
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x60
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #4
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x2c
	b loc_4018
loc_3b48:
	ldr r0, [r0, #0x38]
	ldr r1, [sp, #0x30]
	add r3, sp, #0x60
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_4028
	ldr r0, [sp]
	ldr r0, [r0, #0x3c]
	ldr r1, [sp, #0x54]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x58]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x64]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x70]
	add r3, sp, #0x78
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x64
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x70]
	add r2, sp, #0x7c
	str r0, [r1]
	add r0, sp, #0x70
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3c3c
	add r2, sp, #0x78
	add r1, sp, #0x64
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x7c
	add r0, sp, #0x64
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3c5c
loc_3c3c:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x74
	add r2, sp, #0x7c
	add r1, sp, #0x68
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3c5c:
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x7c]
	str r0, [r1]
	add r1, sp, #0x7c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x7c]
	add r3, sp, #0x80
	str r0, [r1]
	add r1, sp, #0x7c
	add r0, sp, #0x70
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x7c]
	add r2, sp, #0x84
	str r0, [r1]
	add r0, sp, #0x7c
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3cf4
	add r2, sp, #0x80
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x84
	add r0, sp, #0x70
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3d14
loc_3cf4:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x80
	add r2, sp, #0x84
	add r1, sp, #0x74
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3d14:
	ldr r1, [sp, #0x64]
	add r2, sp, #0x70
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #4
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3d64
	add r2, sp, #0x60
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x70
	add r2, sp, #0x64
	stmdb sp!, {r2, r3}
	add r3, sp, #0x58
	add r2, sp, #0x60
	add r1, sp, #0x5c
	b loc_3fc4
loc_3d64:
	add r1, sp, #0x54
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x58
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x50
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x64
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #4
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x64
	b loc_4018
loc_3da8:
	ldr r0, [sp]
	ldr r0, [r0, #0x38]
	ldr r1, [sp, #0x30]
	add r3, sp, #0x64
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_4028
	ldr r0, [sp]
	ldr r0, [r0, #0x40]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x54]
	str r0, [r1]
	add r1, sp, #0x54
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x58]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x7c]
	str r0, [r1]
	add r1, sp, #0x7c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x7c]
	add r3, sp, #0x84
	str r0, [r1]
	add r1, sp, #0x7c
	add r0, sp, #0x70
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x7c]
	add r2, sp, #0x88
	str r0, [r1]
	add r0, sp, #0x7c
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3ea0
	add r2, sp, #0x84
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x88
	add r0, sp, #0x70
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3ec0
loc_3ea0:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x80
	add r2, sp, #0x88
	add r1, sp, #0x74
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3ec0:
	ldr r1, [sp, #0x54]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x88]
	str r0, [r1]
	add r1, sp, #0x88
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x7c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x88]
	add r3, sp, #0x8c
	str r0, [r1]
	add r1, sp, #0x88
	add r0, sp, #0x7c
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x88]
	add r2, sp, #0x90
	str r0, [r1]
	add r0, sp, #0x88
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3f58
	add r2, sp, #0x8c
	add r1, sp, #0x7c
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x90
	add r0, sp, #0x7c
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_3f78
loc_3f58:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x8c
	add r2, sp, #0x90
	add r1, sp, #0x80
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_3f78:
	ldr r1, [sp, #0x70]
	add r2, sp, #0x7c
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #4
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_3fd8
	add r2, sp, #0x64
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x7c
	add r2, sp, #0x70
loc_3fb4:
	stmdb sp!, {r2, r3}
	add r3, sp, #0x5c
	add r2, sp, #0x60
	add r1, sp, #0x58
loc_3fc4:
	add r0, sp, #0x2c
	mov lr, pc
	ldr pc, [sp, #0x3c]
	add sp, sp, #8
	b loc_4028
loc_3fd8:
	add r1, sp, #0x50
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x58
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x54
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #4
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x68
loc_4018:
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_4028:
	ldr r0, [sp, #8]
	ldr r0, [r0]
	teq r0, #2
	bne loc_4208
	ldr r0, [sp, #0x30]
	str r4, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #0x44]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x94
	bl sub_1794
	ldr r0, [sp, #0x30]
	str r4, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x94
	bl sub_1794
	ldr r0, [sp, #0x30]
	str r5, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x4c]
	ldr r1, [sp, #0x70]
	add r3, sp, #0x54
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x30
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x70]
	add r2, sp, #0x58
	str r0, [r1]
	add r0, sp, #0x70
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4140
	add r2, sp, #0x54
	add r1, sp, #0x30
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x58
	add r0, sp, #0x30
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_4160
loc_4140:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x74
	add r2, sp, #0x58
	add r1, sp, #0x34
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_4160:
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x4c]
	ldr r1, [sp, #0x70]
	add r3, sp, #0x58
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x30
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x70]
	add r2, sp, #0x50
	str r0, [r1]
	add r0, sp, #0x70
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_41f0
	add r2, sp, #0x58
	add r1, sp, #0x30
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x50
	add r0, sp, #0x30
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_5310
loc_41f0:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x74
	add r2, sp, #0x5c
	add r1, sp, #0x34
	b loc_5304
loc_4208:
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x50]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x4c]
	ldr r1, [sp, #0x50]
	add r3, sp, #0x7c
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x70
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x50]
	add r2, sp, #0x88
	str r0, [r1]
	add r0, sp, #0x50
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_42dc
	add r2, sp, #0x7c
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x88
	add r0, sp, #0x70
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_42fc
loc_42dc:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x54
	add r2, sp, #0x80
	add r1, sp, #0x74
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_42fc:
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x54]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x4c]
	ldr r1, [sp, #0x50]
	add r3, sp, #0x88
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x70
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x50]
	add r2, sp, #0x90
	str r0, [r1]
	add r0, sp, #0x50
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_43b4
	add r2, sp, #0x88
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x90
	add r0, sp, #0x70
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_43d4
loc_43b4:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x54
	add r2, sp, #0x8c
	add r1, sp, #0x74
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_43d4:
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x58]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	mov r1, r0
	teq r1, #2
	ldr r0, [sp, #0x30]
	beq sub_4838
	str r4, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x5c]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r0, sp, #0x70
	bl glue_01800810
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	ldr r1, [sp, #0x90]
	str r0, [r1]
	add r1, sp, #0x90
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x50]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x70]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp, #0x24]
	ldr r2, [r0]
	ldr r0, [sp, #0x70]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0, #0x44]
	ldr r1, [sp, #0x70]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x94
	bl sub_1794
	ldr r0, [sp]
	ldr r0, [r0, #0x68]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r0, sp, #0x70
	bl sub_1354
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x60]
	ldr r1, [sp, #0x98]
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x90]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x64]
	ldr r1, [sp, #0x98]
	add r3, sp, #0x9c
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x90
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x98]
	str r0, [r1]
	teq r0, #2
	ldreq r0, [sp, #0x18]
	streq r4, [r0]
	beq loc_45d4
	add r2, sp, #0xa0
	add r0, sp, #0x98
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_45ac
	add r2, sp, #0x9c
	add r1, sp, #0x90
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0xa0
	add r0, sp, #0x90
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_45cc
loc_45ac:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x9c
	add r2, sp, #0xa0
	add r1, sp, #0x94
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_45cc:
	ldr r1, [sp, #0x18]
	str r0, [r1]
loc_45d4:
	ldr r0, [sp, #0x18]
	ldr r0, [r0]
	ldr r1, [sp, #0x50]
	add r2, sp, #0x90
	str r0, [r1]
	add r0, sp, #0x70
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4620
	ldr r0, [sp, #0x3c]
	bl sub_0fc8
	add r2, sp, #0x90
	add r1, sp, #0x50
	add r0, sp, #0x94
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_463c
loc_4620:
	add r1, sp, #0x50
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x70
	mov r2, #1
	ldr r0, [sp, #0x3c]
	bl sub_13ac
loc_463c:
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp, #0x30]
	ldr r0, [r0]
	teq r0, #2
	beq sub_4838
	ldr r0, [sp, #0x18]
	ldr r0, [r0]
	bl glue_01800978
	str r0, [sp, #0x34]
	cmp r0, #0
	ble sub_4838
	ldr r0, [sp]
	ldr r0, [r0, #0x6c]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #0
	bl glue_01800804
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	add r0, sp, #0x18
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x30]
	str r0, [r1]
loc_46ac:
	add r0, sp, #0x30
	bl sub_19f8
	str r0, [sp, #0x34]
	teq r0, #0
	bne loc_4738
	ldr r0, [sp, #0x30]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x20]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x70]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x20
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x74]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x70
	bl sub_1ba0
	str r0, [sp, #0x34]
	teq r0, #0
	addne r1, sp, #0x20
	addne r0, sp, #0x1c
	blne glue_018007f4
	add r0, sp, #0x30
	bl sub_19fc
	b loc_46ac
loc_4738:
	add r0, sp, #0x1c
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x30]
	str r0, [r1]
loc_474c:
	add r0, sp, #0x30
	bl sub_19f8
	str r0, [sp, #0x34]
	teq r0, #0
	bne loc_4830
	ldr r0, [sp, #0x30]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x20]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x78]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r0, sp, #0x50
	bl sub_1354
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x60]
	ldr r1, [sp, #0x90]
	str r0, [r1]
	add r1, sp, #0x90
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	add r2, sp, #0x90
	str r0, [r1]
	add r0, sp, #0x50
	mov r1, #2
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_47fc
	ldr r0, [sp, #0x3c]
	bl sub_0fc8
	add r3, sp, #0x90
	add r2, sp, #0x20
	add r1, sp, #0x70
	add r0, sp, #0x94
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_4824
loc_47fc:
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x20
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x50
	mov r2, #2
	ldr r0, [sp, #0x3c]
	bl sub_13ac
loc_4824:
	add r0, sp, #0x30
	bl sub_19fc
	b loc_474c
loc_4830:
	ldr r0, [sp, #0x1c]
	str r4, [r0]

sub_4838:
	ldr r0, [sp]
	ldr r0, [r0, #0x5c]
	ldr r1, [sp, #0x50]
	str r0, [r1]
	add r0, sp, #0x50
	bl glue_01800810
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x1c]
	ldr r1, [sp, #0x90]
	str r0, [r1]
	add r1, sp, #0x90
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x50]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0, #0x44]
	ldr r1, [sp, #0x90]
	str r0, [r1]
	add r1, sp, #0x90
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x70]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x50]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0x50]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x50
	add r0, sp, #0x94
	bl sub_1794
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x50]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x80]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x50
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	ldr r1, [sp, #0x30]
	beq loc_4f50
	ldr r0, [sp]
	ldr r0, [r0, #0x88]
	add r3, sp, #0x50
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_4a98
	ldr r0, [sp]
	ldr r0, [r0, #0x84]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x50]
	ldr r1, [sp, #0x98]
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x90]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x54]
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	add r1, sp, #0xa0
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x98]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x58]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0xa0]
	add r2, sp, #0xa4
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #4
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4a48
	add r2, sp, #0x50
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0xa4
	add r2, sp, #0xa0
	stmdb sp!, {r2, r3}
	add r3, sp, #0xa0
	add r2, sp, #0x98
	add r1, sp, #0x78
	add r0, sp, #0x2c
	mov lr, pc
	ldr pc, [sp, #0x3c]
	add sp, sp, #8
	b loc_4a98
loc_4a48:
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x90
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x98
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0xa0
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #4
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x54
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_4a98:
	ldr r0, [sp]
	ldr r0, [r0, #0x8c]
	ldr r1, [sp, #0x98]
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	ldr r0, [sp, #0x98]
	add r1, sp, #0x98
	str sb, [r0]
	add r0, sp, #0xa0
	bl sub_1c24
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x8c]
	ldr r1, [sp, #0x98]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x14
	bl glue_01800a34
	bl sub_0f10
	str r0, [sp, #0xa8]
	bl sub_1a84
	mov r0, fp
	str r8, [sp, #0xac]
	bl glue_01800040
	teq r0, #0
	bne loc_4c28
	mov r0, r6
	bl glue_01801748
	ldr r0, [sp]
	ldr r0, [r0, #0x94]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r0, sp, #0x30
	bl sub_1354
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	add r1, sp, #0xa0
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x98]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x80]
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x58]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x90]
	add r2, sp, #0x70
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #3
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4be4
	ldr r0, [sp, #0x3c]
	bl sub_0fc8
	add r3, sp, #0x70
	stmdb sp!, {r3}
	add r3, sp, #0x94
	add r2, sp, #0xa4
	add r1, sp, #0x9c
	add r0, sp, #0x98
	mov lr, pc
	ldr pc, [sp, #0x38]
	add sp, sp, #4
	b loc_4c18
loc_4be4:
	add r1, sp, #0x98
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0xa0
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x90
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x30
	mov r2, #3
	ldr r0, [sp, #0x3c]
	bl sub_13ac
loc_4c18:
	bl sub_1c54
	ldr r0, [sp, #0xa8]
	bl sub_181c
	b loc_4d90
loc_4c28:
	bl sub_1c54
	bl sub_23ec
	ldr r0, [sp, #0xa8]
	bl sub_1300
	ldr r0, [sp, #0xa8]
	bl sub_181c
	ldr r0, [sp, #0x10c]
	adr r1, str_4d08, #30
	bl glue_01801860
	teq r0, #0
	beq loc_4d88
	bl sub_0f10
	str r0, [sp, #0x118]
	bl sub_1a84
	mov r0, sl
	str r8, [sp, #0x11c]
	bl glue_01800040
	teq r0, #0
	bne loc_4d4c
	mov r0, r7
	bl glue_01801748
	ldr r0, [sp]
	ldr r0, [r0, #0x9c]
	ldr r1, [sp, #0x30]
	add r3, sp, #0x90
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_4d3c
	add r0, sp, #0xa8
	str r0, [sp, #0x34]
	bl sub_12d8
	ldr r1, [sp, #0xa0]
	add r2, sp, #0x98
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4d10
	add r2, sp, #0x90
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r2, sp, #0x98
	add r1, sp, #0xa0
	add r0, sp, #0x24
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_4d3c
str_4d08:
	.asciz "evt.ex"
	.align 4
loc_4d10:
	add r1, sp, #0xa0
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x94
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_4d3c:
	bl sub_1c54
	ldr r0, [sp, #0x118]
	bl sub_181c
	b loc_4d7c
loc_4d4c:
	bl sub_1c54
	bl sub_23ec
	ldr r0, [sp, #0x118]
	bl sub_1300
	ldr r0, [sp, #0x118]
	bl sub_181c
	ldr r0, [sp, #0x17c]
	adr r1, str_4d08, #30
	bl glue_01801860
	teq r0, #0
	moveq r0, r7
	bleq glue_01801820
loc_4d7c:
	mov r0, r7
	bl glue_01801784
	b loc_4d90
loc_4d88:
	mov r0, r6
	bl glue_01801820
loc_4d90:
	mov r0, r6
	bl glue_01801784
	ldr r0, [sp]
	ldr r0, [r0, #0x8c]
	ldr r1, [sp, #0x98]
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	ldr r0, [sp, #0x98]
	add r1, sp, #0x98
	str sb, [r0]
	add r0, sp, #0xa0
	bl sub_1c68
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x8c]
	ldr r1, [sp, #0x98]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x98
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x88]
	ldr r1, [sp, #0x30]
	add r3, sp, #0x98
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_4f50
	ldr r0, [sp]
	ldr r0, [r0, #0xa0]
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x50]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x54]
	ldr r1, [sp, #0x188]
	str r0, [r1]
	add r1, sp, #0x188
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x58]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x188]
	add r2, sp, #0x18c
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #4
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_4f00
	add r2, sp, #0x98
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x18c
	add r2, sp, #0x188
	stmdb sp!, {r2, r3}
	add r3, sp, #0xac
	add r2, sp, #0x78
	add r1, sp, #0xa8
	add r0, sp, #0x2c
	mov lr, pc
	ldr pc, [sp, #0x3c]
	add sp, sp, #8
	b loc_4f50
loc_4f00:
	add r1, sp, #0xa0
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0xa4
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x188
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #4
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x9c
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_4f50:
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x188]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xa4]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x188
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_5090
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x188]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xa4]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x188
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x188]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x188
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0x50]
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x188]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x70]
	str r0, [r1]
	add r1, sp, #0x70
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x188
	bl sub_1bf8
	str r0, [sp, #0x34]
	teq r0, #0
	ldr r0, [sp, #0x30]
	streq r4, [r0]
	strne r5, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0xa4]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0xa4
	add r0, sp, #0x14
	bl glue_01800a34
loc_5090:
	ldr r0, [sp]
	ldr r0, [r0, #0x88]
	ldr r1, [sp, #0x30]
	add r3, sp, #0xa4
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_5310
	ldr r0, [sp]
	ldr r0, [r0, #0xa4]
	ldr r1, [sp, #0x188]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	add r1, sp, #0xa0
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x190]
	str r0, [r1]
	add r1, sp, #0x190
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x190]
	add r3, sp, #0x194
	str r0, [r1]
	add r1, sp, #0x190
	add r0, sp, #0x18c
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x190]
	add r2, sp, #0x198
	str r0, [r1]
	add r0, sp, #0x190
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_5188
	add r2, sp, #0x194
	add r1, sp, #0x18c
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x198
	add r0, sp, #0x18c
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_51a8
loc_5188:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x194
	add r2, sp, #0x198
	add r1, sp, #0x190
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_51a8:
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x198]
	str r0, [r1]
	add r1, sp, #0x198
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x190]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x24]
	ldr r1, [sp, #0x198]
	add r3, sp, #0x19c
	str r0, [r1]
	add r1, sp, #0x198
	add r0, sp, #0x190
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x198]
	add r2, sp, #0x1a0
	str r0, [r1]
	add r0, sp, #0x198
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_5240
	add r2, sp, #0x19c
	add r1, sp, #0x190
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x1a0
	add r0, sp, #0x190
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_5260
loc_5240:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x19c
	add r2, sp, #0x1a0
	add r1, sp, #0x194
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_5260:
	ldr r1, [sp, #0x18c]
	add r2, sp, #0x190
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #4
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_52c0
	add r2, sp, #0xa4
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x190
	add r2, sp, #0x18c
	stmdb sp!, {r2, r3}
	add r3, sp, #0xa8
	add r2, sp, #0x78
	add r1, sp, #0x190
	add r0, sp, #0x2c
	mov lr, pc
	ldr pc, [sp, #0x3c]
	add sp, sp, #8
	b loc_5310
loc_52c0:
	add r1, sp, #0x188
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0xa0
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x18c
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #4
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0xa8
	add r1, sp, #0x28
loc_5304:
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_5310:
	ldr r0, [sp]
	ldr r0, [r0, #0xa8]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	bne loc_5368
	ldr r0, [sp]
	ldr r0, [r0, #0xac]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_57e4
loc_5368:
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_57e4
	ldr r0, [sp]
	ldr r0, [r0, #0x18]
	ldr r1, [sp, #0x18c]
	add r3, sp, #0xa0
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x24
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x14]
	ldr r1, [sp, #0x188]
	str r0, [r1]
	add r1, sp, #0x188
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x70]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r1, [sp, #0x190]
	str r0, [r1]
	add r1, sp, #0x190
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x188]
	add r2, sp, #0x190
	str r0, [r1]
	add r0, sp, #0x18c
	mov r1, #2
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_5450
	add r2, sp, #0xa0
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r3, sp, #0x190
	add r2, sp, #0x188
	add r1, sp, #0x70
	add r0, sp, #0x24
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_5488
loc_5450:
	add r1, sp, #0x70
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x188
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	mov r3, #2
	stmdb sp!, {r3}
	add r3, sp, #0x190
	add r2, sp, #0xa4
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_5488:
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_57e4
	ldr r0, [sp]
	ldr r0, [r0, #0xac]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_5500
	ldr r0, [sp]
	ldr r0, [r0, #0xb0]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0xc
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	bne loc_550c
loc_5500:
	ldr r0, [sp, #0x10]
	str r4, [r0]
	b loc_5514
loc_550c:
	ldr r0, [sp, #0x10]
	str r5, [r0]
loc_5514:
	ldr r0, [sp]
	ldr r0, [r0, #0xa8]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_57e4
	ldr r0, [sp]
	ldr r0, [r0, #0xb0]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0xc
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_57e4
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xb4]
	ldr r1, [sp, #0x18c]
	add r3, sp, #0x188
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x30
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x18c]
	add r2, sp, #0x70
	str r0, [r1]
	add r0, sp, #0x18c
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_55fc
	add r2, sp, #0x188
	add r1, sp, #0x30
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x70
	add r0, sp, #0x30
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_561c
loc_55fc:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x190
	add r2, sp, #0x18c
	add r1, sp, #0x34
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_561c:
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xb4]
	ldr r1, [sp, #0x18c]
	add r3, sp, #0x70
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x30
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x18c]
	add r2, sp, #0x190
	str r0, [r1]
	add r0, sp, #0x18c
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_56ac
	add r2, sp, #0x70
	add r1, sp, #0x30
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x190
	add r0, sp, #0x30
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_56cc
loc_56ac:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x190
	add r2, sp, #0x74
	add r1, sp, #0x34
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_56cc:
	ldr r0, [sp]
	ldr r0, [r0, #0xbc]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r0, sp, #0x30
	bl sub_1354
	ldr r1, [sp, #0x30]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xb8]
	ldr r1, [sp, #0x190]
	add r3, sp, #0x1a4
	add r2, sp, #0x24
	str r0, [r1]
	add r1, sp, #0x94
	add r0, sp, #0x190
	bl sub_1854
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x6c]
	ldr r1, [sp, #0x198]
	str r0, [r1]
	add r0, sp, #0x198
	mov r1, #1
	bl glue_01800804
	ldr r1, [sp, #0x198]
	str r0, [r1]
	ldr r1, [sp, #0x190]
	str r0, [r1]
	ldr r0, [sp, #0x14]
	ldr r2, [r0]
	ldr r0, [sp, #0x198]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp, #0x198]
	add r2, sp, #0x1a0
	str sb, [r0]
	add r0, sp, #0x30
	mov r1, #3
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_57b0
	ldr r0, [sp, #0x3c]
	bl sub_0fc8
	add r3, sp, #0x1a0
	stmdb sp!, {r3}
	add r3, sp, #0x19c
	add r2, sp, #0x194
	add r1, sp, #0x190
	add r0, sp, #0x98
	mov lr, pc
	ldr pc, [sp, #0x38]
	add sp, sp, #4
	b loc_57e4
loc_57b0:
	add r1, sp, #0x18c
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x190
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x198
	ldr r0, [sp, #0x3c]
	bl sub_12f8
	add r1, sp, #0x30
	mov r2, #3
	ldr r0, [sp, #0x3c]
	bl sub_13ac
loc_57e4:
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x18c]
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x190]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xc4]
	ldr r1, [sp, #0x18c]
	add r3, sp, #0x1a0
	str r0, [r1]
	add r1, sp, #0x18c
	add r0, sp, #0x190
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x18c]
	add r2, sp, #0x1a8
	str r0, [r1]
	add r0, sp, #0x18c
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_5874
	add r2, sp, #0x1a0
	add r1, sp, #0x190
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x1a8
	add r0, sp, #0x190
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_5894
loc_5874:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x190
	add r2, sp, #0x1a4
	add r1, sp, #0x194
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_5894:
	ldr r1, [sp, #0x198]
	str r0, [r1]
	ldr r0, [sp, #0x198]
	ldr r0, [r0]
	teq r0, #2
	ldr r0, [sp, #0x30]
	strne r4, [r0]
	streq r5, [r0]
	ldr r0, [sp]
	ldr r0, [r0, #0xc0]
	ldr r1, [sp, #0x198]
	add r2, sp, #0x30
	str r0, [r1]
	add r1, sp, #0x198
	add r0, sp, #0x14
	bl glue_01800a34
	ldr r0, [sp]
	ldr r0, [r0, #0xc0]
	ldr r1, [sp, #0x198]
	str r0, [r1]
	add r1, sp, #0x198
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_597c
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0x198]
	str r0, [r1]
	add r1, sp, #0x198
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	beq loc_597c
	ldr r0, [sp]
	ldr r0, [r0, #0x48]
	ldr r1, [sp, #0x190]
	str r0, [r1]
	add r1, sp, #0x190
	add r0, sp, #0x94
	bl sub_171c
	ldr r1, [sp, #0x198]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xc8]
	ldr r1, [sp, #0x190]
	str r0, [r1]
	add r1, sp, #0x190
	add r0, sp, #0x198
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	bne loc_3358
loc_597c:
	ldr r0, [sp]
	ldr r0, [r0, #0xc0]
	ldr r1, [sp, #0x198]
	str r0, [r1]
	add r1, sp, #0x198
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x30]
	str r0, [r1]
	mov r1, r0
	teq r1, #2
	ldr r0, [sp, #0x30]
	beq loc_59d4
	ldr r1, [sp]
	ldr r1, [r1, #0xcc]
	str r1, [r0]
	add r1, sp, #0x30
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #4]
	str r0, [r1]
	b loc_5a74
loc_59d4:
	ldr r1, [sp, #0x10]
	ldr r1, [r1]
	teq r1, #2
	beq loc_5a6c
	ldr r1, [sp]
	ldr r1, [r1, #0xd0]
	add r3, sp, #0x198
	str r1, [r0]
	add r1, sp, #0x30
	add r0, sp, #0x24
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x30]
	add r2, sp, #0x190
	str r0, [r1]
	add r0, sp, #0x30
	mov r1, #0
	bl sub_154c
	str r0, [sp, #0x34]
	teq r0, #0
	beq loc_5a4c
	add r2, sp, #0x198
	add r1, sp, #0x24
	ldr r0, [sp, #0x3c]
	bl sub_0fe4
	add r1, sp, #0x190
	add r0, sp, #0x24
	mov lr, pc
	ldr pc, [sp, #0x34]
	b loc_5a6c
loc_5a4c:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x19c
	add r1, sp, #0x28
	ldr r0, [sp, #0x40]
	bl sub_150c
	add sp, sp, #4
loc_5a6c:
	ldr r0, [sp, #4]
	str r4, [r0]
loc_5a74:
	ldr r0, [sp, #0x40]
	teq r0, #0
	beq loc_5a90
	add r2, sp, #0x48
	add r1, sp, #0x44
	ldr r0, [sp, #0x3c]
	bl sub_1020
loc_5a90:
	ldr r0, [sp, #4]
	ldr r4, [r0]
	ldr r0, [sp, #0x1a8]
	bl glue_01800888
	ldr r0, [sp, #0x1a4]
	bl glue_01800888
	ldr r0, [sp, #0x1a0]
	bl glue_01800888
	ldr r0, [sp, #0x19c]
	bl glue_01800888
	ldr r0, [sp, #0x198]
	bl glue_01800888
	ldr r0, [sp, #0x194]
	bl glue_01800888
	ldr r0, [sp, #0x190]
	bl glue_01800888
	ldr r0, [sp, #0x18c]
	bl glue_01800888
	ldr r0, [sp, #0x188]
	bl glue_01800888
	ldr r0, [sp, #0xa4]
	bl glue_01800888
	ldr r0, [sp, #0xa0]
	bl glue_01800888
	ldr r0, [sp, #0x9c]
	bl glue_01800888
	ldr r0, [sp, #0x98]
	bl glue_01800888
	ldr r0, [sp, #0x94]
	bl glue_01800888
	ldr r0, [sp, #0x90]
	bl glue_01800888
	ldr r0, [sp, #0x8c]
	bl glue_01800888
	ldr r0, [sp, #0x88]
	bl glue_01800888
	ldr r0, [sp, #0x84]
	bl glue_01800888
	ldr r0, [sp, #0x80]
	bl glue_01800888
	ldr r0, [sp, #0x7c]
	bl glue_01800888
	ldr r0, [sp, #0x78]
	bl glue_01800888
	ldr r0, [sp, #0x74]
	bl glue_01800888
	ldr r0, [sp, #0x70]
	bl glue_01800888
	ldr r0, [sp, #0x6c]
	bl glue_01800888
	ldr r0, [sp, #0x68]
	bl glue_01800888
	ldr r0, [sp, #0x64]
	bl glue_01800888
	ldr r0, [sp, #0x60]
	bl glue_01800888
	ldr r0, [sp, #0x5c]
	bl glue_01800888
	ldr r0, [sp, #0x58]
	bl glue_01800888
	ldr r0, [sp, #0x54]
	bl glue_01800888
	ldr r0, [sp, #0x50]
	bl glue_01800888
	ldr r0, [sp, #0x4c]
	bl glue_01800888
	ldr r0, [sp, #0x48]
	bl glue_01800888
	ldr r0, [sp, #0x44]
	bl glue_01800888
	ldr r0, [sp, #0x38]
	bl glue_01800888
	ldr r0, [sp, #0x30]
	bl glue_01800888
	ldr r0, [sp, #0x2c]
	bl glue_01800888
	ldr r0, [sp, #0x28]
	bl glue_01800888
	ldr r0, [sp, #0x24]
	bl glue_01800888
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x1ac
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00002041			; andeq r2, r0, r1, asr #32
	.word 0x00000000
	.word 0x0121b7c9
	.word 0x0123af31
	.word 0x0123b559
	.word 0x01238a01
	.word 0x0123b559
	.word 0x0123af31
	.word 0x00003443			; andeq r3, r0, r3, asr #8
	.word 0x00000000
	.word 0x0123b521
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x0123b571
	.word 0x0123b599
	.word 0x0123b5c1
	.word 0x0123b5e9
	.word 0x0123b611
	.word 0x0123b651
	.word 0x02ca4b28			; sbceq r4, sl, #40, #22
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x0123b691
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00001a40			; andeq r1, r0, r0, asr #20
	.word 0x00000000
	.word 0x01227cd1
	.word 0x005a0065			; subseq r0, sl, r5, rrx
	.word 0x0072006f			; rsbseq r0, r2, pc, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b87c
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00460069			; subeq r0, r6, sb, rrx
	.word 0x00720073			; rsbseq r0, r2, r3, ror r0
	.word 0x00740000			; rsbseq r0, r4, r0
	.word 0x00001a40			; andeq r1, r0, r0, asr #20
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00530065			; subseq r0, r3, r5, rrx
	.word 0x0063006f			; rsbeq r0, r3, pc, rrx
	.word 0x006e0064			; rsbeq r0, lr, r4, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b844
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540068			; subseq r0, r4, r8, rrx
	.word 0x00690072			; rsbeq r0, sb, r2, ror r0
	.word 0x00640000			; rsbeq r0, r4, r0
	.word 0x00001a40			; andeq r1, r0, r0, asr #20
	.word 0x00000000
	.word 0x01227cd1
	.word 0x0046006f			; subeq r0, r6, pc, rrx
	.word 0x00750072			; rsbseq r0, r5, r2, ror r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b80c
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00460069			; subeq r0, r6, sb, rrx
	.word 0x00660074			; rsbeq r0, r6, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00530069			; subseq r0, r3, sb, rrx
	.word 0x00780074			; rsbseq r0, r8, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00001c40			; andeq r1, r0, r0, asr #24
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00530065			; subseq r0, r3, r5, rrx
	.word 0x00760065			; rsbseq r0, r6, r5, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b7bc
	.word 0x00001a40			; andeq r1, r0, r0, asr #20
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00450069			; subeq r0, r5, sb, rrx
	.word 0x00670068			; rsbeq r0, r7, r8, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b79c
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x004e0069			; subeq r0, lr, sb, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540065			; subseq r0, r4, r5, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00001e40			; andeq r1, r0, r0, asr #28
	.word 0x00000000
	.word 0x01227cd1
	.word 0x0045006c			; subeq r0, r5, ip, rrx
	.word 0x00650076			; rsbeq r0, r5, r6, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001c40			; andeq r1, r0, r0, asr #24
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006c			; rsbeq r0, r5, ip, rrx
	.word 0x00660074			; rsbeq r0, r6, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b72c
	.word 0x00002240			; andeq r2, r0, r0, asr #4
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540068			; subseq r0, r4, r8, rrx
	.word 0x00690072			; rsbeq r0, sb, r2, ror r0
	.word 0x00740065			; rsbseq r0, r4, r5, rrx
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b704
	.word 0x00002240			; andeq r2, r0, r0, asr #4
	.word 0x00000000
	.word 0x01227cd1
	.word 0x0046006f			; subeq r0, r6, pc, rrx
	.word 0x00750072			; rsbseq r0, r5, r2, ror r0
	.word 0x00740065			; rsbseq r0, r4, r5, rrx
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b6dc
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00460069			; subeq r0, r6, sb, rrx
	.word 0x00660074			; rsbeq r0, r6, r4, ror r0
	.word 0x00650065			; rsbeq r0, r5, r5, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00530069			; subseq r0, r3, sb, rrx
	.word 0x00780074			; rsbseq r0, r8, r4, ror r0
	.word 0x00650065			; rsbeq r0, r5, r5, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00002440			; andeq r2, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00530065			; subseq r0, r3, r5, rrx
	.word 0x00760065			; rsbseq r0, r6, r5, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00650065			; rsbeq r0, r5, r5, rrx
	.word 0x006e0074			; rsbeq r0, lr, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b674
	.word 0x00002240			; andeq r2, r0, r0, asr #4
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00450069			; subeq r0, r5, sb, rrx
	.word 0x00670068			; rsbeq r0, r7, r8, rrx
	.word 0x00740065			; rsbseq r0, r4, r5, rrx
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b64c
	.word 0x00002240			; andeq r2, r0, r0, asr #4
	.word 0x00000000
	.word 0x01227cd1
	.word 0x004e0069			; subeq r0, lr, sb, rrx
	.word 0x006e0065			; rsbeq r0, lr, r5, rrx
	.word 0x00740065			; rsbseq r0, r4, r5, rrx
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114b624
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740069			; rsbseq r0, r4, sb, rrx
	.word 0x00650074			; rsbeq r0, r5, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00002640			; andeq r2, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740079			; rsbseq r0, r4, sb, ror r0
	.word 0x002d0066			; eoreq r0, sp, r6, rrx
	.word 0x00690072			; rsbeq r0, sb, r2, ror r0
	.word 0x00730074			; rsbseq r0, r3, r4, ror r0
	.word 0x0000baba
	.word 0x00002840			; andeq r2, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740079			; rsbseq r0, r4, sb, ror r0
	.word 0x002d0073			; eoreq r0, sp, r3, ror r0
	.word 0x00650063			; rsbeq r0, r5, r3, rrx
	.word 0x006f006e			; rsbeq r0, pc, lr, rrx
	.word 0x00640000			; rsbeq r0, r4, r0
	.word 0x00002640			; andeq r2, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740079			; rsbseq r0, r4, sb, ror r0
	.word 0x002d0074			; eoreq r0, sp, r4, ror r0
	.word 0x00680069			; rsbeq r0, r8, sb, rrx
	.word 0x00720064			; rsbseq r0, r2, r4, rrx
	.word 0x0000baba
	.word 0x00002840			; andeq r2, r0, r0, asr #16
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740079			; rsbseq r0, r4, sb, ror r0
	.word 0x002d0066			; eoreq r0, sp, r6, rrx
	.word 0x006f0075			; rsbeq r0, pc, r5, ror r0
	.word 0x00720074			; rsbseq r0, r2, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0x00002640			; andeq r2, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740079			; rsbseq r0, r4, sb, ror r0
	.word 0x002d0066			; eoreq r0, sp, r6, rrx
	.word 0x00690066			; rsbeq r0, sb, r6, rrx
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00002640			; andeq r2, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00540077			; subseq r0, r4, r7, ror r0
	.word 0x0065006e			; rsbeq r0, r5, lr, rrx
	.word 0x00740079			; rsbseq r0, r4, sb, ror r0
	.word 0x002d0073			; eoreq r0, sp, r3, ror r0
	.word 0x00690078			; rsbeq r0, sb, r8, ror r0
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x01000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010001			; andeq r0, r1, r1
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x0023b819			; eoreq fp, r3, sb, lsl r8
	.word 0x0123b839
	.word 0x0123b859
	.word 0x0123b881
	.word 0x0123b8a9
	.word 0x0123b8c9
	.word 0x0123b8e9
	.word 0x0123b911
	.word 0x0123b939
	.word 0x0123b961
	.word 0x0123b981
	.word 0x0123b9a9
	.word 0x0123b9d1
	.word 0x0123b9f9
	.word 0x0123ba21
	.word 0x0123ba49
	.word 0x0123ba71
	.word 0x0123baa1
	.word 0x0123bac9
	.word 0x0123baf1
	.word 0x0123bb11
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00300074			; eorseq r0, r0, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b3a4
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310073			; eorseq r0, r1, r3, ror r0
	.word 0x00740000			; rsbseq r0, r4, r0
	.word 0xbabababa			; blt -0x114b38c
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x0032006e			; eorseq r0, r2, lr, rrx
	.word 0x00640000			; rsbeq r0, r4, r0
	.word 0xbabababa			; blt -0x114b374
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00330072			; eorseq r0, r3, r2, ror r0
	.word 0x00640000			; rsbeq r0, r4, r0
	.word 0xbabababa			; blt -0x114b35c
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00340074			; eorseq r0, r4, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b344
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00350074			; eorseq r0, r5, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b32c
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00360074			; eorseq r0, r6, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b314
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00370074			; eorseq r0, r7, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b2fc
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00380074			; eorseq r0, r8, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b2e4
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00390074			; eorseq r0, sb, r4, ror r0
	.word 0x00680000			; rsbeq r0, r8, r0
	.word 0xbabababa			; blt -0x114b2cc
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310030			; eorseq r0, r1, r0, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310031			; eorseq r0, r1, r1, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310032			; eorseq r0, r1, r2, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310033			; eorseq r0, r1, r3, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310034			; eorseq r0, r1, r4, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310035			; eorseq r0, r1, r5, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310036			; eorseq r0, r1, r6, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310037			; eorseq r0, r1, r7, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310038			; eorseq r0, r1, r8, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00310039			; eorseq r0, r1, sb, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320030			; eorseq r0, r2, r0, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320031			; eorseq r0, r2, r1, lsr r0
	.word 0x00730074			; rsbseq r0, r3, r4, ror r0
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320032			; eorseq r0, r2, r2, lsr r0
	.word 0x006e0064			; rsbeq r0, lr, r4, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320033			; eorseq r0, r2, r3, lsr r0
	.word 0x00720064			; rsbseq r0, r2, r4, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320034			; eorseq r0, r2, r4, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320035			; eorseq r0, r2, r5, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320036			; eorseq r0, r2, r6, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320037			; eorseq r0, r2, r7, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320038			; eorseq r0, r2, r8, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00320039			; eorseq r0, r2, sb, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00330030			; eorseq r0, r3, r0, lsr r0
	.word 0x00740068			; rsbseq r0, r4, r8, rrx
	.word 0x0000baba
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00330031			; eorseq r0, r3, r1, lsr r0
	.word 0x00730074			; rsbseq r0, r3, r4, ror r0
	.word 0x0000baba
	.word 0x00008c41			; andeq r8, r0, r1, asr #24
	.word 0x00000000
	.word 0x0121b7c9
	.word 0x0123bbc9
	.word 0x0123bbe1
	.word 0x0123bbf9
	.word 0x0123bc11
	.word 0x0123bc29
	.word 0x0123bc41
	.word 0x0123bc59
	.word 0x0123bc71
	.word 0x0123bc89
	.word 0x0123bca1
	.word 0x0123bcb9
	.word 0x0123bcd1
	.word 0x0123bce9
	.word 0x0123bd01
	.word 0x0123bd19
	.word 0x0123bd31
	.word 0x0123bd49
	.word 0x0123bd61
	.word 0x0123bd79
	.word 0x0123bd91
	.word 0x0123bda9
	.word 0x0123bdc1
	.word 0x0123bdd9
	.word 0x0123bdf1
	.word 0x0123be09
	.word 0x0123be21
	.word 0x0123be39
	.word 0x0123be51
	.word 0x0123be69
	.word 0x0123be81
	.word 0x0123be99
	.word 0x0123beb1
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00001540			; andeq r1, r0, r0, asr #10
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x3564dfbf			; strblo sp, [r4, #-0xfbf]!
	.asciz "Intl"
	.byte 0xba, 0xba, 0xba
	.word 0x00024c40			; andeq r4, r2, r0, asr #24
	.word 0x00000000
	.word 0x0123bf59
	.word 0x80000000			; andhi r0, r0, r0
	.word 0x00100110			; andseq r0, r0, r0, lsl r1
	.word 0x011201a4			; tsteq r2, r4, lsr #3
	.word 0x00060240			; andeq r0, r6, r0, asr #4
	.word 0x0a000000			; beq 0x6524
	.word 0x00000000
	.word 0x000a0000			; andeq r0, sl, r0
	.word 0x000b0000			; andeq r0, fp, r0
	.space 16
	.word 0x0a000000			; beq 0x6544
	.word 0x06070005			; streq r0, [r7], -r5
	.word 0x00000000
	.word 0x08040900			; stmdaeq r4, {r8, fp}
	.word 0x03030303
	.word 0x03030303
	.word 0x03030000
	.word 0x00000000
	.word 0x00020202			; andeq r0, r2, r2, lsl #4
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020200			; andeq r0, r2, #0, #4
	.word 0x00000000
	.word 0x00020202			; andeq r0, r2, r2, lsl #4
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020200			; andeq r0, r2, #0, #4
	.word 0x00000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x00000606			; andeq r0, r0, r6, lsl #12
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x00000000
	.word 0x00000202			; andeq r0, r0, r2, lsl #4
	.word 0x00000000
	.word 0x06000000			; streq r0, [r0], -r0
	.word 0x00000000
	.word 0x00000202			; andeq r0, r0, r2, lsl #4
	.word 0x00000000
	.word 0x00000000
	.word 0x00000102			; andeq r0, r0, r2, lsl #2
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x00000000
	.word 0x01293a70
	.word 0x00000000
	.word 0x00001800			; andeq r1, r0, r0, lsl #16
	.word 0x012a0010
	.word 0x07020202			; streq r0, [r2, -r2, lsl #4]
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x01261eb0
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x02020202			; andeq r0, r2, #0x20000000
	.word 0x00000000
	.word 0x001a0026			; andseq r0, sl, r6, lsr #32
	.word 0x0032003e			; eorseq r0, r2, lr, lsr r0
	.word 0x004a0056			; subeq r0, sl, r6, asr r0
	.word 0x0062006e			; rsbeq r0, r2, lr, rrx
	.word 0x007a0086			; rsbseq r0, sl, r6, lsl #1
	.word 0x00000000
	.word 0x8c928486			; ldchi p4, c8, [r2], {134}
	.word 0x888a8c8e			; stmiahi sl, {r1, r2, r3, r7, sl, fp, pc}
	.word 0x8e8a9090			; mcrhi p0, #4, sb, c10, c0, #4
	.word 0x00948486			; addseq r8, r4, r6, lsl #9
	.word 0x08080000
	.word 0x00080000			; andeq r0, r8, r0
	.word 0x00948486			; addseq r8, r4, r6, lsl #9
	.word 0x000e8000			; andeq r8, lr, r0
	.word 0x0e8e0000			; cdpeq p0, #8, c0, c14, c0, #0
	.word 0x00948400			; addseq r8, r4, r0, lsl #8
	.word 0x00000000
	.word 0x00000000
	.word 0x00948486			; addseq r8, r4, r6, lsl #9
	.word 0x00000000
	.word 0x00000000
	.word 0x00940000			; addseq r0, r4, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x00940086			; addseq r0, r4, r6, lsl #1
	.word 0x00000000
	.word 0x00000000
	.word 0x00100000			; andseq r0, r0, r0
	.word 0x00000000
	.word 0x00009080			; andeq sb, r0, r0, lsl #1
	.word 0x8c928486			; ldchi p4, c8, [r2], {134}
	.word 0x888a8c8e			; stmiahi sl, {r1, r2, r3, r7, sl, fp, pc}
	.word 0x8e8a9000			; cdphi p0, #8, c9, c10, c0, #0
	.word 0x8c948486			; ldchi p4, c8, [r4], {134}
	.word 0x888a8c8e			; stmiahi sl, {r1, r2, r3, r7, sl, fp, pc}
	.word 0x8e8a0000			; cdphi p0, #8, c0, c10, c0, #0
	.word 0x00000018			; andeq r0, r0, r8, lsl r0
	.word 0x00240030			; eoreq r0, r4, r0, lsr r0
	.word 0x003c0048			; eorseq r0, ip, r8, asr #32
	.word 0x00540060			; subseq r0, r4, r0, rrx
	.word 0x006c0078			; rsbeq r0, ip, r8, ror r0
	.word 0x00840090			; umulleq r0, r4, r0, r0
	.word 0x88828486			; stmiahi r2, {r1, r2, r7, sl, pc}
	.word 0x88888a88			; stmiahi r8, {r3, r7, sb, fp, pc}
	.word 0x888a8c94			; stmiahi sl, {r2, r4, r7, sl, fp, pc}
	.word 0x80908486			; addshi r8, r0, r6, lsl #9
	.word 0x8e8e8080			; cdphi p0, #8, c8, c14, c0, #4
	.word 0x808e8080			; addhi r8, lr, r0, lsl #1
	.word 0x80908486			; addshi r8, r0, r6, lsl #9
	.word 0x80928088			; addshi r8, r2, r8, lsl #1
	.word 0x92928080			; addsls r8, r2, #0x80
	.word 0x80908080			; addshi r8, r0, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80908086			; addshi r8, r0, r6, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80968080			; addshi r8, r6, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80808c94			; umullhi r8, r0, r4, ip
	.word 0x00008400			; andeq r8, r0, r0, lsl #8
	.word 0x00000000
	.word 0x00000000
	.word 0x88908486			; ldmiahi r0, {r1, r2, r7, sl, pc}
	.word 0x88888a88			; stmiahi r8, {r3, r7, sb, fp, pc}
	.word 0x888a8080			; stmiahi sl, {r7, pc}
	.word 0x00000086			; andeq r0, r0, r6, lsl #1
	.word 0x00000000
	.word 0x00000000
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x00160000			; andseq r0, r6, r0
	.word 0x00000000
	.word 0x00008c94
	.word 0xbabababa			; blt -0x114adc4
	.word 0x00018a40			; andeq r8, r1, r0, asr #20
	.word 0x00000000
	.word 0x0123bf59
	.word 0x80000000			; andhi r0, r0, r0
	.word 0x00100110			; andseq r0, r0, r0, lsl r1
	.word 0x01120144			; tsteq r2, r4, asr #2
	.word 0x0006017e			; andeq r0, r6, lr, ror r1
	.word 0x02040404			; andeq r0, r4, #4, #8
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04020404			; streq r0, [r2], #-0x404
	.word 0x04030404			; streq r0, [r3], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x02040404			; andeq r0, r4, #4, #8
	.word 0x04040504			; streq r0, [r4], #-0x504
	.word 0x04040505			; streq r0, [r4], #-0x505
	.word 0x04050405			; streq r0, [r5], #-0x405
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x05050504			; streq r0, [r5, #-0x504]
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x05040504			; streq r0, [r4, #-0x504]
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x05040404			; streq r0, [r4, #-0x404]
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04050404			; streq r0, [r5], #-0x404
	.word 0x04050505			; streq r0, [r5], #-0x505
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04050404			; streq r0, [r5], #-0x404
	.word 0x04040104			; streq r0, [r4], #-0x104
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x05050404			; streq r0, [r5, #-0x404]
	.word 0x04040504			; streq r0, [r4], #-0x504
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x04040404			; streq r0, [r4], #-0x404
	.word 0x00000000
	.word 0x000e0014			; andeq r0, lr, r4, lsl r0
	.word 0x001a0020			; andseq r0, sl, r0, lsr #32
	.word 0x0026002c			; eoreq r0, r6, ip, lsr #32
	.word 0x888a8484			; stmiahi sl, {r2, r7, sl, pc}
	.word 0x86860004			; strhi r0, [r6], r4
	.word 0x84800000			; strhi r0, [r0], #0
	.word 0x008c0000			; addeq r0, ip, r0
	.word 0x8600008c			; strhi r0, [r0], -ip, lsl #1
	.word 0x00000000
	.word 0x888a8400			; stmiahi sl, {sl, pc}
	.word 0x8686888c			; strhi r8, [r6], ip, lsl #17
	.word 0x00008686			; andeq r8, r0, r6, lsl #13
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0x0016001c			; andseq r0, r6, ip, lsl r0
	.word 0x00220028			; eoreq r0, r2, r8, lsr #32
	.word 0x002e0034			; eoreq r0, lr, r4, lsr r0
	.word 0x8882848c			; stmiahi r2, {r2, r3, r7, sl, pc}
	.word 0x8688808e			; strhi r8, [r8], lr, lsl #1
	.word 0x848c8080			; strhi r8, [ip], #0x80
	.word 0x808a8080			; addhi r8, sl, r0, lsl #1
	.word 0x8688808a			; strhi r8, [r8], sl, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x888a8080			; stmiahi sl, {r7, pc}
	.word 0x86888080			; strhi r8, [r8], r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x000e848c			; andeq r8, lr, ip, lsl #9
	.word 0x0000baba
	.word 0xbabababa			; blt -0x114ac34
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x0055002e			; subseq r0, r5, lr, lsr #32
	.word 0x0053002e			; subseq r0, r3, lr, lsr #32
	.word 0x0000baba
	.word 0x00001a40			; andeq r1, r0, r0, asr #20
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xe192cd21			; orrs ip, r2, r1, lsr #26
	.asciz "localeSym"
	.byte 0xba, 0xba
	.word 0xbabababa			; blt -0x114abfc
	.word 0x00001440			; andeq r1, r0, r0, asr #8
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x007dc961			; rsbseq ip, sp, r1, ror #18
	.word 0x55534100			; ldrbpl r4, [r3, #-0x100]
	.word 0xbabababa			; blt -0x114abe4
	.word 0x00001d40			; andeq r1, r0, r0, asr #26
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x2cc3bc2c			; stclhs p12, c11, [r3], {44}
	.asciz "longOrdinals"
	.byte 0xba, 0xba, 0xba
	.word 0x00001e40			; andeq r1, r0, r0, asr #28
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x8191618c			; orrshi r6, r1, ip, lsl #3
	.asciz "shortOrdinals"
	.byte 0xba, 0xba
	.word 0x00001f40			; andeq r1, r0, r0, asr #30
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xf85a6f2f
	.asciz "firstDayOfWeek"
	.byte 0xba
	.word 0x00001e40			; andeq r1, r0, r0, asr #28
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x5366a052
	.asciz "useWeekNumber"
	.byte 0xba, 0xba
	.word 0x00001f40			; andeq r1, r0, r0, asr #30
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5

sub_69bc:
	b 0x598d34
	.asciz "keyboardLayout"
	.byte 0xba
	.word 0x00001c40			; andeq r1, r0, r0, asr #24
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x70ba8cb2
	.asciz "speakerless"
	.word 0xbabababa			; blt -0x114ab24
	.word 0x00001f40			; andeq r1, r0, r0, asr #30
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x6dda2b81			; ldclvs p11, c2, [sl, #0x204]
	.asciz "wordBreakTable"
	.byte 0xba
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x10b9211d			; adcsne r2, sb, sp, lsl r1
	.asciz "wordsDictionary"
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x162c24f0
	.asciz "phoneDictionary"
	.word 0x000060c1			; andeq r6, r0, r1, asr #1
	.word 0x00000000
	.word 0x00000008			; andeq r0, r0, r8
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x0123ae19
	.word 0x01227da9
	.word 0x0123c369
	.word 0x01239561
	.word 0x012397f9
	.word 0x01239689
	.word 0x01239389
	.word 0x0123c3a1
	.word 0x0123c3c1
	.word 0x0123c3e1
	.word 0x0123c401
	.word 0x0123c421
	.word 0x0123c441
	.word 0x0123c461
	.word 0x01239349
	.word 0x0123c481
	.word 0x012397d9
	.word 0x012391f1
	.word 0x0123c4a1
	.word 0x01239539
	.word 0x00005c43			; andeq r5, r0, r3, asr #24
	.word 0x00000000
	.word 0x0123c4c1
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x0123c351
	.word 0x0123c389
	.word 0x0123aec1
	.word 0x0123af81
	.word 0x0123b019
	.word 0x0123b6b1
	.word 0x0123bb39
	.word 0x0123bec9
	.word 0x00000000
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x0123c389
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x0123bf71
	.word 0x0123c1c1
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x01239921
	.word 0x01239c21
	.word 0x00000000
	.word 0x0123abc1
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x000018c1			; andeq r1, r0, r1, asr #17
	.word 0x00000000
	.word 0x00000008			; andeq r0, r0, r8
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x01239751
	.word 0x012391c9
	.word 0x00001443			; andeq r1, r0, r3, asr #8
	.word 0x00000000
	.word 0x0123c581
	.word 0x0123c521
	.word 0x0123c521
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00001043			; andeq r1, r0, r3, asr #32
	.word 0x00000000
	.word 0x01238929
	.word 0x0123c599
	.word 0x000018c1			; andeq r1, r0, r1, asr #17
	.word 0x00000000
	.word 0x00000000
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x01239329
	.word 0x0123dd19
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x529b1862			; addspl r1, fp, #0x620000
	.asciz "longDateStrSpec"
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xdf303551			; swile #0x303551
	.asciz "abbrDateStrSpec"
	.word 0x00002440			; andeq r2, r0, r0, asr #8
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x6b7793b1			; blvs 0x1deba80
	.asciz "yearMonthDayStrSpec"
	.word 0xbabababa			; blt -0x114a944
	.word 0x00002140			; andeq r2, r0, r0, asr #2
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x375c0543			; ldrblo r0, [ip, -r3, asr #10]
	.asciz "yearMonthStrSpec"
	.byte 0xba, 0xba, 0xba
	.word 0xbabababa			; blt -0x114a91c
	.word 0x00001b40			; andeq r1, r0, r0, asr #22
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xe2dc1e72			; sbcs r1, ip, #0x720
	.asciz "dayStrSpec"
	.byte 0xba
	.word 0xbabababa			; blt -0x114a8fc
	.word 0x00002340			; andeq r2, r0, r0, asr #6
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x9dcc076d			; stclls p7, c0, [ip, #0x1b4]
	.asciz "numericDateStrSpec"
	.byte 0xba
	.word 0xbabababa			; blt -0x114a8d4
	.word 0x00002140			; andeq r2, r0, r0, asr #2
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x793dfc88			; ldmdbvc sp!, {r3, r7, sl, fp, ip, sp, lr, pc}
	.asciz "numericMDStrSpec"
	.byte 0xba, 0xba, 0xba
	.word 0xbabababa			; blt -0x114a8ac
	.word 0x00002340			; andeq r2, r0, r0, asr #6
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x5bea1028			; blpl -0x5752e4
	.asciz "numericYearStrSpec"
	.byte 0xba
	.word 0xbabababa			; blt -0x114a884
	.word 0x00002140			; andeq r2, r0, r0, asr #2
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x99248b8a			; stmdbls r4!, {r1, r3, r7, r8, sb, fp, pc}
	.asciz "longMonthStrSpec"
	.byte 0xba, 0xba, 0xba
	.word 0xbabababa			; blt -0x114a85c
	.word 0x00002140			; andeq r2, r0, r0, asr #2
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x25b9a879			; ldrhs sl, [sb, #0x879]!
	.asciz "abbrMonthStrSpec"
	.byte 0xba, 0xba, 0xba
	.word 0xbabababa			; blt -0x114a834
	.word 0x00002240			; andeq r2, r0, r0, asr #4
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x0fed992d			; swieq #0xed992d
	.asciz "numericDayStrSpec"
	.byte 0xba, 0xba
	.word 0xbabababa			; blt -0x114a80c
	.word 0x00002540			; andeq r2, r0, r0, asr #10
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x4409279b			; strmi r2, [sb], #-0x79b
	.asciz "longDayOfWeekStrSpec"
	.byte 0xba, 0xba, 0xba
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xd44a2dab			; strble r2, [sl], #-0xdab
	.asciz "longTimeStrSpec"
	.word 0x00002440			; andeq r2, r0, r0, asr #8
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x043c0997			; ldrteq r0, [ip], #-0x997
	.asciz "shortestTimeStrSpec"
	.word 0xbabababa			; blt -0x114a79c
	.word 0x00001c40			; andeq r1, r0, r0, asr #24
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x37a9c3d2
	.asciz "hourStrSpec"
	.word 0xbabababa			; blt -0x114a77c
	.word 0x00001e40			; andeq r1, r0, r0, asr #28
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xafbc22c6			; swige #0xbc22c6
	.asciz "minuteStrSpec"
	.byte 0xba, 0xba
	.word 0x00001e40			; andeq r1, r0, r0, asr #28
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x16f7ace0			; ldrbtne sl, [r7], r0, ror #25
	.asciz "secondStrSpec"
	.byte 0xba, 0xba
	.word 0x000060c1			; andeq r6, r0, r1, asr #1
	.word 0x00000000
	.word 0x00000008			; andeq r0, r0, r8
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x0123c5d9
	.word 0x0123c5f9
	.word 0x0123c619
	.word 0x0123c641
	.word 0x0123c669
	.word 0x012394b9
	.word 0x0123c689
	.word 0x0123c6b1
	.word 0x0123c6d9
	.word 0x0123c701
	.word 0x0123c729
	.word 0x0123c751
	.word 0x0123c779
	.word 0x01239121
	.word 0x0123c7a1
	.word 0x01239709
	.word 0x0123c7c1
	.word 0x0123c7e9
	.word 0x0123c809
	.word 0x0123c829
	.word 0x00005c43			; andeq r5, r0, r3, asr #24
	.word 0x00000000
	.word 0x0123c849
	.word 0x02c2e928			; sbceq lr, r2, #40, #18
	.word 0x02c4e948			; sbceq lr, r4, #72, #18
	.word 0x000b0ba4			; andeq r0, fp, r4, lsr #23
	.word 0x00002c2c			; andeq r2, r0, ip, lsr #24
	.word 0x0004e948			; andeq lr, r4, r8, asr #18
	.word 0x00000ba4			; andeq r0, r0, r4, lsr #23
	.word 0x000b2ba4			; andeq r2, fp, r4, lsr #23
	.word 0x00002ba4			; andeq r2, r0, r4, lsr #23
	.word 0x000000b0			; strheq r0, [r0], -r0
	.word 0x0000002c			; andeq r0, r0, ip, lsr #32
	.word 0x0000004c			; andeq r0, r0, ip, asr #32
	.word 0x000000a4			; andeq r0, r0, r4, lsr #1
	.word 0x00000028			; andeq r0, r0, r8, lsr #32
	.word 0x00000048			; andeq r0, r0, r8, asr #32
	.word 0x029aab30			; addseq sl, sl, #48, #22
	.word 0x000a6a30			; andeq r6, sl, r0, lsr sl
	.word 0x000029a8			; andeq r2, r0, r8, lsr #19
	.word 0x000000a4			; andeq r0, r0, r4, lsr #1
	.word 0x000000a8			; andeq r0, r0, r8, lsr #1
	.word 0x000000ac			; andeq r0, r0, ip, lsr #1
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x000036c0			; andeq r3, r0, r0, asr #13
	.word 0x00000000
	.word 0x0121b989
	.word 0x1822c700			; stmdane r2!, {r8, sb, sl, lr, pc}
	.word 0x11a55f00
	.word 0x217d24c2
	.word 0xa47d20c2			; ldrbtge r2, [sp], #-0xc2
	.word 0xa3717b91
	.word 0xc56f001f			; strbgt r0, [pc, #-0x1f]!
	.word 0x717b7cc7
	.word 0x0013987d			; andseq sb, r3, sp, ror r8
	.word 0x057d066f			; ldrbeq r0, [sp, #-0x66f]!
	.word 0x00092222			; andeq r2, sb, r2, lsr #4
	.word 0xa502baba			; strge fp, [r2, #-0xaba]
	.word 0x000014c1			; andeq r1, r0, r1, asr #9
	.word 0x00000000
	.word 0x0121b9a9
	.word 0x0123dd49
	.word 0x0121b7f1
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00001d40			; andeq r1, r0, r0, asr #26
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x4a9571ed			; bmi -0x1a9c950
	.asciz "slotval|iter"
	.byte 0xba, 0xba, 0xba
	.word 0x00001cc1			; andeq r1, r0, r1, asr #25
	.word 0x00000000
	.word 0x0121e269
	.word 0x00000000
	.word 0x01222039
	.word 0x0121c049
	.word 0x0123c959
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00002443			; andeq r2, r0, r3, asr #8
	.word 0x00000000
	.word 0x0123ff01
	.word 0x00000032			; andeq r0, r0, r2, lsr r0
	.word 0x0123c909
	.word 0x0123c941
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x000c0000			; andeq r0, ip, r0
	.word 0x0123c979
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00002040			; andeq r2, r0, r0, asr #32
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x07e7f2b8
	.asciz "GetPICTResource"
	.word 0x00001940			; andeq r1, r0, r0, asr #18
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x42120217			; andsmi r0, r2, #0x70000001
	.asciz "nameOrId"
	.byte 0xba, 0xba, 0xba
	.word 0xbabababa			; blt -0x114a584
	.word 0x00001840			; andeq r1, r0, r0, asr #16
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0xbd04c23c			; stclt p2, c12, [r4, #-0xf0]
	.asciz "picture"
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00500049			; subseq r0, r0, sb, asr #32
	.word 0x00430054			; subeq r0, r3, r4, asr r0
	.word 0x0000baba
	.word 0x00004e40			; andeq r4, r0, r0, asr #28
	.word 0x00000000
	.word 0x01227cd1
	.word 0x00620061			; rsbeq r0, r2, r1, rrx
	.word 0x00640020			; rsbeq r0, r4, r0, lsr #32
	.word 0x00500049			; subseq r0, r0, sb, asr #32
	.word 0x00430054			; subeq r0, r3, r4, asr r0
	.word 0x00200072			; eoreq r0, r0, r2, ror r0
	.word 0x00650073			; rsbeq r0, r5, r3, ror r0
	.word 0x006f0075			; rsbeq r0, pc, r5, ror r0
	.word 0x00720063			; rsbseq r0, r2, r3, rrx
	.word 0x00650020			; rsbeq r0, r5, r0, lsr #32
	.word 0x00730070			; rsbseq r0, r3, r0, ror r0
	.word 0x00650063			; rsbeq r0, r5, r3, rrx
	.word 0x00690066			; rsbeq r0, sb, r6, rrx
	.word 0x00690063			; rsbeq r0, sb, r3, rrx
	.word 0x00610074			; rsbeq r0, r1, r4, ror r0
	.word 0x0069006f			; rsbeq r0, sb, pc, rrx
	.word 0x006e003a			; rsbeq r0, lr, sl, lsr r0
	.word 0x0000baba
	.word 0x000057c0			; andeq r5, r0, r0, asr #15
	.word 0x00000000
	.word 0x0121b989
	.word 0x7b18296f			; blvc 0x6115e0
	.word 0x000e197b			; andeq r1, lr, fp, ror sb
	.word 0x1a1b2b5f			; bne 0x6d1da8
	.word 0x004a7b1c			; subeq r7, sl, ip, lsl fp
	.word 0x296f001c			; stmdbhs pc!, {r2, r3, r4}^
	.word 0x1d7b1a1e			; ldclne p10, c1, [fp, #-0x78]!
	.word 0x2b5f004a			; blhs 0x17c7164
	.word 0x7b1f0007			; blvc 0x7c705c
	.word 0x296f002d			; stmdbhs pc!, {r0, r2, r3, r5}^
	.word 0x7b1a1f00			; blvc 0x68ec48
	.word 0x082a5f00			; stmdaeq sl!, {r8, sb, sl, fp, ip, lr}
	.word 0x2e226f00			; cdphs p15, #2, c6, c2, c0, #0
	.word 0x357b5f00			; ldrblo r5, [fp, #-0xf00]!
	.word 0x4a1f0009			; bmi 0x7c707c
	.word 0x1f000a1f			; swine #0xa1f
	.word 0x000b7b1f			; andeq r7, fp, pc, lsl fp
	.word 0x000c8bc7			; andeq r8, ip, r7, asr #23
	.word 0x00161f00			; andseq r1, r6, r0, lsl #30
	.word 0x0d2a02ba			; stceq p2, c0, [sl, #-0x2e8]!
	.word 0x000044c1			; andeq r4, r0, r1, asr #9
	.word 0x00000000
	.word 0x0121b9a9
	.word 0x0121c691
	.word 0x0123ca19
	.word 0x0123ca01
	.word 0x0121b8a1
	.word 0x0121c611
	.word 0x0123ca19
	.word 0x0121b8c1
	.word 0x0121c5c1
	.word 0x0121c7b1
	.word 0x01237469
	.word 0x0123ca31
	.word 0x01238a01
	.word 0x0121b7c9
	.word 0x0121c419
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x000024c3			; andeq r2, r0, r3, asr #9
	.word 0x00000000
	.word 0x0123ff29
	.word 0x00000032			; andeq r0, r0, r2, lsr r0
	.word 0x0123ca81
	.word 0x0123cad9
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x0123cb49
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x000014c1			; andeq r1, r0, r1, asr #9
	.word 0x00000000
	.word 0x0121e269
	.word 0x00000000
	.word 0x0123c9e1
	.word 0xbeacebad			; cdplt p11, #10, c14, c12, c13, #5
	.word 0x00001640			; andeq r1, r0, r0, asr #12
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x86d45a8d			; ldrbhi r5, [r4], sp, lsl #21
	.asciz "depth"
	.byte 0xba, 0xba
	.word 0x00001b40			; andeq r1, r0, r0, asr #22
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x330247ef
	.asciz "colorTable"
	.byte 0xba
	.word 0xbabababa			; blt -0x114a3ec
	.word 0x00002b40			; andeq r2, r0, r0, asr #22
	.word 0x00000000
	.word 0x00055552			; andeq r5, r5, r2, asr r5
	.word 0x7e15833d			; mrcvc p3, #0, r8, c5, c13, #1
	.asciz "noColorTableAtThisBitDepth"
	.byte 0xba
	.word 0xbabababa			; blt -0x114a3bc
	.word 0x000030c1			; andeq r3, r0, r1, asr #1
	.word 0x00000000
	.word 0x0121b7c9
	.word 0x0123cb99
	.word 0x0123cbf9
	.word 0x0123cc19
	.word 0x0123cb99
	.word 0x0123cc49
	.word 0x0123cb99
	.word 0x0123cb99
	.word 0x0123cb99
	.word 0x0123ccd9
	.word 0x00001c40			; andeq r1, r0, r0, asr #24
	.word 0x00000000
	.word 0x0123cb79
	.word 0x0000ffff
	.word 0xffffffff
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0xbabababa			; blt -0x114a36c
	.word 0x00002c40			; andeq r2, r0, r0, asr #24
	.word 0x00000000
	.word 0x0123cb79
	.word 0x0000ffff
	.word 0xffffffff
	.word 0x0001aaaa			; andeq sl, r1, sl, lsr #21
	.word 0xaaaaaaaa			; bge -0x154e390
	.word 0x00025555			; andeq r5, r2, r5, asr r5
	.asciz "UUUU"
	.byte 0x03, 0x00, 0x00
	.word 0x00000000
	.word 0xbabababa			; blt -0x114a33c
	.word 0x00008c40			; andeq r8, r0, r0, asr #24
	.word 0x00000000
	.word 0x0123cb79
	.word 0x0000ffff
	.word 0xffffffff
	.word 0x0001eeee			; andeq lr, r1, lr, ror #29
	.word 0xeeeeeeee			; cdp p14, #14, c14, c14, c14, #7
	.word 0x0002dddd
	.word 0xdddddddd			; ldclle p13, c13, [sp, #0x374]
	.word 0x0003cccc			; andeq ip, r3, ip, asr #25
	.word 0xcccccccc			; stclgt p12, c12, [ip], {204}
	.word 0x0004bbbb
	.word 0xbbbbbbbb			; bllt -0x1109f04
	.word 0x0005aaaa			; andeq sl, r5, sl, lsr #21
	.word 0xaaaaaaaa			; bge -0x154e340
	.word 0x00069999
	.word 0x99999999			; ldmibls sb, {r0, r3, r4, r7, r8, fp, ip, pc}
	.word 0x00078888			; andeq r8, r7, r8, lsl #17
	.word 0x88888888			; stmiahi r8, {r3, r7, fp, pc}
	.word 0x00087777			; andeq r7, r8, r7, ror r7
	.asciz "wwww"
	.asciz "\tffffff"
	.asciz "\nUUUUUU"
	.byte 0x0b, 0x44, 0x44
	.asciz "DDDD"
	.byte 0x0c, 0x33, 0x33
	.asciz "3333"
	.asciz "\r\"\"\"\"\"\""
	.byte 0x0e, 0x11, 0x11
	.word 0x11111111
	.word 0x000f0000			; andeq r0, pc, r0
	.word 0x00000000
	.word 0xbabababa			; blt -0x114a2ac
	.word 0x00080c40			; andeq r0, r8, r0, asr #24
	.word 0x00000000
	.word 0x0123cb79
	.word 0x0000ffff
	.word 0xffffffff
	.word 0x0001fefe
	.word 0xfefefefe
	.word 0x0002fdfd
	.word 0xfdfdfdfd
	.word 0x0003fcfc
	.word 0xfcfcfcfc
	.word 0x0004fbfb
	.word 0xfbfbfbfb
	.word 0x0005fafa
	.word 0xfafafafa
	.word 0x0006f9f9
	.word 0xf9f9f9f9
	.word 0x0007f8f8
	.word 0xf8f8f8f8
	.word 0x0008f7f7
	.word 0xf7f7f7f7
	.word 0x0009f6f6
	.word 0xf6f6f6f6
	.word 0x000af5f5
	.word 0xf5f5f5f5
	.word 0x000bf4f4
	.word 0xf4f4f4f4
	.word 0x000cf3f3
	.word 0xf3f3f3f3
	.word 0x000df2f2
	.word 0xf2f2f2f2
	.word 0x000ef1f1
	.word 0xf1f1f1f1
	.word 0x000ff0f0
	.word 0xf0f0f0f0
	.word 0x0010efef			; andseq lr, r0, pc, ror #31
	.word 0xefefefef			; swi #0xefefef
	.word 0x0011eeee			; andseq lr, r1, lr, ror #29
	.word 0xeeeeeeee			; cdp p14, #14, c14, c14, c14, #7
	.word 0x0012eded			; andseq lr, r2, sp, ror #27
	.word 0xedededed			; stcl p13, c14, [sp, #0x3b4]!
	.word 0x0013ecec			; andseq lr, r3, ip, ror #25
	.word 0xecececec			; stcl p12, c14, [ip], #0x3b0
	.word 0x0014ebeb			; andseq lr, r4, fp, ror #23

sub_7318:
	bl -0x4fada0
	andseq lr, r5, sl, ror #21
	b -0x53b19c
	.word 0x0016e9e9			; andseq lr, r6, sb, ror #19
	.word 0xe9e9e9e9			; stmib sb!, {r0, r3, r5, r6, r7, r8, fp, sp, lr, pc}^
	.word 0x0017e8e8			; andseq lr, r7, r8, ror #17
	.word 0xe8e8e8e8			; stmia r8!, {r3, r5, r6, r7, fp, sp, lr, pc}^
	.word 0x0018e7e7			; andseq lr, r8, r7, ror #15
	.word 0xe7e7e7e7			; strb lr, [r7, r7, ror #15]!
	.word 0x0019e6e6			; andseq lr, sb, r6, ror #13
	.word 0xe6e6e6e6			; strbt lr, [r6], r6, ror #13
	.word 0x001ae5e5			; andseq lr, sl, r5, ror #11
	.word 0xe5e5e5e5			; strb lr, [r5, #0x5e5]!
	.word 0x001be4e4			; andseq lr, fp, r4, ror #9
	.word 0xe4e4e4e4			; strbt lr, [r4], #0x4e4
	.word 0x001ce3e3			; andseq lr, ip, r3, ror #7
	.word 0xe3e3e3e3
	.word 0x001de2e2			; andseq lr, sp, r2, ror #5
	.word 0xe2e2e2e2			; rsc lr, r2, #0x2000000e
	.word 0x001ee1e1			; andseq lr, lr, r1, ror #3
	.word 0xe1e1e1e1
	.word 0x001fe0e0			; andseq lr, pc, r0, ror #1
	.word 0xe0e0e0e0			; rsc lr, r0, r0, ror #1
	.word 0x0020dfdf
	.word 0xdfdfdfdf			; swile #0xdfdfdf
	.word 0x0021dede
	.word 0xdededede			; mrcle p14, #6, sp, c14, c14, #6
	.word 0x0022dddd
	.word 0xdddddddd			; ldclle p13, c13, [sp, #0x374]
	.word 0x0023dcdc
	.word 0xdcdcdcdc			; ldclle p12, c13, [ip], {220}
	.word 0x0024dbdb
	.word 0xdbdbdbdb			; blle -0x901cf4
	.word 0x0025dada
	.word 0xdadadada			; ble -0x9420f0
	.word 0x0026d9d9
	.word 0xd9d9d9d9			; ldmible sb, {r0, r3, r4, r6, r7, r8, fp, ip, lr, pc}^
	.word 0x0027d8d8
	.word 0xd8d8d8d8			; ldmiale r8, {r3, r4, r6, r7, fp, ip, lr, pc}^
	.word 0x0028d7d7
	.word 0xd7d7d7d7
	.word 0x0029d6d6
	.word 0xd6d6d6d6
	.word 0x002ad5d5
	.word 0xd5d5d5d5			; ldrble sp, [r5, #0x5d5]
	.word 0x002bd4d4
	.word 0xd4d4d4d4			; ldrble sp, [r4], #0x4d4
	.word 0x002cd3d3
	.word 0xd3d3d3d3			; bicsle sp, r3, #0x4c000003
	.word 0x002dd2d2
	.word 0xd2d2d2d2			; sbcsle sp, r2, #0x2000000d
	.word 0x002ed1d1
	.word 0xd1d1d1d1			; ldrsble sp, [r1, #0x11]
	.word 0x002fd0d0
	.word 0xd0d0d0d0			; ldrsble sp, [r0], #0
	.word 0x0030cfcf			; eorseq ip, r0, pc, asr #31
	.word 0xcfcfcfcf			; swigt #0xcfcfcf
	.word 0x0031cece			; eorseq ip, r1, lr, asr #29
	.word 0xcececece			; cdpgt p14, #12, c12, c14, c14, #6
	.word 0x0032cdcd			; eorseq ip, r2, sp, asr #27
	.word 0xcdcdcdcd			; stclgt p13, c12, [sp, #0x334]
	.word 0x0033cccc			; eorseq ip, r3, ip, asr #25
	.word 0xcccccccc			; stclgt p12, c12, [ip], {204}
	.word 0x0034cbcb			; eorseq ip, r4, fp, asr #23
	.word 0xcbcbcbcb			; blgt -0xd05cb4
	.word 0x0035caca			; eorseq ip, r5, sl, asr #21
	.word 0xcacacaca			; bgt -0xd460b0
	.word 0x0036c9c9			; eorseq ip, r6, sb, asr #19
	.word 0xc9c9c9c9			; stmibgt sb, {r0, r3, r6, r7, r8, fp, lr, pc}^
	.word 0x0037c8c8			; eorseq ip, r7, r8, asr #17
	.word 0xc8c8c8c8			; stmiagt r8, {r3, r6, r7, fp, lr, pc}^
	.word 0x0038c7c7			; eorseq ip, r8, r7, asr #15
	.word 0xc7c7c7c7			; strbgt ip, [r7, r7, asr #15]
	.word 0x0039c6c6			; eorseq ip, sb, r6, asr #13
	.word 0xc6c6c6c6			; strbgt ip, [r6], r6, asr #13
	.word 0x003ac5c5			; eorseq ip, sl, r5, asr #11
	.word 0xc5c5c5c5			; strbgt ip, [r5, #0x5c5]
	.word 0x003bc4c4			; eorseq ip, fp, r4, asr #9
	.word 0xc4c4c4c4			; strbgt ip, [r4], #0x4c4
	.word 0x003cc3c3			; eorseq ip, ip, r3, asr #7
	.word 0xc3c3c3c3			; bicgt ip, r3, #0xc000003
	.word 0x003dc2c2			; eorseq ip, sp, r2, asr #5
	.word 0xc2c2c2c2			; sbcgt ip, r2, #0x2000000c
	.word 0x003ec1c1			; eorseq ip, lr, r1, asr #3
	.word 0xc1c1c1c1			; bicgt ip, r1, r1, asr #3
	.word 0x003fc0c0			; eorseq ip, pc, r0, asr #1
	.word 0xc0c0c0c0			; sbcgt ip, r0, r0, asr #1
	.word 0x0040bfbf			; strheq fp, [r0], #-0xff
	.word 0xbfbfbfbf			; swilt #0xbfbfbf
	.word 0x0041bebe			; strheq fp, [r1], #-0xee
	.word 0xbebebebe			; mrclt p14, #5, fp, c14, c14, #5
	.word 0x0042bdbd			; strheq fp, [r2], #-0xdd
	.word 0xbdbdbdbd			; ldclt p13, c11, [sp, #0x2f4]!
	.word 0x0043bcbc			; strheq fp, [r3], #-0xcc
	.word 0xbcbcbcbc			; ldclt p12, c11, [ip], #0x2f0
	.word 0x0044bbbb			; strheq fp, [r4], #-0xbb
	.word 0xbbbbbbbb			; bllt -0x1109c74
	.word 0x0045baba			; strheq fp, [r5], #-0xaa
	.word 0xbabababa			; blt -0x114a070
	.word 0x0046b9b9			; strheq fp, [r6], #-0x99
	.word 0xb9b9b9b9			; ldmiblt sb!, {r0, r3, r4, r5, r7, r8, fp, ip, sp, pc}
	.word 0x0047b8b8			; strheq fp, [r7], #-0x88
	.word 0xb8b8b8b8			; ldmialt r8!, {r3, r4, r5, r7, fp, ip, sp, pc}
	.word 0x0048b7b7			; strheq fp, [r8], #-0x77
	.word 0xb7b7b7b7
	.word 0x0049b6b6			; strheq fp, [sb], #-0x66
	.word 0xb6b6b6b6
	.word 0x004ab5b5			; strheq fp, [sl], #-0x55
	.word 0xb5b5b5b5			; ldrlt fp, [r5, #0x5b5]!
	.word 0x004bb4b4			; strheq fp, [fp], #-0x44
	.word 0xb4b4b4b4			; ldrtlt fp, [r4], #0x4b4
	.word 0x004cb3b3			; strheq fp, [ip], #-0x33
	.word 0xb3b3b3b3
	.word 0x004db2b2			; strheq fp, [sp], #-0x22
	.word 0xb2b2b2b2			; adcslt fp, r2, #0x2000000b
	.word 0x004eb1b1			; strheq fp, [lr], #-0x11
	.word 0xb1b1b1b1
	.word 0x004fb0b0			; strheq fp, [pc], #-0
	.word 0xb0b0b0b0
	.word 0x0050afaf			; subseq sl, r0, pc, lsr #31
	.word 0xafafafaf			; swige #0xafafaf
	.word 0x0051aeae			; subseq sl, r1, lr, lsr #29
	.word 0xaeaeaeae			; cdpge p14, #10, c10, c14, c14, #5
	.word 0x0052adad			; subseq sl, r2, sp, lsr #27
	.word 0xadadadad			; stcge p13, c10, [sp, #0x2b4]!
	.word 0x0053acac			; subseq sl, r3, ip, lsr #25
	.word 0xacacacac			; stcge p12, c10, [ip], #0x2b0
	.word 0x0054abab			; subseq sl, r4, fp, lsr #23
	.word 0xabababab			; blge -0x150dc34
	.word 0x0055aaaa			; subseq sl, r5, sl, lsr #21
	.word 0xaaaaaaaa			; bge -0x154e030
	.word 0x0056a9a9			; subseq sl, r6, sb, lsr #19
	.word 0xa9a9a9a9			; stmibge sb!, {r0, r3, r5, r7, r8, fp, sp, pc}
	.word 0x0057a8a8			; subseq sl, r7, r8, lsr #17
	.word 0xa8a8a8a8			; stmiage r8!, {r3, r5, r7, fp, sp, pc}
	.word 0x0058a7a7			; subseq sl, r8, r7, lsr #15
	.word 0xa7a7a7a7			; strge sl, [r7, r7, lsr #15]!
	.word 0x0059a6a6			; subseq sl, sb, r6, lsr #13
	.word 0xa6a6a6a6			; strtge sl, [r6], r6, lsr #13
	.word 0x005aa5a5			; subseq sl, sl, r5, lsr #11
	.word 0xa5a5a5a5			; strge sl, [r5, #0x5a5]!
	.word 0x005ba4a4			; subseq sl, fp, r4, lsr #9
	.word 0xa4a4a4a4			; strtge sl, [r4], #0x4a4
	.word 0x005ca3a3			; subseq sl, ip, r3, lsr #7
	.word 0xa3a3a3a3
	.word 0x005da2a2			; subseq sl, sp, r2, lsr #5
	.word 0xa2a2a2a2			; adcge sl, r2, #0x2000000a
	.word 0x005ea1a1			; subseq sl, lr, r1, lsr #3
	.word 0xa1a1a1a1
	.word 0x005fa0a0			; subseq sl, pc, r0, lsr #1
	.word 0xa0a0a0a0			; adcge sl, r0, r0, lsr #1
	.word 0x00609f9f
	.word 0x9f9f9f9f			; swils #0x9f9f9f
	.word 0x00619e9e
	.word 0x9e9e9e9e			; mrcls p14, #4, sb, c14, c14, #4
	.word 0x00629d9d
	.word 0x9d9d9d9d			; ldcls p13, c9, [sp, #0x274]
	.word 0x00639c9c
	.word 0x9c9c9c9c			; ldcls p12, c9, [ip], {156}
	.word 0x00649b9b
	.word 0x9b9b9b9b			; blls -0x1911bf4
	.word 0x00659a9a
	.word 0x9a9a9a9a			; bls -0x1951ff0
	.word 0x00669999
	.word 0x99999999			; ldmibls sb, {r0, r3, r4, r7, r8, fp, ip, pc}
	.word 0x00679898
	.word 0x98989898			; ldmials r8, {r3, r4, r7, fp, ip, pc}
	.word 0x00689797
	.word 0x97979797
	.word 0x00699696
	.word 0x96969696
	.word 0x006a9595
	.word 0x95959595			; ldrls sb, [r5, #0x595]
	.word 0x006b9494
	.word 0x94949494			; ldrls sb, [r4], #0x494
	.word 0x006c9393
	.word 0x93939393			; orrsls sb, r3, #0x4c000002
	.word 0x006d9292
	.word 0x92929292			; addsls sb, r2, #0x20000009
	.word 0x006e9191
	.word 0x91919191
	.word 0x006f9090
	.word 0x90909090			; umullsls sb, r0, r0, r0
	.word 0x00708f8f			; rsbseq r8, r0, pc, lsl #31
	.word 0x8f8f8f8f			; swihi #0x8f8f8f
	.word 0x00718e8e			; rsbseq r8, r1, lr, lsl #29
	.word 0x8e8e8e8e			; cdphi p14, #8, c8, c14, c14, #4
	.word 0x00728d8d			; rsbseq r8, r2, sp, lsl #27
	.word 0x8d8d8d8d			; stchi p13, c8, [sp, #0x234]
	.word 0x00738c8c			; rsbseq r8, r3, ip, lsl #25
	.word 0x8c8c8c8c			; stchi p12, c8, [ip], {140}
	.word 0x00748b8b			; rsbseq r8, r4, fp, lsl #23
	.word 0x8b8b8b8b			; blhi -0x1d15bb4
	.word 0x00758a8a			; rsbseq r8, r5, sl, lsl #21
	.word 0x8a8a8a8a			; bhi -0x1d55fb0
	.word 0x00768989			; rsbseq r8, r6, sb, lsl #19
	.word 0x89898989			; stmibhi sb, {r0, r3, r7, r8, fp, pc}
	.word 0x00778888			; rsbseq r8, r7, r8, lsl #17
	.word 0x88888888			; stmiahi r8, {r3, r7, fp, pc}
	.word 0x00788787			; rsbseq r8, r8, r7, lsl #15
	.word 0x87878787			; strhi r8, [r7, r7, lsl #15]
	.word 0x00798686			; rsbseq r8, sb, r6, lsl #13
	.word 0x86868686			; strhi r8, [r6], r6, lsl #13
	.word 0x007a8585			; rsbseq r8, sl, r5, lsl #11
	.word 0x85858585			; strhi r8, [r5, #0x585]
	.word 0x007b8484			; rsbseq r8, fp, r4, lsl #9
	.word 0x84848484			; strhi r8, [r4], #0x484
	.word 0x007c8383			; rsbseq r8, ip, r3, lsl #7
	.word 0x83838383			; orrhi r8, r3, #0xc000002
	.word 0x007d8282			; rsbseq r8, sp, r2, lsl #5
	.word 0x82828282			; addhi r8, r2, #0x20000008
	.word 0x007e8181			; rsbseq r8, lr, r1, lsl #3
	.word 0x81818181			; orrhi r8, r1, r1, lsl #3
	.word 0x007f8080			; rsbseq r8, pc, r0, lsl #1
	.word 0x80808080			; addhi r8, r0, r0, lsl #1
	.word 0x00807f7f			; addeq r7, r0, pc, ror pc
	.word 0x7f7f7f7f			; swivc #0x7f7f7f
	.word 0x00817e7e			; addeq r7, r1, lr, ror lr
	.asciz "~~~~"
	.byte 0x82, 0x7d, 0x7d
	.asciz "}}}}"
	.byte 0x83, 0x7c, 0x7c
	.asciz "||||"
	.byte 0x84, 0x7b, 0x7b
	.asciz "{{{{"
	.byte 0x85, 0x7a, 0x7a
	.asciz "zzzz"
	.byte 0x86, 0x79, 0x79
	.asciz "yyyy"
	.byte 0x87, 0x78, 0x78
	.asciz "xxxx"
	.byte 0x88, 0x77, 0x77
	.asciz "wwww"
	.byte 0x89, 0x76, 0x76
	.asciz "vvvv"
	.byte 0x8a, 0x75, 0x75
	.asciz "uuuu"
	.byte 0x8b, 0x74, 0x74
	.asciz "tttt"
	.byte 0x8c, 0x73, 0x73
	.asciz "ssss"
	.byte 0x8d, 0x72, 0x72
	.asciz "rrrr"
	.byte 0x8e, 0x71, 0x71
	.asciz "qqqq"
	.byte 0x8f, 0x70, 0x70
	.asciz "pppp"
	.byte 0x90, 0x6f, 0x6f
	.asciz "oooo"
	.byte 0x91, 0x6e, 0x6e
	.asciz "nnnn"
	.byte 0x92, 0x6d, 0x6d
	.asciz "mmmm"
	.byte 0x93, 0x6c, 0x6c
	.asciz "llll"
	.byte 0x94, 0x6b, 0x6b
	.asciz "kkkk"
	.byte 0x95, 0x6a, 0x6a
	.asciz "jjjj"
	.byte 0x96, 0x69, 0x69
	.asciz "iiii"
	.byte 0x97, 0x68, 0x68
	.asciz "hhhh"
	.byte 0x98, 0x67, 0x67
	.asciz "gggg"
	.byte 0x99, 0x66, 0x66
	.asciz "ffff"
	.byte 0x9a, 0x65, 0x65
	.asciz "eeee"
	.byte 0x9b, 0x64, 0x64
	.asciz "dddd"
	.byte 0x9c, 0x63, 0x63
	.asciz "cccc"
	.byte 0x9d, 0x62, 0x62
	.asciz "bbbb"
	.byte 0x9e, 0x61, 0x61
	.asciz "aaaa"
	.byte 0x9f, 0x60, 0x60
	.asciz "````"
	.byte 0xa0, 0x5f, 0x5f
	.asciz "____"
	.byte 0xa1, 0x5e, 0x5e
	.asciz "^^^^"
	.byte 0xa2, 0x5d, 0x5d
	.asciz "]]]]"
	.byte 0xa3, 0x5c, 0x5c
	.asciz "\\\\\\\\"
	.byte 0xa4, 0x5b, 0x5b
	.asciz "[[[["
	.byte 0xa5, 0x5a, 0x5a
	.asciz "ZZZZ"
	.byte 0xa6, 0x59, 0x59
	.asciz "YYYY"
	.byte 0xa7, 0x58, 0x58
	.asciz "XXXX"
	.byte 0xa8, 0x57, 0x57
	.asciz "WWWW"
	.byte 0xa9, 0x56, 0x56
	.asciz "VVVV"
	.byte 0xaa, 0x55, 0x55
	.asciz "UUUU"
	.byte 0xab, 0x54, 0x54
	.asciz "TTTT"
	.byte 0xac, 0x53, 0x53
	.asciz "SSSS"
	.byte 0xad, 0x52, 0x52
	.asciz "RRRR"
	.byte 0xae, 0x51, 0x51
	.asciz "QQQQ"
	.byte 0xaf, 0x50, 0x50
	.asciz "PPPP"
	.byte 0xb0, 0x4f, 0x4f
	.asciz "OOOO"
	.byte 0xb1, 0x4e, 0x4e
	.asciz "NNNN"
	.byte 0xb2, 0x4d, 0x4d
	.asciz "MMMM"
	.byte 0xb3, 0x4c, 0x4c
	.asciz "LLLL"
	.byte 0xb4, 0x4b, 0x4b
	.asciz "KKKK"
	.byte 0xb5, 0x4a, 0x4a
	.asciz "JJJJ"
	.byte 0xb6, 0x49, 0x49
	.asciz "IIII"
	.byte 0xb7, 0x48, 0x48
	.asciz "HHHH"
	.byte 0xb8, 0x47, 0x47
	.asciz "GGGG"
	.byte 0xb9, 0x46, 0x46
	.asciz "FFFF"
	.byte 0xba, 0x45, 0x45
	.asciz "EEEE"
	.byte 0xbb, 0x44, 0x44
	.asciz "DDDD"
	.byte 0xbc, 0x43, 0x43
	.asciz "CCCC"
	.byte 0xbd, 0x42, 0x42
	.asciz "BBBB"
	.byte 0xbe, 0x41, 0x41
	.asciz "AAAA"
	.byte 0xbf, 0x40, 0x40
	.asciz "@@@@"
	.byte 0xc0, 0x3f, 0x3f
	.asciz "????"
	.byte 0xc1, 0x3e, 0x3e
	.asciz ">>>>"
	.byte 0xc2, 0x3d, 0x3d
	.asciz "===="
	.byte 0xc3, 0x3c, 0x3c
	.asciz "<<<<"
	.byte 0xc4, 0x3b, 0x3b
	.asciz ";;;;"
	.byte 0xc5, 0x3a, 0x3a
	.asciz "::::"
	.byte 0xc6, 0x39, 0x39
	.asciz "9999"
	.byte 0xc7, 0x38, 0x38
	.asciz "8888"
	.byte 0xc8, 0x37, 0x37
	.asciz "7777"
	.byte 0xc9, 0x36, 0x36
	.asciz "6666"
	.byte 0xca, 0x35, 0x35
	.asciz "5555"
	.byte 0xcb, 0x34, 0x34
	.asciz "4444"
	.byte 0xcc, 0x33, 0x33
	.asciz "3333"
	.byte 0xcd, 0x32, 0x32
	.asciz "2222"
	.byte 0xce, 0x31, 0x31
	.asciz "1111"
	.byte 0xcf, 0x30, 0x30
	.asciz "0000"
	.byte 0xd0, 0x2f, 0x2f
	.asciz "////"
	.byte 0xd1, 0x2e, 0x2e
	.asciz "...."
	.byte 0xd2, 0x2d, 0x2d
	.asciz "----"
	.byte 0xd3, 0x2c, 0x2c
	.asciz ",,,,"
	.byte 0xd4, 0x2b, 0x2b
	.asciz "++++"
	.byte 0xd5, 0x2a, 0x2a
	.asciz "****"
	.byte 0xd6, 0x29, 0x29
	.asciz "))))"
	.byte 0xd7, 0x28, 0x28
	.asciz "(((("
	.byte 0xd8, 0x27, 0x27
	.asciz "''''"
	.byte 0xd9, 0x26, 0x26
	.asciz "&&&&"
	.byte 0xda, 0x25, 0x25
	.asciz "%%%%"
	.byte 0xdb, 0x24, 0x24
	.asciz "$$$$"
	.byte 0xdc, 0x23, 0x23
	.asciz "####"
	.byte 0xdd, 0x22, 0x22
	.asciz "\"\"\"\""
	.byte 0xde, 0x21, 0x21
	.asciz "!!!!"
	.byte 0xdf, 0x20, 0x20
	.asciz "    "
	.byte 0xe0, 0x1f, 0x1f
	.word 0x1f1f1f1f			; swine #0x1f1f1f
	.word 0x00e11e1e			; rsceq r1, r1, lr, lsl lr
	.word 0x1e1e1e1e			; mrcne p14, #0, r1, c14, c14, #0
	.word 0x00e21d1d			; rsceq r1, r2, sp, lsl sp
	.word 0x1d1d1d1d			; ldcne p13, c1, [sp, #-0x74]
	.word 0x00e31c1c			; rsceq r1, r3, ip, lsl ip
	.word 0x1c1c1c1c
	.word 0x00e41b1b			; rsceq r1, r4, fp, lsl fp
	.word 0x1b1b1b1b			; blne 0x6ce60c
	.word 0x00e51a1a			; rsceq r1, r5, sl, lsl sl
	.word 0x1a1a1a1a			; bne 0x68e210
	.word 0x00e61919			; rsceq r1, r6, sb, lsl sb
	.word 0x19191919			; ldmdbne sb, {r0, r3, r4, r8, fp, ip}
	.word 0x00e71818			; rsceq r1, r7, r8, lsl r8
	.word 0x18181818			; ldmdane r8, {r3, r4, fp, ip}
	.word 0x00e81717			; rsceq r1, r8, r7, lsl r7
	.word 0x17171717
	.word 0x00e91616			; rsceq r1, sb, r6, lsl r6
	.word 0x16161616
	.word 0x00ea1515			; rsceq r1, sl, r5, lsl r5
	.word 0x15151515			; ldrne r1, [r5, #-0x515]
	.word 0x00eb1414			; rsceq r1, fp, r4, lsl r4
	.word 0x14141414			; ldrne r1, [r4], #-0x414
	.word 0x00ec1313			; rsceq r1, ip, r3, lsl r3
	.word 0x13131313
	.word 0x00ed1212			; rsceq r1, sp, r2, lsl r2
	.word 0x12121212			; andsne r1, r2, #0x20000001
	.word 0x00ee1111			; rsceq r1, lr, r1, lsl r1
	.word 0x11111111
	.word 0x00ef1010			; rsceq r1, pc, r0, lsl r0
	.word 0x10101010			; andsne r1, r0, r0, lsl r0
	.word 0x00f00f0f			; rscseq r0, r0, pc, lsl #30
	.word 0x0f0f0f0f			; swieq #0xf0f0f
	.word 0x00f10e0e			; rscseq r0, r1, lr, lsl #28
	.word 0x0e0e0e0e			; cdpeq p14, #0, c0, c14, c14, #0
	.word 0x00f20d0d			; rscseq r0, r2, sp, lsl #26
	.asciz "\r\r\r\r"
	.byte 0xf3, 0x0c, 0x0c
	.word 0x0c0c0c0c
	.word 0x00f40b0b			; rscseq r0, r4, fp, lsl #22
	.word 0x0b0b0b0b			; bleq 0x2ca64c

sub_7a1c:
	stmdb sp!, {r4, r5, r6, r7, lr}
	mov r4, r1
	sub sp, sp, #0xc
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r5, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r7, r0
	bl sub_0000
	mov r6, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_7ad0
	bl glue_01800838
	ldr r1, [sp, #8]
	str r0, [r1]
	mov r0, r6
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r6
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_7adc
loc_7ad0:
	bl glue_01800838
	ldr r1, [sp, #8]
	str r0, [r1]
loc_7adc:
	ldr r0, [r7]
	ldr r1, [sp, #4]
	str r0, [r1]
	add r1, sp, #4
	add r0, sp, #8
	bl sub_171c
	ldr r1, [sp]
	str r0, [r1]
	bl glue_01800978
	cmp r0, #0
	movle r0, #2
	ble sub_7b44
	ldr r1, [r7]
	ldr r0, [sp, #4]
	str r1, [r0]
	add r1, sp, #4
	add r0, sp, #8
	bl sub_171c
	ldr r1, [sp]
	str r0, [r1]
	mov r1, #0
	ldr r0, [sp, #4]
	str r1, [r0]
	add r1, sp, #4
	mov r0, sp
	bl sub_1cdc

sub_7b44:
	str r0, [r5]
	ldr r4, [r5]
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r5
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

sub_7b78:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r1
	sub sp, sp, #0x14
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r8, r0
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r6, r0
	bl sub_0000
	mov r5, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_7c50
	bl glue_01800838
	ldr r1, [sp, #8]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_7c5c
loc_7c50:
	bl glue_01800838
	ldr r1, [sp, #8]
	str r0, [r1]
loc_7c5c:
	ldr r0, [r6]
	ldr r1, [sp, #4]
	str r0, [r1]
	add r1, sp, #4
	add r0, sp, #8
	bl sub_171c
	ldr r1, [sp]
	str r0, [r1]
	bl glue_01800978
	cmp r0, #0
	movle r0, #2
	ble sub_7d74
	ldr r1, [r6]
	ldr r0, [sp, #4]
	str r1, [r0]
	add r1, sp, #4
	add r0, sp, #8
	bl sub_171c
	ldr r1, [sp]
	mov r4, #0
	str r0, [r1]
	ldr r0, [sp, #4]
	add r1, sp, #4
	str r4, [r0]
	mov r0, sp
	bl sub_1cdc
	str r0, [r8]
	ldr r0, [r6, #4]
	ldr r1, [sp, #4]
	str r0, [r1]
	add r0, sp, #4
	bl sub_1354
	ldr r1, [sp, #4]
	str r0, [r1]
	ldr r1, [r6]
	ldr r0, [sp, #0xc]
	str r1, [r0]
	add r1, sp, #0xc
	add r0, sp, #8
	bl sub_171c
	ldr r1, [sp]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	add r2, sp, #0x10
	str r4, [r0]
	add r0, sp, #4
	mov r1, #2
	bl sub_154c
	movs r4, r0
	beq loc_7d48
	mov r0, r5
	bl sub_0fc8
	add r3, sp, #0x10
	add r2, sp, #0xc
	mov r1, sp
	add r0, sp, #8
	mov lr, pc
	mov pc, r4
	b loc_7d70
loc_7d48:
	mov r1, sp
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0xc
	mov r0, r5
	bl sub_12f8
	add r1, sp, #4
	mov r0, r5
	mov r2, #2
	bl sub_13ac
loc_7d70:
	ldr r0, [r8]

sub_7d74:
	str r0, [r7]
	ldr r4, [r7]
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r8
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_7dc0:
	stmdb sp!, {r4, r5, r6, r7, lr}
	mov r5, r1
	mov r4, r2
	sub sp, sp, #0x10
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r5]
	str r0, [sp]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r7, r0
	bl sub_0000
	mov r5, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_7e80
	bl glue_01800838
	ldr r1, [sp, #0xc]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_7e8c
loc_7e80:
	bl glue_01800838
	ldr r1, [sp, #0xc]
	str r0, [r1]
loc_7e8c:
	ldr r1, [r7]
	ldr r0, [sp, #8]
	str r1, [r0]
	add r1, sp, #8
	add r0, sp, #0xc
	bl sub_171c
	ldr r1, [sp, #4]
	str r0, [r1]
	mov r1, sp
	add r0, sp, #4
	bl glue_018007f4
	mov r0, #2
	str r0, [r6]
	mov r4, r0
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, pc}

sub_7ef0:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r1
	sub sp, sp, #8
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r8, r0
	bl sub_0000
	mov r5, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_7fa4
	bl glue_01800838
	ldr r1, [sp, #4]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_7fb0
loc_7fa4:
	bl glue_01800838
	ldr r1, [sp, #4]
	str r0, [r1]
loc_7fb0:
	ldr r1, [r8]
	ldr r0, [sp]
	str r1, [r0]
	mov r1, sp
	add r0, sp, #4
	bl sub_171c
	str r0, [r7]
	bl glue_01800978
	mov r4, r0, lsl #2
	str r4, [r6]
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_8004:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r1
	sub sp, sp, #8
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	mov r0, #2
	bl glue_01800818
	mov r5, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r8, r0
	bl sub_0000
	mov r6, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_80b8
	bl glue_01800838
	ldr r1, [sp, #4]
	str r0, [r1]
	mov r0, r6
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r6
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_80c4
loc_80b8:
	bl glue_01800838
	ldr r1, [sp, #4]
	str r0, [r1]
loc_80c4:
	ldr r1, [r8]
	ldr r0, [sp]
	str r1, [r0]
	mov r1, sp
	add r0, sp, #4
	bl sub_171c
	str r0, [r7]
	bl glue_01800978
	teq r0, #0
	movne r0, #2
	moveq r0, #0x1a
	str r0, [r5]
	ldr r4, [r5]
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r5
	bl glue_01800888
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_8124:
	stmdb sp!, {r4, r5, r6, r7, lr}
	mov r5, r1
	mov r4, r2
	sub sp, sp, #0x24
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	ldr r0, [r5]
	str r0, [sp]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r6, r0
	bl sub_0000
	mov r5, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_8220
	bl glue_01800838
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #0x1c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x1c]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_822c
loc_8220:
	bl glue_01800838
	ldr r1, [sp, #0x1c]
	str r0, [r1]
loc_822c:
	ldr r1, [r6]
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	add r2, sp, #0x18
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	movs r4, r0
	beq loc_8280
	mov r0, r5
	bl sub_0fc8
	add r2, sp, #0x18
	mov r1, sp
	add r0, sp, #0x1c
	mov lr, pc
	mov pc, r4
	b loc_829c
loc_8280:
	mov r1, sp
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x14
	mov r0, r5
	mov r2, #1
	bl sub_13ac
loc_829c:
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	teq r0, #2
	beq loc_833c
	ldr r1, [r6, #4]
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	add r2, sp, #0x18
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	movs r4, r0
	beq loc_8308
	mov r0, r5
	bl sub_0fc8
	add r2, sp, #0x18
	mov r1, sp
	add r0, sp, #0x1c
	mov lr, pc
	mov pc, r4
	b loc_8324
loc_8308:
	mov r1, sp
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x14
	mov r0, r5
	mov r2, #1
	bl sub_13ac
loc_8324:
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	teq r0, #2
	beq loc_83d4
loc_833c:
	ldr r1, [r6, #0x10]
	ldr r0, [sp, #0x10]
	str r1, [r0]
	add r0, sp, #0x10
	bl sub_1354
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r1, [r6, #8]
	ldr r0, [sp, #0x14]
	str r1, [r0]
	ldr r1, [r6, #0xc]
	ldr r0, [sp, #0x18]
	add r2, sp, #0x20
	str r1, [r0]
	add r0, sp, #0x10
	mov r1, #2
	bl sub_154c
	movs r4, r0
	beq loc_83ac
	mov r0, r5
	bl sub_0fc8
	add r3, sp, #0x20
	add r2, sp, #0x18
	add r1, sp, #0x14
	add r0, sp, #0x1c
	mov lr, pc
	mov pc, r4
	b loc_83d4
loc_83ac:
	add r1, sp, #0x14
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x18
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x10
	mov r0, r5
	mov r2, #2
	bl sub_13ac
loc_83d4:
	ldr r1, [r6, #0x14]
	ldr r0, [sp, #0x10]
	str r1, [r0]
	add r0, sp, #0x10
	bl glue_01800810
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r1, [sp, #4]
	str r0, [r1]
	ldr r0, [sp]
	ldr r2, [r0]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	mov r0, sp
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x10]
	str r0, [r1]
loc_8424:
	add r0, sp, #0x10
	bl sub_19f8
	teq r0, #0
	bne loc_860c
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800920
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r1, [r6]
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	movs r4, r0
	beq loc_84b8
	mov r0, r5
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0xc
	add r0, sp, #0x1c
	mov lr, pc
	mov pc, r4
	b loc_84d4
loc_84b8:
	add r1, sp, #0xc
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x14
	mov r0, r5
	mov r2, #1
	bl sub_13ac
loc_84d4:
	ldr r1, [sp, #0x18]
	str r0, [r1]
	ldr r0, [sp, #0x18]
	ldr r0, [r0]
	teq r0, #2
	beq loc_8600
	ldr r1, [r6, #4]
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	movs r4, r0
	beq loc_8540
	mov r0, r5
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0xc
	add r0, sp, #0x1c
	mov lr, pc
	mov pc, r4
	b loc_855c
loc_8540:
	add r1, sp, #0xc
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x14
	mov r0, r5
	mov r2, #1
	bl sub_13ac
loc_855c:
	ldr r1, [sp, #0x18]
	str r0, [r1]
	ldr r0, [sp, #0x18]
	ldr r0, [r0]
	teq r0, #2
	bne loc_8600
	ldr r1, [r6, #0x18]
	ldr r0, [sp, #0x20]
	str r1, [r0]
	add r1, sp, #0x20
	add r0, sp, #0x1c
	bl sub_171c
	ldr r1, [sp, #0x14]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	movs r4, r0
	beq loc_85cc
	mov r0, r5
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0xc
	add r0, sp, #0x1c
	mov lr, pc
	mov pc, r4
	b loc_85e8
loc_85cc:
	add r1, sp, #0xc
	mov r0, r5
	bl sub_12f8
	add r1, sp, #0x14
	mov r0, r5
	mov r2, #1
	bl sub_13ac
loc_85e8:
	ldr r1, [sp, #0x18]
	add r2, sp, #0x18
	str r0, [r1]
	add r1, sp, #8
	add r0, sp, #4
	bl glue_01800a2c
loc_8600:
	add r0, sp, #0x10
	bl sub_19fc
	b loc_8424
loc_860c:
	ldr r0, [sp, #4]
	ldr r0, [r0]
	str r0, [r7]
	mov r4, r0
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}

sub_8670:
	stmdb sp!, {r4, r5, r6, r7, lr}
	mov r5, r1
	mov r4, r2
	sub sp, sp, #0x14
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r5]
	str r0, [sp]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r7, r0
	bl sub_0000
	mov r5, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_873c
	bl glue_01800838
	ldr r1, [sp, #0x10]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_8748
loc_873c:
	bl glue_01800838
	ldr r1, [sp, #0x10]
	str r0, [r1]
loc_8748:
	ldr r0, [r7]
	ldr r1, [sp, #8]
	str r0, [r1]
	add r1, sp, #8
	mov r0, sp
	bl glue_01800b04
	mov r4, #2
	teq r0, #0
	moveq r0, r4
	movne r0, #0x1a
	ldr r1, [sp, #4]
	str r0, [r1]
	teq r0, #2
	beq loc_8854
	ldr r0, [r7, #8]!
	ldr r1, [sp, #8]
	str r0, [r1]
	add r0, sp, #8
	bl sub_1354
	ldr r1, [sp, #8]
	add r2, sp, #0xc
	str r0, [r1]
	add r0, sp, #8
	mov r1, #1
	bl sub_154c
	movs r7, r0
	beq loc_87d4
	mov r0, r5
	bl sub_0fc8
	add r2, sp, #0xc
	mov r1, sp
	add r0, sp, #0x10
	mov lr, pc
	mov pc, r7
	b loc_87f0
loc_87d4:
	mov r1, sp
	mov r0, r5
	bl sub_12f8
	add r1, sp, #8
	mov r0, r5
	mov r2, #1
	bl sub_13ac
loc_87f0:
	ldr r1, [sp, #4]
	str r0, [r1]
	mov r1, #8
	ldr r0, [sp, #8]
	str r1, [r0]
	add r1, sp, r1
	add r0, sp, #4
	bl sub_1c68
	ldr r1, [sp, #0xc]
	str r0, [r1]
	mov r5, r0
	tst r0, #3
	blne glue_018007e8
	mov r0, r5, asr #2
	ldr r1, [sp, #8]
	mvn r3, #0
	mov r2, #0
	str r4, [r1]
	stmdb sp!, {r2, r3}
	add r3, sp, #0x10
	mov r1, r0
	add r0, sp, #8
	mvn r2, #0
	bl glue_01800b08
	add sp, sp, #8
loc_8854:
	ldr r0, [sp]
	ldr r0, [r0]
	str r0, [r6]
	ldr r4, [r6]
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}

sub_8898:
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov r4, r1
	mov r5, r2
	mov r8, r3
	sub sp, sp, #0x48
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x44]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x40]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x3c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x38]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x34]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x30]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x2c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x28]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x24]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	ldr r0, [r5]
	str r0, [sp, #4]
	ldr r0, [r4]
	str r0, [sp]
	ldr r0, [r8]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r5, r0
	bl sub_0000
	mov r4, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r8
	beq loc_8a0c
	bl glue_01800838
	ldr r1, [sp, #0x30]
	str r0, [r1]
	mov r0, r4
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #0x30]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r4
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x30]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_8a18
loc_8a0c:
	bl glue_01800838
	ldr r1, [sp, #0x30]
	str r0, [r1]
loc_8a18:
	mov sb, #0
	ldr r0, [sp, #8]
	str sb, [r0]
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x18]
	str r1, [r0]
	add r0, sp, #0x18
	bl sub_1354
	ldr r1, [sp, #0x18]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x20]
	str r1, [r0]
	add r0, sp, #0x20
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x20]
	str r0, [r1]
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	ldr r1, [r5]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_8abc
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_8ad8
loc_8abc:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_8ad8:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	teq r0, #2
	ldreq r0, [r5, #4]
	beq loc_ab70
	ldr r0, [r5, #8]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_8b48
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_8b64
loc_8b48:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_8b64:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r1, [r0]
	teq r1, #2
	beq loc_8c8c
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [r5, #0xc]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x38]
	str r1, [r0]
	add r0, sp, #0x38
	bl sub_1354
	ldr r1, [sp, #0x38]
	add r2, sp, #0x3c
	str r0, [r1]
	add r0, sp, #0x38
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_8c30
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x3c
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_8c4c
loc_8c30:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x38
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_8c4c:
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x2c
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	bne loc_9b68
loc_8c84:
	add r1, sp, #0x28
	b loc_a964
loc_8c8c:
	ldr r0, [r5, #0x18]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_8ce0
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_8cfc
loc_8ce0:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_8cfc:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	mov sl, #4
	mov r8, #0x1a
	ldr r1, [r0]
	teq r1, #2
	beq loc_8ea0
	ldr r1, [r5, #0x1c]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_8d6c
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, sb
	b loc_8d88
loc_8d6c:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_8d88:
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r1, [r5, #0x24]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x20]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	add r0, sp, #0x34
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #8]
	ldr r2, [r0]
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp, #0x3c]
	add r1, sp, #0x3c
	str sl, [r0]
	add r0, sp, #8
	bl sub_1ba0
	teq r0, #0
	moveq r0, #2
	ldreq r1, [sp, #0x38]
	streq r0, [r1]
	ldrne r0, [sp, #0x38]
	strne r8, [r0]
	ldr r0, [sp, #0x38]
	ldr r2, [r0]
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x34
	add r0, sp, #0x24
	mov r1, #2
	bl sub_154c
	movs r8, r0
	beq loc_8e78
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x34
	add r2, sp, #0x2c
	add r1, sp, #0x28
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_ab70
loc_8e78:
	add r1, sp, #0x28
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	mov r0, r4
	mov r2, #2
	b loc_a978
loc_8ea0:
	ldr r1, [r5, #0x28]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	bl sub_1354
	ldr r1, [sp, #0x2c]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs fp, r0
	beq loc_8ef4
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, fp
	b loc_8f10
loc_8ef4:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_8f10:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	teq r0, #2
	beq loc_98dc
	ldr r0, [r5, #0x34]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [r5, #0x2c]
	ldr r0, [sp, #0x38]
	str r1, [r0]
	add r1, sp, #0x38
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r0, [sp, #0x38]
	str sl, [r0]
	ldr r1, [r5, #0x30]
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	mov r0, #2
	ldr r1, [sp, #0x40]
	add r2, sp, #0x44
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #5
	bl sub_154c
	movs r8, r0
	beq loc_8fd4
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x44
	add r2, sp, #0x40
	add r1, sp, #0x3c
	stmdb sp!, {r1, r2, r3}
	add r3, sp, #0x44
	add r2, sp, #0xc
	add r1, sp, #0x40
	add r0, sp, #0x3c
	mov lr, pc
	mov pc, r8
	add sp, sp, #0xc
	b loc_9020
loc_8fd4:
	add r1, sp, #0x34
	mov r0, r4
	bl sub_12f8
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x38
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x40
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	mov r2, #5
	bl sub_13ac
loc_9020:
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0x38]
	ldr r0, [sp, #0x28]
	add r2, sp, #0x2c
	str r1, [r0]
	add r1, sp, #0x28
	add r0, sp, #0x30
	bl sub_1794
	ldr r0, [sp, #0x2c]
	ldr r1, [r0]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	teq r1, #2
	ldr r0, [sp, #0x24]
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	beq loc_9134
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #3
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [r5, #0x3c]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r1, [r5, #0x38]
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	add r1, sp, #0x3c
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [r5, #0x40]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	bne loc_ab10
loc_912c:
	add r1, sp, #0x2c
	b loc_a964
loc_9134:
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #3
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [r5, #0x44]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x2c]
	ldr r1, [sp, #0x38]
	str r0, [r1]
	add r1, sp, #0x38
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	bl glue_01800978
	mov r0, r0, lsl #2
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9224
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	add r1, sp, #0x2c
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9240
loc_9224:
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9240:
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r1, [r5, #0x2c]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r1, sp, #0x2c
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x24]
	str r0, [r1]
	mov r1, sp
	add r0, sp, #0x24
	bl glue_018007f4
	ldr r1, [r5, #0x4c]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r1, sp, #0x2c
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x24]
	str r0, [r1]
	add r1, sp, #0x24
	add r0, sp, #4
	bl sub_1af0
	teq r0, #0
	beq loc_93f0
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #3
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x50]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	add r0, sp, #0x3c
	bl sub_1354
	ldr r1, [sp, #0x3c]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x3c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9378
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x38
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9394
loc_9378:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9394:
	ldr r1, [sp, #0x40]
	str r0, [r1]
	ldr r0, [sp, #0x40]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_93dc
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	b loc_953c
loc_93dc:
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	b loc_9560
loc_93f0:
	mov r0, sp
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x24]
	str r0, [r1]
loc_9404:
	add r0, sp, #0x24
	bl sub_19f8
	teq r0, #0
	bne loc_9574
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800920
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0x28]
	add r1, sp, #0x28
	str sl, [r0]
	add r0, sp, #8
	bl sub_1c24
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0x54]
	ldr r0, [sp, #0x40]
	str r1, [r0]
	add r1, sp, #0x40
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r1, sp, #0x28
	add r0, sp, #0x2c
	bl sub_1af0
	teq r0, #0
	beq loc_9610
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x40]
	str r1, [r0]
	add r0, sp, #0x40
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x40]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r2, [r0]
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x58]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x40
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9550
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x40
loc_953c:
	add r1, sp, #0x2c
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_956c
loc_9550:
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
loc_9560:
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_956c:
	ldr r1, [sp, #0xc]
	str r0, [r1]
loc_9574:
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [r5, #0x78]
	ldr r0, [sp, #0x38]
	str r1, [r0]
	add r1, sp, #0x38
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x3c]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x3c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9864
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x38
	add r1, sp, #0xc
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9880
loc_9610:
	ldr r0, [r5, #0xf4]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x40]
	str r1, [r0]
	add r0, sp, #0x40
	mov r1, #4
	bl glue_01800804
	ldr r1, [sp, #0x40]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r2, [r0]
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp, #0x10]
	ldr r2, [r0]
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [r5, #0x5c]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	ldr r0, [r5, #0x60]
	ldr r1, [sp, #0x38]
	str r0, [r1]
	add r1, sp, #0x38
	add r0, sp, #0x10
	bl sub_1ba0
	teq r0, #0
	beq loc_96ec
	ldr r0, [r5, #0x64]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	add r1, sp, #0x34
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x38]
	str r0, [r1]
	teq r0, #2
	beq loc_9734
loc_96ec:
	ldr r0, [r5, #0x68]
	ldr r1, [sp, #0x38]
	str r0, [r1]
	add r1, sp, #0x38
	add r0, sp, #0x10
	bl sub_1ba0
	teq r0, #0
	beq loc_973c
	ldr r0, [r5, #0x6c]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	add r1, sp, #0x34
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x38]
	str r0, [r1]
	teq r0, #2
	bne loc_973c
loc_9734:
	ldr r0, [r5, #0x70]
	b loc_97dc
loc_973c:
	ldr r1, [r5, #0x74]
	ldr r0, [sp, #0x34]
	str r1, [r0]
	add r1, sp, #0x34
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x38]
	str r0, [r1]
	ldr r0, [sp, #0x44]
	add r1, sp, #0x44
	str sl, [r0]
	add r0, sp, #4
	bl sub_1c24
	ldr r1, [sp, #0x34]
	add r2, sp, #0x44
	str r0, [r1]
	add r0, sp, #0x38
	mov r1, #2
	bl sub_154c
	movs r8, r0
	beq loc_97b4
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x44
	add r2, sp, #0x34
	add r1, sp, #0x14
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_97dc
loc_97b4:
	add r1, sp, #0x14
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x34
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x38
	mov r0, r4
	mov r2, #2
	bl sub_13ac
loc_97dc:
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	ldr r2, [r0]
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800a24
	add r2, sp, #0x40
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9834
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x40
	add r1, sp, #0x2c
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9850
loc_9834:
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9850:
	ldr r1, [sp, #0xc]
	str r0, [r1]
	add r0, sp, #0x24
	bl sub_19fc
	b loc_9404
loc_9864:
	add r1, sp, #0xc
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9880:
	ldr r1, [sp, #0x40]
	str r0, [r1]
	ldr r0, [sp, #0x40]
	ldr r2, [r0]
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x7c]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x2c
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_8c84
	b loc_9b68
loc_98dc:
	ldr r0, [r5, #0x80]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r0, sp, #0x28
	bl sub_1354
	ldr r1, [sp, #0x28]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x28
	mov r1, #1
	bl sub_154c
	movs fp, r0
	beq loc_9930
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, fp
	b loc_994c
loc_9930:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_994c:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	teq r0, #2
	beq loc_a364
	ldr r1, [r5, #0x34]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	bl sub_1354
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [r5, #0x2c]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	add r1, sp, #0x3c
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x40]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	str sl, [r0]
	ldr r1, [r5, #0x30]
	ldr r0, [sp, #0x38]
	mov r8, #2
	str r1, [r0]
	ldr r0, [sp, #0x34]
	add r2, sp, #0x44
	str r8, [r0]
	add r0, sp, #0x2c
	mov r1, #5
	bl sub_154c
	movs sb, r0
	beq loc_9a10
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x44
	add r2, sp, #0x34
	add r1, sp, #0x38
	stmdb sp!, {r1, r2, r3}
	add r3, sp, #0x48
	add r2, sp, #0xc
	add r1, sp, #0x4c
	add r0, sp, #0x3c
	mov lr, pc
	mov pc, sb
	add sp, sp, #0xc
	b loc_9a5c
loc_9a10:
	add r1, sp, #0x40
	mov r0, r4
	bl sub_12f8
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x38
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x34
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #5
	bl sub_13ac
loc_9a5c:
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [r5, #0x38]
	ldr r1, [sp, #0x2c]
	add r2, sp, #0x28
	str r0, [r1]
	add r1, sp, #0x2c
	add r0, sp, #0x30
	bl sub_1794
	ldr r0, [sp, #0x28]
	ldr r1, [r0]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	teq r1, #2
	ldr r0, [sp, #0x24]
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	beq loc_9b7c
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	mov r1, #3
	bl glue_01800804
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [r5, #0x3c]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r1, [r5, #0x38]
	ldr r0, [sp, #0x38]
	str r1, [r0]
	add r1, sp, #0x38
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [r5, #0x40]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	add r2, sp, #0x2c
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_8c84
loc_9b68:
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	add r1, sp, #0x28
	b loc_ab64
loc_9b7c:
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	add r0, sp, #0x2c
	mov r1, #4
	bl glue_01800804
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [r5, #0x8c]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r1, [r5, #0x2c]
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	add r1, sp, #0x3c
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x38]
	str r0, [r1]
	bl glue_01800978
	mov r0, r0, lsl #2
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	mov r0, sp
	bl glue_01800834
	ldr r1, [sp, #0x38]
	str r0, [r1]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	add r1, sp, #0x3c
	add r0, sp, #0x38
	bl sub_1bf8
	teq r0, #0
	beq loc_9d4c
	ldr r0, [r5, #0xf4]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	add r0, sp, #0x3c
	bl sub_1354
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	ldr r0, [r5, #0x14]
	ldr r1, [sp, #0x40]
	str r0, [r1]
	add r0, sp, #0x40
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x40]
	str r0, [r1]
	ldr r1, [sp, #0x38]
	str r0, [r1]
	mov r0, sp
	bl glue_01800834
	ldr r1, [sp, #0x44]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x5c]
	ldr r1, [sp, #0x44]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x40]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x40
	add r0, sp, #0x3c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9d24
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x40
	add r1, sp, #0x38
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9d40
loc_9d24:
	add r1, sp, #0x38
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9d40:
	ldr r1, [sp, #0x34]
	str r0, [r1]
	b loc_9d54
loc_9d4c:
	ldr r0, [sp, #0x34]
	str r8, [r0]
loc_9d54:
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800a24
	add r2, sp, #0x2c
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9da4
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	add r1, sp, #0x28
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9dc0
loc_9da4:
	add r1, sp, #0x28
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9dc0:
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r0, [r5, #0x2c]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	add r1, sp, #0x28
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x24]
	str r0, [r1]
	mov r1, sp
	add r0, sp, #0x24
	bl glue_018007f4
	ldr r1, [r5, #0x4c]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r1, sp, #0x28
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x24]
	str r0, [r1]
	add r1, sp, #0x24
	add r0, sp, #4
	bl sub_1af0
	teq r0, #0
	beq loc_9f70
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	mov r1, #3
	bl glue_01800804
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r2, [r0]
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x50]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	add r0, sp, #0x3c
	bl sub_1354
	ldr r1, [sp, #0x3c]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x3c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9ef8
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x38
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_9f14
loc_9ef8:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_9f14:
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x2c]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	add r2, sp, #0x2c
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_9f5c
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	b loc_a0a4
loc_9f5c:
	add r1, sp, #0x28
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	b loc_a0c8
loc_9f70:
	mov r0, sp
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x24]
	str r0, [r1]
loc_9f84:
	add r0, sp, #0x24
	bl sub_19f8
	teq r0, #0
	bne loc_a0dc
	ldr r0, [sp, #0x24]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0x2c]
	add r1, sp, #0x2c
	str sl, [r0]
	add r0, sp, #8
	bl sub_1c24
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [r5, #0x54]
	ldr r0, [sp, #0x34]
	str r1, [r0]
	add r1, sp, #0x34
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	add r1, sp, #0x2c
	add r0, sp, #0x28
	bl sub_1af0
	teq r0, #0
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	beq loc_a178
	bl sub_1354
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x34]
	str r1, [r0]
	add r0, sp, #0x34
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r2, [r0]
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0x58]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x34
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a0b8
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x34
loc_a0a4:
	add r1, sp, #0x28
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a0d4
loc_a0b8:
	add r1, sp, #0x28
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
loc_a0c8:
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a0d4:
	ldr r1, [sp, #0xc]
	str r0, [r1]
loc_a0dc:
	ldr r1, [r5, #0xf4]
	ldr r0, [sp, #0x24]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0x78]
	ldr r0, [sp, #0x38]
	str r1, [r0]
	add r1, sp, #0x38
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x3c]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x3c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a2ec
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x38
	add r1, sp, #0xc
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a308
loc_a178:
	bl sub_1354
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x34]
	str r1, [r0]
	add r0, sp, #0x34
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r2, [r0]
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r1, [r5, #0x74]
	ldr r0, [sp, #0x40]
	str r1, [r0]
	add r1, sp, #0x40
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x38]
	str r0, [r1]
	ldr r0, [sp, #0x44]
	add r1, sp, #0x44
	str sl, [r0]
	add r0, sp, #4
	bl sub_1c24
	ldr r1, [sp, #0x40]
	add r2, sp, #0x44
	str r0, [r1]
	add r0, sp, #0x38
	mov r1, #2
	bl sub_154c
	movs r8, r0
	beq loc_a23c
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x44
	add r2, sp, #0x40
	add r1, sp, #0x14
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a264
loc_a23c:
	add r1, sp, #0x14
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x40
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x38
	mov r0, r4
	mov r2, #2
	bl sub_13ac
loc_a264:
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	ldr r2, [r0]
	ldr r0, [sp, #0x34]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x34
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a2bc
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x34
	add r1, sp, #0x28
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a2d8
loc_a2bc:
	add r1, sp, #0x28
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a2d8:
	ldr r1, [sp, #0xc]
	str r0, [r1]
	add r0, sp, #0x24
	bl sub_19fc
	b loc_9f84
loc_a2ec:
	add r1, sp, #0xc
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a308:
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0xa0]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_912c
	b loc_ab10
loc_a364:
	mov r0, sp
	bl glue_01800968
	teq r0, #0
	moveq r1, #2
	movne r1, r8
	ldr r0, [sp, #0x24]
	str r1, [r0]
	teq r1, #2
	ldr r0, [sp, #0x24]
	beq loc_a430
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #3
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r2, #0x26
	add r2, r2, #0x200
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r2, #0x26
	add r2, r2, #0x200
	mov r1, #2
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_912c
	b loc_ab10
loc_a430:
	ldr r0, [sp]
	ldr r0, [r0]
	bl glue_01800970
	teq r0, #0
	moveq r1, #2
	movne r1, r8
	ldr r0, [sp, #0x24]
	str r1, [r0]
	teq r1, #2
	ldr r0, [sp, #0x24]
	beq loc_a4e8
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r2, #0x76
	add r2, r2, #0x200
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_912c
	b loc_ab10
loc_a4e8:
	ldr r0, [r5, #0xac]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	add r0, sp, #0x2c
	bl sub_1354
	ldr r1, [sp, #0x2c]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a53c
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a558
loc_a53c:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a558:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r1, [r0]
	teq r1, #2
	beq loc_a6a4
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	add r1, sp, #0x3c
	str sb, [r0]
	mov r0, sp
	bl sub_1af0
	teq r0, #0
	ldrne r1, [r5, #0x50]
	ldrne r0, [sp, #0x34]
	strne r1, [r0]
	ldreq r0, [r5, #0xb4]
	ldreq r1, [sp, #0x34]
	streq r0, [r1]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r1, [r5, #0xb8]
	ldr r0, [sp, #0x3c]
	str r1, [r0]
	add r0, sp, #0x3c
	bl sub_1354
	ldr r1, [sp, #0x3c]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x3c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a64c
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x38
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a668
loc_a64c:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a668:
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_912c
	b loc_ab10
loc_a6a4:
	ldr r1, [r5, #0xbc]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	bl sub_1354
	ldr r1, [sp, #0x2c]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a6f8
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a714
loc_a6f8:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a714:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r1, [r0]
	teq r1, #2
	beq loc_a888
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #2
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0x3c]
	add r1, sp, #0x3c
	str sb, [r0]
	mov r0, sp
	bl sub_1af0
	teq r0, #0
	ldrne r1, [r5, #0x50]
	ldreq r1, [r5, #0xb4]
	ldr r0, [sp, #0x34]
	str r1, [r0]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r0, [r5, #0xcc]
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	add r0, sp, #0x3c
	bl sub_1354
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	ldr r1, [r5, #0xc8]
	ldr r0, [sp, #0x40]
	str r1, [r0]
	add r1, sp, #0x40
	add r0, sp, #0x30
	bl sub_171c
	ldr r1, [sp, #0x38]
	add r2, sp, #0x40
	str r0, [r1]
	add r0, sp, #0x3c
	mov r1, #2
	bl sub_154c
	movs r8, r0
	beq loc_a824
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x40
	add r2, sp, #0x38
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a84c
loc_a824:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x38
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x3c
	mov r0, r4
	mov r2, #2
	bl sub_13ac
loc_a84c:
	ldr r1, [sp, #0x34]
	str r0, [r1]
	ldr r0, [sp, #0x34]
	ldr r2, [r0]
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_912c
	b loc_ab10
loc_a888:
	ldr r1, [r5, #0xd0]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	bl sub_1354
	ldr r1, [sp, #0x2c]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a8dc
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a8f8
loc_a8dc:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a8f8:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r1, [r0]
	teq r1, #2
	beq loc_a980
	ldr r1, [sp]
	ldr r1, [r1]
	teq r1, #2
	ldreq r0, [r5, #0xd4]
	beq loc_ab70
	teq r1, #0x1a
	ldreq r0, [r5, #0xd8]
	beq loc_ab70
	ldr r1, [r5, #0xdc]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	bne loc_ab54
loc_a960:
	mov r1, sp
loc_a964:
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x24
	mov r0, r4
	mov r2, #1
loc_a978:
	bl sub_13ac
	b loc_ab70
loc_a980:
	ldr r1, [r5, #0xe0]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	add r0, sp, #0x2c
	bl sub_1354
	ldr r1, [sp, #0x2c]
	add r2, sp, #0x28
	str r0, [r1]
	add r0, sp, #0x2c
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a9d4
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	mov r1, sp
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
	b loc_a9f0
loc_a9d4:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_a9f0:
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	ldr r1, [r0]
	teq r1, #2
	beq loc_ab24
	ldr r1, [r5, #0xf4]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	str r0, [r1]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r0, sp, #0x28
	mov r1, #5
	bl glue_01800804
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [r5, #0x3c]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	mov r0, sp
	bl glue_01800834
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [r5, #0xe8]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0]
	bl glue_01800978
	mov r0, r0, lsl #2
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800a24
	ldr r0, [r5, #0x40]
	ldr r1, [sp, #0x34]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x28]
	ldr r0, [r0]
	mov r1, #4
	bl glue_01800a24
	add r2, sp, #0x28
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_912c
loc_ab10:
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x28
	add r1, sp, #0x2c
	b loc_ab64
loc_ab24:
	ldr r1, [r5, #0xdc]
	str r1, [r0]
	add r0, sp, #0x24
	bl sub_1354
	ldr r1, [sp, #0x24]
	add r2, sp, #0x2c
	str r0, [r1]
	add r0, sp, #0x24
	mov r1, #1
	bl sub_154c
	movs r8, r0
	beq loc_a960
loc_ab54:
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	mov r1, sp
loc_ab64:
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r8
loc_ab70:
	str r0, [r6]
	ldr r2, [r6]
	ldr r0, [sp, #0x20]
	ldr r0, [r0]
	mov r1, #0
	bl glue_01800a24
	ldr r2, [r5, #0xf0]!
	str r2, [r6]
	ldr r0, [sp, #0x20]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	add r2, sp, #0x20
	add r0, sp, #0x18
	mov r1, #1
	bl sub_154c
	movs r5, r0
	beq loc_abd8
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0x1c
	add r0, sp, #0x30
	mov lr, pc
	mov pc, r5
	b loc_abf4
loc_abd8:
	add r1, sp, #0x1c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x18
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_abf4:
	str r0, [r7]
	ldr r4, [r7]
	ldr r0, [sp, #0x44]
	bl glue_01800888
	ldr r0, [sp, #0x40]
	bl glue_01800888
	ldr r0, [sp, #0x3c]
	bl glue_01800888
	ldr r0, [sp, #0x38]
	bl glue_01800888
	ldr r0, [sp, #0x34]
	bl glue_01800888
	ldr r0, [sp, #0x30]
	bl glue_01800888
	ldr r0, [sp, #0x2c]
	bl glue_01800888
	ldr r0, [sp, #0x28]
	bl glue_01800888
	ldr r0, [sp, #0x24]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dbf18
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dbf3c
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x01000000
	.word 0x00000000
	.word 0x00000023			; andeq r0, r0, r3, lsr #32
	.word 0x20000000			; andhs r0, r0, r0
	.word 0x012dbf30
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dbf48
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x40000000			; andmi r0, r0, r0
	.word 0x012dbf60
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000009			; andeq r0, r0, sb
	.word 0x00800000			; addeq r0, r0, r0
	.word 0x012dbf78
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x03000000
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x06000000			; streq r0, [r0], -r0
	.word 0x012dbfb4
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dbf90
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x04000000			; streq r0, [r0], #-0
	.word 0x012dbfd8
	.word 0x00000012			; andeq r0, r0, r2, lsl r0
	.word 0x00040000			; andeq r0, r4, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x012cdb9c
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x00000000
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x38000000
	.word 0x012dbff0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dbffc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x07400000			; strbeq r0, [r0, -r0]
	.word 0x012dc014
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc020
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x20000000			; andhs r0, r0, r0
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc044
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dc074
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0x00000800			; andeq r0, r0, r0, lsl #16
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc068
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x02000000			; andeq r0, r0, #0
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x80000000			; andhi r0, r0, r0
	.word 0x012dc080
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc098
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0x012dc0b0			; strheq ip, [sp, -r0]!
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x00000000
	.word 0x03000000
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00020000			; andeq r0, r2, r0
	.word 0x012dc0c8
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc0e0
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dc104
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x03000000
	.word 0x012dc0f8
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00080000			; andeq r0, r8, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x012dc128
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x80000000			; andhi r0, r0, r0
	.word 0x012dc140
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc14c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc164
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00c00000			; sbceq r0, r0, r0
	.word 0x012dc17c
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x012dc194
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000001d			; andeq r0, r0, sp, lsl r0
	.word 0x00002000			; andeq r2, r0, r0
	.word 0x012dc1ac
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc1b8
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dc1dc
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x05000000			; streq r0, [r0, #-0]
	.word 0x012dc1d0
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012d7778
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00000200			; andeq r0, r0, r0, lsl #4
	.word 0x012dc200
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc224
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc23c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012db5c4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc278
	.word 0x00000039			; andeq r0, r0, sb, lsr r0
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00006000			; andeq r6, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x04000000			; streq r0, [r0], #-0
	.word 0x012dc260
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0x012dc290
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x01278e88
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc2c0
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00008000			; andeq r8, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x02000000			; andeq r0, r0, #0
	.word 0x012dc2b4
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc2cc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x01000000
	.word 0x012dc2e4
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc2f0
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x01000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000001			; andeq r0, r0, r1
	.space 16
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x01000000
	.word 0x01000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x01000000
	.word 0x01000000
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x01000000
	.word 0x00000000
	.word 0x01000001
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x01000000
	.word 0x01000000
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x01000100
	.word 0x01000100
	.word 0x01000100
	.word 0x01000100
	.word 0x01000100
	.word 0x01000100
	.word 0x01000100
	.word 0x01000100
	.word 0x01000000
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x20000000			; andhs r0, r0, r0
	.word 0x012dc428
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc440
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x04000000			; streq r0, [r0], #-0
	.word 0x01278e4c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc470
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000001e			; andeq r0, r0, lr, lsl r0
	.word 0x02000000			; andeq r0, r0, #0
	.word 0x012dc488
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x10000000			; andne r0, r0, r0
	.word 0x012dc494
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dc4c4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012d2e34
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x40000000			; andmi r0, r0, r0
	.word 0x012dc668
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc518
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc524
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc53c
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc554
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc56c
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc584
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc59c
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc5b4
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc5cc
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000000
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0x01278d68
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0x012dc5fc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dc614
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dc62c
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dc644
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dc674
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dc68c
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x012dc6b0
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x00000000
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x012dc6e0
	.word 0x00000032			; andeq r0, r0, r2, lsr r0
	.word 0xffffff6f
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dc6ec
	.word 0x00000031			; andeq r0, r0, r1, lsr r0
	.word 0x000000ff
	.word 0x012dc6f8
	.word 0x0000002f			; andeq r0, r0, pc, lsr #32
	.word 0xffffff6f
	.word 0x012dc704
	.word 0x0000002e			; andeq r0, r0, lr, lsr #32
	.word 0x000000ff
	.word 0x012dc710
	.word 0x0000002d			; andeq r0, r0, sp, lsr #32
	.word 0x00f00700			; rscseq r0, r0, r0, lsl #14
	.word 0x012dc71c
	.word 0x0000002c			; andeq r0, r0, ip, lsr #32
	.word 0x1f000000			; swine #0
	.word 0x012dc728
	.word 0x0000002b			; andeq r0, r0, fp, lsr #32
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dc734
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0xff1f0000
	.word 0x012dc740
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0x0000e0ff
	.word 0x012dc74c
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0xff7f0000
	.word 0x012dc758
	.word 0x00000009			; andeq r0, r0, sb
	.word 0x000080ff
	.word 0x012dc764
	.word 0x00000007			; andeq r0, r0, r7
	.word 0xff070000
	.word 0x012dc770
	.word 0x00000006			; andeq r0, r0, r6
	.word 0x0000f8ff
	.word 0x012dc77c
	.word 0x00000004			; andeq r0, r0, r4
	.word 0xffff0700
	.word 0x012dc788
	.word 0x00000003			; andeq r0, r0, r3
	.word 0xfffffff8
	.word 0x00000000
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x0000ffdf
	.word 0x012dc7b8
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00db0300			; sbcseq r0, fp, r0, lsl #6
	.word 0x012dc7c4
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dc7a0
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x08002000			; stmdaeq r0, {sp}
	.word 0x012dc7ac
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x2032c004			; eorshs ip, r2, r4
	.word 0x012dc6c8
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x08000000
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dc7e8
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0xffffff03
	.word 0x012dc7f4
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0x0000e0ff
	.word 0x012dc800
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0xffffff0f
	.word 0x012dc80c
	.word 0x00000009			; andeq r0, r0, sb
	.word 0x000080ff
	.word 0x012dc818
	.word 0x00000008			; andeq r0, r0, r8
	.word 0xffff7e00
	.word 0x00000000
	.word 0x00000007			; andeq r0, r0, r7
	.word 0x00fcffff
	.word 0x012dc7d0
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x30000000			; andlo r0, r0, r0
	.word 0x012dc7dc
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00002000			; andeq r2, r0, r0
	.word 0x012dc830
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x2001000c			; andhs r0, r1, ip
	.word 0x012dc824
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc848
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dc878
	.word 0x0000002d			; andeq r0, r0, sp, lsr #32
	.word 0x00e00000			; rsceq r0, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dc884
	.word 0x0000002c			; andeq r0, r0, ip, lsr #32
	.word 0x1f000000			; swine #0
	.word 0x012dc890
	.word 0x0000002b			; andeq r0, r0, fp, lsr #32
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dc89c
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0xff1f0000
	.word 0x012dc8a8
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0x0000e0ff
	.word 0x012dc8c0
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0xff7f0000
	.word 0x012dc8e4
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x08000000
	.word 0x012dc8cc
	.word 0x00000009			; andeq r0, r0, sb
	.word 0x000080ff
	.word 0x012dc8d8
	.word 0x00000008			; andeq r0, r0, r8
	.word 0xfffffe0f
	.word 0x00000000
	.word 0x00000007			; andeq r0, r0, r7
	.word 0x00fcffff
	.word 0x012dc860
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x012dc908
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00030000			; andeq r0, r3, r0
	.word 0x012dc8b4
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00002000			; andeq r2, r0, r0
	.word 0x012dc8fc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x2001000c			; andhs r0, r1, ip
	.word 0x012dc86c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dc938
	.word 0x0000002d			; andeq r0, r0, sp, lsr #32
	.word 0x00e00000			; rsceq r0, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dc944
	.word 0x0000002c			; andeq r0, r0, ip, lsr #32
	.word 0x1f000000			; swine #0
	.word 0x012dc950
	.word 0x0000002b			; andeq r0, r0, fp, lsr #32
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dc95c
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0xffffff7f
	.word 0x012dc968
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0x0000e0ff
	.word 0x012dc974
	.word 0x0000000b			; andeq r0, r0, fp
	.word 0x01000000
	.word 0x012dc98c
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0xffffffff
	.word 0x012dc9b0
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x98000000
	.word 0x012dc998
	.word 0x00000009			; andeq r0, r0, sb
	.word 0x000080ff
	.word 0x012dc9a4
	.word 0x00000008			; andeq r0, r0, r8
	.word 0xfffffe0f
	.word 0x00000000
	.word 0x00000007			; andeq r0, r0, r7
	.word 0x00fcffff
	.word 0x012dc920
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x012dc9e0
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x00030000			; andeq r0, r3, r0
	.word 0x012dc980
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x01000000
	.word 0x012dc9c8
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00002000			; andeq r2, r0, r0
	.word 0x012dc9d4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x2001000c			; andhs r0, r1, ip
	.word 0x012dc92c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0x06000000			; streq r0, [r0], -r0
	.word 0x012dca1c
	.word 0x00000012			; andeq r0, r0, r2, lsl r0
	.word 0x0000c001			; andeq ip, r0, r1
	.word 0x012dca28
	.word 0x0000000f			; andeq r0, r0, pc
	.word 0xeef7ffff			; mrc p15, #7, pc, c7, c15, #7
	.word 0x012dca10
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0xffff0300
	.word 0x012dca40
	.word 0x0000000e			; andeq r0, r0, lr
	.word 0xfcbfef7f
	.word 0x012dca4c
	.word 0x0000000b			; andeq r0, r0, fp
	.word 0xffffffff
	.word 0x012dca34
	.word 0x0000000c			; andeq r0, r0, ip
	.word 0xff030000
	.word 0x00000000
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0x000000e0			; andeq r0, r0, r0, ror #1
	.word 0x012def90
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x20001500			; andhs r1, r0, r0, lsl #10
	.word 0x012dca70
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0x6c000000
	.word 0x012dca04
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x14000030			; strne r0, [r0], #-0x30
	.word 0x012dc9f8
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x012dcaa0
	.word 0x00000018			; andeq r0, r0, r8, lsl r0
	.word 0xffff0f00
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dcaac
	.word 0x00000017			; andeq r0, r0, r7, lsl r0
	.word 0xbfffffff			; swilt #0xffffff
	.word 0x012dcab8
	.word 0x00000016			; andeq r0, r0, r6, lsl r0
	.word 0xfff7fffb
	.word 0x012dcad0
	.word 0x00000015			; andeq r0, r0, r5, lsl r0
	.word 0xffeffffb
	.word 0x00000000
	.word 0x00000012			; andeq r0, r0, r2, lsl r0
	.word 0x000000fe
	.word 0x012dcac4
	.word 0x00000013			; andeq r0, r0, r3, lsl r0
	.word 0xf7fd3f00
	.word 0x012dca88
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00000002			; andeq r0, r0, r2
	.word 0x012dcadc
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0x00f20000			; rscseq r0, r2, r0
	.word 0x012dca94
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dcaf4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0x00070000			; andeq r0, r7, r0
	.word 0x012dcb30
	.word 0x00000016			; andeq r0, r0, r6, lsl r0
	.word 0xfff7ff8b
	.word 0x012dcb18
	.word 0x00000017			; andeq r0, r0, r7, lsl r0
	.word 0x3f000000			; swilo #0
	.word 0x012dcb3c
	.word 0x00000015			; andeq r0, r0, r5, lsl r0
	.word 0xffeffffb
	.word 0x00000000
	.word 0x00000013			; andeq r0, r0, r3, lsl r0
	.word 0xf0fd3f00
	.word 0x012dcb24
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0x00f20000			; rscseq r0, r2, r0
	.word 0x012d062c
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dcb0c
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x03000000
	.word 0x012dcb90
	.word 0x00000025			; andeq r0, r0, r5, lsr #32
	.word 0x00000700			; andeq r0, r0, r0, lsl #14
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dcb9c
	.word 0x00000022			; andeq r0, r0, r2, lsr #32
	.word 0xffffffff
	.word 0x012dcb84
	.word 0x00000023			; andeq r0, r0, r3, lsr #32
	.word 0xff0f0000
	.word 0x012dcba8
	.word 0x00000021			; andeq r0, r0, r1, lsr #32
	.word 0xfb7effff
	.word 0x012dcbb4
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0xfbfdffff
	.word 0x012dcbcc
	.word 0x0000001f			; andeq r0, r0, pc, lsl r0
	.word 0xffeffb9f
	.word 0x012dcbe4
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0xffffffff
	.word 0x012dcbc0
	.word 0x0000001d			; andeq r0, r0, sp, lsl r0
	.word 0xff000000
	.word 0x012dcb78
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x38000000
	.word 0x00000000
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0x000000f8
	.word 0x012dcc20
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0x00000cfb
	.word 0x012dcb6c
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x02000000			; andeq r0, r0, #0
	.word 0x012dcbd8
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dcc08
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dcbfc
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00001300			; andeq r1, r0, r0, lsl #6
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dcc44
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0xfbfd3f00
	.word 0x012dcc5c
	.word 0x0000001f			; andeq r0, r0, pc, lsl r0
	.word 0xffeffb9f
	.word 0x00000000
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0xffffffff
	.word 0x012dcc50
	.word 0x0000001d			; andeq r0, r0, sp, lsl r0
	.word 0xff000000
	.word 0x012dcc2c
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x20000000			; andhs r0, r0, r0
	.word 0x012dcc98
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0x00000c1b			; andeq r0, r0, fp, lsl ip
	.word 0x012dcc68
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dcc80
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dcc38
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dccbc
	.word 0x00000029			; andeq r0, r0, sb, lsr #32
	.word 0xffffff3f
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dccc8
	.word 0x00000028			; andeq r0, r0, r8, lsr #32
	.word 0xfbfffeff
	.word 0x012dcce0
	.word 0x00000027			; andeq r0, r0, r7, lsr #32
	.word 0x0000c0ff
	.word 0x00000000
	.word 0x00000025			; andeq r0, r0, r5, lsr #32
	.word 0x0000f87d			; andeq pc, r0, sp, ror r8
	.word 0x012dccd4
	.word 0x00000026			; andeq r0, r0, r6, lsr #32
	.word 0xff0f0000
	.word 0x012dcca4
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x012dccec
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x24000000			; strhs r0, [r0], #-0
	.word 0x012dccb0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dcd04
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dcd4c
	.word 0x00000027			; andeq r0, r0, r7, lsr #32
	.word 0x0000c0ff
	.word 0x012dcd28
	.word 0x00000028			; andeq r0, r0, r8, lsr #32
	.word 0xfbff0000
	.word 0x00000000
	.word 0x00000025			; andeq r0, r0, r5, lsr #32
	.word 0x0000007c			; andeq r0, r0, ip, ror r0
	.word 0x012dcd40
	.word 0x00000026			; andeq r0, r0, r6, lsr #32
	.word 0xff0f0000
	.word 0x012dcd34
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0x24000000			; strhs r0, [r0], #-0
	.word 0x012dcd1c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dcd64
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x012dcd94
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x0a000020			; beq 0xbb88
	.word 0x00000000
	.word 0x00000000
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0x012dcda0
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x7ffdf703			; swivc #0xfdf703
	.word 0x012dcdb8
	.word 0x00000039			; andeq r0, r0, sb, lsr r0
	.word 0xfbfdf57f
	.word 0x012dcdc4
	.word 0x00000037			; andeq r0, r0, r7, lsr r0
	.word 0xf7d7ffbf
	.word 0x012dcdac
	.word 0x00000038			; andeq r0, r0, r8, lsr r0
	.word 0xeff7fbf7			; swi #0xf7fbf7
	.word 0x012dcdd0
	.word 0x00000036			; andeq r0, r0, r6, lsr r0
	.word 0xffdf5fff
	.word 0x012dcddc
	.word 0x00000035			; andeq r0, r0, r5, lsr r0
	.word 0xfff7d77f
	.word 0x012dcde8
	.word 0x00000034			; andeq r0, r0, r4, lsr r0
	.word 0x7ff5df5f			; swivc #0xf5df5f
	.word 0x012dcdf4
	.word 0x00000033			; andeq r0, r0, r3, lsr r0
	.word 0xffffffbf
	.word 0x012dce00
	.word 0x00000032			; andeq r0, r0, r2, lsr r0
	.word 0xfdf5ffef
	.word 0x012dce0c
	.word 0x00000031			; andeq r0, r0, r1, lsr r0
	.word 0xfdf7d7ff
	.word 0x012dce18
	.word 0x00000030			; andeq r0, r0, r0, lsr r0
	.word 0xffff7f7f
	.word 0x012dce24
	.word 0x0000002f			; andeq r0, r0, pc, lsr #32
	.word 0xfdf5ffef
	.word 0x012dce30
	.word 0x0000002e			; andeq r0, r0, lr, lsr #32
	.word 0xfff7d7ff
	.word 0x012dce3c
	.word 0x0000002d			; andeq r0, r0, sp, lsr #32
	.word 0x7ffdff7f			; swivc #0xfdff7f
	.word 0x012dce48
	.word 0x0000002c			; andeq r0, r0, ip, lsr #32
	.word 0xfffffd7f
	.word 0x012dce54
	.word 0x0000002b			; andeq r0, r0, fp, lsr #32
	.word 0xfdf7fbeb
	.word 0x012dce60
	.word 0x0000002a			; andeq r0, r0, sl, lsr #32
	.word 0xfffb7f7f
	.word 0x012dce6c
	.word 0x00000029			; andeq r0, r0, sb, lsr #32
	.word 0xabfffefa			; blge 0xb7d4
	.word 0x012dce78
	.word 0x00000028			; andeq r0, r0, r8, lsr #32
	.word 0xfbfffffd
	.word 0x012dce84
	.word 0x00000027			; andeq r0, r0, r7, lsr #32
	.word 0xfbfdf5ff
	.word 0x012dce90
	.word 0x00000026			; andeq r0, r0, r6, lsr #32
	.word 0xfffffffe
	.word 0x012dcea8
	.word 0x00000025			; andeq r0, r0, r5, lsr #32
	.word 0xf7d7ff7f
	.word 0x012dcf8c
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x03000c00
	.word 0x012dceb4
	.word 0x00000024			; andeq r0, r0, r4, lsr #32
	.word 0xfb7f7ffd
	.word 0x012dcec0
	.word 0x00000023			; andeq r0, r0, r3, lsr #32
	.word 0xfffffffe
	.word 0x012dcecc
	.word 0x00000022			; andeq r0, r0, r2, lsr #32
	.word 0xfeefafff
	.word 0x012dced8
	.word 0x00000021			; andeq r0, r0, r1, lsr #32
	.word 0xfb7ebfbf
	.word 0x012dcee4
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0xfbfdffff
	.word 0x012dcef0
	.word 0x0000001f			; andeq r0, r0, pc, lsl r0
	.word 0xffeffb9f
	.word 0x012dcefc
	.word 0x0000001e			; andeq r0, r0, lr, lsl r0
	.word 0xdfeff7d7			; swile #0xeff7d7
	.word 0x012dcf08
	.word 0x0000001d			; andeq r0, r0, sp, lsl r0
	.word 0xffffeffb
	.word 0x012dcf14
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0xefffaafa			; swi #0xffaafa
	.word 0x012dcf20
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0xbffeffff			; swilt #0xfeffff
	.word 0x012dcf2c
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0xfdfefabf
	.word 0x012dcf38
	.word 0x00000019			; andeq r0, r0, sb, lsl r0
	.word 0xfedf5fff
	.word 0x012dcf44
	.word 0x00000018			; andeq r0, r0, r8, lsl r0
	.word 0xbfbffeff			; swilt #0xbffeff
	.word 0x012dcf50
	.word 0x00000017			; andeq r0, r0, r7, lsl r0
	.word 0xff7fffea
	.word 0x012dcf5c
	.word 0x00000016			; andeq r0, r0, r6, lsl r0
	.word 0xfff7fffb
	.word 0x012dcf68
	.word 0x00000015			; andeq r0, r0, r5, lsl r0
	.word 0xffeffffb
	.word 0x012dcf74
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0xfbeff7d7
	.word 0x012dcf80
	.word 0x00000013			; andeq r0, r0, r3, lsl r0
	.word 0xfffdffff
	.word 0x012dcf98
	.word 0x00000012			; andeq r0, r0, r2, lsl r0
	.word 0xfffdf5ff
	.word 0x012dcd7c
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0xb8006000			; stmdalt r0, {sp, lr}
	.word 0x012dcfa4
	.word 0x00000011			; andeq r0, r0, r1, lsl r0
	.word 0xfffedf5f
	.word 0x012dcfb0
	.word 0x00000010			; andeq r0, r0, r0, lsl r0
	.word 0xffffffbf
	.word 0x012dcfbc
	.word 0x0000000f			; andeq r0, r0, pc
	.word 0xeef7fbeb			; cdp p11, #15, c15, c7, c11, #7
	.word 0x012dcfc8
	.word 0x0000000e			; andeq r0, r0, lr
	.word 0xffbfef7f
	.word 0x012dcfd4
	.word 0x0000000d			; andeq r0, r0, sp
	.word 0x7fbfdf5f			; swivc #0xbfdf5f
	.word 0x012dcfe0
	.word 0x0000000c			; andeq r0, r0, ip
	.word 0xffffbfef
	.word 0x012dcfec
	.word 0x0000000b			; andeq r0, r0, fp
	.word 0xbfffabea			; swilt #0xffabea
	.word 0x012dcff8
	.word 0x0000000a			; andeq r0, r0, sl
	.word 0xfefaffff
	.word 0x012dd004
	.word 0x00000009			; andeq r0, r0, sb
	.word 0x7fffeaff			; swivc #0xffeaff
	.word 0x012dd010
	.word 0x00000008			; andeq r0, r0, r8
	.word 0xfffffeff
	.word 0x012dd01c
	.word 0x00000007			; andeq r0, r0, r7
	.word 0xafffefaf			; swige #0xffefaf
	.word 0x012dd028
	.word 0x00000006			; andeq r0, r0, r6
	.word 0xbfbffeef			; swilt #0xbffeef
	.word 0x012dd034
	.word 0x00000005			; andeq r0, r0, r5
	.word 0xdffffbeb			; swile #0xfffbeb
	.word 0x012dd040
	.word 0x00000004			; andeq r0, r0, r4
	.word 0xefafff7f			; swi #0xafff7f
	.word 0x012dd04c
	.word 0x00000003			; andeq r0, r0, r3
	.word 0xfffdf5ff
	.word 0x012dcd88
	.word 0x00000002			; andeq r0, r0, r2
	.word 0xeffeffdf			; swi #0xfeffdf
	.word 0x012dce9c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x0000c0bf			; strheq ip, [r0], -pc
	.word 0x012dd07c
	.word 0x00000042			; andeq r0, r0, r2, asr #32
	.word 0xfffff71f
	.word 0x012dd058
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0xfb67fb93
	.word 0x012dd088
	.word 0x00000041			; andeq r0, r0, r1, asr #32
	.word 0xeffffffb			; swi #0xfffffb
	.word 0x012dd070
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x7d3fd5ff			; ldcvc p5, c13, [pc, #-0x3fc]!
	.word 0x00000000
	.word 0x00000000
	.word 0x0c000000
	.word 0x00000000
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x012cdcb0
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd094
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x03000000
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd0c4
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd0e8
	.word 0x0000003a			; andeq r0, r0, sl, lsr r0
	.word 0x07000000			; streq r0, [r0, -r0]
	.word 0x00000000
	.word 0x00000039			; andeq r0, r0, sb, lsr r0
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dd0d0
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000039			; andeq r0, r0, sb, lsr r0
	.word 0x001e0000			; andseq r0, lr, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd10c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd118
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd130
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000037			; andeq r0, r0, r7, lsr r0
	.word 0x78000000
	.word 0x012dd13c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd160
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000036			; andeq r0, r0, r6, lsr r0
	.word 0x00e00100			; rsceq r0, r0, r0, lsl #2
	.word 0x012dd16c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd190
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000035			; andeq r0, r0, r5, lsr r0
	.word 0x00780000			; rsbseq r0, r8, r0
	.word 0x012dd19c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd1c0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000034			; andeq r0, r0, r4, lsr r0
	.word 0x0000e001			; andeq lr, r0, r1
	.word 0x012dd1cc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd1f0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000033			; andeq r0, r0, r3, lsr r0
	.word 0x000000c0			; andeq r0, r0, r0, asr #1
	.word 0x012dd208
	.word 0x00000034			; andeq r0, r0, r4, lsr r0
	.word 0x07000000			; streq r0, [r0, -r0]
	.word 0x012dd1fc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd250
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000032			; andeq r0, r0, r2, lsr r0
	.word 0x1e000000			; cdpne p0, #0, c0, c0, c0, #0
	.word 0x012dd22c
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x20000000			; andhs r0, r0, r0
	.word 0x012dd238
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000031			; andeq r0, r0, r1, lsr r0
	.word 0x00780000			; rsbseq r0, r8, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd274
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd280
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd298
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000030			; andeq r0, r0, r0, lsr r0
	.word 0x00008007			; andeq r8, r0, r7
	.word 0x012dd2a4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd2c8
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x0000002f			; andeq r0, r0, pc, lsr #32
	.word 0x1e000000			; cdpne p0, #0, c0, c0, c0, #0
	.word 0x012dd2d4
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd2ec
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd304
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000002e			; andeq r0, r0, lr, lsr #32
	.word 0x00780000			; rsbseq r0, r8, r0
	.word 0x012dd310
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd334
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000002c			; andeq r0, r0, ip, lsr #32
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x012dd34c
	.word 0x0000002d			; andeq r0, r0, sp, lsr #32
	.word 0x07000000			; streq r0, [r0, -r0]
	.word 0x012dd340
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd370
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000002b			; andeq r0, r0, fp, lsr #32
	.word 0x00003c00			; andeq r3, r0, r0, lsl #24
	.word 0x012dd37c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd3a0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000002a			; andeq r0, r0, sl, lsr #32
	.word 0x00008007			; andeq r8, r0, r7
	.word 0x012dd3ac
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000029			; andeq r0, r0, sb, lsr #32
	.word 0x00000f00			; andeq r0, r0, r0, lsl #30
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd3f4
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd3dc
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x80000000			; andhi r0, r0, r0
	.word 0x012dd3e8
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd430
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dd43c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000028			; andeq r0, r0, r8, lsr #32
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x012dd40c
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd448
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000027			; andeq r0, r0, r7, lsr #32
	.word 0x001e0000			; andseq r0, lr, r0
	.word 0x012dd454
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd478
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000025			; andeq r0, r0, r5, lsr #32
	.word 0x78000000
	.word 0x012dd484
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd4a8
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000024			; andeq r0, r0, r4, lsr #32
	.word 0x00800700			; addeq r0, r0, r0, lsl #14
	.word 0x012dd4b4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000022			; andeq r0, r0, r2, lsr #32
	.word 0x00f00000			; rscseq r0, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd4e4
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x00000400			; andeq r0, r0, r0, lsl #8
	.word 0x012dd4f0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd4fc
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd52c
	.word 0x0000003f			; andeq r0, r0, pc, lsr r0
	.word 0x00020000			; andeq r0, r2, r0
	.word 0x012dd514
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000021			; andeq r0, r0, r1, lsr #32
	.word 0x0000c003			; andeq ip, r0, r3
	.word 0x012dd520
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd550
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000001e			; andeq r0, r0, lr, lsl r0
	.word 0x00007800			; andeq r7, r0, r0, lsl #16
	.word 0x012dd55c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd580
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x01000000
	.word 0x012dd58c
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000001c			; andeq r0, r0, ip, lsl r0
	.word 0xf00f0000
	.word 0x012dd598
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd5bc
	.word 0x0000003b			; andeq r0, r0, fp, lsr r0
	.word 0x00000020			; andeq r0, r0, r0, lsr #32
	.word 0x00000000
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0x000000c0			; andeq r0, r0, r0, asr #1
	.word 0x012dd5d4
	.word 0x0000001b			; andeq r0, r0, fp, lsl r0
	.word 0x03000000
	.word 0x012dd5f8
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd5c8
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x38000000
	.word 0x012dd5ec
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd610
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x0000001a			; andeq r0, r0, sl, lsl r0
	.word 0x000f0000			; andeq r0, pc, r0
	.word 0x012dd61c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd640
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000019			; andeq r0, r0, sb, lsl r0
	.word 0x00e00100			; rsceq r0, r0, r0, lsl #2
	.word 0x012dd64c
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000018			; andeq r0, r0, r8, lsl r0
	.word 0xc0030000			; andgt r0, r3, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd670
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x00002000			; andeq r2, r0, r0
	.word 0x012dd6a0
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x012dd67c
	.word 0x0000003c			; andeq r0, r0, ip, lsr r0
	.word 0x80000000			; andhi r0, r0, r0
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd6ac
	.word 0x0000003d			; andeq r0, r0, sp, lsr r0
	.word 0x01000000
	.word 0x012dd6b8
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000017			; andeq r0, r0, r7, lsl r0
	.word 0x00800f00			; addeq r0, r0, r0, lsl #30
	.word 0x012dd6c4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000
	.word 0x00000000
	.word 0x0f500000			; swieq #0x500000
	.word 0x012dd6e8
	.word 0x0000003e			; andeq r0, r0, lr, lsr r0
	.word 0x00001000			; andeq r1, r0, r0
	.word 0x00000000
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0x00007800			; andeq r7, r0, r0, lsl #16
	.word 0x012dd6f4
	.word 0x00000040			; andeq r0, r0, r0, asr #32
	.word 0x00001500			; andeq r1, r0, r0, lsl #10
	.word 0x00000000

sub_c498:
	stmdb sp!, {r4, r5, lr}
	mov r5, r1
	mov r4, r2
	sub sp, sp, #0xa4
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xa0]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x2c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x28]
	mov r0, #0
	str r0, [sp, #0x24]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #0
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	ldr r0, [r5]
	str r0, [sp, #4]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	str r0, [sp]
	bl sub_0000
	str r0, [sp, #0x24]
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_c5b4
	bl glue_01800838
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r0, [sp, #0x24]
	bl sub_29b4
	ldr r1, [sp, #0x28]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp, #0x24]
	bl sub_29d0
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_c5e8
loc_c5b4:
	bl glue_01800838
	ldr r1, [sp, #0xc]
	str r0, [r1]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x28]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800920
	ldr r1, [sp, #0x2c]
	str r0, [r1]
loc_c5e8:
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r2, #2
	mov r1, #4
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #4]!
	ldr r0, [sp, #0x10]
	str r1, [r0]
	add r0, sp, #0x10
	mov r1, #1
	bl glue_01800804
	ldr r1, [sp, #0x10]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #5
	bl glue_01800a24
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r2, #2
	mov r1, #0
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x10]!
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp]
	ldr r1, [r0, #0xc]!
	ldr r0, [sp, #0x18]
	add r2, sp, #0x20
	str r1, [r0]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_c6b4
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0x18
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	b loc_c6d0
loc_c6b4:
	add r1, sp, #0x18
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x14
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
loc_c6d0:
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	teq r0, #2
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	moveq r2, #2
	movne r2, #0x1a
	mov r1, #9
	bl glue_01800a24
	ldr r0, [sp]
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0x14]
	str r0, [r1]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x18]
	ldr r1, [sp, #0x18]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_c768
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0x18
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	b loc_c784
loc_c768:
	add r1, sp, #0x18
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x14
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
loc_c784:
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	teq r0, #2
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	moveq r2, #2
	movne r2, #0x1a
	mov r1, #8
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x10]!
	ldr r0, [sp, #0x10]
	str r1, [r0]
	add r0, sp, #0x10
	bl sub_1354
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x20]
	ldr r1, [sp, #0x14]
	add r2, sp, #0x18
	str r0, [r1]
	add r0, sp, #0x10
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_c820
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x18
	add r1, sp, #0x14
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	ldr r1, [sp, #0x20]
	b loc_c840
loc_c820:
	add r1, sp, #0x14
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x10
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
	ldr r1, [sp, #0x14]
loc_c840:
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xc
	bl glue_01800a24
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xc
	bl glue_01800920
	ldr r1, [sp, #0x14]
	str r0, [r1]
	add r0, sp, #0x14
	bl glue_01800968
	teq r0, #0
	moveq r1, #2
	movne r1, #0x1a
	ldr r0, [sp, #0x10]
	str r1, [r0]
	teq r1, #2
	ldr r0, [sp, #0x10]
	bne loc_c8b8
	ldr r1, [sp]
	ldr r1, [r1, #0x2c]
	str r1, [r0]
	mov r2, r1
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xc
	bl glue_01800a24
loc_c8b8:
	ldr r0, [sp]
	ldr r1, [r0, #0x10]!
	ldr r0, [sp, #0x10]
	str r1, [r0]
	add r0, sp, #0x10
	bl sub_1354
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp]
	ldr r1, [r0, #0x30]!
	ldr r0, [sp, #0x14]
	add r2, sp, #0x18
	str r1, [r0]
	add r0, sp, #0x10
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_c928
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x18
	add r1, sp, #0x14
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	ldr r1, [sp, #0x20]
	b loc_c948
loc_c928:
	add r1, sp, #0x14
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x10
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
	ldr r1, [sp, #0x14]
loc_c948:
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #6
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x38]!
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #6
	bl glue_01800920
	ldr r1, [sp, #0x18]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_c9d4
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0x18
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	b loc_c9f0
loc_c9d4:
	add r1, sp, #0x18
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x14
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
loc_c9f0:
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r0, [r0]
	mov r5, #0
	teq r0, #2
	beq loc_ca44
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #6
	bl glue_01800920
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x14]
	add r1, sp, #0x14
	str r5, [r0]
	add r0, sp, #0x10
	bl sub_1a2c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_ca5c
loc_ca44:
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r2, #0x40000
	sub r2, r2, #4
	mov r1, #6
	bl glue_01800a24
loc_ca5c:
	ldr r0, [sp]
	ldr r1, [r0, #0x10]!
	ldr r0, [sp, #0x14]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x40]
	ldr r1, [sp, #0x10]
	add r2, sp, #0x18
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_cacc
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x18
	add r1, sp, #0x10
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	ldr r1, [sp, #0x20]
	b loc_caec
loc_cacc:
	add r1, sp, #0x10
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x14
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
	ldr r1, [sp, #0x10]
loc_caec:
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #7
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x38]!
	ldr r0, [sp, #0x10]
	str r1, [r0]
	add r0, sp, #0x10
	bl sub_1354
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #7
	bl glue_01800920
	ldr r1, [sp, #0x18]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x10
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_cb78
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x20
	add r1, sp, #0x18
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	b loc_cb94
loc_cb78:
	add r1, sp, #0x18
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x10
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
loc_cb94:
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0x14]
	ldr r0, [r0]
	teq r0, #2
	beq loc_cbe4
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #7
	bl glue_01800920
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	add r1, sp, #0x10
	str r5, [r0]
	add r0, sp, #0x14
	bl sub_1a2c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_cbfc
loc_cbe4:
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r2, #0x40000
	sub r2, r2, #4
	mov r1, #7
	bl glue_01800a24
loc_cbfc:
	ldr r0, [sp]
	ldr r1, [r0, #0x48]!
	ldr r0, [sp, #0x10]
	add r3, sp, #0x2c
	add r2, sp, #0x28
	str r1, [r0]
	add r1, sp, #0xc
	add r0, sp, #0x10
	bl sub_1854
	ldr r1, [sp, #0x14]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xb
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x50]!
	ldr r0, [sp, #0x10]
	add r3, sp, #0x2c
	add r2, sp, #0x28
	str r1, [r0]
	add r1, sp, #0xc
	add r0, sp, #0x10
	bl sub_1854
	ldr r1, [sp, #0x14]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xa
	bl glue_01800a24
	bl sub_0f10
	str r0, [sp, #0x30]
	bl sub_1a84
	str r5, [sp, #0x34]
	add r0, sp, #0x3c
	bl glue_01800040
	add r4, sp, #0x34
	teq r0, #0
	bne loc_cdc0
	mov r0, r4
	bl glue_01801748
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xb
	bl glue_01800920
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r1, #0xa
	bl glue_01800920
	ldr r1, [sp, #0x18]
	str r0, [r1]
	ldr r0, [sp, #0x20]
	add r2, sp, #0xa0
	str r5, [r0]
	add r0, sp, #0x18
	mov r1, #2
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_cd20
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r3, sp, #0xa0
	add r2, sp, #0x20
	add r1, sp, #4
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	b loc_cd48
loc_cd20:
	add r1, sp, #4
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x20
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x18
	mov r2, #2
	ldr r0, [sp, #0x24]
	bl sub_13ac
loc_cd48:
	ldr r1, [sp, #0x14]
	add r2, sp, #0x18
	str r0, [r1]
	add r0, sp, #0x10
	mov r1, #1
	bl sub_154c
	str r0, [sp, #0x1c]
	teq r0, #0
	beq loc_cd8c
	ldr r0, [sp, #0x24]
	bl sub_0fc8
	add r2, sp, #0x18
	add r1, sp, #0x14
	add r0, sp, #0xc
	mov lr, pc
	ldr pc, [sp, #0x1c]
	b loc_cda8
loc_cd8c:
	add r1, sp, #0x14
	ldr r0, [sp, #0x24]
	bl sub_12f8
	add r1, sp, #0x10
	mov r2, #1
	ldr r0, [sp, #0x24]
	bl sub_13ac
loc_cda8:
	ldr r1, [sp, #8]
	str r0, [r1]
	bl sub_1c54
	ldr r0, [sp, #0x30]
	bl sub_181c
	b loc_ce68
loc_cdc0:
	bl sub_1c54
	bl sub_23ec
	ldr r0, [sp, #0x30]
	bl sub_1300
	ldr r0, [sp, #0x30]
	bl sub_181c
	ldr r0, [sp, #0x94]
	adr r1, str_ce0c, #30
	bl glue_01801860
	teq r0, #0
	beq loc_ce1c
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r2, #2
	mov r1, #5
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x60]!
	b loc_ce4c
str_ce0c:
	.asciz "evt.ex.outofmem"
loc_ce1c:
	ldr r0, [sp, #0x94]
	adr r1, str_ce58, #30
	bl glue_01801860
	teq r0, #0
	beq loc_ce60
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	mov r2, #2
	mov r1, #5
	bl glue_01800a24
	ldr r0, [sp]
	ldr r1, [r0, #0x64]!
loc_ce4c:
	ldr r0, [sp, #8]
	str r1, [r0]
	b loc_ce68
str_ce58:
	.asciz "evt.ex"
	.align 4
loc_ce60:
	mov r0, r4
	bl glue_01801820
loc_ce68:
	mov r0, r4
	bl glue_01801784
	ldr r0, [sp, #8]
	ldr r4, [r0]
	ldr r0, [sp, #0xa0]
	bl glue_01800888
	ldr r0, [sp, #0x2c]
	bl glue_01800888
	ldr r0, [sp, #0x28]
	bl glue_01800888
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0xa4
	ldmia sp!, {r4, r5, pc}
	.word 0x01281728
	.word 0x00000ac0			; andeq r0, r0, r0, asr #21
	.word 0x0128cf34
	.word 0x01281728
	.word 0x00000ac0			; andeq r0, r0, r0, asr #21
	.word 0x00000000
	.word 0x01278850
	.word 0x00000000
	.word 0x01279dd0
	.word 0x0128cc50
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00040000			; andeq r0, r4, r0
	.word 0x0128cbf0
	.word 0x01281728
	.word 0x00000b00			; andeq r0, r0, r0, lsl #22
	.word 0x0128cf54
	.word 0x012792a0
	.word 0x00000000
	.word 0x012792a0
	.word 0x0128cf7c
	.word 0x01279dd0
	.word 0x00000000
	.word 0x00000000
	.word 0x000000a0			; andeq r0, r0, r0, lsr #1
	.word 0x00000000
	.word 0x01281728
	.word 0x0128cd28
	.word 0x00000000
	.word 0x00000000
	.word 0x0128cd78
	.word 0x01281800
	.word 0x00000300			; andeq r0, r0, r0, lsl #6
	.word 0x0128d430
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x08000000
	.word 0x00000000
	.word 0x00000000
	.word 0xd4c0ffff			; strble pc, [r0], #0xfff
	.word 0x00000000
	.word 0x01278148
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000088			; andeq r0, r0, r8, lsl #1
	.word 0x0128c884
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x08000000
	.word 0x0128c740
	.word 0x012817bc
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x0127fba8
	.word 0x00000000
	.word 0x00000000
	.word 0x00000088			; andeq r0, r0, r8, lsl #1
	.word 0x00000000
	.word 0x00000000
	.word 0xd4c0ffff			; strble pc, [r0], #0xfff
	.word 0x0128ea70
	.word 0x00000005			; andeq r0, r0, r5
	.word 0x01000000
	.word 0x00000000
	.word 0x0127ae94
	.word 0x00000000
	.word 0x0128c988
	.word 0x00000001			; andeq r0, r0, r1
	.word 0xff7bffff
	.word 0x00000000
	.word 0x01276bc8
	.word 0x0128c8b4
	.word 0x012817bc
	.word 0x00000180			; andeq r0, r0, r0, lsl #3
	.word 0x0128c774
	.word 0x01281624
	.word 0x00000000
	.word 0x01281728
	.word 0x0128cfac
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x01281778
	.word 0x0128ced8
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x01278550
	.word 0x00000000
	.word 0x01276bc8
	.word 0x00000000
	.word 0x0127aeb4
	.word 0x00000000
	.word 0x012792a0
	.word 0x00000000
	.word 0x01278284
	.word 0x00000000
	.word 0x01278984
	.word 0x00000000
	.word 0x01276bc8
	.word 0x0128d0bc			; strheq sp, [r8, -ip]!
	.word 0x0127aeb4
	.word 0x00000000
	.word 0x0128c0d4
	.word 0x00000000
	.word 0x012817bc
	.word 0x0127aeb4
	.word 0x0128d0cc
	.word 0x0127fc78
	.word 0x00000000
	.word 0x012825d8
	.space 16
	.word 0x01276bc8
	.word 0x00000000
	.word 0x01276bc8
	.word 0x00000000
	.word 0x01278984
	.word 0x0128cec0
	.word 0x00000000
	.word 0x0127fca8
	.word 0x0128d348
	.word 0x00000005			; andeq r0, r0, r5
	.word 0x01000000
	.word 0x00000000
	.word 0x01278984
	.word 0x00000000
	.word 0x01279550
	.word 0x00000000
	.word 0x0128cca4
	.word 0x012817bc
	.word 0x00000880			; andeq r0, r0, r0, lsl #17
	.word 0x00000000
	.word 0x01279570
	.word 0x0128d114
	.word 0x00000000
	.word 0x0127fcb8
	.word 0x0128cc2c
	.word 0x01281800
	.word 0x00000000
	.word 0x00000000
	.word 0x0128e0e0
	.word 0x0128d578
	.word 0x012819dc
	.word 0x00000300			; andeq r0, r0, r0, lsl #6
	.word 0x00000000
	.word 0x00000036			; andeq r0, r0, r6, lsr r0
	.word 0x000006e0			; andeq r0, r0, r0, ror #13
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000007			; andeq r0, r0, r7
	.word 0x00000000
	.word 0x0128d180
	.word 0x00000000
	.word 0x00000000
	.word 0xd4c0ffff			; strble pc, [r0], #0xfff
	.word 0x00000000
	.word 0x012797b8
	.word 0x0128d7dc
	.word 0x01281a2c
	.word 0x01280378
	.word 0x00000000
	.word 0x01278550
	.word 0x00000000
	.word 0x00000000
	.word 0x00401008			; subeq r1, r0, r8
	.word 0x0128df94
	.word 0x01281ae0
	.word 0x000013c0			; andeq r1, r0, r0, asr #7
	.word 0x0128dc04
	.word 0x01281ae0
	.word 0x00001300			; andeq r1, r0, r0, lsl #6
	.word 0x0128d744
	.word 0x012818cc
	.word 0x000006c0			; andeq r0, r0, r0, asr #13
	.word 0x0128d51c
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x00004000			; andeq r4, r0, r0
	.word 0x0128d174
	.word 0x01281ae0
	.word 0x00000700			; andeq r0, r0, r0, lsl #14
	.word 0x0128d544
	.word 0x01281910
	.word 0x00000000
	.word 0x00000000
	.word 0x012817bc
	.word 0x0128cd28
	.word 0x00000000
	.word 0x00000000
	.word 0x0128cef0
	.word 0x01281800
	.word 0x000006c0			; andeq r0, r0, r0, asr #13
	.word 0x0128d874
	.word 0x01281948
	.word 0x00000080			; andeq r0, r0, r0, lsl #1
	.word 0x0128dd28
	.word 0x01281ae0
	.word 0x00000dc0			; andeq r0, r0, r0, asr #27
	.word 0x0128d234
	.word 0x01281800
	.word 0x000006c4			; andeq r0, r0, r4, asr #13
	.word 0x00000000
	.word 0x01279cb0
	.word 0x00000000
	.word 0x012787d0
	.word 0x00000000
	.word 0x00000000
	.word 0x0127866c
	.word 0x00000000
	.word 0x01276bc8
	.word 0x0128d280
	.word 0x012797b8
	.word 0x00000000
	.word 0x0128cd3c
	.word 0x00000000
	.word 0x01281800
	.word 0x012797b8
	.word 0x0128d290
	.word 0x0127fde8
	.word 0x00000000
	.word 0x01282644
	.space 16
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00800000			; addeq r0, r0, r0
	.word 0x0128ebf0
	.word 0x01281aa8
	.word 0x00000000
	.word 0x01276bc8
	.word 0x00000000
	.word 0x01278968
	.word 0x00000000
	.word 0x0128cafc
	.word 0x01281800
	.word 0x00000800			; andeq r0, r0, r0, lsl #16
	.word 0x00000000
	.word 0x01278984
	.word 0x0128cd64
	.word 0x00000000
	.word 0x0127fe18
	.word 0x0128c244
	.word 0x01281838
	.word 0x00000000
	.word 0x00000000
	.word 0x01276bc8
	.word 0x00000000
	.word 0x01279550
	.word 0x00000000
	.word 0x0128d140
	.word 0x01281800
	.word 0x00000880			; andeq r0, r0, r0, lsl #17
	.word 0x00000000
	.word 0x01279570
	.word 0x0128d2fc
	.word 0x00000000
	.word 0x0127fe28
	.word 0x0128d40c
	.word 0x00000004			; andeq r0, r0, r4
	.word 0x00810000			; addeq r0, r1, r0
	.word 0x00000000
	.word 0x01279100
	.word 0x0128d454
	.word 0x01281910
	.word 0x00000600			; andeq r0, r0, r0, lsl #12
	.word 0x00000000
	.word 0x0128d180
	.word 0x0128d418
	.word 0x01281910
	.word 0x00000280			; andeq r0, r0, r0, lsl #5
	.word 0x00000000
	.word 0x01278850
	.word 0x0128d6d0
	.word 0x00000001			; andeq r0, r0, r1
	.word 0xff7bffff
	.word 0x00000000
	.word 0x012797b8
	.word 0x0128d5dc
	.word 0x00000000
	.word 0x012801e8
	.word 0x00000000
	.word 0x01278650
	.word 0x00000000
	.word 0x01278e64
	.word 0x01281c10
	.word 0x00000280			; andeq r0, r0, r0, lsl #5
	.word 0x0128d308
	.word 0x01281ae0
	.word 0x00000000
	.word 0x0128d1f0
	.word 0x01281910
	.word 0x000006c0			; andeq r0, r0, r0, asr #13
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0x0128d220
	.word 0x01281800
	.word 0x0128ced8
	.space 16
	.word 0xd4c0ffff			; strble pc, [r0], #0xfff
	.word 0x0128cc14
	.word 0x012818cc
	.word 0x00000280			; andeq r0, r0, r0, lsl #5
	.word 0x00000000
	.word 0x00000000
	.word 0x00008080			; andeq r8, r0, r0, lsl #1
	.word 0x0128d160
	.word 0x01281838
	.word 0x00000200			; andeq r0, r0, r0, lsl #4
	.word 0x0128d724
	.word 0x01281910
	.word 0x00000300			; andeq r0, r0, r0, lsl #6
	.word 0x0128d7d0
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x2208007c			; andhs r0, r8, #0x7c
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0x00000000
	.word 0x01279ab0
	.word 0x00000000
	.word 0x0128c7e4
	.word 0x012818cc
	.word 0x00000600			; andeq r0, r0, r0, lsl #12
	.word 0x00000000
	.word 0x01276bc8
	.word 0x0128c464
	.word 0x01281838
	.word 0x00000800			; andeq r0, r0, r0, lsl #16
	.word 0x0128cf20
	.word 0x01281838
	.word 0x000004c0			; andeq r0, r0, r0, asr #9
	.word 0x00000000
	.word 0x01278e48
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0x0128d2e8
	.word 0x01281838
	.word 0x00000500			; andeq r0, r0, r0, lsl #10
	.word 0x00000000
	.word 0x01278984
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000014			; andeq r0, r0, r4, lsl r0
	.word 0x00000000
	.word 0x0127833c
	.word 0x00000000
	.word 0x00000000
	.word 0x01278850
	.word 0x0128cefc
	.word 0x01281888
	.word 0x01280028
	.word 0x0128d328
	.word 0x01281838
	.word 0x00000580			; andeq r0, r0, r0, lsl #11
	.word 0x00000000
	.word 0x01279570
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000054			; andeq r0, r0, r4, asr r0
	.word 0x0128d4c8
	.word 0x012818cc
	.word 0x01280118
	.word 0x00000000
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0
	.word 0x00000100			; andeq r0, r0, r0, lsl #2
	.word 0x00000000
	.word 0x00000000
	.word 0x01000001
	.word 0x00000001			; andeq r0, r0, r1
	.word 0x00000000
	.word 0x00010000			; andeq r0, r1, r0

sub_d4cc:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r2
	sub sp, sp, #8
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	mov r0, #2
	bl glue_01800818
	mov r5, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r8, r0
	bl sub_0000
	mov r6, r0
	bl sub_0fa4
	teq r0, #0
	mov r0, r4
	beq loc_d580
	bl glue_01800838
	ldr r1, [sp, #4]
	str r0, [r1]
	mov r0, r6
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r6
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_d58c
loc_d580:
	bl glue_01800838
	ldr r1, [sp, #4]
	str r0, [r1]
loc_d58c:
	ldr r0, [r8]
	ldr r1, [sp]
	str r0, [r1]
	mov r1, sp
	add r0, sp, #4
	bl sub_171c
	str r0, [r7]
	teq r0, #2
	moveq r0, #2
	str r0, [r5]
	ldr r4, [r5]
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r5
	bl glue_01800888
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_d5e4:
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r1
	sub sp, sp, #0xac
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xa8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xa4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xa0]
	mov r0, #0
	str r0, [sp, #0x9c]
	str r0, [sp, #0x98]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x94]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x90]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x8c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x88]
	mov r0, #0
	str r0, [sp, #0x84]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x80]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x7c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x78]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	str r0, [sp]
	bl sub_0000
	str r0, [sp, #0x98]
	bl sub_29b4
	ldr r1, [sp, #0xa0]
	str r0, [r1]
	ldr r0, [sp, #0x98]
	bl sub_29d0
	ldr r1, [sp, #0xa4]
	str r0, [r1]
	ldr r0, [sp, #0x98]
	bl sub_0fa4
	str r0, [sp, #0x9c]
	teq r0, #0
	mov r0, r4
	beq loc_d724
	bl glue_01800838
	ldr r1, [sp, #0x80]
	str r0, [r1]
	ldr r0, [sp, #0x98]
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #0x80]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	ldr r0, [sp, #0x98]
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x80]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_d730
loc_d724:
	bl glue_01800838
	ldr r1, [sp, #0x80]
	str r0, [r1]
loc_d730:
	bl sub_0f10
	str r0, [sp, #8]
	bl sub_1a84
	mov r5, #0
	str r5, [sp, #0xc]
	add r0, sp, #0x14
	mov r6, r0
	bl glue_01800040
	add r4, sp, #0xc
	teq r0, #0
	bne loc_d9d0
	mov r0, r4
	bl glue_01801748
	ldr r0, [sp]
	ldr r1, [r0, #4]!
	ldr r0, [sp, #0x7c]
	str r1, [r0]
	add r1, sp, #0x7c
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x78]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #4]
	ldr r1, [sp, #0x7c]
	str r0, [r1]
	add r1, sp, #0x7c
	add r0, sp, #0x78
	bl sub_1ba0
	str r0, [sp, #0x84]
	teq r0, #0
	ldr r0, [sp]
	beq loc_d8ac
	ldr r0, [r0, #0x10]
	ldr r1, [sp, #0x78]
	str r0, [r1]
	add r1, sp, #0x78
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x7c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0x14]
	ldr r1, [sp, #0x78]
	add r3, sp, #0x88
	str r0, [r1]
	add r1, sp, #0x78
	add r0, sp, #0x7c
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x78]
	str r0, [r1]
	ldr r0, [sp]
	ldr r1, [r0, #8]!
	ldr r0, [sp, #0x90]
	str r1, [r0]
	add r1, sp, #0x90
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x8c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	ldr r1, [sp, #0x94]
	str r0, [r1]
	add r1, sp, #0x94
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x90]
	add r2, sp, #0x94
	str r0, [r1]
	add r0, sp, #0x78
	mov r1, #2
	bl sub_154c
	str r0, [sp, #0x84]
	teq r0, #0
	beq loc_d880
	add r2, sp, #0x88
	add r1, sp, #0x7c
	ldr r0, [sp, #0x98]
	bl sub_0fe4
	add r3, sp, #0x94
	add r2, sp, #0x90
	b loc_d974
loc_d880:
	add r1, sp, #0x8c
	ldr r0, [sp, #0x98]
	bl sub_12f8
	add r1, sp, #0x90
	ldr r0, [sp, #0x98]
	bl sub_12f8
	mov r3, #2
	stmdb sp!, {r3}
	add r3, sp, #0x7c
	add r2, sp, #0x8c
	b loc_d9b0
loc_d8ac:
	ldr r1, [r0, #0x10]!
	ldr r0, [sp, #0x78]
	str r1, [r0]
	add r1, sp, #0x78
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x7c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r1, [r0, #0x18]!
	ldr r0, [sp, #0x78]
	add r3, sp, #0x90
	str r1, [r0]
	add r1, sp, #0x78
	add r0, sp, #0x7c
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x78]
	str r0, [r1]
	ldr r0, [sp]
	ldr r1, [r0, #8]!
	ldr r0, [sp, #0x94]
	str r1, [r0]
	add r1, sp, #0x94
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x8c]
	str r0, [r1]
	ldr r0, [sp]
	ldr r0, [r0, #0xc]
	ldr r1, [sp, #0xa8]
	str r0, [r1]
	add r1, sp, #0xa8
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x94]
	add r2, sp, #0xa8
	str r0, [r1]
	add r0, sp, #0x78
	mov r1, #2
	bl sub_154c
	str r0, [sp, #0x84]
	teq r0, #0
	beq loc_d988
	add r2, sp, #0x90
	add r1, sp, #0x7c
	ldr r0, [sp, #0x98]
	bl sub_0fe4
	add r3, sp, #0xa8
	add r2, sp, #0x94
loc_d974:
	add r1, sp, #0x8c
	add r0, sp, #0x7c
	mov lr, pc
	ldr pc, [sp, #0x84]
	b loc_d9c0
loc_d988:
	add r1, sp, #0x8c
	ldr r0, [sp, #0x98]
	bl sub_12f8
	add r1, sp, #0x94
	ldr r0, [sp, #0x98]
	bl sub_12f8
	mov r3, #2
	stmdb sp!, {r3}
	add r3, sp, #0x7c
	add r2, sp, #0x94
loc_d9b0:
	add r1, sp, #0x80
	ldr r0, [sp, #0x9c]
	bl sub_150c
	add sp, sp, #4
loc_d9c0:
	bl sub_1c54
	ldr r0, [sp, #8]
	bl sub_181c
	b loc_da00
loc_d9d0:
	bl sub_1c54
	bl sub_23ec
	ldr r0, [sp, #8]
	bl sub_1300
	ldr r0, [sp, #8]
	bl sub_181c
	ldr r0, [sp, #0x6c]
	adr r1, str_daf0, #30
	bl glue_01801860
	teq r0, #0
	moveq r0, r4
	bleq glue_01801820
loc_da00:
	mov r0, r4
	bl glue_01801784
	bl sub_0f10
	str r0, [sp, #8]
	bl sub_1a84
	mov r0, r6
	str r5, [sp, #0xc]
	bl glue_01800040
	mov r6, #2
	teq r0, #0
	bne loc_db10
	mov r0, r4
	bl glue_01801748
	ldr r0, [sp]
	ldr r0, [r0, #0x1c]
	ldr r1, [sp, #0x8c]
	str r0, [r1]
	add r1, sp, #0x8c
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #0x94]
	str r0, [r1]
	mov r0, #4
	ldr r1, [sp, #0x8c]
	str r0, [r1]
	add r1, sp, #0x8c
	add r0, sp, #0x94
	bl sub_1c68
	ldr r1, [sp, #0x78]
	str r0, [r1]
	ldr r0, [sp]
	ldr r1, [r0, #0x1c]!
	ldr r0, [sp, #0x8c]
	add r2, sp, #0x78
	str r1, [r0]
	add r1, sp, #0x8c
	add r0, sp, #0x80
	bl sub_1794
	ldr r0, [sp, #0x78]
	ldr r1, [r0]
	ldr r0, [sp, #0x7c]
	str r1, [r0]
	ldr r0, [sp, #0x78]
	add r1, sp, #0x78
	str r5, [r0]
	add r0, sp, #0x7c
	bl sub_1af0
	str r0, [sp, #0x84]
	teq r0, #0
	beq loc_daf8
	ldr r0, [sp]
	ldr r1, [r0, #0x20]!
	ldr r0, [sp, #0x78]
	str r1, [r0]
	add r1, sp, #0x78
	add r0, sp, #0x80
	bl sub_171c
	ldr r1, [sp, #4]
	str r0, [r1]
	b loc_db00
str_daf0:
	.asciz "evt.ex"
	.align 4
loc_daf8:
	ldr r0, [sp, #4]
	str r6, [r0]
loc_db00:
	bl sub_1c54
	ldr r0, [sp, #8]
	bl sub_181c
	b loc_db4c
loc_db10:
	bl sub_1c54
	bl sub_23ec
	ldr r0, [sp, #8]
	bl sub_1300
	ldr r0, [sp, #8]
	bl sub_181c
	ldr r0, [sp, #0x6c]
	adr r1, str_daf0, #30
	bl glue_01801860
	teq r0, #0
	ldrne r0, [sp, #4]
	strne r6, [r0]
	bne loc_db4c
	mov r0, r4
	bl glue_01801820
loc_db4c:
	mov r0, r4
	bl glue_01801784
	ldr r0, [sp, #0x9c]
	teq r0, #0
	beq loc_db70
	add r2, sp, #0xa4
	add r1, sp, #0xa0
	ldr r0, [sp, #0x98]
	bl sub_1020
loc_db70:
	ldr r0, [sp, #4]
	ldr r4, [r0]
	ldr r0, [sp, #0xa8]
	bl glue_01800888
	ldr r0, [sp, #0xa4]
	bl glue_01800888
	ldr r0, [sp, #0xa0]
	bl glue_01800888
	ldr r0, [sp, #0x94]
	bl glue_01800888
	ldr r0, [sp, #0x90]
	bl glue_01800888
	ldr r0, [sp, #0x8c]
	bl glue_01800888
	ldr r0, [sp, #0x88]
	bl glue_01800888
	ldr r0, [sp, #0x80]
	bl glue_01800888
	ldr r0, [sp, #0x7c]
	bl glue_01800888
	ldr r0, [sp, #0x78]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0xac
	ldmia sp!, {r4, r5, r6, pc}

sub_dbdc:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r1
	sub sp, sp, #0x20
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r7, r0
	bl sub_0000
	mov r5, r0
	bl sub_29b4
	ldr r1, [sp, #0x18]
	str r0, [r1]
	mov r0, r5
	bl sub_29d0
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	mov r0, r5
	bl sub_0fa4
	movs r8, r0
	mov r0, r4
	beq loc_dcf4
	bl glue_01800838
	ldr r1, [sp, #0x14]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	ldr r1, [sp]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x14]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x14]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_dd10
loc_dcf4:
	bl glue_01800838
	ldr r1, [sp, #0x14]
	str r0, [r1]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp]
	str r0, [r1]
loc_dd10:
	ldr r0, [r7, #4]
	ldr r1, [sp, #4]
	add r3, sp, #8
	str r0, [r1]
	add r1, sp, #4
	mov r0, sp
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #4]
	str r0, [r1]
	ldr r0, [r7]
	ldr r1, [sp, #0x10]
	str r0, [r1]
	add r1, sp, #0x10
	add r0, sp, #0x14
	bl sub_171c
	ldr r1, [sp, #0xc]
	add r2, sp, #0x10
	str r0, [r1]
	add r0, sp, #4
	mov r1, #1
	bl sub_154c
	movs r4, r0
	beq loc_dd98
	add r2, sp, #8
	mov r1, sp
	mov r0, r5
	bl sub_0fe4
	add r2, sp, #0x10
	add r1, sp, #0xc
	mov r0, sp
	mov lr, pc
	mov pc, r4
	b loc_ddc4
loc_dd98:
	add r1, sp, #0xc
	mov r0, r5
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #8
	add r2, sp, #0xc
	add r1, sp, #4
	mov r0, r5
	bl sub_150c
	add sp, sp, #4
loc_ddc4:
	teq r8, #0
	str r0, [r6]
	beq loc_dde0
	add r2, sp, #0x1c
	add r1, sp, #0x18
	mov r0, r5
	bl sub_1020
loc_dde0:
	ldr r4, [r6]
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_de38:
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	mov r4, r1
	mov r7, r2
	sub sp, sp, #0x40
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x3c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x38]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x34]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x30]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x2c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x28]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x24]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r4]
	str r0, [sp]
	ldr r0, [r7]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r5, r0
	bl sub_0000
	mov r4, r0
	bl sub_29b4
	ldr r1, [sp, #0x24]
	str r0, [r1]
	mov r0, r4
	bl sub_29d0
	ldr r1, [sp, #0x28]
	str r0, [r1]
	mov r0, r4
	bl sub_0fa4
	movs r8, r0
	mov r0, r7
	beq loc_dfb0
	bl glue_01800838
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	mov r0, r4
	bl sub_29b4
	ldr r1, [sp, #0x10]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x3c]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r4
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x3c]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_dfcc
loc_dfb0:
	bl glue_01800838
	ldr r1, [sp, #0x3c]
	str r0, [r1]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x10]
	str r0, [r1]
loc_dfcc:
	ldr r1, [r5, #4]
	ldr r0, [sp, #0x14]
	add r3, sp, #0x18
	str r1, [r0]
	add r1, sp, #0x14
	add r0, sp, #0x10
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x14]
	mov r7, #2
	str r0, [r1]
	teq r0, #2
	ldreq r0, [sp, #0xc]
	streq r7, [r0]
	beq loc_e390
	ldr r0, [r5]
	ldr r1, [sp, #0x1c]
	add r2, sp, #0x20
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_e054
	add r2, sp, #0x18
	add r1, sp, #0x10
	mov r0, r4
	bl sub_0fe4
	add r2, sp, #0x20
	add r1, sp, #0x1c
	add r0, sp, #0x10
	mov lr, pc
	mov pc, sb
	b loc_e080
loc_e054:
	add r1, sp, #0x1c
	mov r0, r4
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x18
	add r2, sp, #0x1c
	add r1, sp, #0x14
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_e080:
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	teq r0, #2
	beq loc_e390
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x1c]
	str r1, [r0]
	add r0, sp, #0x1c
	bl sub_1354
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	ldr r0, [r5, #8]
	ldr r1, [sp, #0x30]
	str r0, [r1]
	add r1, sp, #0x30
	add r0, sp, #0xc
	bl glue_01800928
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r1, [r5, #0xc]
	ldr r0, [sp, #0x30]
	add r3, sp, #0x34
	str r1, [r0]
	add r1, sp, #0x30
	add r0, sp, #0x2c
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x30]
	str r0, [r1]
	teq r0, #2
	ldreq r0, [sp, #4]
	streq r7, [r0]
	beq loc_e170
	add r2, sp, #0x38
	add r0, sp, #0x30
	mov r1, #0
	bl sub_154c
	movs sb, r0
	beq loc_e148
	add r2, sp, #0x34
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_0fe4
	add r1, sp, #0x38
	add r0, sp, #0x2c
	mov lr, pc
	mov pc, sb
	b loc_e168
loc_e148:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #0x34
	add r2, sp, #0x38
	add r1, sp, #0x30
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_e168:
	ldr r1, [sp, #4]
	str r0, [r1]
loc_e170:
	ldr r0, [sp, #4]
	ldr r1, [r0]
	ldr r0, [sp, #0x20]
	add r2, sp, #0x2c
	str r1, [r0]
	add r0, sp, #0x1c
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_e1b8
	mov r0, r4
	bl sub_0fc8
	add r2, sp, #0x2c
	add r1, sp, #0x20
	add r0, sp, #0x3c
	mov lr, pc
	mov pc, sb
	b loc_e1d4
loc_e1b8:
	add r1, sp, #0x20
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x1c
	mov r0, r4
	mov r2, #1
	bl sub_13ac
loc_e1d4:
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r0, [sp, #0x14]
	ldr r0, [r0]
	teq r0, #2
	beq loc_e390
	ldr r0, [r5, #0x1c]
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	add r0, sp, #0x1c
	bl sub_1354
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	mov r1, #0
	ldr r0, [sp, #0x20]
	str r1, [r0]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x2c]
	str r1, [r0]
	ldr r0, [r5, #0x18]
	ldr r1, [sp, #0x30]
	add r2, sp, #0x38
	str r0, [r1]
	add r0, sp, #0x1c
	mov r1, #5
	bl sub_154c
	movs sb, r0
	beq loc_e27c
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x38
	add r2, sp, #0x30
	add r1, sp, #0x2c
	stmdb sp!, {r1, r2, r3}
	add r3, sp, #0x2c
	add r2, sp, #0xc
	add r1, sp, #0x10
	add r0, sp, #0x48
	mov lr, pc
	mov pc, sb
	add sp, sp, #0xc
	b loc_e2c8
loc_e27c:
	add r1, sp, #4
	mov r0, r4
	bl sub_12f8
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x20
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x30
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x1c
	mov r0, r4
	mov r2, #5
	bl sub_13ac
loc_e2c8:
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r0, [sp, #8]
	ldr r1, [r0]
	ldr r0, [sp, #0x14]
	str r1, [r0]
	teq r1, #2
	ldr r0, [sp, #0x14]
	beq loc_e390
	ldr r1, [r5, #0x20]
	str r1, [r0]
	add r0, sp, #0x14
	bl sub_1354
	ldr r1, [sp, #0x14]
	str r0, [r1]
	ldr r1, [r5, #8]!
	ldr r0, [sp, #0x30]
	str r1, [r0]
	add r1, sp, #0x30
	add r0, sp, #0xc
	bl glue_01800928
	ldr r1, [sp, #0x1c]
	add r2, sp, #0x30
	str r0, [r1]
	add r0, sp, #0x14
	mov r1, #2
	bl sub_154c
	movs r5, r0
	beq loc_e360
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x30
	add r2, sp, #8
	add r1, sp, #0x1c
	add r0, sp, #0x3c
	mov lr, pc
	mov pc, r5
	b loc_e388
loc_e360:
	add r1, sp, #0x1c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #8
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x14
	mov r0, r4
	mov r2, #2
	bl sub_13ac
loc_e388:
	str r0, [r6]
	b loc_e394
loc_e390:
	str r7, [r6]
loc_e394:
	teq r8, #0
	beq loc_e3ac
	add r2, sp, #0x28
	add r1, sp, #0x24
	mov r0, r4
	bl sub_1020
loc_e3ac:
	ldr r4, [r6]
	ldr r0, [sp, #0x3c]
	bl glue_01800888
	ldr r0, [sp, #0x38]
	bl glue_01800888
	ldr r0, [sp, #0x34]
	bl glue_01800888
	ldr r0, [sp, #0x30]
	bl glue_01800888
	ldr r0, [sp, #0x2c]
	bl glue_01800888
	ldr r0, [sp, #0x28]
	bl glue_01800888
	ldr r0, [sp, #0x24]
	bl glue_01800888
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}

sub_e43c:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r1
	sub sp, sp, #0x1c
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #4]
	mov r0, #2
	bl glue_01800818
	str r0, [sp]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r7, r0
	bl sub_0000
	mov r5, r0
	bl sub_29b4
	ldr r1, [sp, #0x14]
	str r0, [r1]
	mov r0, r5
	bl sub_29d0
	ldr r1, [sp, #0x18]
	str r0, [r1]
	mov r0, r5
	bl sub_0fa4
	movs r8, r0
	mov r0, r4
	beq loc_e540
	bl glue_01800838
	ldr r1, [sp, #8]
	str r0, [r1]
	mov r0, r5
	bl sub_29b4
	mov r2, r0
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r5
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_e54c
loc_e540:
	bl glue_01800838
	ldr r1, [sp, #8]
	str r0, [r1]
loc_e54c:
	ldr r1, [r7]
	ldr r0, [sp, #4]
	str r1, [r0]
	add r1, sp, #4
	add r0, sp, #8
	bl sub_171c
	ldr r1, [sp]
	str r0, [r1]
	ldr r1, [r7, #4]!
	ldr r0, [sp, #4]
	add r3, sp, #0xc
	str r1, [r0]
	add r1, sp, #4
	mov r0, sp
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #4]
	add r2, sp, #0x10
	str r0, [r1]
	add r0, sp, #4
	mov r1, #0
	bl sub_154c
	movs r4, r0
	beq loc_e5d0
	add r2, sp, #0xc
	mov r1, sp
	mov r0, r5
	bl sub_0fe4
	add r1, sp, #0x10
	mov r0, sp
	mov lr, pc
	mov pc, r4
	b loc_e5f0
loc_e5d0:
	mov r3, #0
	stmdb sp!, {r3}
	add r3, sp, #8
	add r2, sp, #0x10
	add r1, sp, #4
	mov r0, r5
	bl sub_150c
	add sp, sp, #4
loc_e5f0:
	teq r8, #0
	str r0, [r6]
	beq loc_e60c
	add r2, sp, #0x18
	add r1, sp, #0x14
	mov r0, r5
	bl sub_1020
loc_e60c:
	ldr r4, [r6]
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	ldr r0, [sp, #4]
	bl glue_01800888
	ldr r0, [sp]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_e65c:
	stmdb sp!, {r4, r5, r6, r7, lr}
	mov r6, r1
	mov r5, r2
	mov r4, r3
	sub sp, sp, #0x1c
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	ldr r0, [r5]
	str r0, [sp, #4]
	ldr r0, [r6]
	str r0, [sp]
	ldr r0, [r4]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r4, r0
	ldr r0, [sp]
	ldr r0, [r0]
	teq r0, #2
	ldrne r0, [sp, #4]
	ldrne r0, [r0]
	teqne r0, #2
	beq loc_e7bc
	mov r0, sp
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x14]
	str r0, [r1]
loc_e710:
	add r0, sp, #0x14
	bl sub_19f8
	teq r0, #0
	bne loc_e7bc
	ldr r0, [sp, #0x14]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x10]
	str r0, [r1]
	add r1, sp, #4
	add r0, sp, #0x10
	bl glue_01800928
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r1, [sp, #0x18]
	str r0, [r1]
	teq r0, #2
	beq loc_e7b0
	ldr r0, [sp, #8]
	ldr r1, [r0]
	teq r1, #2
	ldreq r1, [sp, #0xc]
	ldreq r1, [r1]
	beq loc_e7ac
	add r0, sp, #0xc
	bl glue_01800838
	ldr r1, [sp, #0xc]
	str r0, [r1]
	ldr r1, [r4]
	ldr r0, [sp, #0x18]
	add r2, sp, #8
	str r1, [r0]
	add r1, sp, #0x18
	add r0, sp, #0xc
	bl glue_01800a34
	ldr r0, [sp, #0xc]
	ldr r1, [r0]
	ldr r0, [sp, #8]
loc_e7ac:
	str r1, [r0]
loc_e7b0:
	add r0, sp, #0x14
	bl sub_19fc
	b loc_e710
loc_e7bc:
	ldr r0, [sp, #8]
	ldr r0, [r0]
	str r0, [r7]
	mov r4, r0
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}

sub_e808:
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	mov r5, r2
	mov r4, r3
	mov r0, #2
	ldr r8, [sp, #0x18]!
	sub sp, sp, #0x38
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	mov r7, r0
	ldr r0, [r4]
	str r0, [sp, #8]
	ldr r0, [r5]
	str r0, [sp, #4]
	ldr r0, [r6]
	str r0, [sp]
	ldr r0, [r8]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r4, r0
	ldr r0, [sp]
	ldr r0, [r0]
	teq r0, #2
	ldrne r0, [sp, #4]
	ldrne r0, [r0]
	teqne r0, #2
	ldrne r0, [sp, #8]
	ldrne r0, [r0]
	teqne r0, #2
	beq loc_e9a4
	mov r0, sp
	mov r1, #0
	bl sub_1998
	ldr r1, [sp, #0x18]
	str r0, [r1]
loc_e8d4:
	add r0, sp, #0x18
	bl sub_19f8
	teq r0, #0
	bne loc_e9a4
	ldr r0, [sp, #0x18]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0x14]
	str r0, [r1]
	add r1, sp, #4
	add r0, sp, #0x14
	bl glue_01800928
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	teq r0, #2
	beq loc_e998
	add r1, sp, #8
	add r0, sp, #0x10
	bl glue_01800928
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	teq r0, #2
	beq loc_e998
	ldr r0, [sp, #0xc]
	ldr r1, [r0]
	teq r1, #2
	ldreq r1, [sp, #0x10]
	ldreq r1, [r1]
	beq loc_e994
	add r0, sp, #0x10
	bl glue_01800838
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [r4]
	ldr r1, [sp, #0x1c]
	add r2, sp, #0xc
	str r0, [r1]
	add r1, sp, #0x1c
	add r0, sp, #0x10
	bl glue_01800a34
	ldr r0, [sp, #0x10]
	ldr r1, [r0]
	ldr r0, [sp, #0xc]
loc_e994:
	str r1, [r0]
loc_e998:
	add r0, sp, #0x18
	bl sub_19fc
	b loc_e8d4
loc_e9a4:
	ldr r0, [sp, #0xc]
	ldr r0, [r0]
	str r0, [r7]
	mov r4, r0
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	mov r0, r7
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

sub_e9f0:
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	mov r5, r1
	mov r4, r2
	mov r7, r3
	sub sp, sp, #0x3c
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x38]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x34]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x30]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x2c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x28]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x24]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x20]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x1c]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x18]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x14]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0x10]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #0xc]
	mov r0, #2
	bl glue_01800818
	str r0, [sp, #8]
	mov r0, #2
	bl glue_01800818
	mov r6, r0
	ldr r0, [r4]
	str r0, [sp, #4]
	ldr r0, [r5]
	str r0, [sp]
	ldr r0, [r7]
	ldr r0, [r0]
	mov r1, #3
	bl glue_01800920
	bl glue_01800a44
	mov r5, r0
	bl sub_0000
	mov r4, r0
	bl sub_29b4
	ldr r1, [sp, #0x20]
	str r0, [r1]
	mov r0, r4
	bl sub_29d0
	ldr r1, [sp, #0x24]
	str r0, [r1]
	mov r0, r4
	bl sub_0fa4
	movs r8, r0
	mov r0, r7
	beq loc_eb5c
	bl glue_01800838
	ldr r1, [sp, #0x38]
	str r0, [r1]
	mov r0, r4
	bl sub_29b4
	ldr r1, [sp, #0xc]
	str r0, [r1]
	mov r2, r0
	ldr r0, [sp, #0x38]
	ldr r0, [r0]
	mov r1, #1
	bl glue_01800a24
	mov r0, r4
	bl sub_29d0
	mov r2, r0
	ldr r0, [sp, #0x38]
	ldr r0, [r0]
	mov r1, #2
	bl glue_01800a24
	b loc_eb78
loc_eb5c:
	bl glue_01800838
	ldr r1, [sp, #0x38]
	str r0, [r1]
	mov r1, #1
	bl glue_01800920
	ldr r1, [sp, #0xc]
	str r0, [r1]
loc_eb78:
	ldr r1, [r5, #4]
	ldr r0, [sp, #0x10]
	add r3, sp, #0x14
	str r1, [r0]
	add r1, sp, #0x10
	add r0, sp, #0xc
	mov r2, #1
	bl sub_13d8
	ldr r1, [sp, #0x10]
	mov r7, #2
	str r0, [r1]
	teq r0, #2
	ldreq r0, [sp, #8]
	streq r7, [r0]
	beq loc_edfc
	ldr r1, [r5]
	ldr r0, [sp, #0x18]
	add r2, sp, #0x1c
	str r1, [r0]
	add r0, sp, #0x10
	mov r1, #1
	bl sub_154c
	movs sb, r0
	beq loc_ec00
	add r2, sp, #0x14
	add r1, sp, #0xc
	mov r0, r4
	bl sub_0fe4
	add r2, sp, #0x1c
	add r1, sp, #0x18
	add r0, sp, #0xc
	mov lr, pc
	mov pc, sb
	b loc_ec2c
loc_ec00:
	add r1, sp, #0x18
	mov r0, r4
	bl sub_12f8
	mov r3, #1
	stmdb sp!, {r3}
	add r3, sp, #0x14
	add r2, sp, #0x18
	add r1, sp, #0x10
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_ec2c:
	ldr r1, [sp, #8]
	str r0, [r1]
	ldr r0, [sp, #8]
	ldr r0, [r0]
	teq r0, #2
	beq loc_edfc
	ldr r1, [r5, #0x10]
	ldr r0, [sp, #0x18]
	str r1, [r0]
	add r0, sp, #0x18
	bl sub_1354
	ldr r1, [sp, #0x18]
	str r0, [r1]
	ldr r1, [r5, #8]
	ldr r0, [sp, #0x28]
	str r1, [r0]
	add r1, sp, #0x28
	add r0, sp, #8
	bl glue_01800928
	ldr r1, [sp, #0x1c]
	str r0, [r1]
	mov r1, #0
	ldr r0, [sp, #0x28]
	str r1, [r0]
	ldr r0, [r5, #0xc]
	ldr r1, [sp, #0x2c]
	str r0, [r1]
	ldr r0, [sp, #0x30]
	add r2, sp, #0x34
	str r7, [r0]
	add r0, sp, #0x18
	mov r1, #5
	bl sub_154c
	movs sb, r0
	beq loc_ecf0
	mov r0, r4
	bl sub_0fc8
	add r3, sp, #0x34
	add r2, sp, #0x30
	add r1, sp, #0x2c
	stmdb sp!, {r1, r2, r3}
	add r3, sp, #0x34
	add r2, sp, #0xc
	add r1, sp, #0x28
	add r0, sp, #0x44
	mov lr, pc
	mov pc, sb
	add sp, sp, #0xc
	b loc_ed3c
loc_ecf0:
	add r1, sp, #0x1c
	mov r0, r4
	bl sub_12f8
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x28
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x2c
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x30
	mov r0, r4
	bl sub_12f8
	add r1, sp, #0x18
	mov r0, r4
	mov r2, #5
	bl sub_13ac
loc_ed3c:
	ldr r1, [sp, #0x10]
	str r0, [r1]
	ldr r0, [sp, #0x10]
	ldr r1, [r0]
	teq r1, #2
	bne loc_edfc
	ldr r1, [r5, #0x14]!
	add r3, sp, #0x18
	str r1, [r0]
	add r1, sp, #0x10
	add r0, sp, #0xc
	mov r2, #0
	bl sub_13d8
	ldr r1, [sp, #0x10]
	add r2, sp, #0x30
	str r0, [r1]
	add r0, sp, #0x10
	mov r1, #2
	bl sub_154c
	movs r5, r0
	beq loc_edbc
	add r2, sp, #0x18
	add r1, sp, #0xc
	mov r0, r4
	bl sub_0fe4
	add r3, sp, #0x30
	add r2, sp, #4
	mov r1, sp
	add r0, sp, #0xc
	mov lr, pc
	mov pc, r5
	b loc_edf4
loc_edbc:
	mov r1, sp
	mov r0, r4
	bl sub_12f8
	add r1, sp, #4
	mov r0, r4
	bl sub_12f8
	mov r3, #2
	stmdb sp!, {r3}
	add r3, sp, #0x14
	add r2, sp, #0x1c
	add r1, sp, #0x10
	mov r0, r4
	bl sub_150c
	add sp, sp, #4
loc_edf4:
	str r0, [r6]
	b loc_ee00
loc_edfc:
	str r7, [r6]
loc_ee00:
	teq r8, #0
	beq loc_ee18
	add r2, sp, #0x24
	add r1, sp, #0x20
	mov r0, r4
	bl sub_1020
loc_ee18:
	ldr r4, [r6]
	ldr r0, [sp, #0x38]
	bl glue_01800888
	ldr r0, [sp, #0x34]
	bl glue_01800888
	ldr r0, [sp, #0x30]
	bl glue_01800888
	ldr r0, [sp, #0x2c]
	bl glue_01800888
	ldr r0, [sp, #0x28]
	bl glue_01800888
	ldr r0, [sp, #0x24]
	bl glue_01800888
	ldr r0, [sp, #0x20]
	bl glue_01800888
	ldr r0, [sp, #0x1c]
	bl glue_01800888
	ldr r0, [sp, #0x18]
	bl glue_01800888
	ldr r0, [sp, #0x14]
	bl glue_01800888
	ldr r0, [sp, #0x10]
	bl glue_01800888
	ldr r0, [sp, #0xc]
	bl glue_01800888
	ldr r0, [sp, #8]
	bl glue_01800888
	mov r0, r6
	bl glue_01800888
	mov r0, r4
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, pc}
