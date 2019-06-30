extends "res://Menu/scripts/panel_base.gd"

signal end_splash

func _ready():
	slide_in()

func _on_play_button_pressed():
	emit_signal("end_splash")
