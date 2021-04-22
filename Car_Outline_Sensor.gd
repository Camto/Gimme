extends Area2D

var car_is_in = false

func _body_entered(body):
	if body.is_in_group("car"):
		car_is_in = true
		$"..".check_for_win()

func _body_exited(body):
	if body.is_in_group("car"):
		car_is_in = false
		$"..".check_for_win()