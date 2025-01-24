extends Area2D



# Wind force at 0 distance from fan (will fall off the farther bubble is from fan).
var wind_force = 60

# Fan will only push bubble that are in range given by this value.
var fan_max_range = 650

# Keep track of bubbles in current fan area.
var _bubbles_in_fan = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for bubble in _bubbles_in_fan:
		_push_bubble(bubble, delta)


func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		_bubbles_in_fan.append(body)

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		_bubbles_in_fan.erase(body)


func _push_bubble(bubble: RigidBody2D, delta: float):
	# Strength of fan is based on how close bubble is to the fan.
	var fan_bubble_vec2 = self.global_position - bubble.global_position
	var distance_from_fan = sqrt(fan_bubble_vec2.x ** 2 + fan_bubble_vec2.y ** 2)
	var fan_strength = max((fan_max_range - distance_from_fan) / fan_max_range * wind_force, 0)

	# Get the fan force vector based on the rotation of the fan.
	var fan_rotation_angle = self.global_rotation  # radians
	var fan_force_vec2 = Vector2(cos(fan_rotation_angle), sin(fan_rotation_angle))

	# Apply the final fan force vector to the bubble.
	var fan_force_actual = fan_force_vec2 * fan_strength * delta
	bubble.apply_impulse(fan_force_actual)
