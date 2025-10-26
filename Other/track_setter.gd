extends Node

@export var bgm_name:String = ""

@export var ambiance_name:String = ""

@export var cross_fade_time:float = 1

@export var reset_blocking:bool = false

func play_tracks():
	if(reset_blocking):
		BgmPlayerSingleton.reset()
	if(!bgm_name.is_empty()):
		BgmPlayerSingleton.play_bgm(bgm_name, cross_fade_time)
	
	if(!ambiance_name.is_empty()):
		BgmPlayerSingleton.play_ambience(ambiance_name, cross_fade_time)
		
