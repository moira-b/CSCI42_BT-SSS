# This will be the base ancestry class script
# inherited by all ancestries.
class_name Ancestry
extends Resource

@export var ancestry_name: String
@export var feature1: AncestryFeature
@export var feature2: AncestryFeature

var description: String

func _ready() -> void:
	self.description = self.get_description()

func set_description() -> void:
	self.description = self.get_description()

# descriptions were taken from:
# https://app.demiplane.com/nexus/daggerheart/ancestries
func get_description() -> String:
	var all_descriptions: Dictionary = {
		"Clank": "Clanks are sentient mechanical beings built from a variety of materials, including metal, wood, and stone.",
		"Drakona": "Drakona resemble wingless dragons in humanoid form and possess a powerful elemental breath.",
		"Dwarf": "Dwarves are most easily recognized as short humanoids with square frames, dense musculature, and thick hair.",
		"Elf": "Elves are typically tall humanoids with pointed ears and acutely attuned senses.",
		"Faerie": "Faeries are winged humanoid creatures with insectile features.",
		"Faun": "Fauns resemble humanoid goats with curving horns, square pupils, and cloven hooves.",
		"Firbolg": "Firbolgs are bovine humanoids typically recognized by their broad noses and long, drooping ears.",
		"Fungril": "Fungril resemble humanoid mushrooms.",
		"Galapa": "Galapa resemble anthropomorphic turtles with large, domed shells into which they can retract.",
		"Giant": "Giants are towering humanoids with broad shoulders, long arms, and one to three eyes.",
		"Goblin": "Goblins are small humanoids easily recognizable by their large eyes and massive membranous ears.",
		"Halfling": "Halflings are small humanoids with large hairy feet and prominent rounded ears.",
		"Human": "Humans are most easily recognized by their dexterous hands, rounded ears, and bodies built for endurance.",
		"Infernis": "Infernis are humanoids who possess sharp canine teeth, pointed ears, and horns. They are the descendants of demons from the Circles Below. ",
		"Katari": "Katari are feline humanoids with retractable claws, vertically slit pupils, and high, triangular ears.",
		"Orc": "Orcs are humanoids most easily recognized by their square features and boar-like tusks that protrude from their lower jaw.",
		"Ribbet": "Ribbets resemble anthropomorphic frogs with protruding eyes and webbed hands and feet.",
		"Simiah": "Simiah resemble anthropomorphic monkeys and apes with long limbs and prehensile feet.",
	}
	
	return all_descriptions[self.ancestry_name]
