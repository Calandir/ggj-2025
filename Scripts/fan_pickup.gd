class_name FanPickup
extends Area2D

@export var pickup_root: Node2D

# To make sure only one player can pick this up at once
var _picked_up_by_player: Player = null


func _on_Area2D_body_entered(body) -> void:
	if body is Player:
		if _picked_up_by_player == body:
			# Horrible hack: ignore event, it fires when picked up/down
			return
		
		if not body.pickups_in_range.has(self):
			#print(body.name + " has " + name + " in range")
			body.pickups_in_range.append(self)


func _on_Area2D_body_exited(body) -> void:
	if body is Player:
		if _picked_up_by_player == body:
			# Horrible hack: ignore event, it fires when picked up/down
			return
			
		#print(body.name + " has " + name + " NOT in range")
		body.pickups_in_range.erase(self)
