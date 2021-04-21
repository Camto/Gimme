extends RigidBody2D

onready var window_size = get_viewport_rect().size

signal pressed
signal unpressed

var captured = false

func _physics_process(delta):
	if captured:
		var mouse_position = get_global_mouse_position()
		mouse_position.x = clamp(mouse_position.x, 0, window_size.x)
		mouse_position.y = clamp(mouse_position.y, 0, window_size.y)
		linear_velocity = (mouse_position - position) * 20

func _on_Button_button_down():
	emit_signal("pressed", self)

func _on_Button_button_up():
	emit_signal("unpressed", self)