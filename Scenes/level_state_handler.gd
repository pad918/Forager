extends Node2D

class_name LevelStateHandler

@export var timer_label: Label

@export var round_animation_player: AnimationPlayer

var acorn_target:int = 10

var acorns_collected:int = 0

var time_left:float = 60*2

var has_player_countdown_timer:bool = false

var round_over:bool = false
	
func add_acorns(num:int):
	acorns_collected+=num
	if(acorns_collected >= acorn_target):
		round_over = true
		# TODO: Wait a bit, goto powerup menu?
		get_parent().load_next_level()

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
		if(not round_over):
			print("Player FAILED!")
			round_animation_player.play("DidNotMakeIt")
			round_animation_player.animation_finished.connect(
				func(_n):
					SceneLoaderSingleton.load_scene("MainMenu")
			)
		round_over = true
	elif(time_left<30 && !has_player_countdown_timer):
		has_player_countdown_timer = true
		get_node("%SfxSingleton").play_sfx("TimerCountdown")
	update_timer_label()

	
