; --------------------------------------------
; Title:   interrupt handler
; Author:  Liraal
; Date:    2012-06-28
; Version: 0x1
; --------------------------------------------

:interrupt_init
ias interrupt_main
set pc, pop

:interrupt_main
ife a, 0x1
	jsr keyboard_interrupt
ife a, 0x2
	jsr interrupt_keyboard_string	;if recieved a string	
ife a, 0x3
	jsr clock_tick
ife a, 0x4
	jsr interrupt_clock_alarm		;if received an alarm
ifg a, 0xF
	ifl a, 0x14
		jsr GUI_arrow
ife a, 0x14
	jsr GUI_step					;if received a return
ife a, 0x15
	jsr time_turn
ife a, 0x21
	jsr GUI_unit_menu_set
ife a, 0x22
	jsr unit_spawn_settler
ife a, 0x23
	jsr GUI_city_menu_set
ife a, 0x24
	set [GUI_in_menu], 0x3
ife a, 0x25
	jsr unit_spawn_swordsman
ife a, 0x100
	jsr GUI_build_menu_set
ife a, 0x101
	jsr GUI_recruit_menu_set


rfi a

:interrupt_keyboard_string
	set push, a
	set push, b
	set push, x
	set a, keyboard_string
	set b, 0x0
	set x, 0x7000
	jsr display_write8
	add a, 0x8
	add b, 0x8
	jsr display_write8
	jsr keyboard_string_clear
	set x, pop
	set b, pop
	set a, pop
set pc, pop

:interrupt_clock_alarm

set pc, pop
