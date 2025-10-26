extends "res://Other/movement_state.gd"

class_name StemMovementState

@export var acceleration: Vector2 = Vector2(200, 100)

@export var max_speed: Vector2 = Vector2(1000, 1000)

@export var friction: Vector2 = Vector2(200, 100)

@export var gliding_state: MovementState
@export var side_movement_state: MovementState

@export var jump_boost_sideways: Vector2 = Vector2(1000, 200)

@export var jump_boost_up: float = 500
@export var jump_boost_down: float = 500

var last_mov_y_dir: float = 1

# Used to temporarely change the friction (e.g. when jumping)
var friction_multiplier:Vector2 = Vector2(1, 1)
var max_speed_multiplier:Vector2 = Vector2(1, 1)


func _ready() -> void:
	super._ready()
	area_collider.area_exited.connect(
		func (a:Area2D):
			if((a.collision_layer&(1<<1)) != 0):
				if(!is_on_steam()):
					print("Exiting tree stem!")
					statemachine.set_movement_state(self, gliding_state)
	)
	area_collider.area_entered.connect(
		func(a:Area2D):
			if((a.collision_layer&(1<<2)) != 0):
				print("entered branch")
				statemachine.set_movement_state(self, side_movement_state)
			# If entered ground
			if((a.collision_layer&(1<<0)) != 0):
				print("entered ground")
				get_sfx_player().play_sfx("LandGround")
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
	# Slowly restore friction if 
	friction_multiplier.y = min(1, friction_multiplier.y+delta*3)
	friction_multiplier.x = min(1, friction_multiplier.x+delta*3)
	
	# Slowly restore max speed multiplier
	max_speed_multiplier.x = max(1, max_speed_multiplier.x-delta*6)
	max_speed_multiplier.y = max(1, max_speed_multiplier.y-delta*6)
	
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
				) * friction_multiplier.x
			
	if input_dir == Vector2.ZERO:
		character.velocity.y -= linear_fiction(
			character.velocity.y, delta*friction.y,
			func(s): # Easing function for Y friction
				return max(0, min(1, ease(abs(s)/max_speed.y, 0.4)))
				) * friction_multiplier.y
		
	# Limit speed to +- max_speed
	character.velocity.x = max(
		-max_speed.x*max_speed_multiplier.x, 
		min(max_speed.x*max_speed_multiplier.x, character.velocity.x)
		) 
	character.velocity.y = max(
		-max_speed.y*max_speed_multiplier.y, 
		min(max_speed.y*max_speed_multiplier.y, character.velocity.y)
		) 
	
	# If user presses space (and side arrows), give massive x speed boost and
	# Go to next state
	if (input_dir.x != 0 and Input.is_action_just_pressed("Jump")):
		character.velocity.y += jump_boost_sideways.y # Give upward boost no matter which direction it is moving
		character.velocity.x += jump_boost_sideways.x * input_dir.x
		statemachine.set_movement_state(self, gliding_state)
	#TODO: This does not look good. I can not just set the speed, it has to be 
	# an accelleration applied over time / I have to reduce the friction for a little time after
	# jumping up!
	elif(input_dir.y < 0 and Input.is_action_just_pressed("Jump")):
		print("Vertical boost")
		friction_multiplier.y = 0.2
		max_speed_multiplier.y = 3
		character.velocity.y -= jump_boost_up
	#Drop down from the tree
	elif(input_dir.y > 0 and  Input.is_action_just_pressed("Jump")):
		print("Falling")
		character.velocity.y += jump_boost_down
		statemachine.set_movement_state(self, gliding_state)
	
	character.move_and_slide();
	
	# Set the animation
	if(input_dir.y==0):
		play_animation("ClimbStillUp" if last_mov_y_dir<=0 else "ClimbStillDown")
	else:
		play_animation("ClimbUp" if input_dir.y<=0 else "ClimbDown")
		last_mov_y_dir = input_dir.y
	
	
