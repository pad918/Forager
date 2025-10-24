extends Camera2D

@export var low_limit: Vector2 = Vector2(0, 0)

@export var high_limit: Vector2 = Vector2(100, 100)

@export var speed_offset_multiplier: float = 100

@export var max_camera_speed_acceleration: float = 100

var speed_offset: Vector2 = Vector2(0, 0)

var player: CharacterBody2D

func _ready() -> void:
	player = get_parent()

func _physics_process(delta: float) -> void:
	var new_speed_offset:Vector2 = player.velocity * speed_offset_multiplier
	var delta_speed_offset:Vector2 = new_speed_offset - speed_offset
	var max_camera_speed_acceleration_this_frame = delta * max_camera_speed_acceleration
	if delta_speed_offset.length() > max_camera_speed_acceleration_this_frame:
		new_speed_offset = speed_offset + delta_speed_offset.normalized() * max_camera_speed_acceleration_this_frame
	
	speed_offset = new_speed_offset 
	position = speed_offset
	
	var is_out_of_bounds:bool = false
	var glob_pos = global_position
	if(glob_pos.x <= low_limit.x):
		position.x = low_limit.x - glob_pos.x
		is_out_of_bounds = true
	if(glob_pos.x >= high_limit.x):
		position.x = high_limit.x - glob_pos.x
		is_out_of_bounds = true
	if(glob_pos.y <= low_limit.y):
		position.y = low_limit.y - glob_pos.y
		is_out_of_bounds = true
	if(glob_pos.y >= high_limit.y):
		position.y = high_limit.y - glob_pos.y
		is_out_of_bounds = true
	
	if(is_out_of_bounds):
		speed_offset *= 0.95


	
	
