extends Node

class_name UISfx

func play(audio_name:String):
	print("Playing SFX in singleton: ", audio_name)
	var player = get_node(audio_name)
	if(player == null or not player is AudioStreamPlayer):
		printerr("Audio, ", audio_name, " is not recogniced")
	player.play()
