extends Node2D

var captured_object = null

func _ready():
	randomize()

func make_capturable(object):
	object.connect("pressed", self, "_on_object_pressed")
	object.connect("unpressed", self, "_on_object_unpressed")

func new_object(object):
	make_capturable(object)
	$Objects.add_child(object)

func free_object(object):
	if captured_object == object:
		captured_object = null
	object.queue_free()

func _on_object_pressed(object):
	if not captured_object:
		captured_object = object
		captured_object.captured = true

func _on_object_unpressed(object):
	if captured_object:
		captured_object.captured = false
		captured_object = null

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if captured_object and not event.pressed:
			captured_object.captured = false
			captured_object = null