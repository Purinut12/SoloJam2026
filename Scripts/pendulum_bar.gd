extends Line2D

@export var anchor: Node
@export var ball: Node

func _process(_delta):
	clear_points()
	add_point(to_local(anchor.global_position))
	add_point(to_local(ball.global_position))
