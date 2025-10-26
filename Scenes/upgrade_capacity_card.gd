extends UpgradeCard

class_name UpgradeCapacityCard

@export var capacity_upgrade_amount:float = 0.5

func perform_upgrade():
	get_node("/root/GameEntryPoint/GameStateHandler").player_capacity_upgrade += capacity_upgrade_amount
