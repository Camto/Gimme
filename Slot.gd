extends Area2D

onready var board = $"../.."

var x_texture = preload("res://X.png")
var o_texture = preload("res://O.png")

var piece = null

func _body_entered(body):
	if body_is_valid_x(body):
		$Sprite.texture = x_texture
		body.enter_slot(self)

func _body_exited(body):
	if body_is_valid_x(body):
		$Sprite.texture = null
		body.exit_slot()

func body_is_valid_x(body):
	return (
		board.winner == null and
		piece == null and
		body.is_in_group("x") and body.captured)

func insert_x():
	piece = board.Player.X
	$Sprite.texture = x_texture
	$Sprite.modulate.a = 1
	board.bounce_ = true
	board.played(self)
	board.check_for_win()
	if board.winner == null:
		board.play_o()
		board.check_for_win()

func insert_o():
	piece = board.Player.O
	$Sprite.texture = o_texture
	$Sprite.modulate.a = 1