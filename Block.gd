extends RigidBody2D

signal clicked

var captured = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(delta):
	if captured:
		linear_velocity = (get_global_mouse_position() - position) * 20