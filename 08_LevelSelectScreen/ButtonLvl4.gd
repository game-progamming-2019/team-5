extends TextureButton

func _ready():
	connect("pressed", $"..", "lvl4Selected")