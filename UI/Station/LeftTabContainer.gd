extends TabContainer


func initialize(items):
	var player_items_data = GameInstance.player.get_inventory()
	$Shop/InventoryWin.populate(player_items_data)
	$Garage/InventoryWin.populate(player_items_data)
	$Shop/ProductWin.populate(items)
