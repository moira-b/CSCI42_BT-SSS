extends ItemList

@export var classes_array: Array[CharacterClass]
@export var subclasses_list: ItemList
var option_selection_array: Array[CharacterClass]

var character: Character

func _ready() -> void:
	for option in classes_array:
		add_item(option.name)
		option_selection_array.append(option)
	self.item_selected.connect(_on_item_selected)
	
	character = self.get_parent().get_parent().get_child(0)

func _on_item_selected(_index: int):
	var option_selected: String = self.get_item_text(_index)
	self.get_parent().get_parent().show_description("Character Class temp description")
	
	subclasses_list.clear()
	for subclass in classes_array[_index].character_subclasses:
		subclasses_list.add_item(subclass.subclass_name)	
	character.character_class = classes_array[_index]
