extends Node2D


class_name BGMPlayer

func get_player(name:String)-> AudioStreamPlayer:
	var player = get_node(name)
	return player
	

func play_bgm(name:String, cross_fade_time:float):
	pass
	
func play_ambience(name:String, cross_fade_time:float):
	pass
