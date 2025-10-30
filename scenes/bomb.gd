extends Area2D

# Variable to hold the name of the player's group (optional but good practice)
const PLAYER_GROUP = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the 'body_entered' signal to a function in this script.
	# This signal is emitted when a PhysicsBody2D (like a CharacterBody2D/RigidBody2D) 
	# enters the Area2D's collision shape.
	connect("body_entered", Callable(self, "_on_body_entered"))


# Function that runs when another body enters the bomb's area.
func _on_body_entered(body):
	print("something hit me")
	# Check if the body that entered is the player (e.g., by checking a group).
	# Make sure your Player node is added to the "player" group!
	if body.is_in_group(PLAYER_GROUP):
		print("Player hit the bomb! Restarting level...")
		
		# --- RESTART THE LEVEL ---
		restart_level()
		
		# Optionally queue_free() the bomb so it can't be hit again
		# queue_free() 


func restart_level():
	# Get the current scene's path. If your current level scene is e.g. "res://scenes/Level1.tscn"
	var current_scene_path = get_tree().current_scene.scene_file_path
	
	# Reload the current scene
	get_tree().change_scene_to_file(current_scene_path)
