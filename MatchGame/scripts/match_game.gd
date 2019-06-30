extends Node2D

# Game Variabel
export (int) var total_used_keyword = 10
export (int) var key_timer = 5

# Type game that will used
export (String) var game_type = "shape"
export (Array) var keywords = ["pentagon",
"rectangle",
"square",
"circle"
]

# Value for score requirement
export (int) var score_1_star = 100
export (int) var score_2_star = 200
export (int) var score_3_star = 300

func _ready():
	_on_ready()

func _on_ready():
	play_music()
	if !$tutorial.is_visible():
		if $start_timer.is_visible():
			start_game_countdown()
		else:
			start_game()

func set_keywords(available_keyword):
	keywords = available_keyword

func set_game_type(images_directory):
	game_type = images_directory

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
	$game/grid.resources = get_resource()
	$game.start_game()

func start_game_countdown():
	$start_timer/time.set_text("Ready")
	$start_timer/time.modulate = Color(1, 1, 1)
	$start_timer/time/countdown.start_countdown()

func _on_tutorial_end_tutorial():
	start_game_countdown()
	$tutorial.queue_free()

func _on_start_timer_end_start_timer():
	start_game()
	$start_timer.visible = false

func _on_game_start_timer():
	start_game_countdown()
	$start_timer.visible = true

func _on_game_game_end():
	var score = $game/top_ui/score.get_score()
	var star
	if score < score_1_star:
		star = 0
	elif score >= score_1_star and score < score_2_star:
		star = 1
	elif score >= score_2_star and score < score_3_star:
		star = 2
	elif score >= score_3_star:
		star = 3
	print("Result : " + str(score) + "( " + str(star) + ")")
	$game/star.game_result(star, score)
