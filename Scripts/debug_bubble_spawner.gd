extends Node

const USE_AUTO_SPAWN: bool = false
const USE_MANUAL_SPAWN: bool = true

const TIME_BETWEEN_BUBBLES: float = 3.0
var _time_until_next_bubble: float = 0.0

@export var _p0_spawn_topleft: Node2D
@export var _p0_spawn_bottomRight: Node2D

@export var _p1_spawn_topleft: Node2D
@export var _p1_spawn_bottomRight: Node2D

@onready var bubble_scene = preload("res://Scenes/Bubble.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_spawn_bubble"):
		get_tree().root.add_child(bubble_scene.instantiate())
	
	if USE_AUTO_SPAWN:
		_process_auto_spawn(delta)
	if USE_MANUAL_SPAWN:
		_process_manual_spawn()

func _process_auto_spawn(delta):
	_time_until_next_bubble -= delta
	
	if _time_until_next_bubble > 0.0:
		return
	
	_time_until_next_bubble += TIME_BETWEEN_BUBBLES
	get_tree().root.add_child(bubble_scene.instantiate())

func _process_manual_spawn():
	if Input.is_action_just_pressed("p0_spawn_bubble"):
		_spawn_bubble_on_side(_p0_spawn_topleft, _p0_spawn_bottomRight)
	if Input.is_action_just_pressed("p1_spawn_bubble"):
		_spawn_bubble_on_side(_p1_spawn_topleft, _p1_spawn_bottomRight)

func _spawn_bubble_on_side(topleft_corner: Node2D, bottomright_corner: Node2D):
	var spawn_point = Vector2(randf_range(topleft_corner.position.x, bottomright_corner.position.x), randf_range(topleft_corner.position.y, bottomright_corner.position.y))
	
	var new_bubble: Node2D = bubble_scene.instantiate()
	new_bubble.position = spawn_point
	print(spawn_point)
	
	get_tree().root.add_child(new_bubble)
