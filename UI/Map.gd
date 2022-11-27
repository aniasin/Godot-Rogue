extends NinePatchRect

var tween
onready var original_pos_x = rect_position.x


func _ready():
	update_map()
	tween.interpolate_property(self, "rect_position:x", 
		original_pos_x, 1200, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func update_map():
	pass

