extends NinePatchRect


func populate(items_data):
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.texture = load(item["icon"])
		slot.slot_name = item["name"]
		$ScrollContainer/GridContainer.add_child(slot)
		
	for i in range (0, 20):
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.texture = load("res://UI/Station/Assets/slot.png")
		slot.slot_name = "none"
		$ScrollContainer/GridContainer.add_child(slot)
