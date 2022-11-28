extends Area2D

export (String) var encounter_name
export (int) var number

onready var positions = [$Position2D1, $Position2D2, $Position2D3, $Position2D4]

var encounter_data


func _ready():
	encounter_data = GameInstance.encounters[encounter_name]


func _on_MobSpawner_body_entered(body):
	if body.has_method("enter_station"):
		call_deferred("spawn_mob")
		$Timer.start()


func spawn_mob():
	if not $CollisionShape2D.disabled:
		$CollisionShape2D.disabled = true
	if number > 0:
		var i = number % positions.size()
		var mob = load(encounter_data["path"]).instance()
		mob.set_position(positions[i].get_position())
		mob.set_rotation(get_rotation())
		GameInstance.current_map.add_child(mob)
		number -= 1
	else:
		$Timer.stop()
		queue_free()


func _on_Timer_timeout():
	spawn_mob()
