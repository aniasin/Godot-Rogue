extends Area2D

export (String) var element

var data


func _ready():
	data = GameInstance.ship_elements[element]
	$Sprite.texture = load(data["texture"])


func get_texture():
	return $Sprite.texture

