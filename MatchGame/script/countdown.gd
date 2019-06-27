extends Timer

var counter
export (int) var counter_limit = 3

signal countdown_end
signal start_game

var countdown_type

func start_countdown():
	counter = -1
	start()

func _on_countdown_timeout():
	$countdown_sound.play()
	counter += 1
	if counter == counter_limit:
		countdown_done()
	if countdown_type == "game":
		update_timer()

func update_timer():
	var label = get_parent().get_node("start_game/time")
	label.set_text(str(counter_limit - counter)) 
	if counter == 0:
		label.modulate = Color(0, 0, 1)
	if counter == 1:
		label.modulate = Color(0, 1, 0)
	if counter == 2:
		label.modulate = Color(1, 0, 0)
	
func countdown_done():
	stop()
	$countdown_end_sound.play()
	if countdown_type == "game":
		emit_signal("start_game")
	elif countdown_type == "keyword":
		emit_signal("countdown_end")

func _on_keyword_timer_start_countdown():
	countdown_type = "keyword"
	start_countdown()

func start_game_countdown():
	countdown_type = "game"
	start_countdown()