extends Area2D

export (int) var speed = 1000


func _process(delta):
	var velocity = Vector2(0, -speed).rotated(rotation)
	position += velocity * delta
