extends Node2D

var station_open = null
var dragged_slot


func _ready():
	GameInstance.current_map = self
	station_pop_up($Station)


func station_pop_up(station):
	if not station_open:
		var StationMenu = load("res://UI/Station/StationMain.tscn")
		var station_menu = StationMenu.instance()
		station_menu.initialize(station)
		add_child(station_menu)
		station_open = station
		station_menu.connect("station_quit", self, "_on_station_quit")


func _on_station_quit():
	station_open.activate_collision()
	station_open = null


func _input(event):
	if event.is_action_released("left click"):
		if dragged_slot:
			var timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_wait_time(0.2)
			timer.autostart = true
			timer.connect("timeout", self, "_timer_drop_callback", [timer])
			add_child(timer)


func start_dragging(slot):
	dragged_slot = slot


func stop_dragging():
	dragged_slot = null


func swap(slot):
	var dragged_texture = slot.texture
	var dragged_data = slot.item_data
	slot.texture = load(dragged_slot.item_data["icon"])
	slot.item_data = dragged_slot.item_data
	dragged_slot.texture = dragged_texture
	dragged_slot.item_data = dragged_data
	stop_dragging()


func cancel_drag():
	if dragged_slot:
		dragged_slot.texture = load(dragged_slot.item_data["icon"])
		stop_dragging()


func _timer_drop_callback(timer):
	cancel_drag()
	timer.queue_free()
