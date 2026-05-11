extends Node

func _ready():
	fade_out()

func fade_out():
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0, 1.0)
	tween.tween_callback($ColorRect.hide)
