extends TabContainer


func initialize(items):
	#$Shop/InventoryWin.populate(items)
	#$Garage/InventoryWin.populate(items)
	$Shop/ProductWin.populate(items)
