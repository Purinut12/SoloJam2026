extends Node2D

@export var speed: float = 100.0
@export var left_limit: float = -200.0
@export var right_limit: float = 200.0

var direction: int = 1 # 1 for right, -1 for left

func _process(delta):
	position.x += direction * speed * delta
	
	if position.x >= right_limit:
		direction = -1
		position.x = right_limit
	elif position.x <= left_limit:
		direction = 1
		position.x = left_limit

func set_limits(new_left: float, new_right: float):
	left_limit = new_left
	right_limit = new_right
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = 350
