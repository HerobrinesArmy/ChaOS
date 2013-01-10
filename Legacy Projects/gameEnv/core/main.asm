; --------------------------------------------
; Title:   program core
; Author:  Liraal
; Date:    2012-06-28
; Version: 0x1
; --------------------------------------------

jsr core_init
jsr GUI_main_menu
sub pc, 0x1

;INIT section
:core_init
jsr display_init
jsr keyboard_init
jsr interrupt_init
jsr random_init
jsr map_generate
jsr clock_init
set pc, pop

:printT
set push, a
set a, [VRAM]
set [a], 0x70F8
jsr display_refresh
set a, pop
set pc, pop