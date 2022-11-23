extends TextureRect

onready var root_node = get_tree().root.get_child(0)
var empty_texture = load("res://UI/Station/Assets/slot.png")


func get_drag_data(_pos):
	if texture == empty_texture:
		return null	
	root_node.start_dragging(self, texture)
	# Use another texture rect as drag preview.
	var draged_preview = TextureRect.new()
	draged_preview.texture = texture
	set_drag_preview(draged_preview)
	texture = empty_texture
	# Return texture as drag data.
	return draged_preview.texture


func can_drop_data(_pos, data):
	return data != null


func drop_data(_pos, data):
	var old_texture = texture
	if old_texture == empty_texture:
		texture = data
		root_node.stop_dragging()
	else:
		root_node.swap(self, texture)
