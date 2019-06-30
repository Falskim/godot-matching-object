extends "res://Menu/scripts/panel_base.gd"

signal back_level_select

func _on_back_button_pressed():
	emit_signal("back_level_select")
