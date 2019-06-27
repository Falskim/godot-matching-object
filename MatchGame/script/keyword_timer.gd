extends Timer

var keyword
var label
var time

# For countdown sound effect
var countdown_timer = null
var countdown_played = false
var countdown_counter = 0

# Signal to end the game if all of keywords already used
signal game_end
signal start_countdown

# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node("time_remaining")
	label.set_text("")
	wait_time = get_parent().get_parent().key_timer
	keyword = get_parent()

func update_label():
	time = int(str(time_left).substr(0, 1))
	label.set_text(str(time + 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_stopped():
		update_label()
	if time == 3 and !countdown_played:
		countdown_played = true
		emit_signal("start_countdown")

func _on_keyword_timer_timeout():
	if keyword.has_next_keyword():
		keyword.next_keyword()
		start()
	else:
		stop()
		label.set_text("0")
		set_process(false)
		emit_signal("game_end")
		queue_free()

func _on_countdown_countdown_end():
	countdown_played = false
