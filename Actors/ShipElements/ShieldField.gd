extends StaticBody2D

var power
var owner_element

func hit(collider, damage):
	power -= damage
	owner_element.data["power"] = power
	if power <= 0:
		$CollisionShape2D.disabled = true
		$Sprite.hide()


