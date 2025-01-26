extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	Globalvars.game_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_score_is_game_over(goal_num: int, score: int) -> void:
	if score == Globalvars.score_to_win:
		var win_group = $GameOverUI
		var win_label = win_group.find_child("PlayerWinsLabel")
		var player_name
		var losing_player
		var player_1_win_screen = win_group.find_child("BlueWinsSprite")
		var player_2_win_screen = win_group.find_child("RedWinsSprite")
		if goal_num:
			player_name = Globalvars.player2_name
			losing_player = $"Player 1"
			player_1_win_screen.show()
			player_2_win_screen.hide()
		else:
			player_name = Globalvars.player1_name
			losing_player = $"Player 0"
			player_2_win_screen.show()
			player_1_win_screen.hide()

		win_group.show()
		win_label.text = player_name

		# Hide losing player and fans for winning player to enjoy their moment.
		losing_player.hide()
		losing_player.set_process(false)
		var fan_grp = $Fan_grp
		fan_grp.hide()
		fan_grp.set_process(false)

		Globalvars.game_active = false
