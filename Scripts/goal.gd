extends Area2D

@export var goal_num: int = 0

# Keep track of bubbles eaten by goal
var score = 0


signal goal_scored(goal_num: int, score: int)

var cheer_sfx := [
	load("res://Audio/cheer1_with_pop.wav"),
	load("res://Audio/cheer2_with_pop.wav"),
	load("res://Audio/cheer3_with_pop.wav"),
]


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
		emit_signal("goal_scored", goal_num, score)
		_play_cheer_sfx()


func _play_cheer_sfx():
		# AudioStreamPlayer can only play one sound at a time, which is an issue when scoring multiple bubbles.
		# The solution is to spawn an AudioStreamPlayer every time and clean it up when done.
		# https://www.reddit.com/r/godot/comments/1atc6oc/trying_to_create_a_temporary_audiostreamplayer/
		var sfx := AudioStreamPlayer.new()
		add_child(sfx)
		sfx.stream = cheer_sfx[randi() % 3]
		sfx.play()
		await sfx.finished
		sfx.queue_free()
