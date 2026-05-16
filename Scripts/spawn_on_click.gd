extends Node2D

@export var Ball: PackedScene
@export var stats: Node
@export var valid_area: Area2D
@export var spawn_rate: float = 0.5

var last_spawn_time = 0.0
var is_auto_spawn_enabled: bool = false

signal ball_spawned()
signal clicked()

func _process(_delta):
	if is_auto_spawn_enabled:
		var mouse_pos = get_global_mouse_position()
		try_spawn(mouse_pos)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		clicked.emit()
		if event.button_index == MOUSE_BUTTON_LEFT:
			try_spawn(get_global_mouse_position())

func try_spawn(spawn_pos: Vector2):
	var current_time = Time.get_ticks_msec() / 1000.0
	var cooldown = 1.0 / spawn_rate
	
	if (current_time - last_spawn_time) < cooldown: return
	if stats.money < stats.spawn_cost: return
	
	if not is_point_in_valid_area(spawn_pos):
		return

	last_spawn_time = current_time
	
	var instance = Ball.instantiate()
	instance.position = spawn_pos
	add_child(instance)
	ball_spawned.emit()

func is_point_in_valid_area(pos: Vector2) -> bool:
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	var result = get_world_2d().direct_space_state.intersect_point(query)
	for item in result:
		if item.collider == valid_area:
			return true
	return false

func _on_auto_spawn_toggle_button_pressed() -> void:
	is_auto_spawn_enabled = true

func _on_upgrade_controller_spawn_rate_upgraded(rate: float, _level: int) -> void:
	spawn_rate = rate
