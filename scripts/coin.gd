extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	print(body.name)
	if body.name.begins_with("Player"):
		game_manager.add_point()
		animation_player.play("pickup")
