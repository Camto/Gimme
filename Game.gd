extends Node2D

var captured_object = null

func _ready():
	for object in get_tree().get_nodes_in_group("object"):
		make_capturable(object)

func make_capturable(object):
	object.connect("clicked", self, "_on_object_clicked")

func _on_object_clicked(object):
	if !captured_object:
		captured_object = object
		captured_object.captured = true

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if captured_object and !event.pressed:
			captured_object.captured = false
			captured_object = null