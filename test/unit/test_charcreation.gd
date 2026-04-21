extends GutTest

var Character = preload("res://Scripts/Character/Character.gd")
var character: Character
var creator_scene = load("res://Scenes/CharacterCreator/character_creator_interface.tscn")
var class_rogue = load("res://Resources/Classes/Rogue/rogue.tres")
var creator_interface

func before_each():
	character = autofree(Character.new())
	creator_interface = creator_scene.instantiate()
	creator_interface.character = character
	add_child_autofree(creator_interface)
	
func test_init():
	assert_eq(creator_interface.option_tab_index, 0)
	assert_eq(creator_interface.confirm_button.disabled, true)
	assert_eq(creator_interface.back_button.disabled, true)
	assert_eq(creator_interface.back_button.visible, false)
	assert_eq(creator_interface.complete_button.disabled, true)
	assert_eq(creator_interface.complete_button.visible, false)
	assert_gt(creator_interface.option_tab_array.size(), 0)
	

func test_signal_connections():
	for button in creator_interface.tab_buttons:
		assert_connected(button.pressed, creator_interface._on_tab_button_pressed)
		
	assert_connected(creator_interface.pd_window.closing, creator_interface._on_pd_window_closing)
	

func test_all_option_tabs():
	creator_interface.character.character_class = class_rogue
	# Check if dependent tabs are visible
	for button in creator_interface.tab_buttons:
		button.pressed.emit()
		assert_eq(button.visible, true)
	
	# Check if current tab is set properly
	for button in creator_interface.tab_buttons:
		button.pressed.emit()
		var current_active = creator_interface.active_option_tab
		assert_eq(current_active, creator_interface.option_tab_array[creator_interface.option_tab_index])
