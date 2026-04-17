class_name Character_Sheet
extends Control

@onready var bio_edit = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/BioPanelContainer/BioMarginContainer/Bio/BioEdit
@onready var name_edit = $HeaderMargin/Header/HeaderInfo/NamePronouns/NamePanelContainer/NameC/NameEdit
@onready var agility_field: SpinBox = $TraitModifiers/AgilityPanel/AgilityContainer/Agility/SpinBox
@onready var strength_field: SpinBox = $TraitModifiers/StrengthPanel/StrengthContainer/Strength/SpinBox
@onready var finesse_field: SpinBox = $TraitModifiers/FinessePanel/FinesseContainer/Finesse/SpinBox
@onready var instinct_field: SpinBox = $TraitModifiers/InstinctPanel/InstinctContainer/Instinct/SpinBox
@onready var presence_field: SpinBox = $TraitModifiers/PrescencePanel/PrescenceContainer/Prescence/SpinBox
@onready var knowledge_field: SpinBox = $TraitModifiers/KnowledgePanel/KnowledgeContainer/Knowledge/SpinBox
@onready var pronouns_field: LineEdit = $HeaderMargin/Header/HeaderInfo/NamePronouns/PronounsPanelContainer/Pronouns/PronounsEdit
@onready var experience1 : LineEdit = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/Experiences/Experience1/Experience1
@onready var experience2 : LineEdit = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/Experiences/Experience2/Experience2
@onready var experience3 : LineEdit = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/Experiences/Experience3/Experience3
@onready var experience4 : LineEdit = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/Experiences/Experience4/Experience4
@onready var experience5 : LineEdit = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/Experiences/Experience5/Experience5

@onready var health_field = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/MarkableStats/VBoxContainer/Health
@onready var stress_field = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/MarkableStats/VBoxContainer/Stress
@onready var armor_field = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/MarkableStats/VBoxContainer/Armor
@onready var hope_field = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/MarkableStats/VBoxContainer/Hope
@onready var ancestry_field = $HeaderMargin/Header/HeaderInfo/ClassCommunityAncestry/AncestryPanelContainer/Ancestry/Ancestry
@onready var community_field = $HeaderMargin/Header/HeaderInfo/ClassCommunityAncestry/CommunityPanelContainer/Community/Community
@onready var class_field = $HeaderMargin/Header/HeaderInfo/ClassCommunityAncestry/ClassPanelContainer/Class/Class
@onready var short_rest_button: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/RestButtons/ShortRest
@onready var long_rest_button: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/RestButtons/LongRest
@onready var rest_window: Window = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/RestButtons/RestWindow
@onready var rest_confirm_button: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/RestButtons/RestWindow/RestUI/ConfirmButton
@onready var dice_roll_window: Window = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/DiceButtons/DiceRollWindow
@onready var fh_roll_window: Window = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/DiceButtons/FHRollWindow
@onready var evasion_value: Label = $BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EvasionProficiencyMargin/HBoxContainer/Evasion/FieldContainer/MarginContainer/FieldValue
@onready var proficiency_value: Label = $BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EvasionProficiencyMargin/HBoxContainer/Proficiency/FieldContainer/MarginContainer/FieldValue
@onready var major_threshold_value: Label = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/DamageThresholds/HBoxContainer/MajorThreshold/FieldContainer/MarginContainer/FieldValue
@onready var severe_threshold_value: Label = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/DamageThresholds/HBoxContainer/SevereThreshold/FieldContainer/MarginContainer/FieldValue

@onready var advance_window: Window = $AdvanceWindow

@onready var dice_button: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/DiceButtons/Dice
@onready var fearhope_button: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/LeftPanelButtons/MarginContainer/VBoxContainer/ActionButtons/DiceButtons/FHDice

@onready var levelup_button: Button = $HeaderMargin/Header/Level/FieldContainer/PanelContainer/LevelUpButton
@onready var levelup_confirmation_panel = $HeaderMargin/Header/Level/FieldContainer/LevelUpWindow
@onready var levelup_confirmation_button: Button = $HeaderMargin/Header/Level/FieldContainer/LevelUpWindow/Buttons/ConfirmButton
@onready var levelup_cancel_button: Button = $HeaderMargin/Header/Level/FieldContainer/LevelUpWindow/Buttons/CancelButton
@onready var level_field = $HeaderMargin/Header/Level/FieldContainer/MarginContainer/HSplitContainer/LevelDisplay

