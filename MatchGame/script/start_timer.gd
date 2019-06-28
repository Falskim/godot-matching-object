extends Node2D

signal end_start_timer

func _on_countdown_countdown_end():
	emit_signal("end_start_timer")

func _on_start_timer_end_start_timer():
	print("End countdown")
