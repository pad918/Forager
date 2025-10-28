extends CPUParticles2D

@export var scroll_speed:Vector2 = Vector2(1, 1)
@export var zero_point:Vector2 = Vector2(0, 0)

func _process(_delta: float) -> void:
	#var viewport_pos:Vector2 = get_viewport().get_camera_2d().global_position
	var center_pos:Vector2 = get_viewport().get_camera_2d().get_screen_center_position()
	var offset = (scroll_speed-Vector2(1, 1)) * (center_pos-zero_point)
	offset.y *= -1
	offset.x *= -1
	set_instance_shader_parameter("offset", offset)
