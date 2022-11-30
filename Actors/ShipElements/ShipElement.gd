extends Area2D

export (String) var element

var element_action
var data

var is_firing = false



func _ready():
	data = GameInstance.ship_elements[element]
	$Sprite.texture = load(data["texture"])
	element_action = load(data["activate"]).instance()
	add_child(element_action)
	element_action.timer.set_wait_time(data["rate"] / 60)

func get_texture():
	return $Sprite.texture
	

func activate_element():
	element_action.activate()


func deactivate_element():
	element_action.deactivate()

func start_fire():
	activate_element()


func stop_fire():
	deactivate_element()


func damage(value):
	data["hp"] -= value
	if data["hp"] <= 0:
		data["state"] = false
	print(data["name"], " has been damaged for ", value)


