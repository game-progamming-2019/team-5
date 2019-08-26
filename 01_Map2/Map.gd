extends Node2D

signal _lvlCompleted

func lvlCompleted(body):
	emit_signal("_lvlCompleted")

func _ready():
	connect("_lvlCompleted", $"..", "lvlCompleted")

#func _process(delta):
#	pass
