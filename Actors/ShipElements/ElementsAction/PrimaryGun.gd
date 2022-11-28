extends Node2D


func fire():
	var projectile = load("res://Actors/ShipElements/ElementsAction/Projectile.tscn").instance()
	projectile.set_rotation(get_global_rotation())
	projectile.set_position(get_global_position())
	GameInstance.current_map.add_child(projectile)

