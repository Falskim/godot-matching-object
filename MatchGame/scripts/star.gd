extends CanvasLayer

var score
signal restart_game
signal back_menu

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
	get_tree().quit()
	emit_signal("back_menu")

# Bikin sesuai game
func _on_game_game_result(star, score):
	self.score = score
	print(star)
	if star == 1:
		one_star()
	elif star == 2:
		two_star()
	elif star == 3:
		three_star()
