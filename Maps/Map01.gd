extends Node2D

var station_open = null
var dragged_slot
var dragged_slot_data

func _ready():
	GameInstance.current_map = self
	station_pop_up($Station)


func station_pop_up(station):
	if not station_open:
		var StationMenu = load("res://UI/Station/StationMain.tscn")
		var station_menu = StationMenu.instance()
		station_menu.initialize(station)
		add_child(station_menu)
		station_open = station_menu


func _input(event):
	if event.is_action_released("left click"):
		if dragged_slot:
			var timer = Timer.new()
			timer.set_one_shot(true)
			timer.set_wait_time(0.2)
			timer.autostart = true
			timer.connect("timeout", self, "_timer_drop_callback", [timer])
			add_child(timer)


func start_dragging(slot_data):
	dragged_slot = slot_data["slot"]
	dragged_slot_data = slot_data


func stop_dragging():
	dragged_slot_data = null
	dragged_slot = null


func swap(slot_data):
	slot_data["slot"].texture = dragged_slot_data["texture"]
	slot_data["slot"].item_data = dragged_slot_data["item_data"]
	dragged_slot.texture = slot_data["texture"]
	dragged_slot.item_data = slot_data["item_data"]
	
	stop_dragging()


func cancel_drag():
	if dragged_slot:
		dragged_slot.texture = dragged_slot_data["texture"]
		stop_dragging()


func _timer_drop_callback(timer):
	cancel_drag()
	timer.queue_free()
