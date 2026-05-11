extends Node

signal ball_spawned()


func _on_spawn_on_click_ball_spawned() -> void:
	ball_spawned.emit()


func _on_auto_spawner_ball_spawned() -> void:
	ball_spawned.emit()
