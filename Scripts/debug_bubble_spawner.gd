extends Node

@onready var bubble_scene = preload("res://Scenes/Bubble.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_spawn_bubble"):
		get_tree().root.add_child(bubble_scene.instantiate())
