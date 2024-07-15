extends MarginContainer

# In hindsight a class was probably not the right choice. This is literally being used as nothing 
# more than a dictionary.
# TODO: Come back and switch this to a dictionary.
class Ship:
	var color: String
	var texture: Texture # Can probably constrain this more but not sure which to choose
	var particles_hex_code: String

	func _init(color: String, texture: Texture, particles_hex_code: String):
		self.color = color
		self.texture = texture
		self.particles_hex_code = particles_hex_code

var ships = [
	Ship.new("blue", load("res://SpaceShooterRedux/PNG/playerShip1_blue.png"), "4bffff"),
	Ship.new("green", load("res://SpaceShooterRedux/PNG/playerShip1_green.png"), "00FF2B"),
	Ship.new("orange", load("res://SpaceShooterRedux/PNG/playerShip1_orange.png"), "FFB300"),
	Ship.new("red", load("res://SpaceShooterRedux/PNG/playerShip1_red.png"), "FF0000"),
]

var ships_length = len(ships)
var cur_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture
	
func _on_back_button_pressed():
	# At the start, go to the end
	if cur_index == 0:
		cur_index = ships_length - 1
		$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture
	elif cur_index < ships_length:
		cur_index -= 1
		$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture
	else:
		push_error("Ship-chooser index out of bounds, defaulting to index 0")
		cur_index = 0
		$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture

func _on_next_button_pressed():
	# At the final, go back to the start
	if cur_index == ships_length - 1:
		cur_index = 0
		$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture
	elif cur_index >= 0:
		cur_index += 1
		$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture
	else:
		push_error("Ship-chooser index out of bounds, defaulting to index 0")
		cur_index = 0
		$VBoxContainer/HBoxContainer/TextureRect.texture = ships[cur_index].texture

func _on_button_pressed():
	PlayerVariables.ship_texture = ships[cur_index].texture
	PlayerVariables.particles_hex_code = ships[cur_index].particles_hex_code
	get_tree().change_scene_to_file("res://scenes/level.tscn")
