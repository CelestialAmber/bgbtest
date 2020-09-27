SECTION "Unused RST Vectors", ROM0[$0] ;all the RST vectors before 0x38 seem to be unused (filled with FF)

ds $38

SECTION "Home", ROM0[$38]
RST_38:: ;this RST vector also seems unused, but has data
    ld b, b
    jr RST_38

    rst $38
    rst $38
    rst $38
    rst $38
    rst $38

VBlankInterrupt::
    push af
    push hl
    jp MainLoop


    rst $38
    rst $38
    rst $38

LCDCInterrupt::
    push af
    push hl
    ld hl, $c008
    ldh a, [rLY]
    db $fe

TimerOverflowInterrupt::
    ld d, b
    jr nc, jr_000_0061

    add [hl]
    and $1f
    ld h, $0a

SerialTransferCompleteInterrupt::
    ld l, a
    ld a, [hl]
    sub $0a
    ldh [rSCX], a
    pop hl
    pop af

JoypadTransitionInterrupt::
    reti


jr_000_0061:
    xor a
    ldh [rSCX], a
    inc a
    ldh [rIE], a
    pop hl

    pop af
    reti
    ;unused space filled with FF
    ds $96

SECTION "Entry", ROM0[$100]

Entry::
    nop
    jp Start