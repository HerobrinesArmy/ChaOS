; --------------------------------------------
; Title:   city manager
; Author:  Liraal
; Date:    2012-06-30
; Version: 0x1
; --------------------------------------------

:city_entries				;Total of 20
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0		;pos, char, player, buildings, name (16)
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
dat 0x0,0x20,0xFFFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
:city_pointer	dat city_entries

:city_pointer_refresh
set push, a
set push, b
set push, c
set push, i
set a, city_entries
set c, a
add c, 0xC3
:city_pointer_refresh_loop
ife a, c
	ife [a], 0x0
		ife [a+1], 0x20
			ife [a+2], 0xFFFF
				ife [a+3], 0x0
					set pc, city_pointer_refresh_end
set i, 0x0
:city_pointer_refresh_loop_loop
ife i, 0x6
	set pc, city_pointer_refresh_end
add a, i
set b, [a]
sub a, i
ifn b, 0x0
	ifn b, 0x20
		ifn b, 0xFFFF
			set pc, city_pointer_refresh_loop_end
add i, 1
set pc, city_pointer_refresh_loop_loop
:city_pointer_refresh_loop_end
add a, 5
set pc, city_pointer_refresh_loop
:city_pointer_refresh_end
set i,pop
set c, pop
set b, pop
set a, pop
set pc, pop

:city_found
jsr unit_remove
set push, a
set push, b
set a, [GUI_board_x]
set b, [GUI_board_y]
shl a, 0x8
bor a, b
set b, [city_pointer]
set [b], a
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x43
add [city_pointer], 1
set b, [city_pointer]
set [b], [GUI_player]
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
set b, [city_pointer]
set [b], 0x0
add [city_pointer], 1
jsr city_pointer_refresh
set b, pop
set a, pop
set pc, pop

:city_add_to_map
set push, a
set push, b
set push, c
set push, i
set push, x
set push, y
set i, 0
set a, city_entries
add a, 0x1
set b, city_entries
:city_add_to_map_loop
ife i, 0x14
	set pc, city_add_to_map_end
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
bor [x], c
add a, 0x10
add b, 0x10
add i, 0x1
set pc, city_add_to_map_loop
:city_add_to_map_end
set y, pop
set x, pop
set i, pop
set c, pop
set b, pop
set a, pop
set pc, pop

:city_remove
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
:city_remove_loop
ife i, 0x14
	set pc, city_remove_end
set x, city_entries
set y, city_entries
add y, 0x4
mul i, 0x10
add x, i
add y, i
div i, 0x10
ife [x], a
	ife [y], b
		set pc, city_delete
add i, 1
set pc, city_remove_loop
:city_remove_end
jsr city_pointer_refresh
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:city_delete
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
set [x], 0x20
add x, 1
set [x], 0xFFFF
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
add x, 1
set [x], 0x0
set pc, city_remove_end

:city_get_city
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
:city_get_city_loop
ife i, 0x28
	set pc, city_get_city_end
set x, city_entries
set y, city_entries
add y, 0x2
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, city_get_city_end
add i, 1
set pc, city_get_city_loop
:city_get_city_end
jsr city_get_city_clear
ife [x], a
	ife [y], b
		jsr city_get_city_set
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:city_get_city_set
	add y, 0x1
	set i, 0
	:city_get_city_set_loop
	ife i, 0xD
		set pc, city_get_city_set_end
	add i, GUI_city
	set [i], [x]
	sub i, GUI_city
	add i, 0x1
	add x, 0x1
	set pc, city_get_city_set_loop
	:city_get_city_set_end
	sub y, 0x1
set pc, pop

:city_get_city_clear
	set i, 0
	:city_get_city_clear_loop
	ife i, 0xD
		set pc, pop
	add i, GUI_city
	set [i], 0xffff
	sub i, GUI_city
	add i, 1
	set pc, city_get_city_clear_loop
	
:city_build_townhall
set push, j
set push, x
set x, GUI_city
add x, 2
set j, [x]
and j, 0x1
ife j, 0x1
	set pc, city_build_townhall_end
set j, 0x1
jsr city_build_set
:city_build_townhall_end
set x, pop
set j, pop
set pc, pop

:city_build_barracks
set push, j
set push, x
set x, GUI_city
add x, 2
set j, [x]
and j, 0x2
ife j, 0x2
	set pc, city_build_barracks_end
set j, 0x2
jsr city_build_set
:city_build_barracks_end
set x, pop
set j, pop
set pc, pop
	
:city_build_set
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
:city_build_set_loop
ife i, 0x28
	set pc, city_build_set_end
set x, city_entries
set y, city_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, city_build
add i, 1
set pc, city_build_set_loop
:city_build_set_end
;jsr city_pointer_refresh
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:city_build
mul i, 0x2
add i, building_entries
ife j, 0x1
	jsr city_build_1
ife j, 0x2
	jsr city_build_2
sub i, building_entries
div i, 0x2
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:city_build_1
set [i], 0x2
add i, 1
set [i], 0x1
sub i, 1
set pc, pop

:city_build_2
set [i], 0x4
add i, 1
set [i], 0x2
sub i, 1
set pc, pop

:city_add_building	
set push, j
add i, 1
set j, i
sub i, 1
	sub i ,building_entries
	mul i, 0x5
	add i, city_entries
	add i, 0x3
	bor [i], [j]
	;dat 0x0
	sub i, 0x3
	sub i, city_entries
	div i, 0x5
	add i, building_entries
set j, pop
set pc, pop

:city_recruit_settler
set push, j
set j, 0x1
jsr city_recruit_set
set j, pop
set pc, pop

:city_recruit_swordsman
set push, j
set j, 0x2
jsr city_recruit_set
set j, pop
set pc, pop

:city_add_recruit
set push, c
set push, j
set push, [GUI_board_x]
set push, [GUI_board_y]
set push, [GUI_player]
add i, 1
set j, i
sub i, 1
	sub i, recruit_entries
	mul i, 0x5
	add i, city_entries
	set c, [i]
	and c, 0xFF00
	shr c, 0x8
	set [GUI_board_x], c
	set c, [i]
	and c, 0xFF
	set [GUI_board_y], c
	ife [j], 0x0
		jsr unit_spawn_settler
	sub i, 0x3
	sub i, city_entries
	div i, 0x5
	add i, recruit_entries
set [GUI_player], pop
set [GUI_board_y], pop
set [GUI_board_x], pop
set j, pop
set c, pop
set pc, pop

:city_recruit_set
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
:city_recruit_set_loop
ife i, 0x28
	set pc, city_recruit_set_end
set x, city_entries
set y, city_entries
add y, 0x4
mul i, 0x6
add x, i
add y, i
div i, 0x6
ife [x], a
	ife [y], b
		set pc, city_recruit
add i, 1
set pc, city_recruit_set_loop
:city_recruit_set_end
;jsr city_pointer_refresh
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:city_recruit
mul i, 0x2
add i, recruit_entries
ife j, 0x1
	jsr city_recruit_1
ife j, 0x2
	jsr city_recruit_2
sub i, recruit_entries
div i, 0x2
set y, pop
set x, pop
set i, pop
set b, pop
set a, pop
set pc, pop

:city_recruit_1
set [i], 0x2
add i, 1
set [i], 0x1
sub i, 1
set pc, pop

:city_recruit_2
set [i], 0x4
add i, 1
set [i], 0x2
sub i, 1
set pc, pop