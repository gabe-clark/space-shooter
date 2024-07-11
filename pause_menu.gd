extends Control

func _ready():
	get_tree().paused = false

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
