extends RigidBody2D

onready var window_size = get_viewport_rect().size
var Next_Level = preload("res://Next_Level.tscn")

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

func _body_entered(body):
	if body.is_in_group("key"):
		var new_object = Next_Level.instance()
		new_object.position = position
		self.queue_free()
		body.queue_free()
		$"/root/Game".new_object(new_object)