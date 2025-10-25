extends Node2D

class_name LevelStateHandler

@export var timer_label: Label

@export var round_animation_player: AnimationPlayer

var acorn_target:int = 10

var time_left:float =60*5

var has_player_countdown_timer:bool = false

var round_over:bool = false

func _ready() -> void:
	var game_state_handler: GameStateHandler = get_parent()
	time_left *= game_state_handler.player_timer_upgrade
	
func deposit_acorns(num:int):
	if(num >= acorn_target):
		round_over = true
		var game_state:GameStateHandler = get_parent()
		game_state.total_collected_acorns += num
		print("Collected ",num, " acorns this level")
		# Display upgrades menu
		round_animation_player.play("ShowUpgradesUi")
		#get_parent().load_next_level()

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

	