@onready var agility_advance: Button = $TraitModifiers/Agility/AdvanceButton
@onready var strength_advance: Button = $TraitModifiers/Strength/AdvanceButton
@onready var finesse_advance: Button = $TraitModifiers/Finesse/AdvanceButton
@onready var instinct_advance: Button = $TraitModifiers/Instinct/AdvanceButton
@onready var presence_advance: Button = $TraitModifiers/Prescence/AdvanceButton
@onready var knowledge_advance: Button = $TraitModifiers/Knowledge/AdvanceButton
@onready var health_advance: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/MarkableStats/VBoxContainer/Health/FieldContainer/Buttons/AdvanceButton
@onready var stress_advance: Button = $BodyMargin/PanelContainer/HBoxContainer/LeftPanel/VBoxContainer/MarkableStats/VBoxContainer/Stress/FieldContainer/Buttons/AdvanceButton
@onready var experience1_advance: Button = $Experiences/Experience1/AdvanceButton
@onready var experience2_advance: Button = $Experiences/Experience2/AdvanceButton
@onready var experience3_advance: Button = $Experiences/Experience3/AdvanceButton
@onready var experience4_advance: Button = $Experiences/Experience4/AdvanceButton
@onready var experience5_advance: Button = $Experiences/Experience5/AdvanceButton
@onready var evasion_advance: Button = $EvasionProficency/Evasion/AdvanceButton
@onready var proficiency_advance: Button = $EvasionProficency/Proficiency/AdvanceButton

@onready var save_button: Button = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/Save
@onready var delete_button: Button = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/Delete
@onready var main_menu_button: Button = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/MainMenu

@onready var del_window = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/DeletionWindow
@onready var del_confirm_button = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/DeletionWindow/Buttons/ConfirmButton
@onready var del_cancel_button = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/DeletionWindow/Buttons/CancelButton

@onready var all_traits: Array[SpinBox] = [agility_field, strength_field, finesse_field, instinct_field,
	presence_field, knowledge_field]

@onready var class_panel = $HeaderMargin/Header/HeaderInfo/ClassCommunityAncestry/ClassPanelContainer
@onready var ancestry_panel = $HeaderMargin/Header/HeaderInfo/ClassCommunityAncestry/AncestryPanelContainer
@onready var community_panel = $HeaderMargin/Header/HeaderInfo/ClassCommunityAncestry/CommunityPanelContainer
@onready var information_popup = $InformationPopup

@onready var equipment_window = $EquipmentWindow
@onready var experiences_container = $BodyMargin/PanelContainer/HBoxContainer/RightPanel/VBoxContainer/Experiences

var updated = false
var shortRestCounter = 0
var character: Character 
var card_scene: PackedScene = load("res://Scenes/Cards/card_vault.tscn")
var save_manager

func enter() -> void:
	character = $Character
	save_manager = get_tree().root.get_node("CharacterSheet").get_node("SaveManager")
	rest_window.get_character(character)
	dice_roll_window.visible = false
	fh_roll_window.visible = false
	levelup_confirmation_panel.visible = false
	equipment_window.visible = false
	update_edit_fields()
	update_equipment_display()
	connect_signals()
	
	self.update_markable_fields()
	
	ancestry_field.set_text(character.ancestry.ancestry_name)
	class_field.set_text(character.character_class.name + " \n(" + character.subclass.subclass_name + ")")
	community_field.set_text(character.community.community_name)
	level_field.text = str(character.level)
	evasion_value.set_text(str(character.evasion))
	proficiency_value.set_text(str(character.proficiency))
	
	save_manager.set_character(character)
	save_manager.save_character_data()

	experiences_container.set_level_values(character)

func _process(_delta: float) -> void:
	if(updated==false and character.character_name!=""):
		updated=true
		update_edit_fields()
	check_tier_achievements_threshold()
		
func update_equipment_display() -> void:
	# handle display of actual equipment
	var primaryPanel = $BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentMargin/EquipmentVBox/PrimaryWeapon
	var secondaryPanel = $BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentMargin/EquipmentVBox/SecondaryWeapon
	var armorPanel = $BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentMargin/EquipmentVBox/Armor
	
	primaryPanel.get_child(0).get_node("EquipmentName").text = character.get_primary_name()
	primaryPanel.get_child(0).get_node("EquipmentInfo").text = character.get_primary_info()
	armorPanel.get_child(0).get_node("EquipmentName").text = character.get_armor_name()
	armorPanel.get_child(0).get_node("EquipmentInfo").text = character.get_armor_info()
	
	if (character.get_secondary_name()==""):
		secondaryPanel.hide()
	else:
		secondaryPanel.get_child(0).get_node("EquipmentName").text = character.get_secondary_name()
		secondaryPanel.get_child(0).get_node("EquipmentInfo").text = character.get_secondary_info()
		secondaryPanel.show()
	
	# handle stat changes due to equipment changes
	major_threshold_value.set_text(str(character.damage_thresholds[0]))
	severe_threshold_value.set_text(str(character.damage_thresholds[1]))
	evasion_value.set_text(str(character.evasion))
	
