class_name Character_Sheet
extends Control

@onready var bio_edit = $"Bio/BioEdit"
@onready var name_edit = $Header/HeaderInfo/NamePronouns/NamePanelContainer/NameC/NameEdit
@onready var agility_field: LineEdit = $"TraitModifiers/Agility/LineEdit"
@onready var strength_field: LineEdit = $"TraitModifiers/Strength/LineEdit"
@onready var finesse_field: LineEdit = $"TraitModifiers/Finesse/LineEdit"
@onready var instinct_field: LineEdit = $"TraitModifiers/Instinct/LineEdit"
@onready var presence_field: LineEdit = $"TraitModifiers/Prescence/LineEdit"
@onready var knowledge_field: LineEdit = $"TraitModifiers/Knowledge/LineEdit"
@onready var pronouns_field: LineEdit = $Header/HeaderInfo/NamePronouns/PronounsPanelContainer/Pronouns/PronounsEdit
@onready var experience1 : LineEdit = $Experiences/Experience1/Experience1
@onready var experience2 : LineEdit = $Experiences/Experience2/Experience2
@onready var experience3 : LineEdit = $Experiences/Experience3/Experience3
@onready var experience4 : LineEdit = $Experiences/Experience4/Experience4
@onready var experience5 : LineEdit = $Experiences/Experience5/Experience5

@onready var health_field = $MarkableStats/Health
@onready var stress_field = $MarkableStats/Stress
@onready var armor_field = $MarkableStats/Armor
@onready var hope_field = $MarkableStats/Hope
#@onready var level_field = $Header/Level/Level
@onready var ancestry_field = $Header/HeaderInfo/CommnityAncestry/AncestryPanelContainer/Ancestry/ColorRect/Ancestry
@onready var community_field = $Header/HeaderInfo/CommnityAncestry/PanelContainer/Community/ColorRect/Community
@onready var class_field = $ClassSubclass/ClassRect/Class
@onready var subclass_field = $ClassSubclass/SubclassRect/Label
@onready var short_rest_button: Button = $ActionButtons/RestButtons/ShortRest
@onready var long_rest_button: Button = $ActionButtons/RestButtons/LongRest
@onready var rest_window: Window = $ActionButtons/RestButtons/RestWindow
@onready var dice_roll_window: Window = $ActionButtons/DiceButtons/DiceRollWindow
@onready var fh_roll_window: Window = $ActionButtons/DiceButtons/FHRollWindow
@onready var evasion_value: Label = $EvasionProficency/Evasion/Value
@onready var proficiency_value: Label = $EvasionProficency/Proficiency/Value

@onready var dice_button: Button = $ActionButtons/DiceButtons/Dice
@onready var fearhope_button: Button = $ActionButtons/DiceButtons/FHDice

@onready var levelup_button: Button = $Header/Level/FieldContainer/PanelContainer/LevelUpButton
@onready var levelup_confirmation_panel = $LevelUpConfirmation
@onready var levelup_confirmation_button: Button = $LevelUpConfirmation/VBoxContainer/ConfirmButton
@onready var levelup_cancel_button: Button = $LevelUpConfirmation/VBoxContainer/CancelButton
@onready var level_field = $Header/Level/FieldContainer/MarginContainer/HSplitContainer/LevelDisplay

@onready var agility_advance: Button = $TraitModifiers/Agility/AdvanceButton
@onready var strength_advance: Button = $TraitModifiers/Strength/AdvanceButton
@onready var finesse_advance: Button = $TraitModifiers/Finesse/AdvanceButton
@onready var instinct_advance: Button = $TraitModifiers/Instinct/AdvanceButton
@onready var presence_advance: Button = $TraitModifiers/Prescence/AdvanceButton
@onready var knowledge_advance: Button = $TraitModifiers/Knowledge/AdvanceButton
@onready var health_advance: Button = $MarkableStats/Health/FieldContainer/Buttons/AdvanceButton
@onready var stress_advance: Button = $MarkableStats/Stress/FieldContainer/Buttons/AdvanceButton
@onready var experience1_advance: Button = $Experiences/Experience1/AdvanceButton
@onready var experience2_advance: Button = $Experiences/Experience2/AdvanceButton
@onready var experience3_advance: Button = $Experiences/Experience3/AdvanceButton
@onready var experience4_advance: Button = $Experiences/Experience4/AdvanceButton
@onready var experience5_advance: Button = $Experiences/Experience5/AdvanceButton
@onready var evasion_advance: Button = $EvasionProficency/Evasion/AdvanceButton
@onready var proficiency_advance: Button = $EvasionProficency/Proficiency/AdvanceButton

@onready var save_button: Button = $Header/PanelContainer/MarginContainer/RightPanel/Save
@onready var delete_button: Button = $Header/PanelContainer/MarginContainer/RightPanel/Delete
@onready var main_menu_button: Button = $Header/PanelContainer/MarginContainer/RightPanel/MainMenu

