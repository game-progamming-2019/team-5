extends Panel
func gameover_panel():
	visible=!visible
	rect_position=$"../Player".position+Vector2(-150,-20)

func clickedyes():
	$"../Player/".resetAttributes()
	visible = !visible
	get_tree().paused = false

func clickedno():
	get_tree().quit()

func get_input():
	if Input.is_action_just_released("ui_accept"):
		clickedyes()

func _ready():
	pass
	
func _process(delta):
	
	
	if get_tree().paused == true:
		get_input()