# This will be the base ancestry feature class script
# inherited by all ancestry features.
class_name AncestryFeature
extends Resource

@export var feature_name: String
var description: String

func _ready() -> void:
	self.description = self.get_description()

func set_description() -> void:
	self.description = self.get_description()

func get_description() -> String:
	# descriptions were taken from:
	# https://daggerheart.org/reference/ancestries
	var all_descriptions: Dictionary = {
		"Purposeful Design": "Decide who made you and for what purpose. At character creation, choose one of your Experiences that best aligns with this purpose and gain a permanent +1 bonus to it.",
		"Efficient": "When you take a short rest, you can choose a long rest move instead of a short rest move.",
		"Scales": "Your scales act as natural protection. When you would take Severe damage, you can mark a Stress to mark 1 fewer Hit Points.",
		"Elemental Breath": "Choose an element for your breath (such as electricity, fire, or ice). You can use this breath against a target or group of targets within Very Close range, treating it as an Instinct weapon that deals d8 magic damage using your Proficiency.",
		"Thick Skin": "When you take Minor damage, you can mark 2 Stress instead of marking a Hit Point.",
		"Increased Fortitude": "Spend 3 Hope to halve incoming physical damage.",
		"Quick Reactions": "Mark a Stress to gain advantage on a reaction roll.",
		"Celestial Trance": "During a rest, you can drop into a trance to choose an additional downtime move.",
		"Luckbender": "Once per session, after you or a willing ally within Close range makes an action roll, you can spend 3 Hope to reroll the Duality Dice.",
		"Wings": "You can fly. While flying, you can mark a Stress after an adversary makes an attack against you to gain a +2 bonus to your Evasion against that attack.",
		"Caprine Leap": "You can leap anywhere within Close range as though you were using normal movement, allowing you to vault obstacles, jump across gaps, or scale barriers with ease.",
		"Kick": "When you succeed on an attack against a target within Melee range, you can mark a Stress to kick yourself off them, dealing an extra 2d6 damage and knocking back either yourself or the target to Very Close range.",
		"Charge": "When you succeed on an Agility Roll to move from Far or Very Far range into Melee range with one or more targets, you can mark a Stress to deal 1d12 physical damage to all targets within Melee range.",
		"Unshakable": "When you would mark a Stress, roll a d6. On a result of 6, don’t mark it.", 
		"Fungril Network": "Make an Instinct Roll (12) to use your mycelial array to speak with others of your ancestry. On a success, you can communicate across any distance.",
		"Death Connection": "While touching a corpse that died recently, you can mark a Stress to extract one memory from the corpse related to a specific emotion or sensation of your choice.",
		"Shell": "Gain a bonus to your damage thresholds equal to your Proficiency.",
		"Retract": "Mark a Stress to retract into your shell. While in your shell, you have resistance to physical damage, you have disadvantage on action rolls, and you can’t move.",
		"Endurance": "Gain an additional Hit Point slot at character creation.",
		"Reach": "Treat any weapon, ability, spell, or other feature that has a Melee range as though it has a Very Close range instead.",
		"Surefooted": "You ignore disadvantage on Agility Rolls.",
		"Danger Sense": "Once per rest, mark a Stress to force an adversary to reroll an attack against you or an ally within Very Close range.",
		"Luckbringer": "At the start of each session, everyone in your party gains a Hope.",
		"Internal Compass": "When you roll a 1 on your Hope Die, you can reroll it.",
		"High Stamina": "Gain an additional Stress slot at character creation.",
		"Adaptability": "When you fail a roll that utilized one of your Experiences, you can mark a Stress to reroll.",
		"Fearless": "When you roll with Fear, you can mark 2 Stress to change it into a roll with Hope instead.",
		"Dread Visage": "You have advantage on rolls to intimidate hostile creatures.",
		"Feline Instincts": "When you make an Agility Roll, you can spend 2 Hope to reroll your Hope Die.",
		"Retracting Claws": "Make an Agility Roll to scratch a target within Melee range. On a success, they become temporarily Vulnerable.", 
		"Sturdy": "When you have 1 Hit Point remaining, attacks against you have disadvantage.",
		"Tusks": "When you succeed on an attack against a target within Melee range, you can spend a Hope to gore the target with your tusks, dealing an extra 1d6 damage.",
		"Amphibious": "You can breathe and move naturally underwater.",
		"Long Tongue": "You can use your long tongue to grab onto things within Close range. Mark a Stress to use your tongue as a Finesse Close weapon that deals d12 physical damage using your Proficiency.",
		"Natural Climber": "You have advantage on Agility Rolls that involve balancing and climbing.",
		"Nimble": "Gain a permanent +1 bonus to your Evasion at character creation.",
	}
	
	return all_descriptions[self.feature_name]
