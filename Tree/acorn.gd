extends Node2D

@export var area: Area2D

func _ready() -> void:
	area.area_entered.connect(
		func(n:Area2D):
			var player:Player = n.get_parent()
			player.add_acorn()
			#Play the collection sfx
			var sfx:SFXPlayer = get_node("%SfxSingleton")
			sfx.play_sfx("AcornGrab")
			queue_free()
	)
