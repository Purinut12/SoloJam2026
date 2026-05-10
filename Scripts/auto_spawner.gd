extends Node2D

@export var Ball: PackedScene
@export var spawn_area: Area2D
@export var spawn_rate: float = 0.5
var level: int = 0

var timer: float = 0.0

signal ball_spawned()

func _process(delta):
	timer += delta
	var cooldown_time = 1.0 / spawn_rate
	if timer >= cooldown_time:
		spawn_wave()
		timer = 0.0

func spawn_wave():
	if not Ball or not spawn_area:
		return

	var shape_node = spawn_area.get_node("CollisionShape2D")
	var rect = shape_node.shape.get_rect()
	
	var area_width = rect.size.x * shape_node.global_scale.x
	var area_left = shape_node.global_position.x + (rect.position.x * shape_node.global_scale.x)
	
	var spacing = area_width / (level + 1)

	for i in range(1, level + 1):
		var spawn_x = area_left + (i * spacing)
		
		var instance = Ball.instantiate()
		instance.position = Vector2(spawn_x, shape_node.global_position.y)
		add_child(instance)
		instance.add_to_group("ball")
		ball_spawned.emit()

func _on_upgrade_controller_spawn_rate_upgraded(rate: float, _level: int) -> void:
	spawn_rate = rate
	self.level = _level
