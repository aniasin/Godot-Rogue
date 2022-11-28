extends Node2D


func _ready():
	pass


func fire(owner_element):
	var projectile = load("res://Actors/ShipElements/ElementsAction/Projectile.tscn").instance()
	projectile.set_rotation(owner_element.get_global_rotation())
	projectile.set_position(owner_element.get_global_position())
	GameInstance.current_map.add_child(projectile)

