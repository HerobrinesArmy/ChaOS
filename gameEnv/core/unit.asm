; --------------------------------------------
; Title:   unit manager
; Author:  Liraal
; Date:    2012-06-30
; Version: 0x1
; --------------------------------------------

:unit_entries				;Total of 40
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2	;Pos, Exp, Type, Char, Player, Move
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
dat 0x0, 0x0, 0xFFFF, 0x20, 0xFFFF, 0x2
:unit_pointer	dat unit_entries

:unit_pointer_refresh
set push, a
set push, b
set push, c
set push, i
set a, unit_entries
set c, a
add c, 0xC3
:unit_pointer_refresh_loop
ife a, c
	ife [a], 0x0
		ife [a+1], 0x0
			ife [a+2], 0xFFFF
				ife [a+3], 0x20
					set pc, unit_pointer_refresh_end
set i, 0x0
:unit_pointer_refresh_loop_loop
ife i, 0x6
	set pc, unit_pointer_refresh_end
add a, i
set b, [a]
sub a, i
ifn b, 0x0
	ifn b, 0x20
		ifn b, 0xFFFF
			set pc, unit_pointer_refresh_loop_end
add i, 1
set pc, unit_pointer_refresh_loop_loop
:unit_pointer_refresh_loop_end
add a, 5
set pc, unit_pointer_refresh_loop
:unit_pointer_refresh_end
set i,pop
set c, pop
set b, pop
set a, pop
set pc, pop

:unit_spawn_settler
set push, a
set push, b
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [unit_pointer]
set [b], a
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x0
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x0
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x53
add [unit_pointer], 1
set b, [unit_pointer]
set [b], [GUI_player]
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x2
add [unit_pointer], 1
jsr unit_pointer_refresh
set b, pop
set a, pop
set pc, pop

:unit_spawn_swordsman
set push, a
set push, b
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [unit_pointer]
set [b], a
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x0
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x1
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x2F
add [unit_pointer], 1
set b, [unit_pointer]
set [b], [GUI_player]
add [unit_pointer], 1
set b, [unit_pointer]
set [b], 0x2
add [unit_pointer], 1
jsr unit_pointer_refresh
set b, pop
set a, pop
set pc, pop

:unit_add_to_map
set push, a
set push, b
set push, c
set push, i
set push, x
set push, y
set i, 0
set a, unit_entries
add a, 0x3
set b, unit_entries
:unit_add_to_map_loop
ife i, 0x28
	set pc, unit_add_to_map_end
set c, [b]
set x, c
and c, 0xFF00
and x, 0xFF
shr c, 0x8
mul x, 0x20
add x, c
add x, map_tile_entries
and [x], 0xFF00
set c, [a]
set y, a
add y, 1
ife [y], 0x0
	bor c, [GUI_player0]
ife [y], 0x1
	bor c, [GUI_player1]
xor [x], c
add a, 0x6
add b, 0x6
add i, 0x1
set pc, unit_add_to_map_loop
:unit_add_to_map_end
set y, pop
set x, pop
set i, pop
set c, pop
set b, pop
set a, pop
set pc, pop

:unit_remove
set push, a
set push, b
set push, i
set push, x
set push, y
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [GUI_player]
set i, 0
:unit_remove_loop
ife i, 0x28
	set pc, unit_remove_end
set x, unit_entries
set y, unit_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, unit_delete
add i, 1
set pc, unit_remove_loop
:unit_remove_end
jsr unit_pointer_refresh
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:unit_delete
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
mul b, 0x20
shr a, 0x8
add b, a
add b, map_tile_entries
set a, [b]
and a, 0xFF80
set [b], 0x20
bor [b], a
set [GUI_cursor], [b]
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0xFFFF
add x, 1
set [x], 0x20
add x, 1
set [x], 0xFFFF
add x, 1
set [x], 0x2
set pc, unit_remove_end

:unit_move_dir
set push, j
	ife c, 0x10
		jsr unit_move_up
	ife c, 0x11
		jsr unit_move_down
	ife c, 0x12
		jsr unit_move_left
	ife c, 0x13
		jsr unit_move_right
set j, pop
set pc, unit_move_end

:unit_move
set push, a
set push, b
set push, c
set push, i
set push, x
set push, y
set c, a
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [GUI_player]
set i, 0
:unit_move_loop
ife i, 0x28
	set pc, unit_move_end
set x, unit_entries
set y, unit_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, unit_move_dir
add i, 1
set pc, unit_move_loop
:unit_move_end
jsr unit_pointer_refresh
set y, pop
set x, pop
set i, pop
set c, pop
set b, pop
set a, pop
set [GUI_in_menu], 0x2
set pc, pop

