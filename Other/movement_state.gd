class_name MovementState

extends Node2D

@export var character: CharacterBody2D

var statemachine: MovementStateMachine

func get_sfx_player() -> SFXPlayer:
	return get_parent().sfx_player

func _ready() -> void:
	statemachine = get_parent()

func update(delta:float):
	printerr("ABSTRACT METHOD CALLED: UPDATE in MOVEMENTSTATE!")

func became_active_state():
	pass
