extends NinePatchRect

var is_commercial = false


func _ready():
	update_ship_stats()
	if GameInstance.player.state != GameInstance.STATE.station:
		$ButtonRepair.hide()


func populate():
	for child in $Dummy/Dummy.get_children():
		child.parent_window = self
	var equipments = GameInstance.current_ship.equipped_slots
	for item in equipments.keys():
		if equipments[item]:
			for slot in $Dummy/Dummy.get_children():
				if slot.slot_id == item:
					slot.item_data = equipments[item]
					continue


func update_ship_stats():
	var power = str(GameInstance.current_ship.engine_consumption) + "/" + str(GameInstance.current_ship.max_consumption)
	$LabelPower.text = power
	var hp = str(GameInstance.current_ship.hp) + "/" + str(GameInstance.current_ship.max_hp)
	$LabelHull.text = hp


func _on_ButtonRepair_pressed():
	#TODO
	GameInstance.current_ship.hp = GameInstance.current_ship.max_hp
	update_ship_stats()
