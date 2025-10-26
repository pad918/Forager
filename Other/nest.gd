extends Node2D

var player:Player = null
@export var nest_area:Area2D

#TODO: 
# 	Only allow stashing if the player has enough acorns, i.e. if you have hit the target
#	Play a "failing" sound / animation
#	On success => play animation and go to the next round

func _ready() -> void:
	nest_area.area_entered.connect(
		func(a:Area2D):
			player = a.get_parent()
			if(player is Player):
				player.try_stash_acorns()
	)
	
	nest_area.area_exited.connect(
		func(_a):
			player = null
	)	
