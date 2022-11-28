extends TextureRect

onready var root_node = GameInstance.current_map
export (int) var slot_id = 0
export (PoolStringArray) var slots_forbiden
export (bool) var is_equipable = false

var tooltip
var parent_window
var item_data
var empty_texture = load("res://UI/Station/Assets/slot.png")


func _ready():
	if item_data:
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
	return true


func drop_data(_pos, slot_data):
	var old_texture = texture
	var other_slot = slot_data["slot"]
	if other_slot.item_data["type"] in slots_forbiden:
		root_node.cancel_drag()
		return
	if old_texture != empty_texture:
		root_node.cancel_drag()
		return
	if parent_window.is_commercial and other_slot.parent_window.is_commercial and not parent_window.sell_buy(other_slot, self):
		root_node.cancel_drag()
		return

	if is_equipable:
		if not GameInstance.current_ship.equip_slot(slot_id, other_slot.item_data):
			root_node.cancel_drag()
			return
		parent_window.update_ship_stats()
		if other_slot.is_equipable:
			GameInstance.current_ship.remove_slot(other_slot.slot_id)
			parent_window.update_ship_stats()
		
	if not is_equipable and other_slot.is_equipable:
		if not GameInstance.current_ship.unequip_slot(other_slot.slot_id):
			root_node.cancel_drag()
			return
		other_slot.parent_window.update_ship_stats()
		
	texture = slot_data["texture"]
	item_data = other_slot.item_data
	other_slot.texture = empty_texture
	other_slot.item_data = null
	root_node.stop_dragging()


func _on_InventorySlot_mouse_entered():
	if item_data and not tooltip:
		var Tooltip = load("res://UI/Station/ToolTip.tscn")
		tooltip = Tooltip.instance()
		tooltip.set_text(item_data)
		$Timer.start()


func _on_InventorySlot_mouse_exited():
	if tooltip:
		tooltip.hide()
		tooltip.queue_free()
		tooltip = null
		$Timer.stop()


func _on_Timer_timeout():
	#TODO clean this shit
	var owning_window = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()
	owning_window.add_child(tooltip)
	tooltip.rect_position = owning_window.get_local_mouse_position()
