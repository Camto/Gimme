extends Node2D

var captured_object = null

func _ready():
	for object in get_tree().get_nodes_in_group("object"):
		make_capturable(object)

func make_capturable(object):
	object.connect("pressed", self, "_on_object_pressed")
	object.connect("unpressed", self, "_on_object_unpressed")

func new_object(object):
	make_capturable(object)
	$Objects.add_child(object)

func _on_object_pressed(object):
	if !captured_object:
		captured_object = object
		captured_object.captured = true

func _on_object_unpressed(object):
	if captured_object:
		captured_object.captured = false
		captured_object = null

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if captured_object and !event.pressed:
			captured_object.captured = false
			captured_object = null