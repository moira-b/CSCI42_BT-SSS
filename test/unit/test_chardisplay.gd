extends GutTest

var Character = preload("res://Scripts/Character/Character.gd")
var character: Character
var CharDisplay = preload("res://Scenes/CharacterDisplay/character_sheet.tscn")
var SaveManager = preload("res://Scripts/SheetManagement/save_manager.gd")
var save_manager
var char_display

func before_each():
	character = autofree(Character.new())
	save_manager = autofree(SaveManager.new())
	char_display = CharDisplay.instantiate()
	char_display.character = character
	char_display.save_manager = save_manager
	add_child_autofree(char_display)
	char_display.connect_signals()
	

func test_window_visibility():
	assert_eq(char_display.dice_roll_window.visible, false)
	assert_eq(char_display.fh_roll_window.visible, false)
	assert_eq(char_display.levelup_confirmation_panel.visible, false)
	assert_eq(char_display.equipment_window.visible, false)
	assert_eq(char_display.rest_window.visible, false)
	assert_eq(char_display.advance_window.visible, false)


func test_signals():
	watch_signals(char_display)
	var markables = [char_display.health_field, char_display.stress_field,
		char_display.armor_field, char_display.hope_field]
	
	for t in char_display.all_traits:
		assert_connected(t.value_changed, char_display._on_trait_text_submitted)
		
	for m in markables:
		assert_connected(m.stat_increment_pressed, char_display._on_stat_increment_pressed)
		assert_connected(m.stat_decrement_pressed, char_display._on_stat_decrement_pressed)
		
	assert_connected(char_display.short_rest_button.pressed, char_display._on_short_rest_pressed)
	assert_connected(char_display.long_rest_button.pressed, char_display._on_long_rest_pressed)
	assert_connected(char_display.dice_button.pressed, char_display._on_dice_button_pressed)
	assert_connected(char_display.fearhope_button.pressed, char_display._on_fh_dice_button_pressed)
	assert_connected(char_display.rest_confirm_button.pressed, char_display._on_confirm_button_pressed)
	assert_connected(char_display.rest_window.close_requested, char_display._on_rest_window_close_requested)
	assert_connected(char_display.dice_roll_window.close_requested, char_display._on_dice_roll_window_close_requested)
	assert_connected(char_display.fh_roll_window.close_requested, char_display._on_fh_roll_window_close_requested)
	assert_connected(char_display.levelup_button.pressed, char_display._on_levelup_button_pressed)
	assert_connected(char_display.save_button.pressed, char_display.save_character)
	assert_connected(char_display.delete_button.pressed, char_display._on_delete_button_pressed)
	assert_connected(char_display.main_menu_button.pressed, char_display._on_main_menu_button_pressed)
	assert_connected(char_display.advance_window.advancements_confirmed, char_display.update_markable_fields)
	assert_connected(char_display.advance_window.advancements_confirmed, char_display.update_edit_fields)
	assert_connected(char_display.delete_button.pressed, char_display._on_delete_button_pressed)
	assert_connected(char_display.class_panel.mouse_entered, char_display._on_mouse_enter_class_panel)
	assert_connected(char_display.class_panel.mouse_exited, char_display._on_mouse_exit_header_panel)
	assert_connected(char_display.ancestry_panel.mouse_entered, char_display._on_mouse_enter_ancestry_panel)
	assert_connected(char_display.ancestry_panel.mouse_exited, char_display._on_mouse_exit_header_panel)
	assert_connected(char_display.community_panel.mouse_entered, char_display._on_mouse_enter_community_panel)
	assert_connected(char_display.community_panel.mouse_exited, char_display._on_mouse_exit_header_panel)
	assert_connected(char_display.experiences_container.exp_level_changed, char_display._on_exp_level_changed)
	#assert_connected(char_display.name_edit.focus_exited, char_display._on_name_edit_focus_exited)
	#assert_connected(char_display.name_edit.text_submitted, char_display._on_name_edit_text_submitted)
	


func test_line_edit_functions():
	var name_field = char_display.name_edit
	var pronouns_field = char_display.pronouns_field
	var exp_1 = char_display.experience1
	var exp_2 = char_display.experience2
	var exp_3 = char_display.experience3
	var exp_4 = char_display.experience4
	var exp_5 = char_display.experience5
	
	var all_fields = [name_field, pronouns_field, 
		exp_1, exp_2, exp_3, exp_4, exp_5]
		
	for f in all_fields:
		f.text_submitted.emit("abc123")
	
	var char_name = char_display.character.character_name
	var char_pro = char_display.character.pronouns
	var char_ex_1 = char_display.character.experiences[0]
	var char_ex_2 = char_display.character.experiences[1]
	var char_ex_3 = char_display.character.experiences[2]
	var char_ex_4 = char_display.character.experiences[3]
	var char_ex_5 = char_display.character.experiences[4]
	
	var all_char_attrib = [char_name, char_pro,
		char_ex_1, char_ex_2, char_ex_3, char_ex_4, char_ex_5]
	
	for a in all_char_attrib:
		assert_eq(a, "abc123")
		

func test_text_box_functions():
	var bio_field = char_display.bio_edit
	bio_field.text = "abc123"
	bio_field.text_changed.emit()
	var char_bio = char_display.character.bio
	assert_eq(char_bio, "abc123")
