extends HBoxContainer

@onready var class_choice_list = $MulticlassChoiceList
@onready var class_domain_list = $MulticlassDomainList

@export var character_classes : Array[CharacterClass]

var selected_class: CharacterClass
var character: Character

func initialize() -> void:
	_display_multiclass_choices()
	class_choice_list.item_selected.connect(_on_multiclass_choice_option_selected)

func _display_multiclass_choices() -> void:
	for character_class in character_classes:
		class_choice_list.add_item(character_class.name)

func _display_domain_choices() -> void:
	class_domain_list.clear()
	
	var i = 0
	for domain in selected_class.domains:
		class_domain_list.add_item(domain.name)
		if character.character_class.domains.has(domain) || character.multiclass_domains.has(domain):
			class_domain_list.set_item_disabled(i, true)
		
		i += 1

func _on_multiclass_choice_option_selected(index: int) -> void:
	selected_class = character_classes[index]
	_display_domain_choices()

func get_character(c: Character) -> void:
	character = c
