extends Button

var Block = preload("res://Block.tscn")
var Lock = preload("res://Lock.tscn")
var Key = preload("res://Key.tscn")
var Next_Level = preload("res://Next_Level.tscn")
var Restart = preload("res://Restart.tscn")
var Tic_Tac_Toe = preload("res://Tic_Tac_Toe.tscn")
var X = preload("res://X.tscn")
var Car = preload("res://Car.tscn")

var level = 2
var objects = null
var levels = [
	[Next_Level],
	[Lock, Key],
	[Lock, Tic_Tac_Toe, X, X, X, X, X],
	[Car, Block],
	[Block, Block, Block, Restart]
]

func _ready():
	next_level()

func next_level():
	level += 1
	objects = levels[level].duplicate()
	disabled = false
	for object in $"../Objects".get_children():
		$"..".free_object(object)

func restart():
	level -= 1
	next_level()

func _on_Gimme_pressed():
	if not objects.empty():
		var new_object = objects.pop_front().instance()
		new_object.position = $"../Gimme_Center".position
		$"..".new_object(new_object)
	
	if objects.empty():
		disabled = true