extends Label

export (int) var score = 0

func _on_grid_correct_keyword():
	score += 100
	update_score()

func reset_score():
	score = 0
	update_score()

func update_score():
	set_text(str(score))
	
func get_score():
	return score