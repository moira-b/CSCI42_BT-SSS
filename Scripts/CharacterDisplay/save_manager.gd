extends Node2D

@onready var character = self.get_parent().character
const file_path = "user://character_data"


func save_character_data():
	var save_file = FileAccess.open(file_path, FileAccess.WRITE)
	
	# get serialized data from the character
	
	if character.has_method("serialize_data"):
		var character_data = character.call("serialize_data")
		print(character_data)
		var json_string = JSON.stringify(character_data, "\t")
		save_file.store_line(json_string)
	else:
		print("Error. The node does not have a method for data serialization.")


func load_character_data():
	pass
