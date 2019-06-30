extends Node2D

export (String) var names
var color

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

func set_sprite(texture):
	$Sprite.set_texture(load(texture))
	
func get_name():
	return names