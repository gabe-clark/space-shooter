extends CanvasLayer

static var image = load("res://SpaceShooterRedux/PNG/UI/playerLife1_red.png")


func set_health(amount):
	# Remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()

	# Create new children, amount is set by health
	for i in amount:
		var texture_rectangle = TextureRect.new()
		texture_rectangle.texture = image
		$MarginContainer2/HBoxContainer.add_child(texture_rectangle)
		texture_rectangle.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout():
	Global.score += 1
	$MarginContainer/Label.text = str(Global.score)
