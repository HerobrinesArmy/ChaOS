; --------------------------------------------
; Title:   clock library
; Author:  Liraal
; Date:    2012-06-28
; Version: 0x1
; --------------------------------------------
;Clock interrupt message: 0x3, 0x4 for alarms
;---------------------------------------------

:clock_init
set push, a
set push, b
set push, c
set push, j
set push, x
set push, y
set j, 0x0
:clock_init_loop
hwq j
ife b, 0x12d0
	ife a, 0xb402
		set pc, clock_init_clock_found
add j, 1
set pc, clock_init_loop
:clock_init_clock_found
set [CLOCK], j
set a, 0x0
set b, [clock_tick_int]
hwi [CLOCK]
set a, 0x2
set b, 0x3
hwi [CLOCK]
set y, pop
set x, pop
set j, pop
set c, pop
set b, pop
set a, pop
set pc, pop

:CLOCK dat 0x0
:clock_tick_int dat 0x1E
:clock_tick_count dat 0x0
:clock_alarm_delay	dat 0x5

:clock_tick
add [clock_tick_count], 1
ife [clock_tick_count], [clock_alarm_delay]
	jsr clock_alarm
jsr [GUI_pos]
set pc, pop

:clock_wait	;A - number of ticks
set push, b
set push, c
set b, a
set a, 0x1
hwi [CLOCK]
add b, c
:clock_wait_loop
ife c, b
	set pc, clock_wait_end
hwi [CLOCK]
set pc, clock_wait_loop
:clock_wait_end
set c, pop
set a ,b
set b, pop
set pc, pop

:clock_alarm
set [clock_tick_count], 0x0
set [clock_alarm_delay], 0x0
int 0x4
set pc, pop

:clock_get_time
set push, c
set a, 0x1
hwi [CLOCK]
set a, c
set c, pop
set pc, pop