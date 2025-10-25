extends Node2D


class_name CameraLimitHandler

@export var camera: Camera2D

func _ready() -> void:
	for limit_area:CameraLimitArea in get_children():
		if(limit_area is CameraLimitArea):
			limit_area.area_entered.connect(
				func(a:Area2D):
					if(a.get_parent() is Player):
						print("SETTING CAMERA LIMITS!")
						camera.limit_left = int(limit_area.low_limit.x)
						camera.limit_right = int(limit_area.high_limit.x)
						camera.limit_top = int(limit_area.low_limit.y)
						camera.limit_bottom = int(limit_area.high_limit.y)
			)
