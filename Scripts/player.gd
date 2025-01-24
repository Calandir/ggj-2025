extends CharacterBody2D

const TURN_WITH_SEPARATE_CONTROLS: bool = false

const SPEED = 300.0

@export var player_num: int = 0

func _physics_process(delta):
	var inputVector2 = _get_move_input()
	
	velocity = inputVector2
	
	if TURN_WITH_SEPARATE_CONTROLS:
		_process_rotation(_get_look_input())
	else:
		_process_rotation(inputVector2)
		
	move_and_slide()

func _process_rotation(input_direction: Vector2):
	if not input_direction.is_zero_approx():
		rotation_degrees = 90.0 + rad_to_deg(input_direction.angle())
		
		#print(str(input_direction) + " " + str(input_direction.angle()))

func _get_move_input() -> Vector2:
	var input_prefix = "p" + str(player_num)
	
	var input_direction = Input.get_vector(
		input_prefix + "_left",
		input_prefix + "_right",
		input_prefix + "_up",
		input_prefix + "_down")
	
	return input_direction * SPEED

func _get_look_input() -> Vector2:
	var input_prefix = "p" + str(player_num)
	
	var input_direction = Input.get_vector(
		input_prefix + "_look_left",
		input_prefix + "_look_right",
		input_prefix + "_look_up",
		input_prefix + "_look_down")
	
	return input_direction * SPEED
