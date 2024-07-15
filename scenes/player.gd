extends CharacterBody2D

signal laser(pos)

# Export exposes this variable in the Inspector (SUPER CONVENIENT!)
@export var speed: int = 500 # set speed to int
# @export var speed := 500 # set speed to int without having to be explicit
var can_shoot: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$LaserTimer.start()
	position = Vector2(100, 500)
	$PlayerImage.texture = PlayerVariables.ship_texture
	$Particles.process_material.color = PlayerVariables.particles_hex_code

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	# shoot input
	# The difference between is_action_just_pressed and is_action_pressed is is_action_just_pressed
	# only triggers once even if the action is held down.
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPosition.global_position)
		can_shoot = false
		$LaserTimer.start()
		$LaserSound.play()


func _on_laser_timer_timeout():
	can_shoot = true

func play_collision_sound():
	$DamageSound.play()
