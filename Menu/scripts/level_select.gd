extends "res://Menu/scripts/base_panel.gd"

signal back_level_select

func _on_back_button_pressed():
	emit_signal("back_level_select")
