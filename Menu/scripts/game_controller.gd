extends Node2D

func _on_splash_panel_end_splash():
	$splash_panel.slide_out()
	$level_select_panel.slide_in()

func _on_level_select_panel_back_level_select():
	$splash_panel.slide_in()
	$level_select_panel.slide_out()
