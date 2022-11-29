extends Area2D

export (String) var map_destination
export (int) var transition_id

onready var spawn_location = $Position2D.get_global_position()

var destination_id


func _ready():
	match transition_id:
		0:
			destination_id = 2
		1:
			destination_id = 3
		2:
			destination_id = 0
		3:
			destination_id = 1


func _on_MapTransition_body_entered(body):
	if body.has_method("enter_station"):
		$Timer.start()


func _on_MapTransition_body_exited(body):
	if body.has_method("enter_station"):
		$Timer.stop()


func _on_Timer_timeout():
	GameInstance.save_game()
	GameInstance.transition_id = destination_id
	var _new_scene = get_tree().change_scene(map_destination)
