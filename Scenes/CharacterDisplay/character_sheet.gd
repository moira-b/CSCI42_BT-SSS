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

@onready var dice_button: Button = $ActionButtons/DiceButtons/Dice
@onready var fearhope_button: Button = $ActionButtons/DiceButtons/FHDice

@onready var levelup_button: Button = $Header/Level/FieldContainer/PanelContainer/LevelUpButton
@onready var levelup_confirmation_panel = $LevelUpConfirmation
@onready var levelup_confirmation_button: Button = $LevelUpConfirmation/VBoxContainer/ConfirmButton
@onready var levelup_cancel_button: Button = $LevelUpConfirmation/VBoxContainer/CancelButton
@onready var level_field = $Header/Level/FieldContainer/MarginContainer/HSplitContainer/LevelDisplay

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
	update_edit_fields()
	
	character.set_maximum_health()
	character.set_current_health(5)
	character.set_maximum_stress()
	character.set_current_stress(5)
	character.set_maximum_armor_slots()
	character.set_used_armor_slots(5)
	character.set_maximum_hope()
	character.set_current_hope(3)
	character.set_level(1)
	
	connect_signals()
	
	self.update_markable_fields()
	
	ancestry_field.set_text(character.ancestry.ancestry_name)
	class_field.set_text(character.character_class.name)
	subclass_field.set_text(character.subclass.subclass_name)
	community_field.set_text(character.community.community_name)
	level_field.text = str(character.level)

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

func _on_confirm_button_pressed() -> void:
	rest_window.hide()
	disable_button_selection(false)
	print(character.current_hp)
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
	
	rest_window.close_requested.connect(_on_rest_window_close_requested)

	levelup_button.pressed.connect(_on_levelup_button_pressed)

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
