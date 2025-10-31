extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		print("You died!")
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		#Engine.time_scale = 0.5
		#body.get_node("CollisionShape2D").queue_free()
		#timer.start()
	else:
		print("Killed slime")
		get_parent().queue_free()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
