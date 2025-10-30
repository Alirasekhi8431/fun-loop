# Bomb.gd (or whatever script is on your bomb node)
extends Area2D

# Removed @onready var timer = $Timer and the timer functions
# because they are unnecessary for a simple scene reload.

func _ready():
	# Use the built-in signal connection from the editor or connect like this:
	# connect("body_entered", Callable(self, "_on_body_entered"))
	# Note: In modern Godot, using the editor's Signals tab is often easier.
	pass

func _on_body_entered(body: Node) -> void:
	# Check if the body that entered the bomb's area is the player
	print("Something hit me")
	if body.is_in_group("player"):
		print("Player hit by bomb! Resetting scene.")
		
		# Immediately reload the current scene
		get_tree().reload_current_scene()

func _on_area_entered(area: Node) -> void:
	print("Something hit me")
	if area.is_in_group("player"):
		print("Pld dayer hit by bomb! Resetting scene.")
		
		# Immediately reload the current scene
		get_tree().reload_current_scene()
 