func update_markable_fields() -> void:
	health_field.set_current_value(str(character.current_hp))
	stress_field.set_current_value(str(character.current_stress))
	hope_field.set_current_value(str(character.current_hope))
	armor_field.set_current_value(str(character.used_armor_slots))

func update_edit_fields() -> void:
	name_edit.set_text(str(character.character_name))
	bio_edit.set_text(str(character.bio))
	agility_field.value = character.agility
	strength_field.value = character.strength
	instinct_field.value = character.instinct
	finesse_field.value = character.finesse
	presence_field.value = character.presence
	knowledge_field.value = character.knowledge
	pronouns_field.set_text(str(character.pronouns))
	experience1.set_text(str(character.experiences[0]))
	experience2.set_text(str(character.experiences[1]))
	experience3.set_text(str(character.experiences[2]))
	experience4.set_text(str(character.experiences[3]))
	experience5.set_text(str(character.experiences[4]))
	evasion_value.set_text(str(character.evasion))
	proficiency_value.set_text(str(character.proficiency))

#TODO: use this to display proficiency and damage treshold modifiers
func update_dependent_stats() -> void:
	pass


func print_character_details() -> void:
	print("Character Details:")
	print("name: " + character.character_name)
	print(character.pronouns)
	print(character.level)
	print("agility: " + str(character.agility))
	print("strength: " + str(character.strength))
	print("finesse: " + str(character.finesse))
	print("instinct: " + str(character.instinct))
	print("presence: " + str(character.presence))
	print("knowledge: " + str(character.knowledge))
	print(character.bio)

func check_tier_achievements_threshold() -> void:
	if character.level < 2:
		experience3.hide()
	else:
		experience3.show()
	if character.level < 5:
		experience4.hide()
	else:
		experience4.show()
	if character.level < 8:
		experience5.hide()
	else:
		experience5.show()

func _on_bio_text_changed() -> void:
	character.bio = bio_edit.get_text()
	if(character.bio == "Im Cool"):
		print(character.bio)
		print_character_details()
		bio_edit.set_text("hi")


func _on_name_edit_text_submitted(new_text):
	character.character_name = new_text
	print(character.character_name)


func _on_name_edit_text_changed(new_text: String) -> void:
	character.character_name = new_text


func _on_trait_text_submitted(new_val: int, trait_name: String) -> void:
	if (trait_name == "Agility"):
		character.agility = new_val
		agility_field.value = character.agility
		print("Agility: " + str(character.agility))
	if (trait_name == "Strength"):
		character.strength = new_val
		strength_field.value = character.strength
		print("Strength: " + str(character.strength))
	if (trait_name == "Finesse"):
		character.finesse = new_val
		finesse_field.value = character.finesse
		print("Finesse: " + str(character.finesse))
	if (trait_name == "Instinct"):
		character.instinct = new_val
		instinct_field.value = character.instinct
		print("Instinct: " + str(character.instinct))
	if (trait_name == "Prescence"):
		character.presence = new_val
		presence_field.value = character.presence
		print("Presence: " + str(character.presence))
	if (trait_name == "Knowledge"):
		character.knowledge = new_val
		knowledge_field.value = character.knowledge
		print("knowledge: " + str(character.knowledge))


func _on_stat_increment_pressed(stat_name: String) -> void:
	if(stat_name=="Health"):
		if character.set_current_health(character.current_hp+1):
			health_field.set_current_value(str(character.current_hp))
	elif(stat_name=="Stress"):
		if character.set_current_stress(character.current_stress+1):
			stress_field.set_current_value(str(character.current_stress))
	elif(stat_name=="Armor"):
		if character.set_used_armor_slots(character.used_armor_slots+1):
			armor_field.set_current_value(str(character.used_armor_slots))
	elif(stat_name=="Hope"):
		if character.set_current_hope(character.current_hope+1):
			hope_field.set_current_value(str(character.current_hope))


