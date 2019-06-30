extends CanvasLayer

func _ready():
	set_offset(Vector2(0,0))

func slide_in():
	$animation.play(str("slide_in_" + randomize_direction()))

func slide_out():
	$animation.play(str("slide_out_" + randomize_direction()))

func randomize_direction():
	randomize()
	var direction
	var rand = floor(rand_range(0, 4))
	if rand == 0:
		direction = "left"
	elif rand == 1:
		direction = "right"
	elif rand == 2:
		direction = "up"
	elif rand == 3:
		direction = "down"
	return direction
