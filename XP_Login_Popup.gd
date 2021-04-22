extends RigidBody2D

onready var window_size = get_viewport_rect().size

signal pressed
signal unpressed

var captured = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("pressed", self)

func _physics_process(delta):
	if captured:
		var mouse_position = get_global_mouse_position()
		mouse_position.x = clamp(mouse_position.x, 0, window_size.x)
		mouse_position.y = clamp(mouse_position.y, 0, window_size.y)
		linear_velocity = (mouse_position - position) * 20