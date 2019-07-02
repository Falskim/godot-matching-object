extends Node

var debug_mode = true
var minimum_star = 1
var level_info = {}

onready var save_path = "user://save.dat"

func _ready():
	load_data()

func save_data(level, score = 0, star = 0):
	var requirement_met = star >= minimum_star
	if requirement_met:
		unlock_next_level(level)
	level_info[level] = {
			"unlocked" : true,
			"high_score" : score,
			"stars_unlocked" : star
		}
	_save_data()

func unlock_next_level(level):
	var next_level = str(int(level) + 1)
	level_info[next_level] = {
		"unlocked" : true,
		"high_score" : 0,
		"stars_unlocked" : 0
	}

func _save_data():
	var data = level_info
	var file = File.new()
	var err = file.open(save_path, File.WRITE)
	if err != OK:
		print ("Saving data file error")
		return
	file.store_line(to_json(data))
	file.close()
	if debug_mode:
		print("Saving Data : ")
		print(data)

func load_data():
	level_info = _load_data()

func _load_data():
	var default_level_info = {
	"1":{
		"unlocked" : true,
		"high_score" : 0,
		"stars_unlocked" : 0
		}
	}
	var file = File.new()
	var err = file.open(save_path, File.READ)
	if err != OK:
		print("Load data file error, returning default values")
		return default_level_info
	var json = file.get_as_text()
	file.close()
	var data = parse_json(json)
	if debug_mode:
		print("Load json : ")
		print("> JSON : " + json)
		print("> Parsed json : " + str(data))
	return data

func reset_data():
	var dir = Directory.new()
	dir.remove(save_path)
	load_data()