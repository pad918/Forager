extends Node

class_name SceneLoader

@export var main_menu_prefab_path: String
@export var main_game_prefab_path: String

@export var scenes: Dictionary

func get_root_node() -> Node:
	return get_node("/root/GameEntryPoint")

func kill_all_children():
	for child in get_root_node().get_children():
		child.queue_free()

func load_scene(scene_name:String):
	kill_all_children()
	print("Loading scene: ", scene_name)
	var scene_class = load(scenes[scene_name])
	get_root_node().add_child(scene_class.instantiate())
	
