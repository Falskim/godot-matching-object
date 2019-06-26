extends Node2D

# List of shapes, will used as keyword
# resource scene naming MUST BE SAME as keyword below
# but replace space/blank/" " to an underscroll "_"
# Example :
# Keyword -> equilateral triangle
# Scene naming -> equilateral_triangle OR preload("res://MatchGame/scene/tile/equilateral_triangle.tscn"),

var keyword = [
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

export (int) var total_keyword
export (int) var keyword_time

# Type game that will used
var game_type = "shape"

func _ready():
	get_resource_path()
	play_music()

func get_resource_path():
	var res = []
	for i in keyword.size():
		res.append([])
		var key = str(keyword[i]).replace(" ", "_")
		res[i] = "res://MatchGame/scene/" + game_type + "/" + key + ".tscn"
	return res

func get_keyword():
	return keyword

func play_music():
	get_parent().get_node("bgm").play()
