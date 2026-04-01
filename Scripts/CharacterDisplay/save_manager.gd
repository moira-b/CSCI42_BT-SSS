extends Node2D

@onready var character = self.get_parent().character
const FILE_PATH = "user://character_data"

func save_character_data():

	if !character.has_method("serialize_data"):
		print("Error. The node does not have a method for data serialization.")
		return
	
	# get serialized data from the character
	var character_data = character.call("serialize_data")
	var character_name = character_data["character_name"]
	
	# CASE 1: no file yet (i.e. first character)
	if !FileAccess.file_exists(FILE_PATH):
		var save_file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		var to_store = {
			character_name: character_data
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
		#if !(typeof(parse_result)==TYPE_DICTIONARY):
			#print("File format error. Contents of character_data do not comprise a dictionary.")
			#return
		
		print("CHECKPOINT 1")
		print(json.data)
		
		if character_name in json.data:
			print("Character exists, updating profile now")
			json.data[character_name] = character_data
		else:
			print("Character does not exist, creating profile now")
			json.data[character_name] = character_data
		save_file.store_line(JSON.stringify(json.data, "\t"))

		print("CHECKPOINT 2")
		print(json.data)
		save_file.close()

func _get_dictionary(json_data: Variant):
	pass

func load_character_data():
	pass
