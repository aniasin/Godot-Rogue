extends Node

var current_map
var player
var ship_elements = {}


func _ready():
	var data_file = File.new()
	if data_file.open("res://Data/ShipElements.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	var data = data_parse.result
	for item in data:
		ship_elements[item["name"]] = item
	print(ship_elements)



