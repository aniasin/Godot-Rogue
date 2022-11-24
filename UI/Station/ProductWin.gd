extends NinePatchRect


func populate(items_data):
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.item_data = item
		$ScrollContainer/GridContainer.add_child(slot)
		
	for i in range (0, 20):
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		$ScrollContainer/GridContainer.add_child(slot)
