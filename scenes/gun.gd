# Gun.gd
extends Node2D

# Packed scene for bullets
var bullet_scene: PackedScene


func _ready() -> void:
	bullet_scene = load("res://scenes/bullet.tscn") as PackedScene


func _process(delta: float) -> void:
	pass  # Nothing to do per frame


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_ev := event as InputEventKey
		if key_ev.pressed and not key_ev.echo and key_ev.keycode == Key.KEY_S:
			print("shooting ...")

			# Instantiate bullet
			var new_bullet = bullet_scene.instantiate() as CharacterBody2D

			# Check parent metadata for direction
			if get_parent().has_meta("isLeft") and get_parent().get_meta("isLeft") == true:
				new_bullet.velocity = Vector2(-1, 0)
			else:
				new_bullet.velocity = Vector2(1, 0)

			# Add the bullet as a child of the gun
			add_child(new_bullet)
