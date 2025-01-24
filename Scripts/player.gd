extends CharacterBody2D

const SPEED = 300.0

@export var player_num: int = 0

func apply_input():
	var input_prefix = "p" + str(player_num)
	
	var input_direction = Input.get_vector(
		input_prefix + "_left",
		input_prefix + "_right",
		input_prefix + "_up",
		input_prefix + "_down")
	
	velocity = input_direction * SPEED

func _physics_process(delta):
	apply_input()
	move_and_slide()
