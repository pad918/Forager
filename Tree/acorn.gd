extends Node2D

@export var area: Area2D

func _ready() -> void:
	area.area_entered.connect(
		func(n:Area2D):
			var player:Player = n.get_parent()
			player.add_acorn()
			queue_free()
	)
