extends Control

@onready var option_lists = $OptionLists
@onready var confirm_button = $ButtonContainer/ConfirmButton
@onready var complete_button = $ButtonContainer/CompleteButton
@onready var back_button = $ButtonContainer/BackButton
@onready var description_display = $DescriptionContainer
@onready var character = $Character

var option_tab_array: Array[Control]
var option_tab_index: int
var active_option_tab: Control
var sheet_scene: PackedScene = preload("res://Scenes/CharacterDisplay/character_sheet.tscn")

func _ready() -> void:
	option_tab_index = 0
	confirm_button.disabled = true
	back_button.disabled = true
	back_button.visible = false
	complete_button.disabled = true
	complete_button.visible = false
	_load_option_tabs()
	_set_active_option_tab(0)


func _process(_delta: float) -> void:
	_handle_back_button_visibility()
	
	if active_option_tab is ItemList && active_option_tab.is_anything_selected():
		confirm_button.disabled = false
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
	var new_scene = sheet_scene.instantiate()
	character.reparent(new_scene)
	self.get_parent().add_child(new_scene)
	new_scene.enter()
	self.queue_free()
	#get_tree().change_scene_to_packed(sheet_scene)
