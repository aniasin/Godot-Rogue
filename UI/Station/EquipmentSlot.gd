extends TextureRect

onready var root_node = GameInstance.current_map
export (int) var slot_id = 0
export (PoolStringArray) var slots_forbiden
export (bool) var is_equipable = false

var tooltip
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
	root_node.start_dragging(self)
	set_drag_preview(draged_preview)
	texture = empty_texture
	return {"slot": self, "texture": draged_preview.texture}


func can_drop_data(_pos, _slot_data):
	return slot_id != null


func drop_data(_pos, slot_data):
	var old_texture = texture
	var other_slot = slot_data["slot"]
	if other_slot.item_data["type"] in slots_forbiden:
		root_node.cancel_drag()
		return
	if old_texture != empty_texture:
		if parent_window and other_slot.parent_window and parent_window != other_slot.parent_window:
			root_node.cancel_drag()
			return
		root_node.swap(self)
	else:
		if parent_window and other_slot.parent_window and not parent_window.action(other_slot, self):
			root_node.cancel_drag()
			return
		texture = slot_data["texture"]
		item_data = other_slot.item_data
		slot_name = other_slot.item_data["type"]
		other_slot.texture = empty_texture
		other_slot.slot_name = "none"
		other_slot.item_data = null
		root_node.stop_dragging()
	if is_equipable:
		GameInstance.current_ship.equip_slot(slot_id, item_data)



func _on_InventorySlot_mouse_entered():
	if item_data:
		var Tooltip = load("res://UI/Station/ToolTip.tscn")
		tooltip = Tooltip.instance()
		tooltip.set_text(item_data)
		get_parent().get_parent().get_parent().add_child(tooltip)
		tooltip.rect_position = get_parent().get_parent().get_parent().get_local_mouse_position()


func _on_InventorySlot_mouse_exited():
	if tooltip:
		tooltip.hide()
		tooltip.queue_free()
		tooltip = null
