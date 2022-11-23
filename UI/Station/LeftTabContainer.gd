extends TabContainer


func initialize(items):
	$Shop/InventoryWin.populate_shop(items)
	$Garage/InventoryWin.populate_shop(items)
