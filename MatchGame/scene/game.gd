extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func prepare_game():
	$grid.allow_input = true
	$keyword.prepare_keyword()
	$keyword.next_keyword()
	$keyword/keyword_timer.start()
	$score.reset_score()
	
func start_game():
	randomize()
	$grid.prepare_tiles_grid()
	$grid.generate_tiles()
	prepare_game()

func restart_game():
	randomize()
	$grid.regenerate_tiles()
	$keyword/keyword_timer.countdown_played = false
	$countdown.stop()
	prepare_game()

func _on_restart_restart_game():
	restart_game()
