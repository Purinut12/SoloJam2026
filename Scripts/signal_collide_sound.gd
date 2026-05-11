extends Node2D

func _on_body_entered(body):
	# and body is not parent
	if (body.is_in_group("ball") or body.is_in_group("post")) and body != get_parent():
		SignalBus.play_collide_sound.emit()
