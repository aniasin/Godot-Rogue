extends Area2D

export (String) var element

var element_fire
var data

var is_firing = false



func _ready():
	data = GameInstance.ship_elements[element]
	$Sprite.texture = load(data["texture"])
	element_fire = load(data["activate"]).instance()
	add_child(element_fire)
	$TimerFireRate.set_wait_time(data["rate"] / 60)


func get_texture():
	return $Sprite.texture


func start_fire():
	if not is_firing:
		$TimerFireRate.start()
		element_fire.fire(self)
		is_firing = true


func stop_fire():
	$TimerFireRate.stop()
	is_firing = false


func _on_TimerFireRate_timeout():
	element_fire.fire(self)
