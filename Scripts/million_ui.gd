extends Control

func _ready():
	self.modulate.a = 0
	self.visible = false

func _on_upgrade_controller_million_reached() -> void:
	self.visible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
