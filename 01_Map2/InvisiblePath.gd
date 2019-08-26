extends TileMap

var tween

var modulate1 = Color(1.0,1.0,1.0,0)
var modulate2 = Color(1.0,1.0,1.0,1.0)

func changeVisibility():
	print("InvisiblePath")
	#modulate = Color(1,1,1,1)
	_start_Tween()

func _start_Tween():
	tween.interpolate_property(self, "modulate", modulate1, modulate2, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _ready():
	tween = Tween.new()
	add_child(tween)