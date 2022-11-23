extends NinePatchRect


func populate(items_data):
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.texture = load(item["icon"])
		$ScrollContainer/GridContainer.add_child(slot)
