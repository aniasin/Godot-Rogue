extends NinePatchRect


func _ready():
	var timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(.5)
	timer.autostart = true
	timer.connect("timeout", self, "_timer_refresh_callback")
	add_child(timer)


func _timer_refresh_callback():
	$ProgressBarBooster.value = GameInstance.current_ship.booster_state
	


func _on_ButtonInventory_pressed():
	GameInstance.player.toggle_inventory()


func _on_ButtonMap_pressed():
	GameInstance.player.toggle_map()


func _on_Buttonship_pressed():
	GameInstance.player.toggle_ship()
