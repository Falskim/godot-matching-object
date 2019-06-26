extends Node2D

# List of shapes, will used as keyword
# resource scene naming MUST BE SAME as keyword below
# but replace space/blank/" " to an underscroll "_"
# Example :
# Keyword -> equilateral triangle
# Scene naming -> equilateral_triangle OR preload("res://MatchGame/scene/tile/equilateral_triangle.tscn"),

var keywords = [
"equilateral triangle",
"isosceles triangle",
"kite",
"right triangle",
"rhombus",
"scaleless triangle",
"ellipse",
"parallelogram",
"diamond",
"semi circle",
"crescent",
"star",
"heart",
#"triangle",
"trapezoid",
"octagon",
"heptagon",
"hexagon",
"pentagon",
"rectangle",
"square",
"circle"
]

export (int) var total_keyword = 10
export (int) var key_timer = 5

# Type game that will used
var game_type = "shape"

func _ready():
	get_resource_path()
	play_music()

func get_resource_path():
	var res = []
	for i in keywords.size():
		res.append([])
		var key = str(keywords[i]).replace(" ", "_")
		res[i] = "res://MatchGame/scene/" + game_type + "/" + key + ".tscn"
	return res

func play_music():
	$bgm.play()

func _on_play_button_pressed():
	$tutorial.queue_free()
