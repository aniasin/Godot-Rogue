extends Node2D

onready var timer = $TimerDrag_n_drop

var station_open = false
var dragged_texture
var dragged_slot

func _ready():
	station_pop_up($Station)


func station_pop_up(station):
	if not station_open:
		var StationMenu = load("res://UI/Station/StationMain.tscn")
		var station_menu = StationMenu.instance()
		station_menu.initialize(station)
		add_child(station_menu)
		station_open = true


func _input(event):
	if event.is_action_released("left click"):
		if dragged_texture:
			timer.start(0.1)


func start_dragging(slot, texture):
	dragged_slot = slot
	dragged_texture = texture


func stop_dragging():
	dragged_texture = null
	dragged_slot = null


func swap(slot, texture):
	slot.texture = dragged_texture
	dragged_slot.texture = texture
	stop_dragging()


func _on_TimerDrag_n_drop_timeout():
	if dragged_texture:
		dragged_slot.texture = dragged_texture
		stop_dragging()
