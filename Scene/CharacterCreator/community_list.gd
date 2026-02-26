extends ItemList

@export var community_array: Array[Community]

var option_selection_array: Array[Community]

func _ready() -> void:
	for option in community_array:
		add_item(option.community_name)
		option_selection_array.append(option)
	
	self.item_selected.connect(_on_item_selected)

func _on_item_selected(_index: int):
	var option_selected: String = self.get_item_text(_index)
	self.get_parent().get_parent().show_description("Community", option_selected)
