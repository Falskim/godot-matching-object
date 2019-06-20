extends Label

export (int) var score

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

func update():
	set_text("Score : " + str(score))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
