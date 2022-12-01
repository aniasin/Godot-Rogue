extends KinematicBody2D

onready var move_direction = transform.x
onready var ai_component = $AiComponent

var velocity

var ship
var speed = 50
# When spawned, will be overwritten
var data = {"ship":"res://Actors/ShipElements/ShipHeavy.tscn"}

func _ready():
	ship = load(data["ship"]).instance()	
	add_child(ship)
	ship.equip_slot(1, GameInstance.ship_elements["Engine"])
	ship.equip_slot(8, GameInstance.ship_elements["Battery"])
	ship.equip_slot(6, GameInstance.ship_elements["Gun"])
	ship.equip_slot(7, GameInstance.ship_elements["Gun"])
	
	ai_component.start(self)


func _physics_process(_delta):
	velocity = ship.thrust
	velocity = move_and_slide(velocity)


func get_inventory():
	return $MobInventory
