extends Timer

var counter
export (int) var counter_limit = 3

signal countdown_end

func start_countdown():
	counter = -1
	start()

func _on_countdown_timeout():
	$countdown_sound.play()
	counter += 1
	if counter == counter_limit:
		countdown_done()

func countdown_done():
	stop()
	$countdown_end_sound.play()
	emit_signal("countdown_end")
