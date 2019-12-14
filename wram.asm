SECTION "WRAM Bank 0", WRAM0

wRAMStart::

wRAMC000:: ;c000
ds 2

;bits correspond to if the respective button is pressed
;bit 0: right
;bit 1: left
;bit 2: up
;bit 3: down
;bit 4: a
;bit 5: b
;bit 6: select
;bit 7: start
wButtonPressed:: ;c002
ds 1

wRAMC003:: ;c003
ds 1

wRAMC004:: ;c004
ds 1

wRAMC005:: ;c005
ds 1

wRAMC006:: ;c006
ds 1

wRAMC007:: ;c007
ds 2

wRAMC009:: ;c009
ds 1

wRAMC00A:: ;c00a
ds 1

;more ram is used starting at 0x100
;the moving particles use ram starting at address 0x140?
