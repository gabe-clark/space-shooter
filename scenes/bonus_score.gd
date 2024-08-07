extends Area2D

signal collision

var speed: int
var rotation_speed: int
var direction_x: float
var can_collide := true

func _ready():
	var rng := RandomNumberGenerator.new()
	# start position
	var width = get_viewport_rect().size.x
	var random_x = rng.randi_range(width/4, 3*width/4)
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
		$BonusScoreSound.play()
		$Sprite2D.hide()
		can_collide = false
		await get_tree().create_timer(1).timeout
		queue_free()
