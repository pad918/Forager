class_name MovementState

extends Node2D

@export var character: Player

@export var area_collider: Area2D

var statemachine: MovementStateMachine

# To fix the problem with multiple intersecting trees:
var colliding_trees: Array = []

var colliding_grounds: Array = []

func is_on_steam()->bool:
	return !colliding_trees.is_empty()

func is_on_ground() -> bool:
	return !colliding_grounds.is_empty()

func get_sfx_player() -> SFXPlayer:
	return get_parent().sfx_player

func _ready() -> void:
	statemachine = get_parent()
	area_collider.area_exited.connect(
		func (a:Area2D):
			if((a.collision_layer&(1<<1)) != 0):
				var pos:int = colliding_trees.find(a)
				if(pos>=0):
					colliding_trees.remove_at(pos)
				print("Exited area ", a.name)
			if((a.collision_layer&(1<<0)) != 0):
				var pos:int = colliding_grounds.find(a)
				if(pos>=0):
					colliding_grounds.remove_at(pos)
				print("exited ground")
			)
	area_collider.area_entered.connect(
		func(a:Area2D):
			if(a.collision_layer&(1<<1) != 0):
				colliding_trees.append(a)
			if((a.collision_layer&(1<<0)) != 0):
				colliding_grounds.append(a)
	)

func update(delta:float):
	printerr("ABSTRACT METHOD CALLED: UPDATE in MOVEMENTSTATE!")

func became_active_state():
	pass

func play_animation(anim_name:String):
	statemachine.play_animation(anim_name)
