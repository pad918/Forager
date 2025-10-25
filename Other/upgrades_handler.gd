extends Panel

class_name UpgradesHandler

func _ready() -> void:
	visible = false # Quick fix, WHY THE FUCK DOES IT BECOME VISIBLE WHEN YOU PLAY??

func get_game_state_handler() -> GameStateHandler:
	return get_node("/root/GameEntryPoint/GameStateHandler")

func try_upgrade_capacity():
	print("Upgrading Capasity")
	get_game_state_handler()

func try_upgrade_speed():
	print("Upgrading speed")
	
func try_upgrade_time():
	print("Upgrading time limit")
