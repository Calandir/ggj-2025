extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent: CanvasItem = get_parent()
	
	parent.scale = 1.4 * Vector2.ONE
	parent.modulate = Color.TRANSPARENT
	
	var tween_1 = get_tree().create_tween()
	tween_1.tween_property(parent, "scale", Vector2.ONE, 0.5)
	
	var tween_2 = get_tree().create_tween()
	tween_2.tween_property(parent, "modulate", Color.WHITE, 0.3)
