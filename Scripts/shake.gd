extends "res://Scripts/button_shrink.gd"

@export var push_force: float = 500.0
@export var shake_intensity: float = 10.0
@export var shake_duration: float = 0.2
@export var camera: Camera2D

signal shake_screen_signal()

func shake_screen():
	shake_screen_signal.emit()
	var tween = create_tween()
	for i in range(5):
		var offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_intensity
		tween.tween_property(camera, "offset", offset, shake_duration / 5)
	
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.05)


func _on_pressed() -> void:
	get_tree().call_group("ball", "apply_central_impulse", Vector2.UP * push_force)
	shake_screen()
