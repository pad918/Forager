extends Area2D

class_name BGMArea

@export var bgm_cf_time:float = 2
@export var ambience_cf_time:float = 2

@export var bgm_name:String
@export var ambiance_name:String

func _ready() -> void:
	area_entered.connect(
		func(a:Area2D):
			if(a.get_parent() is Player):
				#Start the playback
				if(bgm_name != null):
					BgmPlayerSingleton.play_bgm(bgm_name, bgm_cf_time)
				if(ambiance_name != null):
					BgmPlayerSingleton.play_ambience(ambiance_name, ambience_cf_time)
	)
