extends GutTest

var Character = preload("res://Scripts/Character/Character.gd")
var character: Character

func before_each():
	character = autofree(Character.new())
	add_child(character)
	await get_tree().process_frame

func after_each() -> void:
	pass

func test_level():
	# this test will pass because 1 does equal 1
	assert_eq(character.max_level, 10, "Character's max level should be 10.")
	# test invalid levels
	var invalid_lvl = character.set_level(-1)
	assert_false(invalid_lvl)
	invalid_lvl = character.set_level(12)
	assert_false(invalid_lvl)
	# test valid levels and updates to proficiency
	var valid_lvl = character.set_level(2)
	assert_true(valid_lvl)
	assert_eq(character.proficiency_modifier, 1)
	valid_lvl = character.set_level(5)
	assert_true(valid_lvl)
	assert_eq(character.proficiency_modifier, 2)
	valid_lvl = character.set_level(8)
	assert_true(valid_lvl)
	assert_eq(character.proficiency_modifier, 3)

func test_hope():
	var max_hope = character.max_hope
	assert_eq(max_hope, 6, "Max hope must be 6")
	# test invalid hope values
	var invalid_hope = character.set_current_hope(-1)
	assert_false(invalid_hope)
	invalid_hope = character.set_current_hope(7)
	assert_false(invalid_hope)
	# test valid hope values
	var valid_hope = character.set_current_hope(0)
	var i: int = 0
	while(valid_hope):
		valid_hope = character.set_current_hope(i)
		i += 1
	assert_eq(character.current_hope, 6)
	
func test_stress():
	character.set_maximum_stress()
	var max_stress = character.max_stress
	assert_eq(max_stress, 12, "Max stress must be 12")
	# test invalid stress values
	var invalid_stress = character.set_current_stress(-1)
	assert_false(invalid_stress)
	invalid_stress = character.set_current_stress(max_stress+1)
	assert_false(invalid_stress)
	# test valid stress values
	var valid_stress = character.set_current_stress(0)
	var i: int = 0
	while(valid_stress):
		valid_stress = character.set_current_stress(i)
		i += 1
	assert_eq(character.current_stress, max_stress)
	
func test_armor():
	character.set_maximum_armor_slots()
	var max_armor = character.max_armor_slots
	assert_eq(max_armor, 12, "Max armor must be 12")
	# test invalid stress values
	var invalid_armor= character.set_used_armor_slots(-1)
	assert_false(invalid_armor)
	invalid_armor = character.set_used_armor_slots(max_armor+1)
	assert_false(invalid_armor)
	# test valid stress values
	var valid_armor = character.set_used_armor_slots(0)
	var i: int = 0
	while(valid_armor):
		valid_armor = character.set_used_armor_slots(i)
		i += 1
	assert_eq(character.used_armor_slots, max_armor)

func test_health():
	character.set_maximum_health()
	var max_health = character.max_hp
	assert_eq(max_health, 12, "Max health should be 12")
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
	
	
