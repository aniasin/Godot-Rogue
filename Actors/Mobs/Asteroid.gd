extends KinematicBody2D

var move_direction = Vector2(1, 1)
var speed = 100


func _physics_process(delta):
	var collision = move_and_collide(move_direction * speed * delta)
	if collision:
		move_direction = move_direction * -1
		
