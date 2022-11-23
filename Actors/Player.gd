extends KinematicBody2D


func _ready():
	GameInstance.player = self


func _input(event):
	if event.is_action_pressed("inventory"):
		$InventoryComponent.toggle_inventory($CanvasLayer)


func _physics_process(_delta):
	var velocity = $MovementComp.get_input()
	velocity = move_and_slide(velocity)


func get_inventory():
	return $InventoryComponent.get_items_data()
