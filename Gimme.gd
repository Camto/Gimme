extends Button

var Block = preload("res://Block.tscn")
var Lock = preload("res://Lock.tscn")
var Key = preload("res://Key.tscn")
var Next_Level = preload("res://Next_Level.tscn")
var Restart = preload("res://Restart.tscn")
var Tic_Tac_Toe = preload("res://Tic_Tac_Toe.tscn")
var X = preload("res://X.tscn")
var Car = preload("res://Car.tscn")

var level = 1
var objects = []

func _ready():
	restart()

func next_level():
	disabled = false
	for object in $"../Objects".get_children():
		$"..".free_object(object)
	
	level += 1
	var level_scene = load("res://Level_%d.tscn" % level).instance()
	
	objects = []
	var gimme_objects = level_scene.get_node("Gimme_Objects")
	for gimme_object in gimme_objects.get_children():
		gimme_objects.remove_child(gimme_object)
		objects.push_back(gimme_object)
	
	var new_objects = level_scene.get_node("Starting_Objects")
	for new_object in new_objects.get_children():
		new_objects.remove_child(new_object)
		$"..".new_object(new_object)

func restart():
	level -= 1
	next_level()

func _on_Gimme_pressed():
	if not objects.empty():
		var new_object = objects.pop_front()
		new_object.position = $"../Gimme_Center".position
		$"..".new_object(new_object)
	
	if objects.empty():
		disabled = true