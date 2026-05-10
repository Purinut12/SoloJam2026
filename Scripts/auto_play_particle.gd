extends CPUParticles2D

func _enter_tree():
	if not is_node_ready():
		await ready
	
	restart()
