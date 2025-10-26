extends "res://Other/movement_state.gd"

class_name GroundMovementState

@export var stem_climb_state: MovementState
@export var fall_state: MovementState

@export var friction_x = 0.01
@export var gravity: float = 10
@export var sideways_mov_acceleration:float = 100
@export var max_speed: Vector2 = Vector2(1000, 1000)


@export var jump_boost: Vector2 = Vector2(1000, 200)


func _ready() -> void:
	super._ready()

	area_collider.area_entered.connect(
		func (_a:Area2D):
			pass
	)
	area_collider.area_exited.connect(
		func (a:Area2D):
			# If you exit a branch, fall
			if(((a.collision_layer&(1<<2)) != 0)):
				statemachine.set_movement_state(self, fall_state if !is_on_steam() else stem_climb_state)		
	)

func update(delta: float):
	var input_dir: Vector2 =Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		input_dir += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		input_dir += Vector2(1, 0)	
		
	if Input.is_action_pressed("ui_up"):
		input_dir += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		input_dir += Vector2(0, 1)
	
	character.velocity += delta*Vector2(0, gravity)
	character.velocity.x += input_dir.x * sideways_mov_acceleration
	if(input_dir.x==0):
		#apply friction
		character.velocity.x *= 0.9
	# Limit speed
	character.velocity.x = min(max_speed.x, max(-max_speed.x, character.velocity.x))
	character.velocity.y = min(max_speed.y, max(-max_speed.y, character.velocity.y))
	
	# If you are going upwards and are on a stem => change movement state
	if(is_on_steam() and input_dir.y<0):
		statemachine.set_movement_state(self, stem_climb_state)
	
	if (input_dir.x != 0 and Input.is_action_just_pressed("Jump")):
		character.velocity.y += jump_boost.y # Give upward boost no matter which direction it is moving
		character.velocity.x += jump_boost.x * input_dir.x
		statemachine.set_movement_state(self, fall_state)
		print("GAVE UP+SIDE BOOST!")
	elif(Input.is_action_just_pressed("Jump")):
		# Just jump strait up
		character.velocity.y += jump_boost.y
		statemachine.set_movement_state(self, fall_state)
		print("GAVE UP BOOST!")

	# Drop down from branch handeling
	if(input_dir.y>0 and not is_on_ground()):
		print("Dropping")
		statemachine.set_movement_state(self, fall_state)
		character.velocity.y = 200
		# Falling trhogh a bit will cause the collider
		# to stop working
		character.position.y += 10 
		
	
	character.move_and_slide()
	if(input_dir.x==0):
		play_animation("IdleRight" if character.velocity.x>0 else "IdleLeft")
	else:
		play_animation("WalkRight" if character.velocity.x>0 else "WalkLeft")
