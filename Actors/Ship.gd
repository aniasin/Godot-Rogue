extends Node2D

onready var slots = ["none", $Gun1, $Gun2, $Gun3, $Utility1, $Utility2, $Utility3,
$Engine1, $Engine2, $Engine3, $ThrustLeft1, $ThrustLeft2, $ThrustRight1, $ThrustRight2,]

var ui_window_path = "res://UI/Station/ShipHeavyWin.tscn"


func equip_slot(slot_id, item_data):
	var item = load("res://Actors/ShipElements/ShipElement.tscn").instance()
	item.element = item_data["name"]
	slots[slot_id].add_child(item)


func enter_station(station):
	print(station.station_name)
