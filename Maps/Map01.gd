extends Node2D

var station_open = false


func _ready():
	station_pop_up($Station)


func station_pop_up(station):
	if not station_open:
		var PopUp = load("res://UI/Station/StationMain.tscn")
		var station_menu = PopUp.instance()
		station_menu.initialize(station)
		add_child(station_menu)
		station_open = true
