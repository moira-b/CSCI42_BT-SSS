extends VBoxContainer

var option_button_array: Array[OptionButton]
var selected_index_array: Array

func _ready() -> void:
	for child in self.get_children():
		option_button_array.append(child)


func _process(_delta: float) -> void:
	for index in selected_index_array:
		for option_button in option_button_array:
			option_button.set_item_disabled(index, true)


func _add_item_to_array(index: int):
	selected_index_array.append(index)


func _on_agi_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(index)


func _on_str_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(index)


func _on_fin_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(index)


func _on_ins_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(index)


func _on_prec_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(index)


func _on_know_modifier_options_item_selected(index: int) -> void:
	_add_item_to_array(index)
