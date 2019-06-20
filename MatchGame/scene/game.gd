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
"octagon"
]

func _ready():
	get_resource_path()
	pass

func get_resource_path():
	var res = []
	for i in keyword.size():
		res.append([])
		var key = str(keyword[i]).replace(" ", "_")
		res[i] = "res://MatchGame/scene/tile/" + key + ".tscn"
	return res

func get_keyword():
	return keyword
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
