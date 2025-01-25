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
var fan_max_range: float = 670.0

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
		if _picked_up_by_player == body:
			# Horrible hack: ignore event, it fires when picked up/down
			return
		
		if not body.pickups_in_range.has(self):
			#print(body.name + " has " + name + " in range")
			body.pickups_in_range.append(self)


func _on_Area2D_body_exited(body) -> void:
	if body is RigidBody2D:
		_bubbles_in_fan.erase(body)
	elif body is Player:
		if _picked_up_by_player == body:
			# Horrible hack: ignore event, it fires when picked up/down
			return
			
		#print(body.name + " has " + name + " NOT in range")
		body.pickups_in_range.erase(self)


func _push_bubble(bubble: RigidBody2D, delta: float) -> void:
	# Strength of fan is calculated based on how close bubble is to the fan.
	var fan_bubble_vec2 = self.global_position - bubble.global_position
	var distance_from_fan = sqrt(fan_bubble_vec2.x ** 2 + fan_bubble_vec2.y ** 2)
	var falloff = smoothstep(fan_max_range, 0.0, distance_from_fan)
	var fan_strength = wind_force * falloff

	# Get the fan force vector based on the rotation of the fan.
	var turbulence_rot = noise.get_noise_1d(distance_from_fan) * fan_turbulence_mult
	# Apply some random noise to the direction to simulate air currents.
	var fan_rotation_angle = self.global_rotation + turbulence_rot
	var fan_force_vec2 = Vector2(cos(fan_rotation_angle), sin(fan_rotation_angle))

	# Apply the final fan force vector to the bubble.
	var fan_force_actual = (fan_force_vec2 * fan_strength * delta)

	bubble.apply_impulse(fan_force_actual)
