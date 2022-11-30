extends Node2D

onready var timer = $TimerFireRate
var is_firing = false


func activate():
	if $TimerFireRate.is_stopped():
		$TimerFireRate.start()
		fire()
		is_firing = true


func deactivate():
	is_firing = false


func fire():
	var projectile = load("res://Actors/ShipElements/ElementsAction/Projectile.tscn").instance()
	projectile.set_rotation(get_global_rotation())
	projectile.set_position(get_global_position())
	GameInstance.current_map.add_child(projectile)
	


func _on_TimerFireRate_timeout():
	if is_firing:
		fire()
	else:
		$TimerFireRate.stop()
