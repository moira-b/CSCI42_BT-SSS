extends Container

var text_container_array: Array[Control]

func _ready() -> void:
	for child in self.get_children():
		text_container_array.append(child)

func is_all_textboxes_filled() -> bool:
	var complete = 0
	for text_container in text_container_array:
		var text_edit:LineEdit = text_container.get_node("LineEdit")
		if text_edit.text != "":
			complete += 1
	
	if complete == text_container_array.size():
		return true
	else:
		return false
