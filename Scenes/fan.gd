extends Area2D



var wind_force_vec2 = Vector2(30, 0)  # Wind strength (blows direction to the right)

# Keep track of bubbles in current fan area
var bubbles_in_fan = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for bubble in bubbles_in_fan:
		# TODO, falloff force based on distance from fan?
		var rotation_angle = self.rotation  # radians
		var wind_force_directed = Vector2(cos(rotation_angle), sin(rotation_angle)) * wind_force_vec2
		bubble.apply_impulse(wind_force_directed * delta)


func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		bubbles_in_fan.append(body)

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		bubbles_in_fan.erase(body)
