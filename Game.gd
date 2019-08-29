extends Node2D

export var level = 0
export var level_total = 0

var player
var next_level

signal _paused
signal _lvlCompleted

#####################################################
#####################################################
func lvlCompleted():
	emit_signal("_lvlCompleted")
#####################################################
func nextLevel():
	changeLevel(level+1)
#####################################################
func calledReset():
	$"Player".resetAttributes()
	$"Deathscreen".visible = false
	$"Pausescreen".visible = false
	$"EOLscreen".visible = false
	$"EOLscreen/AllLevelsCompleted".visible = false
#####################################################
func changeLevel(var _level):
	if _level <= level_total:
		level = _level
		loadLevel(_level)
#####################################################
func loadLevel(var _level):
	if(next_level != null):
		remove_child(next_level)
		$Player.resetAttributes()
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
	if(level != 0):
		changeLevel(level)
		var player_res = load("res://02_Player/Player.tscn")
		player = player_res.instance()
		add_child(player)
	
	
	
	connect("_paused", $"Pausescreen", "on_pause")
	connect("_lvlCompleted", $"EOLscreen", "lvlCompleted")

func _process(delta):
	get_input()
