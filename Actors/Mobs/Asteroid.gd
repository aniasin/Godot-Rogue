extends KinematicBody2D

onready var move_direction = transform.x
var speed = 100


func _physics_process(delta):
	var collision = move_and_collide(move_direction * speed * delta)
	if collision:
		move_direction = move_direction * -1
		
