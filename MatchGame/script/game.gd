extends Node2D

# Game Variabel
export (int) var total_keyword = 10
export (int) var key_timer = 5

# Type game that will used
export (String)var game_type = "shape"

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

func _ready():
	play_music()
	get_resource()
	if !$tutorial.is_visible():
		if $start_game.is_visible(): 
			start_game_countdown()

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

func stop_music():
	$bgm.stop()

func start_game():
	$game/grid.allow_input = true
	$game/keyword/keyword_timer.start()
	$game/keyword.next_keyword()

func start_game_countdown():
	$start_timer/time/countdown.start_countdown()

func _on_tutorial_end_tutorial():
	start_game_countdown()
	$tutorial.queue_free()

func _on_start_timer_end_start_timer():
	start_game()
	$start_timer.visible = false
	