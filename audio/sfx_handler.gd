extends Node2D

class_name SFXPlayer

func play_sfx(sfx_name:String):
	var audio_player: AudioStreamPlayer = get_node(sfx_name)
	if(audio_player == null):
		printerr("Could not play sfx sample: ", sfx_name)
	else:
		audio_player.play()
	