@onready var del_window = $Heder/PanelContainer/MarginContainer/RightPanel/DeletionWindow
@onready var del_confirm_button = del_window.get_node("Buttons/ConfirmButton")
@onready var del_cancel_button = del_window.get_node("Buttons/CancelButton")

var advance_buttons: Array[Button] = []
var selected_advance: Array[Button] = []
var updated = false
var shortRestCounter = 0
var character: Character
var card_scene: PackedScene = load("res://Scenes/Cards/card_vault.tscn")

func enter() -> void:
	character = $Character
	rest_window.get_character(character)
	dice_roll_window.visible = false
	fh_roll_window.visible = false
	levelup_confirmation_panel.visible = false
	advance_buttons = [agility_advance, strength_advance, finesse_advance,
	instinct_advance, presence_advance, knowledge_advance, health_advance, stress_advance,
	experience1_advance, experience2_advance, evasion_advance, proficiency_advance]
	update_edit_fields()
	
	#character.set_maximum_health()
	#character.set_maximum_stress()
	#character.set_maximum_armor_slots()
	
	connect_signals()
	
	self.update_markable_fields()
	
	ancestry_field.set_text(character.ancestry.ancestry_name)
	class_field.set_text(character.character_class.name)
	subclass_field.set_text(character.subclass.subclass_name)
	community_field.set_text(character.community.community_name)
	level_field.text = str(character.level)
	evasion_value.set_text(str(character.evasion))
	proficiency_value.set_text(str(character.proficiency))
	

func _process(_delta: float) -> void:
	if(updated==false and character.character_name!=""):
		updated=true
		update_edit_fields()
	check_tier_achievements_threshold()
		

func update_markable_fields() -> void:
	health_field.set_current_value(str(character.current_hp))
	stress_field.set_current_value(str(character.current_stress))
	hope_field.set_current_value(str(character.current_hope))
	armor_field.set_current_value(str(character.used_armor_slots))

func update_edit_fields() -> void:
	name_edit.set_text(str(character.character_name))
	bio_edit.set_text(str(character.bio))
	agility_field.set_text(str(character.agility))
	strength_field.set_text(str(character.strength))
	instinct_field.set_text(str(character.instinct))
	finesse_field.set_text(str(character.finesse))
	presence_field.set_text(str(character.presence))
	knowledge_field.set_text(str(character.knowledge))
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


func _on_agility_text_submitted(new_text: String) -> void:
	if (int(new_text) == 0):
		print("Invalid input")
	else:
		character.agility = int(new_text)
		agility_field.text = str(character.agility)
		print("Agility: " + str(character.agility))


func _on_strength_text_submitted(new_text: String) -> void:
	if (int(new_text) == 0):
		print("Invalid input")
	else:
		character.strength = int(new_text)
		strength_field.text = str(character.strength)
		print("Strength: " + str(character.strength))


func _on_finesse_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			character.finesse = int(new_text)
			finesse_field.text = str(character.finesse)
			print("Finesse: " + str(character.finesse))


func _on_instinct_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			character.instinct = int(new_text)
			instinct_field.text = str(character.instinct)
			print("Instinct: " + str(character.instinct))


func _on_presence_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			character.presence = int(new_text)
			presence_field.text = str(character.presence)
			print("Presence: " + str(character.presence))


func _on_knowledge_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			character.knowledge = int(new_text)
			knowledge_field.text = str(character.knowledge)
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
	# OLD CODE, can delete
	#elif(stat_name=="Level"):
		#if character.set_level(character.level+1):
			#level_field.set_current_value(str(character.level))
	
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
	# OLD CODE, can delete
	#elif(stat_name=="Level"):
		#if character.set_level(character.level-1):
			#level_field.set_current_value(str(character.level))

func _on_pronouns_text_changed(new_text):
	character.pronouns = new_text

func _on_pronouns_text_submitted(new_text):
	character.pronouns = new_text
	print(new_text)
	
func change_experience(i: int, s: String):
	character.experiences[i] = s
	print(character.experiences[i])

func _on_experience_1_text_changed(new_text):
	change_experience(1, new_text)

func _on_experience_1_text_submitted(new_text):
	change_experience(1, new_text)

func _on_experience_2_text_changed(new_text):
	change_experience(2, new_text)

func _on_experience_2_text_submitted(new_text):
	change_experience(2, new_text)

func _on_experience_3_text_changed(new_text):
	change_experience(3, new_text)

func _on_experience_3_text_submitted(new_text):
	change_experience(3, new_text)

func _on_experience_4_text_changed(new_text):
	change_experience(4, new_text)

func _on_experience_4_text_submitted(new_text):
	change_experience(4, new_text)

func _on_experience_5_text_changed(new_text):
	change_experience(5, new_text)

func _on_experience_5_text_submitted(new_text):
	change_experience(5, new_text)

