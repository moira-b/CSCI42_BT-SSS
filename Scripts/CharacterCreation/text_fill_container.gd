extends Container

var line_edit_array: Array[LineEdit]

var character: Character

func _ready() -> void:
	for child in self.get_children():
		line_edit_array.append(child.get_node("LineEdit"))
	
	character = self.get_parent().get_parent().get_node("Character")

func is_all_textboxes_filled() -> bool:
	var complete = 0
	for line_edit in line_edit_array:
		if line_edit.text != "":
			complete += 1
	
	if complete == line_edit_array.size():
		return true
	else:
		return false


func _on_confirm_button_pressed() -> void:
	if self.name == "ExperiencesContainer":
		character.experiences[0] = line_edit_array[0].text
		character.experiences[1] = line_edit_array[1].text


func _on_complete_button_pressed() -> void:
	if self.name == "NamePronounContainer":
		character.character_name = line_edit_array[0].text
		character.pronouns = line_edit_array[1].text
