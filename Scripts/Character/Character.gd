# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

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
@export var max_hp: int = 10 # TEMPORARY
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

func set_maximum_health() -> void:
	self.max_hp = 10
	# TODO: set maximum health based on character creation options

func set_current_health(value: int) -> void:
	if(value <= self.max_hp):
		current_hp = value
		print("DEBUG: " + self.character_name + "'s current health is " + str(current_hp) + ".")
	else:
		print("Cannot set current health to be greater than max health.")

#func take_damage(dmg: int) -> void:
	#current_hp -= dmg
#
#func gain_health(health_gained: int)-> void:
	#current_hp += health_gained
	#print("DEBUG (1/2): " + self.character_name + " gained " + str(health_gained) + "health.")
	#print("DEBUG (2/2): " + self.character_name + "'s urrent health is " + str(current_hp) + ".")
