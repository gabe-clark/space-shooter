extends Control

@onready var resolutions_option_button = $MarginContainer/HBoxContainer/VBoxContainer/OptionButton

func _ready():
	add_resolutions()
	
	# Load custom config
	var config = ConfigFile.new()
	var err = config.load(Global.CONFIG_FILE_PATH)

	# If the file didn't load, ignore it.
	if err != OK:
		return

	for player in config.get_sections():
		if config.has_section_key(player, "ResolutionString"):
			var resolution_string = config.get_value(player, "ResolutionString")
			get_window().set_size(GUI.resolutions[resolution_string])
			GUI.center_window()
			resolutions_option_button.selected = GUI.resolutions.keys().find(resolution_string)
		
func add_resolutions():
	for r in GUI.resolutions:
		resolutions_option_button.add_item(r)

func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolutions_index = GUI.resolutions.keys().find(window_size_string)
	resolutions_option_button.selected = resolutions_index 

func _on_option_button_item_selected(index):
	var key = resolutions_option_button.get_item_text(index)
	get_window().set_size(GUI.resolutions[key])
	GUI.center_window()
	Global.save_custom_config("DefaultPlayer", "ResolutionString", key)

