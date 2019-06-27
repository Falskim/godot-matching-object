extends Label

export (int) var score = 0

func _on_grid_correct_keyword():
	score += 100
	set_text(str(score))
