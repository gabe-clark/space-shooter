extends Node

var score := 0
const CONFIG_FILE_PATH = "user://config.cfg"

func save_custom_config(section: String, key: String, value, save_path = CONFIG_FILE_PATH):
	# This function takes the current configuration, rewrites it back to the file, then overwrites
	# once with the final call to config.set_value. I've implemented it this way because as of godot
	# 4.2 there seems not to be an easy to append to a configuration file. I may have just 
	# overlooked the documentation for that though. 
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	for sec in config.get_sections():
		for k in config.get_section_keys(sec):
			config.set_value(sec, k, config.get_value(sec, k))
	config.set_value(section, key, value)
	config.save(save_path)
