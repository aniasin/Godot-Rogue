extends CanvasLayer

onready var background = $ColorRect
onready var window = $MarginContainer
onready var tween = $Tween

# Map subscribe to it in station_pop_up
signal station_quit

var owning_station
var is_open = false
var inventory_items = []


func initialize(station):
	owning_station = station
	$MarginContainer/HBoxContainer/NinePatchRect/LabelTitle.text = station.station_name
	for item in station.inventory:
		var data = GameInstance.ship_elements[item]
		var element = load("res://Actors/ShipElements/ShipElement.tscn").instance()
		element.data = data
		inventory_items.append(data)	
	$MarginContainer/HBoxContainer/NinePatchRect/LeftTabContainer.initialize(inventory_items)


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
	#TODO save current station inventory
	emit_signal("station_quit")
	close()


func _on_Tween_tween_completed(_object, _key):
	if is_open:
		window.show()
	else:
		queue_free()
