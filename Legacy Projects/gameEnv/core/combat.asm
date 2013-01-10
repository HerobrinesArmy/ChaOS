; --------------------------------------------
; Title:   combat manager (seems to be working!)
; Author:  Liraal
; Date:    2012-07-01
; Version: 0x1
; --------------------------------------------

:combat_strength_settler	dat 0x1
:combat_strength_swordsman	dat 0x10
:combat_unit_attacker		dat 0x0
:combat_unit_defender		dat 0x0
:combat_defender_pos		dat 0x0

:combat_get_attacker_strength
set push, a
set push, b
set push, c
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, combat_unit_attacker
set c, [GUI_player]
ife [GUI_unit], 0x0
	set [combat_unit_attacker], [combat_strength_settler]
ife [GUI_unit], 0x1
	set [combat_unit_attacker], [combat_strength_swordsman]
set c, pop
set b, pop
set a, pop
set pc, pop

:combat_get_defender_strength
set push, a
set push, b
set push, c
set a, [combat_defender_pos]
set b, combat_unit_defender
set c, [GUI_player]
ife [combat_unit_defender], 0xffff
	set pc, combat_get_defender_strength_end
ife [combat_unit_defender], 0x0
	set [combat_unit_defender], [combat_strength_settler]
ife [combat_unit_defender], 0x1
	set [combat_unit_defender], [combat_strength_swordsman]
:combat_get_defender_strength_end
set c, pop
set b, pop
set a, pop
set pc, pop

:combat_battle
jsr combat_get_attacker_strength
jsr combat_get_defender_strength
ife [combat_unit_defender], 0xffff
	set pc, pop
jsr combat_fight
set pc, pop

:combat_fight
set push, y
jsr random_extract_number
mul [combat_unit_attacker], y
jsr random_extract_number
mul [combat_unit_defender], y
ifg [combat_unit_attacker], [combat_unit_defender]
	jsr combat_attacker_won
ifg [combat_unit_defender], [combat_unit_attacker]
	jsr combat_defender_won
ife [combat_unit_attacker], [combat_unit_defender]
	jsr combat_tie
set y, pop
set pc, pop

:combat_attacker_won
;dat 0x0
set push, [GUI_board_x]
set push, [GUI_board_y]
set [GUI_board_x], [combat_defender_pos]
set [GUI_board_y], [combat_defender_pos]
and [GUI_board_x], 0xFF00
shl [GUI_board_x], 0x8
and [GUI_board_y], 0xFF
xor [GUI_player], 0x1
jsr unit_remove
set [GUI_board_y], pop
set [GUI_board_x], pop
xor [GUI_player], 0x1
int 0x30
set pc, pop

:combat_defender_won
;dat 0x0
jsr unit_remove
int 0x31
set pc, pop

:combat_tie
;dat 0x0
set push, [GUI_board_x]
set push, [GUI_board_y]
set [GUI_board_x], [combat_defender_pos]
set [GUI_board_y], [combat_defender_pos]
and [GUI_board_x], 0xFF00
shl [GUI_board_x], 0x8
and [GUI_board_y], 0xFF
xor [GUI_player], 0x1
jsr unit_remove
set [GUI_board_y], pop
set [GUI_board_x], pop
xor [GUI_player], 0x1
jsr unit_remove
int 0x32
set pc, pop

;-----------------
:combat_get_unit	;A -pos, C -player, B - memory
set push, a
set push, b
set push, c
set push, i
set push, x
set push, y
set b, [c]
set i, 0
:combat_get_unit_loop
ife i, 0x28
	set pc, combat_get_unit_end
set x, unit_entries
set y, unit_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, combat_get_unit_end
add i, 1
set pc, unit_get_unit_loop
:combat_get_unit_end
set [c], 0xFFFF
ife [x], a
	ife [y], b
		jsr combat_get_unit_set
set y, pop
set x, pop
set i, pop
set c, pop
set b, pop
set a, pop
set pc, pop

:combat_get_unit_set
	sub y, 0x2
	set [b], [y]
	add y, 0x2
set pc, pop