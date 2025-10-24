extends Node2D

@export var area: Area2D

func _ready() -> void:
	area.area_entered.connect(
		func(n):
			print("Collected Acorn!")
			var state_handler: LevelStateHandler = get_node("%LevelStateHandler")
			state_handler.collected_acorn()
			queue_free()
	)
