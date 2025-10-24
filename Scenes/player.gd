extends CharacterBody2D

class_name Player

#	How movement should work
#	* Statemachine
#		* State 1: Climbing tree
#		* State 2: On branch
#		* State 3: Gliding / jumping
#

@export var acorn_label: Label

var num_acorns:int = 0

func add_acorn():
	num_acorns += 1
	update_fatness()
	update_ui()

func update_fatness():
	scale.x = 1+(num_acorns*0.2)

func update_ui():
	acorn_label.text = "%d/%d" % [num_acorns, get_node("%LevelStateHandler").acorn_target]

func try_stash_acorns() -> bool:
	var state_handler: LevelStateHandler = get_node("%LevelStateHandler")
	if(state_handler.acorn_target<=num_acorns):
		state_handler.add_acorns(num_acorns)
		get_node("%SfxSingleton").play_sfx("AcornStash")
		num_acorns = 0
		update_fatness()
		return true
	else:
		get_node("%SfxSingleton").play_sfx("AcornStashFail")
		return false

func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	pass
