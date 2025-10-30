extends Area2D

const PLAYER_GROUP = "player"
const GRAVITY: float = 800.0 # Standard Godot gravity value
var velocity: Vector2 = Vector2.ZERO # Stores the movement vector

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _physics_process(delta):
	# 1. Apply gravity (increase downward velocity over time)
	velocity.y += GRAVITY * delta
	
	# 2. Move the bomb using the calculated velocity
	# NOTE: Area2D doesn't have move_and_slide(), so we update position directly.
	position += velocity * delta
	
	# Optional: Check for collision with the ground/static environment
	# A cleaner way is using signals (see note below), but a simple Y check works:
	# if position.y > get_viewport_rect().size.y:
	#     queue_free() # Remove bomb if it falls off screen


func _on_body_entered(body):
	# This check remains the same for player collision
	if body.is_in_group(PLAYER_GROUP):
		print("Player hit the bomb! Restarting level...")
		restart_level()
		# queue_free() # Bomb explodes/disappears
		

func restart_level():
	var current_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene_path)
