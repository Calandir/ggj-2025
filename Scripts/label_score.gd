extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_goal_goal_scored(goal_num: int, score: int) -> void:
	# Score <= score_to_win is a hack to get around sync issues on final goal of round.
	self.text = str(score)
