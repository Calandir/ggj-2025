extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func _on_pressed_yes() -> void:
	var game_scene = load("res://Scenes/example_scene.tscn")  # Use the path to your game scene
	get_tree().change_scene_to_packed(game_scene)


func _on_pressed_no() -> void:
	var game_scene = load("res://Scenes/menu.tscn")  # Use the path to your game scene
	get_tree().change_scene_to_packed(game_scene)
