extends Panel

class_name UpgradesHandler

@export var state_handler: GameStateHandler

func _ready() -> void:
	visible = false # Quick fix, WHY THE FUCK DOES IT BECOME VISIBLE WHEN YOU PLAY??
	state_handler = get_node("/root/GameEntryPoint/GameStateHandler")

func get_game_state_handler() -> GameStateHandler:
	return get_node("/root/GameEntryPoint/GameStateHandler")

func try_upgrade_capacity():
	print("Upgrading Capasity")
	get_game_state_handler().player_capacity_upgrade += 0.1

func try_upgrade_speed():
	print("Upgrading speed")
	get_game_state_handler().player_speed_upgrade += 0.1
	
func try_upgrade_time():
	print("Upgrading time limit")
	get_game_state_handler().player_timer_upgrade += 0.5
	
func load_next_round():
	state_handler.load_next_level()
