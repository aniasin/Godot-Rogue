extends Node2D

onready var timer = $TimerFireRate


func activate(_layer, _mask):
	$Thrust.emitting = true
	timer.set_wait_time(1)
	timer.start()
	
func _on_TimerFireRate_timeout():
	$Thrust.emitting = false
