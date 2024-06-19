extends Area2D

@export var speed = 500

func _process(delta):
	position.y -= speed * delta

func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(2.5, 2.5), 0.25).from(Vector2(0, 0))
