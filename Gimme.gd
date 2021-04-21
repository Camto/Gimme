extends Button

var Block = preload("res://Block.tscn")

var objects = [Block, Block]

func _on_Gimme_pressed():
	if objects.size():
		var new_object = objects.pop_front().instance()
		new_object.position = get_position()
		$"..".make_capturable(new_object)
		$"../Objects".add_child(new_object)