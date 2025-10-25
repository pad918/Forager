extends Node2D

class_name BasicParalax

@export var scroll_speed:Vector2 = Vector2(1, 1)
@export var zero_point:Vector2 = Vector2(0, 0)

func _process(_delta: float) -> void:
	var viewport_pos:Vector2 = get_viewport_transform().get_origin()
	position = (scroll_speed-Vector2(1, 1)) * (viewport_pos-zero_point)
