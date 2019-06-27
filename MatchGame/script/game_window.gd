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

# Game Variabel
export (int) var total_keyword = 10
export (int) var key_timer = 5

# Type game that will used
var game_type = "shape"

func _ready():
	#play_music()
	get_resource()
	if !$tutorial.is_visible():
		start_game()

func get_resource():
	var texture = get_texture_resource()
	var res = []
	for i in keywords.size():
		res.append([])
		res[i].append(keywords[i])
		res[i].append(texture[i])
	return res

func get_texture_resource():
	var texture = []
	for i in keywords.size():
		texture.append([])
		var key = str(keywords[i]).replace(" ", "_").to_lower()
		texture[i] = "res://MatchGame/images/" + game_type + "/" + key + ".png"
	return texture

func play_music():
	$bgm.play()

func start_game():
	$grid.allow_input = true
	$keyword/keyword_timer.start()
	$tutorial.queue_free()

func _on_tutorial_end_tutorial():
	start_game()