; Disassembly of "bgbtest.gb"
; This file was created with mgbdis v1.3 - Game Boy ROM disassembler by Matt Currie.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $000", ROM0[$150]

Start:
    di
    ld sp, $fffe

Init:
    ldh a, [rLY]
    cp $90 ;is the current scanline 90(hex)?
    jr nz, Init ;if not, jump to the start
    xor a
    ldh [rLCDC], a
    ld hl, $8000
    ld de, $2000
    call Call_000_03b7
    ld hl, $c000
    ld de, $2000
    call Call_000_03b7
    ld hl, $8010
    ld bc, bgb_text
    ld de, HeaderROMSize
    ;copy the large bgb text and small text font to vram, starting at index 0x30(first tile index)
    ;it only uses a pointer to the large text image, this could mean that the large and small text are together in 1 image
    call Call_000_03cf
    ld hl, $8800
    ld bc, bgb_logo
    ld de, $0200
    ;copy the bgb logo, buttons and other graphics to vram, starting at tile index 0x80
    call Call_000_03c2
    ld hl, $ff80
    ld bc, $0419
    ld de, $000a
    call Call_000_03c2
    ld hl, $9800
    ld de, $07e1
    call Call_000_03e5
    ld hl, $c100
    ld bc, $083d
    ld de, $00a0
    call Call_000_03c2
    call Call_000_0457
    ld a, $d3
    ldh [rLCDC], a
    ld a, $1b
    ldh [rBGP], a
    ldh [rOBP0], a
    ld a, $40
    ldh [rOBP1], a
    ld a, $08
    ldh [rSTAT], a
    ld a, $03
    ldh [rIE], a
    ld a, $01
    ld [$c009], a
    ld a, $08
    ldh [rSCY], a
    xor a
    ldh [rIF], a
    ldh [rSCX], a
    ld hl, $c000
    ld [hl], $c5
    inc hl
    ld [hl], $a7
    ld a, $01
    ld [$c005], a
    ld a, $80
    ld [$c00a], a
    ei

jr_000_01e2:
    halt
    nop
    jr jr_000_01e2

MainLoop: ;0x1e7
    push bc
    push de
    call CheckInput
    call Call_000_0338
    call $ff80
    ld hl, $c007
    inc [hl]
    ld a, [hl+]
    srl a
    srl a
    ld [hl], a
    ld a, $40
    ldh [rOBP1], a
    xor a
    ldh [rSCX], a
    ld a, [$c009]
    ldh [rIE], a
    call Call_000_0219
    call Call_000_0284
    call Call_000_02db
    call Call_000_0263
    pop de
    pop bc
    pop hl
    pop af
    reti


Call_000_0219:
    ld bc, $c140

jr_000_021c:
    inc c
    inc c
    inc c
    ld a, [bc]
    and $03
    ld e, a
    dec c
    dec c
    ld a, [bc]
    sub e
    jr c, jr_000_0233

    ld [bc], a
    inc c
    inc c
    inc c

jr_000_022d:
    ld a, c
    cp $a0
    jr nz, jr_000_021c

    ret


jr_000_0233:
    ld a, $a8
    ld [bc], a
    dec c
    ld a, [bc]
    dec a
    jr nz, jr_000_0241

    call Call_000_031f
    inc c
    ld [bc], a
    dec c

jr_000_0241:
    call Call_000_031f
    and $7f
    add $02
    ld [bc], a
    inc c
    inc c
    call Call_000_031f
    and $01
    add $90
    ld [bc], a
    inc c
    ld a, l
    and $0f

jr_000_0257:
    ld e, a
    sub $03
    jr nc, jr_000_0257

    inc e
    or $90
    ld [bc], a
    inc c
    jr jr_000_022d

Call_000_0263:
    ld a, [$c003]
    or a
    ret z

    ld hl, $c00a
    bit 7, a
    jr nz, jr_000_0281

    and [hl]
    jr z, jr_000_027e

    ld a, [hl]
    srl a
    jr c, jr_000_0279

    ld [hl], a
    ret


jr_000_0279:
    dec l
    ld a, [hl]
    xor $02
    ld [hl+], a

jr_000_027e:
    ld [hl], $80
    ret


jr_000_0281:
    ld [hl], $40
    ret


Call_000_0284:
    ld a, [$c002]
    xor $c0
    and $c0
    ld a, [$c003]
    jr z, jr_000_02a2

jr_000_0290:
    ld b, a
    ld hl, $c000
    xor [hl]
    ld a, [hl]
    ld a, b
    ld hl, $02cb

jr_000_029a:
    add a
    jr c, jr_000_02ad

    inc hl
    inc hl
    jr nz, jr_000_029a

    ret


jr_000_02a2:
    bit 7, a
    jr z, jr_000_0290

    ldh a, [rNR51]
    xor $44
    ldh [rNR51], a
    ret


