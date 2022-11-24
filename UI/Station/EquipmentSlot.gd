extends TextureRect

onready var root_node = GameInstance.current_map
export (int) var slot_id = 0
export (PoolStringArray) var slots_forbiden
export (bool) var is_equipable = false

var parent_window
var slot_name = "none"
var item_data
var empty_texture = load("res://UI/Station/Assets/slot.png")


func _ready():
	if item_data:
		slot_name = item_data["type"]
		texture = load(item_data["icon"])


func get_drag_data(_pos):
	if texture == empty_texture:
		return null

	var draged_preview = TextureRect.new()
	draged_preview.texture = texture
	root_node.start_dragging({"slot": self, "name": slot_name, "texture": draged_preview.texture, 
								"item_data": item_data})
	set_drag_preview(draged_preview)
	texture = empty_texture
	# Return texture  and slot_name as drag data.
	return {"slot": self, "name": slot_name, "texture": draged_preview.texture, "item_data": item_data}


func can_drop_data(_pos, _slot_data):
	return true


func drop_data(_pos, slot_data):
	var old_texture = texture
	if slot_data["name"] in slots_forbiden:
		root_node.cancel_drag()
		return
	if old_texture != empty_texture:
		if parent_window and parent_window != slot_data["slot"].parent_window:
			root_node.cancel_drag()
			return
		root_node.swap({"slot": self, "name": slot_name, "texture": texture, "item_data": slot_data["item_data"]})
	else:
		if parent_window and not parent_window.action(slot_data["slot"], self):
			root_node.cancel_drag()
			return
		texture = slot_data["texture"]
		item_data = slot_data["item_data"]
		slot_name = slot_data["name"]
		slot_data["slot"].texture = empty_texture
		slot_data["slot"].slot_name = "none"
		slot_data["slot"].item_data = null
		root_node.stop_dragging()
	if is_equipable:
		GameInstance.current_ship.unequip_slot(slot_data["slot"].slot_id)
		GameInstance.current_ship.equip_slot(slot_id, item_data)

