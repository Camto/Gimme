extends RigidBody2D

enum Player {X, O}

onready var window_size = get_viewport_rect().size
var Key = preload("res://Key.tscn")
var Restart = preload("res://Restart.tscn")

signal pressed
signal unpressed

var captured = false
onready var slots = [
	[$Slots/Slot, $Slots/Slot2, $Slots/Slot3],
	[$Slots/Slot4, $Slots/Slot5, $Slots/Slot6],
	[$Slots/Slot7, $Slots/Slot8, $Slots/Slot9]
]
onready var empty_slots = $Slots.get_children()
var winner = null
var bounce_ = false

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
	
	if bounce_:
		linear_velocity = Vector2(0.0, -200.0)
		angular_velocity = rand_range(-PI, PI)
		bounce_ = false

func played(slot):
	empty_slots.erase(slot)

func play_o():
	if empty_slots.size():
		var slot = empty_slots[randi() % empty_slots.size()]
		slot.insert_o()
		played(slot)

func check_for_win():
	winner = calculate_winner()
	if empty_slots.size() == 0:
		winner = Player.O
	if winner != null:
		$Win_Timer.start()

func calculate_winner():
	for i in range(3):
		var row = slots[i]
		if row[0].piece == row[1].piece and row[1].piece == row[2].piece:
			return row[0].piece
		
		if slots[0][i].piece == slots[1][i].piece and slots[1][i].piece == slots[2][i].piece:
			return slots[0][i].piece
	
	if slots[0][0].piece == slots[1][1].piece and slots[1][1].piece == slots[2][2].piece:
		return slots[0][0].piece
	
	if slots[0][2].piece == slots[1][1].piece and slots[1][1].piece == slots[2][0].piece:
		return slots[0][2].piece

func _on_Win_Timer_timeout():
	var new_object
	if winner == Player.X:
		new_object = Key.instance()
	else:
		new_object = Restart.instance()
	new_object.position = position
	$"/root/Game".free_object(self)
	$"/root/Game".new_object(new_object)