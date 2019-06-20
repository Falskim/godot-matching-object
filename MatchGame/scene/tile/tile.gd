extends Node2D

export (String) var names

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_color()
	pass # Replace with function body.

func randomize_color():
	randomize()
	var x = rand_range(0.4, 1)
	var y = rand_range(0.4, 1)
	var z = rand_range(0.4, 1)
	$Sprite.modulate = Color(x,y,z)	
#	var rand = floor(rand_range(0, possible_modulate_color.size()))
#	$Sprite.modulate = Color(
#	possible_modulate_color[rand][0],
#	possible_modulate_color[rand][1],
#	possible_modulate_color[rand][2]
#	)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
