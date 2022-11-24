extends TabContainer


func initialize(items):
	var ui_window_path = GameInstance.current_ship.ui_window_path
	var ship = load(ui_window_path).instance()
	$Garage.add_child(ship)
	var player_items_data = GameInstance.player.get_inventory().get_items_data()
	$Shop/InventoryWin.populate(player_items_data)
	$Garage/InventoryWin.populate(player_items_data)	
	$Shop/ProductWin.populate(items)
