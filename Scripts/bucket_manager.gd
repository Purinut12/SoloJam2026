extends Node2D

@export var bucket_scene: PackedScene
var total_min: float = -200.0
var total_max: float = 200.0

func add_bucket_upgrade():
	var new_bucket = bucket_scene.instantiate()
	add_child(new_bucket)
	
	redistribute_buckets()

func redistribute_buckets():
	var buckets = get_children()
	var count = buckets.size()
	var gap: float = 50.0
	
	var total_width = total_max - total_min
	var total_gap_space = (count - 1) * gap
	var slot_width = (total_width - total_gap_space) / count

	for i in range(count):
		var slot_left = total_min + (i * (slot_width + gap))
		var slot_right = slot_left + slot_width
		
		buckets[i].set_limits(slot_left, slot_right)

func _on_upgrade_controller_bucket_upgraded() -> void:
	add_bucket_upgrade()
