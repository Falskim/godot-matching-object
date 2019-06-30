extends CanvasLayer

var score
var menu_path = "res://Menu/scenes/game_controller.tscn"

signal restart_game

func zero_star():
	$AnimationPlayer.play("0 star")
	update_score()
	print("Animation 0")

func one_star():
	$AnimationPlayer.play("1 star")
	update_score()

func two_star():
	$AnimationPlayer.play("2 star")
	update_score()

func three_star():
	$AnimationPlayer.play("3 star")
	update_score()

func update_score():
	$TextureRect/score.set_text(str(score))

func _on_retry_pressed():
	# Restart game
	$TextureRect.rect_position = Vector2(690, 415)
	emit_signal("restart_game")

func _on_exit_pressed():
	return get_tree().change_scene(menu_path)

# Bikin sesuai game
func game_result(star, score):
	self.score = score
	if star == 0:
		zero_star()
	elif star == 1:
		one_star()
	elif star == 2:
		two_star()
	elif star == 3:
		three_star()
