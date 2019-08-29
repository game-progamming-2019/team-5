extends TextureButton

func _ready():
	connect("pressed", $"..", "clickedReset")
