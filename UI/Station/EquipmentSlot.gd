extends TextureRect

onready var root_node = GameInstance.current_map
export (PoolStringArray) var slots_forbiden

var slot_name = "none"
var empty_texture = load("res://UI/Station/Assets/slot.png")


func get_drag_data(_pos):
	if texture == empty_texture:
		return null	

	var draged_preview = TextureRect.new()
	draged_preview.texture = texture
	root_node.start_dragging({"slot": self, "name": slot_name, "texture": draged_preview.texture})
	set_drag_preview(draged_preview)
	texture = empty_texture
	# Return texture  and slot_name as drag data.
	return {"slot": self, "name": slot_name, "texture": draged_preview.texture}


func can_drop_data(_pos, slot_data):
	return true


func drop_data(_pos, slot_data):
	var old_texture = texture
	if slot_data["name"] in slots_forbiden:
		root_node.cancel_drag()
		return
	if old_texture == empty_texture:
		texture = slot_data["texture"]
		slot_name = slot_data["name"]
		slot_data["slot"].texture = empty_texture
		slot_data["slot"].slot_name = "none"
		root_node.stop_dragging()
	else:
		root_node.swap({"slot": self, "name": slot_name, "texture": texture})
