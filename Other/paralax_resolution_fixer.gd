extends Parallax2D


# Get the size of the viewprt, offset by half of it
# This will solve the resolution problem (i think)

@export var player:Player 

var original_offset:Vector2 

func _ready() -> void:
	original_offset = scroll_offset

func _process(delta: float) -> void:
	scroll_offset.y = original_offset.y -(-(get_viewport_rect().size.y-800)) * 1
