extends Timer

var keyword
var label
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = get_parent().get_parent().keyword_time
	start()
	label = get_node("time_remaining")
	keyword = get_parent()

func update_label():
	time = str(time_left).substr(0, 1)
	label.set_text(str(int(time) + 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_label()

func _on_keyword_timer_timeout():
	if keyword.has_next_keyword():
		keyword.next_keyword()
		start()
	else:
		stop()
		label.set_text("0")
		set_process(false)
