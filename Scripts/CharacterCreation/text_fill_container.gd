extends Container

@onready var name_edit = $"../NamePronounContainer/NameContainer/LineEdit"
var line_edit_array: Array[LineEdit]
var character: Character
var current_name = ""

func _ready() -> void:
	for child in self.get_children():
		line_edit_array.append(child.get_node("LineEdit"))
	
	character = self.get_parent().get_parent().get_node("Character")
	name_edit.text_submitted.connect(_validate_name)
	name_edit.focus_exited.connect(_validate_name)

func is_all_textboxes_filled() -> bool:
	var complete = 0
	for line_edit in line_edit_array:
		if line_edit.text != "":
			complete += 1
	
	if complete == line_edit_array.size():
		return true
	else:
		return false
		
func _validate_name():
	if name_edit.text=="":
		print("Invalid name submitted. Character name should not be blank.")
		name_edit.text = current_name
		return

	if len(name_edit.text) > 64:
		print("Invalid name submitted. Character name should not exceed 64 characters.")
		name_edit.text = current_name
		return
		
	current_name = name_edit.text

func _on_confirm_button_pressed() -> void:
	if self.name == "ExperiencesContainer":
		character.experiences[0] = line_edit_array[0].text
		character.experiences[1] = line_edit_array[1].text


func _on_complete_button_pressed() -> void:
	if self.name == "NamePronounContainer":
		character.character_name = line_edit_array[0].text
		character.pronouns = line_edit_array[1].text
