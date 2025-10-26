extends Node

@export var scene_name: String

var load_next_frame:bool = false

func load_scene():
	SceneLoaderSingleton.load_scene(scene_name)

# Loads with a slight delay to allow audio / visuals to start before
# the loading stops ALL OTHER SCRIPTS!
func load_scene_delayed():
	load_next_frame = true
	

func _process(_delta: float) -> void:
	if(load_next_frame):
		load_next_frame = false
		SceneLoaderSingleton.load_scene(scene_name)
