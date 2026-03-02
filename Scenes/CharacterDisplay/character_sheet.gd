extends Control

@onready var bio_edit = $"Bio/BioEdit"
@onready var name_edit = $"Names/NameC/NameEdit"
@onready var agility_field: LineEdit = $"TraitModifiers/Agility/LineEdit"
@onready var strength_field: LineEdit = $"TraitModifiers/Strength/LineEdit"
@onready var finesse_field: LineEdit = $"TraitModifiers/Finesse/LineEdit"
@onready var instinct_field: LineEdit = $"TraitModifiers/Instinct/LineEdit"
@onready var presence_field: LineEdit = $"TraitModifiers/Prescence/LineEdit"
@onready var knowledge_field: LineEdit = $"TraitModifiers/Knowledge/LineEdit"

var character:Character
func enter() -> void:
	character = $Character
	character.enter_character_sheet()
