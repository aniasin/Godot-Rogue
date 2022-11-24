extends NinePatchRect

var inventory_size = 10
var items = []


func populate(items_data):
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.texture = load(item["icon"])
		slot.slot_name = item["name"]
		$ScrollContainer/GridContainer.add_child(slot)
	
	if inventory_size - items_data.size() > 0:
		for _free_slot in range(inventory_size - items_data.size()):
			var slot = load("res://UI/Station/InventorySlot.tscn").instance()
			slot.texture = load("res://UI/Station/Assets/slot.png")
			slot.slot_name = "none"
			$ScrollContainer/GridContainer.add_child(slot)
