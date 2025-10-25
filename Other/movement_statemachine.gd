extends Node2D

class_name MovementStateMachine

@export var character_body: CharacterBody2D

@export var current_state: MovementState

@export var animator: AnimatedSprite2D

@export var sfx_player: SFXPlayer

@export var animation_tree: AnimationTree

func set_animation_frame(source_state:MovementState, frame_id:int):
	if(source_state == current_state):
		animator.frame = frame_id

func set_movement_state(source_state:MovementState, new_state:MovementState):
	# Only allow the currently active state to change to another state
	if(new_state==null):
		printerr("Trying to set the state to null!")
	if(source_state == current_state):
		current_state = new_state
		current_state.became_active_state()
	
func _physics_process(delta: float) -> void:
	current_state.update(delta)
	animation_tree.set("parameters/blend_position", character_body.velocity.normalized())
