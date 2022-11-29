extends CanvasLayer

var to_black = true


func activate():
	var tween_start = 1
	var tween_stop = 0
	if not to_black:
		tween_start = 0
		tween_stop = 1
		
	$Tween.interpolate_property($ColorRect.get_material(), "shader_param/circle_size", 
	tween_start, tween_stop, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()





func _on_Tween_tween_all_completed():
	if to_black:
		get_parent().travel()

