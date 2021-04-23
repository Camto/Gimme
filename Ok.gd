extends Button

func _pressed():
	if $"../Username".text == "bob79" and $"../Password".text == "hunter2":
		$"/root/Game/Gimme".next_level()
	else:
		$"../Username".text = ""
		$"../Password".text = ""
		$"..".linear_velocity = Vector2(0.0, -200.0)
		$"..".angular_velocity = rand_range(-PI, PI)