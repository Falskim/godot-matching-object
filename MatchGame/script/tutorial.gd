extends Node2D

signal end_tutorial

func _on_play_button_pressed():
	emit_signal("end_tutorial")
