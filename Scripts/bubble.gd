class_name Bubble
extends RigidBody2D


# Noise generator.
var noise: FastNoiseLite

var ambient_motion_force: float = 1.5

var point_value: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize noise generator
	noise = FastNoiseLite.new()
	noise.seed = int(randf() * 100000)
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.0005
	noise.fractal_gain = 1.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# Calculate the ambient motion for this bubble based on world position.
	var current_position = self.global_position
	var random_value = noise.get_noise_2d(current_position.x, current_position.y) * 3.0
	var turbulence_rot = random_value * 2.0 * PI
	var ambient_vec2 = Vector2(cos(turbulence_rot), sin(turbulence_rot))

	# Apply result vector to bubble.
	var ambient_force_actual = ambient_vec2 * ambient_motion_force * delta
	self.apply_impulse(ambient_force_actual)
