extends Sprite2D

@export var player_num: int = 0

var player: Player = null

func _ready():
	player = get_node("../Player " + str(player_num))

func _process(delta):
	if player._get_currently_picked_up():
		queue_free()
