class_name Fan
extends Area2D


# If fan is on/off
@export var fan_is_on: bool = false

# Wind force at 0 distance from fan (will fall off the farther bubble is from fan).
@export var wind_force: float = 100.0

# Control how much random turbulence occurs when blowing bubble.
var fan_turbulence_mult: float = 2.0

# Noise generator.
var noise: FastNoiseLite

# Fan will only push bubble that are in range given by this value.
var fan_max_range: float = 650.0

# Keep track of bubbles in current fan area.
var _bubbles_in_fan  = []

# To make sure only one player can pick this up at once
var _picked_up_by_player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize noise generator
	noise = FastNoiseLite.new()
	noise.seed = int(randf() * 100000)
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.005


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for bubble in _bubbles_in_fan:
		_push_bubble(bubble, delta)


func _on_Area2D_body_entered(body) -> void:
	if body is RigidBody2D:
		_bubbles_in_fan.append(body)
	elif body is Player:
		if not body.pickup_in_range:
			body.pickup_in_range = self

func _on_Area2D_body_exited(body) -> void:
	if body is RigidBody2D:
		_bubbles_in_fan.erase(body)
	elif body is Player:
		if body.pickup_in_range == self:
			body.pickup_in_range = null


func _push_bubble(bubble: RigidBody2D, delta: float) -> void:
	# Strength of fan is based on how close bubble is to the fan.
	var fan_bubble_vec2 = self.global_position - bubble.global_position
	var distance_from_fan = sqrt(fan_bubble_vec2.x ** 2 + fan_bubble_vec2.y ** 2)
	var fan_strength = max((fan_max_range - distance_from_fan) / fan_max_range * wind_force, 0.0)

	# Get the fan force vector based on the rotation of the fan.
	var fan_rotation_angle = self.global_rotation  # radians
	var fan_force_vec2 = Vector2(cos(fan_rotation_angle), sin(fan_rotation_angle))

	# Apply some random variance in the direction to simulate air currents.
	var random_rot = noise.get_noise_1d(distance_from_fan) * fan_turbulence_mult

	# Apply the final fan force vector to the bubble.
	var fan_force_actual = (fan_force_vec2 * fan_strength * delta).rotated(random_rot)

	bubble.apply_impulse(fan_force_actual)
