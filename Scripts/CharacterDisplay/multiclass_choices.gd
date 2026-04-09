extends HBoxContainer

@onready var class_choice_list = $MulticlassChoiceList
@onready var class_domain_list = $MulticlassDomainList
@onready var confirm_button = $"../ConfirmButton"

@export var character_classes : Array[CharacterClass]

var selected_class: CharacterClass
var selected_domain: Domain
var character: Character

func initialize() -> void:
	_display_multiclass_choices()
	class_choice_list.item_selected.connect(_on_multiclass_choice_option_selected)
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	confirm_button.disabled = true

func get_character(c: Character) -> void:
	character = c

func _display_multiclass_choices() -> void:
	var i = 0
	for character_class in character_classes:
		class_choice_list.add_item(character_class.name)
		if character_class == character.character_class || character.multiclass_selections.has(character_class):
			class_choice_list.set_item_disabled(i, true)

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

func _on_confirm_button_pressed() -> void:
	pass
