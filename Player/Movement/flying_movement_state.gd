extends "res://Other/movement_state.gd"

class_name FlyingMovementState

@export var gravity = 100

@export var stem_climb_state: MovementState

@export var side_movement_state: MovementState

@export var friction_x = 0.01

@export var x_acceleration = 100

@export var max_speed = Vector2(2000, 1000)

var time_since_started_falling:float = 0

var area_when_started = null

func became_active_state():
	time_since_started_falling = 0

func _ready() -> void:
	super._ready()

	area_collider.area_entered.connect(
		func (a):
			print("Entered area ", a.name, " colmask: ", a.collision_layer)
			# Add state for entering  branch
			if((a.collision_layer&(1<<2)) != 0):
				print("entered branch")
				# Only play if player is moving downwards!
				if(character.velocity.y>=-0.01):
					get_sfx_player().play_sfx("LandBranch")
				statemachine.set_movement_state(self, side_movement_state)
			# Or entering the ground (layer 1)
			if((a.collision_layer&(1<<0)) != 0):
				print("entered ground")
				get_sfx_player().play_sfx("LandGround")
				if(is_on_ground()):
					statemachine.set_movement_state(self, side_movement_state)
	)


func update(delta:float):

	time_since_started_falling += delta
	character.velocity += delta*Vector2(0, gravity)
	character.velocity.y = min(abs(max_speed.y), character.velocity.y)
	
	# Get input direction
	var input_dir: Vector2 =Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		input_dir += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		input_dir += Vector2(1, 0)	
		
	if Input.is_action_pressed("ui_up"):
		input_dir += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		input_dir += Vector2(0, 1)
	
	# If the user is trying to move upwards, and is over the stem,
	# go to the climbing state!
	if(is_on_steam() and input_dir.y < 0 and time_since_started_falling>0.25):
		statemachine.set_movement_state(self, stem_climb_state)	
	
	if(input_dir.x==0):
		character.velocity.x *= (1-friction_x)
	else:
		character.velocity.x += delta*input_dir.x*x_acceleration
	character.velocity.x = min(max_speed.x, max(-max_speed.x, character.velocity.x))
	character.move_and_slide()
	
	play_animation("FallRight" if character.velocity.x>0 else "FallLeft")
