extends GutTest

var Character = preload("res://Scripts/Character/Character.gd")
var character: Character
var SaveManager = preload("res://Scripts/SheetManagement/save_manager.gd")
var save_manager

func before_each():
	character = autofree(Character.new())
	character.set_maximum_health()
	character.set_maximum_armor_slots()
	character.set_maximum_stress()
	character.character_name = "Quian"
	character.character_class = load("res://Resources/Classes/Rogue/rogue.tres")
	character.subclass = load("res://Resources/Classes/Rogue/Nightwalker/nightwalker.tres")
	character.ancestry = load("res://Resources/Ancestries/Ribbet/ribbet.tres")
	character.community = load("res://Resources/Communities/loreborne.tres")

	save_manager = autofree(SaveManager.new())
	save_manager.set_character(character)
	add_child(save_manager)

	await get_tree().process_frame

func after_each():
	pass

func test_has_character():
	assert_not_null(save_manager.character)

func test_existing_filepath():
	assert_true(save_manager.save_file_exists())

func test_pk_count():
	var json_data = save_manager._get_character_data()
	var i = 0
	for key in json_data:
		if key != "pk_count": 
			i += 1
	var num_chars = int(json_data["pk_count"])
	print(num_chars)
	assert_eq(num_chars, i)

func test_save_character():
	var json_data = save_manager._get_character_data()
	var before_pk = int(json_data["pk_count"])
	save_manager.save_character_data()
	json_data = save_manager._get_character_data()
	var new_character_made = false;
	
	for key in json_data:
		if key != "pk_count":
			if json_data[key]["character_name"] == "Quian":
				new_character_made = true
	assert_true(new_character_made)
	
func test_load_data():
	var char_dict = save_manager._get_character_dictionary("1")
	save_manager.character.load_data(char_dict)
	var correct_name = str(save_manager.character.character_name) == char_dict["character_name"]
	var correct_agility = int(save_manager.character.agility) == char_dict["agility"]
	assert_true(correct_name)
	assert_true(correct_agility)
