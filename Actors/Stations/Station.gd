extends Area2D

export var station_name = "Station A"
var station_image = load("res://Assets/Stations/station.png")
var map_icon = "station"

var inventory = [
	"Engine", "Gun", "Gun", "Engine", "Battery", "Engine", "Gun", "Gun", "Engine", "Battery"
]


func _ready():
	$SpriteLight.modulate = Color8(51, 255, 51)


func _on_Station_body_entered(body):
	if body.has_method("enter_station"):
		$CollisionShape2D.set_deferred("disabled", true)
		body.enter_station(self)
		get_parent().station_pop_up(self)
		$SpriteLight.modulate = Color8(255, 0, 0)


func activate_collision():
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer.autostart = true
	timer.connect("timeout", self, "_timer_reopen_callback", [timer])
	add_child(timer)


func _on_item_bought(item):
	#StationMain call it through signal emitted in LeftTabContainer
	if item[0]["name"] in inventory:
		inventory.erase(item[0]["name"])



func _timer_reopen_callback(timer):
	$CollisionShape2D.disabled = false
	$SpriteLight.modulate = Color8(51, 255, 51)
	timer.queue_free()




