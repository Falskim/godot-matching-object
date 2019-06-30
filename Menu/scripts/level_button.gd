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
	setup()
	
func setup():
	level_label.set_text(str(level))
	if enabled:
		button.set_normal_texture(open_texture)
	else:
		button.set_normal_texture(blocked_texture)
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
