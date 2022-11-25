extends NinePatchRect


func populate(items_data):
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.item_data = item
		slot.parent_window = self
		$ScrollContainer/GridContainer.add_child(slot)
		
	for _i in range (0, 20):
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.parent_window = self
		$ScrollContainer/GridContainer.add_child(slot)


func action(item_in, item_out):
	if item_in.parent_window == item_out.parent_window:
		return false
	else:
		GameInstance.player.get_inventory().inc_money(item_in.item_data["price"] / 2)
		GameInstance.player.get_inventory().remove_item(item_in.item_data["name"])
		item_in.parent_window.update_money()
		return true

