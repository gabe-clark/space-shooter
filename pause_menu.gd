extends Control

func _ready():
	get_tree().paused = false
	# This is a total hack because I could not figure out how to do it in the GUI editor.
	# TODO: Figure out how to do this in the editor, the right way
	# Might not even need the MarginContainer
	$PanelContainer/VBoxContainer/MarginContainer.custom_minimum_size = Vector2($PanelContainer/VBoxContainer/MasterLabel.get_rect().size*2)
	# Load custom config
	var config = ConfigFile.new()
	var err = config.load(Global.CONFIG_FILE_PATH)

	# If the file didn't load, ignore it.
	if err != OK:
		return

	for player in config.get_sections():
		if config.has_section_key(player, "MasterVolume"):
			var master_volume = config.get_value(player, "MasterVolume")
			var music_volume = config.get_value(player, "MusicVolume")
			var sound_effects_volume = config.get_value(player, "SoundEffectsVolume")
			$PanelContainer/VBoxContainer/MasterSlider.value = master_volume
			$PanelContainer/VBoxContainer/MusicSlider.value = music_volume
			$PanelContainer/VBoxContainer/SoundEffectsSlider.value = sound_effects_volume

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


func _on_master_slider_value_changed(value):
	Global.save_custom_config("DefaultPlayer", "MasterVolume", value)

func _on_music_slider_value_changed(value):
	Global.save_custom_config("DefaultPlayer", "MusicVolume", value)

func _on_sound_effects_slider_value_changed(value):
	Global.save_custom_config("DefaultPlayer", "SoundEffectsVolume", value)
