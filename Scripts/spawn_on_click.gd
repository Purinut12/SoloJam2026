extends Node2D

@export var Ball: PackedScene

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_at_position(get_global_mouse_position())

func spawn_at_position(click_pos):
	var instance = Ball.instantiate()
	add_child(instance)
	instance.position = click_pos
	instance.add_to_group("ball")
