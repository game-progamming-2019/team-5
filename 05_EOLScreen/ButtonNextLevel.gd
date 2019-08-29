extends TextureButton

func _ready():
	connect("pressed", $"..", "clickedNextLevel")