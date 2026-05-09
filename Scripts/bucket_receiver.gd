extends Area2D

@export var upgradeController: Node
@export var particles: CPUParticles2D
@export var sfx_player: AudioStreamPlayer2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("ball"):
		if upgradeController:
			upgradeController.add_win_money()
		if particles:
			particles.emitting = true 
		if sfx_player:
			sfx_player.play()
		body.queue_free() 
