extends Timer

onready var keyword = get_parent()
var time

# Main game node
onready var root = get_parent().get_parent().get_parent()

# For countdown sound effect
var countdown_timer = null
var countdown_played = false
var countdown_counter = 0

# Signal to end the game if all of keywords already used
signal game_end
signal start_countdown

func update_label():
	time = int(str(time_left).substr(0, 1))
	$time_remaining.set_text(str(time + 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_stopped():
		update_label()
	if time == 3 and !countdown_played:
		countdown_played = true
		start_countdown_effect()

func start_countdown_effect():
	get_parent().get_parent().get_node("countdown").start_countdown()

func _on_keyword_timer_timeout():
	if keyword.has_next_keyword():
		keyword.next_keyword()
		start()
	else:
		stop()
		$time_remaining.set_text("0")
		emit_signal("game_end")

func _on_countdown_countdown_end():
	countdown_played = false
