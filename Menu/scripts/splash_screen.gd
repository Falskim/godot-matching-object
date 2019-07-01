extends "res://Menu/scripts/base_panel.gd"

func _ready():
	slide_in()

func _on_play_button_pressed():
	slide_out()
	get_tree().change_scene("res://Menu/scenes/menu_controller.tscn")
