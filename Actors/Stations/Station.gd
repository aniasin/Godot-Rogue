extends Area2D

export var station_name = "Station A"
export (PoolStringArray) var inventory
var station_image = load("res://Assets/Stations/station.png")


func _on_Station_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.has_method("enter_station"):
		$CollisionShape2D.set_deferred("disabled", true)
		area.enter_station(self)
		get_parent().station_pop_up(self)
