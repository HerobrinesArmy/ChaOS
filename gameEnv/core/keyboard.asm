; --------------------------------------------
; Title:   keyboard library
; Author:  Liraal
; Date:    2012-06-28
; Version: 0x1
; --------------------------------------------
;Keyboard interrupt message: 0x1, 0x2 for strings, 0x10	arrow up, 0x11 arrow down, 0x12 arrow left, 0x13 arrow right, 0x14 return
;---------------------------------------------

:keyboard_init
set push, a
set push, b
set push, c
set push, j
set push, x
set push, y
set j, 0x0
:keyboard_init_loop
hwq j
ife b, 0x30cf
	ife a, 0x7406
		set pc, keyboard_init_keyboard_found
add j, 1
set pc, keyboard_init_loop
:keyboard_init_keyboard_found
set [KEYBOARD], j
set a, 0x0
hwi [KEYBOARD]
set a, 0x3
set b, 0x1
hwi [KEYBOARD]
set [keyboard_behavior], keyboard_interrupt_normal
set y, pop
set x, pop
set j, pop
set c, pop
set b, pop
set a, pop
set pc, pop

;variables
:KEYBOARD dat 0x0
:keyboard_behavior dat 0x0
:keyboard_string	dat 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
:keyboard_string_pointer dat 0x0
;-------------------------

:keyboard_interrupt
	jsr [keyboard_behavior]
set pc, pop

:keyboard_interrupt_normal
set push, a
set push, b
set push, c
set a, 0x1
hwi [KEYBOARD]
ifg c, 0x1F
	ifl c, 0x80
		jsr keyboard_ASCII
ife c, 0x0
	jsr keyboard_no_key
ife c, 0x10
	jsr keyboard_backspace
ife c, 0x11
	jsr keyboard_return
ife c, 0x20
	jsr keyboard_space
ife c, 0x77
	jsr keyboard_arrow_up
ife c, 0x73
	jsr keyboard_arrow_down
ife c, 0x61
	jsr keyboard_arrow_left
ife c, 0x64
	jsr keyboard_arrow_right
ife c, 0x31
	jsr keyboard_one
ife c, 0x32
	jsr keyboard_two
ife c, 0x33
	jsr keyboard_three
ife c, 0x34
	jsr keyboard_four
ife c, 0x35
	jsr keyboard_five
ife c, 0x90
	jsr keyboard_shift
ife c, 0x91
	jsr keyboard_control
set c, pop
set b, pop
set a, pop
set pc, pop

:keyboard_no_key
set pc, pop

:keyboard_backspace
;Backspace key commands to follow

;----------------------------
set pc, pop

:keyboard_return
;Enter key commands to follow
int 0x14
;----------------------------
set pc, pop

:keyboard_space
int 0x15
set pc, pop

:keyboard_arrow_up
;Up arrow key commands to follow
;ife [GUI_in_menu], 0x1
;	ifg [GUI_menu_pos], 0x0
;		sub [GUI_menu_pos], 0x1
	;jsr GUI_main_menu
int 0x10
;----------------------------
set pc, pop

:keyboard_arrow_down
;Down arrow key commands to follow
;ife [GUI_in_menu], 0x1
;		ifl [GUI_menu_pos], 0xB
;		add [GUI_menu_pos], 1
	;jsr GUI_main_menu
int 0x11
;----------------------------
set pc, pop

:keyboard_arrow_left
;Left arrow key commands to follow
int 0x12
;----------------------------
set pc, pop

:keyboard_arrow_right
;Right arrow key commands to follow
int 0x13
;----------------------------
set pc, pop

:keyboard_one
int 0x21
set pc, pop

:keyboard_two
int 0x22
set pc, pop

:keyboard_three
int 0x23
set pc, pop

:keyboard_four
int 0x24
set pc, pop

:keyboard_five
int 0x25
set pc, pop

:keyboard_shift
;Shift key commands to follow

;----------------------------
set pc, pop

:keyboard_control
;Control key commands to follow

;----------------------------
set pc, pop

:keyboard_ASCII
ife [GUI_can_write], 0x0
	set pc, pop
set push, i
set [keyboard_string_pointer], keyboard_string
set i, [keyboard_string_pointer]
set [i], c
add [keyboard_string_pointer], 1
set [keyboard_behavior], keyboard_ASCII_interrupt
set a, keyboard_string
jsr display_user_input
set i, pop
set ex, pop
set c, pop
set b, pop
set a, pop
set pc, pop

:keyboard_ASCII_interrupt
set push, a
set push, b
set push, c
set a, 0x1
hwi [KEYBOARD]
ife c, 0x10
	jsr keyboard_ASCII_backspace
ife c, 0x11
	jsr keyboard_ASCII_return
ife c, 0x82
	jsr keyboard_ASCII_arrow_left
ife c, 0x83
	jsr keyboard_ASCII_arrow_right
ifg c, 0x1F
	ifl c, 0x80
		jsr keyboard_ASCII_add
set a, keyboard_string
jsr display_user_input
set c, pop
set b, pop
set a, pop
set pc, pop

:keyboard_ASCII_backspace
ife [keyboard_string_pointer], keyboard_string
	jsr keyboard_ASCII_backspace_empty
set push, i
sub [keyboard_string_pointer], 1
set i, [keyboard_string_pointer]
set [i], 0x20
set i, pop
set pc, pop

:keyboard_ASCII_backspace_empty
set [keyboard_behavior], keyboard_interrupt_normal
set ex, pop
set pc, pop

:keyboard_ASCII_return
	set [keyboard_behavior], keyboard_interrupt_normal
	int 0x2
set pc, pop

:keyboard_ASCII_arrow_left
ife [keyboard_string_pointer], keyboard_string
	set pc, pop
sub [keyboard_string_pointer], 1
set pc, pop

:keyboard_ASCII_arrow_right
ife [keyboard_string_pointer], keyboard_string_pointer
	set pc, pop
add [keyboard_string_pointer], 1
set pc, pop

:keyboard_ASCII_add
ife [keyboard_string_pointer], keyboard_string_pointer
	set pc, pop
set push, i
set i, [keyboard_string_pointer]
set [i], c
add [keyboard_string_pointer], 1
set i, pop
set pc, pop

:keyboard_string_clear
set push, i
set i, keyboard_string
:keyboard_string_clear_loop
ife i, keyboard_string_pointer
	set pc, keyboard_string_clear_end
set [i], 0x20
add i, 0x1
set pc, keyboard_string_clear_loop
:keyboard_string_clear_end
set a, keyboard_string
jsr display_user_input
set i, pop
set pc, pop