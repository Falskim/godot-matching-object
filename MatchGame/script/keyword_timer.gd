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

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = get_parent().get_parent().keyword_time
	start()
	label = get_node("time_remaining")
	keyword = get_parent()
	prepare_countdown_timer()

func update_label():
	time = int(str(time_left).substr(0, 1))
	label.set_text(str(time + 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_label()
	if time == 3 and !countdown_played:
		countdown_timer.start()
		countdown_played = true

func prepare_countdown_timer():
	countdown_timer = Timer.new()
	add_child(countdown_timer)
	countdown_timer.connect("timeout", self, "_on_Timer_countdown")
	countdown_timer.set_wait_time(1.0)
	countdown_timer.set_one_shot(false)

func _on_keyword_timer_timeout():
	$countdown_end_sound.play()
	if keyword.has_next_keyword():
		keyword.next_keyword()
		start()
	else:
		stop()
		label.set_text("0")
		set_process(false)
		emit_signal("game_end")
		queue_free()

func _on_Timer_countdown():
	$countdown_sound.play()
	countdown_counter += 1
	if countdown_counter == 3:
		countdown_timer.stop()
		countdown_counter = 0
		countdown_played = false
