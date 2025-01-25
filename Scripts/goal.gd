extends Area2D

@export var goal_num: int = 0

# Keep track of bubbles eaten by goal
var score = 0


signal goal_scored(goal_num: int, score: int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		score += 1
		body.queue_free()
		print(goal_num, score)
		emit_signal("goal_scored", goal_num, score)
	