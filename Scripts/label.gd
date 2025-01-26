extends Label

# Declare the score variable
var score : int = 0
var playername : String = ""
@export var playerIdentifier: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(Globalvars.player2_name)
	if playerIdentifier == 0:
		self.text = Globalvars.player2_name
	else:
		self.text = Globalvars.player1_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
