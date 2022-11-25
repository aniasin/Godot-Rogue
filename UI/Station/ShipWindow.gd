extends NinePatchRect


func populate():
	var equipments = GameInstance.current_ship.equipped_slots
	for item in equipments.keys():
		if equipments[item]:
			for slot in $Container/Container2.get_children():
				if slot.slot_id == item:
					slot.item_data = equipments[item]
					continue
