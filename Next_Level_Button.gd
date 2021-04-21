extends Button

var already_pressed = false

func _pressed():
	if not already_pressed:
		$"/root/Game/Gimme".next_level()
		disabled = true
		already_pressed = true