extends HSlider

class_name AudioVolumeSlider

func _ready() -> void:
	value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	
func _process(delta: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	pass