jr_000_02ad:
    push af
    ld c, $13
    ld b, $00
    ld a, [$c004]
    xor $01
    ld [$c004], a
    jr nz, jr_000_02c0

    ld c, $18
    ld b, $02

jr_000_02c0:
    ld a, [hl+]
    add b
    ld [c], a
    inc c
    ld a, [hl+]
    or $80
    ld [c], a
    pop af
    jr jr_000_029a

    ld a, [bc]
    ld b, $42
    ld b, $72
    ld b, $89
    ld b, $b2
    ld b, $d6
    ld b, $e7
    ld b, $06
    rlca

Call_000_02db:
    ld bc, $c005
    ld a, [bc]
    dec a
    ld [bc], a
    ret nz

    ld a, $04
    ld [bc], a
    ld c, $1c
    ld a, [c]
    and $60
    jr z, jr_000_02f0

    add $20
    ld [c], a
    ret


jr_000_02f0:
    ld hl, $c006
    inc [hl]
    ld a, [hl]
    and $02
    ld c, a
    call Call_000_031f
    ld a, c
    or a
    jr z, jr_000_0302

    bit 0, l
    ret z

jr_000_0302:
    ld d, $00
    ld a, h
    and $07
    add a
    ld e, a
    ld hl, $02cb
    add hl, de
    ld a, $80
    ldh [rNR30], a
    ld a, $40
    ldh [rNR32], a
    ld c, $1d
    ld a, [hl+]
    ld [c], a
    inc c
    ld a, [hl+]
    or $80
    ld [c], a
    ret


Call_000_031f:
    ld de, $c000
    ld a, [de]
    ld h, a
    inc e
    ld a, [de]
    ld l, a
    add hl, hl
    jr nc, jr_000_032c

    set 0, l

jr_000_032c:
    ld a, l
    bit 7, h
    jr z, jr_000_0333

    xor $01

jr_000_0333:
    ld [de], a
    dec e
    ld a, h
    ld [de], a
    ret


Call_000_0338:
    ld a, [$c002]
    ld b, a
    ld a, $94
    bit 6, b
    jr nz, jr_000_0344

    add $10

jr_000_0344:
    ld hl, $9a07
    ld [hl+], a
    inc a
    ld [hl+], a
    inc l
    ld a, $96
    bit 7, b
    jr nz, jr_000_0353

    add $10

jr_000_0353:
    ld [hl+], a
    inc a
    ld [hl+], a
    ld a, $9c
    bit 5, b
    jr nz, jr_000_035e

    add $10

jr_000_035e:
    ld hl, $99ad
    ld [hl+], a
    inc a
    ld [hl+], a
    inc l
    inc a
    ld l, $cd
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, $98
    bit 4, b
    jr nz, jr_000_0373

    add $10

jr_000_0373:
    ld hl, $9990
    ld [hl+], a
    inc a
    ld [hl+], a
    inc l
    inc a
    ld l, $b0
    ld [hl+], a
    inc a
    ld [hl-], a
    ld h, $c1
    ld a, $78
    bit 3, b
    jr nz, jr_000_0389

    xor a

jr_000_0389:
    ld l, $00
    ld [hl], a
    ld l, $04
    ld [hl], a
    ld a, $60
    bit 2, b
    jr nz, jr_000_0396

    xor a

jr_000_0396:
    ld l, $08
    ld [hl], a
    ld l, $0c
    ld [hl], a
    ld a, $10
    bit 1, b
    jr nz, jr_000_03a3

    xor a

jr_000_03a3:
    ld l, $11
    ld [hl], a
    ld l, $15
    ld [hl], a
    ld a, $28
    bit 0, b
    jr nz, jr_000_03b0

    xor a

jr_000_03b0:
    ld l, $19
    ld [hl], a
    ld l, $1d
    ld [hl], a
    ret


Call_000_03b7:
    call Call_000_03dd

jr_000_03ba:
    ld [hl+], a
    dec e
    jr nz, jr_000_03ba

    dec d
    jr nz, jr_000_03ba

    ret


Call_000_03c2:
    call Call_000_03dd

jr_000_03c5:
    ld a, [bc]
    ld [hl+], a
    inc bc
    dec e
    jr nz, jr_000_03c5

    dec d
    jr nz, jr_000_03c5

    ret


Call_000_03cf:
    call Call_000_03dd

CopyTileToVRAM:
    ld a, [bc]
    ld [hl+], a
    ld [hl+], a
    inc bc
    dec e
    jr nz, CopyTileToVRAM

    dec d
    jr nz, CopyTileToVRAM

    ret


Call_000_03dd:
    push af
    ld a, e
    or a
    jr z, jr_000_03e3

    inc d

jr_000_03e3:
    pop af ;this points to 3d2(copytiletovram) for the bgb text
    ret


