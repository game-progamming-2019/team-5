extends TextureButton

func _ready():
	connect("pressed", $"..", "lvl3Selected")