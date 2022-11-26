extends NinePatchRect


func _ready():
	var timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(.5)
	timer.autostart = true
	timer.connect("timeout", self, "_timer_refresh_callback")
	add_child(timer)


func _timer_refresh_callback():
	$LabelSpeed.text = str(GameInstance.current_ship.engine_power)
	$LabelPower.text = str(GameInstance.current_ship.engine_consumption)
