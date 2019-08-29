extends Panel

signal calledReset
signal nextLevel

func lvlCompleted():
	visible = !visible
	rect_position=$"../Player".position+Vector2(-150,-20)
	get_tree().paused = true

func clickedNextLevel():
	if $"..".level == $"..".level_total:
			$AllLevelsCompleted.visible = true
	else:
		get_tree().paused = false
		visible = !visible
		emit_signal("nextLevel")

func clickedClose():
	get_tree().quit()

func clickedMainMenu():
	visible = !visible

func clickedReset():
	visible = !visible
	get_tree().paused = false
	emit_signal("calledReset")

func get_input():
	if Input.is_action_just_pressed("ui_back"):
		clickedNextLevel()
	
	if Input.is_action_just_pressed("ui_home"):
		clickedMainMenu()
	
	if Input.is_action_just_pressed("ui_accept"):
		clickedReset()
	
	

func _ready():
	connect("calledReset", $"..", "calledReset")
	connect("nextLevel", $"..", "nextLevel")
	
func _process(delta):
	if get_tree().paused == true:
		get_input()