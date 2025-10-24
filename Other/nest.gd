extends Node2D

var player:Player = null
@export var nest_area:Area2D

func _ready() -> void:
	nest_area.area_entered.connect(
		func(a:Area2D):
			player = a.get_parent()
	)
	
	nest_area.area_exited.connect(
		func(a):
			player = null
	)	

func _input(ev):
	if player!=null and Input.is_key_pressed(KEY_ENTER):
		print("STASHING ALL ACORNS!")
		player.stash_acorns()
