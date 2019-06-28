extends Timer

var label

var message = [
"Wrong",
"Incorrect",
"Try Again",
"Oops"
]

func _ready():
	label = get_node("wrong_message")
	label.hide()

func _on_grid_wrong_keyword():
	start()
	var rand = floor(rand_range(0, message.size()))
	label.set_text(message[rand])
	label.show()

func _on_wrong_timer_timeout():
	label.hide()
