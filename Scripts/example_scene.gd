extends Node2D


@export var score_to_win: int = 20


var win_label 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_label = $PlayerWinsLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_score_is_game_over(goal_num: int, score: int) -> void:
	if score == score_to_win:
		var player_name
		var losing_player
		if goal_num:
			player_name = Globalvars.player1_name
			losing_player = $"Player 1"
		else:
			player_name = Globalvars.player2_name
			losing_player = $"Player 0"

		win_label.text = player_name + " WINS!"
		win_label.show()

		# Hide losing player and fans for winning player to enjoy their moment.
		losing_player.hide()
		losing_player.set_process(false)
		var fan_grp = $Fan_grp
		fan_grp.hide()
		fan_grp.set_process(false)
