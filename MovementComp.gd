extends Node


var velocity = Vector2()

func get_input():
	var speed = 0
	if GameInstance.current_ship:
		speed += GameInstance.current_ship.engine_power
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	return velocity
