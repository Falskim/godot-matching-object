extends Label

export (int) var y_position
export (int) var total_keyword
export (bool) var debug = true

var current_keyword
# Possible Keyword
# Shape
# List available keyword
var possible_keyword = [
"circle",
"cloud",
"diamond",
"pentagon",
"triangle",
"star"
]
# List keyword that will used
var keyword = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	create_keyword()
	next_keyword()
	place_to_center()
	
func create_keyword():
	# An array for checking keyword already used or not, [name][is_used]
	var temp_keyword = []
	for i in possible_keyword.size():
		temp_keyword.append([])
		temp_keyword[i].append(possible_keyword[i])
		temp_keyword[i].append(false) #is_used
		
	total_keyword = 3
	# Avoiding if inputed total keyword exceeding total avaiable keyword
	if total_keyword > possible_keyword.size():
		total_keyword = possible_keyword.size()
	for i in total_keyword:
		var rand = floor(rand_range(0, possible_keyword.size()))
		while temp_keyword[rand][1]:
			rand = floor(rand_range(0, possible_keyword.size()))
		keyword.append(possible_keyword[rand])
		temp_keyword[rand][1] = true
		
	# Debug
	if debug:
		var unused_keyword = []
		for i in possible_keyword.size():
			if !temp_keyword[i][1]:
				unused_keyword.append(temp_keyword[i][0])
		print("Total keyword [used/available] : " 
		+ "[" + str(total_keyword) + "/" 
		+ str(possible_keyword.size()) + "]")
		print("Used Keyword : ")
		print(keyword)
		print("Unused Keyword : ")
		print(unused_keyword)

func next_keyword():
	if current_keyword == null:
		current_keyword = keyword[0]
	else:
		for i in keyword:
			if keyword[i] == current_keyword:
				current_keyword = keyword[i+1]
				break
	set_text(current_keyword)

func place_to_center():
	var x_position = get_viewport_rect().size.x/2 - get_rect().size.x/2
	rect_position = Vector2(x_position, y_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
