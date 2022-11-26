extends NinePatchRect

var is_commercial = false

func _ready():
	update_ship_stats()


func populate():
	for child in $Container/Container2.get_children():
		child.parent_window = self
	var equipments = GameInstance.current_ship.equipped_slots
	for item in equipments.keys():
		if equipments[item]:
			for slot in $Container/Container2.get_children():
				if slot.slot_id == item:
					slot.item_data = equipments[item]
					continue


func update_ship_stats():
	var power = str(GameInstance.current_ship.engine_consumption) + "/" + str(GameInstance.current_ship.max_consumption)
	$LabelPower.text = power
