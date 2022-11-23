extends NinePatchRect


func populate_shop(inventory):
	for item  in inventory:
		var rect = TextureRect.new()
		rect.texture = load(item)
		$ScrollContainer/GridContainer.add_child(rect)
