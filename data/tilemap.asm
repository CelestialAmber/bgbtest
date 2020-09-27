;tilemap data(offset 0x7e1)
;if the current byte is C0, the next 2 bytes of data have the following format:
;byte 0: tile index, byte 1: tile amount
;if the current byte is E0, the next 3 bytes of data have the following format:
;byte 0: usually F3 or FF for end of data, byte 1: start tile index, byte 2: number of tiles
;first tile index = startIndex, last tile index = startIndex + numberOfTiles
;otherwise, the next data is just 1 byte representing a single tile's index
db $C0,$00,$61
db $E0,$F3,$80,$04
db $00
db $E0,$F3,$01,$08
db $E0,$F3,$01,$04
db $C0,$00,$0F
db $E0,$F3,$84,$04
db $00
db $E0,$F3,$09,$08
db $E0,$F3,$09,$04
db $C0,$00,$0F
db $E0,$F3,$88,$04
db $00
db $E0,$F3,$11,$08
db $E0,$F3,$11,$04
db $C0,$00,$0F
db $E0,$F3,$8C,$04
db $00
db $E0,$F3,$19,$08
db $E0,$F3,$19,$04
db $C0,$00,$51
db "PRESS BUTTONS"
db $C0,$00,$16
db "TO TEST"
db $E0,$FF