extends KinematicBody2D

export (int) var speed = 1000


func _ready():
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer.autostart = true
	timer.connect("timeout", self, "explode")
	add_child(timer)


func _physics_process(delta):
	var collision = move_and_collide(Vector2(0, -speed).rotated(rotation) * delta)
	if collision:
		print("Collided with ", collision.collider.name)
		explode()


func explode():
	queue_free()
