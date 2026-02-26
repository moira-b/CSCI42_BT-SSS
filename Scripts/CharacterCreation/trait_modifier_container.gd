extends VBoxContainer

var option_button_array: Array[OptionButton]
var selected_index_array: Array

var agi_index = -1
var str_index = -1
var fin_index = -1
var ins_index = -1
var prec_index = -1
var know_index = -1

func _ready() -> void:
	for child in self.get_children():
		option_button_array.append(child)


func _add_item_to_array(prev_index: int,index: int):
	if(prev_index>=0):
		for option_button in option_button_array:
			option_button.set_item_disabled(prev_index, false)
	for option_button in option_button_array:
			option_button.set_item_disabled(index, true)

func _on_agi_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(agi_index,index)
	agi_index = index


func _on_str_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(str_index,index)
	str_index = index

func _on_fin_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(fin_index, index)
	fin_index = index

func _on_ins_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(ins_index, index)
	ins_index = index


func _on_prec_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(prec_index,index)
	prec_index = index

func _on_know_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(know_index,index)
	know_index = index
