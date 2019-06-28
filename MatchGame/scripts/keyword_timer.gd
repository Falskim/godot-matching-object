extends Timer

# game node
onready var display = get_parent().get_parent().get_node("top_ui/time")
onready var keyword = get_parent()

# For countdown sound effect
var countdown_timer = null
var countdown_played = false
var countdown_counter = 0

# Variabel for calculating time
var time
var time_limit

# Signal to end the game if all of keywords already used
signal game_end
signal start_countdown

#var sprite = {
#	"0" : "$display.time_0",
#	"1" : "$display.time_1",
#	"2"	: "$display.time_2",
#	"3" : "$display.time_3",
#	"4"	: "$display.time_4",
#	"5" : "$display.time_5",
#}

func update_sprite():
	if time < time_limit:
		time_limit = time
		var type = int(floor(wait_time) - time) - 1
		if type == 0:
			display.set_texture(display.time_0)
		elif type == 1:
			display.set_texture(display.time_1)
		elif type == 2:
			display.set_texture(display.time_2)
		elif type == 3:
			display.set_texture(display.time_3)
		elif type == 4:
			display.set_texture(display.time_4)
		elif type == 5:
			display.set_texture(display.time_5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = floor(time_left)
	if !is_stopped():
		update_sprite()
	if time == 3 and !countdown_played:
		countdown_played = true
		start_countdown_effect()

func start_countdown_effect():
	get_parent().get_parent().get_node("countdown").start_countdown()

func _on_keyword_timer_timeout():
	display.set_texture(display.time_5)
	if keyword.has_next_keyword():
		keyword.next_keyword()
		time_limit = wait_time + 1
		start()
	else:
		stop()
		display.set_texture(display.time_5)
		emit_signal("game_end")

func _on_countdown_countdown_end():
	countdown_played = false
