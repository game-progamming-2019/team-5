extends TextureButton

func _ready():
	connect("pressed", $"..", "lvl2Selected")