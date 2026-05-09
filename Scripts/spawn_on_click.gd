extends Node2D

@export var Ball: PackedScene
@export var stats: Node
@export var valid_area: Area2D
var last_spawn_time = 0.0

signal ball_spawned()
signal clicked()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		clicked.emit()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Use the overlaps_point method (requires a CollisionShape2D)
		var mouse_pos = get_global_mouse_position()
		
		# Check physics overlap
		var query = PhysicsPointQueryParameters2D.new()
		query.position = mouse_pos
		query.collide_with_areas = true
		
		var result = get_world_2d().direct_space_state.intersect_point(query)
		
		# If the result list isn't empty, we clicked inside a shape
		if result.size() > 0:
			for item in result:
				if item.collider == valid_area:
					spawn_at_position(mouse_pos)
					break

func spawn_at_position(click_pos):
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if current_time - last_spawn_time < stats.spawn_cooldown || stats.money < stats.spawn_cost:
		return
		
	last_spawn_time = current_time
	
	var instance = Ball.instantiate()
	add_child(instance)
	instance.position = click_pos
	instance.add_to_group("ball")
	ball_spawned.emit()
