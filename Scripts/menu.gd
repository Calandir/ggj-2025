extends Control

@onready var start_button = $Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	pass # Replace with function body.
	
	
func _on_start_button_pressed():
	# Load the main game scene (replace "res://GameScene.tscn" with your scene's actual path)
	var game_scene = load("res://Scenes/example_scene.tscn")  # Use the path to your game scene
	get_tree().change_scene_to_packed(game_scene)
	# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass
