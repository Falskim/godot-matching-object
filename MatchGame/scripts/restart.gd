extends CanvasLayer

signal restart_game

func _on_no_pressed():
	$AnimationPlayer.play("slide_out_right")
	get_tree().paused = false

func _on_yes_pressed():
	$AnimationPlayer.play("slide_out_right")
	get_tree().paused = false
	emit_signal("restart_game")

func _on_restart_button_pressed():
	$AnimationPlayer.play("slide_in_right")
	get_tree().paused = true
