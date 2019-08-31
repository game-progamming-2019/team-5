extends Node2D

export var level = 1
export var level_total = 4

var next_level

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
	spawnPlayer()
	
	get_tree().paused = false
#####################################################
func pressedLevelSelect():
	remove_child($"MainMenuScreen")
	
	var level_select_screen = load("res://08_LevelSelectScreen/LevelSelectscreen.tscn").instance()
	add_child(level_select_screen)
#####################################################
func lvlCompleted():
	emit_signal("_lvlCompleted")
#####################################################
func nextLevel():
	changeLevel(level+1)
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
#####################################################
func calledReset():
	$"Player".resetAttributes()
	$"Deathscreen".visible = false
	$"Pausescreen".visible = false
	$"EOLscreen".visible = false
	$"EOLscreen/AllLevelsCompleted".visible = false
#####################################################
func lvl1Selected():
	get_tree().paused = true
	remove_child($"LevelSelectscreen")
	
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	spawnPlayer()
	changeLevel(1)
	get_tree().paused = false

func lvl2Selected():
	get_tree().paused = true
	remove_child($"LevelSelectscreen")
	
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	spawnPlayer()
	changeLevel(2)
	get_tree().paused = false

func lvl3Selected():
	get_tree().paused = true
	remove_child($"LevelSelectscreen")
	
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	spawnPlayer()
	changeLevel(3)
	get_tree().paused = false

func lvl4Selected():
	get_tree().paused = true
	remove_child($"LevelSelectscreen")
	remove_child($"Camera")
	
	var camera = load("res://09_Camera1/Camera.tscn").instance()
	add_child(camera)
	
	spawnPlayer()
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
	
	remove_child($"Camera")
	var camera = load("res://09_Camera2/Camera.tscn").instance()
	add_child(camera)
	
	connect("_paused", $"Pausescreen", "on_pause")
	connect("_lvlCompleted", $"EOLscreen", "lvlCompleted")

func _process(delta):
	if(next_level != null):
		get_input()
