extends NinePatchRect


func populate_shop(items):
	for item  in items:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.texture = load(item.inventory_texture_path)
		$ScrollContainer/GridContainer.add_child(slot)
