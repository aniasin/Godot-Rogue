extends TabContainer


func initialize(station):
	$Shop/InventoryWin.populate_shop(station.inventory)
