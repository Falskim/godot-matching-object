extends Node2D

# Grid variabel
export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

# Debug and developing status
export (bool) var debug = true

# Load all resource
var tiles_resources = []
var explosion_effect = load("res://MatchGame/scene/explosion_effect.tscn")

# All tiles on the grid
var all_tiles = []

# Signal if answer is wrong
signal wrong_keyword
var is_allow_input = true

# Signal if answer is correct
signal correct_keyword

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	prepare_tiles_resources()
	prepare_tiles_grid()
	spawn_tile()

func prepare_tiles_resources():
	var path = get_parent().get_resource_path()
	var resource = []
	for i in path.size():
		resource.append([])
		resource[i] = load(path[i])
	tiles_resources = resource
	
func prepare_tiles_grid():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	all_tiles = array

func spawn_tile():
	var tile 
	var total_object = tiles_resources.size()
	var object_amount = []
	for i in total_object:
		object_amount.append([])
		object_amount[i] = 0
	var threshold = (width*height)/total_object
	
	for i in width:
		for j in height:
			var loop_counter = 0
			var rand = floor(rand_range(0, tiles_resources.size()))
			tile = tiles_resources[rand].instance()
			while (object_amount[rand] > threshold or has_adjacent(tile.name, i, j)) and loop_counter < 100:
				rand = floor(rand_range(0, tiles_resources.size()))
				tile = tiles_resources[rand].instance()
				loop_counter += 1
			object_amount[rand] += 1
			tile = tiles_resources[rand].instance()
			add_child(tile)
			tile.position = grid_to_pixel(i, j)
			all_tiles[i][j] = tile
	# Checking if certain object doenst appear
	var total = 0
	for i in tiles_resources.size():
		if object_amount[i] < threshold*2/3:
			var x = floor(rand_range(0, width))
			var y = floor(rand_range(0, height))
			tile = tiles_resources[i].instance()
			remove_child(all_tiles[x][y])
			add_child(tile)
			tile.position = grid_to_pixel(x, y)
			all_tiles[x][y] = tile
			object_amount[i] += 1
		total += object_amount[i]
	print("Tile Object Distribution : ")
	print(object_amount)
	print(total)

func has_adjacent(name, i, j):
	if i > 0:
		if all_tiles[i-1][j] != null && all_tiles[i-1][j].names == name:
				return true
	if j > 0:
		if all_tiles[i][j-1] != null && all_tiles[i][j-1].names == name:
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

func is_in_grid(grid_position):
	var column = grid_position.x
	var row = grid_position.y
	if column < 0 or column >= width or row < 0 or row >= height:
		print("Out off bound !")
		return false
	return true

func is_already_clicked(grid_position):
	return all_tiles[grid_position.x][grid_position.y] == null
	
func input_register():
	if Input.is_action_just_pressed("ui_touch") and is_allow_input:
		var curr_position = pixel_to_grid(get_global_mouse_position())
		print("Clicked !")
		if is_in_grid(curr_position) and !is_already_clicked(curr_position):
			check_tile(curr_position)
			# Debug
			if debug:
				print(curr_position)

func check_tile(input_position):
	var choosen_keyword = all_tiles[input_position.x][input_position.y].names
	if is_keyword_same(choosen_keyword):
		get_parent().get_parent().get_node("correct_sound").play()
		destroy_tile(input_position)
		start_effect(explosion_effect, input_position.x, input_position.y)
		respawn_tile(input_position)
		emit_signal("correct_keyword")
	else:
		get_parent().get_parent().get_node("wrong_sound").play()
		emit_signal("wrong_keyword")
		is_allow_input = false

func is_keyword_same(chosen_keyword):
	var label_keyword = get_parent().get_node("keyword").get_keyword()
	var result = chosen_keyword == label_keyword
	# Debug
	if debug:
		print("Chosen keyword : " + chosen_keyword)
		print("Label keyword : " + label_keyword)
		print("Result : " + str(result))
	return result

func destroy_tile(tile_position):
	var tile = all_tiles[tile_position.x][tile_position.y]
	all_tiles[tile_position.x][tile_position.y] = null
	print(tile)
	update_score()
	remove_child(tile)

func start_effect(effect, column, row):
	var fx = effect.instance()
	add_child(fx)
	fx.position = grid_to_pixel(column, row)

func respawn_tile(tile_position):
	var rand = floor(rand_range(0, tiles_resources.size()))
	var tile = tiles_resources[rand].instance()
	add_child(tile)
	tile.position = grid_to_pixel(tile_position.x, tile_position.y)
	all_tiles[tile_position.x][tile_position.y] = tile

func update_score():
	var label = get_parent().get_parent().get_node("score")
	# Getting current score number
	var current_score = label.get_text().substr(8, len(label.get_text()))
	label.score += 100
	label.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_register()

func _on_wrong_timer_timeout():
	is_allow_input = true

func _on_keyword_timer_game_end():
	is_allow_input = false
