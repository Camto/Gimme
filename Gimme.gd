extends Button

var Block = preload("res://Block.tscn")
var Lock = preload("res://Lock.tscn")
var Key = preload("res://Key.tscn")
var Next_Level = preload("res://Next_Level.tscn")

var level = -1
var objects = null
var levels = [[Next_Level], [Lock, Key], [Block]]

func _ready():
	next_level()

func next_level():
	level += 1
	objects = levels[level].duplicate()
	disabled = false
	for object in get_tree().get_nodes_in_group("object"):
		object.queue_free()

func _on_Gimme_pressed():
	if not objects.empty():
		var new_object = objects.pop_front().instance()
		new_object.position = get_position()
		$"..".new_object(new_object)
	
	if objects.empty():
		disabled = true