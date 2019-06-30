extends "res://MatchGame/scripts/match_game.gd"

export (String) var images_directory = "shape"
export (Array) var available_keywords = [
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

func _on_ready():
	.set_keywords(available_keywords)
	.set_game_type(images_directory)
	._on_ready()
	