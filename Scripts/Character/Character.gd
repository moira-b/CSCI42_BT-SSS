# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

# Objects from local scene
var bio_edit 
var name_edit 
var agility_field: LineEdit 
var strength_field: LineEdit 
var finesse_field: LineEdit 
var instinct_field: LineEdit
var presence_field: LineEdit 
var knowledge_field: LineEdit 

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
@export var experiences: Array[String] = ["", ""]

var ancestry: Ancestry
var community: Community
var character_class: CharacterClass
var subclass: CharacterSubclass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func enter_character_sheet() -> void:
	bio_edit = $"../Bio/BioEdit"
	name_edit = $"../Names/NameC/NameEdit"
	agility_field = $"../TraitModifiers/Agility/LineEdit"
	strength_field = $"../TraitModifiers/Strength/LineEdit"
	finesse_field = $"../TraitModifiers/Finesse/LineEdit"
	instinct_field = $"../TraitModifiers/Instinct/LineEdit"
	presence_field = $"../TraitModifiers/Prescence/LineEdit"
	knowledge_field = $"../TraitModifiers/Knowledge/LineEdit"

func take_damage(dmg: int) -> void:
	current_hp -= dmg
	
