extends AudioStreamPlayer2D

func playSound():
	play()

func _on_spawn_controller_ball_spawned() -> void:
	playSound()
