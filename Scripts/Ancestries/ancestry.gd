# This will be the base ancestry class script
# inherited by all ancestries.
class_name Ancestry
extends Resource

@export var ancestry_name: String
@export var feature1: AncestryFeature
@export var feature2: AncestryFeature

var description: String

func _ready() -> void:
	self.description = self.set_description()
	
# descriptions were taken from:
# https://daggerheart.org/reference/ancestries
func set_description() -> String:
	var all_descriptions: Dictionary = {
		"Clank": "",
		"Drakona": "",
		"Dwarf": "Dwarves are most easily recognized as short humanoids with square frames, dense musculature, and thick hair. Their average height ranges from 4 to 5 ½ feet, and they are often broad in proportion to their stature.",
		"Elf": "",
		"Faerie": "",
		"Faun": "Fauns resemble humanoid goats with curving horns, square pupils, and cloven hooves. Though their appearances may vary, most fauns have a humanoid torso and a goatlike lower body covered in dense fur.",
		"Firbolg": "Firbolgs are bovine humanoids typically recognized by their broad noses and long, drooping ears. Some have faces that are a blend of humanoid and bison, ox, cow, or other bovine creatures.",
		"Fungril": "Fungril resemble humanoid mushrooms. They can be either more humanoid or more fungal in appearance, and they come in an assortment of colors, from earth tones to bright reds, yellows, purples, and blues.",
		"Galapa": "",
		"Giant": "",
		"Goblin": "",
		"Halfing": "Halflings are small humanoids with large hairy feet and prominent rounded ears. Members of this ancestry live for around 150 years, and a halfling’s appearance is likely to remain youthful even as they progress from adulthood into old age.",
		"Human": "",
		"Infernis": "Infernis are humanoids who possess sharp canine teeth, pointed ears, and horns. They are the descendants of demons from the Circles Below. ",
		"Katari": "",
		"Orc": "Orcs are humanoids most easily recognized by their square features and boar-like tusks that protrude from their lower jaw. Their ears are pointed, and their hair and skin typically have green, blue, pink, or gray tones.",
		"Ribbet": "Ribbets resemble anthropomorphic frogs with protruding eyes and webbed hands and feet. They have smooth (though sometimes warty) moist skin and eyes positioned on either side of their head.",
		"Simmiah": "",
	}
	
	return all_descriptions[self.ancestry_name]
