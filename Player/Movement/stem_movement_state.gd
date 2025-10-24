extends "res://Other/movement_state.gd"

class_name StemMovementState

@export var acceleration: Vector2 = Vector2(200, 100)

@export var max_speed: Vector2 = Vector2(1000, 1000)

@export var friction: Vector2 = Vector2(200, 100)

@export var area_collider: Area2D 

@export var gliding_state: MovementState
@export var side_movement_state: MovementState

@export var jump_boost: Vector2 = Vector2(1000, 200)

func _ready() -> void:
	super._ready()
	area_collider.area_exited.connect(
		func (a:Area2D):
			print("Exited area ", a.name)
			if((a.collision_layer&(1<<1)) != 0):
				statemachine.set_movement_state(self, gliding_state)
	)
	area_collider.area_entered.connect(
		func(a:Area2D):
			if((a.collision_layer&(1<<2)) != 0):
				print("entered branch")
				statemachine.set_movement_state(self, side_movement_state)
	)

func linear_fiction(curr_vel:float, frame_friction:float, ease_fn = null) -> float:
	var fric: float = frame_friction * sign(curr_vel)
	if(sign(curr_vel-fric) != sign(curr_vel)):
		return curr_vel # Set curr_vel to exactly 0 if it flips over!
	if ease_fn != null:
		return fric * ease_fn.call(curr_vel)
	return fric

func update(delta:float):
	var input_dir = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		input_dir += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		input_dir += Vector2(0, 1)
	
	# Handle horizontal movement
	if Input.is_action_pressed("ui_left"):
		input_dir += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		input_dir += Vector2(1, 0)	

	character.velocity += input_dir * acceleration
	
	# Apply friction if there is no input
	if input_dir.x == 0:
		character.velocity.x -= linear_fiction(
			character.velocity.x, delta*friction.x,
			func(s): # Easing function for X friction
				return max(0, min(1, ease(abs(s)/max_speed.x, 0.4)))
				)
			
	if input_dir == Vector2.ZERO:
		character.velocity.y -= linear_fiction(
			character.velocity.y, delta*friction.y,
			func(s): # Easing function for Y friction
				return max(0, min(1, ease(abs(s)/max_speed.y, 0.4)))
				)
		
	# Limit speed to +- max_speed
	character.velocity.x = max(-max_speed.x, min(max_speed.x, character.velocity.x)) 
	character.velocity.y = max(-max_speed.y, min(max_speed.y, character.velocity.y)) 
	
	character.move_and_slide();
	
	# If user presses space (and side arrows), give massive x speed boost and
	# Go to next state
	if (input_dir.x != 0 and Input.is_key_pressed(KEY_SPACE)):
		character.velocity.y += jump_boost.y # Give upward boost no matter which direction it is moving
		character.velocity.x += jump_boost.x * input_dir.x
		statemachine.set_movement_state(self, gliding_state)
