extends Node2D

# Grid variabel
export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset
export (bool) var debug = true

# Load all resource
onready var root = get_parent().get_parent()
onready var explosion_effect = load("res://MatchGame/scenes/explosion_effect.tscn")
onready var tile_path = load("res://MatchGame/scenes/tile.tscn")
onready var keyword_sprite_resources = root.get_resource()


# All tiles on the grid
onready var is_grid_ready = false
onready var all_tiles

# Signal
signal wrong_keyword
signal correct_keyword

# Game status condition
onready var allow_input = false
onready var game_end = false
var input_position

func prepare_tiles_grid():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	all_tiles = array
	is_grid_ready = true

func _set_tile_detail(i, j, value):
	# Keyword names
	all_tiles[i][j].names = keyword_sprite_resources[value][0]
	# Sprite Texture
	all_tiles[i][j].set_sprite(keyword_sprite_resources[value][1])
	# Position
	all_tiles[i][j].position = grid_to_pixel(i, j)
	# Color
	all_tiles[i][j].randomize_color()
	
func generate_tiles():
	randomize()
	var tile
	var total_object = keyword_sprite_resources.size()
	var object_amount = []
	for i in total_object:
		object_amount.append([])
		object_amount[i] = 0
	var threshold = (width*height)/total_object
	
	for i in width:
		for j in height:
			var loop_counter = 0
			var rand = floor(rand_range(0, keyword_sprite_resources.size()))
			if all_tiles[i][j] == null:
				tile = tile_path.instance()
				add_child(tile)
				all_tiles[i][j] = tile
			else:
				tile = all_tiles[i][j]
			_set_tile_detail(i, j, rand)
			while (object_amount[rand] > threshold or has_name_adjacent(tile.names, i, j)) and loop_counter < 100:
				rand = floor(rand_range(0, keyword_sprite_resources.size()))
				_set_tile_detail(i, j, rand)
				loop_counter += 1
			object_amount[rand] += 1
			while has_color_adjacent(i, j):
				tile.randomize_color()
	# Checking if certain object doesn't appear
	var total = 0
	for i in keyword_sprite_resources.size():
		if object_amount[i] < threshold*2/3:
			var x = floor(rand_range(0, width))
			var y = floor(rand_range(0, height))
			_set_tile_detail(x, y, i)
			object_amount[i] += 1
		total += object_amount[i]
	print("Tile Object Distribution : ")
	print(object_amount)
	print(total)

func has_name_adjacent(name, i, j):
	if i > 0:
		if all_tiles[i-1][j] != null && all_tiles[i-1][j].names == name:
			return true
	if j > 0:
		if all_tiles[i][j-1] != null && all_tiles[i][j-1].names == name:
			return true
	return false	

func has_color_adjacent(i, j):
	var tile = all_tiles[i][j]
	if i > 0:
		if all_tiles[i-1][j] != null && all_tiles[i-1][j].color == tile.color:
			return true
	if j > 0:
		if all_tiles[i][j-1] != null && all_tiles[i][j-1].color == tile.color:
			return true
	return false

func grid_to_pixel(column, row):
	var new_x = x_start + (offset * column)
	var new_y = y_start + (-offset * row)
	return Vector2(new_x, new_y)

func pixel_to_grid(input_position):
	var x = input_position.x
	var y = input_position.y
	var column = round((x - x_start) / offset)
	var row = round((y - y_start) / -offset)
	
	# Avoiding rounding to negative for zero
	if column == -0:
		column = 0
	if row == -0:
		row = 0
	return Vector2(column, row)

func input_register():
	if Input.is_action_just_pressed("ui_touch"):
		input_position = pixel_to_grid(get_global_mouse_position())
		if is_in_grid():
			check_tile()
			# Debug
			if debug:
				print(input_position)

func is_in_grid():
	var column = input_position.x
	var row = input_position.y
	if column < 0 or column >= width or row < 0 or row >= height:
		return false
	return true

func check_tile():
	var choosen_keyword = all_tiles[input_position.x][input_position.y].names
	if is_keyword_same(choosen_keyword):
		correct_answer()
	else:
		wrong_answer()

func is_keyword_same(chosen_keyword):
	var label_keyword = get_parent().get_node("keyword").get_keyword()
	var result = chosen_keyword == label_keyword
	# Debug
	if debug:
		print("Chosen keyword : " + chosen_keyword)
		print("Label keyword : " + label_keyword)
		print("Result : " + str(result))
	return result
	
func correct_answer():
	play_sound_effect("correct_sound")
	start_effect(explosion_effect, input_position)
	change_tile(input_position)
	emit_signal("correct_keyword")

func wrong_answer():
	play_sound_effect("wrong_sound")
	emit_signal("wrong_keyword")
	allow_input = false

func play_sound_effect(effect):
	get_parent().get_node(effect).play()

func change_tile(_position):
	var rand = floor(rand_range(0, keyword_sprite_resources.size()))
	_set_tile_detail(_position.x, _position.y, rand)

func start_effect(effect, _position):
	var fx = effect.instance()
	add_child(fx)
	fx.position = grid_to_pixel(_position.x, _position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if allow_input and !game_end:
		input_register()

func _on_wrong_timer_timeout():
	allow_input = true

func _on_keyword_timer_game_end():
	allow_input = false
	game_end = true
	print("input disabled")
