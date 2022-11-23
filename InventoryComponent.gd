extends Node

onready var root_node = GameInstance.current_map

var items = ["Engine", "Gun"]
var inventory_ui = null

func add_item(item_name):
	items.append(item_name)


func remove_item(item_name):
	items.erase(item_name)

func toggle_inventory(container):
	if inventory_ui:
		inventory_ui.queue_free()
		inventory_ui = null
	else:
		var Inventory = load("res://UI/Station/InventoryWin.tscn")
		inventory_ui = Inventory.instance()
		inventory_ui.populate(get_items_data())
		container.add_child(inventory_ui)


func get_items_data():
	var items_data = []
	for item in items:
		var data = GameInstance.ship_elements[item]
		items_data.append(data)
	return items_data
