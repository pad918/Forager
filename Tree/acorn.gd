extends Node2D

@export var area: Area2D

func _ready() -> void:
	area.area_entered.connect(
		func(n:Area2D):
			var player = n.get_parent()
			if (player is Player):
				player.add_acorn()
				#Play the collection sfx
				var sfx:SFXPlayer = get_node("%SfxSingleton")
				sfx.play_sfx("AcornGrab")
				queue_free()
	)
