extends Label

# Declare the score variable
var score : int = 0
var playername : String = ""
@export var playerIdentifier: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(Globalvars.player1_name)
	if playerIdentifier == 0:
		self.text = Globalvars.player1_name + " Score: " + str(score)
	else:
		self.text = Globalvars.player2_name + " Score: " + str(score)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Function to update the score and update the UI text
func update_score():
	Globalvars.player1_score += 1
	#self.text = Globalvars.player1_name + " Score: " + str(score)


func _on_goal_goal_scored() -> void:
	score += 1
	if playerIdentifier == 0:
		self.text = Globalvars.player1_name + " Score: " + str(score)
	else:
		self.text = Globalvars.player2_name + " Score: " + str(score)
	
