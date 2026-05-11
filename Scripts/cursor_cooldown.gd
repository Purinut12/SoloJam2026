extends Node2D

@onready var timer = $Timer
var radius = 20.0
var color = Color("#EBEDE9")
var thickness = 2.0
var antialiasing = true

func _process(_delta):
	global_position = get_global_mouse_position()
	
	queue_redraw()

func _draw():
	var time_left = timer.time_left
	var total_time = timer.wait_time
	var progress = 1.0
	
	if total_time > 0:
		progress = time_left / total_time
	
	var current_radius = radius * progress
	if current_radius > 0:
		draw_arc(Vector2.ZERO, current_radius, 0, TAU, 64, color, thickness, antialiasing)

func start_cooldown(duration: float):
	timer.start(duration)

func _on_upgrade_controller_spawn_rate_upgraded(rate: float, _level: int) -> void:
	timer.wait_time = 1.0 / rate

func _on_spawn_on_click_ball_spawned() -> void:
	start_cooldown(timer.wait_time)
