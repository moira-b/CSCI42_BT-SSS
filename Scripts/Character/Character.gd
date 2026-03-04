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
@export var max_hp: int
@export var current_hp: int
@export var max_stress: int
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
	self.max_hp = 12 # PLACEHOLDER
	# TODO: set maximum health based on character creation options
	# (i.e. consider chosen character features)

func set_current_health(value: int) -> bool:
	if(0 <= value && value <= self.max_hp):
		current_hp = value
		print("DEBUG: " + self.character_name + "'s current health is " + str(current_hp) + ".")
		return true
	elif(value < 0):
		print("Cannot set current health to be less than 0.")
	else:
		print("Cannot set current health to be greater than max health.")
	
	return false

func set_maximum_stress() -> void:
	self.max_stress = 12 # PLACEHOLDER
	# TODO: set maximum health based on character creation options
	# (i.e. consider chosen character features)

func set_current_stress(value: int) -> bool:
	if(0 <= value && value <= self.max_stress):
		current_stress = value
		print("DEBUG: " + self.character_name + "'s current stress is " + str(self.current_stress) + ".")
		return true
	elif(value < 0):
		print("Cannot set current stress to be less than 0.")
	else:
		print("Cannot set current stress to be greater than max stress.")
		
	return false

func set_maximum_armor_slots() -> void:
	self.max_armor_slots = 12 # ACTUAL DEFAULT
	# TODO: set maximum health based on character creation options
	# (i.e. consider chosen character features)
	
func set_used_armor_slots(value: int) -> bool:
	if(0 <= value && value <= self.max_hp):
		used_armor_slots = value
		print("DEBUG: " + self.character_name + " has used " + str(current_hp) + " armor slots.")
		return true
	elif(value < 0):
		print("Cannot set used armor slots to be less than 0.")
	else:
		print("Cannot set used armor slots to be greater than max armor slots.")
	
	return false
