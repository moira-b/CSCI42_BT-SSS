# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

const FILE_PATH = "user://character_data"

const max_level: int = 10
const max_hope: int = 6

@export var bio: String
@export var character_name: String
@export var pronouns: String
@export var level: int
@export var evasion: int
@export var agility: int
@export var strength: int
@export var finesse: int
@export var instinct: int
@export var presence: int
@export var knowledge: int
@export var proficiency: int
@export var proficiency_modifier: int
@export var max_hp: int
@export var current_hp: int
@export var max_stress: int
@export var current_stress: int
@export var current_hope: int
@export var items: Array[String]
@export var max_armor_slots: int
@export var used_armor_slots: int
@export var experiences: Array[String] = ["", "", "", "", ""]
@export var damage_thresholds: Array[int]

var ancestry: Ancestry
var community: Community
var character_class: CharacterClass
var subclass: CharacterSubclass
var primary_key: String

@onready var active_domain_cards = $ActiveDomainCards
@onready var vaulted_domain_cards = $VaultedDomainCards
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
		#print("DEBUG: " + self.character_name + "'s current health is " + str(current_hp) + ".")
		return true
	elif(value < 0):
		print("Cannot set current health to be less than 0.")
	else:
		print("Cannot set current health to be greater than max health.")
	
	return false

func set_maximum_stress() -> void:
	self.max_stress = 6 # PLACEHOLDER
	# TODO: set maximum health based on character creation options
	# (i.e. consider chosen character features)
	
func mark_stress(stress_taken: int):
	var new_stress= current_stress+stress_taken
	if( not set_current_stress(new_stress)):
		set_current_health(current_hp-(new_stress-current_stress))
		
func set_current_stress(value: int) -> bool:
	if(0 <= value && value <= self.max_stress):
		current_stress = value
		#print("DEBUG: " + self.character_name + "'s current stress is " + str(self.current_stress) + ".")
		return true
	elif(value < 0):
		print("Cannot set current stress to be less than 0.")
		load_data(1)
	else:
		print("Cannot set current stress to be greater than max stress.")
		
	return false

func set_maximum_armor_slots() -> void:
	self.max_armor_slots = 12 # ACTUAL DEFAULT
	# TODO: set maximum health based on character creation options
	# (i.e. consider chosen character features)
	
func set_used_armor_slots(value: int) -> bool:
	if(0 <= value && value <= self.max_armor_slots):
		used_armor_slots = value
		#print("DEBUG: " + self.character_name + " has used " + str(used_armor_slots) + " armor slots.")
		return true
	elif(value < 0):
		print("Cannot set used armor slots to be less than 0.")
	else:
		print("Cannot set used armor slots to be greater than max armor slots.")
	
	return false
	
func set_current_hope(value: int) -> bool:
	if(0 <= value && value <= self.max_hope):
		current_hope = value
		#print("DEBUG: " + self.character_name + " currently has " + str(current_hope) + " hope.")
		return true
	elif(value < 0):
		print("Cannot set hope counter s to be less than 0.")
	else:
		print("Cannot set hope counter to be greater than max hope.")
	
	return false

func set_level(value: int) -> bool:
	if(1 <= value && value <= self.max_level):
		level = value
		#print("DEBUG: " + self.character_name + " currently has " + str(level) + " level.")
		set_proficiency_modifier()
		return true
	elif(value < 1):
		print("Cannot set level counter s to be less than 1.")
	else:
		print("Cannot set level counter to be greater than max level.")
	
	return false

func set_proficiency_modifier() -> void:
	proficiency_modifier = 0
	if level > 1: proficiency_modifier = 1
	if level > 4: proficiency_modifier = 2
	if level > 7: proficiency_modifier = 3
	
func set_proficiency() -> void:
	self.proficiency = proficiency_modifier + proficiency
	pass
	
func serialize_data():
	var save_dict = {
		"primary_key": primary_key,
		"character_name": character_name,
		"pronouns": pronouns,
		"bio": bio,
		"level": level,
		"class": character_class.name,
		"subclass": subclass.subclass_name,
		"evasion": evasion,
		"agility": agility,
		"strength": strength,
		"finesse": finesse,
		"instinct": instinct,
		"presence": presence,
		"knowledge": knowledge,
		"proficiency": proficiency,
		"proficiency_modifier": proficiency_modifier,
		"max_hp": max_hp,
		"current_hp": current_hp,
		"max_stress": max_stress,
		"current_stress": current_stress,
		"current_hope": current_hope,
		"items": items,
		"max_armor_slots": max_armor_slots,
		"used_armor_slots": used_armor_slots,
		"experiences": experiences,
		"damage_thresholds": damage_thresholds,
	}
	return save_dict

func assign_primary_key(pk: int):
	self.primary_key = str(pk)

func load_data(pk: int):
	var save_file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
	var current_contents = save_file.get_as_text()
	var json = JSON.new()
	
	# Check that the file contents can be parsed by JSON
	var parse_result = json.parse(current_contents)
	if !(parse_result==OK):
		print("JSON Parse Error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return
		
	# Check that the file contents can be made into a dictionary
	var json_data = json.data
	var char_dict = json_data[primary_key]
	for key in char_dict:
		print(key, ": ", char_dict[key])
