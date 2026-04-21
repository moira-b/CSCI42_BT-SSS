extends GutTest
const WEAPON_PATH = "res://Resources/Equipment/weapons.json"
const ARMOR_PATH = "res://Resources/Equipment/armor.json"
var Character = preload("res://Scripts/Character/Character.gd")
var character: Character

func before_each():
	character = autofree(Character.new())
	character.character_class = load("res://Resources/Classes/Rogue/rogue.tres")
	add_child(character)
	await get_tree().process_frame

func after_each() -> void:
	pass

func test_max_level():
	# this test will pass because 1 does equal 1
	assert_eq(character.max_level, 10, "Character's max level should be 10.")

func test_character_class():
	var char_class = character.character_class.name
	assert_true(char_class == "Rogue")

func test_invalid_level():
	var invalid_lvl = character.set_level(-1)
	assert_false(invalid_lvl)
	invalid_lvl = character.set_level(12)
	assert_false(invalid_lvl)

func test_level_update_proficiency():
	var valid_lvl = character.set_level(2)
	assert_true(valid_lvl)
	assert_eq(character.proficiency, 1)
	valid_lvl = character.set_level(5)
	assert_true(valid_lvl)
	assert_eq(character.proficiency, 2)
	valid_lvl = character.set_level(8)
	assert_true(valid_lvl)
	assert_eq(character.proficiency, 3)

func test_max_hope():
	var max_hope = character.max_hope
	assert_eq(max_hope, 6, "Max hope must be 6")	

func test_invalid_hope():
	var invalid_hope = character.set_current_hope(-1)
	assert_false(invalid_hope)
	invalid_hope = character.set_current_hope(7)
	assert_false(invalid_hope)

func test_iterate_through_hope():
	var valid_hope = character.set_current_hope(0)
	var i: int = 0
	while(valid_hope):
		valid_hope = character.set_current_hope(i)
		i += 1
	assert_eq(character.current_hope, 6)
	
func test_max_stress():
	character.set_maximum_stress()
	var max_stress = character.max_stress
	assert_eq(max_stress, 6, "Max stress must be 6")

func test_invalid_stress():
	character.set_maximum_stress()
	var max_stress = character.max_stress
	var invalid_stress = character.set_current_stress(-1)
	assert_false(invalid_stress)
	invalid_stress = character.set_current_stress(max_stress+1)
	assert_false(invalid_stress)

func test_iterate_through_stress():
	character.set_maximum_stress()
	var max_stress = character.max_stress
	var valid_stress = character.set_current_stress(0)
	var i: int = 0
	while(valid_stress):
		valid_stress = character.set_current_stress(i)
		i += 1
	assert_eq(character.current_stress, max_stress)
	
func test_base_armor():
	character.set_maximum_armor_slots()
	var max_armor = character.max_armor_slots
	assert_true(max_armor == 0, "Base Max Armor must be 0")

func test_invalid_armor():
	character.set_maximum_armor_slots()
	var max_armor = character.max_armor_slots
	var invalid_armor= character.set_used_armor_slots(-1)
	assert_false(invalid_armor)
	invalid_armor = character.set_used_armor_slots(max_armor+1)
	assert_false(invalid_armor)

func test_iterate_through_armor():
	character.set_maximum_armor_slots()
	var max_armor = character.max_armor_slots
	var valid_armor = character.set_used_armor_slots(0)
	var i: int = 0
	while(valid_armor):
		valid_armor = character.set_used_armor_slots(i)
		i += 1
	assert_eq(character.used_armor_slots, max_armor)


func test_equipment_armor():
	character.items = ["","",""]
	var armors:Array[String] = ["Gambeson Armor","Leather Armor","Chainmail Armor","Full Plate Armor"]
	for armor in armors:
		character.equip_armor(armor)
		assert_eq(character.items[0], armor, "Character must have equipped the armor")
		
		character.unequip_armor(armor)
		assert_eq(character.items[0],"","Character's armor slot must be empty")


func test_equipment_damage_thresholds():
	character.items = ["","",""]
	var armors:Array[String] = ["Gambeson Armor","Leather Armor","Chainmail Armor","Full Plate Armor"]
	for armor in armors:
		var armor_as_text = FileAccess.get_file_as_string(ARMOR_PATH)
		var armor_as_dict = JSON.parse_string(armor_as_text)
		character.equip_armor(armor)
		var valid_armor: int = armor_as_dict.get(armor).get("major_threshold") + 1
		assert_eq(character.damage_thresholds[0],valid_armor,"Character must have the same major threshold as the armor")
		valid_armor = armor_as_dict.get(armor).get("severe_threshold") + 1
		assert_eq(character.damage_thresholds[1],valid_armor,"Character must have the same severe threshold as the armor")
				
		character.unequip_armor(armor)
		
		assert_eq(character.damage_thresholds[0],1,"Character's major threshold must equal the level(1)")
		assert_eq(character.damage_thresholds[0],1,"Character's severe threshold must equal the level(1)")
		

