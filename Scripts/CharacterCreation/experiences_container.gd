extends VBoxContainer

var experience_array: Array[HBoxContainer]

func _ready() -> void:
	for child in self.get_children():
		experience_array.append(child)

func is_all_textboxes_filled() -> bool:
	var complete = 0
	for experience_holder in experience_array:
		var text_edit:LineEdit = experience_holder.get_node("LineEdit")
		if text_edit.text != "":
			complete += 1
	
	if complete == experience_array.size():
		return true
	else:
		return false
