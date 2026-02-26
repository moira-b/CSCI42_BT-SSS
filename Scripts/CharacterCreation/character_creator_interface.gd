extends Control

@onready var option_lists = $OptionLists
@onready var confirm_button = $ButtonContainer/ConfirmButton
@onready var back_button = $ButtonContainer/BackButton

var item_list_array: Array[ItemList]
var item_list_index: int
var active_item_list: ItemList

func _ready() -> void:
	item_list_index = 0
	confirm_button.disabled = true
	back_button.disabled = true
	back_button.visible = false
	_load_item_lists()
	_set_active_item_list(0)


func _process(_delta: float) -> void:
	_handle_back_button_visibility()
	
	if active_item_list.is_anything_selected():
		confirm_button.disabled = false


func _set_active_item_list(_index: int):
	'''
		Sets active item list by hiding or showing visibility of given item lists
	'''
	if item_list_array[_index] is ItemList:
		active_item_list = item_list_array[_index]
		active_item_list.visible = true	

	for item_list:ItemList in item_list_array:
		if item_list != active_item_list:
			item_list.visible = false


func _load_item_lists():
	'''
		Initializes item list by loading each child of
		OptionLists into an array
	'''
	for child:ItemList in option_lists.get_children():
		item_list_array.append(child)


func _handle_back_button_visibility():
	if item_list_index > 0:
		back_button.disabled = false
		back_button.visible = true
	else:
		back_button.disabled = true
		back_button.visible = false


func _on_confirm_button_pressed() -> void:
	item_list_index += 1
	_set_active_item_list(item_list_index)
	confirm_button.disabled = true


func _on_back_button_pressed() -> void:
	item_list_index -= 1
	_set_active_item_list(item_list_index)
