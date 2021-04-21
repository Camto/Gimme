extends Button

var already_pressed = false

func _pressed():
	if not already_pressed:
		$"/root/Game/Gimme".restart()
		disabled = true
		already_pressed = true