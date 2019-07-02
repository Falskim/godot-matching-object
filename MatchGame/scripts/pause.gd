extends CanvasLayer

export (String) var menu_path
signal restart_game

func _on_continue_pause_pressed():
	$AnimationPlayer.play("slide_out_left")
	get_tree().paused = false

func _on_pause_button_pressed():
	$AnimationPlayer.play("slide_in_right")
	get_tree().paused = true

func _on_quit_menu_pressed():
	get_tree().change_scene(menu_path)
