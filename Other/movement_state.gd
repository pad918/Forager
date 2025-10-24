class_name MovementState

extends Node2D

@export var character: CharacterBody2D

var statemachine: MovementStateMachine

func _ready() -> void:
	statemachine = get_parent()

func update(delta:float):
	printerr("ABSTRACT METHOD CALLED: UPDATE in MOVEMENTSTATE!")
