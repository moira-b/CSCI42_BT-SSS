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
	var markables = [char_display.health_checkables, char_display.stress_checkables,
		char_display.armor_checkables, char_display.hope_checkables]
	
	for t in char_display.all_traits:
		assert_connected(t.value_changed, char_display._on_trait_text_submitted)
		
	for m in markables:
		assert_connected(m.amount_toggled_updated, char_display._on_markable_stat_pressed)
		
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
	assert_connected(char_display.experiences_vbox.exp_level_changed, char_display._on_exp_level_changed)
	assert_connected(char_display.name_edit.focus_exited, char_display._on_name_edit_focus_exited)
	assert_connected(char_display.name_edit.text_submitted, char_display._on_name_edit_text_submitted)
	


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


func test_equipment_manager():
	var test_armor = "Gambeson Armor"
	var test_prim = "Broadsword"
	var test_second = "Shortsword"
	
	var primary_info = char_display.get_node("BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentContainer/EquipmentMargin/EquipmentVBox/PrimaryWeapon/PrimaryVBox")
	var secondary_info = char_display.get_node("BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentContainer/EquipmentMargin/EquipmentVBox/SecondaryWeapon/SecondaryVBox")
	var armor_info = char_display.get_node("BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentContainer/EquipmentMargin/EquipmentVBox/Armor/ArmorVBox")
	
	char_display.character.items.append(test_armor)
	char_display.character.equip_armor(char_display.character.items[0])
	char_display.character.items.append(test_prim)
	char_display.character.equip_primary(char_display.character.items[1])
	char_display.character.items.append(test_second)
	char_display.character.equip_secondary(char_display.character.items[2])
	
	char_display.update_equipment_display()
	
	assert_string_contains(armor_info.get_child(1).text, char_display.character.get_armor_name())
	assert_string_contains(primary_info.get_child(1).text, char_display.character.get_primary_name())
	assert_string_contains(secondary_info.get_child(1).text, char_display.character.get_secondary_name())
	
	assert_string_contains(armor_info.get_child(1).text, char_display.character.get_armor_info())
	assert_string_contains(primary_info.get_child(1).text, char_display.character.get_primary_info())
	assert_string_contains(secondary_info.get_child(1).text, char_display.character.get_secondary_info())
	
	assert_eq(char_display.damage_threshold_display.get_major_threshold(), char_display.character.damage_thresholds[0])
	assert_eq(char_display.damage_threshold_display.get_severe_threshold(), char_display.character.damage_thresholds[1])
	assert_eq(char_display.evasion_value.text, str(char_display.character.evasion))


func test_markables():
	var test_health = char_display.health_checkables
	var test_stress = char_display.stress_checkables
	var test_hope = char_display.hope_checkables
	var test_armor = char_display.armor_checkables
	
	test_health.initialize("Health", 5)
	test_stress.initialize("Stress", 5)
	test_hope.initialize("Hope", 6)
	test_armor.initialize("Armor", 5)
	
	# Testing setting stats to 0
	char_display.character.set_current_health(0)
	char_display.character.set_current_stress(0)
	char_display.character.set_current_hope(0)
	char_display.character.set_used_armor_slots(0)
	
	char_display.update_markable_fields()
	
	assert_eq(test_health.amount_toggled, char_display.character.current_hp)
	assert_eq(test_stress.amount_toggled, char_display.character.current_stress)
	assert_eq(test_hope.amount_toggled, char_display.character.current_hope)
	assert_eq(test_armor.amount_toggled, char_display.character.used_armor_slots)
	
	# Testing setting stats to -1
	char_display.character.set_current_health(-1)
	char_display.character.set_current_stress(-1)
	char_display.character.set_current_hope(-1)
	char_display.character.set_used_armor_slots(-1)
	
	char_display.update_markable_fields()
	
	assert_eq(test_health.amount_toggled, char_display.character.current_hp)
	assert_eq(test_stress.amount_toggled, char_display.character.current_stress)
	assert_eq(test_hope.amount_toggled, char_display.character.current_hope)
	assert_eq(test_armor.amount_toggled, char_display.character.used_armor_slots)
	
	# Testing setting stats greater than max
	char_display.character.set_current_health(char_display.character.max_hp + 1)
	char_display.character.set_current_stress(char_display.character.max_stress + 1)
	char_display.character.set_current_hope(char_display.character.max_hope + 1)
	char_display.character.set_used_armor_slots(char_display.character.max_armor_slots + 1)
	
	char_display.update_markable_fields()
	
	assert_eq(test_health.amount_toggled, char_display.character.current_hp)
	assert_eq(test_stress.amount_toggled, char_display.character.current_stress)
	assert_eq(test_hope.amount_toggled, char_display.character.current_hope)
	assert_eq(test_armor.amount_toggled, char_display.character.used_armor_slots)
	
	# Testing directly setting stats to 1
	char_display.character.set_current_health(1)
	char_display.character.set_current_stress(1)
	char_display.character.set_current_hope(1)
	char_display.character.set_used_armor_slots(1)
	
	char_display.update_markable_fields()
	
	assert_eq(test_health.amount_toggled, char_display.character.current_hp)
	assert_eq(test_stress.amount_toggled, char_display.character.current_stress)
	assert_eq(test_hope.amount_toggled, char_display.character.current_hope)
	assert_eq(test_armor.amount_toggled, char_display.character.used_armor_slots)
	
	# Testing incrementing signals
	test_health.amount_toggled_updated.emit(1)
	test_stress.amount_toggled_updated.emit(1)
	test_hope.amount_toggled_updated.emit(1)
	test_armor.amount_toggled_updated.emit(1)

	assert_eq(test_health.amount_toggled, char_display.character.current_hp)
	assert_eq(test_stress.amount_toggled, char_display.character.current_stress)
	assert_eq(test_hope.amount_toggled, char_display.character.current_hope)
	assert_eq(test_armor.amount_toggled, char_display.character.used_armor_slots)


func test_trait_fields():
	for field in char_display.all_traits:
		field.value_changed.emit(1)
		
	assert_eq(char_display.agility_field.value, char_display.character.agility)
	assert_eq(char_display.strength_field.value, char_display.character.strength)
	assert_eq(char_display.finesse_field.value, char_display.character.finesse)
	assert_eq(char_display.instinct_field.value, char_display.character.instinct)
	assert_eq(char_display.presence_field.value, char_display.character.presence)
	assert_eq(char_display.knowledge_field.value, char_display.character.knowledge)
	
	for field in char_display.all_traits:
		field.value_changed.emit(-2)
		
	assert_eq(char_display.agility_field.value, char_display.character.agility)
	assert_eq(char_display.strength_field.value, char_display.character.strength)
	assert_eq(char_display.finesse_field.value, char_display.character.finesse)
	assert_eq(char_display.instinct_field.value, char_display.character.instinct)
	assert_eq(char_display.presence_field.value, char_display.character.presence)
	assert_eq(char_display.knowledge_field.value, char_display.character.knowledge)
	
	for field in char_display.all_traits:
		field.value_changed.emit(5)
		
	assert_eq(char_display.agility_field.value, char_display.character.agility)
	assert_eq(char_display.strength_field.value, char_display.character.strength)
	assert_eq(char_display.finesse_field.value, char_display.character.finesse)
	assert_eq(char_display.instinct_field.value, char_display.character.instinct)
	assert_eq(char_display.presence_field.value, char_display.character.presence)
	assert_eq(char_display.knowledge_field.value, char_display.character.knowledge)
