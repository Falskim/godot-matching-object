extends Node2D

signal start_timer

func start_game():
	randomize()
	$keyword.prepare_keyword()
	$keyword.next_keyword()
	$keyword/keyword_timer.start()
	$grid.allow_input = true
	# For avoiding overlapped at restart
	if !$grid.is_grid_ready:
		$grid.prepare_tiles_grid()
	$grid.generate_tiles()

func _on_restart_restart_game():
	$countdown.stop()
	$keyword/keyword_timer.stop()
	$keyword/keyword_timer/time_remaining.set_text("")
	$keyword/keyword_timer.countdown_played = false
	$grid.game_end = false
	emit_signal("start_timer")