extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		get_tree().change_scene_to_file("res://scenes/level_flash.tscn")
