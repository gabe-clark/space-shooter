extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var bonus_score_scene: PackedScene = load("res://scenes/bonus_score.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var health: int = 5

func _ready():
	# Setup health UI
	get_tree().call_group("ui", "set_health", health)
	$CanvasLayer/PauseMenu.hide()
	# stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()

	for star in $Stars.get_children():
		# position
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		var random_scale = rng.randf_range(1, 2)

		star.scale = Vector2(random_scale, random_scale)
		star.position = Vector2(random_x, random_y)
		star.speed_scale = rng.randf_range(0.6, 1.4)

# Don't forget to connect the timeout signal from the node
func _on_meteor_timer_timeout():
	# Step 2: Create an instance of that scene
	var meteor = meteor_scene.instantiate()

	# Step 3: Attach the node to the scene tree
	$Meteors.add_child(meteor)

	meteor.connect("collision", _on_meteor_collision)

# Don't forget to connect the timeout signal from the node
func _on_bonus_score_timer_timeout():
	# Step 2: Create an instance of that scene
	var bonus_score = bonus_score_scene.instantiate()

	# Step 3: Attach the node to the scene tree
	$BonusScores.add_child(bonus_score)

	bonus_score.connect("collision", _on_bonus_score_collision)

func _on_bonus_score_collision():
	print("Bonus score collision")
	Global.score += 10

func _on_meteor_collision():
	print("Meteor collision")
	health -= 1
	get_tree().call_group("ui", "set_health", health)
	if health == 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	$Player.play_collision_sound()


# Shoot laser
func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos

