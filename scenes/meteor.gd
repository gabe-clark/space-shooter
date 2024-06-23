extends Area2D

signal collision

var speed: int
var rotation_speed: int
var direction_x: float
var can_collide := true

# The meteor's mask is set to 1 and 4 meaning that it can collide with anything
# on layers 1 and 4, or Player and Laser.

func _ready():
	var rng := RandomNumberGenerator.new()
	var random_1_to_3 = rng.randi_range(1, 3)
	var random_11_to_13 = rng.randi_range(11, 13)
	var random_number = random_1_to_3 if rng.randi_range(1,2) == 1 else random_11_to_13

	var path: String = "res://SpaceShooterRedux/PNG/Meteors/meteor" + str(random_number) + ".png"
	$Sprite2D.texture = load(path)

	# start position
	var width = get_viewport_rect().size.x
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)

	position = Vector2(random_x, random_y)

	# speed / rotation / direction
	speed = rng.randi_range(200, 500)
	direction_x = rng.randf_range(-1, 1)
	# Could multiply by some non-linear sequence to make it the speed scale with
	# the speed. Probably exponential or something.
	rotation_speed = rng.randi_range(40, 100)


func _process(delta):
	# add movement to the meteors
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta


func _on_body_entered(_body):
	if can_collide:
		collision.emit()


func _on_area_entered(area):
	# Get rid of the laser
	area.queue_free()
	$ExplosionSound.play()
	$Sprite2D.hide()
	can_collide = false
	await get_tree().create_timer(1).timeout
	# And get rid of the meteor
	queue_free()

