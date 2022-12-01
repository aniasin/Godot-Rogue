extends Node

export (float) var interval = 1.0

var is_active = false
var home_location
var mob
var time = 0
var last_tick = 0.0
var current_targets = []
var target_location = null
var is_moving = false


func _process(delta):
	if not is_active or not mob:
		return
	move()
	update_perception()
	set_target()
	time += delta


func start(actor):
	mob = actor
	home_location = mob.position
	is_active = true


func update_perception():
	if not $PerceptionComponent.is_active:
		return
	if $PerceptionComponent.last_tick >= time - $PerceptionComponent.interval:
		$PerceptionComponent.update_perception(mob)
		$PerceptionComponent.last_tick = time


func set_target():
	if not is_active:
		return
	var perceived_actors = $PerceptionComponent.currently_perceived_actors
	if perceived_actors.size() > 0:
		current_targets = perceived_actors
		chase(current_targets[0])
		return
	perceived_actors = $PerceptionComponent.perceived_actors.keys()
	if perceived_actors.size() > 0:
		current_targets = perceived_actors
		var last_known_position = $PerceptionComponent.perceived_actors[current_targets[0]]["position"]
		search(current_targets[0], last_known_position)
		return
	patrol()
	current_targets = []


func patrol():
	stop_chase()
	stop_search()
	print("Patrolling...")
	target_location = home_location


func chase(target):
	print("Chasing ", target)
	mob.look_at(target.position)
	for gun in mob.ship.primary_guns:
		gun.get_parent().look_at(target.get_global_position())
	mob.ship.start_primary_fire()


func stop_chase():
	print("Stop Chase !")
	mob.ship.stop_primary_fire()


func search(_target, position):
	stop_chase()
	if not target_location:
		print("Searching...")
		target_location = position
	

func stop_search():
	print("Stop Searching !")
	target_location = null


func move():
	if not target_location:
		return
	if mob.position.distance_to(target_location) >= 200 and not is_moving:
		mob.look_at(target_location)
		mob.ship.add_thrust(mob.velocity, 1, 0)
		is_moving = true
		print("Moving to ", target_location)
	elif mob.position.distance_to(target_location) <= 200 and is_moving:
		mob.ship.add_thrust(mob.velocity, -1, 0)
		print("Arrived at destination ", target_location)
		target_location = null
		is_moving = false

