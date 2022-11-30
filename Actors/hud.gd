extends NinePatchRect


func _on_ButtonInventory_pressed():
	GameInstance.player.toggle_inventory()


func _on_ButtonMap_pressed():
	GameInstance.player.toggle_map()


func _on_Buttonship_pressed():
	GameInstance.player.toggle_ship()
