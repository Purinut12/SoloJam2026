extends Button

@export var sfx_player: Array[AudioStreamPlayer2D] = []
@export var click_particles: CPUParticles2D

@export var shrink_size: Vector2 = Vector2(0.95, 0.95)
@export var duration: float = 0.1

func _ready():
	pivot_offset = size / 2
	
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_button_down():
	if sfx_player:
		for player in sfx_player:
			player.play()
	
	if click_particles:
		click_particles.restart()
	
	var tween = create_tween()
	tween.tween_property(self, "scale", shrink_size, duration).set_trans(Tween.TRANS_QUAD)

func _on_button_up():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, duration).set_trans(Tween.TRANS_QUAD)
