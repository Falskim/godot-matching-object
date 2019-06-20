extends Timer

var keyword
var label
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node("time_remaining")
	keyword = get_parent()

func update_label():
	time = str(time_left).substr(0, 4)
	label.set_text(time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_label()

func _on_keyword_timer_timeout():
	if keyword.has_next_keyword():
		keyword.next_keyword()
	else:
		stop()
		set_process(false)
