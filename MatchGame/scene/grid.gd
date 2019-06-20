extends Node2D

export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

# Debug and developing status
export (bool) var debug = true

# Load all shape 
var tiles_resources = []

# All tiles on the grid
var all_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	prepare_tiles_resources()
	all_tiles = create_tiles()
	spawn_tile()

func prepare_tiles_resources():
	var path = get_parent().get_resource_path()
	var resource = []
	for i in path.size():
		resource.append([])
		resource[i] = load(path[i])
	tiles_resources = resource
	
func create_tiles():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func spawn_tile():
	var total_object = tiles_resources.size()
	var object = []
	for i in total_object:
		object.append([])
		object[i] = 0
	var threshold = (width*height)/total_object
	
	for i in width:
		for j in height:
			var loop_counter = 0
			var rand = floor(rand_range(0, tiles_resources.size()))
			while object[rand] > threshold and loop_counter < 10:
				rand = floor(rand_range(0, tiles_resources.size()))
				loop_counter += 1
			object[rand] += 1
			var tile = tiles_resources[rand].instance()
			add_child(tile)
			tile.position = grid_to_pixel(i, j)
			all_tiles[i][j] = tile
	print("Distribution")
	print(object)

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
	if Input.is_action_just_pressed("ui_touch"):
		var curr_position = pixel_to_grid(get_global_mouse_position())
		print("Clicked !")
				
		if is_in_grid(curr_position) and !is_already_clicked(curr_position):
			check_tile(curr_position)
			# Debug
			if debug:
				print(curr_position)
				
func check_tile(input_position):
	var chosen_keyword = all_tiles[input_position.x][input_position.y].names
	if is_keyword_same(chosen_keyword):
		destroy_tile(input_position)

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

func update_score():
	var label = get_parent().get_parent().get_node("score_label")
	# Getting current score number
	var current_score = label.get_text().substr(8, len(label.get_text()))
	label.score += 100
	label.update()
	print(current_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_register()
