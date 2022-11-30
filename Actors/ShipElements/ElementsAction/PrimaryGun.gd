extends Node2D

onready var timer = $TimerFireRate
var is_firing = false
var own_layer
var own_mask

func activate(layer, mask):
	own_layer = layer
	own_mask = mask
	if $TimerFireRate.is_stopped():
		$TimerFireRate.start()
		fire()
		is_firing = true


func deactivate():
	is_firing = false


func fire():
	var projectile = load("res://Actors/ShipElements/ElementsAction/Projectile.tscn").instance()
	projectile.collision_layer = own_layer
	projectile.collision_mask = own_mask
	projectile.set_rotation(get_global_rotation())
	projectile.set_position(get_global_position())
	GameInstance.current_map.add_child(projectile)
	


func _on_TimerFireRate_timeout():
	if is_firing:
		fire()
	else:
		$TimerFireRate.stop()
