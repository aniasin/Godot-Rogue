extends KinematicBody2D

var velocity = Vector2()
var rotation_dir = 0
var ship

var state = GameInstance.STATE.default

var map
var ship_window

func _ready():
	print("Player ready !")
	GameInstance.player = self
	restore_state()


func get_input():
	rotation_dir = 0
	if Input.is_action_pressed("left click") and state != GameInstance.STATE.station:
		ship.start_primary_fire()
	if Input.is_action_just_released("left click") and state != GameInstance.STATE.station:
		ship.stop_primary_fire()
	
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_just_pressed("up"):
		ship.add_thrust(velocity, 1, 0)
	if Input.is_action_just_released("up"):
		ship.thrust_release()
	if Input.is_action_just_pressed("down"):
		ship.add_thrust(velocity, -1, 0)
	if Input.is_action_just_released("down"):
		ship.thrust_release()
	if Input.is_action_just_pressed("strafe_left"):
		ship.add_thrust(velocity, 1, -90)
	if Input.is_action_just_released("strafe_left"):
		ship.thrust_release()
	if Input.is_action_just_pressed("strafe_right"):
		ship.add_thrust(velocity, 1, 90)
	if Input.is_action_just_released("strafe_right"):
		ship.thrust_release()
	


func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		toggle_inventory()


func _physics_process(delta):
	if state == GameInstance.STATE.station:
		velocity = Vector2()
	else:
		get_input()
		rotation += rotation_dir * ship.rotation_speed * delta
		velocity = ship.thrust
	velocity = move_and_slide(velocity)


func equip_ship(current_ship):
	GameInstance.current_ship = current_ship
	ship = current_ship


func toggle_inventory():
	$InventoryComponent.toggle_inventory($Interface)


func toggle_map():
	if not map:
		map = load("res://UI/Map.tscn").instance()
		map.tween = $Interface/Tween
		$Interface.add_child(map)
	else:
		map.queue_free()
		map = null


func toggle_ship():
	ship.toggle_ship_window($Interface)


func get_inventory():
	return $InventoryComponent
	

func get_camera():
	return $Camera2D

func restore_state():	
	ship.restore_state()
	$InventoryComponent.restore_state()
