# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

# Objects from local scene
@onready var bio_edit = $"../Bio/BioEdit"
@onready var name_edit = $"../Names/NameC/NameEdit"

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


func _on_name_edit_text_submitted(new_text):
	character_name = new_text
	print(character_name)# Replace with function body.
