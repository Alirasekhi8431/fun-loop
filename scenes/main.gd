# Main.gd
extends Node2D

# Path to your level scene
const LEVEL1_SCENE_PATH = "res://scenes/level1.tscn"

# This will hold the entered group ID
var group_id: String = ""

# Called when the scene is ready
func _ready():
	# Connect the button signal
	$VBoxContainer/Button.pressed.connect(_on_play_pressed)


func _on_play_pressed():
	# Get the text from TextEdit
	group_id = $VBoxContainer/HBoxContainer/TextEdit.text.strip_edges()
	
	if group_id == "":
		# Optional: warn the user if empty
		print("Please enter a group ID before playing!")
		return
	
	# Save the group ID to an autoload or singleton for access in level1
	Globals.group_id = group_id  # We'll set up this singleton next
	
	# Load level1.tscn
	get_tree().change_scene_to_file(LEVEL1_SCENE_PATH)
