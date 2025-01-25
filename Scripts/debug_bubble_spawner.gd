extends Node

const USE_AUTO_SPAWN: bool = true

const TIME_BETWEEN_BUBBLES: float = 3.0
var _time_until_next_bubble: float = 0.0

@onready var bubble_scene = preload("res://Scenes/Bubble.tscn")

func _ready():
	_time_until_next_bubble = TIME_BETWEEN_BUBBLES

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_spawn_bubble"):
		get_tree().root.add_child(bubble_scene.instantiate())
	
	if USE_AUTO_SPAWN:
		_process_auto_spawn(delta)

func _process_auto_spawn(delta):
	_time_until_next_bubble -= delta
	
	if _time_until_next_bubble > 0.0:
		return
	
	_time_until_next_bubble += TIME_BETWEEN_BUBBLES
	get_tree().root.add_child(bubble_scene.instantiate())
