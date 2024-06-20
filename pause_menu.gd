extends Control

func _ready():
	print("Pause menu is ready")

func _input(event):
	print("input event registered in pause menu")
	if event.is_action_pressed("options"):
		get_tree().change_scene_to_file("res://scenes/level.tscn")
