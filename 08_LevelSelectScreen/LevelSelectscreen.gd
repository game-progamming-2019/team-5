extends Panel

signal _lvl1
signal _lvl2
signal _lvl3
signal _lvl4

func lvl1Selected():
	emit_signal("_lvl1")

func lvl2Selected():
	emit_signal("_lvl2")

func lvl3Selected():
	emit_signal("_lvl3")

func lvl4Selected():
	emit_signal("_lvl4")

func _ready():
	connect("_lvl1", $"..", "lvl1Selected")
	connect("_lvl2", $"..", "lvl2Selected")
	connect("_lvl3", $"..", "lvl3Selected")
	connect("_lvl4", $"..", "lvl4Selected")