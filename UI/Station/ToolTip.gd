extends PanelContainer


func set_text(item_data):
	var name = item_data["name"] + "\n"
	var hp = "HP : " + str(item_data["hp"]) + "\n"
	var power = "Power : " + str(item_data["power"]) + "\n"
	var consumption = "Consumption : " + str(item_data["consumption"]) + "\n"
	var price = "Price : " + str(item_data["price"]) + "\n"
	var description = "\n" + "Description : " + str(item_data["description"])
	$Label.text =  name + hp + power + consumption + price + description
