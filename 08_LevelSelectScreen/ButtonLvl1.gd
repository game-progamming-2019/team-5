extends TextureButton

func _ready():
	connect("pressed", $"..", "lvl1Selected")