extends Node2D

onready var slots = [null, $Gun1, $Gun2, $Gun3, $Utility1, $Utility2, $Utility3,
$Engine1, $Engine2, $Engine3, $ThrustLeft1, $ThrustLeft2, $ThrustRight1, $ThrustRight2,]

var ui_window_path = "res://UI/Station/ShipHeavyWin.tscn"


func equip_slot(slot_id, item_data):
	unequip_slot(slot_id)
	GameInstance.player.get_inventory().remove_item(item_data["name"])
	var item = load("res://Actors/ShipElements/ShipElement.tscn").instance()
	item.element = item_data["name"]
	slots[slot_id].add_child(item)
	

func unequip_slot(slot_id):
	if  slots[slot_id] and slots[slot_id].get_child(0):
		GameInstance.player.get_inventory().add_item(slots[slot_id].get_child(0).data["name"])
		slots[slot_id].get_child(0).queue_free()


func enter_station(station):
	print(station.station_name)
