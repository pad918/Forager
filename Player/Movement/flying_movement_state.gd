extends "res://Other/movement_state.gd"

class_name FlyingMovementState

@export var max_fall_speed = 2000

@export var gravity = 100

@export var player_area_collider:Area2D

@export var stem_climb_state: MovementState

@export var side_movement_state: MovementState

@export var friction_x = 0.01

func _ready() -> void:
	super._ready()

	player_area_collider.area_entered.connect(
		func (a):
			print("Entered area ", a.name, " colmask: ", a.collision_layer)
			if((a.collision_layer&(1<<1)) != 0):
				statemachine.set_movement_state(self, stem_climb_state)
			# Add state for entering  branch
			if((a.collision_layer&(1<<2)) != 0):
				print("entered branch")
				statemachine.set_movement_state(self, side_movement_state)
			# Or entering the ground (layer 1)
			if((a.collision_layer&(1<<0)) != 0):
				print("entered ground")
				statemachine.set_movement_state(self, side_movement_state)
		
	)

func update(delta:float):
	character.velocity += delta*Vector2(0, gravity)
	character.velocity.y = min(max_fall_speed, character.velocity.y)
	character.velocity.x *= (1-friction_x)
	character.move_and_slide()
