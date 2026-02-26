extends ItemList

@export var heritage_array: Array[Ancestry]

var option_selection_array: Array[Ancestry]

func _ready() -> void:
	for option in heritage_array:
		add_item(option.ancestry_name)
		option_selection_array.append(option)
	
	self.item_selected.connect(_on_item_selected)

func _on_item_selected(_index: int):
	pass
