extends UpgradeCard

@export var speed_upgrade_amount:float = 0.2

func perform_upgrade():
	get_node("/root/GameEntryPoint/GameStateHandler").player_speed_upgrade += speed_upgrade_amount
