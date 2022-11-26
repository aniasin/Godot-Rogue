extends Node


var velocity = Vector2()

func get_input():
	var speed = 0
	var booster = 0
	if GameInstance.current_ship:
		speed += GameInstance.current_ship.engine_power
	velocity = Vector2()
	if Input.is_action_pressed("booster"):
		GameInstance.current_ship.start_booster()
	if Input.is_action_just_released("booster"):
		GameInstance.current_ship.stop_booster()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * (speed + GameInstance.current_ship.booster)
	return velocity
