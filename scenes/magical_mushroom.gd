extends Area2D

# How much the jump boost increases
@export var jump_boost := -100.0  # Negative because your jump is upward

func _ready():
	# Connect signal for when something enters the magic orb area
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	# Check if the object that touched it is the player
	if body.is_in_group("player"):
		# Directly modify the jump velocity
		body.JUMP_VELOCITY += jump_boost
		print("New jump velocity:", body.JUMP_VELOCITY)
		queue_free()  # Remove the orb from the scene
