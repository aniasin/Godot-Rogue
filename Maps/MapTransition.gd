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
		print("Entering map transition...")
		$Timer.start()
	if body.has_method("out_of_boundary"):
		body.out_of_boundary()


func travel():
	GameInstance.save_game()
	GameInstance.transition_id = destination_id
	var _new_scene = get_tree().change_scene(map_destination)


func arrival():
	$Transition.to_black = false
	$Transition.activate()


func _on_Timer_timeout():
	$Transition.to_black = true
	$Transition.activate()

