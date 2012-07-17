; --------------------------------------------
; Title:   display library
; Author:  Liraal
; Date:    2012-06-28
; Version: 0x1
; --------------------------------------------

:displayLib
;exec code------------------------------------
jsr display_init
jsr display_set_board
jsr display_refresh
set a, 0x3000
set b, 0x5
jsr display_set_char_color
jsr display_refresh
sub pc, 1


;libraries------------------------------------
:display_init
 set push, a
 set push, b
 set push, c
 set push, i
 set push, x
 set push, y
 hwq i				
 ife b, 0x7349
  ife a, 0xf615
   ife c, 0x1802
    ife y, 0x1c6c
     ife x, 0x8b36
      add pc, 0x2
 add i, 1
 sub pc, 0xE
 set [LEM], i
 set a, 0x2
 set b, GUI_palette
 hwi [LEM]
 jsr display_refresh
 set y, pop
 set x, pop
 set i, pop
 set c, pop
 set b, pop
 set a, pop
set pc, pop
:LEM	dat 0x0
:VRAM	dat 0x8000
:LP		dat 0x0
:display_font_color dat 0xF000

:display_refresh
set push, a
set push, b
set a, 0x0
set b, [VRAM]
hwi [LEM]
set b, pop
set a, pop
set pc, pop

:display_fastClear
 set [VRAM], 0x8180
set pc, pop

:display_clear
 set push, i
 set push, j
 set push, x
 set i, [VRAM]
 set j, i
 add j, 0xC0
 set x, j
 add x, 0xC0
 ife j, x
 	add pc, 3
 set [j], 0x0
 sti [i], 0x0
 sub pc, 6
 set x, pop
 set j, pop
 set i, pop
set pc, pop

:display_printASCII
set push, a
set push, b
set push, i
set push, j
set i, 0xF000
set j, [VRAM]
ife i, 0xf080
	add pc, 0x4
set [j], i
add j, 0x1
add i, 0x1
sub pc, 0x7
set a, 0x0
set b, [VRAM]
hwi [LEM]
set j, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:display_setChar
 set push, x
 set x, b
 sub x, 1
 mul x, 0x20
 add x, a
 add x, [VRAM]
 set [x], c
 set x, pop
set pc, pop

:display_write
 set push, a
 set push, b
 set push, i
 set push, j
 set i, [VRAM]
 add i, b
 set j, [VRAM]
 add j, 0x180
 :display_write_loop
  ife i, j
  	set pc, display_write_end
  ife [a], 0x0
  	set pc, display_write_end
  bor [a], x
  set [i], [a]
  add a, 1
  add i, 1
  set pc, display_write_loop
 :display_write_end
 jsr display_refresh
 set j, pop
 set i, pop
 set b, pop
 set a, pop
set pc, pop

:display_write8 ;write 8-char (16-byte) word, beginning from address in A register, offset in VRAM defined in B register, x - color code
set push, a
set push, b
set push, c
set push, i
set push, j
set push, x
set i, 0x0
set j, [VRAM]
add j, b
:display_write8_loop
ife i, 0x8
	set pc, display_write8_end
set c, [a]
bor c, x
sti [j], c
add a, 0x1
set pc, display_write8_loop
:display_write8_end
jsr display_refresh
set x, pop
set j, pop
set i, pop
set c, pop
set b, pop
set a, pop
set pc, pop

:display_horizontal_line		;param: j - line number
set push, i
set push, j
sub j, 1
mul j, 0x20
add j, [VRAM]
set i, 0
:display_horizontal_line_loop
ife i, 0x1F
	set pc, display_horizontal_line_end
sti [j], 0xF007
set pc, display_horizontal_line_loop
:display_horizontal_line_end
jsr display_refresh
set j, pop
set i, pop
set pc, pop

:display_vertical_line		;param: j - line number
set push, i
set push, j
sub j, 1
add j, [VRAM]
set i, 0
:display_vertical_line_loop
ife i, 0xC
	set pc, display_vertical_line_end
set [j], 0xF01D
add i, 1
add j, 0x20
set pc, display_vertical_line_loop
:display_vertical_line_end
jsr display_refresh
set j, pop
set i, pop
set pc, pop

:display_menu	;A - adress, B - highlight
set push, a
set push, c
set push, i
set push, j
set push, x
set j, 0
set i, 0
:display_menu_loop
ife [a], 0x0
 set pc, display_menu_end
ife i, 0xC
	set pc, display_menu_end
set x, 0xF000
ife i, b
	set x, 0xE000
set push, b
set b, j
jsr display_write8
set b, pop
add a, 0x8
add i, 1
add j, 0x20
set pc, display_menu_loop
:display_menu_end
set j, 9
jsr display_vertical_line
jsr display_refresh
set x, pop
set j, pop
set i, pop
set c, pop
set a, pop
set pc, pop

:display_menu_content		;A - starting adress
set push, a
set push, c
set push, i
set push, j
set j, [VRAM]
set i, 0
:display_menu_content_loop
ife i, 0x16
	set i, 0x0
ife i, 0x0
	add j, 0xa
ife [a], 0x0
	set pc, display_menu_content_loop_end
set c, [a]
bor c, 0xF000
sti [j], c
add a, 1
set pc, display_menu_content_loop
:display_menu_content_loop_end
jsr display_refresh
set j, pop
set i, pop
set c, pop
set a, pop
set pc, pop

:display_menu_content_line	;A - adress, B - line
set push, a
set push, c
set push, i
set push, j
set j, [VRAM]
set i, 0
mul b, 0x20
add j, b
div b, 0x20
:display_menu_content_line_loop
ife i, 0x16
	set i, 0x0
ife i, 0x0
	add j, 0xa
ife [a], 0x0
	set pc, display_menu_content_line_loop_end
set c, [a]
bor c, 0xF000
sti [j], c
add a, 1
set pc, display_menu_content_line_loop
:display_menu_content_line_loop_end
jsr display_refresh
set j, pop
set i, pop
set c, pop
set a, pop
set pc, pop

:display_set_char_color ;A - color, B - adress
add B, [VRAM]
bor A, 0x00FF
and [B], A
sub B, [VRAM]
and A, 0xFF00
set pc, pop

:display_set_board
set push, a
set push, b
set push, i
set push, j
set a, map_tile_entries
set i, [VRAM]
set j, 0x0
:display_set_board_loop
ife j, 0x180
	set pc, display_set_board_end
;set b, 0x20
;bor b, [a]
sti [i], [a]
add a, 1
set pc, display_set_board_loop
:display_set_board_end
set j, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:display_toggle_char_visibility	;A - offset in VRAM
add a, [VRAM]
set push, b
set push, c
set b, [a]
set c, b
and c, 0xF00
and b, 0xFFF
shl c, 0x4
bor c, b
set [a], c
set c, pop
set b, pop
set pc, pop

:display_toggle_char_blinking	;A - offset in VRAM
add a, [VRAM]
xor [a], 0x80
set pc, pop

:display_user_input				;A - adress of 16 word block
set push, j
set push, i
set j, 0x170
add j, [VRAM]
set i, 0x0
:display_user_input_loop
ife i, 0x10
	set pc, display_user_input_end
bor [a], [display_font_color]
sti [j], [a]
add a, 1
set pc, display_user_input_loop
:display_user_input_end
set i, pop
set j, pop
jsr display_refresh
set pc, pop