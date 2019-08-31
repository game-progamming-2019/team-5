extends Panel

signal _playPressed
signal _levelselectPressed

func playPressed():
	emit_signal("_playPressed")

func levelselectPressed():
	emit_signal("_levelselectPressed")

func clickedClose():
	get_tree().quit()

func _ready():
	connect("_playPressed", $"..", "pressedPlay")
	connect("_levelselectPressed", $"..", "pressedLevelSelect")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
