extends Label

onready var root = get_parent().get_parent()
export (bool) var debug = true

# List keyword queue that will used
var keywords

# Currently used keyword
var current_keyword

func prepare_keyword():
	randomize()
	var total_keyword = root.total_keyword
	var possible_keyword = root.keywords
	# An array for checking keyword already used or not, [name][is_used]
	var temp_keyword = []
	for i in possible_keyword.size():
		temp_keyword.append([])
		temp_keyword[i].append(possible_keyword[i])
		temp_keyword[i].append(false) #is_used

	# Avoiding if inputed total keyword exceeding total avaiable keyword
	if total_keyword > possible_keyword.size():
		total_keyword = possible_keyword.size()
	keywords = []
	for i in total_keyword:
		var rand = floor(rand_range(0, possible_keyword.size()))
		while temp_keyword[rand][1]:
			rand = floor(rand_range(0, possible_keyword.size()))
		keywords.append(possible_keyword[rand])
		temp_keyword[rand][1] = true

	# Debug
	if debug:
		var unkeywords = []
		for i in possible_keyword.size():
			if !temp_keyword[i][1]:
				unkeywords.append(temp_keyword[i][0])
		print("Total keyword [used/available] : "
		+ "[" + str(total_keyword) + "/"
		+ str(possible_keyword.size()) + "]")
		print("Used Keyword : ")
		print(keywords)
		print("Unused Keyword : ")
		print(unkeywords)

func next_keyword():
	if current_keyword == null:
		current_keyword = keywords[0]
	else:
		if has_next_keyword():
			current_keyword = keywords[_get_current_keyword_index() + 1]
	# Updating keyword
	_update_label()

func has_next_keyword():
	return _get_current_keyword_index() < keywords.size() - 1

func _update_label():
	var text_string = current_keyword
	set_text(str(text_string).to_upper())

func _get_current_keyword_index():
	for i in keywords.size():
		if keywords[i] == current_keyword:
			return i

func get_keyword():
	return current_keyword
