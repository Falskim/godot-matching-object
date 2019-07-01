extends "res://Menu/scripts/base_panel.gd"

signal to_level_select

func _on_play_button_pressed():
	slide_out()
	get_tree().change_scene("res://Menu/scenes/menu_controller.tscn")

func _on_level_select_button_pressed():
	emit_signal("to_level_select")

func _on_sound_button_pressed():
	pass # Replace with function body.
