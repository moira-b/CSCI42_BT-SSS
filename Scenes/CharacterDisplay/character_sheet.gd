extends Control

@onready var bio_edit = $"Bio/BioEdit"
@onready var name_edit = $"Names/NameC/NameEdit"
@onready var agility_field: LineEdit = $"TraitModifiers/Agility/LineEdit"
@onready var strength_field: LineEdit = $"TraitModifiers/Strength/LineEdit"
@onready var finesse_field: LineEdit = $"TraitModifiers/Finesse/LineEdit"
@onready var instinct_field: LineEdit = $"TraitModifiers/Instinct/LineEdit"
@onready var presence_field: LineEdit = $"TraitModifiers/Prescence/LineEdit"
@onready var knowledge_field: LineEdit = $"TraitModifiers/Knowledge/LineEdit"
@onready var short_rest: Button = $RestButtons/ShortRest
@onready var long_rest: Button = $RestButtons/LongRest
@onready var rest_window: Window = $RestButtons/RestWindow
@onready var project_action: CheckButton = $RestButtons/RestWindow/RestUI/RestActions/Project


var updated = false
var shortRestCounter = 0
var character: Character

func enter() -> void:
	character = $Character
	update_edit_fields()


func _process(_delta: float) -> void:
	if(updated==false and character.character_name!=""):
		updated=true
		update_edit_fields()
		

func update_edit_fields() -> void:
	name_edit.set_text(str(character.character_name))
	bio_edit.set_text(str(character.bio))
	agility_field.set_text(str(character.agility))
	strength_field.set_text(str(character.strength))
	instinct_field.set_text(str(character.instinct))
	finesse_field.set_text(str(character.finesse))
	presence_field.set_text(str(character.presence))
	knowledge_field.set_text(str(character.knowledge))


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


func _on_short_rest_pressed() -> void:
	project_action.visible = false
	if shortRestCounter < 3:
		long_rest.disabled = true
		shortRestCounter += 1
		rest_window.visible = true


func _on_long_rest_pressed() -> void:
	short_rest.disabled = true
	project_action.visible = true
	shortRestCounter = 0
	rest_window.visible = true


func _on_rest_window_close_requested() -> void:
	rest_window.hide()
	short_rest.disabled = false
	long_rest.disabled = false
	
