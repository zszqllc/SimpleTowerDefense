extends PanelContainer

func _get_drag_data(position):
	if get_child(0) != null:
		
		var txt     = TextureRect.new()
		txt.texture = get_node("DELETE").texture
		set_drag_preview(txt)
		
		return get_child(0)
	return false

func _can_drop_data(position, data):
	if get_child(0) and data == get_child(0):
		return true
	return false

func _drop_data(position, data):
	if data and get_child(0) == null:
		data.get_parent().remove_child(data)
		self.add_child(data)

