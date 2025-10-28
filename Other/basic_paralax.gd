extends Sprite2D

class_name BasicParalax

@export var scroll_speed:Vector2 = Vector2(1, 1)
@export var zero_point:Vector2 = Vector2(0, 0)

func _process(_delta: float) -> void:
	#var viewport_pos:Vector2 = get_viewport_transform().get_origin()
	var viewport_pos:Vector2 = get_viewport().get_camera_2d().get_screen_center_position()
	offset = ((scroll_speed-Vector2(1, 1)) * (viewport_pos-zero_point)) / scale.x
