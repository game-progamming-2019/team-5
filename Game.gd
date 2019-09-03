extends Node2D

export var level = 1
export var level_total = 4

var next_level
var main_menu_pressed = false
var coming_from_next_level = false

signal _paused
signal _lvlCompleted

#####################################################
func pressedPlay():
	get_tree().paused = true
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	remove_child($"MainMenuScreen")
	
	level = 1
	
	changeLevel(level)
	
	get_tree().paused = false
	
	main_menu_pressed = false
#####################################################
func pressedLevelSelect():
	remove_child($"MainMenuScreen")
	
	var level_select_Screen = load("res://08_LevelSelectScreen/LevelSelectScreen.tscn").instance()
	add_child(level_select_Screen)
	
	main_menu_pressed = false
#####################################################
func lvlCompleted():
	emit_signal("_lvlCompleted")
#####################################################
func nextLevel():
	coming_from_next_level = true
	
	$"Player".resetAttributes()
	changeLevel(level+1)
	
	coming_from_next_level = false
#####################################################
func calledMainMenu():
	var camera = Camera.new()
	add_child(camera)
	camera.name = "Camera"
	camera.current = true
	
	remove_child($"Player")
	remove_child($"Map")
	
	var mainmenu = load("res://06_MainMenuScreen/MainMenu.tscn").instance()
	add_child(mainmenu)
	
	get_tree().paused = false
	
	main_menu_pressed = true
#####################################################
func calledReset():
	$"Player".resetAttributes()
	$"DeathScreen".visible = false
	$"PauseScreen".visible = false
	$"EOLScreen".visible = false
	$"EOLScreen/AllLevelsCompleted".visible = false
#####################################################
func lvl1Selected():
	get_tree().paused = true
	remove_child($"LevelSelectScreen")
	
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	changeLevel(1)
	get_tree().paused = false

func lvl2Selected():
	get_tree().paused = true
	remove_child($"LevelSelectScreen")
	
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	changeLevel(2)
	get_tree().paused = false

func lvl3Selected():
	get_tree().paused = true
	remove_child($"LevelSelectScreen")
	
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	changeLevel(3)
	get_tree().paused = false

func lvl4Selected():
	get_tree().paused = true
	remove_child($"LevelSelectScreen")
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	changeLevel(4)
	get_tree().paused = false
#####################################################
func spawnPlayer():
	var player = load("res://02_Player/Player.tscn").instance()
	add_child(player)
#####################################################
func changeLevel(var _level):
	if _level <= level_total:
		level = _level
		loadLevel(_level)
#####################################################
func loadLevel(var _level):
	if(next_level != null):
		remove_child(next_level)
	
	var next_level_res = load("res://01_Map" + str(_level) + "/Map.tscn")
	next_level = next_level_res.instance()
	add_child(next_level)
	
	if(coming_from_next_level == false):
		spawnPlayer()
	
	if(main_menu_pressed == false):
		$"Player".resetAttributes()
#####################################################
func fetusDeletus():
	remove_child($Camera)
#####################################################
func get_input():
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("_paused")
#####################################################
func _ready():
	var mainmenu = load("res://06_MainMenuScreen/MainMenu.tscn").instance()
	add_child(mainmenu)
	
	main_menu_pressed = true
	
	remove_child($"Camera")
	var camera = load("res://09_Camera2/Camera.tscn").instance()
	add_child(camera)
	
	connect("_paused", $"PauseScreen", "on_pause")
	connect("_lvlCompleted", $"EOLScreen", "lvlCompleted")

func _process(delta):
	if(next_level != null):
		get_input()
