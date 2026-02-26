# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

# Objects from local scene
@onready var bio_edit: TextEdit = $"../Bio/BioEdit"

var bio: String
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
	agility = 10
	strength = 10
	finesse = 10
	instinct = 10
	presence = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass


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


func _on_name_edit_text_changed(new_text) -> void:
	character_name = new_text
	if(character_name == "Quian"):
		print(bio)


func _on_bio_text_changed() -> void:
	bio = bio_edit.get_text()
	if(bio == "Im Cool"):
		print(bio)
		print_character_details()
