extends Node2D

onready var settings = $settings_panel
onready var level_select = $level_select_panel

func _ready():
	level_select.slide_in()
	settings.slide_out()

func _on_level_select_panel_back_to_splash():
	get_tree().change_scene("res://Menu/scenes/splash_panel.tscn")

func _on_settings_panel_to_level_select():
	level_select.slide_in()
	settings.slide_out()	

func _on_level_select_panel_to_settings():
	level_select.slide_out()
	settings.slide_in()