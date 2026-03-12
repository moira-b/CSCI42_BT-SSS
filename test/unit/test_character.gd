extends GutTest

var Character = preload("res://Scripts/Character/Character.gd")
var character: Character

func before_each():
	character = autofree(Character.new())
	add_child(character)
	await get_tree().process_frame

func after_each() -> void:
	pass

class TestLevel:
	extends GutTest
	
	var Character = preload("res://Scripts/Character/Character.gd")
	var character: Character
	
	func before_each():
		character = autofree(Character.new())
		add_child(character)
		await get_tree().process_frame

	func after_each() -> void:
		pass

	func test_max_level():
		# this test will pass because 1 does equal 1
		assert_eq(character.max_level, 10, "Character's max level should be 10.")

	func test_set_level_valid():
		var valid_lvl = character.set_level(7)
		assert_true(valid_lvl)

	func test_set_level_too_low():
		var invalid_lvl = character.set_level(-1)
		assert_false(invalid_lvl)

	func test_set_level_too_high():
		var invalid_lvl = character.set_level(12)
		assert_false(invalid_lvl)

class TestHope:
	extends GutTest
	
	var Character = preload("res://Scripts/Character/Character.gd")
	var character: Character
	
	func before_each():
		character = autofree(Character.new())
		add_child(character)
		await get_tree().process_frame

	func after_each() -> void:
		pass
		
	func test_max_hope():
		var max_hope = character.max_hope
		assert_eq(max_hope, 6, "Max hope must be 6")
