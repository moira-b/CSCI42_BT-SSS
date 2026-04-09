extends HBoxContainer

@onready var class_choice_list = $MulticlassChoiceList
@onready var class_domain_list = $MulticlassDomainList

@export var character_classes : Array[CharacterClass]

var selected_class: CharacterClass
var character: Character

func _display_multiclass_choices() -> void:
	for character_class in character_classes:
		class_choice_list.add_item(character_class.name)

func _display_domain_choices() -> void:
	var i = 0
	for domain in selected_class:
		class_domain_list.add_item(domain)
		if character.character_class.domains.has(domain) || character.multiclass_domains.has(domain):
			class_domain_list.set_item_disabled(i, true)
		
		i += 1
