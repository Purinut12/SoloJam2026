extends Control

var has_started_fade_out = false

func _input(event):
	if event is InputEventMouseButton and event.pressed and not has_started_fade_out:
		has_started_fade_out = true
		var tween = create_tween()
		tween.tween_interval(10.0)
		tween.tween_property(self, "modulate:a", 0.0, 1.0)
		tween.finished.connect(queue_free)