func _on_stat_decrement_pressed(stat_name: String) -> void:
	if(stat_name=="Health"):
		if character.set_current_health(character.current_hp-1):
			health_field.set_current_value(str(character.current_hp))
	elif(stat_name=="Stress"):
		if character.set_current_stress(character.current_stress-1):
			stress_field.set_current_value(str(character.current_stress))
	elif(stat_name=="Armor"):
		if character.set_used_armor_slots(character.used_armor_slots-1):
			armor_field.set_current_value(str(character.used_armor_slots))
	elif(stat_name=="Hope"):
		if character.set_current_hope(character.current_hope-1):
			hope_field.set_current_value(str(character.current_hope))


func _on_pronouns_text_changed(new_text):
	character.pronouns = new_text

func _on_pronouns_text_submitted(new_text):
	character.pronouns = new_text
	print(new_text)
	
func change_experience(i: int, s: String):
	character.experiences[i] = s
	print(character.experiences[i])

func _on_experience_1_text_changed(new_text):
	change_experience(0, new_text)

func _on_experience_1_text_submitted(new_text):
	change_experience(0, new_text)

func _on_experience_2_text_changed(new_text):
	change_experience(1, new_text)

func _on_experience_2_text_submitted(new_text):
	change_experience(1, new_text)

func _on_experience_3_text_changed(new_text):
	change_experience(2, new_text)

func _on_experience_3_text_submitted(new_text):
	change_experience(2, new_text)

func _on_experience_4_text_changed(new_text):
	change_experience(3, new_text)

func _on_experience_4_text_submitted(new_text):
	change_experience(3, new_text)

func _on_experience_5_text_changed(new_text):
	change_experience(4, new_text)

func _on_experience_5_text_submitted(new_text):
	change_experience(4, new_text)

func _on_short_rest_pressed() -> void:
	if character.ancestry.ancestry_name=="Clank":
		_on_long_rest_pressed()
		return
	
	rest_window.set_rest_Length("short")
	rest_window.disable_Project()
	disable_button_selection(true)
	if shortRestCounter < 3:
		long_rest_button.disabled = true
		shortRestCounter += 1
		rest_window.visible = true

func _on_long_rest_pressed() -> void:
	rest_window.set_rest_Length("long")
	disable_button_selection(true)
	rest_window.enable_Project()
	shortRestCounter = 0
	rest_window.visible = true

func _on_dice_button_pressed() -> void:
	dice_roll_window.visible = true
	disable_button_selection(true)

func _on_fh_dice_button_pressed() -> void:
	fh_roll_window.visible = true
	disable_button_selection(true)

func _on_rest_window_close_requested() -> void:
	rest_window.hide()
	disable_button_selection(false)

func _on_dice_roll_window_close_requested() -> void:
	dice_roll_window.visible = false
	disable_button_selection(false)

func _on_fh_roll_window_close_requested() -> void:
	fh_roll_window.visible = false
	disable_button_selection(false)
	
	# handle the FH result
	if fh_roll_window.latest_outcome=="Hope":
		character.set_current_hope(character.current_hope + 1)
		hope_field.set_current_value(str(character.current_hope))
	elif fh_roll_window.latest_outcome=="Crit":
		character.set_current_hope(character.current_hope + 1)
		hope_field.set_current_value(str(character.current_hope))
		character.set_current_stress(character.current_stress - 1)
		stress_field.set_current_value(str(character.current_stress))

func _on_confirm_button_pressed() -> void:
	rest_window.hide()
	rest_window.confirm_selection()
	rest_window.set_buttons_down()
	disable_button_selection(false)
	update_markable_fields()
	
func _on_levelup_button_pressed() -> void:
	if character.level < 10:
		levelup_confirmation_button.pressed.connect(_on_levelup_confirm_pressed)
		levelup_cancel_button.pressed.connect(_on_levelup_cancel_pressed)
		levelup_confirmation_panel.visible = true

func _on_levelup_confirm_pressed() -> void:
	character.set_level(character.level + 1)
	character.damage_thresholds[0] += 1
	character.damage_thresholds[1] += 1
	update_equipment_display()
	level_field.text = str(character.level)
	levelup_confirmation_button.pressed.disconnect(_on_levelup_confirm_pressed)
	levelup_cancel_button.pressed.disconnect(_on_levelup_cancel_pressed)
	levelup_confirmation_panel.visible = false
	advance_window.get_character(character)
	advance_window.visible = true

func _on_levelup_cancel_pressed() -> void:
	levelup_confirmation_panel.visible = false

