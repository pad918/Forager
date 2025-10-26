extends Node2D

class_name FallingLeafs

@export var animation_time:float = 10
@export var child_start_pos = Vector2(1000, -1000)
@export var spawn_pos_randomness: Vector2  = Vector2(700, 700)
@export var movment_dist = 1000
@export var direction:Vector2 = Vector2(-300, 300)
@export var spawn_every_x_seconds: float = 3.5

var instances: Array
var timer:float = 0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var c1:Node2D = get_child(0)
	c1.visible = false
	pre_generate(60)
	
func create_new_instance():
	var template:Node2D = get_child(0)
	var instance:Node2D = template.duplicate()
	instance.visible = true
	instance.position = child_start_pos
	instance.position += Vector2(rng.randf_range(-spawn_pos_randomness.x, spawn_pos_randomness.x), rng.randf_range(-spawn_pos_randomness.y, spawn_pos_randomness.y))
	add_child(instance)

func pre_generate(time:float):
	for i in range(30*int(time)):
		update_sprites(1.0/30.0)

func update_sprites(delta:float):
	timer += delta
	if(timer>spawn_every_x_seconds):
		timer = 0
		create_new_instance()
	
	for c:Node2D in get_children():
		if(c == get_child(0)):
			continue
		c.position += delta*direction
		if(c.position.distance_to(child_start_pos) >= movment_dist):
			c.queue_free()

func _process(delta: float) -> void:
	update_sprites(delta)
	
	
