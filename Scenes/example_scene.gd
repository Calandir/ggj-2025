extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player 1: " + Globalvars.player1_name)
	print("Player 2: " + Globalvars.player2_name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
