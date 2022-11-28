extends Sprite


func _ready():
	if OS.has_feature("standalone"):
		queue_free()