func test_equipment_weapons():
	character.items = ["","",""]
	var weapons:Array[String] = ["Broadsword","Longsword","Dagger","Battleaxe"]
	for weapon in weapons:
		character.equip_primary(weapon)
		assert_eq(character.items[1], weapon, "Character must have equipped the weapon")
		
		character.unequip_primary(weapon)
		assert_eq(character.items[1],"","Character must have unequipped the weapon")
		

func test_equipment_secondary_weapons():
	character.items = ["","",""]
	var weapons:Array[String] = ["Shortsword","Round Shield","Tower Shield","Small Dagger"]
	for weapon in weapons:
		character.equip_secondary(weapon)
		assert_eq(character.items[2], weapon, "Character must have equipped the weapon")
		
		character.unequip_secondary(weapon)
		assert_eq(character.items[2],"","Character must have unequipped the weapon")


func test_equipment_armor_score():
	character.items = ["","",""]
	var armors:Array[String] = ["Gambeson Armor","Leather Armor","Chainmail Armor","Full Plate Armor"]
	character.set_maximum_armor_slots()
	for armor in armors:
		var armor_as_text = FileAccess.get_file_as_string(ARMOR_PATH)
		var armor_as_dict = JSON.parse_string(armor_as_text)
		character.equip_armor(armor)
		var valid_armor: int = armor_as_dict.get(armor).get("base_score")
		assert_eq(character.max_armor_slots,valid_armor,"Character must have the same max armor slots as the armor")
		
		character.unequip_armor(armor)
		
		assert_eq(character.max_armor_slots,0,"Character must have no armor")


func test_set_initial_max_health():
	var classes: Array[CharacterClass] = [
	load("res://Resources/Classes/Bard/bard.tres"), 
	load("res://Resources/Classes/Druid/druid.tres"),
	load("res://Resources/Classes/Guardian/guardian.tres"),
	load("res://Resources/Classes/Ranger/ranger.tres"),
	load("res://Resources/Classes/Rogue/rogue.tres"),
	load("res://Resources/Classes/Seraph/seraph.tres"),
	load("res://Resources/Classes/Warrior/warrior.tres"),
	load("res://Resources/Classes/Wizard/wizard.tres")]
	
	for character_class in classes:
		character.character_class = character_class
		character.set_maximum_health()
		var max_health = character.max_hp
		assert_eq(max_health, character_class.starting_hp, "Max health should be the same as " + character_class.name)
		# test invalid health values
		var invalid_health = character.set_current_health(13)
		assert_false(invalid_health)
		invalid_health = character.set_current_health(-1)
		assert_false(invalid_health)
		# test valid health values
		var valid_health = character.set_current_health(0)
		var i: int = 0
		while(valid_health):
			valid_health = character.set_current_health(i)
			i += 1
		assert_eq(character.current_hp, max_health)
	
func test_set_invalid_hp_high():
	character.set_maximum_health()
	var max_health = character.max_hp
	# test invalid health values
	var invalid_health = character.set_current_health(max_health + 1)
	assert_false(invalid_health)

func test_set_invalid_hp_low():
	character.set_maximum_health()
	# test invalid health values
	var invalid_health = character.set_current_health(-1)
	assert_false(invalid_health)
	
func test_iterate_through_hp():
	var classes: Array[CharacterClass] = [
	load("res://Resources/Classes/Bard/bard.tres"), 
	load("res://Resources/Classes/Druid/druid.tres"),
	load("res://Resources/Classes/Guardian/guardian.tres"),
	load("res://Resources/Classes/Ranger/ranger.tres"),
	load("res://Resources/Classes/Rogue/rogue.tres"),
	load("res://Resources/Classes/Seraph/seraph.tres"),
	load("res://Resources/Classes/Warrior/warrior.tres"),
	load("res://Resources/Classes/Wizard/wizard.tres")]
	
	for character_class in classes:
		character.character_class = character_class
		character.set_maximum_health()
		var max_health = character.max_hp
		var valid_health = character.set_current_health(0)
		var i: int = 0
		while(valid_health):
			valid_health = character.set_current_health(i)
			i += 1
		assert_eq(character.current_hp, max_health)
		
		
func test_ancestries():
	character.ancestry = load("res://Resources/Ancestries/Elf/elf.tres")
	character.implement_ancestry_features()
	assert_eq(character.num_downtime_moves,3,"Elves must gain an additional downtime move")
	
	character.ancestry = load("res://Resources/Ancestries/Human/human.tres")
	character.set_maximum_stress()
	character.implement_ancestry_features()
	assert_eq(character.max_stress,7,"Humans must gain an additional stress")
	
	character.ancestry = load("res://Resources/Ancestries/Giant/giant.tres")
	character.set_maximum_health()
	character.implement_ancestry_features()
	assert_eq(character.max_hp,7,"Giants must gain an additional hitpoint")
	
	
