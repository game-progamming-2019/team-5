extends Button

func _ready():
	connect("pressed", $"..", "clickedUnpause")