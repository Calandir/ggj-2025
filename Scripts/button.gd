extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_pressed():
	
	var game_scene = load("res://Scenes/menu.tscn")
	get_tree().change_scene_to_packed(game_scene)
