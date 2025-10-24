extends CharacterBody2D

class_name Player

#	How movement should work
#	* Statemachine
#		* State 1: Climbing tree
#		* State 2: On branch
#		* State 3: Gliding / jumping
#

var num_acorns:int = 0

func add_acorn():
	num_acorns += 1
	update_fatness()

func update_fatness():
	scale.x = 1+(num_acorns*0.2)
	
func stash_acorns():
	print("stashing, player has: ", num_acorns)
	var state_handler: LevelStateHandler = get_node("%LevelStateHandler")
	state_handler.add_acorns(num_acorns)
	if(num_acorns>0):
		get_node("%SfxSingleton").play_sfx("AcornStash")
	num_acorns = 0
	update_fatness()

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
