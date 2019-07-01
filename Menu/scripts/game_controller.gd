extends Node2D

func _on_level_select_panel_back_to_splash():
	$level_select_panel.slide_out()
	get_tree().change_scene("res://Menu/scenes/splash_panel.tscn")
