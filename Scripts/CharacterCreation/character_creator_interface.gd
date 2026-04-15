extends Control

@onready var option_lists = $OptionLists
@onready var confirm_button = $ButtonContainer/ConfirmButton
@onready var complete_button = $ButtonContainer/CompleteButton
@onready var back_button = $ButtonContainer/BackButton
@onready var description_display = $DescriptionContainer
@onready var card_selector = $OptionLists/DomainCardSelContainer
@onready var character = $Character
@onready var tab_container = $TabButtons
@onready var tab_buttons: Array[Node] = tab_container.get_children()

var option_tab_array: Array[Control]
var option_tab_index: int
var active_option_tab: Control
var sheet_scene: PackedScene = preload("res://Scenes/CharacterDisplay/character_sheet.tscn")
var domain: PackedScene = load("res://Scenes/Cards/domain_card_base.tscn")

func _ready() -> void:
	option_tab_index = 0
	confirm_button.disabled = true
	back_button.disabled = true
	back_button.visible = false
	complete_button.disabled = true
	complete_button.visible = false
	_load_option_tabs()
	_set_active_option_tab(0)
	for button in tab_buttons:
		button.pressed.connect(_on_tab_button_pressed.bind(button))


func _process(_delta: float) -> void:
	_handle_back_button_visibility()
	
	if active_option_tab is ItemList && active_option_tab.is_anything_selected():
		confirm_button.disabled = false
	elif active_option_tab.name == "DomainCardSelContainer":
		if active_option_tab.select_card_list.item_count == 2:
			confirm_button.disabled = false
		else:
			confirm_button.disabled = true
	elif active_option_tab.name == "TraitAssignmentContainer":
		if active_option_tab.get_child(1).is_all_items_complete():
			confirm_button.disabled = false
	elif active_option_tab.name == "ExperiencesContainer" and active_option_tab.is_all_textboxes_filled():
			confirm_button.disabled = false
	elif active_option_tab.name == "NamePronounContainer" and active_option_tab.is_all_textboxes_filled():
			complete_button.disabled = false
			

func _set_active_option_tab(_index: int):
	'''
		Sets active item list by hiding or showing visibility of given item lists
	'''
	if active_option_tab and active_option_tab.name == "DomainCardSelContainer":
		active_option_tab.clear_screen()
		

	if option_tab_array[_index]:
		active_option_tab = option_tab_array[_index]
		active_option_tab.visible = true

	for option_tab in option_tab_array:
		if option_tab != active_option_tab:
			option_tab.visible = false
	
	if active_option_tab.name == "NamePronounContainer":
		confirm_button.visible = false
		complete_button.disabled = true
		complete_button.visible = true
	elif active_option_tab.name == "DomainCardSelContainer":
		description_display.visible = false
		active_option_tab.fill_domain_card_list()
		active_option_tab.clear_selected_cards()
	else:
		confirm_button.visible = true
		complete_button.disabled = true
		complete_button.visible = false


func _load_option_tabs():
	'''
		Initializes item list by loading each child of
		OptionLists into an array
	'''
	for child in option_lists.get_children():
		option_tab_array.append(child)


func _handle_back_button_visibility():
	if option_tab_index > 0:
		back_button.disabled = false
		back_button.visible = true
	else:
		back_button.disabled = true
		back_button.visible = false


func _on_confirm_button_pressed() -> void:
	option_tab_index += 1
	_set_active_option_tab(option_tab_index)
	confirm_button.disabled = true
	description_display.clear_message()


func _on_back_button_pressed() -> void:
	option_tab_index -= 1
	_set_active_option_tab(option_tab_index)


func show_description(message: String) -> void:
	description_display.display_message(message)


func _on_complete_button_pressed() -> void:
	add_domain_cards()
	var new_scene = sheet_scene.instantiate()
	character.set_maximum_health()
	character.set_maximum_stress()
	character.set_maximum_armor_slots()
	character.implement_ancestry_features()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()
	#get_tree().change_scene_to_packed(sheet_scene)


func add_domain_cards():
	for index in range(card_selector.select_card_list.item_count):
		var card = card_selector.select_card_list.get_item_text(index)
		character.active_cards.append(card)


func _on_tab_button_pressed(tab: Button) -> void:
	if tab.name == "Class": _set_active_option_tab(0)
	if tab.name == "Subclass": _set_active_option_tab(1)
	if tab.name == "Heritage": _set_active_option_tab(2)
	if tab.name == "Community": _set_active_option_tab(3)
	if tab.name == "DomainCards": _set_active_option_tab(4)
	if tab.name == "Traits": _set_active_option_tab(5)
	if tab.name == "Experiences": _set_active_option_tab(6)
	if tab.name == "Name": _set_active_option_tab(7)
