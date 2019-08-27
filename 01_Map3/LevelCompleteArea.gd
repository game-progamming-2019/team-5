extends Area2D

func _ready():
	connect("body_entered", $"..", "lvlCompleted")

#func _process(delta):
#	pass
