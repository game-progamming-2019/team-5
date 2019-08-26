extends Node2D

signal _lvlCompleted
signal _onInvisible

func lvlCompleted(body):
	emit_signal("_lvlCompleted")

func onInvisible():
	emit_signal("_onInvisible")


func _ready():
	connect("_lvlCompleted", $"..", "lvlCompleted")
	connect("_onInvisible", $"InvisiblePath", "changeVisibility")

#func _process(delta):
#	pass
