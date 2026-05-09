extends Node2D

@export var speed: float = 100.0
@export var left_limit: float = -200.0
@export var right_limit: float = 200.0

var direction: int = 1 # 1 for right, -1 for left

func _process(delta):
	# 1. Update position
	position.x += direction * speed * delta
	
	# 2. Check limits and flip direction
	if position.x >= right_limit:
		direction = -1
		position.x = right_limit # Keep it in bounds
	elif position.x <= left_limit:
		direction = 1
		position.x = left_limit # Keep it in bounds
