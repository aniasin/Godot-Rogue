extends KinematicBody2D

onready var ship_base = $Ship.ship_base
onready var movement_comp = $MovementComp

func _physics_process(_delta):
	var velocity = movement_comp.get_input()
	velocity = move_and_slide(velocity)

