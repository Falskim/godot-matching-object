extends Timer

var label

var message = [
"Success",
"Yes",
"Well Done",
"Nice",
"Correct"
]

func _ready():
	label = get_node("correct_message")
	label.hide()

func _on_correct_timer_timeout():
	label.hide()

func _on_grid_correct_keyword():
	start()
	var rand = floor(rand_range(0, message.size()))
	label.set_text(message[rand])
	label.show()
