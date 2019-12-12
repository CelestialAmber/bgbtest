SECTION "WRAM Bank 0", WRAM0
wRAMStart::
ds 2
wButtonPressed:: ;c002
;bits correspond to if the respective button is pressed
;bit 0: right
;bit 1: left
;bit 2: up
;bit 3: down
;bit 4: a
;bit 5: b
;bit 6: select
;bit 7: start
ds 1
wRAMc003:: ;c003
ds 1