extends CharacterBody2D

@export var speed: float = 100.0
@export var movement_range: float = 300.0
@export var drop_interval: float = 2.0 # Time in seconds between bomb drops

# Reference to the Bomb scene (Make sure to set this in the Inspector!)
@export var bomb_scene: PackedScene 

var direction: int = 1 # 1 for right, -1 for left
var start_x: float = 0.0
var time_until_drop: float = 0.0


func _ready():
	# Record the starting position to define the patrol path
	start_x = global_position.x
	time_until_drop = drop_interval


func _process(delta):
	# --- Bomb Dropping Timer ---
	time_until_drop -= delta
	if time_until_drop <= 0:
		drop_bomb()
		time_until_drop = drop_interval


func _physics_process(delta):
	# --- Horizontal Patrol Movement ---
	
	# Calculate horizontal velocity
	var velocity_x = speed * direction
	velocity.x = velocity_x
	
	# Check if the witch has reached the end of its patrol range
	if direction == 1 and global_position.x >= start_x + movement_range:
		direction = -1 # Change direction to left
		# You could flip the Sprite2D here if needed: $Sprite2D.flip_h = true
	elif direction == -1 and global_position.x <= start_x - movement_range:
		direction = 1 # Change direction to right
		# $Sprite2D.flip_h = false
		
	move_and_slide()


func drop_bomb():
	if bomb_scene:
		# Create a new instance of the bomb scene
		var bomb_instance = bomb_scene.instantiate()
		
		# Add the bomb to the main scene (the parent of the witch's parent, usually)
		get_parent().add_child(bomb_instance)
		
		# Position the bomb slightly below the witch
		bomb_instance.global_position = global_position + Vector2(0, 10) 
		
		# Optional: Apply an initial downward velocity to the bomb (if it needs to fall)
		# bomb_instance.apply_gravity_or_fall_logic()
