extends Node2D

signal pressed
signal unpressed

var captured

func check_for_win():
	if $Left.car_is_in and $Right.car_is_in:
		$"/root/Game/Gimme".next_level()