extends RayCast2D

export (int) var vision_angle = 90
export (int) var vision_max_distance = 2000


func get_percieved_actors(mob):
	var perceived_actors = []
	var facing = mob.transform.x
	var mob_to_player = mob.position.direction_to(GameInstance.player.position)
	if mob.position.distance_to(GameInstance.player.position) <= vision_max_distance:
		print(acos(mob_to_player.normalized().dot(facing)))
		if acos(mob_to_player.normalized().dot(facing)) <= PI / (360 / vision_angle):
			print("I see you !")
	
	
	return perceived_actors


