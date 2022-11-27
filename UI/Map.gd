extends NinePatchRect

onready var original_pos_x = rect_position.x
onready var station_marker = $StationMarker
onready var enemy_marker = $EnemyMarker
onready var icons = {"station": station_marker, "enemy": enemy_marker}

var tween
var markers = {}
var grid_scale
var zoom = 5


func _ready():
	grid_scale = rect_size / (get_viewport_rect().size * zoom)
	update_map()
	tween.interpolate_property(self, "rect_position:x", 
		original_pos_x, 1200, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func _process(delta):
	for item in markers:
		var obj_pos = (item.position - GameInstance.player.position) * grid_scale + rect_size / 2
		obj_pos.x = clamp(obj_pos.x, 0, rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, rect_size.y)
		markers[item].position = obj_pos


func update_map():
	var map_objects = get_tree().get_nodes_in_group("pov")
	for item in map_objects:
		var marker = icons[item.map_icon].duplicate()
		add_child(marker)
		marker.show()
		markers[item] = marker

