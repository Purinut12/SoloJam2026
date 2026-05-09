extends RigidBody2D

@export var push_force: float = 1000.0
@export var target_angle: float = 45.0
@export var check_interval: float = 3.0

var is_active: bool = true
var timer: float = 0.0
var peak_angle_this_interval: float = 0.0

func _ready():
	var random_angle_deg = randf_range(-target_angle, target_angle)
	
	var pivot_pos = get_parent().global_position
	var length = (global_position - pivot_pos).length()
	
	var angle_rad = deg_to_rad(random_angle_deg)
	var offset = Vector2(sin(angle_rad), cos(angle_rad)) * length
	
	global_position = pivot_pos + offset

func _physics_process(delta):
	var pivot_pos = get_parent().global_position
	var current_angle = abs(rad_to_deg((global_position - pivot_pos).angle_to(Vector2.DOWN)))
	
	if current_angle > peak_angle_this_interval:
		peak_angle_this_interval = current_angle

	timer += delta
	if timer >= check_interval:
		is_active = (peak_angle_this_interval < target_angle)
		
		timer = 0.0
		peak_angle_this_interval = 0.0

	if is_active:
		var moving_right = linear_velocity.x > 0
		var angle_from_center = rad_to_deg((global_position - pivot_pos).angle_to(Vector2.DOWN))
		
		if abs(angle_from_center) < target_angle:
			if angle_from_center < 0 and not moving_right:
				apply_central_force(Vector2.LEFT * push_force)
			elif angle_from_center > 0 and moving_right:
				apply_central_force(Vector2.RIGHT * push_force)
