# This will be the base character class script
# inherited by all character classes.
class_name CharacterClass
extends Resource

@export var name: String
@export var domains: Array[Domain]
@export var starting_evasion: int
@export var starting_hp: int
@export var hope_feature: CharacterClassFeature
@export var class_feature: Array[CharacterClassFeature]
@export var class_items: Array[String]
@export var character_subclasses: Array[CharacterSubclass]

var description: String

func set_description() -> void:
	self.description = self.get_description()

# descriptions are taken from
# https://app.demiplane.com/nexus/daggerheart/classes
func get_description() -> String:
	var all_descriptions: Dictionary = {
		"Assasin": "Assassins are masters in the art of slipping past their opponents’ defenses to inflict terrible pain and deadly strikes.",
		"Bard": "As a bard, you know how to get people to talk, bring attention to yourself, and use words or music to influence the world around you.",
		"Blood Hunter": "As a blood hunter, you harness the power of hemocraft—that is, blood magic—in your relentless pursuit of evil creatures.",
		"Brawler": "As a brawler, you can use your fists just as well as any weapon to fight off the threats that get in your way.",
		"Druid": "As a druid, you are a force of nature, preserving the balance of life and death by channeling the wilds themselves through you.",
		"Guardian": "As a guardian, you run into danger to protect your party, keeping watch over those who might not survive without you there.",
		"Ranger": "As a ranger, your keen eyes and graceful haste make you indispensable when tracking down enemies and navigating the wilds.",
		"Rogue": "As a rogue, you have experience fighting with your blade as well as your wit, preferring to move quickly and fight quietly.",
		"Seraph": "As a seraph, you’ve taken a vow to a god who helps you channel sacred arcane power to keep your party on their feet.",
		"Sorcerer": "As a sorcerer, you were born with innate magical power, and you’ve learned how to wield that power to get what you want.",
		"Warlock": "As a warlock, you've pledged your life to a patron in exchange for great power.",
		"Warrior": "As a warrior, you run into battle without hesitation or caution, knowing you can strike down whatever enemy stands in your path.",
		"Witch": "As a witch, you communte with the forces of nature and entities from realms beyond.",
		"Wizard": "As a wizard, you’ve become familiar with the arcane through the relentless study of grimoires and other tools of magic.

",
	}
	
	return all_descriptions[self.name]
