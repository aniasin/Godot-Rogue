extends Node2D

onready var slots = [null, $Gun1, $Gun2, $Gun3, $Utility1, $Utility2, $Utility3,
$Engine1, $Engine2, $Engine3, $ThrustLeft1, $ThrustLeft2, $ThrustRight1, $ThrustRight2,]

var ui_window_path = "res://UI/Station/ShipHeavyWin.tscn"
var equipped_slots = {}

var weight = 3
var engine_power = 20
var engine_consumption = 20


func equip_slot(slot_id, item_data):
	unequip_slot(slot_id)
	GameInstance.player.get_inventory().remove_item(item_data)
	var item = load("res://Actors/ShipElements/ShipElement.tscn").instance()
	item.element = item_data["name"]
	slots[slot_id].add_child(item)
	equipped_slots[slot_id] = item_data
	update_ship()
	

func unequip_slot(slot_id):
	if equipped_slots.has(slot_id) and equipped_slots[slot_id]:
		GameInstance.player.get_inventory().add_item(slots[slot_id].get_child(0).data)
		print("unequiped item !")
		remove_slot(slot_id)


func remove_slot(slot_id):
	if equipped_slots.has(slot_id):
		slots[slot_id].get_child(0).queue_free()
		equipped_slots.erase(slot_id)
	update_ship()


func update_ship():
	engine_power = 20
	engine_consumption = 20
	for key in equipped_slots.keys():
		if equipped_slots[key]:
			var type = equipped_slots[key]["type"]
			if type == "ENGINE":
				engine_power += equipped_slots[key]["power"]
			engine_consumption += equipped_slots[key]["consumption"]


func enter_station(station):
	print(station.station_name)
