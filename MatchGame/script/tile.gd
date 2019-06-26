extends Node2D

export (String) var names

var color

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_color()

func randomize_color():
	randomize()
	var r = round(rand_range(0, 1))
	var g = round(rand_range(0, 1))
	var b = round(rand_range(0, 1))
	while (r == 0 and g == 0 and b == 0) or (r == 1 and g == 1 and b == 1):
		r = round(rand_range(0, 1))
		g = round(rand_range(0, 1))
		b = round(rand_range(0, 1))
	color = Color(r, g, b)
	$Sprite.modulate = color
#	var rand = floor(rand_range(0, possible_modulate_color.size()))
#	$Sprite.modulate = Color(
#	possible_modulate_color[rand][0],
#	possible_modulate_color[rand][1],
#	possible_modulate_color[rand][2]
#	)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
