extends PanelContainer


func set_text(item_data):
	var name = item_data["name"] + "\n"
	var hp = "hp : " + str(item_data["hp"]) + "\n"
	var power = "power : " + "\n"
	var consumption = "consumption : " + "\n"
	var price = "price : " + str(item_data["price"]) + "\n"
	$Label.text =  name + hp + power + consumption + price
