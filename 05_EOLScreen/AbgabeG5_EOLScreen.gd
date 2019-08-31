extends Panel

signal calledReset
signal nextLevel
signal calledMainMenu

func lvlCompleted():
	visible = !visible
	rect_position=$"../Player/Camera".get_camera_screen_center() + Vector2(-150, -63)
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
	get_tree().paused = true
	visible = !visible
	emit_signal("calledMainMenu")

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
	connect("calledMainMenu", $"..", "calledMainMenu")
	
func _process(delta):
	if get_tree().paused == true:
		get_input()