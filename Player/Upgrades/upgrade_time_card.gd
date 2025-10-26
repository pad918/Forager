extends UpgradeCard

class_name TimeUpgradeCard

@export var how_much_to_add:int = 15

func perform_upgrade():
	get_node("/root/GameEntryPoint/GameStateHandler").player_timer_upgrade += how_much_to_add
