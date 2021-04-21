extends Button

var Block = preload("res://Block.tscn")

var objects = [Block, Block]

func _on_Gimme_pressed():
	if objects.size():
		var new_obj = objects.pop_front().instance()
		new_obj.position = get_position()
		$"..".add_child(new_obj)