extends Node2D

@export var Ball: PackedScene
var cooldown_time = 0.5 # Seconds between spawns
var last_spawn_time = 0.0

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_at_position(get_global_mouse_position())

func spawn_at_position(click_pos):
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if current_time - last_spawn_time < cooldown_time:
		return # Still on cooldown, stop here
		
	last_spawn_time = current_time
	
	var instance = Ball.instantiate()
	add_child(instance)
	instance.position = click_pos
	instance.add_to_group("ball")
