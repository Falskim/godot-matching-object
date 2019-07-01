extends "res://Menu/scripts/base_panel.gd"

signal back_to_splash
signal to_settings

func _on_back_button_pressed():
	emit_signal("back_to_splash")

func _on_reset_button_pressed():
	GameDataManager.reset_data()
	emit_signal("back_to_splash")

func _on_settings_button_pressed():
	emit_signal("to_settings")
