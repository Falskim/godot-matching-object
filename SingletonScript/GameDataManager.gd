extends Node

var debug_mode = true
var level_info = {}
var default_level_info = {
	1:{
		"unlocked" : true,
		"high_score" : 0,
		"stars_unlocked" : 0
		}
	}

onready var path = "user://save.dat"

func _ready():
	load_data()

func save_data(level, unlocked = false, score = 0, star = 0):
	level_info[level] = {
			"unlocked" : unlocked,
			"high_score" : score,
			"stars_unlocked" : star
		}
	_save_data()

func _save_data():
	var file = File.new()
	var err = file.open(path, File.WRITE)
	if err != OK:
		print ("Saving data file error")
		return
	file.store_var(level_info)
	file.close()
	if debug_mode:
		print("Saving Data : ")
		print(level_info)

func load_data():
	level_info = _load_data()

func _load_data():
	var file = File.new()
	var err = file.open(path, File.READ)
	if err != OK:
		print("Load data file error, returning default values")
		return default_level_info
	var read = {}
	read = file.get_var()
	if debug_mode:
		print("Loading data :")
		print(read)
	return read

func reset_data():
	var file = File.new()
	var err = file.open(path, File.WRITE)
	if err != OK:
		print ("Reset data file error")
		return
	file.store_var(default_level_info)
	file.close()
	if debug_mode:
		print("Default reset data : ")
		print(default_level_info)

func unlock_next_level(level):
	save_data(level + 1, true)
