extends Node


# Called when the node enters the scene tree for the first time.
@onready var tilemap = get_node("/root/Game/TileMap")
@onready var player = get_node("/root/Game/Player")
@onready var xdist = 0
@onready var game_manager = %GameManager
const K = 5

func _physics_process(delta: float) -> void:
	var tile_coords = tilemap.local_to_map(tilemap.to_local(player.global_position))
	xdist = abs(tile_coords.x)
	var allowed = 2 * game_manager.score + K
	if xdist > allowed:
		var clam = Vector2(allowed, 0)
		var bound = tilemap.to_global(tilemap.map_to_local(clam)).x
		#player.position.x = clamp(player.position.x, -bound, bound)
		player.position.x = lerp(player.position.x, clamp(player.position.x, -bound, bound), 0.2)

	
