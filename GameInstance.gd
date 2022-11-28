extends Node

var current_map
var player
var current_ship
var ship_elements = {}
var encounters = {}


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
