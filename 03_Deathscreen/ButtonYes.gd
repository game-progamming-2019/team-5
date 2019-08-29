extends TextureButton

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", $"..", "clickedyes")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
