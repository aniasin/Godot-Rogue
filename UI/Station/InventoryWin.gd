extends NinePatchRect

var inventory_size = 10
var items = []


func populate(items_data):
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
		print(GameInstance.player.get_inventory().get_money())
		return true

