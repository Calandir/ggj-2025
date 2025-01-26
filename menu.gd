extends Control

@onready var start_button = $Button
@onready var player2_name_input = $LineEdit1  # Reference to Player 1's LineEdit
@onready var player1_name_input = $LineEdit2




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	pass # Replace with function body.
	
	
func _on_start_button_pressed():
	# Load the main game scene (replace "res://GameScene.tscn" with your scene's actual path)

	if player2_name_input.text:
		Globalvars.player2_name = player2_name_input.text
	else:
		Globalvars.player2_name = "Player 2"
		
	if player1_name_input.text:
		Globalvars.player1_name = player1_name_input.text
	else:
		Globalvars.player1_name = "Player 1"
	
	var game_scene = load("res://Scenes/example_scene.tscn")  # Use the path to your game scene
	get_tree().change_scene_to_packed(game_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
