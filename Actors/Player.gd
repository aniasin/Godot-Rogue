extends KinematicBody2D

var velocity = Vector2()
var rotation_dir = 0
var ship

enum STATE {default = 0, station=1}
var state = STATE.default

var map

func _ready():
	GameInstance.player = self
	equip_ship($ShipHeavy)


func get_input():
	rotation_dir = 0
	if Input.is_action_just_pressed("booster"):
		ship.start_booster()
	if Input.is_action_just_released("booster"):
		ship.stop_booster()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("up"):
		velocity = Vector2(ship.engine_power + ship.booster, 0).rotated(rotation)
	if Input.is_action_pressed("down"):
		velocity = Vector2(-ship.engine_power, 0).rotated(rotation)


func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		toggle_inventory()
	if event.is_action_pressed("left click") and state != STATE.station:
		ship.start_primary_fire()
	if event.is_action_released("left click") and state != STATE.station:
		ship.stop_primary_fire()


func _physics_process(delta):
	if state == STATE.station:
		velocity = Vector2()
	else:
		get_input()
		rotation += rotation_dir * ship.rotation_speed * delta
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


func get_inventory():
	return $InventoryComponent
