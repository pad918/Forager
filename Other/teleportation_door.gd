extends Node2D

class_name TeleportationDoor

@export var area: Area2D
@export var destination: Node2D


var player:Player = null

func _ready() -> void:
	area.area_entered.connect(
		func(a:Area2D):
			player = a.get_parent()
	)
	area.area_exited.connect(
		func(_a:Area2D):
			player = null
	)
	
func _input(_event: InputEvent) -> void:
	if player!=null and Input.is_key_pressed(KEY_ENTER):
		player.position = destination.position
