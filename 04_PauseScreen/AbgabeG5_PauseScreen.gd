extends Panel

signal calledReset

func on_pause():
	visible = !visible
	rect_position=$"../Player".position+Vector2(-150,-20)
	get_tree().paused = true

func clickedUnpause():
	get_tree().paused = false
	visible = !visible

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
		clickedUnpause()
	
	if Input.is_action_just_pressed("ui_home"):
		clickedMainMenu()
	
	if Input.is_action_just_pressed("ui_accept"):
		clickedReset()
	
	

func _ready():
	connect("calledReset", $"..", "calledReset")
	
func _process(delta):
	if get_tree().paused == true:
		get_input()