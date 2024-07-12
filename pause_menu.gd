extends Control

func _ready():
	get_tree().paused = false
	# This is a total hack because I could not figure out how to do it in the GUI editor.
	# TODO: Figure out how to do this in the editor, the right way
	# Might not even need the MarginContainer
	$PanelContainer/VBoxContainer/MarginContainer.custom_minimum_size = Vector2($PanelContainer/VBoxContainer/MasterLabel.get_rect().size*2)

func _input(event):
	if event.is_action_pressed("options") and get_tree().paused == false:
		pause()
		show()
	elif event.is_action_pressed("options") and get_tree().paused:
		hide()
		resume()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play()

func _on_quit_pressed():
	get_tree().quit()
