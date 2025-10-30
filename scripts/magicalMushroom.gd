# MagicPowerUp.gd (attached to the Area2D node)
extends Area2D

# This function is called when a body (like your player) enters the area.
func _on_body_entered(body):
	# Check if the body that entered is the player (assuming your player node is named 'Player'
	# or has a specific group assigned, or extends a specific Player script).
	# For simplicity, we'll check if it has the 'increase_jump_speed' function.
	if body.has_method("increase_jump_speed"):
		# 1. Increase the player's jump speed
		body.increase_jump_speed()
		
		# 2. Delete the magical node from the scene
		queue_free()
