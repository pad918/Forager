extends Area2D

class_name PuserArea

@export var push_force_vector:Vector2

var player:Player = null

func _ready() -> void:
	area_entered.connect(
		func(a:Area2D):
			var _player: Player = a.get_parent()
			if(_player is Player):
				player = _player
	)
	area_exited.connect(
		func(a:Area2D):
			var _player: Player = a.get_parent()
			if(_player is Player):
				player = null
	)

func _physics_process(_delta: float) -> void:
	if(player != null):
		print("GLOB ROT:", global_rotation)
		var rotated_push_force = push_force_vector.rotated(global_rotation)
		player.velocity = rotated_push_force
		player.position += rotated_push_force.normalized()*10
