extends Sprite2D

@export var fade_duration: float = 10.0
@export var wait_duration: float = 60.0

func _ready():
	modulate.a = 0.0
	
	var tween = create_tween().set_loops()
	
	tween.tween_interval(wait_duration)
	
	tween.tween_property(self, "modulate:a", 1.0, fade_duration)
	
	tween.tween_interval(wait_duration)
	
	tween.tween_property(self, "modulate:a", 0.0, fade_duration)
