extends Label

# Declare the score variable
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = "Score: " + str(score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Function to update the score and update the UI text
func update_score():
	score += 1
	self.text = "Score: " + str(score)


func _on_goal_goal_scored() -> void:
	score += 1
	self.text = "Score: " + str(score)
