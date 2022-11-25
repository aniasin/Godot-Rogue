extends TabContainer


func initialize(items):
	var ui_window_path = GameInstance.current_ship.ui_window_path
	var ship = load(ui_window_path).instance()
	$Garage.add_child(ship)
	var player_items_data = GameInstance.player.get_inventory().get_items_data()
	$Shop/InventoryWin.populate(player_items_data)
	$Shop/ProductWin.populate(items)


func _on_LeftTabContainer_tab_changed(tab):
	match tab:
		0:
			var inventory = $Garage/InventoryWin
			$Garage.remove_child(inventory)
			$Shop.add_child(inventory)
		1:
			var inventory = $Shop/InventoryWin
			$Shop.remove_child(inventory)
			$Garage.add_child(inventory)
