extends Node2D

class_name GameStateHandler

@export var acorn_level_requirements: Array
@export var level_prefab_path: String

var level_id:int = -1

var total_collected_acorns = 0

var player_speed_upgrade:float = 1
var player_timer_upgrade:float = 45 # Start at 30 seconds
var player_capacity_upgrade:float = 1

func load_next_level():
	level_id += 1
	if(level_id>=acorn_level_requirements.size()):
		print("DONE WITH ALL LEVELS!")
		return
	var level_prefab = load(level_prefab_path)
	# Kill all the children and load a new level state
	for c in get_children():
		c.queue_free()
	var level_state: LevelStateHandler = level_prefab.instantiate()
	level_state.acorn_target = acorn_level_requirements[level_id]
	add_child(level_state)
	
func _ready() -> void:
	load_next_level()
