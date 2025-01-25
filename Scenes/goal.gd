extends Area2D

# Keep track of bubbles eaten by goal

var score = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
		
		
		
	

signal goal_scored

func _on_Area2D_body_entered(body):
	#print("collision detected!")
	if body is RigidBody2D:
		score += 1
		body.queue_free()
		#print("score!")	
		emit_signal("goal_scored")
	
	

#func _on_Area2D_body_exited(body):
	#if body is RigidBody2D:
		#bubbles_in_goal.erase(body)
