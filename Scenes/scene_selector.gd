extends Node

@export var scene_name: String
func load_scene():
	SceneLoaderSingleton.load_scene(scene_name)
