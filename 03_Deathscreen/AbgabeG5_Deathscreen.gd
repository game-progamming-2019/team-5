extends Panel
func gameover_panel():
	visible=!visible

func clickedyes():
	$"../Player/".resetAttributes()
	visible = !visible
	get_tree().paused = false
	
func clickedno():
	get_tree().quit()
	
func _ready():
	pass
	
func _process(delta):
	rect_position=$"../Player".position+Vector2(-150,-20)