extends Node2D


class_name BGMPlayer

var last_bgm: AudioStreamPlayer = null
var last_ambiance: AudioStreamPlayer = null

var curr_bgm: AudioStreamPlayer = null
var curr_ambiance: AudioStreamPlayer = null

var time_since_last_bgm_change:float = 0
var time_since_last_ambiance_change:float = 0

var bmg_cross_fade_time:float = 1
var ambiance_cross_fade_time:float = 1

func _ready() -> void:
	play_bgm("TitleBGM", 1)
	play_ambience("ForrestAmbience", 1)

func get_player(name:String)-> AudioStreamPlayer:
	var player = get_node(name)
	return player

func play_bgm(name:String, _cross_fade_time:float):
	if(curr_bgm!=null and curr_bgm.name == name):
		return
	time_since_last_bgm_change = 0
	bmg_cross_fade_time = _cross_fade_time
	last_bgm = curr_bgm
	curr_bgm = get_player(name)
	print("Starting BGM: ", name)
	
func play_ambience(name:String, _cross_fade_time:float):
	if(curr_ambiance!=null and curr_ambiance.name == name):
		return
	time_since_last_ambiance_change = 0
	ambiance_cross_fade_time = _cross_fade_time
	last_ambiance = curr_ambiance
	curr_ambiance = get_player(name)
	print("Starting ambiance: ", name)
	
	
# Fade in
func get_time_fade_in(curr_time:float, total_time:float) -> float:
	var volume: float = 0
	volume = min(1, curr_time/total_time)
	return volume

func get_time_fade_out(curr_time:float, total_time:float) -> float:
	return 1-get_time_fade_in(curr_time, total_time)

func _process(delta: float) -> void:
	time_since_last_bgm_change += delta
	time_since_last_ambiance_change += delta
	
	if(last_bgm!=null):
		last_bgm.volume_db = -60 * get_time_fade_in(time_since_last_bgm_change, bmg_cross_fade_time)
		
	if(last_ambiance!=null):
		last_ambiance.volume_db = -60 * get_time_fade_in(time_since_last_ambiance_change, ambiance_cross_fade_time)
	
	if(curr_bgm!=null):
		curr_bgm.volume_db =  -60 * get_time_fade_out(time_since_last_bgm_change, bmg_cross_fade_time)
	
	if(curr_ambiance!=null):
		curr_ambiance.volume_db = -60 * get_time_fade_out(time_since_last_ambiance_change, ambiance_cross_fade_time)
