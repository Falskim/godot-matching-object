extends Node2D

signal end_tutorial

func _on_play_button_pressed():
	$slide_out.play("slide_out_down")

func _on_slide_out_animation_finished(anim_name):
	emit_signal("end_tutorial")
