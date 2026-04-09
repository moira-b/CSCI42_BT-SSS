extends Node2D

const FILE_PATH = "user://character_data"
var character = null

func set_character(character: Character):
	self.character = character

func save_character_data():
	# Verify that a character has already been assigned
	if (character==null):
		print("Error. Attempting to save character, but save manager does not have a reference to the character.")
		return
	
	# Verify that the node can serialize data
	# (which is only possible for nodes of type Character)
	if !character.has_method("serialize_data"):
		print("Error. The node does not have a method for data serialization.")
		return
	
	# CASE 1: no file yet (i.e. first character)
	if !FileAccess.file_exists(FILE_PATH):
		character.assign_primary_key(1)
		var character_data = character.call("serialize_data")
		var save_file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		var to_store = {
			"pk_count": 1,
			character.primary_key: character_data
		}
		save_file.store_line(JSON.stringify(to_store, "\t"))
		save_file.close()
	 
	# CASE 2: file already exxits
	else:
		var save_file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
		var current_contents = save_file.get_as_text()
		var json = JSON.new()
		
		# Check that the file contents can be parsed by JSON
		var parse_result = json.parse(current_contents)
		if !(parse_result==OK):
			print("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
			return
			
		# Check that the file contents can be made into a dictionary
		var json_data = json.data
		
		# CASE 2A: Editing existing character
		if (character.primary_key in json.data):
			print("Character exists, updating profile now")
			
		# Case 2B: Creating new character
		else:
			# make sure to handle primary keys
			json_data["pk_count"] += 1
			character.assign_primary_key(json_data["pk_count"])
			print("Character does not exist, creating profile now")
			
		var character_data = character.call("serialize_data")
		json.data[character.primary_key] = character_data
		save_file.store_line(JSON.stringify(json_data, "\t"))

		print("CHECKPOINT 2")
		#print(json.data)
		save_file.close()

func _get_character_dictionary(pk: String):
	var save_file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
	var current_contents = save_file.get_as_text()
	var json = JSON.new()
	
	# Check that the file contents can be parsed by JSON
	var parse_result = json.parse(current_contents)
	if !(parse_result==OK):
		print("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return
			
	# Check that the file contents can be made into a dictionary
	var json_data = json.data
	var char_dict = json_data[pk]
	return char_dict

func load_character_data():
	pass

func delete_character_data():
	# Verify that a character has already been assigned
	if (character==null):
		print("Error. Attempting to delete character, but save manager does not have a reference to the character.")
		return
	
	# Verify that the node can serialize data
	# (which is only possible for nodes of type Character)
	if !character.has_method("serialize_data"):
		print("Error. The node does not have a method for data serialization.")
		return
		
	var save_file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var current_contents = save_file.get_as_text()
	var json = JSON.new()
	save_file.close()
	
	# Check that the file contents can be parsed by JSON
	var parse_result = json.parse(current_contents)
	if !(parse_result==OK):
		print("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return

	var json_data = json.data
	if (character.primary_key in json.data):
		json_data.erase(character.primary_key)
		print(json.data)
		print("DEBUG: Removed character '" + character.character_name + "' from save file.")
	
	save_file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	save_file.store_line(JSON.stringify(json_data, "\t"))
	save_file.close()

func _get_character_data():
	var save_file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
	var current_contents = save_file.get_as_text()
	var json = JSON.new()
	
	# Check that the file contents can be parsed by JSON
	var parse_result = json.parse(current_contents)
	if !(parse_result==OK):
		print("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return
			
	# Check that the file contents can be made into a dictionary
	var json_data = json.data
	return json_data

func save_file_exists():
	return FileAccess.file_exists(FILE_PATH)
