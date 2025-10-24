extends Node2D

class_name LevelStateHandler

@export var acorn_label: Label
@export var timer_label: Label

var acorn_target:int = 100

var acorns_collected:int = 0

var time_left:float = 60*1 # 5 minutes

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

func update_timer_label():
	@warning_ignore("integer_division")
	var minutes:int = int(time_left) / 60
	var seconds:int = int(time_left) - 60*minutes
	var label:String = "%02d:%02d" % [minutes, seconds]
	timer_label.text = label
	
func _physics_process(delta: float) -> void:
	time_left -= delta
	
	if(time_left<0):
		time_left = 0
		print("ran out of time")
		# TODO: play hibernation animation thing?
	update_timer_label()

	
