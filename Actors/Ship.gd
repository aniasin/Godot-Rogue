extends KinematicBody2D


onready var slots = [null]
var tween

export (String) var ui_window_path

var equipped_slots = {}

var max_hp = 200
var hp = max_hp
var weight = 3
var engine_power = 100
var rotation_speed = 1.5
var engine_consumption = 20
var max_consumption = 120

var thrust = Vector2()


var primary_guns = []
var engines = []
var ship_window = null


func _ready():
	if get_parent().name == GameInstance.player.name:
		tween = $"../Interface/Tween"
		collision_layer = 1
		collision_mask = 2
	else:
		collision_layer = 2
		collision_mask = 1
	for item in get_children():
		if item is Position2D:
			slots.append(item)


func hit(_collider, damage):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randf() > .8 or hp <= 0:
		var index = rng.randi_range(1, equipped_slots.size())
		if slots[index].get_child_count() > 0:
			slots[index].get_child(0).damage(damage)
			return
	hp -= damage
	print("Hull has been damaged for ", damage)


func equip_slot(slot_id, item_data):
	if item_data["consumption"] > max_consumption - engine_consumption:
		return false
	unequip_slot(slot_id)
	get_parent().get_inventory().remove_item(item_data)
	var item = load("res://Actors/ShipElements/ShipElement.tscn").instance()
	item.element = item_data["name"]
	slots[slot_id].add_child(item)
	if item_data["type"] == "GUN":
		primary_guns.append(item)
	if item_data["type"] == "ENGINE":
		engines.append(item)
	if item_data["name"] == "Shield":
		var field = load("res://Actors/ShipElements/ShieldField.tscn").instance()
		field.power = item_data["power"]
		field.owner_element = item
		add_child(field)
	equipped_slots[slot_id] = item_data
	update_ship()
	return true
	

func unequip_slot(slot_id):
	if equipped_slots.has(slot_id) and equipped_slots[slot_id]:
		if max_consumption - engine_consumption + slots[slot_id].get_child(0).data["consumption"] < 0:
			return false
		get_parent().get_inventory().add_item(slots[slot_id].get_child(0).data)
		remove_slot(slot_id)
		return true
	return false


func remove_slot(slot_id):
	if equipped_slots.has(slot_id):
		if slots[slot_id].get_child(0).data["type"] == "GUN":
			primary_guns.erase(slots[slot_id].get_child(0))
		if slots[slot_id].get_child(0).data["type"] == "ENGINE":
			engines.erase(slots[slot_id].get_child(0))
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


func start_primary_fire():
	for gun in primary_guns:
		gun.activate_element()


func stop_primary_fire():
	for gun in primary_guns:
		gun.deactivate_element()


func enter_station(station):
	print(station.name)


func add_thrust(velocity, direction, angle):
	thrust = velocity
	var goal_velocity = (Vector2(engine_power, 0) * direction).rotated(get_parent().rotation + angle)
	$TweenThrust.interpolate_property(self, "thrust", thrust, goal_velocity, 1,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenThrust.start()
	for engine in engines:
		engine.activate_element()


func thrust_release():
	$TweenThrust.stop_all()


func toggle_ship_window(container):
	if ship_window:
		if not tween.is_active():
			tween.interpolate_property(ship_window, "margin_left", 
			-500, 0, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			tween.connect("tween_all_completed", self, "_destroy_ship_window")
	else:
		var Window = load(ui_window_path)
		ship_window = Window.instance()
		ship_window.populate()
		container.add_child(ship_window)
		tween.interpolate_property(ship_window, "margin_left", 
		0, -500, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()


func _destroy_ship_window():
	ship_window.queue_free()
	ship_window = null
	tween.disconnect("tween_all_completed", self, "_destroy_ship_window")


func restore_state():
	for key in GameInstance.player_equipments:
		equip_slot(key, GameInstance.player_equipments[key])