Call_000_03e5:
jr_000_03e5:
    ld a, [de]
    inc de
    cp $c0
    jr z, jr_000_0400

    cp $e0
    jr z, jr_000_040d

    ld [hl+], a
    jr jr_000_03e5

jr_000_03f2:
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld c, a
    ld a, b
    inc de

jr_000_03f9:
    ld [hl+], a
    inc a
    dec c
    jr nz, jr_000_03f9

    jr jr_000_03e5

jr_000_0400:
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld c, a
    ld a, b
    inc de

jr_000_0407:
    ld [hl+], a
    dec c
    jr nz, jr_000_0407

    jr jr_000_03e5

jr_000_040d:
    ld a, [de]
    inc de
    cp $ff
    ret z

    cp $f3
    jr z, jr_000_03f2

jr_000_0416:
    ld b, b
    jr jr_000_0416

    ld a, $c1
    ldh [rDMA], a
    ld a, $28

jr_000_041f:
    dec a
    jr nz, jr_000_041f

    ret


CheckInput:
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and $0f
    ld b, a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and $0f
    swap a
    or b
    ld b, a
    ld a, [wButtonPressed]
    xor b
    and b
    ld [wRAMc003], a
    ld a, b
    ld [wButtonPressed], a
    ld a, $30
    ldh [rP1], a
    ret


Call_000_0457:
    xor a
    ldh [rNR52], a
    nop
    nop
    nop
    nop
    ld a, $80
    ldh [rNR52], a
    ld a, $ff
    ldh [rNR51], a
    ld a, $77
    ldh [rNR50], a
    xor a
    ldh [rNR10], a
    ldh [rNR32], a
    ld a, $40
    ldh [rNR11], a
    ldh [rNR21], a
    ld a, $94
    ldh [rNR12], a
    ldh [rNR22], a
    ld hl, $0489
    ld c, $30

jr_000_0480:
    ld a, [hl+]
    ld [c], a
    inc c
    ld a, c
    cp $40
    jr nz, jr_000_0480

    ret


    nop
    ld de, $3322
    ld b, h
    ld d, l
    ld h, [hl]
    ld [hl], a
    adc b
    sbc c
    xor d
    cp e
    call z, $eedd
    rst $38

bgb_text::
    INCBIN "gfx/bgb_text.1bpp"

text_font::
    INCBIN "gfx/text_font.1bpp"

bgb_logo:: ;0x5e1
    INCBIN "gfx/bgb_logo.2bpp"

particles::
    INCBIN "gfx/particles.2bpp"

input_tiles_other::
    INCBIN "gfx/input_tiles_other.2bpp"

select_button::
    INCBIN "gfx/select_button.2bpp"

start_button::
    INCBIN "gfx/start_button.2bpp"

a_button::
    INCBIN "gfx/a_button.2bpp"

b_button::
    INCBIN "gfx/b_button.2bpp"

    ret nz

    nop
    ld h, c
    ldh [$f3], a
    add b
    inc b
    nop
    ldh [$f3], a
    ld bc, $e008

jr_000_07ee:
    di
    ld bc, $c004
    nop
    rrca
    ldh [$f3], a
    add h
    inc b
    nop
    ldh [$f3], a
    add hl, bc
    ld [$f3e0], sp
    add hl, bc
    inc b
    ret nz

    nop
    rrca
    ldh [$f3], a
    adc b
    inc b
    nop
    ldh [$f3], a
    ld de, $e008
    di
    ld de, $c004
    nop
    rrca
    ldh [$f3], a
    adc h
    inc b
    nop
    ldh [$f3], a
    add hl, de
    ld [$f3e0], sp
    add hl, de
    inc b
    ret nz

    nop
    ld d, c
    db "PRESS BUTTONS" ;text starts at offset 0x824
    db $C0,$00,$16,"TO TEST"
    ldh [rIE], a
    ld a, b
    jr @-$6c

    ld b, b
    ld a, b
    jr nz, @-$6c

    ld h, b
    ld h, b
    jr @-$6c

    nop
    ld h, b
    jr nz, @-$6c

    jr nz, jr_000_08b6

    db $10
    sub d
    nop
    ld [hl], b
    db $10
    sub d
    ld b, b
    ld l, b
    jr z, @-$6c

    jr nz, @+$72

    jr z, jr_000_07ee

    ld h, b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101

jr_000_08b6:
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ;unused space filled with FF
    ds $123
    ;0xa00
    ;maybe a data table?
    db $00, $01, $01, $02, $03, $04, $05, $07, $08, $09, $0B, $0C, $0D, $0E, $0F, $0F
    db $0F, $0F, $0F, $0E, $0D, $0C, $0B, $09, $08, $07, $05, $04, $03, $02, $01, $01
    ;0xa20
    ;the rest of the bank is filled with FF (likely all unused space)
    ds $35e0
    