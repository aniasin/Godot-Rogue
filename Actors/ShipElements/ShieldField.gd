extends StaticBody2D

var hp
var owner_element

func hit(collider, damage):
	hp -= damage
	owner_element.data["hp"] = hp
	if hp <= 0:
		queue_free()


