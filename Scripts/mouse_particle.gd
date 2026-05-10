extends Node2D

@export var particles: Array[CPUParticles2D] = []

func _process(_delta):
	global_position = get_global_mouse_position()

func _on_spawn_on_click_ball_spawned() -> void:
	for particle in particles:
		if not particle.emitting:
			particle.emitting = true
			break
