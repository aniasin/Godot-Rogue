extends NinePatchRect

var inventory_size = 10
var items = []


func populate(items_data):
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.texture = load(item["icon"])
		$ScrollContainer/GridContainer.add_child(slot)
	
	if inventory_size - items_data.size() > 0:
		for free_slot in range(inventory_size - items_data.size()):
			var slot = load("res://UI/Station/InventorySlot.tscn").instance()
			slot.texture = load("res://UI/Station/Assets/slot.png")
			$ScrollContainer/GridContainer.add_child(slot)
		
