extends CharacterBody2D

const SPEED = 300.0

@export var player_num: int = 0

func apply_input() -> Vector2:
	var input_prefix = "p" + str(player_num)
	
	var input_direction = Input.get_vector(
		input_prefix + "_left",
		input_prefix + "_right",
		input_prefix + "_up",
		input_prefix + "_down")
	
	return input_direction * SPEED

func _physics_process(delta):
	var inputVector2 = apply_input()
	
	velocity = inputVector2
	
	if not velocity.is_zero_approx():
		rotation_degrees = 90.0 + rad_to_deg(inputVector2.angle())
		
		#print(str(inputVector2) + " " + str(inputVector2.angle()))
		
	move_and_slide()
