extends Node2D

export (int) var level
export (String) var level_to_load
export (bool) var enabled
export (int) var total_star

# Texture
export (Texture) var blocked_texture
export (Texture) var open_texture
export (Texture) var star_empty
export (Texture) var star_1
export (Texture) var star_2
export (Texture) var star_3

onready var level_label = $button/level_label
onready var button = $button
onready var star = $star

# Called when the node enters the scene tree for the first time.
func _ready():
	load_save_data()
	setup()
	
func load_save_data():
	if GameDataManager.level_info.has(level):
		enabled = GameDataManager.level_info[level]["unlocked"]
		total_star = GameDataManager.level_info[level]["stars_unlocked"]
	else:
		enabled = false
		total_star = 0
	
func setup():
	# Setting texture and label
	level_label.set_text(str(level))
	button.set_normal_texture(open_texture)
	button.set_disabled_texture(blocked_texture)
	
	# Setting button property allowed to click or not
	if enabled:
		button.disabled = false
	else:
		button.disabled = true

	# Setting star sprites
	if total_star == 0:
		star.set_texture(star_empty)
	elif total_star == 1:
		star.set_texture(star_1)
	elif total_star == 2:
		star.set_texture(star_2)
	elif total_star == 3:
		star.set_texture(star_3)

func _on_button_pressed():
	return get_tree().change_scene(level_to_load)
