# Bullet.gd
extends CharacterBody2D

const SPEED: float = 160.0

func _ready() -> void:
	# Set collision layers/masks
	collision_layer = 2
	collision_mask = 1
	# Optionally make this top-level if needed:
	# set_owner(null)  

func _physics_process(delta: float) -> void:
	var vel: Vector2 = velocity

	# Move horizontally according to current velocity direction
	vel.x = sign(velocity.x) * SPEED * delta

	velocity = vel

	var collision = move_and_collide(velocity)
	if collision:
		# Optional: get the collider if needed
		var collider = collision.get_collider()
		queue_free()  # Destroy bullet on collision