func connect_signals() -> void:
	for field in all_traits:
		field.value_changed.connect(_on_trait_text_submitted.bind(field.get_parent().name))
	
	health_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	health_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	stress_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	stress_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	armor_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	armor_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	hope_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	hope_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	
	short_rest_button.pressed.connect(_on_short_rest_pressed)
	long_rest_button.pressed.connect(_on_long_rest_pressed)
	dice_button.pressed.connect(_on_dice_button_pressed)
	fearhope_button.pressed.connect(_on_fh_dice_button_pressed)
	rest_confirm_button.pressed.connect(_on_confirm_button_pressed)
	rest_window.close_requested.connect(_on_rest_window_close_requested)
	dice_roll_window.close_requested.connect(_on_dice_roll_window_close_requested)
	fh_roll_window.close_requested.connect(_on_fh_roll_window_close_requested)
	
	levelup_button.pressed.connect(_on_levelup_button_pressed)
	save_button.pressed.connect(save_character)
	delete_button.pressed.connect(_on_delete_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	advance_window.advancements_confirmed.connect(update_markable_fields)
	advance_window.advancements_confirmed.connect(update_edit_fields)

	class_panel.mouse_entered.connect(_on_mouse_enter_class_panel)
	ancestry_panel.mouse_entered.connect(_on_mouse_enter_ancestry_panel)
	community_panel.mouse_entered.connect(_on_mouse_enter_community_panel)
	
	class_panel.mouse_exited.connect(_on_mouse_exit_header_panel)
	ancestry_panel.mouse_exited.connect(_on_mouse_exit_header_panel)
	community_panel.mouse_exited.connect(_on_mouse_exit_header_panel)

	var manage_equipment_button = $BodyMargin/PanelContainer/HBoxContainer/CenterPanel/VBoxContainer/EquipmentMargin/EquipmentVBox/ManageEquipment
	manage_equipment_button.pressed.connect(_on_equipment_management_button_pressed)
	
	experiences_container.exp_level_changed.connect(_on_exp_level_changed)

func disable_button_selection(b: bool) -> void:
	short_rest_button.disabled = b
	long_rest_button.disabled = b
	dice_button.disabled = b
	fearhope_button.disabled = b


func _on_cards_button_pressed() -> void:
	var new_scene = card_scene.instantiate()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()

func save_character() -> void:
	var save_manager = $SaveManager
	save_manager.set_character(character)
	await save_manager.call("save_character_data")
	
	var save_notif = $HeaderMargin/Header/PanelContainer/MarginContainer/RightPanel/SaveNotification
	save_notif.showFor()
	
func _on_delete_button_pressed() -> void:
	# CONFIRM IF PLAYER IS SURE
	del_cancel_button.pressed.connect(_on_cancel_deletion)
	del_confirm_button.pressed.connect(_on_confirm_deletion)
	del_window.show()

func _on_cancel_deletion():
	del_cancel_button.pressed.disconnect(_on_cancel_deletion)
	del_confirm_button.pressed.disconnect(_on_confirm_deletion)
	del_window.hide()
	
func _on_confirm_deletion():
	var save_manager = $SaveManager
	save_manager.set_character(character)
	await save_manager.call("delete_character_data")
	
	del_cancel_button.pressed.disconnect(_on_cancel_deletion)
	del_confirm_button.pressed.disconnect(_on_confirm_deletion)
	del_window.hide()
	
	var main_menu = load("res://Scenes/SheetManagement/main_menu.tscn").instantiate()
	get_tree().root.add_child(main_menu)
	self.queue_free()
	
func _on_main_menu_button_pressed() -> void:
	save_character()
	var main_menu = load("res://Scenes/SheetManagement/main_menu.tscn").instantiate()
	get_tree().root.add_child(main_menu)
	self.queue_free()

func _on_mouse_enter_class_panel():
	information_popup.showClassInformation(
		character.character_class,
		character.subclass,
		class_panel.global_position,
		class_panel.size
	)

func _on_mouse_enter_ancestry_panel():
	information_popup.showAncestryInformation(
		character.ancestry,
		ancestry_panel.global_position,
		ancestry_panel.size
	)

func _on_mouse_enter_community_panel():
	information_popup.showCommunityInformation(
		character.community, 
		community_panel.global_position,
		community_panel.size
	)

func _on_mouse_exit_header_panel():
	information_popup.hide()

func _on_equipment_management_button_pressed():
	equipment_window.showWindow(self.character)

func _on_exp_level_changed(which_exp: int, new_val: int):
	var current_val = character.experience_levels[which_exp-1]
	character.update_experience_level(which_exp, new_val-current_val)
