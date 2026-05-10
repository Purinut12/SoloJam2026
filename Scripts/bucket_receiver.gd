extends Area2D

@export var upgradeController: Node
@export var particles: Array[CPUParticles2D] = []
@export var sfx_player: AudioStreamPlayer2D

func _ready():
	upgradeController = get_tree().get_first_node_in_group("upgrade_controller")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("ball"):
		if upgradeController:
			upgradeController.add_win_money()
		for particle in particles:
			if not particle.emitting:
				particle.emitting = true
				break
		if sfx_player:
			sfx_player.play()
		body.queue_free() 
