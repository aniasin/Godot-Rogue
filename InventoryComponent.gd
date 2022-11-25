extends Node

onready var root_node = GameInstance.current_map
onready var tween = $"../Interface/Tween"

var money = 1000
var items = ["Engine", "Gun"]
var inventory_ui = null

func add_item(item_name):
	items.append(item_name)


func remove_item(item_name):
	items.erase(item_name)


func inc_money(value):
	money += value


func get_money():
	return money


func toggle_inventory(container):
	if inventory_ui:
		tween.interpolate_property(inventory_ui, "margin_left", 
		0, -500, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		tween.connect("tween_all_completed", self, "_destroy_inventory_window")
	else:
		var Inventory = load("res://UI/Station/InventoryWin.tscn")
		inventory_ui = Inventory.instance()
		inventory_ui.populate(get_items_data())
		container.add_child(inventory_ui)
		tween.interpolate_property(inventory_ui, "margin_left", 
		-500, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()


func _destroy_inventory_window():
		inventory_ui.queue_free()
		inventory_ui = null
		tween.disconnect("tween_all_completed", self, "_destroy_inventory_window")


func get_items_data():
	var items_data = []
	for item in items:
		var data = GameInstance.ship_elements[item]
		items_data.append(data)
	return items_data


