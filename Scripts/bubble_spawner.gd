extends Node

const USE_AUTO_SPAWN: bool = true
const USE_MANUAL_SPAWN: bool = false

const TIME_BETWEEN_BUBBLES: float = 3.0
var _time_until_next_bubble: float = 0.0

@export var _auto_spawn_topleft: Node2D
@export var _auto_spawn_bottomRight: Node2D

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
	_spawn_bubble_in_area(_auto_spawn_topleft, _auto_spawn_bottomRight)

func _process_manual_spawn():
	if Input.is_action_just_pressed("p0_spawn_bubble"):
		_spawn_bubble_in_area(_p0_spawn_topleft, _p0_spawn_bottomRight)
	if Input.is_action_just_pressed("p1_spawn_bubble"):
		_spawn_bubble_in_area(_p1_spawn_topleft, _p1_spawn_bottomRight)

func _spawn_bubble_in_area(topleft_corner: Node2D, bottomright_corner: Node2D):
	var spawn_point = Vector2(randf_range(topleft_corner.position.x, bottomright_corner.position.x), randf_range(topleft_corner.position.y, bottomright_corner.position.y))
	
	var new_bubble: Bubble = bubble_scene.instantiate()
	new_bubble.position = spawn_point
	print(spawn_point)
	
	var random = randf()
	
	# 50% chance of small bubble
	if random < 0.5:
		new_bubble.point_value = 1
		new_bubble.mass = 0.03
		for child in new_bubble.get_children():
			child.scale = Vector2(0.5, 0.5)
	# 10% chance of big bubble
	elif random < 0.6:
		new_bubble.point_value = 3
		new_bubble.mass = 0.5
		for child in new_bubble.get_children():
			child.scale = Vector2(1.3, 1.3)
	# 40% chance of normal bubble
	else:
		new_bubble.point_value = 2
		new_bubble.mass = 0.15
	
	get_tree().root.add_child(new_bubble)

	$AudioStreamPlayer2D.play()