func _on_short_rest_pressed() -> void:
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
		#levelup_confirmation_panel.global_position = levelup_button.global_position
		levelup_confirmation_button.pressed.connect(_on_levelup_confirm_pressed)
		levelup_cancel_button.pressed.connect(_on_levelup_cancel_pressed)
		levelup_confirmation_panel.visible = true

func _on_levelup_confirm_pressed() -> void:
	character.set_level(character.level + 1)
	level_field.text = str(character.level)
	levelup_confirmation_button.pressed.disconnect(_on_levelup_confirm_pressed)
	levelup_cancel_button.pressed.disconnect(_on_levelup_cancel_pressed)
	levelup_confirmation_panel.visible = false

func _on_levelup_cancel_pressed() -> void:
	levelup_confirmation_panel.visible = false

func connect_signals() -> void:
	health_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	health_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	stress_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	stress_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	armor_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	armor_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	hope_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	hope_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	# OLD CODE, can delete
	#level_field.stat_increment_pressed.connect(_on_stat_increment_pressed)
	#level_field.stat_decrement_pressed.connect(_on_stat_decrement_pressed)
	
	short_rest_button.pressed.connect(_on_short_rest_pressed)
	long_rest_button.pressed.connect(_on_long_rest_pressed)
	dice_button.pressed.connect(_on_dice_button_pressed)
	fearhope_button.pressed.connect(_on_fh_dice_button_pressed)
	$ActionButtons/RestButtons/RestWindow/RestUI/ConfirmButton.pressed.connect(_on_confirm_button_pressed)
	
	rest_window.close_requested.connect(_on_rest_window_close_requested)
	dice_roll_window.close_requested.connect(_on_dice_roll_window_close_requested)
	fh_roll_window.close_requested.connect(_on_fh_roll_window_close_requested)
	
	levelup_button.pressed.connect(_on_levelup_button_pressed)
	
	save_button.pressed.connect(_on_save_button_pressed)
	delete_button.pressed.connect(_on_delete_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

func disable_button_selection(b: bool) -> void:
	short_rest_button.disabled = b
	long_rest_button.disabled = b
	dice_button.disabled = b
	fearhope_button.disabled = b

func _on_agility_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(agility_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(agility_advance)


func _on_strength_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(strength_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(strength_advance)


func _on_finesse_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(finesse_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(finesse_advance)


func _on_instinct_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(instinct_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(instinct_advance)


func _on_presence_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(presence_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(presence_advance)


func _on_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(knowledge_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(knowledge_advance)


func _on_health_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(health_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(health_advance)


func _on_stress_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(stress_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(stress_advance)


func _on_experience_1_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(experience1_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(experience1_advance)


func _on_experience_2_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(experience2_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(experience2_advance)


func _on_experience_3_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(experience3_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(experience3_advance)


func _on_experience_4_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(experience4_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(experience4_advance)


func _on_experience_5_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(experience5_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(experience5_advance)


func _on_evasion_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(evasion_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(evasion_advance)


func _on_proficiency_advance_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected_advance.append(proficiency_advance)
		
		if selected_advance.size() >= 2:
			var first = selected_advance[0]
			var second = selected_advance[1]
			
			advance_buttons.erase(first)
			advance_buttons.erase(second)
			
			for button in advance_buttons:
				button.hide()
			
			first.disabled = true
			second.disabled = true
			
			increment_advancements(selected_advance)
	else:
		selected_advance.erase(proficiency_advance)


func toggle_advance_buttons() -> void:
	advance_buttons += selected_advance
	selected_advance.clear()
	for button in advance_buttons:
		button.show()
		button.button_pressed = false
		button.disabled = false


func _on_cards_button_pressed() -> void:
	var new_scene = card_scene.instantiate()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()


func _on_level_up_confirm_button_pressed() -> void:
	if character.level == 1:
		advance_buttons.append(experience3_advance)
		toggle_advance_buttons()
	if character.level == 4:
		advance_buttons.append(experience4_advance)
		toggle_advance_buttons()
	if character.level == 7:
		advance_buttons.append(experience5_advance)
		toggle_advance_buttons()


func increment_advancements(stats) -> void:
	for s in stats:
		if s == agility_advance: character.agility += 1
		if s == strength_advance: character.strength += 1
		if s == finesse_advance: character.finesse += 1
		if s == instinct_advance: character.instinct += 1
		if s == presence_advance: character.presence += 1
		if s == knowledge_advance: character.knowledge += 1
		if s == health_advance: character.max_hp += 1
		if s == stress_advance: character.max_stress += 1
		if s == evasion_advance: character.evasion += 1
		if s == proficiency_advance: character.proficiency += 1
	update_edit_fields()

func _on_save_button_pressed() -> void:
	var save_manager = $SaveManager
	save_manager.set_character(character)
	await save_manager.call("save_character_data")
	
	
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
	# TODO: return to main menu after deletion
	
func _on_main_menu_button_pressed() -> void:
	pass
