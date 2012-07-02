; --------------------------------------------
; Title:   time manager
; Author:  Liraal
; Date:    2012-06-30
; Version: 0x1
; --------------------------------------------

:time_in_turns	dat 0x0
:time_turn_to_year	dat 0x4

:time_get_years
set a, [time_in_turns]
mul a, [time_turn_to_year]
set pc, pop

:time_turn
set push, a
set a, [GUI_player]
ife a, 0x0
	set [GUI_player], 0x1
ife a, 0x1
	set [GUI_player], 0x0
ife [GUI_player], 0x0
	jsr time_turn_act
set a, pop
set pc, pop

:time_turn_act
add [time_in_turns], 0x1
jsr building_update
jsr recruit_update
jsr time_reset_moves
set pc, pop

:time_reset_moves
set push, i
set i, 0
:time_reset_moves_loop
ife i, 0x28
	set pc, time_reset_moves_end
mul i, 0x6
add i, unit_entries
add i, 0x5
set [i], 0x2
sub i, 0x5
sub i, unit_entries
div i, 0x6
add i, 0x1
set pc, time_reset_moves_loop
:time_reset_moves_end
set i, pop
set pc, pop