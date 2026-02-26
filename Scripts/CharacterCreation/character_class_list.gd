extends ItemList

@export var classes_array: Array[CharacterClass]
@export var subclasses_list: ItemList

var option_selection_array: Array[CharacterClass]

func _ready() -> void:
	for option in classes_array:
		add_item(option.name)
		option_selection_array.append(option)
	
	self.item_selected.connect(_on_item_selected)

func _on_item_selected(_index: int):
	subclasses_list.clear()
	
	for subclass in option_selection_array[_index].character_subclasses:
		subclasses_list.add_item(subclass.subclass_name)
