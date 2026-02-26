extends Control

@onready var option_lists = $OptionLists
@onready var confirm_button = $ButtonContainer/ConfirmButton
@onready var back_button = $ButtonContainer/BackButton

var option_tab_array: Array[Control]
var option_tab_index: int
var active_option_tab: Control

func _ready() -> void:
	option_tab_index = 0
	confirm_button.disabled = true
	back_button.disabled = true
	back_button.visible = false
	_load_option_tabs()
	_set_active_option_tab(0)


func _process(_delta: float) -> void:
	_handle_back_button_visibility()
	
	if active_option_tab is ItemList && active_option_tab.is_anything_selected():
		confirm_button.disabled = false


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


func _on_back_button_pressed() -> void:
	option_tab_index -= 1
	_set_active_option_tab(option_tab_index)
