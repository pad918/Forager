extends CharacterBody2D

class_name Player

#	How movement should work
#	* Statemachine
#		* State 1: Climbing tree
#		* State 2: On branch
#		* State 3: Gliding / jumping
#

@export var acorn_label: Label

@export var acorn_fatness_scaling:float = 0.05

var num_acorns:int = 0

var game_state: GameStateHandler

var speed_scale:float = 1

func add_acorn():
	num_acorns += 1
	update_fatness()
	update_ui()

func update_fatness():
	pass
	# Should just be removed? It does not look good
	#scale.x = 1+(num_acorns*0.2)

func update_ui():
	acorn_label.text = "%d/%d" % [num_acorns, get_parent().acorn_target]

func try_stash_acorns() -> bool:
	var state_handler: LevelStateHandler = get_parent()
	if(state_handler.acorn_target<=num_acorns):
		state_handler.deposit_acorns(num_acorns)
		get_node("%SfxSingleton").play_sfx("AcornStash")
		num_acorns = 0
		update_fatness()
		return true
	else:
		get_node("%SfxSingleton").play_sfx("AcornStashFail")
		return false

func _ready() -> void:
	update_ui()
	game_state = get_node("/root/GameEntryPoint/GameStateHandler")
	
func _physics_process(_delta: float) -> void:
	speed_scale = max(0.5, game_state.player_speed_upgrade - num_acorns*acorn_fatness_scaling/game_state.player_capacity_upgrade)
