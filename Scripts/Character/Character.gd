# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

# Objects from local scene
@onready var bio_edit = $"../Bio/BioEdit"
@onready var name_edit = $"../Names/NameC/NameEdit"
@onready var agility_field: LineEdit = $"../TraitModifiers/Agility/LineEdit"
@onready var strength_field: LineEdit = $"../TraitModifiers/Strength/LineEdit"
@onready var finesse_field: LineEdit = $"../TraitModifiers/Finesse/LineEdit"
@onready var instinct_field: LineEdit = $"../TraitModifiers/Instinct/LineEdit"
@onready var presence_field: LineEdit = $"../TraitModifiers/Prescence/LineEdit"
@onready var knowledge_field: LineEdit = $"../TraitModifiers/Knowledge/LineEdit"

@export var bio: String
@export var character_name: String
@export var pronouns: String
@export var level: int
@export var agility: int
@export var strength: int
@export var finesse: int
@export var instinct: int
@export var presence: int
@export var knowledge: int
@export var max_hp: int
@export var current_hp: int
@export var current_stress: int
@export var max_hope: int
@export var current_hope: int
@export var items: Array[String]
@export var max_armor_slots: int
@export var used_armor_slots: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_character_details()
	update_edit_fields()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

func _on_name_edit_text_changed(new_text) -> void:
	pass


func _on_bio_text_changed() -> void:
	bio = bio_edit.get_text()
	if(bio == "Im Cool"):
		print(bio)
		print_character_details()
		bio_edit.set_text("hi")

		
func take_damage(dmg: int) -> void:
	current_hp -= dmg
	

func print_character_details() -> void:
	print("Character Details:")
	print("name: " + character_name)
	print(pronouns)
	print(level)
	print("agility: " + str(agility))
	print("strength: " + str(strength))
	print("finesse: " + str(finesse))
	print("instinct: " + str(instinct))
	print("presence: " + str(presence))
	print("knowledge: " + str(knowledge))
	print(bio)
	
	
func update_edit_fields() -> void:
	name_edit.set_text(character_name)
	bio_edit.set_text(bio)
	agility_field.set_text(str(agility))
	strength_field.set_text(str(strength))
	instinct_field.set_text(str(instinct))
	finesse_field.set_text(str(finesse))
	presence_field.set_text(str(presence))
	knowledge_field.set_text(str(knowledge))


func _on_name_edit_text_submitted(new_text):
	character_name = new_text
	print(character_name)


func _on_agility_text_submitted(new_text: String) -> void:
	if (int(new_text) == 0):
		print("Invalid input")
	else:
		agility = int(new_text)
		agility_field.text = str(agility)
		print("Agility: " + str(agility))


func _on_strength_text_submitted(new_text: String) -> void:
	if (int(new_text) == 0):
		print("Invalid input")
	else:
		strength = int(new_text)
		strength_field.text = str(strength)
		print("Strength: " + str(strength))


func _on_finesse_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			finesse = int(new_text)
			finesse_field.text = str(finesse)
			print("Finesse: " + str(finesse))


func _on_instinct_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			instinct = int(new_text)
			instinct_field.text = str(instinct)
			print("Instinct: " + str(instinct))


func _on_presence_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			presence = int(new_text)
			presence_field.text = str(presence)
			print("Presence: " + str(presence))


func _on_knowledge_text_submitted(new_text: String) -> void:
		if (int(new_text) == 0):
			print("Invalid input")
		else:
			knowledge = int(new_text)
			knowledge_field.text = str(knowledge)
			print("knowledge: " + str(knowledge))
