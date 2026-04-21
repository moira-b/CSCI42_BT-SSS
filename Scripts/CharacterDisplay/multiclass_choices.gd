extends HBoxContainer

@onready var class_choice_list = $MulticlassChoiceList
@onready var class_domain_list = $MulticlassSpecifics/MulticlassDomainList
@onready var class_subclass_list = $MulticlassSpecifics/MulticlassSubclassList
@onready var confirm_button = $"../ConfirmButton"

var selected_class: CharacterClass
var selected_domain: Domain
var character: Character
var selected_subclass: CharacterSubclass
var domain_choice_array: Array[Domain]

var character_classes = [
	"res://Resources/Classes/Bard/bard.tres",
	"res://Resources/Classes/Druid/druid.tres",
	"res://Resources/Classes/Guardian/guardian.tres",
	"res://Resources/Classes/Ranger/ranger.tres",
	"res://Resources/Classes/Rogue/rogue.tres",
	"res://Resources/Classes/Seraph/seraph.tres",
	"res://Resources/Classes/Sorcerer/sorcerer.tres",
	"res://Resources/Classes/Warrior/warrior.tres",
	"res://Resources/Classes/Wizard/wizard.tres"
]

func initialize() -> void:
	_display_multiclass_choices()
	class_choice_list.item_selected.connect(_on_multiclass_choice_option_selected)
	class_domain_list.item_selected.connect(_on_domain_choice_option_selected)
	class_subclass_list.item_selected.connect(_on_subclass_choice_option_selected)
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	confirm_button.disabled = true

func get_character(c: Character) -> void:
	character = c

func _display_multiclass_choices() -> void:
	var i = 0
	for character_class in character_classes:
		var character_class_name = load(character_class).name
		class_choice_list.add_item(character_class_name)
		if character_class_name == character.character_class.name:
			class_choice_list.set_item_disabled(i, true)
		i+=1

func _display_domain_choices() -> void:
	class_domain_list.clear()
	domain_choice_array.clear()
	selected_domain = null
	
	var i = 0
	for domain in selected_class.domains:
		class_domain_list.add_item(domain.name)
		domain_choice_array.append(domain)
		if character.character_class.domains.has(domain):
			class_domain_list.set_item_disabled(i, true)
		
		i += 1
		
func _display_subclass_choices() -> void:
	class_subclass_list.clear()
	selected_subclass = null
	
	for subclass in selected_class.character_subclasses:
		class_subclass_list.add_item(subclass.subclass_name)

func _on_multiclass_choice_option_selected(index: int) -> void:
	confirm_button.disabled = true
	selected_class = load(character_classes[index])
	_display_domain_choices()
	_display_subclass_choices()

func _on_domain_choice_option_selected(index: int) -> void:
	selected_domain = domain_choice_array[index]
	
	if(selected_domain and selected_subclass):
		confirm_button.disabled = false

func _on_subclass_choice_option_selected(index: int) -> void:
	selected_subclass = selected_class.character_subclasses[index]
	
	if(selected_domain and selected_subclass):
		confirm_button.disabled = false
		
func _on_confirm_button_pressed() -> void:
	character.multiclass_selection = selected_class
	character.multiclass_domains = selected_domain
	character.multiclass_subclass = selected_subclass
	
	get_parent().get_parent().show_multiclass()
	get_parent().set_active_container(2)
