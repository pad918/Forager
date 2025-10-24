extends Node2D

class_name LevelStateHandler

@export var acorn_label: Label

var acorn_target:int = 100

var acorns_collected:int = 0

var time_left:int = 60*5 # 5 minutes

func update_ui():
	acorn_label.text = "%d/%d" % [acorns_collected, acorn_target]

func reset(new_target:int):
	acorns_collected = acorn_target
	update_ui()
	
func add_acorns(num:int):
	acorns_collected+=num
	print("state handler num acorns: ", acorns_collected)
	update_ui()

func has_reached_target():
	return acorns_collected >= acorn_target

func _physics_process(delta: float) -> void:
	time_left -= delta
	if(time_left<0):
		print("ran out of time")
		# TODO: play hibernation animation thing?
	
