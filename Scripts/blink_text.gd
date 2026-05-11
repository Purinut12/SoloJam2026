extends Label

@export var blink_color: Color = Color.YELLOW
@export var duration: float = 0.6

func _ready():
	if label_settings:
		var default_color = label_settings.outline_color
		var tween = create_tween().set_loops()
		tween.tween_property(label_settings, "outline_color", blink_color, duration)
		tween.tween_property(label_settings, "outline_color", default_color, duration)
