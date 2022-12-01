extends RayCast2D

export (int) var vision_angle = 90
export (int) var vision_max_distance = 2000
export (bool) var is_active = true
export (float) var interval = 1.0

var currently_perceived_actors = []
var perceived_actors = {}
var last_tick = 0.0
var time_history = 30


func update_perception(mob):
	currently_perceived_actors = []
	var facing = mob.transform.x
	var mob_to_player = mob.position.direction_to(GameInstance.player.position)
	if mob.position.distance_to(GameInstance.player.position) <= vision_max_distance:
		if acos(mob_to_player.normalized().dot(facing)) <= PI / (360 / vision_angle):
			currently_perceived_actors.append(GameInstance.player)
			perceived_actors[currently_perceived_actors[0]] = {
				"time": last_tick, "position": currently_perceived_actors[0].position 
				}
	
	for actor in perceived_actors:
		if last_tick - perceived_actors[actor]["time"] >= time_history:
			perceived_actors.erase(actor)
