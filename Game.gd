extends Node2D

export var level = 1
export var level_total = 2
#####################################################
#####################################################
func lvlCompleted():
	print("lvl-comp")
#####################################################
func changeLevel():
	if(level + 1) <= level_total:
		level += 1
#####################################################
func fetusDeletus():
	remove_child($Camera)
#####################################################
func _ready():
	var next_level_res = load("res://01_Map" + str(level) + "/Map.tscn")
	var next_level = next_level_res.instance()
	add_child(next_level)
	
	var player_res = load("res://02_Player/Player.tscn")
	var player = player_res.instance()
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
