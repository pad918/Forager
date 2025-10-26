extends Node


@export var sfx_name: String = ""

func play():
	if(not sfx_name.is_empty()):
		UiSfxSingleton.play(sfx_name)
