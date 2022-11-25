extends NinePatchRect

var inventory_size = 10


func populate(items_data):
	update_money()
	for item  in items_data:
		var slot = load("res://UI/Station/InventorySlot.tscn").instance()
		slot.item_data = item
		slot.parent_window = self
		$ScrollContainer/GridContainer.add_child(slot)
	
	if inventory_size - items_data.size() > 0:
		for _free_slot in range(inventory_size - items_data.size()):
			var slot = load("res://UI/Station/InventorySlot.tscn").instance()
			slot.parent_window = self
			$ScrollContainer/GridContainer.add_child(slot)


func action(item_in, item_out):
	if item_in.parent_window == item_out.parent_window:
		return true
	if GameInstance.player.get_inventory().get_money() < item_in.item_data["price"]:
		return false
	else:
		GameInstance.player.get_inventory().inc_money(- item_in.item_data["price"])
		GameInstance.player.get_inventory().add_item(item_in.item_data["name"])
		update_money()
		return true


func update_money():
	$LabelMoney.text = str(GameInstance.player.get_inventory().get_money())
