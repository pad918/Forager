extends Node2D

class_name SFXPlayer

func play_sfx(sfx_name:String):
	var audio_player = get_node(sfx_name)
	if(audio_player == null):
		printerr("Could not play sfx sample: ", sfx_name)
	else:
		if(audio_player is AudioStreamPlayer):
			audio_player.play()
		elif(audio_player is SoundRotator):
			audio_player.play()
	
