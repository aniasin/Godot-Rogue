extends Node2D

onready var slots = [null, $Gun1, $Gun2, $Gun3, $Utility1, $Utility2, $Utility3,
$Engine1, $Engine2, $Engine3, $ThrustLeft1, $ThrustLeft2, $ThrustRight1, $ThrustRight2,]

var ui_window_path = "res://UI/Station/ShipHeavyWin.tscn"
var equipped_slots = {}

var weight = 3
var engine_power = 20
var engine_consumption = 20
var max_consumption = 120
var booster = 0
var booster_timer
var booster_replenish_time = 10


func equip_slot(slot_id, item_data):
	if item_data["consumption"] > max_consumption - engine_consumption:
		return false
	unequip_slot(slot_id)
	GameInstance.player.get_inventory().remove_item(item_data)
	var item = load("res://Actors/ShipElements/ShipElement.tscn").instance()
	item.element = item_data["name"]
	slots[slot_id].add_child(item)
	equipped_slots[slot_id] = item_data
	update_ship()
	return true
	

func unequip_slot(slot_id):
	if equipped_slots.has(slot_id) and equipped_slots[slot_id]:
		if max_consumption - engine_consumption + slots[slot_id].get_child(0).data["consumption"] < 0:
			return false
		GameInstance.player.get_inventory().add_item(slots[slot_id].get_child(0).data)
		print("unequiped item !")
		remove_slot(slot_id)
		return true
	return false


func remove_slot(slot_id):
	if equipped_slots.has(slot_id):
		slots[slot_id].get_child(0).queue_free()
		equipped_slots.erase(slot_id)
	update_ship()


func update_ship():
	engine_power = 20
	engine_consumption = 20
	max_consumption = 120
	for key in equipped_slots.keys():
		if equipped_slots[key]:
			var type = equipped_slots[key]["type"]
			if type == "ENGINE":
				engine_power += equipped_slots[key]["power"]
			if equipped_slots[key]["consumption"] > 0:
				engine_consumption += equipped_slots[key]["consumption"]
			else:
				max_consumption -= equipped_slots[key]["consumption"]


func enter_station(station):
	print(station.station_name)


func start_booster():
	#TODO Tween
	if booster >= 0 and max_consumption - engine_consumption > 10:
		engine_consumption += 1
		booster = 100
	else:
		stop_booster()


func stop_booster():
	#TODO Tween
	if not booster_timer:
		booster = -1
		booster_timer = Timer.new()
		booster_timer.set_one_shot(true)
		booster_timer.set_wait_time(booster_replenish_time)
		booster_timer.autostart = true
		booster_timer.connect("timeout", self, "_timer_booster_callback")
		add_child(booster_timer)


func _timer_booster_callback():
	update_ship()
	booster = 0
	booster_timer.queue_free()
	booster_timer = null
	print("booster back !")
