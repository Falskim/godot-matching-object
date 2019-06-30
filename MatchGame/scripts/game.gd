extends Node2D

signal start_timer
signal game_result

func start_game():
	randomize()
	$keyword.prepare_keyword()
	$keyword.next_keyword()
	$keyword/keyword_timer.wait_time = get_parent().key_timer
	$keyword/keyword_timer.time_limit = get_parent().key_timer + 1
	$keyword/keyword_timer.start()
	$grid.allow_input = true
	$keyword/keyword_timer.countdown_played = false
	$grid.game_end = false
	# For avoiding overlapped at restart
	if !$grid.is_grid_ready:
		$grid.prepare_tiles_grid()
	$grid.generate_tiles()

func restart_game():
	randomize()
	$grid.allow_input = false
	$countdown.stop()
	$top_ui/score.reset_score()
	$keyword/keyword_timer.stop()
	$keyword/keyword_timer.countdown_played = true
	$keyword.current_keyword = null
	emit_signal("start_timer")
	
func _on_restart_restart_game():
	restart_game()	
	
func _on_keyword_timer_game_end():
	var score = $top_ui/score.get_score()
	var star
	if score <= 100:
		star = 1
	elif score > 100 and score <= 300:
		star = 2
	elif score > 300:
		star = 3
	emit_signal("game_result", star, score)

func _on_star_restart_game():
	restart_game()
