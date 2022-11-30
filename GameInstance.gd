extends Node

enum STATE {default = 0, station=1}

var current_map
var player
var current_ship
var ship_elements = {}
var encounters = {}

# Map transition
var transition_id
var parallax
# SaveGame
var player_equipments = {}
var player_inventory = []
var player_rotation = 0
var player_position = Vector2()
var player_money = 0


func _ready():
	var data_file_ships = File.new()
	if data_file_ships.open("res://Data/ShipElements.json", File.READ) != OK:
		return
	var data_text_ships = data_file_ships.get_as_text()
	data_file_ships.close()
	var data_parse_ships = JSON.parse(data_text_ships)
	if data_parse_ships.error != OK:
		return
	var data_ships = data_parse_ships.result
	for item in data_ships:
		ship_elements[item["name"]] = item
		
	var data_file_encounters = File.new()
	if data_file_encounters.open("res://Data/Encounters.json", File.READ) != OK:
		return
	var data_text_encounters = data_file_encounters.get_as_text()
	var data_parse_encounters = JSON.parse(data_text_encounters)
	if data_parse_encounters.error != OK:
		return
	var data_encounters = data_parse_encounters.result
	for item in data_encounters:
		encounters[item["name"]] = item


func spawn_player():
	player = load("res://Actors/Player.tscn").instance()
	current_ship = load("res://Actors/ShipElements/ShipLight.tscn").instance()
	player.add_child(current_ship)
	player.ship = current_ship
	var spawn_location = Vector2()
	var transition_objects = get_tree().get_nodes_in_group("transition")
	for object in transition_objects:
		if object.transition_id == transition_id:
			spawn_location = object.spawn_location
			object.arrival()
			break
	player.set_position(spawn_location)
	player.set_rotation(player_rotation)
	current_map.add_child(player)
	parallax.set_up(player.get_camera())
	return player


func save_game():
	player_rotation = player.get_rotation()
	player_equipments = current_ship.equipped_slots
	player_inventory = player.get_inventory().get_items_data()
	player_money = player.get_inventory().get_money()

