extends Area2D

export (int) var speed = 1000


func _ready():
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer.autostart = true
	timer.connect("timeout", self, "explode")
	add_child(timer)


func _process(delta):
	var velocity = Vector2(0, -speed).rotated(rotation)
	position += velocity * delta


func explode():
	queue_free()