:unit_delete_temp
set push, a
set push, b
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
mul b, 0x20
shr a, 0x8
add b, a
add b, map_tile_entries
set a, [b]
and a, 0xFF00
set [b], 0x20
bor [b], a
set b, pop
set a, pop
set [GUI_cursor], 0x0
set pc, pop

:unit_move_up
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifg b, 0x0
	sub b, 1
shl a, 0x8
bor a, b
jsr unit_can_move
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_up
set pc, pop

:unit_move_down
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifl b, 0xB
	add b, 1
shl a, 0x8
bor a, b
jsr unit_can_move
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_down
set pc, pop

:unit_move_left
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifg a, 0x0
	sub a, 1
shl a, 0x8
bor a, b
jsr unit_can_move
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_left
set pc, pop

:unit_move_right
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifl a, 0x1F
	add a, 1
shl a, 0x8
bor a, b
jsr unit_can_move
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_right
set pc, pop

:unit_can_move ;A,B - pos x,y
set push, c
set push, i
set push, y
set j, 0
set c, x
add c, 0x5
ifn [c], 0x2
	set pc, unit_can_move_end
set c, a
shl c, 0x8
bor c, b
set i, 0
:unit_can_move_loop
ife i, 0x28
	set pc, unit_can_move_loop_2
mul i, 0x6
add i, unit_entries
set y, i
add y, 0x4
ife [i], c
	ifn [y], [GUI_player]
		set pc, unit_can_move_end
sub i, unit_entries
div i, 0x6
add i, 0x1
set pc, unit_can_move_loop
:unit_can_move_loop_2
jsr map_get_terrain
ife c, 0x1
	set pc, unit_can_move_end
set j, 0x1 ;IMPORTANT!
:unit_can_move_end
set y, pop
set i, pop
set c, pop
set pc, pop

:unit_get_unit
set push, a
set push, b
set push, i
set push, x
set push, y
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [GUI_player]
set i, 0
:unit_get_unit_loop
ife i, 0x28
	set pc, unit_get_unit_end
set x, unit_entries
set y, unit_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, unit_get_unit_end
add i, 1
set pc, unit_get_unit_loop
:unit_get_unit_end
set [GUI_unit], 0xFFFF
ife [x], a
	ife [y], b
		jsr unit_get_unit_set
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:unit_get_unit_set
	sub y, 0x2
	set [GUI_unit], [y]
	add y, 0x2
set pc, pop

:unit_attack_dir
set push, j
	ife c, 0x10
		jsr unit_attack_up
	ife c, 0x11
		jsr unit_attack_down
	ife c, 0x12
		jsr unit_attack_left
	ife c, 0x13
		jsr unit_attack_right
set j, pop
set pc, unit_attack_end

:unit_attack
set push, a
set push, b
set push, c
set push, i
set push, x
set push, y
set c, a
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [GUI_player]
set i, 0
:unit_attack_loop
ife i, 0x28
	set pc, unit_attack_end
set x, unit_entries
set y, unit_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, unit_attack_dir
add i, 1
set pc, unit_attack_loop
:unit_attack_end
jsr unit_pointer_refresh
set y, pop
set x, pop
set i, pop
set c, pop
set b, pop
set a, pop
set [GUI_in_menu], 0x2
set pc, pop

:unit_attack_up
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifg b, 0x0
	sub b, 1
shl a, 0x8
bor a, b
set [combat_defender_pos], a
jsr combat_battle
ife [combat_unit_defender], 0xffff
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_up
set pc, pop

:unit_attack_down
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifl b, 0xB
	add b, 1
shl a, 0x8
bor a, b
set [combat_defender_pos], a
jsr combat_battle
ife [combat_unit_defender], 0xffff
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_down
set pc, pop

:unit_attack_left
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifg a, 0x0
	sub a, 1
shl a, 0x8
bor a, b
set [combat_defender_pos], a
jsr combat_battle
ife [combat_unit_defender], 0xffff
ife j, 0x0
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_left
set pc, pop

:unit_attack_right
set a, [x]
set b, a
and a, 0xFF00
and b, 0xFF
shr a, 0x8
ifl a, 0x1F
	add a, 1
shl a, 0x8
bor a, b
set [combat_defender_pos], a
jsr combat_battle
ife [combat_unit_defender], 0xffff
	set pc, pop
set j, x
add j, 0x5
sub [j], 0x2
jsr unit_delete_temp
set [x], a
;jsr GUI_cursor_right
set pc, pop