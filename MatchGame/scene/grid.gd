extends Node2D

export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

# Debug and developing status
export (bool) var debug = true

# Load all shape 
var possible_shape = [
preload("res://MatchGame/scene/tile/circle.tscn"),
preload("res://MatchGame/scene/tile/cloud.tscn"),
preload("res://MatchGame/scene/tile/diamond.tscn"),
preload("res://MatchGame/scene/tile/pentagon.tscn"),
preload("res://MatchGame/scene/tile/star.tscn"),
preload("res://MatchGame/scene/tile/triangle.tscn")
]

var all_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	all_tiles = create_tiles()
	spawn_tile()

func create_tiles():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func spawn_tile():
	for i in width:
		for j in height:
			var rand = floor(rand_range(0, possible_shape.size()))
			var tile = possible_shape[rand].instance()
			add_child(tile)
			tile.position = grid_to_pixel(i, j)
			all_tiles[i][j] = tile

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

func input_register():
	if Input.is_action_just_pressed("ui_touch"):
		var curr_position = pixel_to_grid(get_global_mouse_position())
		print("Clicked !")
				
		if is_in_grid(curr_position):
			check_tile(curr_position)
			# Debug
			if debug:
				print(curr_position)
				
func check_tile(input_position):
	var chosen_keyword = all_tiles[input_position.x][input_position.y].names
	is_keyword_same(chosen_keyword)

func is_keyword_same(chosen_keyword):
	var label_keyword = get_parent().get_node("keyword_label").get_text()# Debug
	var result = chosen_keyword == label_keyword
	# Debug
	if debug:
		print("Chosen keyword : " + chosen_keyword)
		print("Label keyword : " + label_keyword)
		print("Result : " + str(result))
	return result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_register()
