extends Node2D

class_name AnimationStateMachine

@export var anim_player: AnimationPlayer

@export var default_anim_name: String = "IdleRight"

var curr_anim_name:String = "NONE"

func play_animation(anim_name:String):
	if(anim_name != curr_anim_name):
		anim_player.play(anim_name)

func _ready() -> void:
	play_animation(default_anim_name)
