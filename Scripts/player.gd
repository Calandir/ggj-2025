class_name Player
extends CharacterBody2D

const TURN_WITH_SEPARATE_CONTROLS: bool = false

const SPEED = 300.0

@export var player_num: int = 0

# Gets set while in range and/or picked up
var pickups_in_range: Array[Fan] = []

func _process(delta):
	_process_pick_up()
		
func _process_pick_up():
	var input_prefix = "p" + str(player_num)
	if not Input.is_action_just_pressed(input_prefix + "_pick_up_down"):
		return
	
	if pickups_in_range.is_empty():
		return
	
	var first_pickup: Fan = pickups_in_range[0]
	#print("first_pickup is " + first_pickup.name)
	
	if first_pickup._picked_up_by_player == self:
		# Put it down
		first_pickup._picked_up_by_player = null
		first_pickup.reparent(get_parent())
	else:
		# Try to pick it up if free
		var is_picked_up_by_other_player = first_pickup._picked_up_by_player != null
		if is_picked_up_by_other_player:
			return
		
		first_pickup._picked_up_by_player = self
		first_pickup.reparent(self)

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
		# Add 90 because the sprite looks normal when moving up, not right
		rotation_degrees = 90.0 + rad_to_deg(input_direction.angle())
		
		# Apply rotation to current pickup as well
		if not pickups_in_range.is_empty() and pickups_in_range[0]._picked_up_by_player == self:
			# Undo the 90 degree compensation
			pickups_in_range[0].global_rotation_degrees = rotation_degrees - 90
		
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
