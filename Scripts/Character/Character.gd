# This is the character script
# which holds all the character information and methods
class_name Character
extends Node

const FILE_PATH = "user://character_data"
const WEAPON_PATH = "res://Resources/Equipment/weapons.json"
const ARMOR_PATH = "res://Resources/Equipment/armor.json"

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
@export var items: Array[String]		#index 0: armor, 1: primary, 2: secondary
@export var max_armor_slots: int
@export var used_armor_slots: int
@export var experiences: Array[String] = ["", "", "", "", ""]
@export var damage_thresholds: Array[int] = [1,1]
@export var experience_levels: Array[int] = [2, 2, 2, 2, 2]
@export var max_domain_cards: int
@export var num_downtime_moves: int = 2

var ancestry: Ancestry
var community: Community
var character_class: CharacterClass
var subclass: CharacterSubclass
var multiclass_domains: Array[Domain]
var multiclass_subclasses: Array[CharacterSubclass]
var multiclass_selections: Array[CharacterClass]
var primary_key: String


@onready var active_cards: Array[String] = []
@onready var vaulted_cards: Array[String] = []

@onready var active_domain_cards = $ActiveDomainCards
@onready var vaulted_domain_cards = $VaultedDomainCards
var active_domain_card_counters = [0, 0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_maximum_health() -> void:
	self.max_hp = character_class.starting_hp

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
		set_current_health(current_hp+(new_stress-current_stress))
		
func set_current_stress(value: int) -> bool:
	if(0 <= value && value <= self.max_stress):
		current_stress = value
		#print("DEBUG: " + self.character_name + "'s current stress is " + str(self.current_stress) + ".")
		return true
	elif(value < 0):
		print("Cannot set current stress to be less than 0.")
	else:
		print("Cannot set current stress to be greater than max stress.")
		
	return false

func set_maximum_armor_slots() -> void:
	self.max_armor_slots = 0 # ACTUAL DEFAULT
	# TODO: set maximum health based on character creation options
	# (i.e. consider chosen character features)
	
func set_used_armor_slots(value: int) -> bool:
	if(0 <= value && value <= self.max_armor_slots):
		if(value > 12): #max armor slots
			value = 12
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
		if level == 2 or level== 5 or level==8: 
			set_proficiency()
		return true
	elif(value < 1):
		print("Cannot set level counter s to be less than 1.")
	else:
		print("Cannot set level counter to be greater than max level.")
	
	return false

func set_base_evasion() -> void:
	evasion = character_class.starting_evasion + agility

func set_proficiency() -> void:
	self.proficiency = proficiency + 1
	pass
	
func serialize_data():
	var save_dict = {
		"primary_key": primary_key,
		"character_name": character_name,
		"pronouns": pronouns,
		"bio": bio,
		"level": level,
		"class": character_class.resource_path,
		"subclass": subclass.resource_path,
		"ancestry": ancestry.resource_path,
		"community": community.resource_path,
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
		"experience_levels": experience_levels,
		"max_domain_cards": max_domain_cards,
		"active_cards" : active_cards,
		"vaulted_cards": vaulted_cards,
		"multiclass_domains": multiclass_domains,
		"multiclass_subclasses": multiclass_subclasses,
		"multiclass_selections": multiclass_selections,
		"num_downtime_moves": num_downtime_moves,
		"active_domain_card_counters": active_domain_card_counters
	}
	return save_dict

func assign_primary_key(pk: int):
	self.primary_key = str(pk)

func load_data(char_dict: Variant):
	agility = char_dict["agility"]
	ancestry = load(char_dict["ancestry"])
	bio = char_dict["bio"]
	character_name = char_dict["character_name"]
	character_class = load(char_dict["class"])
	community = load(char_dict["community"])
	current_hope = char_dict["current_hope"]
	current_hp = char_dict["current_hp"]
	current_stress = char_dict["current_stress"]
	damage_thresholds.assign(char_dict["damage_thresholds"])
	evasion = char_dict["evasion"]
	experiences.assign(char_dict["experiences"])
	experience_levels.assign(char_dict["experience_levels"])
	finesse = char_dict["finesse"]
	instinct = char_dict["instinct"]
	items.assign(char_dict["items"])
	knowledge = char_dict["knowledge"]
	level = char_dict["level"]
	max_armor_slots = char_dict["max_armor_slots"]
	max_hp = char_dict["max_hp"]
	max_stress = char_dict["max_stress"]
	presence = char_dict["presence"]
	primary_key = char_dict["primary_key"]
	proficiency = char_dict["proficiency"]
	proficiency_modifier = char_dict["proficiency_modifier"]
	pronouns = char_dict["pronouns"]
	strength = char_dict["strength"]
	subclass = load(char_dict["subclass"])
	used_armor_slots = char_dict["used_armor_slots"]
	max_domain_cards = char_dict["max_domain_cards"]
	active_cards.assign(char_dict["active_cards"])
	vaulted_cards.assign(char_dict["vaulted_cards"])
	multiclass_domains.assign(char_dict["multiclass_domains"])
	multiclass_subclasses.assign(char_dict["multiclass_subclasses"])
	multiclass_selections.assign(char_dict["multiclass_selections"])
	num_downtime_moves = char_dict["num_downtime_moves"]
	active_domain_card_counters.assign(char_dict["active_domain_card_counters"])
	
func implement_ancestry_features(pd_which_exp: int=-1):
	if self.ancestry.ancestry_name=="Clank":
		update_experience_level(pd_which_exp, 1)
		print(character_name + " has a permanent +1 bonus to an experience due to Clank ancestry.")
		print(experience_levels)
	elif self.ancestry.ancestry_name=="Elf":
		num_downtime_moves = 3
		print(character_name + " permanently has an extra downtime move due to Elf ancestry.")
	elif self.ancestry.ancestry_name=="Giant":
		max_hp += 1
		print(character_name + "'s max health is automatically increased by 1 due to Giant ancestry.")
	elif self.ancestry.ancestry_name=="Human":
		max_stress += 1
		print(character_name + "'s max stress is automatically increased by 1 due to Human ancestry.")
	elif self.ancestry.ancestry_name=="Simiah":
		evasion += 1
		print(character_name + "'s evasion is automatically increased by 1 due to Simiah ancestry.")

func update_equipment(new_equipment: Array[String]):
	if items[0]!=new_equipment[0]:
		print("replacing armor")
		unequip_armor(items[0])
		equip_armor(new_equipment[0])
	if items[1]!=new_equipment[1]:
		print("replacing primary")
		unequip_primary(items[1])
		equip_primary(new_equipment[1])
	if items[2]!=new_equipment[2]:
		print("replacing secondary")
		unequip_secondary(items[2])
		equip_secondary(new_equipment[2])

func equip_armor(armor: String):
	print("equipped armor: " + armor)
	var armor_as_text = FileAccess.get_file_as_string(ARMOR_PATH)
	var armor_as_dict = JSON.parse_string(armor_as_text)
	
	
	
	if(not armor_as_dict.get(armor)):
		return
		
	max_armor_slots += armor_as_dict.get(armor).get("base_score")
	
	items[0] = armor
	
	damage_thresholds[0] += armor_as_dict.get(armor).get("major_threshold")
	damage_thresholds[1] += armor_as_dict.get(armor).get("severe_threshold")
		
	var feature = armor_as_dict.get(armor).get("feature")
	
	if(feature == "Flexible"):
		evasion += 1
	elif(feature == "Heavy"):
		evasion -= 1
	elif(feature == "Very Heavy"):
		evasion -= 3
		agility -= 1
	elif (feature == "Gilded"):
		presence += 1
	elif (feature == "Difficult"):
		evasion -= 2
		agility -= 1
		strength -= 1
		finesse -= 1
		instinct -= 1
		presence -= 1
		knowledge -= 1
		
	
func unequip_armor(armor: String):
	print("unequipped armor: " + armor)
	var armor_as_text = FileAccess.get_file_as_string(ARMOR_PATH)
	var armor_as_dict = JSON.parse_string(armor_as_text)
	
	if(not armor_as_dict.get(armor)):
		return
		
	items[0] = ""
	
	max_armor_slots -= armor_as_dict.get(armor).get("base_score")
	damage_thresholds[0] -= armor_as_dict.get(armor).get("major_threshold")
	damage_thresholds[1] -= armor_as_dict.get(armor).get("severe_threshold")
	
	var feature = armor_as_dict.get(armor).get("feature")
	
	if(feature == "Flexible"):
		evasion -= 1
	elif(feature == "Heavy"):
		evasion += 1
	elif(feature == "Very Heavy"):
		evasion += 3
		agility += 1
	elif (feature == "Gilded"):
		presence -= 1
	elif (feature == "Difficult"):
		evasion += 2
		agility += 1
		strength += 1
		finesse += 1
		instinct += 1
		presence += 1
		knowledge += 1
	
	
func equip_primary(weapon: String):
	print("equipped primary: " + weapon)
	
	var weapon_as_text = FileAccess.get_file_as_string("res://Resources/Equipment/weapons.json")
	var weapon_as_dict = JSON.parse_string(weapon_as_text)
	
	if(not weapon_as_dict.get(weapon)):
		return
	
	items[1] = weapon
	
	var feature = weapon_as_dict.get(weapon).get("feature")
	
	if(feature == "Massive" || feature == "Heavy"):
		evasion -= 1
	elif(feature=="Cumbersome"):
		finesse -= 1
	elif(feature=="Protective"):
		max_armor_slots += 1
	elif(feature =="Barrier"):
		max_armor_slots += weapon_as_dict.get(weapon).get("tier") + 1
		evasion -= 1
	elif(feature =="Double Duty"):
		max_armor_slots += 1
	elif(feature == "Brave"):
		evasion -= 1
		damage_thresholds[1] += 3
	elif(feature == "Destructive"):
		evasion -= 1
		agility -= 1
	
	
func unequip_primary(weapon: String):
	print("unequipped primary: " + weapon)
	
	
	var weapon_as_text = FileAccess.get_file_as_string("res://Resources/Equipment/weapons.json")
	var weapon_as_dict = JSON.parse_string(weapon_as_text)
	
	if(not weapon_as_dict.get(weapon)):
		return
	
	items[1] = ""
	
	var feature = weapon_as_dict.get(weapon).get("feature")
	
	if(feature == "Massive" || feature == "Heavy"):
		evasion += 1
	elif(feature=="Cumbersome"):
		finesse += 1
	elif(feature=="Protective"):
		max_armor_slots -= 1
	elif(feature =="Barrier"):
		max_armor_slots -= weapon_as_dict.get(weapon).get("tier") + 1
		evasion += 1
	elif(feature =="Double Duty"):
		max_armor_slots -= 1
	elif(feature == "Brave"):
		evasion += 1
		damage_thresholds[1] -= 3
	elif(feature == "Destructive"):
		evasion += 1
		agility += 1
	
func equip_secondary(weapon: String):
	print("equipped secondary: " + weapon)
	var weapon_as_text = FileAccess.get_file_as_string("res://Resources/Equipment/weapons.json")
	var weapon_as_dict = JSON.parse_string(weapon_as_text)
	
	if(not weapon_as_dict.get(weapon)):
		return
	
	items[2] = weapon
	
	var feature = weapon_as_dict.get(weapon).get("feature")
	
	if(feature == "Massive" || feature == "Heavy"):
		evasion -= 1
	elif(feature=="Cumbersome"):
		finesse -= 1
	elif(feature=="Protective"):
		max_armor_slots += weapon_as_dict.get(weapon).get("tier")
	elif(feature =="Barrier"):
		max_armor_slots += weapon_as_dict.get(weapon).get("tier") + 1
		evasion -= 1
	elif(feature =="Double Duty"):
		max_armor_slots += 1
	elif(feature == "Brave"):
		evasion -= 1
		damage_thresholds[1] += 3
	elif(feature == "Destructive"):
		evasion -= 1
		agility -= 1
	
	
func unequip_secondary(weapon: String):
	print("unequipped secondary: " + weapon)
	var weapon_as_text = FileAccess.get_file_as_string("res://Resources/Equipment/weapons.json")
	var weapon_as_dict = JSON.parse_string(weapon_as_text)
	
	if(not weapon_as_dict.get(weapon)):
		return
	
	items[2] = ""
	
	var feature = weapon_as_dict.get(weapon).get("feature")
	
	if(feature == "Massive" || feature == "Heavy"):
		evasion += 1
	elif(feature=="Cumbersome"):
		finesse += 1
	elif(feature=="Protective"):
		max_armor_slots -= weapon_as_dict.get(weapon).get("tier")
	elif(feature =="Barrier"):
		max_armor_slots -= (weapon_as_dict.get(weapon).get("tier") + 1)
		evasion += 1
	elif(feature =="Double Duty"):
		max_armor_slots -= 1
	elif(feature == "Brave"):
		evasion += 1
		damage_thresholds[1] -= 3
	elif(feature == "Destructive"):
		evasion += 1
		agility += 1
	

func get_armor_name():
	return items[0]

func get_primary_name():
	return items[1]

func get_secondary_name():
	return items[2]
	
func get_armor_info() -> String:
	var armor = get_armor_name()
	var armor_as_text = FileAccess.get_file_as_string(ARMOR_PATH)
	var armor_as_dict = JSON.parse_string(armor_as_text)
	
	if(not armor_as_dict.get(armor)):
		return "ERROR IN GETTING ARMOR INFO"
	
	var tier: int = armor_as_dict.get(armor).get("tier")
	var base_score: int = armor_as_dict.get(armor).get("base_score")
	var feature = armor_as_dict.get(armor).get("feature")

	var info = "Tier %d | Base Score %d" % [tier, base_score]
	if feature != "":
		info += " | " + feature
	return info

func get_primary_info() -> String:
	var primary = get_primary_name()
	var weapon_as_text = FileAccess.get_file_as_string(WEAPON_PATH)
	var weapon_as_dict = JSON.parse_string(weapon_as_text)
	
	if(not weapon_as_dict.get(primary)):
		return "ERROR IN GETTING PRIMARY INFO"
	
	var damageType = weapon_as_dict.get(primary).get("damage_type")
	var range = weapon_as_dict.get(primary).get("range")
	var rollTrait = weapon_as_dict.get(primary).get("trait")
	var damageDie: int = weapon_as_dict.get(primary).get("damage_die")
	var damageModifier: int = weapon_as_dict.get(primary).get("damage_modifier")
	var feature = weapon_as_dict.get(primary).get("feature")

	var info = "%s | %s | %s | d%d" % [damageType, range, rollTrait, damageDie]
	if damageModifier != 0:
		info += "+" + str(damageModifier)
	if feature != "":
		info += " | " + feature
	return info

func get_secondary_info() -> String:
	var secondary = get_secondary_name()
	var weapon_as_text = FileAccess.get_file_as_string(WEAPON_PATH)
	var weapon_as_dict = JSON.parse_string(weapon_as_text)
	
	if(not weapon_as_dict.get(secondary)):
		return "ERROR IN GETTING SECONDARY INFO"
	
	var damageType = weapon_as_dict.get(secondary).get("damage_type")
	var range = weapon_as_dict.get(secondary).get("range")
	var rollTrait = weapon_as_dict.get(secondary).get("trait")
	var damageDie: int = weapon_as_dict.get(secondary).get("damage_die")
	var damageModifier: int = weapon_as_dict.get(secondary).get("damage_modifier")
	var feature = weapon_as_dict.get(secondary).get("feature")

	var info = "%s | %s | %s | d%d" % [damageType, range, rollTrait, damageDie]
	if damageModifier != 0:
		info += "+" + str(damageModifier)
	if feature != "":
		info += " | " + feature
	return info

func update_experience_level(which_exp: int, change_amt: int):
	var exp_index = which_exp -1
	if (exp_index < 0) || (exp_index > len(experience_levels)-1):
		print("ERROR in set_experience_level. Trying to access unexpected exp index.")
		return
	
	experience_levels[exp_index] += change_amt

func set_character_name(new_name: String) -> String:
	if new_name=="":
		return "Failed to change the name of " + character_name + ". New name cannot be blank."
	
	if len(new_name) > 64:
		return "Failed to change the name of " + character_name + ". New name cannot be more than 64 characters."
	
	var old_name = character_name
	character_name = new_name
	return old_name + "'s name has been changed to " + new_name + "."
