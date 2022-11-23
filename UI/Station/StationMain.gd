extends CanvasLayer

onready var background = $ColorRect
onready var window = $MarginContainer
onready var tween = $Tween
var is_open = false


func initialize(station):
	$MarginContainer/HBoxContainer/NinePatchRect/LabelTitle.text = station.station_name
	$MarginContainer/HBoxContainer/NinePatchRect/LeftTabContainer.initialize(station)

func _ready():
	window.hide()
	open()
	

func open():
	is_open = true
	tween.interpolate_property(background.get_material(), "shader_param/circle_size", 
	1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func close():
	is_open = false
	get_parent().station_open = false
	tween.interpolate_property(background.get_material(), "shader_param/circle_size", 
	0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func _on_ButtonQuit_pressed():
	window.hide()
	close()


func _on_Tween_tween_completed(_object, _key):
	if is_open:
		window.show()
	else:
		queue_free()
