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
	if $TimerFireRate.is_stopped():
		$TimerFireRate.start()
		element_fire.fire()
		is_firing = true


func stop_fire():
	is_firing = false


func damage(value):
	data["hp"] -= value
	if data["hp"] <= 0:
		data["state"] = false
	print(data["name"], " has been damaged for ", value)


func _on_TimerFireRate_timeout():
	if is_firing:
		element_fire.fire()
	else:
		$TimerFireRate.stop()
