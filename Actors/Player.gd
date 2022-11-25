extends KinematicBody2D


func _ready():
	GameInstance.player = self
	equip_ship($ShipHeavy)


func _input(event):
	if event.is_action_pressed("inventory"):
		$InventoryComponent.toggle_inventory($Interface)


func _physics_process(_delta):
	var velocity = $MovementComp.get_input()
	velocity = move_and_slide(velocity)


func equip_ship(ship):
	GameInstance.current_ship = ship


func get_inventory():
	return $InventoryComponent
