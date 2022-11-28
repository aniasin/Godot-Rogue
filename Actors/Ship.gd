extends KinematicBody2D

onready var slots = [null, $Gun1, $Gun2, $Gun3, $Utility1, $Utility2, $Utility3,
$Engine1, $Engine2, $Engine3, $ThrustLeft1, $ThrustLeft2, $ThrustRight1, $ThrustRight2,]

var ui_window_path = "res://UI/Station/ShipHeavyWin.tscn"
var equipped_slots = {}

var weight = 3
var engine_power = 20
var rotation_speed = 1.5
var engine_consumption = 20
var max_consumption = 120
var booster = 0
var booster_time = 0
var max_booster = 200

var is_boosting = false
var booster_state = 0

var primary_guns = []


func _process(delta):
	if is_boosting:
		booster_time -= delta
	else:
		booster_time = clamp(booster_time + delta, 0, (max_consumption - engine_consumption) / 10)
	if max_consumption - engine_consumption > 0:
		booster_state = (booster_time / (max_consumption - engine_consumption)) * 1000
	else:
		booster_state = 0


func equip_slot(slot_id, item_data):
	if item_data["consumption"] > max_consumption - engine_consumption:
		return false
	unequip_slot(slot_id)
	GameInstance.player.get_inventory().remove_item(item_data)
	var item = load("res://Actors/ShipElements/ShipElement.tscn").instance()
	item.element = item_data["name"]
	slots[slot_id].add_child(item)
	if item_data["type"] == "GUN":
		primary_guns.append(item)
	equipped_slots[slot_id] = item_data
	update_ship()
	return true
	

func unequip_slot(slot_id):
	if equipped_slots.has(slot_id) and equipped_slots[slot_id]:
		if max_consumption - engine_consumption + slots[slot_id].get_child(0).data["consumption"] < 0:
			return false
		GameInstance.player.get_inventory().add_item(slots[slot_id].get_child(0).data)
		remove_slot(slot_id)
		return true
	return false


func remove_slot(slot_id):
	if equipped_slots.has(slot_id):
		if slots[slot_id].get_child(0).data["type"] == "GUN":
			primary_guns.erase(slots[slot_id].get_child(0))
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

	booster_time = (max_consumption - engine_consumption) / 10


func start_primary_fire():
	for gun in primary_guns:
		gun.start_fire()


func stop_primary_fire():
	for gun in primary_guns:
		gun.stop_fire()


func enter_station(station):
	print(station.station_name)


func start_booster():
	if booster <= 0 and booster_time >= 1 and engine_power > 20:
		$TweenBooster.interpolate_property(self, "booster", 
		0, max_booster, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(booster_time)
		timer.autostart = true
		timer.connect("timeout", self, "_timer_booster_callback", [timer])
		add_child(timer)
		$TweenBooster.start()
		is_boosting = true


func stop_booster():
	$TweenBooster.stop_all()
	$TweenBooster.interpolate_property(self, "booster", 
	booster, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenBooster.start()
	is_boosting = false


func _timer_booster_callback(timer):
	stop_booster()
	timer.queue_free()

