extends Node2D

# A node that has children audio players and rotates between them

class_name SoundRotator

var curr_id:int = 0

func play():
	var child_id:int = curr_id % get_child_count()
	var player:AudioStreamPlayer = get_child(child_id)
	player.play()
	curr_id += 1
