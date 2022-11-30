extends KinematicBody2D

onready var move_direction = transform.x
var speed = 50
# When spawned, will be overwroten
var data = {"damage":10, "hp":10, "name":"asteroids","path":"res://Actors/Mobs/Asteroid.tscn"}


func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	speed = rng.randi_range(45, 55)


func _physics_process(delta):
	var collision = move_and_collide(move_direction * speed * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit(self, data["damage"])
		
		var timer = Timer.new()
		timer.set_wait_time(3)
		timer.autostart = true
		timer.connect("timeout", self, "_timer_timeout", [timer])
		add_child(timer)
		$CollisionShape2D.disabled = true
		speed = 200
		move_direction = move_direction.bounce(collision.normal)


func _timer_timeout(timer):
	speed = 50
	$CollisionShape2D.disabled = false
	timer.queue_free()


func out_of_boundary():
	var timer = Timer.new()
	timer.autostart = true
	timer.set_wait_time(10)
	timer.connect("timeout", self, "_destroy")
	add_child(timer)

	
func _destroy():
	queue_free()

