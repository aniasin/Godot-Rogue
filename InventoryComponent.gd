extends Node

onready var root_node = GameInstance.current_map
onready var tween = $"../Interface/Tween"

var money = 1000
var items_data = []
var inventory_ui = null

func add_item(item):
	items_data.append(item)


func remove_item(item):
	items_data.erase(item)


func inc_money(value):
	money += value


func get_money():
	return money


func toggle_inventory(container):
	if inventory_ui:
		if not tween.is_active():
			tween.interpolate_property(inventory_ui, "margin_left", 
			0, -500, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			tween.connect("tween_all_completed", self, "_destroy_inventory_window")
	else:
		var Inventory = load("res://UI/Station/InventoryWin.tscn")
		inventory_ui = Inventory.instance()
		inventory_ui.populate(get_items_data())
		container.add_child(inventory_ui)
		tween.interpolate_property(inventory_ui, "margin_left", 
		-500, 0, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()


func _destroy_inventory_window():
		inventory_ui.queue_free()
		inventory_ui = null
		tween.disconnect("tween_all_completed", self, "_destroy_inventory_window")


func get_items_data():
	return items_data


func restore_state():
	inc_money(GameInstance.player_money)
	for item in GameInstance.player_inventory:
		add_item(item)


